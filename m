Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A02227E95
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Jan 2026 04:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768104833; cv=none; b=IS4moGZ8Ph+1yuVUrqBOe5OYZwwtrICXJGQXh3k5y0aaXGwm6y1T1V+phACrXyJxL/trT++aEWKHG9/s8A7UMOgEWoV06pNwnXdihPrgauOOvR7OJruDHRuz14JGcg4r1Np5AF4zmfUXDJgo8VA9WVSisL+hMnm9jcYbobpL6q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768104833; c=relaxed/simple;
	bh=pnkoaS3BDyegUiypzuayNhPPwN3jB4XGtFWuYD1ZLdE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SDn6un3aG3JxFdounbpIyThSZsvf9eEdku/tIhhZWeTeQgJNYMQ+UkVC9UznqjQ5Zk9F51zhbPGgVW3I1C+5hyxyJTHif/Wja1q1peyA8u69BR/E5Nk64xlZxYj0G5c2+muVjr+gfyoRRlMZ2ERlCj5x8HcYBNqtklD0iNtKkXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LrepVoXf; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LrepVoXf"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-11f3b5411c7so14261418c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2026 20:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768104831; x=1768709631; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=79Lm5r+aff6tOMggRex7lERHHcu3vz/+dw8OY+TEe/4=;
        b=LrepVoXfGoFd2dOhKEVMwALNB+R1Zq56xMKJiqu9u4jAEt+WjzjwNW5it2iNmFZTR0
         B2CtbDR3jJ2dbCZT0JSRR0HsDFzF0mUVYr7fi4G/hIX624NVUoGMPu/Q37h9V+nPaFzD
         no4bD1FJIf215uWz7QGyg264czw6fE8yj8w6MwokRCdBGTOKgtICLZqSi2dQ3tkoWV8f
         ksFTBegZwivSmZJg+pviD8+doKikxxWwi4AZ269kExM/4TXx1/O6iL/OtMZfvI2rdIB5
         tuvs9aUDd+JsVA7Xh2Rh7TaNKbqfvyFERzVb178TwzwASWscCIVYxiZP4dCYo+4VliK4
         +lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768104831; x=1768709631;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79Lm5r+aff6tOMggRex7lERHHcu3vz/+dw8OY+TEe/4=;
        b=X+pdcDWGnJwvjbPIOgyr8yxkFNKi7YJje9vPx6eMpe11tp4TAtNzsl8/FiwTnLblKw
         k213ChH1NAJIw5CKlHFJVGn63JOGm9oQeMXAD3cvqkuSNV+lkXfEs2Vii2Yep+N9mVrg
         D3GfoVhLnFSiI17KuvaMKYSXFZmtRBlBm3swBurfS2ubPrX77LfgvQyaTgmddgj5dEC/
         Z9+afVM0I2oQ96+f6NOPp7bv/DD9JKEaKWjFYn8b08i03rylaKx7+RZtlUVMdlTTXw8O
         XM96KYIPQpjosTkpBrnh06SaQipFbyPzaFAmm63Vxq0MyWX7HeG63e5+B2sCPJ3Vk13a
         2btw==
X-Forwarded-Encrypted: i=1; AJvYcCWw/vhxN0GMxPnfQfPyRoLfXw/ZUReam97QvY/7pVLioWc3L4MFyPauW+2z7S30Tq8YEKrezLrPngixM2EOEHVP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx30M1Rc2gPLAKAjqWOQrNk8ncEhcjwkPj8HUH0fNmDZeSVLMJk
	KxfUTLtEve8fJ8Y5W32wnhoOW3x0TV5+ntEWx9YDSn9XT+qGzvdfXUJuqVgHfWvUEEzPEih49Vh
	eEp1CxoQzIg==
X-Google-Smtp-Source: AGHT+IExjh+icGjuEXfliQJ9KapJZef9WEJHe8V8zlsgQpc6W/MNOCCxaTHKhh88Wrjgkd9wUAI/2rl0W8L7
X-Received: from dlbbq37.prod.google.com ([2002:a05:7022:6725:b0:11f:45c3:e5f6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f86:b0:119:e569:fb9a
 with SMTP id a92af1059eb24-121f8ab6642mr16108366c88.9.1768104830976; Sat, 10
 Jan 2026 20:13:50 -0800 (PST)
Date: Sat, 10 Jan 2026 20:13:35 -0800
In-Reply-To: <20260111041338.1817056-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260111041338.1817056-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260111041338.1817056-5-irogers@google.com>
Subject: [PATCH v3 4/7] perf srcline: Add configuration support for the
 addr2line style
From: Ian Rogers <irogers@google.com>
To: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow the addr2line style to be specified on the `perf report` command
line or in the .perfconfig file.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-report.c   | 10 ++++
 tools/perf/util/config.c      |  4 ++
 tools/perf/util/srcline.c     | 98 +++++++++++++++++++++++++++++++----
 tools/perf/util/srcline.h     |  2 +
 tools/perf/util/symbol_conf.h | 10 ++++
 5 files changed, 113 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 6c2b4f93ec78..2e936928e8c0 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1271,6 +1271,13 @@ parse_percent_limit(const struct option *opt, const char *str,
 	return 0;
 }
 
+static int
+report_parse_addr2line_config(const struct option *opt __maybe_unused,
+			      const char *arg, int unset __maybe_unused)
+{
+	return addr2line_configure("addr2line.style", arg, NULL);
+}
+
 static int process_attr(const struct perf_tool *tool __maybe_unused,
 			union perf_event *event,
 			struct evlist **pevlist)
@@ -1447,6 +1454,9 @@ int cmd_report(int argc, const char **argv)
 		   "objdump binary to use for disassembly and annotations"),
 	OPT_STRING(0, "addr2line", &addr2line_path, "path",
 		   "addr2line binary to use for line numbers"),
+	OPT_CALLBACK(0, "addr2line-style", NULL, "addr2line style",
+		     "addr2line styles (libdw,llvm,libbfd,addr2line)",
+		     report_parse_addr2line_config),
 	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
 		    "Symbol demangling. Enabled by default, use --no-demangle to disable."),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index e0219bc6330a..0452fbc6c085 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -20,6 +20,7 @@
 #include "util/stat.h"  /* perf_stat__set_big_num */
 #include "util/evsel.h"  /* evsel__hw_names, evsel__use_bpf_counters */
 #include "util/addr2line.h"  /* addr2line_timeout_ms */
+#include "srcline.h"
 #include "build-id.h"
 #include "debug.h"
 #include "config.h"
@@ -519,6 +520,9 @@ int perf_default_config(const char *var, const char *value,
 	if (strstarts(var, "stat."))
 		return perf_stat_config(var, value);
 
+	if (strstarts(var, "addr2line."))
+		return addr2line_configure(var, value, dummy);
+
 	/* Add other config variables here. */
 	return 0;
 }
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index e2d280678b02..28fa1abd1fd3 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -7,9 +7,11 @@
 #include "llvm.h"
 #include "symbol.h"
 #include "libdw.h"
+#include "debug.h"
 
 #include <inttypes.h>
 #include <string.h>
+#include <linux/string.h>
 
 bool srcline_full_filename;
 
@@ -138,21 +140,95 @@ static int addr2line(const char *dso_name, u64 addr, char **file, unsigned int *
 		     struct dso *dso, bool unwind_inlines, struct inline_node *node,
 		     struct symbol *sym)
 {
-	int ret;
+	int ret = 0;
+
+	if (symbol_conf.addr2line_style[0] == A2L_STYLE_UNKNOWN) {
+		int i = 0;
+
+		/* Default addr2line fallback order. */
+#ifdef HAVE_LIBDW_SUPPORT
+		symbol_conf.addr2line_style[i++] = A2L_STYLE_LIBDW;
+#endif
+#ifdef HAVE_LIBLLVM_SUPPORT
+		symbol_conf.addr2line_style[i++] = A2L_STYLE_LLVM;
+#endif
+#ifdef HAVE_LIBBFD_SUPPORT
+		symbol_conf.addr2line_style[i++] = A2L_STYLE_LIBBFD;
+#endif
+		symbol_conf.addr2line_style[i++] = A2L_STYLE_CMD;
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(symbol_conf.addr2line_style); i++) {
+		switch (symbol_conf.addr2line_style[i]) {
+		case A2L_STYLE_LIBDW:
+			ret = libdw__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines,
+					       node, sym);
+			break;
+		case A2L_STYLE_LLVM:
+			ret = llvm__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines,
+					      node, sym);
+			break;
+		case A2L_STYLE_LIBBFD:
+			ret = libbfd__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines,
+						node, sym);
+			break;
+		case A2L_STYLE_CMD:
+			ret = cmd__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines,
+					     node, sym);
+			break;
+		case A2L_STYLE_UNKNOWN:
+		default:
+			break;
+		}
+		if (ret > 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+int addr2line_configure(const char *var, const char *value, void *cb __maybe_unused)
+{
+	static const char * const a2l_style_names[] = {
+		[A2L_STYLE_LIBDW] = "libdw",
+		[A2L_STYLE_LLVM] = "llvm",
+		[A2L_STYLE_LIBBFD] = "libbfd",
+		[A2L_STYLE_CMD] = "addr2line",
+		NULL
+	};
+
+	char *s, *p, *saveptr;
+	size_t i = 0;
 
-	ret = libdw__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines, node, sym);
-	if (ret > 0)
-		return ret;
+	if (strcmp(var, "addr2line.style"))
+		return 0;
+
+	if (!value)
+		return -1;
 
-	ret = llvm__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines, node, sym);
-	if (ret > 0)
-		return ret;
+	s = strdup(value);
+	if (!s)
+		return -1;
 
-	ret = libbfd__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines, node, sym);
-	if (ret > 0)
-		return ret;
+	p = strtok_r(s, ",", &saveptr);
+	while (p && i < ARRAY_SIZE(symbol_conf.addr2line_style)) {
+		bool found = false;
+		char *q = strim(p);
+
+		for (size_t j = A2L_STYLE_LIBDW; j < MAX_A2L_STYLE; j++) {
+			if (!strcasecmp(q, a2l_style_names[j])) {
+				symbol_conf.addr2line_style[i++] = j;
+				found = true;
+				break;
+			}
+		}
+		if (!found)
+			pr_warning("Unknown addr2line style: %s\n", q);
+		p = strtok_r(NULL, ",", &saveptr);
+	}
 
-	return cmd__addr2line(dso_name, addr, file, line_nr, dso, unwind_inlines, node, sym);
+	free(s);
+	return 0;
 }
 
 static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index be9f002bf234..7c37b3bf9ce7 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -63,4 +63,6 @@ struct symbol *new_inline_sym(struct dso *dso,
 			      struct symbol *base_sym,
 			      const char *funcname);
 
+int addr2line_configure(const char *var, const char *value, void *cb);
+
 #endif /* PERF_SRCLINE_H */
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 7a80d2c14d9b..71bb17372a6c 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -9,6 +9,15 @@
 struct strlist;
 struct intlist;
 
+enum a2l_style {
+	A2L_STYLE_UNKNOWN = 0,
+	A2L_STYLE_LIBDW,
+	A2L_STYLE_LLVM,
+	A2L_STYLE_LIBBFD,
+	A2L_STYLE_CMD,
+};
+#define MAX_A2L_STYLE (A2L_STYLE_CMD + 1)
+
 struct symbol_conf {
 	bool		nanosecs;
 	unsigned short	priv_size;
@@ -70,6 +79,7 @@ struct symbol_conf {
 			*col_width_list_str,
 			*bt_stop_list_str;
 	const char		*addr2line_path;
+	enum a2l_style	addr2line_style[MAX_A2L_STYLE];
 	unsigned long	time_quantum;
        struct strlist	*dso_list,
 			*comm_list,
-- 
2.52.0.457.g6b5491de43-goog

