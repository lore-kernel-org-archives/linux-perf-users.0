Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A022E182B4;
	Sun, 29 Sep 2024 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727575844; cv=none; b=EnPlJ8EZG7uiEc+GxAwS2uJIZXQjVNyxi0vgJsTkUIrU/fojl97K9yyj/diUc+aajiQaRMdjkLd+CCy5hZwLNK2kTORdWF15BPkkiE2LCl220pswQficKl466Kys1ThtzSixvuFOOTTcvj+ZCdDUxV6A2hyt8LXerSG2yiLIyeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727575844; c=relaxed/simple;
	bh=PI5WgKX1Szn3sVwMStb15A/puj5JaT0fUfWxfwfnC40=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a12hWKE5jkwK+rTE+qzaBl9OVQ/+wYxSazU6GYuBkzAn7hohruKgAMO9xz71EWlMGHWbAI81PZ7ScTttREdXIpGBzDy/qzYUZhz3LLtKwF5hVe3H/vCjYNOB+ozIs8/eYyJ3/c/XT4ehXz3LcUXIT++s88i/XX51ayv7FciCLYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJOLPx2O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJOLPx2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8A6C4CEC3;
	Sun, 29 Sep 2024 02:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727575844;
	bh=PI5WgKX1Szn3sVwMStb15A/puj5JaT0fUfWxfwfnC40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BJOLPx2OHbdimo+aaybFmvPtz6fGPG4qp/3gDl3kJv0vW0GE/AVtnrjKbDzYutrmX
	 vRqaB/dDmIc/XJuf1B77jWD2FakPQpU2mxnKgKa4EG/7wJxfRw5nX37Vf0aFY9TI0d
	 8TDOsAQZlC/XRG99aGMShUCg/UsvsC9dN8hUyUXa+WIu5ekEc57+r74fYiWkhRAIFC
	 6XK8oj+EVSFqqGQaTK001ERmfygcmW7ROp5PL9H7pvSfL59hxiLqkDNJIiFwLL/nAd
	 01cc98OoK8HLXgsG6q/4NZpk/2XgJz3ucGS4+XaY0VSYOwfRSHcgR9LKmDggUc/cwF
	 0whYLoI0w65pA==
Date: Sun, 29 Sep 2024 11:10:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
 <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, Will
 Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, Mike Leach
 <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren
 <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Nick
 Terrell <terrelln@fb.com>, Guilherme Amadio <amadio@gentoo.org>, Changbin
 Du <changbin.du@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>,
 Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev
 <atrajeev@linux.vnet.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, Kajol
 Jain <kjain@linux.ibm.com>, Anup Patel <anup@brainfault.org>, Shenlin Liang
 <liangshenlin@eswincomputing.com>, Atish Patra <atishp@rivosinc.com>,
 Oliver Upton <oliver.upton@linux.dev>, Chen Pei <cp0613@linux.alibaba.com>,
 Dima Kogan <dima@secretsauce.net>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Yang Jihong
 <yangjihong@bytedance.com>
Subject: Re: [PATCH v1 08/11] perf libdw: Remove unnecessary defines
Message-Id: <20240929111033.cb4826d6a6e1afb28f834adb@kernel.org>
In-Reply-To: <20240924160418.1391100-9-irogers@google.com>
References: <20240924160418.1391100-1-irogers@google.com>
	<20240924160418.1391100-9-irogers@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Sep 2024 09:04:15 -0700
Ian Rogers <irogers@google.com> wrote:

> As HAVE_DWARF_GETLOCATIONS_SUPPORT and HAVE_DWARF_CFI_SUPPORT always
> match HAVE_DWARF_SUPPORT remove the macros and use
> HAVE_DWARF_SUPPORT. If building the file is guarded by CONFIG_DWARF
> then remove all ifs.

Thanks for the cleanups!

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-check.txt |  2 +-
>  tools/perf/Makefile.config              |  3 --
>  tools/perf/builtin-annotate.c           |  2 +-
>  tools/perf/builtin-check.c              |  2 +-
>  tools/perf/builtin-report.c             |  2 +-
>  tools/perf/util/dwarf-aux.c             |  6 ---
>  tools/perf/util/dwarf-aux.h             | 54 -------------------------
>  tools/perf/util/probe-finder.c          |  4 --
>  8 files changed, 4 insertions(+), 71 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
> index 10f69fb6850b..45101a8e4154 100644
> --- a/tools/perf/Documentation/perf-check.txt
> +++ b/tools/perf/Documentation/perf-check.txt
> @@ -48,7 +48,7 @@ feature::
>                  bpf_skeletons           /  HAVE_BPF_SKEL
>                  debuginfod              /  HAVE_DEBUGINFOD_SUPPORT
>                  dwarf                   /  HAVE_DWARF_SUPPORT
> -                dwarf_getlocations      /  HAVE_DWARF_GETLOCATIONS_SUPPORT
> +                dwarf_getlocations      /  HAVE_DWARF_SUPPORT

nit: BTW, I think we can remove this feature itself now.

Thank you,

>                  dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
>                  auxtrace                /  HAVE_AUXTRACE_SUPPORT
>                  libaudit                /  HAVE_LIBAUDIT_SUPPORT
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 9da0dc001d98..db79b25ada6f 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -463,9 +463,6 @@ else
>          $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.157, disables dwarf support. Please install new elfutils-devel/libdw-dev)
>          NO_LIBDW := 1
>        endif
> -    else
> -      CFLAGS += -DHAVE_DWARF_GETLOCATIONS_SUPPORT
> -      CFLAGS += -DHAVE_DWARF_CFI_SUPPORT
>      endif # Dwarf support
>    endif # libelf support
>  endif # NO_LIBELF
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 3dc6197ef3fa..04af13eb4a4c 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -840,7 +840,7 @@ int cmd_annotate(int argc, const char **argv)
>  	}
>  #endif
>  
> -#ifndef HAVE_DWARF_GETLOCATIONS_SUPPORT
> +#ifndef HAVE_DWARF_SUPPORT
>  	if (annotate.data_type) {
>  		pr_err("Error: Data type profiling is disabled due to missing DWARF support\n");
>  		return -ENOTSUP;
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> index 0b76b6e42b78..18c0a815243b 100644
> --- a/tools/perf/builtin-check.c
> +++ b/tools/perf/builtin-check.c
> @@ -28,7 +28,7 @@ struct feature_status supported_features[] = {
>  	FEATURE_STATUS("bpf_skeletons", HAVE_BPF_SKEL),
>  	FEATURE_STATUS("debuginfod", HAVE_DEBUGINFOD_SUPPORT),
>  	FEATURE_STATUS("dwarf", HAVE_DWARF_SUPPORT),
> -	FEATURE_STATUS("dwarf_getlocations", HAVE_DWARF_GETLOCATIONS_SUPPORT),
> +	FEATURE_STATUS("dwarf_getlocations", HAVE_DWARF_SUPPORT),
>  	FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
>  	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
>  	FEATURE_STATUS("libaudit", HAVE_LIBAUDIT_SUPPORT),
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 5dc17ffee27a..426cbc9110d1 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1701,7 +1701,7 @@ int cmd_report(int argc, const char **argv)
>  		report.data_type = true;
>  		annotate_opts.annotate_src = false;
>  
> -#ifndef HAVE_DWARF_GETLOCATIONS_SUPPORT
> +#ifndef HAVE_DWARF_SUPPORT
>  		pr_err("Error: Data type profiling is disabled due to missing DWARF support\n");
>  		goto error;
>  #endif
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 92eb9c8dc3e5..559c953ca172 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1182,7 +1182,6 @@ int die_get_varname(Dwarf_Die *vr_die, struct strbuf *buf)
>  	return ret < 0 ? ret : strbuf_addf(buf, "\t%s", dwarf_diename(vr_die));
>  }
>  
> -#if defined(HAVE_DWARF_GETLOCATIONS_SUPPORT) || defined(HAVE_DWARF_CFI_SUPPORT)
>  static int reg_from_dwarf_op(Dwarf_Op *op)
>  {
>  	switch (op->atom) {
> @@ -1245,9 +1244,7 @@ static bool check_allowed_ops(Dwarf_Op *ops, size_t nops)
>  	}
>  	return true;
>  }
> -#endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT || HAVE_DWARF_CFI_SUPPORT */
>  
> -#ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
>  /**
>   * die_get_var_innermost_scope - Get innermost scope range of given variable DIE
>   * @sp_die: a subprogram DIE
> @@ -1697,9 +1694,7 @@ void die_collect_global_vars(Dwarf_Die *cu_die, struct die_var_type **var_types)
>  
>  	die_find_child(cu_die, __die_collect_global_vars_cb, (void *)var_types, &die_mem);
>  }
> -#endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
>  
> -#ifdef HAVE_DWARF_CFI_SUPPORT
>  /**
>   * die_get_cfa - Get frame base information
>   * @dwarf: a Dwarf info
> @@ -1732,7 +1727,6 @@ int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset)
>  	}
>  	return -1;
>  }
> -#endif /* HAVE_DWARF_CFI_SUPPORT */
>  
>  /*
>   * die_has_loclist - Check if DW_AT_location of @vr_die is a location list
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index 925a9bb9fb15..892c8c5c23fc 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -156,8 +156,6 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset, Dwarf_Die *die_m
>  /* Return type info where the pointer and offset point to */
>  Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset, Dwarf_Die *die_mem);
>  
> -#ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
> -
>  /* Get byte offset range of given variable DIE */
>  int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
>  
> @@ -176,59 +174,7 @@ void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types);
>  /* Save all global variables in this CU */
>  void die_collect_global_vars(Dwarf_Die *cu_die, struct die_var_type **var_types);
>  
> -#else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
> -#include <errno.h>
> -
> -static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
> -				    Dwarf_Die *vr_die __maybe_unused,
> -				    struct strbuf *buf __maybe_unused)
> -{
> -	return -ENOTSUP;
> -}
> -
> -static inline Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die __maybe_unused,
> -						  Dwarf_Addr pc __maybe_unused,
> -						  int reg __maybe_unused,
> -						  int *poffset __maybe_unused,
> -						  bool is_fbreg __maybe_unused,
> -						  Dwarf_Die *die_mem __maybe_unused)
> -{
> -	return NULL;
> -}
> -
> -static inline Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die __maybe_unused,
> -						   Dwarf_Addr addr __maybe_unused,
> -						   Dwarf_Die *die_mem __maybe_unused,
> -						   int *offset __maybe_unused)
> -{
> -	return NULL;
> -}
> -
> -static inline void die_collect_vars(Dwarf_Die *sc_die __maybe_unused,
> -				    struct die_var_type **var_types __maybe_unused)
> -{
> -}
> -
> -static inline void die_collect_global_vars(Dwarf_Die *cu_die __maybe_unused,
> -					   struct die_var_type **var_types __maybe_unused)
> -{
> -}
> -
> -#endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
> -
> -#ifdef HAVE_DWARF_CFI_SUPPORT
> -
>  /* Get the frame base information from CFA */
>  int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset);
>  
> -#else /* HAVE_DWARF_CFI_SUPPORT */
> -
> -static inline int die_get_cfa(Dwarf *dwarf __maybe_unused, u64 pc __maybe_unused,
> -			      int *preg __maybe_unused, int *poffset __maybe_unused)
> -{
> -	return -1;
> -}
> -
> -#endif /* HAVE_DWARF_CFI_SUPPORT */
> -
>  #endif /* _DWARF_AUX_H */
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 7434b38596b9..8019d232f515 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -602,7 +602,6 @@ static int call_probe_finder(Dwarf_Die *sc_die, struct probe_finder *pf)
>  	ret = dwarf_getlocation_addr(&fb_attr, pf->addr, &pf->fb_ops, &nops, 1);
>  	if (ret <= 0 || nops == 0) {
>  		pf->fb_ops = NULL;
> -#ifdef HAVE_DWARF_CFI_SUPPORT
>  	} else if (nops == 1 && pf->fb_ops[0].atom == DW_OP_call_frame_cfa &&
>  		   (pf->cfi_eh != NULL || pf->cfi_dbg != NULL)) {
>  		if ((dwarf_cfi_addrframe(pf->cfi_eh, pf->addr, &frame) != 0 &&
> @@ -613,7 +612,6 @@ static int call_probe_finder(Dwarf_Die *sc_die, struct probe_finder *pf)
>  			free(frame);
>  			return -ENOENT;
>  		}
> -#endif /* HAVE_DWARF_CFI_SUPPORT */
>  	}
>  
>  	/* Call finder's callback handler */
> @@ -1138,7 +1136,6 @@ static int debuginfo__find_probes(struct debuginfo *dbg,
>  
>  	pf->machine = ehdr.e_machine;
>  
> -#ifdef HAVE_DWARF_CFI_SUPPORT
>  	do {
>  		GElf_Shdr shdr;
>  
> @@ -1148,7 +1145,6 @@ static int debuginfo__find_probes(struct debuginfo *dbg,
>  
>  		pf->cfi_dbg = dwarf_getcfi(dbg->dbg);
>  	} while (0);
> -#endif /* HAVE_DWARF_CFI_SUPPORT */
>  
>  	ret = debuginfo__find_probe_location(dbg, pf);
>  	return ret;
> -- 
> 2.46.0.792.g87dc391469-goog
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
