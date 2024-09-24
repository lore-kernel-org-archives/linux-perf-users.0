Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022DE1ACDE5
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193904; cv=none; b=Yer+rbTVgbRsyLZCX1ZGRaAQct2XZiez3jMmTo4fuhgqdx4deHCYvuiWZz7gsIsto7Pztd2RIAbLZ8pZFj100AjbbXHddKU0Cg8dcvbCZYOLEOXw1bPU2vDccNFTx/eIDMvd6DAX5KwOHLLGSgmfhMoBqBxj2v9pdg5MgcY64ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193904; c=relaxed/simple;
	bh=qfUmU5IPdNn5x1J9BUsLpX16sUAVrH6InykTvYOOEXU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=nKeNb8QPvvwP1WW9tv+3+8Igeo7TahMXizFdCBJpYStlq31awLTP3LfDP4KExldpSDDzukorsqydGFejPWCTuzKeuAjVUGV4kpozDz1iSPQ01LCL1vscrqiI4CGcvJLiC3zqpOV8qwL5z/3oIalLb9IFGONyNLtwqFgt1Fjibg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AdLbtznz; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdLbtznz"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6de0b23f4c5so13057b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727193902; x=1727798702; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ml+3WQr7BKPbaQN1lshaRre+L540nby+DWGQ2gTmC3U=;
        b=AdLbtznzQkX18ip+Wj92o5TsqoidKx8NKjjk0uxvOSoZrS09C3BJ53Ia37mAngvsiB
         oPR2M3FkybHd4CESitZuLYGk/dzXOxBfW6B3vGaPbbW+ZZoAtAqbTiKYYV/UsZXXOn2a
         UQgSccIMdyrSwyfPd2lUg9nPH9EXxKwcqBukPHwYqXDXHfmpfzzPcvyiWGJm1d+At35C
         xppRrxBSXO4m4xSQN+t16uxvdsBCjAaqP7gnnsLOuYXyF/odObjWIrnbPWDypKOdwMws
         JZkB5BibPWcvu7OzJd/ttcM2ml9LkkVDA+HT5I0z3Z4SzPeyJtkSnDExk1lhxqpYccdS
         2WuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727193902; x=1727798702;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ml+3WQr7BKPbaQN1lshaRre+L540nby+DWGQ2gTmC3U=;
        b=GEFhFNw2XRVnJVeMySOtRf6329mqj8EMhJXNydQSoR5va/m37pqWoBnvZQy+XwFTqD
         GuZclOWE+3bockIqi0qbs/nezRDSbX/zMzIIsOsHUag4wj3EHVif6d6R15dD5YJyR4rd
         GNl3s721TGTq1FcA9+Vp16PykCImBrKmpC+5mpT4cfxex593WAnBfzqG+dEI6BjaINrA
         WTBUW/Q9I7Tb/+HYNpaI/aOo1/OfyyFgTm+Yxu5XR7qE/sv1h1jfL6OcGefojK3EMled
         0PEQAVj4YOjGIRvep0Bda4Xo+uPDzbyYzI/qvCpLSSV9R7xPYZdb4HIleOr4+xqglDlx
         NnoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIVYQ8Ji3TxmKL2FHITkzC8mc+x96sRucDY2Oc4S/gd8ZwSbbYyi9RBATuIvLh4IaD5UoQ9JZgMX/TCmSwf+3V@vger.kernel.org
X-Gm-Message-State: AOJu0YwpfYrenBavb/3ApwsJBoY7lfoWfd5damjhDk6fBflINUhBAV41
	n8WKtrtcgYEPglcPNoa4ym14orQlZjdm5khkc3DwhWudLwNpVONh3WJ7p2fYF/ImW04jaWdyN8g
	XJ3rQkw==
X-Google-Smtp-Source: AGHT+IEe9B1OQkne7xCk8DGhm2mrb3Vo8p+rzBDKMxPB6WY62DtPht4AHjRJ05DOcWqdooPzywfKFvkii8V4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:61a6:b27c:a1cd:e6a0])
 (user=irogers job=sendgmr) by 2002:a81:c105:0:b0:6d3:e7e6:8462 with SMTP id
 00721157ae682-6e2084c1e25mr840357b3.1.1727193901900; Tue, 24 Sep 2024
 09:05:01 -0700 (PDT)
Date: Tue, 24 Sep 2024 09:04:15 -0700
In-Reply-To: <20240924160418.1391100-1-irogers@google.com>
Message-Id: <20240924160418.1391100-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924160418.1391100-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 08/11] perf libdw: Remove unnecessary defines
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
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Kajol Jain <kjain@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Atish Patra <atishp@rivosinc.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Yang Jihong <yangjihong@bytedance.com>
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
index 9da0dc001d98..db79b25ada6f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -463,9 +463,6 @@ else
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
index 5dc17ffee27a..426cbc9110d1 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1701,7 +1701,7 @@ int cmd_report(int argc, const char **argv)
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
index 925a9bb9fb15..892c8c5c23fc 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -156,8 +156,6 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset, Dwarf_Die *die_m
 /* Return type info where the pointer and offset point to */
 Dwarf_Die *die_deref_ptr_type(Dwarf_Die *ptr_die, int offset, Dwarf_Die *die_mem);
 
-#ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
-
 /* Get byte offset range of given variable DIE */
 int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
 
@@ -176,59 +174,7 @@ void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types);
 /* Save all global variables in this CU */
 void die_collect_global_vars(Dwarf_Die *cu_die, struct die_var_type **var_types);
 
-#else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
-#include <errno.h>
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
index 7434b38596b9..8019d232f515 100644
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
2.46.0.792.g87dc391469-goog

