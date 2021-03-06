
  ;--------------------------INTERNAL ERROR HANDLER---------------------;
(defun
   STL_ERR (MSG)
  (if (or (/= MSG "Function cancelled")
  ; If an error (such as ESC) occurs
          (= MSG "quit / exit abort")
      ) ;_ end of or
    (princ)
    (princ (strcat "\nError: " MSG))
  ) ; while this command is active...
  (setvar "OSMODE" OS) ; Restore saved modes
  (setvar "PLINEWID" PLW)
  (setq *ERROR* OLDERR) ; Restore old *error* handler
  (princ)
) ;end STL_ERR
  ;------------------------------MAIN PROGRAM----------------------------;
(defun DTR (A) (* pi (/ A 180.0)))
  ;----------------------------------------------------------------------;     
(defun RTD (A) (/ (* A 180.0) pi))
  ;----------------------------------------------------------------------;
  ;Read data file and parse "size string", nth 0, for display in
  ;list box as variable display_list. 
(defun
   STL_READ_DIM_FILE (/ A AA)
  (STL_SET_NIL)
  (setq A "")
  (STL_DEFAULTS)
  (STL_OPEN_DIM_FILE)
  (while (/= A NIL)
    (setq A (read-line STL_DIM_FILE))
    (if (/= A NIL)
      (progn
        (setq
          A  (nth 0 (read A))
          AA (append AA (list A))
        ) ;_ end of setq
      ) ;end progn
    ) ;end if
  ) ;end while
  (setq DISPLAY_LIST (reverse AA))
  (close STL_DIM_FILE)
  (start_list "get_size")
  (mapcar 'add_list DISPLAY_LIST)
  (end_list)
) ;end STL_READ_DIM_FILE
  ;-----------------------------------------------------------------------;
(defun
   STL_SET_NIL ()
  (setq
    STL_DEF_NEWTILE NIL
    STL_DEF_SIZE NIL
    STL_DEF_WHICH_VIEW NIL
    STL_DEF_DISPLAY_LIST NIL
    STL_DEF_INDEX NIL
    STL_DEF_D NIL
    STL_DEF_TW NIL
    STL_DEF_BF NIL
    STL_DEF_TF NIL
    STL_DEF_K NIL
    STL_DEF_TEMP_DIST1 NIL
    STL_DEF_TEMP_DIST2 NIL
    STL_DEF_L_VERT NIL
    STL_DEF_L_HORIZ NIL
    STL_DEF_L_THICK NIL
    STL_DEF_TUBE_VERT NIL
    STL_DEF_TUBE_HORIZ NIL
    STL_DEF_TUBE_THICK NIL
    STL_DEF_DEPTHDIM NIL
    STL_DEF_WEBDIM NIL
    STL_DEF_WIDTHDIM NIL
    STL_DEF_FLANGEDIM NIL
    STL_DEF_KDIM NIL
    STL_DEF_OD_PIPEDIM NIL
    STL_DEF_ID_PIPEDIM NIL
    STL_DEF_DEPTH_TUBEDIM NIL
    STL_DEF_WIDTH_TUBEDIM NIL
    STL_DEF_THK_TUBEDIM NIL
    STL_DEF_2DEND NIL
    STL_DEF_2DTOP NIL
    STL_DEF_2DSIDE NIL
    STL_DEF_3DSOLID NIL
    STL_DEF_3DSURFACE NIL
    STL_DEF_LGTH NIL
    STL_DEF_SCALE NIL
    STL_DEF_METSCALE NIL
    SIZE NIL
    WHICH_VIEW NIL
    DISPLAY_LIST NIL
    INDEX NIL
    D NIL
    TW NIL
    BF NIL
    TF NIL
    K NIL
    TEMP_DIST1 NIL
    TEMP_DIST2 NIL
    L_VERT NIL
    L_HORIZ NIL
    L_THICK NIL
    TUBE_VERT NIL
    TUBE_HORIZ NIL
    TUBE_THICK NIL
    SCALE NIL
  ) ;_ end of setq
  (set_tile "depth" "")
  (set_tile "web" "")
  (set_tile "width" "")
  (set_tile "flange" "")
  (set_tile "k_dim" "")
  (set_tile "od_pipe" "")
  (set_tile "id_pipe" "")
  (set_tile "depth_tube" "")
  (set_tile "width_tube" "")
  (set_tile "thk_tube" "")
  (start_list "get_size")
  (mapcar 'add_list DISPLAY_LIST)
  (end_list)
) ;end STL_SET_NIL
  ;-----------------------------------------------------------------------;
  ;Read selected size, size, from list box and read dimension list from
  ;data file. Set dimension variables.
(defun
   STL_DIM_LIST (/ TEST)
  (STL_OPEN_DIM_FILE)
  (progn
    (while (/= SIZE TEST)
      (setq
        SIZE_DIMS
         (read (read-line STL_DIM_FILE))
        TEST
         (strcase (nth 0 SIZE_DIMS))
      ) ;end setq
    ) ;end while
    (close STL_DIM_FILE)
  ) ;end progn
  (STL_SET_DIM)
) ;end STL_DIM_LIST
  ;-----------------------------------------------------------------------;
  ;Find and open data file, stl_*.dim
(defun
   STL_OPEN_DIM_FILE ()
  (if (= NEWTILE "w_shape")
    (setq STL_DIM_FILE (open (findfile "stl_w.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "m_shape")
    (setq STL_DIM_FILE (open (findfile "stl_m.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "hp_shape")
    (setq STL_DIM_FILE (open (findfile "stl_hp.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "s_shape")
    (setq STL_DIM_FILE (open (findfile "stl_s.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "c_shape")
    (setq STL_DIM_FILE (open (findfile "stl_c.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "c_bar_shape")
    (setq STL_DIM_FILE (open (findfile "stl_c_bar.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "mc_shape")
    (setq STL_DIM_FILE (open (findfile "stl_mc.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "l_shape")
    (setq STL_DIM_FILE (open (findfile "stl_l.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "wt_shape")
    (setq STL_DIM_FILE (open (findfile "stl_wt.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "mt_shape")
    (setq STL_DIM_FILE (open (findfile "stl_mt.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "st_shape")
    (setq STL_DIM_FILE (open (findfile "stl_st.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "std_pipe")
    (setq STL_DIM_FILE (open (findfile "stl_p.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "xs_pipe")
    (setq STL_DIM_FILE (open (findfile "stl_px.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "xxs_pipe")
    (setq STL_DIM_FILE (open (findfile "stl_pxx.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "tube_round")
    (setq STL_DIM_FILE (open (findfile "stl_tube.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "ts_square")
    (setq STL_DIM_FILE (open (findfile "stl_ts_sq.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "ts_rect")
    (setq STL_DIM_FILE (open (findfile "stl_ts_rect.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "met_w_shape")
    (setq STL_DIM_FILE (open (findfile "stl_met_w.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "met_r_shape")
    (setq STL_DIM_FILE (open (findfile "stl_met_r.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "met_c_shape")
    (setq STL_DIM_FILE (open (findfile "stl_met_c.dim") "r"))
  ) ;_ end of if
  (if (= NEWTILE "met_a_shape")
    (setq STL_DIM_FILE (open (findfile "stl_met_a.dim") "r"))
  ) ;_ end of if
) ;end STL_OPEN_DIM_FILE
  ;-----------------------------------------------------------------------;
(defun
   STL_SET_DIM ()
  (if (and (= NEWTILE "w_shape") (/= SIZE NIL))
    (STL_W_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "m_shape") (/= SIZE NIL))
    (STL_W_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "hp_shape") (/= SIZE NIL))
    (STL_W_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "s_shape") (/= SIZE NIL))
    (STL_W_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "c_shape") (/= SIZE NIL))
    (STL_W_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "c_bar_shape") (/= SIZE NIL))
    (STL_W_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "mc_shape") (/= SIZE NIL))
    (STL_W_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "l_shape") (/= SIZE NIL))
    (STL_L_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "wt_shape") (/= SIZE NIL))
    (STL_W_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "mt_shape") (/= SIZE NIL))
    (STL_W_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "st_shape") (/= SIZE NIL))
    (STL_W_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "std_pipe") (/= SIZE NIL))
    (STL_PIPE_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "xs_pipe") (/= SIZE NIL))
    (STL_PIPE_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "xxs_pipe") (/= SIZE NIL))
    (STL_PIPE_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "tube_round") (/= SIZE NIL))
    (STL_PIPE_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "ts_square") (/= SIZE NIL))
    (STL_TS_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "ts_rect") (/= SIZE NIL))
    (STL_TS_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "met_w_shape") (/= SIZE NIL))
    (STL_W_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "met_r_shape") (/= SIZE NIL))
    (STL_TS_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "met_c_shape") (/= SIZE NIL))
    (STL_W_SETDIM)
  ) ;_ end of if
  (if (and (= NEWTILE "met_a_shape") (/= SIZE NIL))
    (STL_L_SETDIM)
  ) ;_ end of if
) ;end STL_SET_DIM
  ;-----------------------------------------------------------------------;
(defun
   DRAW_SHAPE ()
  (if (and (/= NEWTILE NIL) (= WHICH_VIEW "2d_end"))
    (DRAW_SHAPE_END_VIEW)
  ) ;_ end of if
  (if (and (/= NEWTILE NIL) (= WHICH_VIEW "2d_top"))
    (DRAW_SHAPE_TOP_VIEW)
  ) ;_ end of if
  (if (and (/= NEWTILE NIL) (= WHICH_VIEW "2d_side"))
    (DRAW_SHAPE_SIDE_VIEW)
  ) ;_ end of if
  (if (and (/= NEWTILE NIL) (= WHICH_VIEW "3d_solid"))
    (DRAW_SHAPE_END_VIEW)
  ) ;_ end of if
  (if (and (/= NEWTILE NIL) (= WHICH_VIEW "3d_surface"))
    (DRAW_SHAPE_END_VIEW)
  ) ;_ end of if
) ; end DRAW_SHAPE
  ;-----------------------------------------------------------------------;
(defun
   DRAW_SHAPE_END_VIEW ()
  (initget 137 "R")
  (setq INSERT_PT (getpoint "\n<Select insert point>/Reference: "))
  (if (= INSERT_PT "R")
    (progn
      (setq BPT (getpoint "\nEnter BASE point: "))
      (setq RPT (getpoint "\nEnter x,y REFERENCE from BASE point: "))
      (setq
        INSERT_PT
         (list
           (+ (car BPT) (car RPT))
           (+ (cadr BPT) (cadr RPT))
         ) ;_ end of list
      ) ;_ end of setq
    ) ;end progn
  ) ;end if
  (setvar "OSMODE" 16384)
  (if (= NEWTILE "w_shape")
    (DRAW_W_M_HP_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "m_shape")
    (DRAW_W_M_HP_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "hp_shape")
    (DRAW_W_M_HP_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "s_shape")
    (DRAW_S_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "c_shape")
    (DRAW_C_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "c_bar_shape")
    (DRAW_C_BAR_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "mc_shape")
    (DRAW_MC_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "l_shape")
    (DRAW_L_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "wt_shape")
    (DRAW_WT_MT_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "mt_shape")
    (DRAW_WT_MT_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "st_shape")
    (DRAW_ST_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "std_pipe")
    (DRAW_PIPE_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "xs_pipe")
    (DRAW_PIPE_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "xxs_pipe")
    (DRAW_PIPE_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "tube_round")
    (DRAW_PIPE_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "ts_square")
    (DRAW_TS_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "ts_rect")
    (DRAW_TS_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "met_w_shape")
    (DRAW_W_M_HP_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "met_r_shape")
    (DRAW_TS_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "met_c_shape")
    (DRAW_MET_C_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "met_a_shape")
    (DRAW_L_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "form_ang_shape")
    (DRAW_FORM_ANG_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "form_chann_shape")
    (DRAW_FORM_CHANN_SHAPE)
  ) ;_ end of if
  (if (= NEWTILE "form_zee_shape")
    (DRAW_FORM_ZEE_SHAPE)
  ) ;_ end of if
) ;end DRAW_SHAPE_END
  ;-----------------------------------------------------------------------;
(defun
   DRAW_SHAPE_TOP_VIEW ()
  (initget 137 "R")
  (setq INSERT_PT (getpoint "\n<Select insert point>/Reference: "))
  (if (= INSERT_PT "R")
    (progn
      (setq BPT (getpoint "\nEnter BASE point: "))
      (setq RPT (getpoint "\nEnter x,y REFERENCE from BASE point: "))
      (setq
        INSERT_PT
         (list
           (+ (car BPT) (car RPT))
           (+ (cadr BPT) (cadr RPT))
         ) ;_ end of list
      ) ;_ end of setq
    ) ;end progn
  ) ;end if
  (setvar "OSMODE" 16384)
  (if (= NEWTILE "w_shape")
    (DRAW_W_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "m_shape")
    (DRAW_W_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "hp_shape")
    (DRAW_W_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "s_shape")
    (DRAW_W_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "c_shape")
    (DRAW_C_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "c_bar_shape")
    (DRAW_C_BAR_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "mc_shape")
    (DRAW_C_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "l_shape")
    (DRAW_L_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "wt_shape")
    (DRAW_W_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "mt_shape")
    (DRAW_W_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "st_shape")
    (DRAW_W_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "std_pipe")
    (DRAW_PIPE_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "xs_pipe")
    (DRAW_PIPE_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "xxs_pipe")
    (DRAW_PIPE_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "tube_round")
    (DRAW_PIPE_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "ts_square")
    (DRAW_TS_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "ts_rect")
    (DRAW_TS_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "met_w_shape")
    (DRAW_W_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "met_r_shape")
    (DRAW_TS_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "met_c_shape")
    (DRAW_C_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "met_a_shape")
    (DRAW_L_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "form_ang_shape")
    (DRAW_FORM_ANG_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "form_chann_shape")
    (DRAW_FORM_CHANN_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "form_zee_shape")
    (DRAW_FORM_ZEE_SHAPE_TOP)
  ) ;_ end of if
) ;end DRAW_SHAPE
  ;-----------------------------------------------------------------------;
(defun
   DRAW_SHAPE_SIDE_VIEW ()
  (initget 137 "R")
  (setq INSERT_PT (getpoint "\n<Select insert point>/Reference: "))
  (if (= INSERT_PT "R")
    (progn
      (setq BPT (getpoint "\nEnter BASE point: "))
      (setq RPT (getpoint "\nEnter x,y REFERENCE from BASE point: "))
      (setq
        INSERT_PT
         (list
           (+ (car BPT) (car RPT))
           (+ (cadr BPT) (cadr RPT))
         ) ;_ end of list
      ) ;_ end of setq
    ) ;end progn
  ) ;end if
  (setvar "OSMODE" 16384)
  (if (= NEWTILE "w_shape")
    (DRAW_W_SHAPE_SIDE)
  ) ;_ end of if
  (if (= NEWTILE "m_shape")
    (DRAW_W_SHAPE_SIDE)
  ) ;_ end of if
  (if (= NEWTILE "hp_shape")
    (DRAW_W_SHAPE_SIDE)
  ) ;_ end of if
  (if (= NEWTILE "s_shape")
    (DRAW_W_SHAPE_SIDE)
  ) ;_ end of if
  (if (= NEWTILE "c_shape")
    (DRAW_W_SHAPE_SIDE)
  ) ;_ end of if
  (if (= NEWTILE "c_bar_shape")
    (DRAW_W_SHAPE_SIDE)
  ) ;_ end of if
  (if (= NEWTILE "mc_shape")
    (DRAW_W_SHAPE_SIDE)
  ) ;_ end of if
  (if (= NEWTILE "l_shape")
    (DRAW_L_SHAPE_SIDE)
  ) ;_ end of if
  (if (= NEWTILE "wt_shape")
    (DRAW_WT_SHAPE_SIDE)
  ) ;_ end of if
  (if (= NEWTILE "mt_shape")
    (DRAW_WT_SHAPE_SIDE)
  ) ;_ end of if
  (if (= NEWTILE "st_shape")
    (DRAW_WT_SHAPE_SIDE)
  ) ;_ end of if
  (if (= NEWTILE "std_pipe")
    (DRAW_PIPE_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "xs_pipe")
    (DRAW_PIPE_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "xxs_pipe")
    (DRAW_PIPE_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "tube_round")
    (DRAW_PIPE_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "ts_square")
    (DRAW_TS_SHAPE_TOP)
  ) ;_ end of if
  (if (= NEWTILE "ts_rect")
    (DRAW_TS_SHAPE_SIDE)
  ) ;_ end of if
  (if (= NEWTILE "met_w_shape")
    (DRAW_W_SHAPE_SIDE)
  ) ;_ end of if
  (if (= NEWTILE "met_r_shape")
    (DRAW_TS_SHAPE_SIDE)
  ) ;_ end of if
  (if (= NEWTILE "met_c_shape")
    (DRAW_C_SHAPE_SIDE)
  ) ;_ end of if
  (if (= NEWTILE "met_a_shape")
    (DRAW_L_SHAPE_SIDE)
  ) ;_ end of if
  (if (= NEWTILE "form_ang_shape")
    (DRAW_FORM_ANG_SHAPE_SIDE)
  ) ;_ end of if
  (if (= NEWTILE "form_chann_shape")
    (DRAW_FORM_CHANN_SHAPE_SIDE)
  ) ;_ end of if
  (if (= NEWTILE "form_zee_shape")
    (DRAW_FORM_ZEE_SHAPE_SIDE)
  ) ;_ end of if
) ;end DRAW_SHAPE
  ;-----------------------------------------------------------------------;
(defun
   STL_W_SETDIM ()
  (setq
    D  (nth 1 SIZE_DIMS)
    TW (nth 2 SIZE_DIMS)
    BF (nth 3 SIZE_DIMS)
    TF (nth 4 SIZE_DIMS)
    K  (nth 5 SIZE_DIMS)
  ) ;end setq
  (if (= SCALE "1")
    (STL_SCALE_TO_E)
  ) ;_ end of if
  (set_tile "depth" (rtos D 2 3))
  (set_tile "web" (rtos TW 2 3))
  (set_tile "width" (rtos BF 2 3))
  (set_tile "flange" (rtos TF 2 3))
  (set_tile "k_dim" (rtos K 2 3))
) ;End STL_W_SETDIM
  ;-----------------------------------------------------------------------;
(defun
   STL_L_SETDIM ()
  (setq
    L_VERT
     (nth 1 SIZE_DIMS)
    L_HORIZ
     (nth 2 SIZE_DIMS)
    L_THICK
     (nth 3 SIZE_DIMS)
    K (nth 4 SIZE_DIMS)
  ) ;end setq
  (if (= SCALE "1")
    (STL_SCALE_TO_E)
  ) ;_ end of if
  (set_tile "depth" (rtos L_VERT 2 3))
  (set_tile "web" (rtos L_THICK 2 3))
  (set_tile "width" (rtos L_HORIZ 2 3))
  (set_tile "k_dim" (rtos K 2 3))
) ;end STL_L_SETDIM
  ;-----------------------------------------------------------------------;
(defun
   STL_PIPE_SETDIM ()
  (setq
    TEMP_DIST1
     (nth 1 SIZE_DIMS)
    TEMP_DIST2
     (nth 2 SIZE_DIMS)
  ) ;_ end of setq
  (if (= SCALE "1")
    (STL_SCALE_TO_E)
  ) ;_ end of if
  (set_tile "od_pipe" (rtos TEMP_DIST1 2 3))
  (set_tile "id_pipe" (rtos TEMP_DIST2 2 3))
) ;end STL_PIPE_SETDIM
  ;-----------------------------------------------------------------------;
(defun
   STL_TS_SETDIM ()
  (setq
    TUBE_VERT
     (nth 1 SIZE_DIMS)
    TUBE_HORIZ
     (nth 2 SIZE_DIMS)
    TUBE_THICK
     (nth 3 SIZE_DIMS)
  ) ;_ end of setq
  (if (= SCALE "1")
    (STL_SCALE_TO_E)
  ) ;_ end of if
  (set_tile "depth_tube" (rtos TUBE_VERT 2 3))
  (set_tile "width_tube" (rtos TUBE_HORIZ 2 3))
  (set_tile "thk_tube" (rtos TUBE_THICK 2 3))
) ;end STL_TS_SETDIM
  ;-----------------------------------------------------------------------;
(defun
   STL_SCALE_TO_E ()
  (if (or (= NEWTILE "met_w_shape") (= NEWTILE "met_c_shape"))
    (setq
      D  (/ D 25.4)
      TW (/ TW 25.4)
      BF (/ BF 25.4)
      TF (/ TF 25.4)
      K  (/ K 25.4)
    ) ;_ end of setq
  ) ;_ end of if
  (if (= NEWTILE "met_a_shape")
    (setq
      L_VERT
       (/ L_VERT 25.4)
      L_HORIZ
       (/ L_HORIZ 25.4)
      L_THICK
       (/ L_THICK 25.4)
      K (/ K 25.4)
    ) ;_ end of setq
  ) ;_ end of if
  (if (= NEWTILE "met_r_shape")
    (setq
      TUBE_VERT
       (/ TUBE_VERT 25.4)
      TUBE_HORIZ
       (/ TUBE_HORIZ 25.4)
      TUBE_THICK
       (/ TUBE_THICK 25.4)
    ) ;_ end of setq
  ) ;_ end of if
) ;End STL_SCALE_TO_E
  ;-----------------------------------------------------------------------;
(defun
   DRAW_W_M_HP_SHAPE (/ R TW1 PT1 PT2 PT3 PT4 PT5 PT6 PT7 PT8 PT9 PT10
                      PT11 PT12 PT13 PT14 PT15 PT16 PT17 PT18 PT19 PT20
                     )
  (setq
    BF   (/ BF 2)
    TW   (/ TW 2)
    R    (- K TF)
    TW1  (+ TW R)
    PT1  (polar INSERT_PT (DTR 90) BF)
    PT2  (polar PT1 (DTR 0) TF)
    PT3  (polar PT2 (DTR 270) (- BF TW1))
    PT4  (polar PT3 (DTR 270) R)
    PT5  (polar PT4 (DTR 0) R)
    PT6  (polar PT5 (DTR 0) (- D (* K 2)))
    PT7  (polar PT6 (DTR 0) R)
    PT8  (polar PT7 (DTR 90) R)
    PT9  (polar PT8 (DTR 90) (- BF TW1))
    PT10 (polar PT9 (DTR 0) TF)
    PT11 (polar PT10 (DTR 270) (* BF 2))
    PT12 (polar PT11 (DTR 180) TF)
    PT13 (polar PT12 (DTR 90) (- BF TW1))
    PT14 (polar PT13 (DTR 90) R)
    PT15 (polar PT14 (DTR 180) R)
    PT16 (polar PT15 (DTR 180) (- D (* K 2)))
    PT17 (polar PT16 (DTR 180) R)
    PT18 (polar PT17 (DTR 270) R)
    PT19 (polar PT18 (DTR 270) (- BF TW1))
    PT20 (polar PT19 (DTR 180) TF)
  ) ;end setq
  (command
    "pline" INSERT_PT PT1 PT2 PT3 "arc" "d" PT4 PT5 "line" PT6 "arc" "d"
    PT7 PT8 "line" PT9 PT10 PT11 PT12 PT13 "arc" "d" PT14 PT15 "line"
    PT16 "arc" "d" PT17 PT18 "line" PT19 PT20 INSERT_PT ""
   ) ;_ end of command
  (if (= WHICH_VIEW "2d_end")
    (command "rotate" "l" "" INSERT_PT)
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_solid")
    (progn
      (command "extrude" "l" "" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_surface")
    (progn
      (command "change" "l" "" "p" "t" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
) ;end DRAW_W_M_HP_SHAPE
  ;-----------------------------------------------------------------------;
(defun
   DRAW_W_SHAPE_TOP (/ PT1 PT2 PT3 PT4 PT5 PT6 PT7 PT8 ENT1 ENT2)
  (setq
    BF  (/ BF 2)
    TW  (/ TW 2)
    PT1 (polar INSERT_PT (DTR 90) BF)
    PT2 (polar PT1 (DTR 0) LGTH)
    PT3 (polar PT2 (DTR 270) (* BF 2))
    PT4 (polar PT3 (DTR 180) LGTH)
    PT5 (polar INSERT_PT (DTR 90) TW)
    PT6 (polar PT5 (DTR 0) LGTH)
    PT7 (polar PT6 (DTR 270) (* TW 2))
    PT8 (polar PT7 (DTR 180) LGTH)
  ) ;end setq
  (command "pline" INSERT_PT PT1 PT2 PT3 PT4 INSERT_PT "")
  (setq ENT1 (entlast))
  (command "pline" PT5 PT6 PT7 PT8 "")
  (setq ENT2 (entlast))
  (command "chprop" ENT2 "" "lt" "hidden" "")
  (command "rotate" ENT1 ENT2 "" INSERT_PT)
) ;end DRAW_W_SHAPE_TOP
  ;-----------------------------------------------------------------------;
(defun
   DRAW_W_SHAPE_SIDE (/ PT1 PT2 PT3 PT4 PT5 PT6 PT7)
  (setq
    PT1 (polar INSERT_PT (DTR 90) D)
    PT2 (polar PT1 (DTR 0) LGTH)
    PT3 (polar PT2 (DTR 270) D)
    PT4 (polar PT1 (DTR 270) TF)
    PT5 (polar PT4 (DTR 0) LGTH)
    PT6 (polar PT3 (DTR 90) TF)
    PT7 (polar PT6 (DTR 180) LGTH)
  ) ;end setq
  (command "pline" INSERT_PT PT1 PT2 PT3 INSERT_PT PT4 PT5 PT6 PT7 "")
  (command "rotate" "l" "" INSERT_PT)
) ;end DRAW_W_SHAPE_SIDE
  ;-----------------------------------------------------------------------;
(defun
   DRAW_WT_SHAPE_SIDE (/ PT1 PT2 PT3 PT4 PT5)
  (setq
    PT1 (polar INSERT_PT (DTR 90) D)
    PT2 (polar PT1 (DTR 0) LGTH)
    PT3 (polar PT2 (DTR 270) D)
    PT4 (polar PT1 (DTR 270) TF)
    PT5 (polar PT4 (DTR 0) LGTH)
  ) ;end setq
  (command "pline" INSERT_PT PT1 PT2 PT3 INSERT_PT PT4 PT5 PT6 PT7 "")
  (command "rotate" "l" "" INSERT_PT)
) ;end DRAW_W_SHAPE_SIDE
  ;-----------------------------------------------------------------------;
(defun
   DRAW_S_SHAPE (/ TF1 TF2 PT1 PT2 HALF_TAN1 HALF_TAN2 HYPOT PT3 PT4 PT5
                 PT6 PT7 PT8 PT9 PT10 PT11 PT12 PT13 PT14 PT15 PT16 PT17
                 PT18 PT19 PT20 PT21 PT22 PT23 PT24 PT25 PT26 PT27 PT28
                )
  (setq
    BF (/ BF 2)
    TW (/ TW 2)
    TF1
     (- TF (* (/ (- BF TW) 2) 0.17632698))
    PT1
     (polar INSERT_PT (DTR 90) BF)
    PT2
     (polar PT1 (DTR 0) TF1)
    HALF_TAN1
     (/ (distance PT1 PT2) 2)
    HYPOT
     (* (- BF TW) 1.015426612)
    TF2
     (+ TF (* (/ (- BF TW) 2) 0.17632698))
    HALF_TAN2
     (- K TF2)
    PT3
     (polar PT2 (DTR 180) HALF_TAN1)
    PT4
     (polar PT2 (DTR 280) HALF_TAN1)
    PT5
     (polar PT2 (DTR 280) HYPOT)
    PT6
     (polar PT5 (DTR 100) HALF_TAN2)
    PT7
     (polar PT5 (DTR 0) HALF_TAN2)
    PT8
     (polar PT5 (DTR 0) (- D (* TF2 2)))
    PT9
     (polar PT8 (DTR 180) HALF_TAN2)
    PT10
     (polar PT8 (DTR 80) HALF_TAN2)
    PT11
     (polar PT8 (DTR 80) HYPOT)
    PT12
     (polar PT11 (DTR 260) HALF_TAN1)
    PT13
     (polar PT11 (DTR 0) HALF_TAN1)
    PT14
     (polar PT11 (DTR 0) TF1)
    PT15
     (polar PT14 (DTR 270) (* BF 2))
    PT16
     (polar PT15 (DTR 180) TF1)
    PT17
     (polar PT16 (DTR 0) HALF_TAN1)
    PT18
     (polar PT16 (DTR 100) HALF_TAN1)
    PT19
     (polar PT16 (DTR 100) HYPOT)
    PT20
     (polar PT19 (DTR 280) HALF_TAN2)
    PT21
     (polar PT19 (DTR 180) HALF_TAN2)
    PT22
     (polar PT19 (DTR 180) (- D (* TF2 2)))
    PT23
     (polar PT22 (DTR 0) HALF_TAN2)
    PT24
     (polar PT22 (DTR 260) HALF_TAN2)
    PT25
     (polar PT22 (DTR 260) HYPOT)
    PT26
     (polar PT25 (DTR 80) HALF_TAN1)
    PT27
     (polar PT25 (DTR 180) HALF_TAN1)
    PT28
     (polar PT25 (DTR 180) TF1)
  ) ;end setq
  (command
    "pline" INSERT_PT PT1 PT3 "arc" "d" PT2 PT4 "line" PT6 "arc" "d" PT5
    PT7 "line" PT9 "arc" "d" PT8 PT10 "line" PT12 "arc" "d" PT11 PT13
    "line" PT14 PT15 PT17 "arc" "d" PT16 PT18 "line" PT20 "arc" "d" PT19
    PT21 "line" PT23 "arc" "d" PT22 PT24 "line" PT26 "arc" "d" PT25 PT27
    "line" PT28 INSERT_PT ""
   ) ;_ end of command
  (if (= WHICH_VIEW "2d_end")
    (command "rotate" "l" "" INSERT_PT)
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_solid")
    (progn
      (command "extrude" "l" "" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_surface")
    (progn
      (command "change" "l" "" "p" "t" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
) ;end DRAW_S_SHAPE
  ;-----------------------------------------------------------------------;
(defun
   DRAW_C_SHAPE (/ TF1 PT1 PT2 HALF_TAN1 HYPOT TF2 HALF_TAN2 PT3 PT4 PT5
                 PT6 PT7 PT8 PT9 PT10 PT11 PT12 PT13 PT14 PT15
                )
  (setq
    TF1
     (- TF (* (/ (- BF TW) 2) 0.17632698))
    PT1
     (polar INSERT_PT (DTR 90) BF)
    PT2
     (polar PT1 (DTR 0) TF1)
    HALF_TAN1
     (/ (distance PT1 PT2) 2)
    HYPOT
     (* (- BF TW) 1.015426612)
    TF2
     (+ TF (* (/ (- BF TW) 2) 0.17632698))
    HALF_TAN2
     (- K TF2)
    PT3
     (polar PT2 (DTR 180) HALF_TAN1)
    PT4
     (polar PT2 (DTR 280) HALF_TAN1)
    PT5
     (polar PT2 (DTR 280) HYPOT)
    PT6
     (polar PT5 (DTR 100) HALF_TAN2)
    PT7
     (polar PT5 (DTR 0) HALF_TAN2)
    PT8
     (polar PT5 (DTR 0) (- D (* TF2 2)))
    PT9
     (polar PT8 (DTR 180) HALF_TAN2)
    PT10
     (polar PT8 (DTR 80) HALF_TAN2)
    PT11
     (polar PT8 (DTR 80) HYPOT)
    PT12
     (polar PT11 (DTR 260) HALF_TAN1)
    PT13
     (polar PT11 (DTR 0) HALF_TAN1)
    PT14
     (polar PT11 (DTR 0) TF1)
    PT15
     (polar PT14 (DTR 270) BF)
  ) ;end setq
  (command
    "pline" INSERT_PT PT1 PT3 "arc" "d" PT2 PT4 "line" PT6 "arc" "d" PT5
    PT7 "line" PT9 "arc" "d" PT8 PT10 "line" PT12 "arc" "d" PT11 PT13
    "line" PT14 PT15 INSERT_PT ""
   ) ;_ end of command
  (if (= WHICH_VIEW "2d_end")
    (command "rotate" "l" "" INSERT_PT)
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_solid")
    (progn
      (command "extrude" "l" "" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_surface")
    (progn
      (command "change" "l" "" "p" "t" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
) ;end DRAW_C_SHAPE
  ;-----------------------------------------------------------------------;
(defun
   DRAW_C_BAR_SHAPE (/ HALF_TAN PT1 PT2 PT3 PT4 PT5 PT6 PT7 PT8 PT9 PT10
                     PT11 PT12 PT13 PT14 PT15
                    )
  (setq
    HALF_TAN
     (/ TW 2)
    PT1
     (polar INSERT_PT (DTR 0) BF)
    PT2
     (polar PT1 (DTR 90) TF)
    PT3
     (polar PT2 (DTR 270) HALF_TAN)
    PT4
     (polar PT2 (DTR 180) HALF_TAN)
    PT5
     (polar PT2 (DTR 180) (- BF K))
    PT6
     (polar PT5 (DTR 180) (- K TF))
    PT7
     (polar PT6 (DTR 90) (- K TF))
    PT8
     (polar PT7 (DTR 90) (- D (* K 2)))
    PT9
     (polar PT8 (DTR 90) (- K TF))
    PT10
     (polar PT9 (DTR 0) (- K TF))
    PT11
     (polar PT10 (DTR 0) (- BF K))
    PT12
     (polar PT11 (DTR 180) HALF_TAN)
    PT13
     (polar PT11 (DTR 90) HALF_TAN)
    PT14
     (polar PT11 (DTR 90) TF)
    PT15
     (polar PT14 (DTR 180) BF)
  ) ;end setq
  (command
    "pline" INSERT_PT PT1 PT3 "arc" "d" PT2 PT4 "line" PT5 "arc" "d" PT6
    PT7 "line" PT8 "arc" "d" PT9 PT10 "line" PT12 "arc" "d" PT11 PT13
    "line" PT14 PT15 INSERT_PT ""
   ) ;_ end of command
  (if (= WHICH_VIEW "2d_end")
    (command "rotate" "l" "" INSERT_PT)
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_solid")
    (progn
      (command "extrude" "l" "" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_surface")
    (progn
      (command "change" "l" "" "p" "t" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
) ;end DRAW_C_BAR_SHAPE
  ;-----------------------------------------------------------------------;
(defun
   DRAW_MET_C_SHAPE
   (/ RAD PT1 PT2 PT3 PT4 PT5 PT6 PT7 PT8 PT9 PT10 PT11)
  (setq
    RAD  (- K TF)
    PT1  (polar INSERT_PT (DTR 90) BF)
    PT2  (polar PT1 (DTR 0) TF)
    PT3  (polar PT2 (DTR 270) (- BF TW))
    PT4  (polar PT3 (DTR 90) RAD)
    PT5  (polar PT3 (DTR 0) RAD)
    PT6  (polar PT5 (DTR 0) (- D (* K 2)))
    PT7  (polar PT6 (DTR 180) RAD)
    PT8  (polar PT6 (DTR 90) RAD)
    PT9  (polar PT6 (DTR 90) (- BF TW))
    PT10 (polar PT9 (DTR 0) TF)
    PT11 (polar PT10 (DTR 270) BF)
  ) ;end setq
  (command
    "pline" INSERT_PT PT1 PT2 PT4 "arc" "d" PT3 PT5 "line" PT7 "arc" "d"
    PT6 PT8 "line" PT9 PT10 PT11 INSERT_PT ""
   ) ;_ end of command
  (if (= WHICH_VIEW "2d_end")
    (command "rotate" "l" "" INSERT_PT)
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_solid")
    (progn
      (command "extrude" "l" "" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_surface")
    (progn
      (command "change" "l" "" "p" "t" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
) ;end DRAW_MET_C_SHAPE
  ;-----------------------------------------------------------------------;
(defun
   DRAW_C_SHAPE_TOP (/ PT1 PT2 PT3 PT4 PT5 ENT1 ENT2)
  (setq
    PT1 (polar INSERT_PT (DTR 90) BF)
    PT2 (polar PT1 (DTR 0) LGTH)
    PT3 (polar PT2 (DTR 270) BF)
    PT4 (polar PT1 (DTR 270) TW)
    PT5 (polar PT4 (DTR 0) LGTH)
  ) ;end setq
  (command "pline" INSERT_PT PT1 PT2 PT3 INSERT_PT "")
  (setq ENT1 (entlast))
  (command "pline" PT4 PT5 "")
  (setq ENT2 (entlast))
  (command "chprop" ENT2 "" "lt" "hidden" "")
  (command "rotate" ENT1 ENT2 "" INSERT_PT)
) ;end DRAW_C_SHAPE_TOP
  ;-----------------------------------------------------------------------;
(defun
   DRAW_MC_SHAPE (/ TF1 PT1 PT2 HALF_TAN1 HYPOT TF2 HALF_TAN2 PT3 PT4
                  PT5 PT6 PT7 PT8 PT9 PT10 PT11 PT12 PT13 PT14 PT15
                 )
  (setq
    TF1
     (- TF (* (/ (- BF TW) 2) 0.052407779))
    PT1
     (polar INSERT_PT (DTR 90) BF)
    PT2
     (polar PT1 (DTR 0) TF1)
    HALF_TAN1
     (/ (distance PT1 PT2) 2)
    HYPOT
     (* (- BF TW) 1.0013723)
    TF2
     (+ TF (* (/ (- BF TW) 2) 0.052407779))
    HALF_TAN2
     (- K TF2)
    PT3
     (polar PT2 (DTR 180) HALF_TAN1)
    PT4
     (polar PT2 (DTR 273) HALF_TAN1)
    PT5
     (polar PT2 (DTR 273) HYPOT)
    PT6
     (polar PT5 (DTR 93) HALF_TAN2)
    PT7
     (polar PT5 (DTR 0) HALF_TAN2)
    PT8
     (polar INSERT_PT (DTR 0) D)
    PT9
     (polar PT8 (DTR 90) BF)
    PT10
     (polar PT9 (DTR 180) TF1)
    PT11
     (polar PT10 (DTR 0) HALF_TAN1)
    PT12
     (polar PT10 (DTR 267) HALF_TAN1)
    PT13
     (polar PT10 (DTR 267) HYPOT)
    PT14
     (polar PT13 (DTR 87) HALF_TAN2)
    PT15
     (polar PT13 (DTR 180) HALF_TAN2)
  ) ;end setq
  (command
    "pline" INSERT_PT PT1 PT3 "arc" "d" PT2 PT4 "line" PT6 "arc" "d" PT5
    PT7 "line" PT15 "arc" "d" PT13 PT14 "line" PT12 "arc" "d" PT10 PT11
    "line" PT9 PT8 INSERT_PT ""
   ) ;_ end of command
  (if (= WHICH_VIEW "2d_end")
    (command "rotate" "l" "" INSERT_PT)
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_solid")
    (progn
      (command "extrude" "l" "" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_surface")
    (progn
      (command "change" "l" "" "p" "t" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
) ;end DRAW_MC_SHAPE
  ;-----------------------------------------------------------------------;
(defun
   DRAW_L_SHAPE
   (/ HALF_TAN PT1 PT2 PT3 PT4 PT5 PT6 PT7 PT8 PT9 PT10 PT11)
  (setq
    HALF_TAN
     (/ L_THICK 2)
    PT1
     (polar INSERT_PT (DTR 0) L_HORIZ)
    PT2
     (polar PT1 (DTR 90) L_THICK)
    PT3
     (polar PT2 (DTR 270) HALF_TAN)
    PT4
     (polar PT2 (DTR 180) HALF_TAN)
    PT5
     (polar PT2 (DTR 180) (- L_HORIZ K))
    PT6
     (polar PT5 (DTR 180) (- K L_THICK))
    PT7
     (polar PT6 (DTR 90) (- K L_THICK))
    PT8
     (polar PT7 (DTR 90) (- L_VERT K))
    PT9
     (polar PT8 (DTR 270) HALF_TAN)
    PT10
     (polar PT8 (DTR 180) HALF_TAN)
    PT11
     (polar PT8 (DTR 180) L_THICK)
  ) ;end setq
  (command
    "pline" INSERT_PT PT1 PT3 "arc" "d" PT2 PT4 "line" PT5 "arc" "d" PT6
    PT7 "line" PT9 "arc" "d" PT8 PT10 "line" PT11 INSERT_PT ""
   ) ;_ end of command
  (if (= WHICH_VIEW "2d_end")
    (command "rotate" "l" "" INSERT_PT)
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_solid")
    (progn
      (command "extrude" "l" "" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_surface")
    (progn
      (command "change" "l" "" "p" "t" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
) ;end DRAW_L_SHAPE
  ;-----------------------------------------------------------------------;
(defun
   DRAW_L_SHAPE_TOP (/ PT1 PT2 PT3 PT4 PT5 ENT1 ENT2)
  (setq
    PT1 (polar INSERT_PT (DTR 90) L_HORIZ)
    PT2 (polar PT1 (DTR 0) LGTH)
    PT3 (polar PT2 (DTR 270) L_HORIZ)
    PT4 (polar PT1 (DTR 270) L_THICK)
    PT5 (polar PT4 (DTR 0) LGTH)
  ) ;end setq
  (command "pline" INSERT_PT PT1 PT2 PT3 INSERT_PT "")
  (setq ENT1 (entlast))
  (command "pline" PT4 PT5 "")
  (setq ENT2 (entlast))
  (command "rotate" ENT1 ENT2 "" INSERT_PT)
) ;end DRAW_L_SHAPE_TOP
  ;-----------------------------------------------------------------------;
(defun
   DRAW_L_SHAPE_SIDE (/ PT1 PT2 PT3 PT4 PT5)
  (setq
    PT1 (polar INSERT_PT (DTR 90) L_VERT)
    PT2 (polar PT1 (DTR 0) LGTH)
    PT3 (polar PT2 (DTR 270) L_VERT)
    PT4 (polar INSERT_PT (DTR 90) L_THICK)
    PT5 (polar PT4 (DTR 0) LGTH)
  ) ;end setq
  (command "pline" INSERT_PT PT1 PT2 PT3 INSERT_PT "")
  (setq ENT1 (entlast))
  (command "pline" PT4 PT5 "")
  (setq ENT2 (entlast))
  (command "rotate" ENT1 ENT2 "" INSERT_PT)
) ;end DRAW_L_SHAPE_TOP
  ;-----------------------------------------------------------------------;
(defun
   DRAW_WT_MT_SHAPE
   (/ R TW1 PT1 PT2 PT3 PT4 PT5 PT6 PT7 PT8 PT9 PT10 PT11 PT12)
  (setq
    BF   (/ BF 2)
    TW   (/ TW 2)
    R    (- K TF)
    TW1  (+ TW R)
    PT1  (polar INSERT_PT (DTR 90) BF)
    PT2  (polar PT1 (DTR 0) TF)
    PT3  (polar PT2 (DTR 270) (- BF TW1))
    PT4  (polar PT3 (DTR 270) R)
    PT5  (polar PT4 (DTR 0) R)
    PT6  (polar PT5 (DTR 0) (- D K))
    PT7  (polar PT6 (DTR 270) (* TW 2))
    PT8  (polar PT7 (DTR 180) (- D K))
    PT9  (polar PT8 (DTR 180) R)
    PT10 (polar PT9 (DTR 270) R)
    PT11 (polar PT10 (DTR 270) (- BF TW1))
    PT12 (polar PT11 (DTR 180) TF)
  ) ;end setq
  (command
    "pline" INSERT_PT PT1 PT2 PT3 "arc" "d" PT4 PT5 "line" PT6 PT7 PT8
    "arc" "d" PT9 PT10 "line" PT11 PT12 INSERT_PT ""
   ) ;_ end of command
  (if (= WHICH_VIEW "2d_end")
    (command "rotate" "l" "" INSERT_PT)
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_solid")
    (progn
      (command "extrude" "l" "" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_surface")
    (progn
      (command "change" "l" "" "p" "t" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
) ;end DRAW_WT_MT_SHAPE
  ;-----------------------------------------------------------------------;
(defun
   DRAW_ST_SHAPE (/ TF1 PT1 PT2 HALF_TAN1 HYPOT TF2 HALF_TAN2 PT3 PT4
                  PT5 PT6 PT7 PT8 PT9 PT10 PT11 PT12 PT13 PT14 PT15 PT16
                 )
  (setq
    BF (/ BF 2)
    TW (/ TW 2)
    TF1
     (- TF (* (/ (- BF TW) 2) 0.17632698))
    PT1
     (polar INSERT_PT (DTR 90) BF)
    PT2
     (polar PT1 (DTR 0) TF1)
    HALF_TAN1
     (/ (distance PT1 PT2) 2)
    HYPOT
     (* (- BF TW) 1.015426612)
    TF2
     (+ TF (* (/ (- BF TW) 2) 0.17632698))
    HALF_TAN2
     (- K TF2)
    PT3
     (polar PT2 (DTR 180) HALF_TAN1)
    PT4
     (polar PT2 (DTR 280) HALF_TAN1)
    PT5
     (polar PT2 (DTR 280) HYPOT)
    PT6
     (polar PT5 (DTR 100) HALF_TAN2)
    PT7
     (polar PT5 (DTR 0) HALF_TAN2)
    PT8
     (polar PT5 (DTR 0) (- D TF2))
    PT9
     (polar PT8 (DTR 270) (* TW 2))
    PT10
     (polar PT9 (DTR 180) (- D TF2))
    PT11
     (polar PT10 (DTR 0) HALF_TAN2)
    PT12
     (polar PT10 (DTR 260) HALF_TAN2)
    PT13
     (polar PT10 (DTR 260) HYPOT)
    PT14
     (polar PT13 (DTR 80) HALF_TAN1)
    PT15
     (polar PT13 (DTR 180) HALF_TAN1)
    PT16
     (polar PT13 (DTR 180) TF1)
  ) ;end setq
  (command
    "pline" INSERT_PT PT1 PT3 "arc" "d" PT2 PT4 "line" PT6 "arc" "d" PT5
    PT7 "line" PT8 PT9 PT11 "arc" "d" PT10 PT12 "line" PT14 "arc" "d"
    PT13 PT15 "line" PT16 INSERT_PT ""
   ) ;_ end of command
  (if (= WHICH_VIEW "2d_end")
    (command "rotate" "l" "" INSERT_PT)
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_solid")
    (progn
      (command "extrude" "l" "" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_surface")
    (progn
      (command "change" "l" "" "p" "t" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
) ;end DRAW_ST_SHAPE
  ;-----------------------------------------------------------------------;
(defun
   DRAW_PIPE_SHAPE (/ ENT1 ENT2)
  (command "circle" INSERT_PT "d" TEMP_DIST1)
  (setq ENT1 (entlast))
  (command "circle" INSERT_PT "d" TEMP_DIST2)
  (setq ENT2 (entlast))
  (if (= WHICH_VIEW "3d_solid")
    (progn
      (command "extrude" ENT1 "" LGTH "")
      (setq ENT1 (entlast))
      (command "extrude" ENT2 "" LGTH "")
      (setq ENT2 (entlast))
      (command "subtract" ENT1 "" ENT2 "")
    ) ;_ end of progn
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_surface")
    (progn
      (command "erase" ENT2 "")
      (command "change" ENT1 "" "p" "t" LGTH "")
    ) ;_ end of progn
  ) ;_ end of if
) ;end DRAW_PIPE_SHAPE
  ;-----------------------------------------------------------------------;
(defun
   DRAW_TS_SHAPE (/ R1 R2 OD_VERT OD_HORIZ ID_VERT ID_HORIZ PT1 PT2 PT3
                  PT4 PT5 PT6 PT7 PT8 PT9 PT10 PT11 PT12 PT13 PT14 PT15
                  PT16 PT17 PT18 PT19 PT20 PT21 PT22 PT23 PT24 ENT1 ENT2
                 )
  (setq
    R1 TUBE_THICK
    R2 (* TUBE_THICK 2)
    OD_VERT TUBE_VERT
    OD_HORIZ TUBE_HORIZ
    ID_VERT
     (- TUBE_VERT (* TUBE_THICK 2))
    ID_HORIZ
     (- TUBE_HORIZ (* TUBE_THICK 2))
    PT1
     (polar INSERT_PT (DTR 90) (/ OD_VERT 2))
    PT2
     (polar PT1 (DTR 270) R2)
    PT3
     (polar PT1 (DTR 0) R2)
    PT4
     (polar PT1 (DTR 0) OD_HORIZ)
    PT5
     (polar PT4 (DTR 180) R2)
    PT6
     (polar PT4 (DTR 270) R2)
    PT7
     (polar PT4 (DTR 270) OD_VERT)
    PT8
     (polar PT7 (DTR 90) R2)
    PT9
     (polar PT7 (DTR 180) R2)
    PT10
     (polar PT7 (DTR 180) OD_HORIZ)
    PT11
     (polar PT10 (DTR 0) R2)
    PT12
     (polar PT10 (DTR 90) R2)
    PT13
     (polar PT2 (DTR 0) TUBE_THICK)
    PT14
     (polar PT13 (DTR 90) R1)
    PT15
     (polar PT14 (DTR 0) R1)
    PT16
     (polar PT14 (DTR 0) ID_HORIZ)
    PT17
     (polar PT16 (DTR 180) R1)
    PT18
     (polar PT16 (DTR 270) R1)
    PT19
     (polar PT16 (DTR 270) ID_VERT)
    PT20
     (polar PT19 (DTR 90) R1)
    PT21
     (polar PT19 (DTR 180) R1)
    PT22
     (polar PT19 (DTR 180) ID_HORIZ)
    PT23
     (polar PT22 (DTR 0) R1)
    PT24
     (polar PT22 (DTR 90) R1)
  ) ;end setq
  (command
    "pline" INSERT_PT PT2 "arc" "d" PT1 PT3 "line" PT5 "arc" "d" PT4 PT6
    "line" PT8 "arc" "d" PT7 PT9 "line" PT11 "arc" "d" PT10 PT12 "line"
    INSERT_PT ""
   ) ;_ end of command
  (setq ENT1 (entlast))
  (command
    "pline" PT13 "arc" "d" PT14 PT15 "line" PT17 "arc" "d" PT16 PT18
    "line" PT20 "arc" "d" PT19 PT21 "line" PT23 "arc" "d" PT22 PT24
    "line" PT13 ""
   ) ;_ end of command
  (setq ENT2 (entlast))
  (if (= WHICH_VIEW "2d_end")
    (command "rotate" ENT1 ENT2 "" INSERT_PT)
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_solid")
    (progn
      (command "extrude" ENT1 "" LGTH "")
      (setq ENT1 (entlast))
      (command "extrude" ENT2 "" LGTH "")
      (setq ENT2 (entlast))
      (command "subtract" ENT1 "" ENT2 "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_surface")
    (progn
      (command "erase" ENT2 "")
      (command "change" ENT1 "" "p" "t" LGTH "")
      (command "rotate" ENT1 "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
) ;end DRAW_TS_SHAPE
  ;-----------------------------------------------------------------------;
(defun
   DRAW_PIPE_SHAPE_TOP (/ PT1 PT2 PT3 PT4 PT5 PT6 PT7 PT8 ENT1 ENT2)
  (setq
    PT1 (polar INSERT_PT (DTR 90) (/ TEMP_DIST1 2))
    PT2 (polar PT1 (DTR 0) LGTH)
    PT3 (polar PT2 (DTR 270) TEMP_DIST1)
    PT4 (polar PT3 (DTR 180) LGTH)
    PT5 (polar INSERT_PT (DTR 90) (/ TEMP_DIST2 2))
    PT6 (polar PT5 (DTR 0) LGTH)
    PT7 (polar PT6 (DTR 270) TEMP_DIST2)
    PT8 (polar PT7 (DTR 180) LGTH)
  ) ;end setq
  (command "pline" INSERT_PT PT1 PT2 PT3 PT4 INSERT_PT "")
  (setq ENT1 (entlast))
  (command "pline" PT5 PT6 PT7 PT8 "")
  (setq ENT2 (entlast))
  (command "chprop" ENT2 "" "lt" "hidden" "")
  (command "rotate" ENT1 ENT2 "" INSERT_PT)
) ;end DRAW_PIPE_SHAPE_TOP
  ;-----------------------------------------------------------------------;
(defun
   DRAW_TS_SHAPE_TOP (/ PT1 PT2 PT3 PT4 PT5 PT6 PT7 PT8 ENT1 ENT2)
  (setq
    PT1 (polar INSERT_PT (DTR 90) (/ TUBE_HORIZ 2))
    PT2 (polar PT1 (DTR 0) LGTH)
    PT3 (polar PT2 (DTR 270) TUBE_HORIZ)
    PT4 (polar PT3 (DTR 180) LGTH)
    PT5 (polar PT1 (DTR 270) TUBE_THICK)
    PT6 (polar PT5 (DTR 0) LGTH)
    PT7 (polar PT3 (DTR 90) TUBE_THICK)
    PT8 (polar PT7 (DTR 180) LGTH)
  ) ;end setq
  (command "pline" INSERT_PT PT1 PT2 PT3 PT4 INSERT_PT "")
  (setq ENT1 (entlast))
  (command "pline" PT5 PT6 PT7 PT8 "")
  (setq ENT2 (entlast))
  (command "chprop" ENT2 "" "lt" "hidden" "")
  (command "rotate" ENT1 ENT2 "" INSERT_PT)
) ;end DRAW_TS_SHAPE_TOP
  ;-----------------------------------------------------------------------;
(defun
   DRAW_TS_SHAPE_SIDE (/ PT1 PT2 PT3 PT4 PT5 PT6 PT7 PT8 ENT1 ENT2)
  (setq
    PT1 (polar INSERT_PT (DTR 90) (/ TUBE_VERT 2))
    PT2 (polar PT1 (DTR 0) LGTH)
    PT3 (polar PT2 (DTR 270) TUBE_VERT)
    PT4 (polar PT3 (DTR 180) LGTH)
    PT5 (polar PT1 (DTR 270) TUBE_THICK)
    PT6 (polar PT5 (DTR 0) LGTH)
    PT7 (polar PT3 (DTR 90) TUBE_THICK)
    PT8 (polar PT7 (DTR 180) LGTH)
  ) ;end setq
  (command "pline" INSERT_PT PT1 PT2 PT3 PT4 INSERT_PT "")
  (setq ENT1 (entlast))
  (command "pline" PT5 PT6 PT7 PT8 "")
  (setq ENT2 (entlast))
  (command "chprop" ENT2 "" "lt" "hidden" "")
  (command "rotate" ENT1 ENT2 "" INSERT_PT)
) ;end DRAW_TS_SHAPE_TOP
  ;-----------------------------------------------------------------------;
(defun
   DRAW_FORM_ANG_SHAPE (/ R PT1 PT2 PT3 PT4 PT5 PT6 PT7 PT8 PT9)
  (setq
    R   (* FORMANGTHK 2)
    PT1 (polar INSERT_PT (DTR 0) R)
    PT2 (polar INSERT_PT (DTR 0) FORMANGHORIZ)
    PT3 (polar PT2 (DTR 90) FORMANGTHK)
    PT4 (polar PT1 (DTR 90) FORMANGTHK)
    PT5 (polar PT4 (DTR 180) FORMANGTHK)
    PT6 (polar PT5 (DTR 90) FORMANGTHK)
    PT7 (polar INSERT_PT (DTR 90) R)
    PT8 (polar INSERT_PT (DTR 90) FORMANGVERT)
    PT9 (polar PT8 (DTR 0) FORMANGTHK)
  ) ;end setq
  (command
    "pline" PT1 PT2 PT3 PT4 "a" "d" PT5 PT6 "line" PT9 PT8 PT7 "a" "d"
    INSERT_PT PT1 ""
   ) ;_ end of command
  (if (= WHICH_VIEW "2d_end")
    (command "rotate" "l" "" INSERT_PT)
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_solid")
    (progn
      (command "extrude" "l" "" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_surface")
    (progn
      (command "change" "l" "" "p" "t" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
) ;end DRAW_FORM_ANG_SHAPE
  ;-----------------------------------------------------------------------;
(defun
   DRAW_FORM_CHANN_SHAPE (/ R PT1 PT2 PT3 PT4 PT5 PT6 PT7 PT8 PT9 PT10
                          PT11 PT12 PT13 PT14 PT15
                         )
  (setq
    R    (* FORMCHANNTHK 2)
    PT1  (polar INSERT_PT (DTR 0) R)
    PT2  (polar INSERT_PT (DTR 0) FORMCHANNBOTT)
    PT3  (polar PT2 (DTR 90) FORMCHANNTHK)
    PT4  (polar PT1 (DTR 90) FORMCHANNTHK)
    PT5  (polar PT4 (DTR 180) FORMCHANNTHK)
    PT6  (polar PT5 (DTR 90) FORMCHANNTHK)
    PT7  (polar INSERT_PT (DTR 90) R)
    PT8  (polar INSERT_PT (DTR 90) FORMCHANNWEB)
    PT9  (polar PT8 (DTR 270) R)
    PT10 (polar PT9 (DTR 0) FORMCHANNTHK)
    PT11 (polar PT10 (DTR 90) FORMCHANNTHK)
    PT12 (polar PT11 (DTR 0) FORMCHANNTHK)
    PT13 (polar PT12 (DTR 90) FORMCHANNTHK)
    PT14 (polar PT8 (DTR 0) FORMCHANNTOP)
    PT15 (polar PT14 (DTR 270) FORMCHANNTHK)
  ) ;end setq
  (command
    "pline" PT1 PT2 PT3 PT4 "a" "d" PT5 PT6 "line" PT10 "a" "d" PT11
    PT12 "line" PT15 PT14 PT13 "a" "d" PT8 PT9 "line" PT7 "a" "d"
    INSERT_PT PT1 ""
   ) ;_ end of command
  (if (= WHICH_VIEW "2d_end")
    (command "rotate" "l" "" INSERT_PT)
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_solid")
    (progn
      (command "extrude" "l" "" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_surface")
    (progn
      (command "change" "l" "" "p" "t" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
) ;end DRAW_FORM_CHANN_SHAPE
  ;-----------------------------------------------------------------------;
(defun
   DRAW_FORM_ZEE_SHAPE (/ R PT1 PT2 PT3 PT4 PT5 PT6 PT7 PT8 PT9 PT10
                        PT11 PT12 PT13 PT14 PT15
                       )
  (setq
    R    (* FORMZEETHK 2)
    PT1  (polar INSERT_PT (DTR 0) R)
    PT2  (polar INSERT_PT (DTR 0) FORMZEEBOTT)
    PT3  (polar PT2 (DTR 90) FORMZEETHK)
    PT4  (polar PT1 (DTR 90) FORMZEETHK)
    PT5  (polar PT4 (DTR 180) FORMZEETHK)
    PT6  (polar PT5 (DTR 90) FORMZEETHK)
    PT7  (polar INSERT_PT (DTR 90) R)
    PT8  (polar INSERT_PT (DTR 90) FORMZEEWEB)
    PT9  (polar PT8 (DTR 270) FORMZEETHK)
    PT10 (polar PT9 (DTR 270) FORMZEETHK)
    PT11 (polar PT10 (DTR 0) FORMZEETHK)
    PT12 (polar PT11 (DTR 90) R)
    PT13 (polar PT12 (DTR 180) R)
    PT14 (polar PT13 (DTR 270) FORMZEETHK)
    PT15 (polar PT12 (DTR 180) FORMZEETOP)
    PT16 (polar PT15 (DTR 270) FORMZEETHK)
  ) ;end setq
  (command
    "pline" PT1 PT2 PT3 PT4 "a" "d" PT5 PT6 "line" PT11 "a" "d" PT12
    PT13 "line" PT15 PT16 PT14 "a" "d" PT9 PT10 "line" PT7 "a" "d"
    INSERT_PT PT1 ""
   ) ;_ end of command
  (if (= WHICH_VIEW "2d_end")
    (command "rotate" "l" "" INSERT_PT)
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_solid")
    (progn
      (command "extrude" "l" "" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
  (if (= WHICH_VIEW "3d_surface")
    (progn
      (command "change" "l" "" "p" "t" LGTH "")
      (command "rotate" "l" "" INSERT_PT)
    ) ;_ end of progn
  ) ;_ end of if
) ;end DRAW_FORM_ZEE_SHAPE
  ;-----------------------------------------------------------------------;
(defun
   STL_DEFAULTS () ;Set defaults
  (set_tile "stl_met_scale" "0")
  (mode_tile "stl_met_scale" 1)
  (mode_tile "length" 1)
  (if (/= STL_DEF_NEWTILE NIL)
    (setq NEWTILE STL_DEF_NEWTILE)
  ) ;_ end of if
  (if (/= STL_DEF_DISPLAY_LIST NIL)
    (progn
      (setq DISPLAY_LIST STL_DEF_DISPLAY_LIST)
      (start_list "get_size")
      (mapcar 'add_list DISPLAY_LIST)
      (end_list)
    ) ;_ end of progn
  ) ;_ end of if
  (if (/= STL_DEF_SIZE NIL)
    (setq SIZE STL_DEF_SIZE)
  ) ;_ end of if
  (if (/= STL_DEF_INDEX NIL)
    (setq INDEX STL_DEF_INDEX)
  ) ;_ end of if
  (if (/= STL_DEF_D NIL)
    (setq D STL_DEF_D)
  ) ;_ end of if
  (if (/= STL_DEF_TW NIL)
    (setq TW STL_DEF_TW)
  ) ;_ end of if
  (if (/= STL_DEF_BF NIL)
    (setq BF STL_DEF_BF)
  ) ;_ end of if
  (if (/= STL_DEF_TF NIL)
    (setq TF STL_DEF_TF)
  ) ;_ end of if
  (if (/= STL_DEF_K NIL)
    (setq K STL_DEF_K)
  ) ;_ end of if
  (if (/= STL_DEF_TEMP_DIST1 NIL)
    (setq TEMP_DIST1 STL_DEF_TEMP_DIST1)
  ) ;_ end of if
  (if (/= STL_DEF_TEMP_DIST2 NIL)
    (setq TEMP_DIST2 STL_DEF_TEMP_DIST2)
  ) ;_ end of if
  (if (/= STL_DEF_L_VERT NIL)
    (setq L_VERT STL_DEF_L_VERT)
  ) ;_ end of if
  (if (/= STL_DEF_L_HORIZ NIL)
    (setq L_HORIZ STL_DEF_L_HORIZ)
  ) ;_ end of if
  (if (/= STL_DEF_L_THICK NIL)
    (setq L_THICK STL_DEF_L_THICK)
  ) ;_ end of if
  (if (/= STL_DEF_TUBE_VERT NIL)
    (setq TUBE_VERT STL_DEF_TUBE_VERT)
  ) ;_ end of if
  (if (/= STL_DEF_TUBE_HORIZ NIL)
    (setq TUBE_HORIZ STL_DEF_TUBE_HORIZ)
  ) ;_ end of if
  (if (/= STL_DEF_TUBE_THICK NIL)
    (setq TUBE_THICK STL_DEF_TUBE_THICK)
  ) ;_ end of if
  (if (/= STL_DEF_SCALE NIL)
    (setq SCALE STL_DEF_SCALE)
  ) ;_ end of if
  (if (/= STL_DEF_LGTH NIL)
    (setq LGTH (atof STL_DEF_LGTH))
  ) ;_ end of if
  (if (/= STL_DEF_DEPTHDIM NIL)
    (set_tile "depth" STL_DEF_DEPTHDIM)
  ) ;_ end of if
  (if (/= STL_DEF_WEBDIM NIL)
    (set_tile "web" STL_DEF_WEBDIM)
  ) ;_ end of if
  (if (/= STL_DEF_WIDTHDIM NIL)
    (set_tile "width" STL_DEF_WIDTHDIM)
  ) ;_ end of if
  (if (/= STL_DEF_FLANGEDIM NIL)
    (set_tile "flange" STL_DEF_FLANGEDIM)
  ) ;_ end of if
  (if (/= STL_DEF_KDIM NIL)
    (set_tile "k_dim" STL_DEF_KDIM)
  ) ;_ end of if
  (if (/= STL_DEF_OD_PIPEDIM NIL)
    (set_tile "od_pipe" STL_DEF_OD_PIPEDIM)
  ) ;_ end of if
  (if (/= STL_DEF_ID_PIPEDIM NIL)
    (set_tile "id_pipe" STL_DEF_ID_PIPEDIM)
  ) ;_ end of if
  (if (/= STL_DEF_DEPTH_TUBEDIM NIL)
    (set_tile "depth_tube" STL_DEF_DEPTH_TUBEDIM)
  ) ;_ end of if
  (if (/= STL_DEF_WIDTH_TUBEDIM NIL)
    (set_tile "width_tube" STL_DEF_WIDTH_TUBEDIM)
  ) ;_ end of if
  (if (/= STL_DEF_THK_TUBEDIM NIL)
    (set_tile "thk_tube" STL_DEF_THK_TUBEDIM)
  ) ;_ end of if
  (if (= STL_DEF_2DEND "1")
    (set_tile "2d_end" STL_DEF_2DEND)
  ) ;_ end of if
  (if (= STL_DEF_2DEND NIL)
    (set_tile "2d_end" "1")
  ) ;_ end of if
  (if (/= STL_DEF_WHICH_VIEW NIL)
    (setq WHICH_VIEW STL_DEF_WHICH_VIEW)
  ) ;_ end of if
  (if (= STL_DEF_WHICH_VIEW NIL)
    (setq WHICH_VIEW "2d_end")
  ) ;_ end of if
  (if (/= STL_DEF_LGTH NIL)
    (set_tile "length" STL_DEF_LGTH)
  ) ;_ end of if
  (if (= STL_DEF_LGTH NIL)
    (set_tile "length" "1")
  ) ;_ end of if
  (if (= STL_DEF_2DTOP "1")
    (progn
      (set_tile "2d_top" STL_DEF_2DTOP)
      (set_tile "length" STL_DEF_LGTH)
      (mode_tile "length" 0)
      (mode_tile "length" 2)
    ) ;_ end of progn
  ) ;_ end of if
  (if (= STL_DEF_2DTOP NIL)
    (set_tile "2d_top" "0")
  ) ;_ end of if
  (if (= STL_DEF_2DSIDE "1")
    (progn
      (set_tile "2d_side" STL_DEF_2DSIDE)
      (set_tile "length" STL_DEF_LGTH)
      (mode_tile "length" 0)
      (mode_tile "length" 2)
    ) ;_ end of progn
  ) ;_ end of if
  (if (= STL_DEF_2DSIDE NIL)
    (set_tile "2d_side" "0")
  ) ;_ end of if
  (if (= STL_DEF_3DSOLID "1")
    (progn
      (set_tile "3d_solid" STL_DEF_3DSOLID)
      (set_tile "length" STL_DEF_LGTH)
      (mode_tile "length" 0)
      (mode_tile "length" 2)
    ) ;_ end of progn
  ) ;_ end of if
  (if (= STL_DEF_3DSOLID NIL)
    (set_tile "3d_solid" "0")
  ) ;_ end of if
  (if (= STL_DEF_3DSURFACE "1")
    (progn
      (set_tile "3d_surface" STL_DEF_3DSURFACE)
      (set_tile "length" STL_DEF_LGTH)
      (mode_tile "length" 0)
      (mode_tile "length" 2)
    ) ;_ end of progn
  ) ;_ end of if
  (if (= STL_DEF_3DSURFACE NIL)
    (set_tile "3d_surface" "0")
  ) ;_ end of if
  (if (= STL_DEF_METSCALE "1")
    (set_tile "stl_met_scale" STL_DEF_METSCALE)
  ) ;_ end of if
  (if (= STL_DEF_METSCALE NIL)
    (set_tile "stl_met_scale" "0")
  ) ;_ end of if
  (if (or (= NEWTILE "met_w_shape")
          (= NEWTILE "met_r_shape")
          (= NEWTILE "met_c_shape")
          (= NEWTILE "met_a_shape")
      ) ;_ end of or
    (mode_tile "stl_met_scale" 0)
  ) ;_ end of if
) ;end STL_DEFAULTS
  ;--------------------------------------------------------------------;
(defun
   STL_CHECK_SELECTIONS () ;First save defaults
  (setq
    STL_DEF_NEWTILE NEWTILE
    STL_DEF_SIZE SIZE
    STL_DEF_WHICH_VIEW WHICH_VIEW
    STL_DEF_DISPLAY_LIST DISPLAY_LIST
    STL_DEF_INDEX INDEX
    STL_DEF_D D
    STL_DEF_TW TW
    STL_DEF_BF BF
    STL_DEF_TF TF
    STL_DEF_K K
    STL_DEF_TEMP_DIST1 TEMP_DIST1
    STL_DEF_TEMP_DIST2 TEMP_DIST2
    STL_DEF_L_VERT L_VERT
    STL_DEF_L_HORIZ L_HORIZ
    STL_DEF_L_THICK L_THICK
    STL_DEF_TUBE_VERT TUBE_VERT
    STL_DEF_TUBE_HORIZ TUBE_HORIZ
    STL_DEF_TUBE_THICK TUBE_THICK
    STL_DEF_SCALE SCALE
    STL_DEF_DEPTHDIM
     (get_tile "depth")
    STL_DEF_WEBDIM
     (get_tile "web")
    STL_DEF_WIDTHDIM
     (get_tile "width")
    STL_DEF_FLANGEDIM
     (get_tile "flange")
    STL_DEF_KDIM
     (get_tile "k_dim")
    STL_DEF_OD_PIPEDIM
     (get_tile "od_pipe")
    STL_DEF_ID_PIPEDIM
     (get_tile "id_pipe")
    STL_DEF_DEPTH_TUBEDIM
     (get_tile "depth_tube")
    STL_DEF_WIDTH_TUBEDIM
     (get_tile "width_tube")
    STL_DEF_THK_TUBEDIM
     (get_tile "thk_tube")
    STL_DEF_2DEND
     (get_tile "2d_end")
    STL_DEF_2DTOP
     (get_tile "2d_top")
    STL_DEF_2DSIDE
     (get_tile "2d_side")
    STL_DEF_3DSOLID
     (get_tile "3d_solid")
    STL_DEF_3DSURFACE
     (get_tile "3d_surface")
    STL_DEF_LGTH
     (get_tile "length")
    STL_DEF_METSCALE
     (get_tile "stl_met_scale")
  ) ;end setq
  ;Then check selections
  (if (= NEWTILE NIL)
    (alert "OOPS! SELECT A SHAPE TYPE - TRY AGAIN!")
  ) ;_ end of if
  (if (and (/= NEWTILE NIL) (= SIZE NIL))
    (alert "OOPS! SELECT A SHAPE SIZE - TRY AGAIN!")
  ) ;_ end of if
  (if (and (/= NEWTILE NIL) (/= SIZE NIL))
    (done_dialog)
  ) ;_ end of if
) ;end STL_CHECK_SELECTIONS
  ;--------------------------------------------------------------------;
(defun
   STL_HELP ()
  (if (= STL_HELP_LIST NIL)
    (progn
      (setq LINE "")
      (setq HELPFILE (open (findfile "stl_help.txt") "r"))
      (while (/= LINE NIL)
        (setq LINE (read-line HELPFILE))
        (if (/= LINE NIL)
          (setq STL_HELP_LIST (append STL_HELP_LIST (list LINE)))
        ) ;end if
      ) ;end while /= line nil
      (close HELPFILE)
    ) ;end progn
  ) ;end = stl_help_list nil
  (setq DCL_ID (load_dialog (findfile "stl.dcl")))
  (if (not (new_dialog "stl_help" DCL_ID ""))
    (exit)
  ) ;_ end of if
  (start_list "stl_help")
  (mapcar 'add_list STL_HELP_LIST)
  (end_list)
  (start_dialog)
  (unload_dialog DCL_ID)
) ;end STL_HELP
  ;-----------------------------------------------------------------------;
(defun
   OPEN_FORM_DIALOG ()
  (setq DISPLAY_LIST NIL)
  (start_list "get_size")
  (mapcar 'add_list DISPLAY_LIST)
  (end_list)
  (if (= NEWTILE "form_ang_shape")
    (STL_FORM_ANG_DIALOG)
  ) ;_ end of if
  (if (= NEWTILE "form_chann_shape")
    (STL_FORM_CHANN_DIALOG)
  ) ;_ end of if
  (if (= NEWTILE "form_zee_shape")
    (STL_FORM_ZEE_DIALOG)
  ) ;_ end of if
) ;end OPEN_FORM_DIALOG
  ;-----------------------------------------------------------------------;
(defun
   STL_FORM_ANG_DIALOG ()
  (setq DCL_ID (load_dialog (findfile "stl.dcl")))
  (if (not (new_dialog "stl_form_ang_dialog" DCL_ID))
    (exit)
  ) ;_ end of if
  (STL_FORM_ANG_DEFAULTS)
  (action_tile "form_ang_horiz" "(setq formanghoriz (atof $value))")
  (action_tile "form_ang_vert" "(setq formangvert (atof $value))")
  (action_tile "form_ang_thk" "(setq formangthk (atof $value))")
  (action_tile "accept" "(check_form_ang_selections)")
  (action_tile
    "cancel"
    (strcat
      "(setq formanghoriz nil
                                     formangvert nil
                                     formangthk nil)"
      "(stl_defaults)"
      "(done_dialog)"
    ) ;_ end of strcat
  ) ;_ end of action_tile
  (start_dialog)
  (unload_dialog DCL_ID)
) ;end STL_FORM_ANG_DIALOG
  ;-----------------------------------------------------------------------;
(defun
   STL_FORM_ANG_DEFAULTS ()
  (if (= STL_DEF_FORMANGHORIZ NIL)
    (mode_tile "form_ang_horiz" 2)
  ) ;_ end of if
  (if (/= STL_DEF_NEWTILE NIL)
    (setq NEWTILE "form_ang_shape")
  ) ;_ end of if
  (if (/= STL_DEF_FORMANGHORIZ NIL)
    (progn
      (setq FORMANGHORIZ (atof STL_DEF_FORMANGHORIZ))
      (set_tile "form_ang_horiz" STL_DEF_FORMANGHORIZ)
      (mode_tile "form_ang_horiz" 2)
    ) ;_ end of progn
  ) ;_ end of if
  (if (/= STL_DEF_FORMANGVERT NIL)
    (progn
      (setq FORMANGVERT (atof STL_DEF_FORMANGVERT))
      (set_tile "form_ang_vert" STL_DEF_FORMANGVERT)
    ) ;_ end of progn
  ) ;_ end of if
  (if (/= STL_DEF_FORMANGTHK NIL)
    (progn
      (setq FORMANGTHK (atof STL_DEF_FORMANGTHK))
      (set_tile "form_ang_thk" STL_DEF_FORMANGTHK)
    ) ;_ end of progn
  ) ;_ end of if
) ;end STL_FORM_ANG_DEFAULTS
  ;--------------------------------------------------------------------;
(defun
   CHECK_FORM_ANG_SELECTIONS () ;First save defaults
  (setq
    STL_DEF_FORMANGHORIZ
     (get_tile "form_ang_horiz")
    STL_DEF_FORMANGVERT
     (get_tile "form_ang_vert")
    STL_DEF_FORMANGTHK
     (get_tile "form_ang_thk")
    SIZE FORMANGHORIZ
  ) ;end setq
  ;Then check selections
  (if (or (= FORMANGHORIZ NIL) (= FORMANGVERT NIL) (= FORMANGTHK NIL))
    (alert "OOPS! DIMENSION MISSING - TRY AGAIN!")
  ) ;_ end of if
  (if
    (and (/= FORMANGHORIZ NIL) (/= FORMANGVERT NIL) (/= FORMANGTHK NIL))
     (done_dialog)
  ) ;_ end of if
) ;end CHECK_FORM_ANG_SELECTIONS
  ;--------------------------------------------------------------------;
(defun
   STL_FORM_CHANN_DIALOG ()
  (setq DCL_ID (load_dialog (findfile "stl.dcl")))
  (if (not (new_dialog "stl_form_chann_dialog" DCL_ID))
    (exit)
  ) ;_ end of if
  (STL_FORM_CHANN_DEFAULTS)
  (action_tile "form_chann_bott" "(setq formchannbott (atof $value))")
  (action_tile "form_chann_top" "(setq formchanntop (atof $value))")
  (action_tile "form_chann_web" "(setq formchannweb (atof $value))")
  (action_tile "form_chann_thk" "(setq formchannthk (atof $value))")
  (action_tile "accept" "(check_form_chann_selections)")
  (action_tile
    "cancel"
    (strcat
      "(setq formchannbott nil
                                     formchanntop nil
                                     formchannweb nil
                                     formchannthk nil)"
      "(stl_defaults)"
      "(done_dialog)"
    ) ;_ end of strcat
  ) ;_ end of action_tile
  (start_dialog)
  (unload_dialog DCL_ID)
) ;end STL_FORM_CHANN_DIALOG
  ;-----------------------------------------------------------------------;
(defun
   STL_FORM_CHANN_DEFAULTS ()
  (if (= STL_DEF_FORMCHANNBOTT NIL)
    (mode_tile "form_chann_bott" 2)
  ) ;_ end of if
  (if (/= STL_DEF_NEWTILE NIL)
    (setq NEWTILE "form_chann_shape")
  ) ;_ end of if
  (if (/= STL_DEF_FORMCHANNBOTT NIL)
    (progn
      (setq FORMCHANNBOTT (atof STL_DEF_FORMCHANNBOTT))
      (set_tile "form_chann_bott" STL_DEF_FORMCHANNBOTT)
      (mode_tile "form_chann_bott" 2)
    ) ;_ end of progn
  ) ;_ end of if
  (if (/= STL_DEF_FORMCHANNTOP NIL)
    (progn
      (setq FORMCHANNTOP (atof STL_DEF_FORMCHANNTOP))
      (set_tile "form_chann_top" STL_DEF_FORMCHANNTOP)
    ) ;_ end of progn
  ) ;_ end of if
  (if (/= STL_DEF_FORMCHANNWEB NIL)
    (progn
      (setq FORMCHANNWEB (atof STL_DEF_FORMCHANNWEB))
      (set_tile "form_chann_web" STL_DEF_FORMCHANNWEB)
    ) ;_ end of progn
  ) ;_ end of if
  (if (/= STL_DEF_FORMCHANNTHK NIL)
    (progn
      (setq FORMCHANNTHK (atof STL_DEF_FORMCHANNTHK))
      (set_tile "form_chann_thk" STL_DEF_FORMCHANNTHK)
    ) ;_ end of progn
  ) ;_ end of if
) ;end STL_FORM_CHANN_DEFAULTS
  ;--------------------------------------------------------------------;
(defun
   CHECK_FORM_CHANN_SELECTIONS () ;First save defaults
  (setq
    STL_DEF_FORMCHANNBOTT
     (get_tile "form_chann_bott")
    STL_DEF_FORMCHANNTOP
     (get_tile "form_chann_top")
    STL_DEF_FORMCHANNWEB
     (get_tile "form_chann_web")
    STL_DEF_FORMCHANNTHK
     (get_tile "form_chann_thk")
    SIZE FORMCHANNBOTT
  ) ;end setq
  ;Then check selections
  (progn
    (if (or (= FORMCHANNBOTT NIL)
            (= FORMCHANNTOP NIL)
            (= FORMCHANNWEB NIL)
            (= FORMCHANNTHK NIL)
        ) ;_ end of or
      (alert "OOPS! DIMENSION MISSING - TRY AGAIN!")
    ) ;_ end of if
    (if (and
          (/= FORMCHANNBOTT NIL)
          (/= FORMCHANNTOP NIL)
          (/= FORMCHANNWEB NIL)
          (/= FORMCHANNTHK NIL)
        ) ;_ end of and
      (done_dialog)
    ) ;_ end of if
  ) ;end progn
) ;end CHECK_FORM_CHANN_SELECTIONS
  ;--------------------------------------------------------------------;
(defun
   STL_FORM_ZEE_DIALOG ()
  (setq DCL_ID (load_dialog (findfile "stl.dcl")))
  (if (not (new_dialog "stl_form_zee_dialog" DCL_ID))
    (exit)
  ) ;_ end of if
  (STL_FORM_ZEE_DEFAULTS)
  (action_tile "form_zee_bott" "(setq formzeebott (atof $value))")
  (action_tile "form_zee_top" "(setq formzeetop (atof $value))")
  (action_tile "form_zee_web" "(setq formzeeweb (atof $value))")
  (action_tile "form_zee_thk" "(setq formzeethk (atof $value))")
  (action_tile "accept" "(check_form_zee_selections)")
  (action_tile
    "cancel"
    (strcat
      "(setq formzeebott nil
                                     formzeetop nil
                                     formzeeweb nil
                                     formzeethk nil)"
      "(stl_defaults)"
      "(done_dialog)"
    ) ;_ end of strcat
  ) ;_ end of action_tile
  (start_dialog)
  (unload_dialog DCL_ID)
) ;end STL_FORM_ZEE_DIALOG
  ;-----------------------------------------------------------------------;
(defun
   STL_FORM_ZEE_DEFAULTS ()
  (if (= STL_DEF_FORMZEEBOTT NIL)
    (mode_tile "form_zee_bott" 2)
  ) ;_ end of if
  (if (/= STL_DEF_NEWTILE NIL)
    (setq NEWTILE "form_zee_shape")
  ) ;_ end of if
  (if (/= STL_DEF_FORMZEEBOTT NIL)
    (progn
      (setq FORMZEEBOTT (atof STL_DEF_FORMZEEBOTT))
      (set_tile "form_zee_bott" STL_DEF_FORMZEEBOTT)
      (mode_tile "form_zee_bott" 2)
    ) ;_ end of progn
  ) ;_ end of if
  (if (/= STL_DEF_FORMZEETOP NIL)
    (progn
      (setq FORMZEETOP (atof STL_DEF_FORMZEETOP))
      (set_tile "form_zee_top" STL_DEF_FORMZEETOP)
    ) ;_ end of progn
  ) ;_ end of if
  (if (/= STL_DEF_FORMZEEWEB NIL)
    (progn
      (setq FORMZEEWEB (atof STL_DEF_FORMZEEWEB))
      (set_tile "form_zee_web" STL_DEF_FORMZEEWEB)
    ) ;_ end of progn
  ) ;_ end of if
  (if (/= STL_DEF_FORMZEETHK NIL)
    (progn
      (setq FORMZEETHK (atof STL_DEF_FORMZEETHK))
      (set_tile "form_zee_thk" STL_DEF_FORMZEETHK)
    ) ;_ end of progn
  ) ;_ end of if
) ;end STL_FORM_ZEE_DEFAULTS
  ;--------------------------------------------------------------------;
(defun
   CHECK_FORM_ZEE_SELECTIONS () ;First save defaults
  (setq
    STL_DEF_FORMZEEBOTT
     (get_tile "form_zee_bott")
    STL_DEF_FORMZEETOP
     (get_tile "form_zee_top")
    STL_DEF_FORMZEEWEB
     (get_tile "form_zee_web")
    STL_DEF_FORMZEETHK
     (get_tile "form_zee_thk")
    SIZE FORMZEEBOTT
  ) ;end setq
  ;Then check selections
  (progn
    (if (or (= FORMZEEBOTT NIL)
            (= FORMZEETOP NIL)
            (= FORMZEEWEB NIL)
            (= FORMZEETHK NIL)
        ) ;_ end of or
      (alert "OOPS! DIMENSION MISSING - TRY AGAIN!")
    ) ;_ end of if
    (if (and
          (/= FORMZEEBOTT NIL)
          (/= FORMZEETOP NIL)
          (/= FORMZEEWEB NIL)
          (/= FORMZEETHK NIL)
        ) ;_ end of and
      (done_dialog)
    ) ;_ end of if
  ) ;end progn
) ;end CHECK_FORM_ZEE_SELECTIONS
  ;--------------------------------------------------------------------;
(defun
   STL_DIALOG ()
  (setq DCL_ID (load_dialog "stl.dcl")) ;load the DCL file
  (if (not (new_dialog "stl" DCL_ID)) ;initialize the DCL file
    (exit) ;exit if this doesn't work
  ) ;end if
  (STL_DEFAULTS)
  (if (= STL_DEF_NEWTILE "form_ang_shape")
    (STL_FORM_ANG_DIALOG)
  ) ;_ end of if
  (if (= STL_DEF_NEWTILE "form_chann_shape")
    (STL_FORM_CHANN_DIALOG)
  ) ;_ end of if
  (if (= STL_DEF_NEWTILE "form_zee_shape")
    (STL_FORM_ZEE_DIALOG)
  ) ;_ end of if
  (action_tile
    "w_shape"
    (strcat "(setq newtile $key)" "(STL_READ_DIM_FILE)")
  ) ;_ end of action_tile
  (action_tile
    "m_shape"
    (strcat "(setq newtile $key)" "(STL_READ_DIM_FILE)")
  ) ;_ end of action_tile
  (action_tile
    "hp_shape"
    (strcat "(setq newtile $key)" "(STL_READ_DIM_FILE)")
  ) ;_ end of action_tile
  (action_tile
    "s_shape"
    (strcat "(setq newtile $key)" "(STL_READ_DIM_FILE)")
  ) ;_ end of action_tile
  (action_tile
    "c_shape"
    (strcat "(setq newtile $key)" "(STL_READ_DIM_FILE)")
  ) ;_ end of action_tile
  (action_tile
    "c_bar_shape"
    (strcat "(setq newtile $key)" "(STL_READ_DIM_FILE)")
  ) ;_ end of action_tile
  (action_tile
    "mc_shape"
    (strcat "(setq newtile $key)" "(STL_READ_DIM_FILE)")
  ) ;_ end of action_tile
  (action_tile
    "l_shape"
    (strcat "(setq newtile $key)" "(STL_READ_DIM_FILE)")
  ) ;_ end of action_tile
  (action_tile
    "wt_shape"
    (strcat "(setq newtile $key)" "(progn (STL_READ_DIM_FILE))")
  ) ;_ end of action_tile
  (action_tile
    "mt_shape"
    (strcat "(setq newtile $key)" "(STL_READ_DIM_FILE)")
  ) ;_ end of action_tile
  (action_tile
    "st_shape"
    (strcat "(setq newtile $key)" "(STL_READ_DIM_FILE)")
  ) ;_ end of action_tile
  (action_tile
    "std_pipe"
    (strcat "(setq newtile $key)" "(STL_READ_DIM_FILE)")
  ) ;_ end of action_tile
  (action_tile
    "xs_pipe"
    (strcat "(setq newtile $key)" "(STL_READ_DIM_FILE)")
  ) ;_ end of action_tile
  (action_tile
    "xxs_pipe"
    (strcat "(setq newtile $key)" "(STL_READ_DIM_FILE)")
  ) ;_ end of action_tile
  (action_tile
    "tube_round"
    (strcat "(setq newtile $key)" "(STL_READ_DIM_FILE)")
  ) ;_ end of action_tile
  (action_tile
    "ts_square"
    (strcat "(setq newtile $key)" "(STL_READ_DIM_FILE)")
  ) ;_ end of action_tile
  (action_tile
    "ts_rect"
    (strcat "(setq newtile $key)" "(STL_READ_DIM_FILE)")
  ) ;_ end of action_tile
  (action_tile
    "met_w_shape"
    (strcat
      "(setq newtile $key)"
      "(STL_READ_DIM_FILE)"
      "(mode_tile \"stl_met_scale\" 0)"
    ) ;_ end of strcat
  ) ;_ end of action_tile
  (action_tile
    "met_r_shape"
    (strcat
      "(setq newtile $key)"
      "(STL_READ_DIM_FILE)"
      "(mode_tile \"stl_met_scale\" 0)"
    ) ;_ end of strcat
  ) ;_ end of action_tile
  (action_tile
    "met_c_shape"
    (strcat
      "(setq newtile $key)"
      "(STL_READ_DIM_FILE)"
      "(mode_tile \"stl_met_scale\" 0)"
    ) ;_ end of strcat
  ) ;_ end of action_tile
  (action_tile
    "met_a_shape"
    (strcat
      "(setq newtile $key)"
      "(STL_READ_DIM_FILE)"
      "(mode_tile \"stl_met_scale\" 0)"
    ) ;_ end of strcat
  ) ;_ end of action_tile
  (action_tile
    "form_ang_shape"
    (strcat "(setq newtile $key)" "(open_form_dialog)")
  ) ;_ end of action_tile
  (action_tile
    "form_chann_shape"
    (strcat "(setq newtile $key)" "(open_form_dialog)")
  ) ;_ end of action_tile
  (action_tile
    "form_zee_shape"
    (strcat "(setq newtile $key)" "(open_form_dialog)")
  ) ;_ end of action_tile
  (action_tile
    "get_size"
    (strcat
      "(setq index (atoi $value))"
      "(setq size (strcase (nth index display_list)))"
      "(STL_DIM_LIST)"
    ) ;_ end of strcat
  ) ;_ end of action_tile
  (action_tile
    "2d_end"
    (strcat "(setq which_view $key)" "(mode_tile \"length\" 1)")
  ) ;_ end of action_tile
  (action_tile
    "2d_top"
    (strcat
      "(setq which_view $key)"
      "(mode_tile \"length\" 0)"
      "(mode_tile \"length\" 2)"
    ) ;_ end of strcat
  ) ;_ end of action_tile
  (action_tile
    "2d_side"
    (strcat
      "(setq which_view $key)"
      "(mode_tile \"length\" 0)"
      "(mode_tile \"length\" 2)"
    ) ;_ end of strcat
  ) ;_ end of action_tile
  (action_tile
    "3d_solid"
    (strcat
      "(setq which_view $key)"
      "(mode_tile \"length\" 0)"
      "(mode_tile \"length\" 2)"
    ) ;_ end of strcat
  ) ;_ end of action_tile
  (action_tile
    "3d_surface"
    (strcat
      "(setq which_view $key)"
      "(mode_tile \"length\" 0)"
      "(mode_tile \"length\" 2)"
    ) ;_ end of strcat
  ) ;_ end of action_tile
  (action_tile "length" "(setq lgth (distof $value 2))")
  (action_tile
    "stl_met_scale"
    (strcat "(setq scale $value)" "(if (/= size nil) (STL_DIM_LIST))")
  ) ;_ end of action_tile
  (action_tile "accept" "(STL_CHECK_SELECTIONS)")
  (action_tile
    "cancel"
    (strcat "(done_dialog)" "(setq newtile nil size nil)" "(exit)")
  ) ;_ end of action_tile
  (action_tile "stl_help" "(stl_help)")
  (start_dialog) ;display the dialog box
  (unload_dialog DCL_ID) ;unload the DCL file
) ;end STL_DIALOG
  ;--------------------------------------------------------------------;
(defun
   C:CPack_SteelMill (/ NEWTILE SIZE WHICH_VIEW DISPLAY_LIST INDEX D TW BF TF K
          TEMP_DIST1 TEMP_DIST2 L_VERT L_HORIZ L_THICK TUBE_VERT
          TUBE_HORIZ TUBE_THICK STL_DIM_FILE
         )
  (setq
    OLDERR *ERROR*
    *ERROR* STL_ERR
  ) ;_ end of setq
  (setq OS (getvar "OSMODE"))
  (setq PLW (getvar "PLINEWID"))
  (setvar "OSMODE" 111)
  (setvar "PLINEWID" 0)
  (STL_DIALOG)
  (DRAW_SHAPE)
  (setvar "PLINEWID" PLW)
  (setvar "OSMODE" OS)
  (setq *ERROR* OLDERR) ; Restore old *error* handler
  (princ)
) ;end STL
  ;Print message once loaded.
(princ "\nStak Tools STEEL MILL Loaded. Type STL to use.")
(princ)


