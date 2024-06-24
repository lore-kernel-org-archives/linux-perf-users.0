Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A651A01C8;
	Mon, 24 Jun 2024 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252736; cv=none; b=aR17g0+vYLtwbaCfAeA3iEKfJ4mUDwFVeeRHoO//sjgt2/CVN89EAvoV+miwG31FAX01IqsiTeTIiVkVQ+1Df2NCTspeXoHlxuGWV3lZujG/sbVHqMWuXV+riMpqcQCen0HauoAmsts4IOJOiTg/fjySwke1vizm8yrp6dxFIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252736; c=relaxed/simple;
	bh=gY0vqIVyUSNtrEY12S2m/VtNGGIyLvl7wC5AjoLQHc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyAMg0xva9Yc8WZ6SISxqrl2O1ukrzbuuVZ8Yefbsyr/l2O+6FphiUYEZ0G7UoKpUC1QjcVUwcnKDJ89dNczjfaR61LgqJrPXA1J8YPuIHMZGUnJ30vOikNNEbT4eSMXtNnpfsyn5AnujfZOPuWyOCV0keH67eRy0bSzHpi0QXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkBBlo32; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkBBlo32"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6eab07ae82bso3231886a12.3;
        Mon, 24 Jun 2024 11:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719252734; x=1719857534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dallcXeut594oIefpaki2C5DN0vhvYg7qZx87rwFjg=;
        b=EkBBlo32vO0nTdNO5pOSxIA/txX6bpcRWF0Kt0XlYevVhenseUa6uzQonvfORq770U
         xFDlkvOG+TZ8jJ8keE6CTD8sQ5wHqEH6Bdr+Lj7vp27zBYao2cfkvvh+Uf3uLEQZrIQP
         hiUe1yJTwoTkWcymAKIrNYnB/6XTk++A7hevdGetCFmB+QWAorDIFy4b1igQQuGu1dyL
         mfSRWlIZoA6SG9afHM5jKNuVeqKU8rdkpAukh90yhyA3b/gplk932HeKV6Q8DEwYM1zm
         BSmlunz88ZIIDkXNmAd+g/cAV1Sq+DNEf7PIrwWZIIuK1SbNK/DNI7qwXQpciAMhzmSc
         sk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719252734; x=1719857534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dallcXeut594oIefpaki2C5DN0vhvYg7qZx87rwFjg=;
        b=PJ2WvQkez31kZbG9iK8hnhF1xqghP7G2Eu8viELmdGnKN9kf5p6Mm5p/Y+1JjHP/Ny
         8Eh3rbNKnmyJfZ5d18lknGcD8M7qtr1hj8UL2qQ5GOlr9G4rYNVvzX1Cfr61U1sAVH5i
         kPRzkkNrz2pV0ZiSqFyHq3RFM2XJugBX0R4Ov58GJYxPqX15HHP9la8QiEGy7ej8VoqB
         INCxknv6fXA9lPrOrkjsXs8/9mEVu6pfcJMFWaYjR0twMoY8qI13Q2TmwzHrEFd+TUbn
         MbWAT7V5wfDj+CNVnd2OzDtlae7pKFS9Z73pDaudQO5cSdEGFtZtdVujJJu/IRqDDBW8
         Wgwg==
X-Forwarded-Encrypted: i=1; AJvYcCWBJpyQKMMAstJUj/wkhbvGu+AOg48T96pwMblL+J0jNMMqqhQ03uHCc+y5sNizKbgJjxNwbCg2PHCexy7o43z9+7j0xRQMF/HurvzXUpZZui7WzJIQqxFQr9pR400dj5zKGG54g4uVzKwLMQJGUw==
X-Gm-Message-State: AOJu0Ywirl2RGMcn8Xsyudw+p6CcbN/vQVJbeG1WxiQFC90/t3v0s7W7
	ExzB0QMH/ZjApc5lEqL1GDwpbloSDKlQ5Rr/8mSYyuXDWtQkxHHO
X-Google-Smtp-Source: AGHT+IHSmQIeHhBpZxfTj3BhjA8mR0xQdxu+b7cyDgGOlG7NcvatuMtuM9KCPUYcVbh0nOVaTsr0UA==
X-Received: by 2002:a05:6a20:7517:b0:1af:cecb:b64a with SMTP id adf61e73a8af0-1bcf7e6f8c1mr3801959637.9.1719252733828;
        Mon, 24 Jun 2024 11:12:13 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651290157sm6525157b3a.150.2024.06.24.11.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 11:12:13 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 2/8] perf trace: BTF-based enum pretty printing for syscall args
Date: Tue, 25 Jun 2024 02:13:39 +0800
Message-ID: <20240624181345.124764-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624181345.124764-1-howardchu95@gmail.com>
References: <20240624181345.124764-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In this patch, BTF is used to turn enum value to the corresponding
name. There is only one system call that uses enum value as its
argument, that is `landlock_add_rule()`.

The vmlinux btf is loaded lazily, when user decided to trace the
`landlock_add_rule` syscall. But if one decide to run `perf trace`
without any arguments, the behaviour is to trace `landlock_add_rule`,
so vmlinux btf will be loaded by default.

The laziest behaviour is to load vmlinux btf when a
`landlock_add_rule` syscall hits. But I think you could lose some
samples when loading vmlinux btf at run time, for it can delay the
handling of other samples. I might need your precious opinions on
this...

before:

```
perf $ ./perf trace -e landlock_add_rule
     0.000 ( 0.008 ms): ldlck-test/438194 landlock_add_rule(rule_type: 2) = -1 EBADFD (File descriptor in bad state)
     0.010 ( 0.001 ms): ldlck-test/438194 landlock_add_rule(rule_type: 1) = -1 EBADFD (File descriptor in bad state)
```

after:

```
perf $ ./perf trace -e landlock_add_rule
     0.000 ( 0.029 ms): ldlck-test/438194 landlock_add_rule(rule_type: LANDLOCK_RULE_NET_PORT)     = -1 EBADFD (File descriptor in bad state)
     0.036 ( 0.004 ms): ldlck-test/438194 landlock_add_rule(rule_type: LANDLOCK_RULE_PATH_BENEATH) = -1 EBADFD (File descriptor in bad state)
```

Committer notes:

Made it build with NO_LIBBPF=1, simplified btf_enum_fprintf(), see [1]
for the discussion.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Günther Noack <gnoack@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mickaël Salaün <mic@digikod.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/20240613022757.3589783-1-howardchu95@gmail.com
Link: https://lore.kernel.org/lkml/ZnXAhFflUl_LV1QY@x1 # [1]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 110 +++++++++++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c4fa8191253d..24e751bc0ecd 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -19,6 +19,7 @@
 #ifdef HAVE_LIBBPF_SUPPORT
 #include <bpf/bpf.h>
 #include <bpf/libbpf.h>
+#include <bpf/btf.h>
 #ifdef HAVE_BPF_SKEL
 #include "bpf_skel/augmented_raw_syscalls.skel.h"
 #endif
@@ -110,6 +111,10 @@ struct syscall_arg_fmt {
 	const char *name;
 	u16	   nr_entries; // for arrays
 	bool	   show_zero;
+	bool	   is_enum;
+#ifdef HAVE_LIBBPF_SUPPORT
+	const struct btf_type *type;
+#endif
 };
 
 struct syscall_fmt {
@@ -139,6 +144,9 @@ struct trace {
 	} syscalls;
 #ifdef HAVE_BPF_SKEL
 	struct augmented_raw_syscalls_bpf *skel;
+#endif
+#ifdef HAVE_LIBBPF_SUPPORT
+	struct btf		*btf;
 #endif
 	struct record_opts	opts;
 	struct evlist	*evlist;
@@ -204,6 +212,20 @@ struct trace {
 	} oe;
 };
 
+static void trace__load_vmlinux_btf(struct trace *trace __maybe_unused)
+{
+#ifdef HAVE_LIBBPF_SUPPORT
+	if (trace->btf != NULL)
+		return;
+
+	trace->btf = btf__load_vmlinux_btf();
+	if (verbose > 0) {
+		fprintf(trace->output, trace->btf ? "vmlinux BTF loaded\n" :
+						    "Failed to load vmlinux BTF\n");
+	}
+#endif
+}
+
 struct tp_field {
 	int offset;
 	union {
@@ -887,6 +909,64 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 
 #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
 
+#ifdef HAVE_LIBBPF_SUPPORT
+static int syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_fmt, struct btf *btf, char *type)
+{
+	int id;
+
+	// Already cached?
+	if (arg_fmt->type != NULL)
+		return 0;
+
+	type = strstr(type, "enum ");
+	if (type == NULL)
+		return -1;
+
+	type += 5; // skip "enum " to get the enumeration name
+
+	id = btf__find_by_name(btf, type);
+	if (id < 0)
+		return -1;
+
+	arg_fmt->type = btf__type_by_id(btf, id);
+	return arg_fmt->type == NULL ? -1 : 0;
+}
+
+static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, char *bf, size_t size, int val)
+{
+	struct btf_enum *be = btf_enum(type);
+	const int nr_entries = btf_vlen(type);
+
+	for (int i = 0; i < nr_entries; ++i, ++be) {
+		if (be->val == val) {
+			return scnprintf(bf, size, "%s",
+					 btf__name_by_offset(btf, be->name_off));
+		}
+	}
+
+	return 0;
+}
+
+static size_t trace__btf_enum_scnprintf(struct trace *trace, struct syscall_arg_fmt *arg_fmt, char *bf,
+					size_t size, int val, char *type)
+{
+	if (trace->btf == NULL)
+		return 0;
+
+	if (syscall_arg_fmt__cache_btf_enum(arg_fmt, trace->btf, type) < 0)
+		return 0;
+
+	return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
+}
+#else // HAVE_LIBBPF_SUPPORT
+static size_t trace__btf_enum_scnprintf(struct trace *trace __maybe_unused, struct syscall_arg_fmt *arg_fmt __maybe_unused,
+					char *bf __maybe_unused, size_t size __maybe_unused, int val __maybe_unused,
+					char *type __maybe_unused)
+{
+	return 0;
+}
+#endif // HAVE_LIBBPF_SUPPORT
+
 #define STRARRAY(name, array) \
 	  { .scnprintf	= SCA_STRARRAY, \
 	    .strtoul	= STUL_STRARRAY, \
@@ -1238,6 +1318,7 @@ struct syscall {
 	bool		    is_exit;
 	bool		    is_open;
 	bool		    nonexistent;
+	bool		    use_btf;
 	struct tep_format_field *args;
 	const char	    *name;
 	const struct syscall_fmt  *fmt;
@@ -1744,7 +1825,8 @@ static const struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *n
 }
 
 static struct tep_format_field *
-syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field)
+syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field,
+			    bool *use_btf)
 {
 	struct tep_format_field *last_field = NULL;
 	int len;
@@ -1756,6 +1838,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			continue;
 
 		len = strlen(field->name);
+		arg->is_enum = false;
 
 		if (strcmp(field->type, "const char *") == 0 &&
 		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
@@ -1782,6 +1865,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			 * 7 unsigned long
 			 */
 			arg->scnprintf = SCA_FD;
+		} else if (strstr(field->type, "enum") && use_btf != NULL) {
+			*use_btf = arg->is_enum = true;
 		} else {
 			const struct syscall_arg_fmt *fmt =
 				syscall_arg_fmt__find_by_name(field->name);
@@ -1798,7 +1883,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 
 static int syscall__set_arg_fmts(struct syscall *sc)
 {
-	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args);
+	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args,
+									  &sc->use_btf);
 
 	if (last_field)
 		sc->args_size = last_field->offset + last_field->size;
@@ -1811,6 +1897,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	char tp_name[128];
 	struct syscall *sc;
 	const char *name = syscalltbl__name(trace->sctbl, id);
+	int err;
 
 #ifdef HAVE_SYSCALL_TABLE_SUPPORT
 	if (trace->syscalls.table == NULL) {
@@ -1883,7 +1970,13 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
 	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
 
-	return syscall__set_arg_fmts(sc);
+	err = syscall__set_arg_fmts(sc);
+
+	/* after calling syscall__set_arg_fmts() we'll know whether use_btf is true */
+	if (sc->use_btf)
+		trace__load_vmlinux_btf(trace);
+
+	return err;
 }
 
 static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
@@ -1891,7 +1984,7 @@ static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
 	struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
 
 	if (fmt != NULL) {
-		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields);
+		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields, NULL);
 		return 0;
 	}
 
@@ -2103,6 +2196,15 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (trace->show_arg_names)
 				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
+			if (sc->arg_fmt[arg.idx].is_enum) {
+				size_t p = trace__btf_enum_scnprintf(trace, &sc->arg_fmt[arg.idx], bf + printed,
+								     size - printed, val, field->type);
+				if (p) {
+					printed += p;
+					continue;
+				}
+			}
+
 			printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
 								  bf + printed, size - printed, &arg, val);
 		}
-- 
2.45.2

