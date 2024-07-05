Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEBB1474B7;
	Fri,  5 Jul 2024 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720172582; cv=none; b=mxAiA0xKQKX+wKKB4Xq4+4fs/r59SbcOOVgjryGBmVB6EmUYR2v8n0IlyRIDi6I7b/+QgXuFCJb7ZeLHHwTCcKrSjWpirRriVdqS+qzZBCH0aPaZcLA+G2NXFMRTp2l9qXoWlPBQJbdwpjZ1LwGAUp/MjiH/tchiVODFe3XEKZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720172582; c=relaxed/simple;
	bh=SIR9uo5jBHA4ojUDJSYvUwgfou2A3ePKJvZDSyXEPWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZRKkb0e3lbh/bARvHFQsI+fuzHHpP05k6q0xY7Lx9l9AAqq2gosZdky2NR8nMs7G9YIw/PwmgSphtFEAjvkybmduYorNHHI79EfvKNgD1ALXGgtPvPFAWBdYVnnUQo+edHuEJIhOX7llqWBE+q7slHJj1jBehcPLeAphFoAAN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FL6k8Xhn; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FL6k8Xhn"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c96f037145so1062502a91.3;
        Fri, 05 Jul 2024 02:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720172580; x=1720777380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXuX9LroFfrWSjjWC3sm96qQ6X5CtfodhnxL67G+Hzk=;
        b=FL6k8XhnuIlsaT6XE2tdxHNA1proQ07hJHJcapMU2DPsbaydbNtxBrb3ziqQHbhyjl
         u3PrxZiBO5MKFR9G19Kj41aq0Axo0854rPUnfWAgmLhS2TcjlQks2NZN4v8rwR7gpRPm
         kHdRbyqglC7THUznLnra+BqZv3sediSdtKtR1/rspyHTSwgdxmV+8cL50gWMqbUDZSfH
         HoCETHluYL5kP9TIhped01IsXMGnQ9aPrikb0mILyzLcaNH0LW22gRdf9z/n7mIbPBYS
         nshYe/CUuKjXLmL9SKELDjh3JDkqH0F+b7GbbbQlGVNaM/DCKuZ4JWGcB0k3D9SnuinW
         v8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720172580; x=1720777380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZXuX9LroFfrWSjjWC3sm96qQ6X5CtfodhnxL67G+Hzk=;
        b=Jauz+xhwATp73fx972VjOPNNBY682pZvO+pO+FaMy2EMpi57SVePUrWFkQRs/aTtFS
         CCQMz2QHUuCzbLAnZjCDYG9h/pd5Okek/pVN7r5GI27Hd7fhY3x87/LlK02cYqLh36/x
         +TSJVvCnClmjy3PwBhn92u+xH31ynw7h4x+Zy6xebzG5hr5fC3v1q9280PDGRD01g2Va
         Oj+5pbBG1UY+QwM4tM6/oqT/naIS72gQ5BUc9whaEtFJS8Aob2p0SPhrb/CytWPHySVn
         shAwZ9ynmCVdjmym+g4v0VMVuKWjmcWgJTo3zF3mmPof4LzqyUPO6ZH2uqEGEbgqUYoM
         KoEw==
X-Forwarded-Encrypted: i=1; AJvYcCWmr9mvwd6zvWN6+e+/zQf8KdiqTaj+0+O35oz64ftTjjfJrQuqqVbSvw65jW94bDLdzzGTC4hPUZUNfh5/MLAykJhICB7LYPmVr6V+OYM9T36pdvdK5vhb6CZsYqvv4WT9So/IublmspGuUh/jgw==
X-Gm-Message-State: AOJu0YxggrJ6RzDZnmok9rgUPPhPO+1a930EYtxe750ClY/cVi/7KfiM
	QJ64xZVRLfefBLXqDPq4g5itDq1yp5p3iLZZrnlPGzTl48H6OPB6ZKpSipkYOeY=
X-Google-Smtp-Source: AGHT+IGKkfUZ6DlqQ8AWUF9wgJ3QmVdonI652zcmMU/RuSLme3QGD3S59vb9GCnP0SjJYVmXpchTvA==
X-Received: by 2002:a17:90b:19d2:b0:2c7:c788:d34d with SMTP id 98e67ed59e1d1-2c99c6b3733mr3180082a91.38.1720172579570;
        Fri, 05 Jul 2024 02:42:59 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a9cd133sm2958138a91.38.2024.07.05.02.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:42:59 -0700 (PDT)
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
Subject: [PATCH v5 2/8] perf trace: BTF-based enum pretty printing for syscall args
Date: Fri,  5 Jul 2024 17:42:54 +0800
Message-ID: <20240705094300.585156-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705094300.585156-1-howardchu95@gmail.com>
References: <20240705094300.585156-1-howardchu95@gmail.com>
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
Link: https://lore.kernel.org/r/20240624181345.124764-3-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 110 +++++++++++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 8449f2beb54d..1391564911d9 100644
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

