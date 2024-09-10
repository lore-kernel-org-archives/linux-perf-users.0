Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F97137772;
	Tue, 10 Sep 2024 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974856; cv=none; b=b3PU4NBq09c3cVcvdULV+PnmpshiecQTOa5hc8sHlggJSuGg667R7J7+766DhRQSMzkOUjbf/i0H4axsCdMfCjrnr2vDbUjG0ZfeH4ownMLSeVnHtgeqvS31JazFFfyXTFRHayVswfQ2XUJAUQpSwMUhQPerslK8JkahXoc8MK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974856; c=relaxed/simple;
	bh=7+IIDl7PVS1uHqAEIEi4kXUp1QGLqaP5rlX6WPwA6ZU=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=B0BpMkbXGG4OErUwtbFsfPgVvb76SYpmulqxwHOcOt+EgKUu7mIagGVF/INt6IskGi3yjkbMKrz9q5qUfSmtD+bWvrnxY24AfPKe4Hq5ZcsNEarCUE0REL9kLrr/cOihxsRg1oxfXl9W4XI2c875NmaB2mvNH1YrIi0nBBzrZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKFGxjJT; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKFGxjJT"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso4518890a12.2;
        Tue, 10 Sep 2024 06:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725974854; x=1726579654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDoIF+0VTy0ZSl15lryvOIJ2DFk2dEgiB+ivcDU0b54=;
        b=QKFGxjJT7ATlIMmr2kSJtNGYGVXjYdyIjqqRhzqPkeRx3NuYPWjn3PIYT4w2KAc89X
         /yu+3IY9cvczjEG++mao9GWeKHn2XYjjoOf3Ir+3EPo24wgpy2TAPcTmXlh/C+B/znOZ
         DDq4mB3QIAIquddZku8B3lMSp+bxtI8KWki8xfvSMfxwVhutrhgWTpHOrrSj1X8lZN62
         ArAfLFt9/NrsM2toyHqwz3nkyBTeXsBPN/btvrKo5bVoiqBpqAe0OkoyCEV2C75jtkmE
         GItKrOtoZtiENbypFr7NMc+fRR36eR4m62/Icd/nbVeYApJ2nUxmZ2oP7coeBzIDHmZb
         E0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725974854; x=1726579654;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LDoIF+0VTy0ZSl15lryvOIJ2DFk2dEgiB+ivcDU0b54=;
        b=dc+DgsR7TLqQ4HlBct5CZVBxHSCntPQdF7yFkuM1+ehM2WMa/6vRnPIPPB3era7cmL
         6GvwX/+FwgMJELJneERCFuNi6+x4WOAbcS4Pa8f6hR0HYjvGyfAQnBdK23CME4nWE/wz
         qz5buhxVS6yqvFR2przvssOB70/QTxuf7TRv40jaDt/KGNtY7Xta5sZzhU3FGBTbYFg2
         oBYALJ+ADB3KH7syRWnKaHq/tXTvha5BMmDrHQFM+R0wZPMSINiOTs2fYKMvRoj4VcnM
         Ws5oMMieTi4luTpw5a0awGcwv1d5P+t2Yk22uCCsSH3WkStiBhIEaYVgOXecqYurgvjb
         V9MQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9N4VMl71W6LBIWOyRU7i9XsrQ0aB9Pc8SWq8Ri0MHIZyd6AWHmj+xXJLhWS9nAw3aze8IX8gxGjC4s5bbA/HvuQ==@vger.kernel.org, AJvYcCWXt1/9gSXIVaqkSE7TWysi5Cu+hLj2xnesFLgYugIoNGOoOQrGVm6kC5QRyKDytpFP6+V1qdAWJ5dFRYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvMc2Wcufh+UTmukWCNINetEqtJu3QeYcS9F8QJUU3CCUVVWAD
	Mc6HpJIjvZlWsPzEkfMOCExmbMwQHLm3tZTw4L0t3fAlDC8WXIJw
X-Google-Smtp-Source: AGHT+IEkfYSL8nOmwreD2Ig5ZXUj+R7n74Z9XFZ/yS8qTpO7NyYxk6Rjb7OSGU4S2SNy9uoAlAS/HA==
X-Received: by 2002:a05:6a20:e609:b0:1cf:4ad8:83c3 with SMTP id adf61e73a8af0-1cf5e0303ddmr1211699637.2.1725974853701;
        Tue, 10 Sep 2024 06:27:33 -0700 (PDT)
Received: from localhost ([138.0.199.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e33456sm48820745ad.99.2024.09.10.06.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 06:27:32 -0700 (PDT)
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Tue, 10 Sep 2024 10:27:30 -0300
To: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf trace: Support collecting 'union's with the BPF
 augmenter
Message-ID: <ZuBJQp1lf5uAjpo1@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

And reuse the BTF based struct pretty printer, with that we can offer
initial support for the 'bpf' syscall's second argument, a 'union
bpf_attr' pointer.

But this is not that satisfactory as the libbpf btf dumper will pretty
print _all_ the union, we need to have a way to say that the first arg
selects the type for the union member to be pretty printed, something
like what pahole does translating the PERF_RECORD_ selector into a name,
and using that name to find a matching struct.

In the case of 'union bpf_attr' it would map PROG_LOAD to one of the
union members, but unfortunately there is no such mapping:

  root@number:~# pahole bpf_attr
  union bpf_attr {
  	struct {
  		__u32              map_type;           /*     0     4 */
  		__u32              key_size;           /*     4     4 */
  		__u32              value_size;         /*     8     4 */
  		__u32              max_entries;        /*    12     4 */
  		__u32              map_flags;          /*    16     4 */
  		__u32              inner_map_fd;       /*    20     4 */
  		__u32              numa_node;          /*    24     4 */
  		char               map_name[16];       /*    28    16 */
  		__u32              map_ifindex;        /*    44     4 */
  		__u32              btf_fd;             /*    48     4 */
  		__u32              btf_key_type_id;    /*    52     4 */
  		__u32              btf_value_type_id;  /*    56     4 */
  		__u32              btf_vmlinux_value_type_id; /*    60     4 */
  		/* --- cacheline 1 boundary (64 bytes) --- */
  		__u64              map_extra;          /*    64     8 */
  		__s32              value_type_btf_obj_fd; /*    72     4 */
  		__s32              map_token_fd;       /*    76     4 */
  	};                                             /*     0    80 */
  	struct {
  		__u32              map_fd;             /*     0     4 */

  		/* XXX 4 bytes hole, try to pack */

  		__u64              key;                /*     8     8 */
  		union {
  			__u64      value;              /*    16     8 */
  			__u64      next_key;           /*    16     8 */
  		};                                     /*    16     8 */
  		__u64              flags;              /*    24     8 */
  	};                                             /*     0    32 */
  	struct {
  		__u64              in_batch;           /*     0     8 */
  		__u64              out_batch;          /*     8     8 */
  		__u64              keys;               /*    16     8 */
  		__u64              values;             /*    24     8 */
  		__u32              count;              /*    32     4 */
  		__u32              map_fd;             /*    36     4 */
  		__u64              elem_flags;         /*    40     8 */
  		__u64              flags;              /*    48     8 */
  	} batch;                                       /*     0    56 */
  	struct {
  		__u32              prog_type;          /*     0     4 */
  		__u32              insn_cnt;           /*     4     4 */
  		__u64              insns;              /*     8     8 */
  		__u64              license;            /*    16     8 */
  		__u32              log_level;          /*    24     4 */
  		__u32              log_size;           /*    28     4 */
  		__u64              log_buf;            /*    32     8 */
  		__u32              kern_version;       /*    40     4 */
  		__u32              prog_flags;         /*    44     4 */
  		char               prog_name[16];      /*    48    16 */
  		/* --- cacheline 1 boundary (64 bytes) --- */
  		__u32              prog_ifindex;       /*    64     4 */
  		__u32              expected_attach_type; /*    68     4 */
  		__u32              prog_btf_fd;        /*    72     4 */
  		__u32              func_info_rec_size; /*    76     4 */
  		__u64              func_info;          /*    80     8 */
  		__u32              func_info_cnt;      /*    88     4 */
  		__u32              line_info_rec_size; /*    92     4 */
  		__u64              line_info;          /*    96     8 */
  		__u32              line_info_cnt;      /*   104     4 */
  		__u32              attach_btf_id;      /*   108     4 */
  		union {
  			__u32      attach_prog_fd;     /*   112     4 */
  			__u32      attach_btf_obj_fd;  /*   112     4 */
  		};                                     /*   112     4 */
  		__u32              core_relo_cnt;      /*   116     4 */
  		__u64              fd_array;           /*   120     8 */
  		/* --- cacheline 2 boundary (128 bytes) --- */
  		__u64              core_relos;         /*   128     8 */
  		__u32              core_relo_rec_size; /*   136     4 */
  		__u32              log_true_size;      /*   140     4 */
  		__s32              prog_token_fd;      /*   144     4 */
  	};                                             /*     0   152 */
  	struct {
  		__u64              pathname;           /*     0     8 */
  		__u32              bpf_fd;             /*     8     4 */
  		__u32              file_flags;         /*    12     4 */
  		__s32              path_fd;            /*    16     4 */
  	};                                             /*     0    24 */
  	struct {
  		union {
  			__u32      target_fd;          /*     0     4 */
  			__u32      target_ifindex;     /*     0     4 */
  		};                                     /*     0     4 */
  		__u32              attach_bpf_fd;      /*     4     4 */
  		__u32              attach_type;        /*     8     4 */
  		__u32              attach_flags;       /*    12     4 */
  		__u32              replace_bpf_fd;     /*    16     4 */
  		union {
  			__u32      relative_fd;        /*    20     4 */
  			__u32      relative_id;        /*    20     4 */
  		};                                     /*    20     4 */
  		__u64              expected_revision;  /*    24     8 */
  	};                                             /*     0    32 */
  	struct {
  		__u32              prog_fd;            /*     0     4 */
  		__u32              retval;             /*     4     4 */
  		__u32              data_size_in;       /*     8     4 */
  		__u32              data_size_out;      /*    12     4 */
  		__u64              data_in;            /*    16     8 */
  		__u64              data_out;           /*    24     8 */
  		__u32              repeat;             /*    32     4 */
  		__u32              duration;           /*    36     4 */
  		__u32              ctx_size_in;        /*    40     4 */
  		__u32              ctx_size_out;       /*    44     4 */
  		__u64              ctx_in;             /*    48     8 */
  		__u64              ctx_out;            /*    56     8 */
  		/* --- cacheline 1 boundary (64 bytes) --- */
  		__u32              flags;              /*    64     4 */
  		__u32              cpu;                /*    68     4 */
  		__u32              batch_size;         /*    72     4 */
  	} test;                                        /*     0    80 */
  	struct {
  		union {
  			__u32      start_id;           /*     0     4 */
  			__u32      prog_id;            /*     0     4 */
  			__u32      map_id;             /*     0     4 */
  			__u32      btf_id;             /*     0     4 */
  			__u32      link_id;            /*     0     4 */
  		};                                     /*     0     4 */
  		__u32              next_id;            /*     4     4 */
  		__u32              open_flags;         /*     8     4 */
  	};                                             /*     0    12 */
  	struct {
  		__u32              bpf_fd;             /*     0     4 */
  		__u32              info_len;           /*     4     4 */
  		__u64              info;               /*     8     8 */
  	} info;                                        /*     0    16 */
  	struct {
  		union {
  			__u32      target_fd;          /*     0     4 */
  			__u32      target_ifindex;     /*     0     4 */
  		};                                     /*     0     4 */
  		__u32              attach_type;        /*     4     4 */
  		__u32              query_flags;        /*     8     4 */
  		__u32              attach_flags;       /*    12     4 */
  		__u64              prog_ids;           /*    16     8 */
  		union {
  			__u32      prog_cnt;           /*    24     4 */
  			__u32      count;              /*    24     4 */
  		};                                     /*    24     4 */

  		/* XXX 4 bytes hole, try to pack */

  		__u64              prog_attach_flags;  /*    32     8 */
  		__u64              link_ids;           /*    40     8 */
  		__u64              link_attach_flags;  /*    48     8 */
  		__u64              revision;           /*    56     8 */
  	} query;                                       /*     0    64 */
  	struct {
  		__u64              name;               /*     0     8 */
  		__u32              prog_fd;            /*     8     4 */

  		/* XXX 4 bytes hole, try to pack */

  		__u64              cookie;             /*    16     8 */
  	} raw_tracepoint;                              /*     0    24 */
  	struct {
  		__u64              btf;                /*     0     8 */
  		__u64              btf_log_buf;        /*     8     8 */
  		__u32              btf_size;           /*    16     4 */
  		__u32              btf_log_size;       /*    20     4 */
  		__u32              btf_log_level;      /*    24     4 */
  		__u32              btf_log_true_size;  /*    28     4 */
  		__u32              btf_flags;          /*    32     4 */
  		__s32              btf_token_fd;       /*    36     4 */
  	};                                             /*     0    40 */
  	struct {
  		__u32              pid;                /*     0     4 */
  		__u32              fd;                 /*     4     4 */
  		__u32              flags;              /*     8     4 */
  		__u32              buf_len;            /*    12     4 */
  		__u64              buf;                /*    16     8 */
  		__u32              prog_id;            /*    24     4 */
  		__u32              fd_type;            /*    28     4 */
  		__u64              probe_offset;       /*    32     8 */
  		__u64              probe_addr;         /*    40     8 */
  	} task_fd_query;                               /*     0    48 */
  	struct {
  		union {
  			__u32      prog_fd;            /*     0     4 */
  			__u32      map_fd;             /*     0     4 */
  		};                                     /*     0     4 */
  		union {
  			__u32      target_fd;          /*     4     4 */
  			__u32      target_ifindex;     /*     4     4 */
  		};                                     /*     4     4 */
  		__u32              attach_type;        /*     8     4 */
  		__u32              flags;              /*    12     4 */
  		union {
  			__u32      target_btf_id;      /*    16     4 */
  			struct {
  				__u64 iter_info;       /*    16     8 */
  				__u32 iter_info_len;   /*    24     4 */
  			};                             /*    16    16 */
  			struct {
  				__u64 bpf_cookie;      /*    16     8 */
  			} perf_event;                  /*    16     8 */
  			struct {
  				__u32 flags;           /*    16     4 */
  				__u32 cnt;             /*    20     4 */
  				__u64 syms;            /*    24     8 */
  				__u64 addrs;           /*    32     8 */
  				__u64 cookies;         /*    40     8 */
  			} kprobe_multi;                /*    16    32 */
  			struct {
  				__u32 target_btf_id;   /*    16     4 */

  				/* XXX 4 bytes hole, try to pack */

  				__u64 cookie;          /*    24     8 */
  			} tracing;                     /*    16    16 */
  			struct {
  				__u32 pf;              /*    16     4 */
  				__u32 hooknum;         /*    20     4 */
  				__s32 priority;        /*    24     4 */
  				__u32 flags;           /*    28     4 */
  			} netfilter;                   /*    16    16 */
  			struct {
  				union {
  					__u32  relative_fd; /*    16     4 */
  					__u32  relative_id; /*    16     4 */
  				};                     /*    16     4 */

  				/* XXX 4 bytes hole, try to pack */

  				__u64 expected_revision; /*    24     8 */
  			} tcx;                         /*    16    16 */
  			struct {
  				__u64 path;            /*    16     8 */
  				__u64 offsets;         /*    24     8 */
  				__u64 ref_ctr_offsets; /*    32     8 */
  				__u64 cookies;         /*    40     8 */
  				__u32 cnt;             /*    48     4 */
  				__u32 flags;           /*    52     4 */
  				__u32 pid;             /*    56     4 */
  			} uprobe_multi;                /*    16    48 */
  			struct {
  				union {
  					__u32  relative_fd; /*    16     4 */
  					__u32  relative_id; /*    16     4 */
  				};                     /*    16     4 */

  				/* XXX 4 bytes hole, try to pack */

  				__u64 expected_revision; /*    24     8 */
  			} netkit;                      /*    16    16 */
  		};                                     /*    16    48 */
  	} link_create;                                 /*     0    64 */
  	struct {
  		__u32              link_fd;            /*     0     4 */
  		union {
  			__u32      new_prog_fd;        /*     4     4 */
  			__u32      new_map_fd;         /*     4     4 */
  		};                                     /*     4     4 */
  		__u32              flags;              /*     8     4 */
  		union {
  			__u32      old_prog_fd;        /*    12     4 */
  			__u32      old_map_fd;         /*    12     4 */
  		};                                     /*    12     4 */
  	} link_update;                                 /*     0    16 */
  	struct {
  		__u32              link_fd;            /*     0     4 */
  	} link_detach;                                 /*     0     4 */
  	struct {
  		__u32              type;               /*     0     4 */
  	} enable_stats;                                /*     0     4 */
  	struct {
  		__u32              link_fd;            /*     0     4 */
  		__u32              flags;              /*     4     4 */
  	} iter_create;                                 /*     0     8 */
  	struct {
  		__u32              prog_fd;            /*     0     4 */
  		__u32              map_fd;             /*     4     4 */
  		__u32              flags;              /*     8     4 */
  	} prog_bind_map;                               /*     0    12 */
  	struct {
  		__u32              flags;              /*     0     4 */
  		__u32              bpffs_fd;           /*     4     4 */
  	} token_create;                                /*     0     8 */
  };

  root@number:~#

So this is one case where BTF gets us only that far, not getting all
the way to automate the pretty printing of unions designed like 'union
bpf_attr', we will need a custom pretty printer for this union, as using
the libbpf union BTF dumper is way too verbose:

  root@number:~# perf trace --max-events 1 -e bpf bpftool map
       0.000 ( 0.054 ms): bpftool/3409073 bpf(cmd: PROG_LOAD, uattr: (union=
 bpf_attr){(struct){.map_type =3D (__u32)1,.key_size =3D (__u32)2,.value_si=
ze =3D (__u32)2755142048,.max_entries =3D (__u32)32764,.map_flags =3D (__u3=
2)150263906,.inner_map_fd =3D (__u32)21920,},(struct){.map_fd =3D (__u32)1,=
=2Ekey =3D (__u64)140723063628192,(union){.value =3D (__u64)94145833392226,=
=2Enext_key =3D (__u64)94145833392226,},},.batch =3D (struct){.in_batch =3D=
 (__u64)8589934593,.out_batch =3D (__u64)140723063628192,.keys =3D (__u64)9=
4145833392226,},(struct){.prog_type =3D (__u32)1,.insn_cnt =3D (__u32)2,.in=
sns =3D (__u64)140723063628192,.license =3D (__u64)94145833392226,},(struct=
){.pathname =3D (__u64)8589934593,.bpf_fd =3D (__u32)2755142048,.file_flags=
 =3D (__u32)32764,.path_fd =3D (__s32)150263906,},(struct){(union){.target_=
fd =3D (__u32)1,.target_ifindex =3D (__u32)1,},.attach_bpf_fd =3D (__u32)2,=
=2Eattach_type =3D (__u32)2755142048,.attach_flags =3D (__u32)32764,.replac=
e_bpf_fd =3D (__u32)150263906,(union){.relative_fd =3D (__u32)21920,.relati=
ve_id =3D (__u32)21920,},},.test =3D (struct){.prog_fd =3D (__u32)1,.retval=
 =3D (__u32)2,.data_size_in =3D (__u32)2755142048,.data_size_out =3D (__u32=
)32764,.data_in =3D (__u64)94145833392226,},(struct){(union){.start_id =3D =
(__u32)1,.prog_id =3D (__u32)1,.map_id =3D (__u32)1,.btf_id =3D (__u32)1,.l=
ink_id =3D (__u32)1,},.next_id =3D (__u32)2,.open_flags =3D (__u32)27551420=
48,},.info =3D (struct){.bpf_fd =3D (__u32)1,.info_len =3D (__u32)2,.info =
=3D (__u64)140723063628192,},.query =3D (struct){(union){.target_fd =3D (__=
u32)1,.target_ifindex =3D (__u32)1,},.attach_type =3D (__u32)2,.query_flags=
 =3D (__u32)2755142048,.attach_flags =3D (__u32)32764,.prog_ids =3D (__u64)=
94145833392226,},.raw_tracepoint =3D (struct){.name =3D (__u64)8589934593,.=
prog_fd =3D (__u32)2755142048,.cookie =3D (__u64)94145833392226,},(struct){=
=2Ebtf =3D (__u64)8589934593,.btf_log_buf =3D (__u64)140723063628192,.btf_s=
ize =3D (__u32)150263906,.btf_log_size =3D (__u32)21920,},.task_fd_query =
=3D (struct){.pid =3D (__u32)1,.fd =3D (__u32)2,.flags =3D (__u32)275514204=
8,.buf_len =3D (__u32)32764,.buf =3D (__u64)94145833392226,},.link_create =
=3D (struct){(union){.prog_fd =3D (__u32)1,.map_fd =3D (__u32)1,},(u) =3D 3
  root@number:~# 2: prog_array  name hid_jmp_table  flags 0x0
  	key 4B  value 4B  max_entries 1024  memlock 8440B
  	owner_prog_type tracing  owner jited
  13: hash_of_maps  name cgroup_hash  flags 0x0
  	key 8B  value 4B  max_entries 2048  memlock 167584B
  	pids systemd(1)
  960: array  name libbpf_global  flags 0x0
  	key 4B  value 32B  max_entries 1  memlock 280B
  961: array  name pid_iter.rodata  flags 0x480
  	key 4B  value 4B  max_entries 1  memlock 8192B
  	btf_id 1846  frozen
  	pids bpftool(3409073)
  962: array  name libbpf_det_bind  flags 0x0
  	key 4B  value 32B  max_entries 1  memlock 280B

  root@number:~#

For simpler unions this may be better than not seeing any payload, so
keep it there.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c47fde936c33a2e6..d28a56cc171b2b2e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1075,7 +1075,7 @@ static size_t trace__btf_scnprintf(struct trace *trac=
e, struct syscall_arg *arg,
=20
 	if (btf_is_enum(arg_fmt->type))
 		return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
-	else if (btf_is_struct(arg_fmt->type))
+	else if (btf_is_struct(arg_fmt->type) || btf_is_union(arg_fmt->type))
 		return btf_struct_scnprintf(arg_fmt->type, trace->btf, bf, size, arg);
=20
 	return 0;
@@ -2365,8 +2365,7 @@ static size_t syscall__scnprintf_args(struct syscall =
*sc, char *bf, size_t size,
 			default_scnprintf =3D sc->arg_fmt[arg.idx].scnprintf;
=20
 			if (trace->force_btf ||
-			    (default_scnprintf =3D=3D NULL ||
-			     (default_scnprintf =3D=3D SCA_PTR && strstr(field->type, "struct")=
))) {
+			    (default_scnprintf =3D=3D NULL || (default_scnprintf =3D=3D SCA_PTR=
))) {
 				btf_printed =3D trace__btf_scnprintf(trace, &arg, bf + printed,
 								   size - printed, val, field->type);
 				if (btf_printed) {
@@ -3663,14 +3662,18 @@ static int trace__bpf_sys_enter_beauty_map(struct t=
race *trace, int key, unsigne
 		return -1;
=20
 	for (i =3D 0, field =3D sc->args; field; ++i, field =3D field->next) {
-		struct_offset =3D strstr(field->type, "struct ");
-
 		// XXX We're only collecting pointer payloads _from_ user space
 		if (!sc->arg_fmt[i].from_user)
 			continue;
=20
-		if (field->flags & TEP_FIELD_IS_POINTER && struct_offset) { /* struct */
-			struct_offset +=3D 7;
+		struct_offset =3D strstr(field->type, "struct ");
+		if (struct_offset =3D=3D NULL)
+			struct_offset =3D strstr(field->type, "union ");
+		else
+			struct_offset++; // "union" is shorter
+
+		if (field->flags & TEP_FIELD_IS_POINTER && struct_offset) { /* struct or=
 union (think BPF's attr arg) */
+			struct_offset +=3D 6;
=20
 			/* for 'struct foo *', we only want 'foo' */
 			for (tmp =3D struct_offset, cnt =3D 0; *tmp !=3D ' ' && *tmp !=3D '\0';=
 ++tmp, ++cnt) {
--=20
2.46.0

