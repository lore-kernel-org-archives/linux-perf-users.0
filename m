Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB043B7B9E
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778715129; cv=none; b=Zhv0zFxQjlnt66JXJwIk7auxL7q5iQQXpZR+kFROpYpHNS0VS/xWl91E7IzPPq2gTLdsvNj5wBnmvTVUgepiPlJWMmGdiVHxGb1T7TSe8htzq9sT/cYn0VgpdJ3k2vR4r00LaN+VdBJ8rcPbatnC6YuxcUo/rZuSdrxFmR+4kq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778715129; c=relaxed/simple;
	bh=rULpenWmnzI/PQ7f+JPPT4rUvG9dBnOSZbPu4aOSJOc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OLn/K7to0Cl1PtlYMgiZepa6KPY3nfwXj95PfZL7mgdW/ji822o/IJhfDIb8jOpW4GSNvOJpur+vY8vQyGmq8BLZX3Zm2Ys6W64+4D1Z9tj+/aSrBstfy2I+SPrhUC9U1CVnfB05AnLcXI3cwInNyz0DPz+aXxBEwDsA2fJ3ETQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vr0CFCAd; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vr0CFCAd"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f525565b33so8716247eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778715126; x=1779319926; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jNdE0InOrbRKksDXQHzVHDDoeS2kFoDykqTZ1k3Z0Wg=;
        b=vr0CFCAdVRqTdTLRrA/lCRsf2fQcIX89jV1/I2aC5mrG9Wp4T/Bh4JLuSHR1n1yvEv
         GOiOjrTz8D+9WWjUNZYAEO8p3cQ2tpHDDDY8gWFTm8+iOMm18EK8juvZ+Rpysg3IuEKD
         nVanZ0R+DPuALnWcY7sSu0ncLXo29pESYS1NbLdpBwU48ycs/z0PpUIIJTbNGcWavPOu
         aANZmkSusTAlLWm2Nn5JXt1uoR+yW3bBEuiNf1mkqtGNzVhivRl5bBTQIE0bwKsWoNDV
         HJVjjA6ZknpwP4ImLjR67+2z5Ad0yigzrTHtlzP1xI5GqULqZy23UcvCNq4YGw/ZFNFx
         T9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778715126; x=1779319926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNdE0InOrbRKksDXQHzVHDDoeS2kFoDykqTZ1k3Z0Wg=;
        b=NkjB3QmfCJsN4afLk69NXWsyqbbULyVUwHaZBmXS4cuFJ7tAZYRWKTNv45zdrTym+G
         86AyJt6rhkY7UVScK4kEitIUQ+vVZGUGflAx83uvpCyZY8gDRO3cPbKFiEqlpCWWpk0U
         yWhIHy3FAdiGP84n2DXl5TgfrnkCfA8q5aoKrTzOjFj3TulfLlA3nX4/q2lR5XSOn25x
         Nyqe68wc8RiuP1w6MnSgzsqCzjMAek+x8/CfQm5oVXaEcqV9esOUAuuvsqV8jxEX/dXS
         GwbPJYkfL5Xf7Wd/0Qdn0PW7BgEMfI6yJG9eBbWpCjnxIQdg95LC/BJkVFoLkI0z+dZI
         UaCA==
X-Forwarded-Encrypted: i=1; AFNElJ9YrX3X0DG9SACRswzmqERKmFaBO8SojfnbtQ9bUPFIlBuxphfM7pdEN/IAiRlbXqVbPv5Gwxsej6CL9Wg+p3PS@vger.kernel.org
X-Gm-Message-State: AOJu0YwfVkOBIVLh3UGB5XmczKFEko9SyhErM/rVyrcKvVOyaODzp/6r
	ST/aqGUfTxy6AmF6mXRePr670ojnL1JnM8ww0dwaQvuqu7D7c0Ut68/2K6OdW43hTKvAsLBmrht
	zhR+7TrTITA==
X-Received: from dlbuy13.prod.google.com ([2002:a05:7022:1e0d:b0:133:3081:bb33])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7023:b12:b0:12d:c4cf:cd7
 with SMTP id a92af1059eb24-1349a703e74mr3285002c88.8.1778715126051; Wed, 13
 May 2026 16:32:06 -0700 (PDT)
Date: Wed, 13 May 2026 16:31:45 -0700
In-Reply-To: <20260513233151.572332-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260413024805.1316480-1-irogers@google.com> <20260513233151.572332-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513233151.572332-2-irogers@google.com>
Subject: [PATCH v5 1/7] perf unwind: Refactor get_entries to allow dynamic
 libdw/libunwind selection
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, namhyung@kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Li Guan <guanli.oerv@isrc.iscas.ac.cn>
Cc: 9erthalion6@gmail.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	andrew.jones@oss.qualcomm.com, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	howardchu95@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org, 
	leo.yan@linux.dev, libunwind-devel@nongnu.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	mingo@redhat.com, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	shimin.guo@skydio.com, tglozar@redhat.com, tmricht@linux.ibm.com, 
	will@kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, both libdw and libunwind define 'unwind__get_entries'. This
causes a duplicate symbol build failure when both are compiled into
perf.

This commit refactors the DWARF unwind post-processing to be
configurable at runtime via the .perfconfig file option
'unwind.style', or using the argument '--unwind-style' in the commands
'perf report', 'perf script' and 'perf inject', in a similar manner to
the addr2line or the disassembler style.

The file 'tools/perf/util/unwind.c' adds the top-level dispatch
function 'unwind__get_entries'. The backend implementations are
renamed to 'libdw__get_entries' and 'libunwind__get_entries'. Both are
attempted as fallbacks if not configured, or if the primary backend
fails.

Fixes: 2e9191573a69 ("perf build: Remove NO_LIBDW_DWARF_UNWIND option")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c              |   4 +
 tools/perf/builtin-report.c              |   4 +
 tools/perf/builtin-script.c              |   4 +
 tools/perf/util/Build                    |   1 +
 tools/perf/util/config.c                 |   4 +
 tools/perf/util/symbol_conf.h            |  10 +++
 tools/perf/util/unwind-libdw.c           |  18 +++-
 tools/perf/util/unwind-libunwind-local.c |  27 ++++--
 tools/perf/util/unwind-libunwind.c       |   2 +-
 tools/perf/util/unwind.c                 | 104 +++++++++++++++++++++++
 tools/perf/util/unwind.h                 |  61 ++++++++-----
 11 files changed, 207 insertions(+), 32 deletions(-)
 create mode 100644 tools/perf/util/unwind.c

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 6ab20df358c4..a2493f1097df 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -26,6 +26,7 @@
 #include "util/synthetic-events.h"
 #include "util/thread.h"
 #include "util/namespaces.h"
+#include "util/unwind.h"
 #include "util/util.h"
 #include "util/tsc.h"
 
@@ -2563,6 +2564,9 @@ int cmd_inject(int argc, const char **argv)
 		OPT_STRING(0, "guestmount", &symbol_conf.guestmount, "directory",
 			   "guest mount directory under which every guest os"
 			   " instance has a subdir"),
+		OPT_CALLBACK(0, "unwind-style", NULL, "unwind style",
+			     "unwind styles (libdw,libunwind)",
+			     unwind__option),
 		OPT_BOOLEAN(0, "convert-callchain", &inject.convert_callchain,
 			    "Generate callchains using DWARF and drop register/stack data"),
 		OPT_END()
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 95c0bdba6b11..0b0966d94128 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -48,6 +48,7 @@
 #include "util/time-utils.h"
 #include "util/auxtrace.h"
 #include "util/units.h"
+#include "util/unwind.h"
 #include "util/util.h" // perf_tip()
 #include "ui/ui.h"
 #include "ui/progress.h"
@@ -1449,6 +1450,9 @@ int cmd_report(int argc, const char **argv)
 	OPT_CALLBACK(0, "addr2line-style", NULL, "addr2line style",
 		     "addr2line styles (libdw,llvm,libbfd,addr2line)",
 		     report_parse_addr2line_config),
+	OPT_CALLBACK(0, "unwind-style", NULL, "unwind style",
+		     "unwind styles (libdw,libunwind)",
+		     unwind__option),
 	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
 		    "Symbol demangling. Enabled by default, use --no-demangle to disable."),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c8ac9f01a36b..fd0b4609516b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -63,6 +63,7 @@
 #include <linux/err.h>
 #include "util/dlfilter.h"
 #include "util/record.h"
+#include "util/unwind.h"
 #include "util/util.h"
 #include "util/cgroup.h"
 #include "util/annotate.h"
@@ -4159,6 +4160,9 @@ int cmd_script(int argc, const char **argv)
 			"Enable symbol demangling"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 			"Enable kernel symbol demangling"),
+	OPT_CALLBACK(0, "unwind-style", NULL, "unwind style",
+		     "unwind styles (libdw,libunwind)",
+		     unwind__option),
 	OPT_STRING(0, "addr2line", &symbol_conf.addr2line_path, "path",
 			"addr2line binary to use for line numbers"),
 	OPT_STRING(0, "time", &script.time_str, "str",
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 70cc91d00804..01edfccebb88 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -216,6 +216,7 @@ ifndef CONFIG_SETNS
 perf-util-y += setns.o
 endif
 
+perf-util-y += unwind.o
 perf-util-$(CONFIG_LIBDW) += probe-finder.o
 perf-util-$(CONFIG_LIBDW) += dwarf-aux.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 087002fb1b9b..7988149dc7ed 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -23,6 +23,7 @@
 #include "build-id.h"
 #include "debug.h"
 #include "config.h"
+#include "unwind.h"
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <stdlib.h>
@@ -525,6 +526,9 @@ int perf_default_config(const char *var, const char *value,
 	if (strstarts(var, "addr2line."))
 		return addr2line_configure(var, value, dummy);
 
+	if (strstarts(var, "unwind."))
+		return unwind__configure(var, value, dummy);
+
 	/* Add other config variables here. */
 	return 0;
 }
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 6cd454d7c98e..0dee5aa6a534 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -9,6 +9,15 @@
 struct strlist;
 struct intlist;
 
+enum unwind_style {
+	UNWIND_STYLE_UNKNOWN = 0,
+	UNWIND_STYLE_LIBDW,
+	UNWIND_STYLE_LIBUNWIND,
+};
+
+#define MAX_UNWIND_STYLE (UNWIND_STYLE_LIBUNWIND + 1)
+
+
 enum a2l_style {
 	A2L_STYLE_UNKNOWN = 0,
 	A2L_STYLE_LIBDW,
@@ -81,6 +90,7 @@ struct symbol_conf {
 	const char		*addr2line_path;
 	enum a2l_style	addr2line_style[MAX_A2L_STYLE];
 	int             addr2line_timeout_ms;
+	enum unwind_style unwind_style[MAX_UNWIND_STYLE];
 	unsigned long	time_quantum;
        struct strlist	*dso_list,
 			*comm_list,
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 05e8e68bd49c..21171a6a878c 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -339,7 +339,7 @@ frame_callback(Dwfl_Frame *state, void *arg)
 	       DWARF_CB_ABORT : DWARF_CB_OK;
 }
 
-int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
+int libdw__get_entries(unwind_entry_cb_t cb, void *arg,
 			struct thread *thread,
 			struct perf_sample *data,
 			int max_stack,
@@ -356,7 +356,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 	int err = -EINVAL, i;
 
 	if (!data->user_regs || !data->user_regs->regs)
-		return -EINVAL;
+		return 0;
 
 	ui = zalloc(sizeof(*ui) + sizeof(ui->entries[0]) * max_stack);
 	if (!ui)
@@ -430,6 +430,18 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 		map_symbol__exit(&ui->entries[i].ms);
 
 	dwfl_ui_ti->ui = NULL;
+	int entries = (int)ui->idx;
 	free(ui);
-	return 0;
+	/*
+	 * Unwinder return contract:
+	 *  > 0 : unwinding succeeded (stops fallback). If we found frames but hit an error
+	 *        (e.g. truncated stack), report success to preserve existing frames.
+	 *    0 : unwinding failed without yielding frames. Ignore non-fatal errors
+	 *        (e.g. missing debug info, DWARF corruption) to allow fallback unwinder or
+	 *        kernel callchain resolution to proceed.
+	 *  < 0 : fatal error (e.g. -ENOMEM). Aborts unwinding entirely.
+	 */
+	if (err)
+		return (err == -ENOMEM) ? -ENOMEM : (entries > 0 ? 1 : 0);
+	return entries;
 }
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 87d496e9dfa6..27e2f7b31789 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -744,7 +744,7 @@ static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
 	ret = perf_reg_value(&val, perf_sample__user_regs(ui->sample),
 			     perf_arch_reg_ip(e_machine));
 	if (ret)
-		return ret;
+		return 0;
 
 	ips[i++] = (unw_word_t) val;
 
@@ -757,7 +757,7 @@ static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
 		addr_space = maps__addr_space(thread__maps(ui->thread));
 
 		if (addr_space == NULL)
-			return -1;
+			return 0;
 
 		ret = unw_init_remote(&c, addr_space, ui);
 		if (ret && !ui->best_effort)
@@ -785,15 +785,30 @@ static int get_entries(struct unwind_info *ui, unwind_entry_cb_t cb,
 	/*
 	 * Display what we got based on the order setup.
 	 */
+	int entries = 0;
 	for (i = 0; i < max_stack && !ret; i++) {
 		int j = i;
 
 		if (callchain_param.order == ORDER_CALLER)
 			j = max_stack - i - 1;
-		ret = ips[j] ? entry(ips[j], ui->thread, cb, arg) : 0;
+		if (ips[j]) {
+			ret = entry(ips[j], ui->thread, cb, arg);
+			if (ret)
+				break;
+			entries++;
+		}
 	}
 
-	return ret;
+	/*
+	 * Unwinder return contract:
+	 *  > 0 : unwinding succeeded (stops fallback).
+	 *    0 : unwinding failed without yielding frames. Ignore non-fatal errors
+	 *        (e.g. stepping failure) to allow fallback unwinder or kernel callchains.
+	 *  < 0 : fatal error (e.g. -ENOMEM). Aborts unwinding entirely.
+	 */
+	if (ret == -ENOMEM)
+		return -ENOMEM;
+	return (entries > 0 || ret == 0) ? entries : 0;
 }
 
 static int _unwind__get_entries(unwind_entry_cb_t cb, void *arg,
@@ -809,10 +824,10 @@ static int _unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 	};
 
 	if (!data->user_regs || !data->user_regs->regs)
-		return -EINVAL;
+		return 0;
 
 	if (max_stack <= 0)
-		return -EINVAL;
+		return 0;
 
 	return get_entries(&ui, cb, arg, max_stack);
 }
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index cb8be6acfb6f..a0016b897dae 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -79,7 +79,7 @@ void unwind__finish_access(struct maps *maps)
 		ops->finish_access(maps);
 }
 
-int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
+int libunwind__get_entries(unwind_entry_cb_t cb, void *arg,
 			 struct thread *thread,
 			 struct perf_sample *data, int max_stack,
 			 bool best_effort)
diff --git a/tools/perf/util/unwind.c b/tools/perf/util/unwind.c
new file mode 100644
index 000000000000..4ed4b1d55c69
--- /dev/null
+++ b/tools/perf/util/unwind.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "debug.h"
+#include "symbol_conf.h"
+#include "unwind.h"
+#include <linux/string.h>
+#include <string.h>
+#include <stdlib.h>
+
+int unwind__get_entries(unwind_entry_cb_t cb __maybe_unused, void *arg __maybe_unused,
+			struct thread *thread __maybe_unused,
+			struct perf_sample *data __maybe_unused,
+			int max_stack __maybe_unused,
+			bool best_effort __maybe_unused)
+{
+	int ret = 0;
+
+#if defined(HAVE_LIBDW_SUPPORT) || defined(HAVE_LIBUNWIND_SUPPORT)
+	if (symbol_conf.unwind_style[0] == UNWIND_STYLE_UNKNOWN) {
+		int i = 0;
+#ifdef HAVE_LIBDW_SUPPORT
+		symbol_conf.unwind_style[i++] = UNWIND_STYLE_LIBDW;
+#endif
+#ifdef HAVE_LIBUNWIND_SUPPORT
+		symbol_conf.unwind_style[i++] = UNWIND_STYLE_LIBUNWIND;
+#endif
+	}
+#endif //defined(HAVE_LIBDW_SUPPORT) || defined(HAVE_LIBUNWIND_SUPPORT)
+
+	for (size_t i = 0; i < ARRAY_SIZE(symbol_conf.unwind_style); i++) {
+		switch (symbol_conf.unwind_style[i]) {
+		case UNWIND_STYLE_LIBDW:
+			ret = libdw__get_entries(cb, arg, thread, data, max_stack, best_effort);
+			break;
+		case UNWIND_STYLE_LIBUNWIND:
+			ret = libunwind__get_entries(cb, arg, thread, data, max_stack, best_effort);
+			break;
+		case UNWIND_STYLE_UNKNOWN:
+		default:
+#if !defined(HAVE_LIBDW_SUPPORT) && !defined(HAVE_LIBUNWIND_SUPPORT)
+			pr_warning_once(
+				"Error: dwarf unwinding not supported, build perf with libdw or libunwind.\n");
+#endif
+			ret = 0;
+			break;
+		}
+		if (ret > 0) {
+			ret = 0;
+			break;
+		}
+		if (ret < 0)
+			break;
+	}
+	return ret;
+}
+
+int unwind__configure(const char *var, const char *value, void *cb __maybe_unused)
+{
+	static const char * const unwind_style_names[] = {
+		[UNWIND_STYLE_LIBDW] = "libdw",
+		[UNWIND_STYLE_LIBUNWIND] = "libunwind",
+		NULL
+	};
+	char *s, *p, *saveptr;
+	size_t i = 0;
+
+	if (strcmp(var, "unwind.style"))
+		return 0;
+
+	if (!value)
+		return -1;
+
+	s = strdup(value);
+	if (!s)
+		return -1;
+
+	memset(symbol_conf.unwind_style, 0, sizeof(symbol_conf.unwind_style));
+
+	p = strtok_r(s, ",", &saveptr);
+	while (p && i < ARRAY_SIZE(symbol_conf.unwind_style)) {
+		bool found = false;
+		char *q = strim(p);
+
+		for (size_t j = UNWIND_STYLE_LIBDW; j < MAX_UNWIND_STYLE; j++) {
+			if (!strcasecmp(q, unwind_style_names[j])) {
+				symbol_conf.unwind_style[i++] = j;
+				found = true;
+				break;
+			}
+		}
+		if (!found)
+			pr_warning("Unknown unwind style: %s\n", q);
+		p = strtok_r(NULL, ",", &saveptr);
+	}
+
+	free(s);
+	return 0;
+}
+
+int unwind__option(const struct option *opt __maybe_unused,
+		   const char *arg,
+		   int unset __maybe_unused)
+{
+	return unwind__configure("unwind.style", arg, NULL);
+}
diff --git a/tools/perf/util/unwind.h b/tools/perf/util/unwind.h
index 9f7164c6d9aa..28db3e3b9b51 100644
--- a/tools/perf/util/unwind.h
+++ b/tools/perf/util/unwind.h
@@ -4,9 +4,10 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
-#include "util/map_symbol.h"
+#include "map_symbol.h"
 
 struct maps;
+struct option;
 struct perf_sample;
 struct thread;
 
@@ -26,7 +27,9 @@ struct unwind_libunwind_ops {
 			   struct perf_sample *data, int max_stack, bool best_effort);
 };
 
-#ifdef HAVE_DWARF_UNWIND_SUPPORT
+int unwind__configure(const char *var, const char *value, void *cb);
+int unwind__option(const struct option *opt, const char *arg, int unset);
+
 /*
  * When best_effort is set, don't report errors and fail silently. This could
  * be expanded in the future to be more permissive about things other than
@@ -36,8 +39,31 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 			struct thread *thread,
 			struct perf_sample *data, int max_stack,
 			bool best_effort);
-/* libunwind specific */
+
+#ifdef HAVE_LIBDW_SUPPORT
+int libdw__get_entries(unwind_entry_cb_t cb, void *arg,
+		       struct thread *thread,
+		       struct perf_sample *data, int max_stack,
+		       bool best_effort);
+#else
+#include "debug.h"
+static inline int libdw__get_entries(unwind_entry_cb_t cb __maybe_unused, void *arg __maybe_unused,
+				     struct thread *thread __maybe_unused,
+				     struct perf_sample *data __maybe_unused,
+				     int max_stack __maybe_unused,
+				     bool best_effort __maybe_unused)
+{
+	pr_err("Error: libdw dwarf unwinding not built into perf\n");
+	return 0;
+}
+#endif
+
 #ifdef HAVE_LIBUNWIND_SUPPORT
+/* libunwind specific */
+int libunwind__get_entries(unwind_entry_cb_t cb, void *arg,
+			   struct thread *thread,
+			   struct perf_sample *data, int max_stack,
+			   bool best_effort);
 #ifndef LIBUNWIND__ARCH_REG_ID
 #define LIBUNWIND__ARCH_REG_ID(regnum) libunwind__arch_reg_id(regnum)
 #endif
@@ -47,25 +73,15 @@ int unwind__prepare_access(struct maps *maps, struct map *map, bool *initialized
 void unwind__flush_access(struct maps *maps);
 void unwind__finish_access(struct maps *maps);
 #else
-static inline int unwind__prepare_access(struct maps *maps __maybe_unused,
-					 struct map *map __maybe_unused,
-					 bool *initialized __maybe_unused)
-{
-	return 0;
-}
-
-static inline void unwind__flush_access(struct maps *maps __maybe_unused) {}
-static inline void unwind__finish_access(struct maps *maps __maybe_unused) {}
-#endif
-#else
-static inline int
-unwind__get_entries(unwind_entry_cb_t cb __maybe_unused,
-		    void *arg __maybe_unused,
-		    struct thread *thread __maybe_unused,
-		    struct perf_sample *data __maybe_unused,
-		    int max_stack __maybe_unused,
-		    bool best_effort __maybe_unused)
+#include "debug.h"
+static inline int libunwind__get_entries(unwind_entry_cb_t cb __maybe_unused,
+					 void *arg __maybe_unused,
+					 struct thread *thread __maybe_unused,
+					 struct perf_sample *data __maybe_unused,
+					 int max_stack __maybe_unused,
+					 bool best_effort __maybe_unused)
 {
+	pr_err("Error: libunwind dwarf unwinding not built into perf\n");
 	return 0;
 }
 
@@ -78,5 +94,6 @@ static inline int unwind__prepare_access(struct maps *maps __maybe_unused,
 
 static inline void unwind__flush_access(struct maps *maps __maybe_unused) {}
 static inline void unwind__finish_access(struct maps *maps __maybe_unused) {}
-#endif /* HAVE_DWARF_UNWIND_SUPPORT */
+#endif
+
 #endif /* __UNWIND_H */
-- 
2.54.0.563.g4f69b47b94-goog

