Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C53C339AC
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 00:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124067; cv=none; b=NH34EOLkF5IQYxw5PQTVy6kvtctRY/zneEBWXaqBMH12Lf4IjBDS23Ayn7OoSfu+BTkumuDgOawdZjSvM1hs5DOlylMVwfo0wY/BVY5gRkcNE7dV7Ojs2PmjLjLuuudvFqRP7oms25AKHf5360E6J8L6uW1/0ZFDlVL7fDm3nmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124067; c=relaxed/simple;
	bh=6NzXFDtzmeldWPPLZ8swl7rrafIpOa+W1tRbpJ9UR9Y=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fuvSEFODoqIBqRUR5vYbmwY5IU0WSrRhnnDdji+rjKiHQbH2UnhFncSLHioxYrIEUmmDR1nJnlsgxrOLv33TSQyIqGipqgo6KuZ6wJPctoQ9uQPgB6klvh7HIFNYUqy0B6an4T+YutyUfuGh6BklSE/EH1eZ3UGrEog0sJRsdr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Id6lORTv; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Id6lORTv"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28fc60660dso575326276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Oct 2024 17:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124065; x=1729728865; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GcB5GtP5PER7P0fAo7i/I4FfsUt0WnKPhI2an5P5bXU=;
        b=Id6lORTvOhM5R7Kg17NT7IzhrvEtFBJqySKX5vt/QF8OlPm+VAZ/T+ampcqU4xh4Qf
         4iI/5ibqhAG8kEeAI/KspPzdJb2tCiDqz+T0Yy6Z1m9QemkGV8C17ZGDNZlYNEhEpkj5
         L7nR6n1vN81kqZH2EPXoXMiLSYUPN9p4XYK49i8hzOkF26K6FTvWz9vleLvA6COBnTJW
         YEbOqX192+Lfq9a25C3ar+3rQj/GTZzOMQG7oyCOtDjkTNV0ANxVbb2eySDvSKzfM5vy
         90TdEO9oUTFVbk5Gadvneqxl5kJT1hjzk7xw+Qs+qS25UVQDZ+Hqew4PSF8ZS2P1S7IZ
         cOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124065; x=1729728865;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GcB5GtP5PER7P0fAo7i/I4FfsUt0WnKPhI2an5P5bXU=;
        b=IIQAtii7RsJd1lIexCqHDl28Osc+iARR33jsLRuicpOPds7dnc71NtvI+Ji8M1Zq4q
         Txwf0FWOCxND7Uglz0dvZkAYKGSbhJ1KwJKuCWHHsBaHObwDOwVSuTiAP3iNHzXGA5I8
         qhoiQVjks/e8yHtVHAy7yqT/eNfGaQU4eremtgJxJf/USXrxOtLyFtSMBTVrWvLdT/FM
         be6q3vXQij9AEC7E9cDuh/QzJ6Z7SfoRXpPfLvEfMyZNcMOVBMVAfUZu5gIkFgdnJW9D
         ZBpndmMtCTUdzC1bHpWdf5nMsq6ViTnBbZHtWbe0u99sicpStjyfbSEZK2JP+XhIXvc6
         EygQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZSZ/XcfhrRbnQOozVitgzU3L4NdJaKlQLS0xFDinPPnmN2Vp7CzD384L1b6bdBFWXGeQfs3fFJN4ulHf4sAS+@vger.kernel.org
X-Gm-Message-State: AOJu0Yz090Mxs6UQPdHZJoxb7Xr4g/AHlokceIMsBSajiLhhgv+BVyBW
	8AJjsYMvMByux4sy1kUMREQA6BBXGPzhIqWlMbioMNDKBaofodgPWb5y+ig2CP2B2IOkCmV6QvV
	sUetfFg==
X-Google-Smtp-Source: AGHT+IF84de8wETp+H+TNwpiCe/Wmym3lkGW+5hnYBUFbVDRkLRMCr2aUEvU33rn4tBcd8ME/lSYibr0Ec+J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:b10e:0:b0:e0e:4841:3a7e with SMTP id
 3f1490d57ef6-e2978555793mr6672276.7.1729124064807; Wed, 16 Oct 2024 17:14:24
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:13:52 -0700
In-Reply-To: <20241017001354.56973-1-irogers@google.com>
Message-Id: <20241017001354.56973-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017001354.56973-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 09/11] perf libdw: Remove unnecessary defines
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Atish Patra <atishp@rivosinc.com>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Anup Patel <anup@brainfault.org>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

As HAVE_DWARF_GETLOCATIONS_SUPPORT and HAVE_DWARF_CFI_SUPPORT always
match HAVE_DWARF_SUPPORT remove the macros and use
HAVE_DWARF_SUPPORT. If building the file is guarded by CONFIG_DWARF
then remove all ifs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-check.txt |  2 +-
 tools/perf/Makefile.config              |  3 --
 tools/perf/builtin-annotate.c           |  2 +-
 tools/perf/builtin-check.c              |  2 +-
 tools/perf/builtin-report.c             |  2 +-
 tools/perf/util/dwarf-aux.c             |  6 ---
 tools/perf/util/dwarf-aux.h             | 54 -------------------------
 tools/perf/util/probe-finder.c          |  4 --
 8 files changed, 4 insertions(+), 71 deletions(-)

diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index 10f69fb6850b..45101a8e4154 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -48,7 +48,7 @@ feature::
                 bpf_skeletons           /  HAVE_BPF_SKEL
                 debuginfod              /  HAVE_DEBUGINFOD_SUPPORT
                 dwarf                   /  HAVE_DWARF_SUPPORT
-                dwarf_getlocations      /  HAVE_DWARF_GETLOCATIONS_SUPPORT
+                dwarf_getlocations      /  HAVE_DWARF_SUPPORT
                 dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
                 auxtrace                /  HAVE_AUXTRACE_SUPPORT
                 libaudit                /  HAVE_LIBAUDIT_SUPPORT
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6378811f2568..7dbcf8394f3d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -466,9 +466,6 @@ else
         $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.157, disables dwarf support. Please install new elfutils-devel/libdw-dev)
         NO_LIBDW := 1
       endif
-    else
-      CFLAGS += -DHAVE_DWARF_GETLOCATIONS_SUPPORT
-      CFLAGS += -DHAVE_DWARF_CFI_SUPPORT
     endif # Dwarf support
   endif # libelf support
 endif # NO_LIBELF
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 3dc6197ef3fa..04af13eb4a4c 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -840,7 +840,7 @@ int cmd_annotate(int argc, const char **argv)
 	}
 #endif
 
-#ifndef HAVE_DWARF_GETLOCATIONS_SUPPORT
+#ifndef HAVE_DWARF_SUPPORT
 	if (annotate.data_type) {
 		pr_err("Error: Data type profiling is disabled due to missing DWARF support\n");
 		return -ENOTSUP;
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 0b76b6e42b78..18c0a815243b 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -28,7 +28,7 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("bpf_skeletons", HAVE_BPF_SKEL),
 	FEATURE_STATUS("debuginfod", HAVE_DEBUGINFOD_SUPPORT),
 	FEATURE_STATUS("dwarf", HAVE_DWARF_SUPPORT),
-	FEATURE_STATUS("dwarf_getlocations", HAVE_DWARF_GETLOCATIONS_SUPPORT),
+	FEATURE_STATUS("dwarf_getlocations", HAVE_DWARF_SUPPORT),
 	FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
 	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
 	FEATURE_STATUS("libaudit", HAVE_LIBAUDIT_SUPPORT),
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 36b344e39dd6..2251aa61ea53 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1705,7 +1705,7 @@ int cmd_report(int argc, const char **argv)
 		report.data_type = true;
 		annotate_opts.annotate_src = false;
 
-#ifndef HAVE_DWARF_GETLOCATIONS_SUPPORT
+#ifndef HAVE_DWARF_SUPPORT
 		pr_err("Error: Data type profiling is disabled due to missing DWARF support\n");
 		goto error;
 #endif
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 92eb9c8dc3e5..559c953ca172 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1182,7 +1182,6 @@ int die_get_varname(Dwarf_Die *vr_die, struct strbuf *buf)
 	return ret < 0 ? ret : strbuf_addf(buf, "\t%s", dwarf_diename(vr_die));
 }
 
-#if defined(HAVE_DWARF_GETLOCATIONS_SUPPORT) || defined(HAVE_DWARF_CFI_SUPPORT)
 static int reg_from_dwarf_op(Dwarf_Op *op)
 {
 	switch (op->atom) {
@@ -1245,9 +1244,7 @@ static bool check_allowed_ops(Dwarf_Op *ops, size_t nops)
 	}
 	return true;
 }
-#endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT || HAVE_DWARF_CFI_SUPPORT */
 
-#ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
 /**
  * die_get_var_innermost_scope - Get innermost scope range of given variable DIE
  * @sp_die: a subprogram DIE
@@ -1697,9 +1694,7 @@ void die_collect_global_vars(Dwarf_Die *cu_die, struct die_var_type **var_types)
 
 	die_find_child(cu_die, __die_collect_global_vars_cb, (void *)var_types, &die_mem);
 }
-#endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
-#ifdef HAVE_DWARF_CFI_SUPPORT
 /**
  * die_get_cfa - Get frame base information
  * @dwarf: a Dwarf info
@@ -1732,7 +1727,6 @@ int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset)
 	}
 	return -1;
 }
-#endif /* HAVE_DWARF_CFI_SUPPORT */
 
 /*
  * die_has_loclist - Check if DW_AT_location of @vr_die is a location list
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index bd7505812569..892c8c5c23fc 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -9,7 +9,6 @@
 #include <elfutils/libdw.h>
 #include <elfutils/libdwfl.h>
 #include <elfutils/version.h>
-#include <errno.h>
 
 struct strbuf;
 
@@ -157,8 +156,6 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset, Dwarf_Die *die_m
 /* Return type info where the pointer and offset point to */
 Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset, Dwarf_Die *die_mem);
 
-#ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
-
 /* Get byte offset range of given variable DIE */
 int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
 
@@ -177,58 +174,7 @@ void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types);
 /* Save all global variables in this CU */
 void die_collect_global_vars(Dwarf_Die *cu_die, struct die_var_type **var_types);
 
-#else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
-
-static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
-				    Dwarf_Die *vr_die __maybe_unused,
-				    struct strbuf *buf __maybe_unused)
-{
-	return -ENOTSUP;
-}
-
-static inline Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die __maybe_unused,
-						  Dwarf_Addr pc __maybe_unused,
-						  int reg __maybe_unused,
-						  int *poffset __maybe_unused,
-						  bool is_fbreg __maybe_unused,
-						  Dwarf_Die *die_mem __maybe_unused)
-{
-	return NULL;
-}
-
-static inline Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die __maybe_unused,
-						   Dwarf_Addr addr __maybe_unused,
-						   Dwarf_Die *die_mem __maybe_unused,
-						   int *offset __maybe_unused)
-{
-	return NULL;
-}
-
-static inline void die_collect_vars(Dwarf_Die *sc_die __maybe_unused,
-				    struct die_var_type **var_types __maybe_unused)
-{
-}
-
-static inline void die_collect_global_vars(Dwarf_Die *cu_die __maybe_unused,
-					   struct die_var_type **var_types __maybe_unused)
-{
-}
-
-#endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
-
-#ifdef HAVE_DWARF_CFI_SUPPORT
-
 /* Get the frame base information from CFA */
 int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset);
 
-#else /* HAVE_DWARF_CFI_SUPPORT */
-
-static inline int die_get_cfa(Dwarf *dwarf __maybe_unused, u64 pc __maybe_unused,
-			      int *preg __maybe_unused, int *poffset __maybe_unused)
-{
-	return -1;
-}
-
-#endif /* HAVE_DWARF_CFI_SUPPORT */
-
 #endif /* _DWARF_AUX_H */
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index b6775d3bdeac..8ea15a2a4397 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -602,7 +602,6 @@ static int call_probe_finder(Dwarf_Die *sc_die, struct probe_finder *pf)
 	ret = dwarf_getlocation_addr(&fb_attr, pf->addr, &pf->fb_ops, &nops, 1);
 	if (ret <= 0 || nops == 0) {
 		pf->fb_ops = NULL;
-#ifdef HAVE_DWARF_CFI_SUPPORT
 	} else if (nops == 1 && pf->fb_ops[0].atom == DW_OP_call_frame_cfa &&
 		   (pf->cfi_eh != NULL || pf->cfi_dbg != NULL)) {
 		if ((dwarf_cfi_addrframe(pf->cfi_eh, pf->addr, &frame) != 0 &&
@@ -613,7 +612,6 @@ static int call_probe_finder(Dwarf_Die *sc_die, struct probe_finder *pf)
 			free(frame);
 			return -ENOENT;
 		}
-#endif /* HAVE_DWARF_CFI_SUPPORT */
 	}
 
 	/* Call finder's callback handler */
@@ -1138,7 +1136,6 @@ static int debuginfo__find_probes(struct debuginfo *dbg,
 
 	pf->machine = ehdr.e_machine;
 
-#ifdef HAVE_DWARF_CFI_SUPPORT
 	do {
 		GElf_Shdr shdr;
 
@@ -1148,7 +1145,6 @@ static int debuginfo__find_probes(struct debuginfo *dbg,
 
 		pf->cfi_dbg = dwarf_getcfi(dbg->dbg);
 	} while (0);
-#endif /* HAVE_DWARF_CFI_SUPPORT */
 
 	ret = debuginfo__find_probe_location(dbg, pf);
 	return ret;
-- 
2.47.0.105.g07ac214952-goog

