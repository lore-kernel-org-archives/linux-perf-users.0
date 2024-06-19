Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FA07C6C1;
	Wed, 19 Jun 2024 08:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785197; cv=none; b=Pe+fQx0veoJ8pV77+TKNhl6FLzhOyAtfkAetvlBSTKui36vnKsKWvzQ/IibF/K02+jURAueDHUffHhuT8RAyebnj9wSG9PLwTyHq/bgHXVWiQtxsmw6PdjYUAwoThQDunELH3+HAZHz5Mijtj/r7EMWFowtlZMvA/xh5Ggg5AY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785197; c=relaxed/simple;
	bh=qdaNtK9EB4Ck/5vp1XqOAD1xTtT9Qv/aF1nnKk6JNwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltMuCnmEuSb87+cx1fZbcYrYdNZ2JJSP4ry34lez0SS2ZTttzuLKEnVgHm1QYOPbJ2kz2SgGAq9jv8Fwq2w0RXAYZ3FtFI6bvzS8+yJ+MmV6xVKQySAcepBMASozUr0UIFCdZH/6oGA+rVbYPwdWj5HzNRURa0a93qqJpRkIbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1UWidPT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1UWidPT"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f47f07acd3so55778225ad.0;
        Wed, 19 Jun 2024 01:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718785195; x=1719389995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6Qt0EHXAUTtq4/0TMQZ2s1bx5CcrwV1JbUBnKEe+5k=;
        b=X1UWidPTbZc5XYldL19YCl/7tswzDCuZMu8nm5e3CSG2q43kMj6wpBXZYosXoucHPH
         3HsNUXjKjPW+jqJBf1xnJ9aVZ4hjHPSj4dPMyeOrQ5Z/bkpUDIh8rogXxHx7v4p0nyxi
         wL+cEyAEArZAsqOJNpP4O0yCAHGCr2W4qbuHDqt3oJ1ewMucNSlewzQw3s5HI9CnVW28
         tzL0yJgwt28aYRL8/PZxyOPSU79jSJXlx9Xhb/HuSOBP4sVleesHmJPtmztZdqHQ4bNR
         rVIKYbKL/DQ5FPT94my+IABm3yQH42xhzyvENvexCrDCbnE1vkCLq+rHaKHcCCeTqYRi
         WejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718785195; x=1719389995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6Qt0EHXAUTtq4/0TMQZ2s1bx5CcrwV1JbUBnKEe+5k=;
        b=lS1NEjsAKQaMAnjMNhXj5poXiSY4MRR1K5sfJILYI2o7ZmBQ2JeZhQPUvgimF14O1H
         YBKM8D904d8duWO/Y3hRu5JO4W6NDQ4hiFaYokG+NsPr0xlFeQ881WKeyYEmMIXwRlt8
         FyhRc1ttIF8qo9svyJh9yt42st74Vu4k6ZsuUocXa3sEkvvX3L6DRci16KpLMocTbk8a
         LUFcUbDXRXepdW100hMvxzfDINkBohBtwZUTUucGAUHmD3ebnDHrjEcoh8shMznpVqUh
         a8OwqiX1Ba4I4YjTVOijXWR7aTRw4HwSMwsHNM8aABjLkKqrB/pa8TvyYkmJVJOaOlxV
         CMTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcSxT11pfmFvB7keb7GDH6wrXl9gbCCjswsuDo3xLqBp0GES2LjMAUpGl8F1BrRrfX/+BUuPBvENsUgx0CIHiaz/9c889HWd72GJzNCjv+DeDC1gQOeEUNnbbCjBcVAYtoXv28kDCFcJ0MVprsQA==
X-Gm-Message-State: AOJu0YxEuE0WfAzM6Vh7fVs5IOu3P9CYYgeX5552IHKIylH7nOjMMTcY
	RokOBUmKUKYLXaThNoujyLuaycsXnHP317OI6HndcRfhvzUUMkWW
X-Google-Smtp-Source: AGHT+IGe8MRHENq1Xo0otKWgPn4GgKTE+z5YKmSlFLt+2zmE1shF4i9vHHF7fJ5CUdPeXiXMTIbXCg==
X-Received: by 2002:a17:902:d482:b0:1f7:17c2:116f with SMTP id d9443c01a7336-1f9aa459da1mr23013585ad.53.1718785194909;
        Wed, 19 Jun 2024 01:19:54 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1decfsm110368105ad.250.2024.06.19.01.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:19:54 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 2/5] perf trace: Augment enum syscall arguments with BTF
Date: Wed, 19 Jun 2024 16:20:39 +0800
Message-ID: <20240619082042.4173621-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619082042.4173621-1-howardchu95@gmail.com>
References: <20240619082042.4173621-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a feature implemented on the basis of the previous bug fix
https://lore.kernel.org/linux-perf-users/d18a9606-ac9f-4ca7-afaf-fcf4c951cb90@web.de/T/#t

In this patch, BTF is used to turn enum value to the corresponding
enum variable name. There is only one system call that uses enum value
as its argument, that is `landlock_add_rule()`.

The vmlinux btf is loaded lazily, when user decided to trace the
`landlock_add_rule` syscall. But if one decides to run `perf trace`
without any arguments, the behaviour is to trace `landlock_add_rule`,
so vmlinux btf will be loaded by default.

before:

```
perf $ ./perf trace -e landlock_add_rule
     0.000 ( 0.008 ms): ldlck-test/438194 landlock_add_rule(rule_type: 2)                                       = -1 EBADFD (File descriptor in bad state)
     0.010 ( 0.001 ms): ldlck-test/438194 landlock_add_rule(rule_type: 1)                                       = -1 EBADFD (File descriptor in bad state)
```

after:

```
perf $ ./perf trace -e landlock_add_rule
     0.000 ( 0.029 ms): ldlck-test/438194 landlock_add_rule(rule_type: LANDLOCK_RULE_NET_PORT)                  = -1 EBADFD (File descriptor in bad state)
     0.036 ( 0.004 ms): ldlck-test/438194 landlock_add_rule(rule_type: LANDLOCK_RULE_PATH_BENEATH)              = -1 EBADFD (File descriptor in bad state)
```
Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c | 96 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c4fa8191253d..d93f34e9af74 100644
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
@@ -110,6 +111,11 @@ struct syscall_arg_fmt {
 	const char *name;
 	u16	   nr_entries; // for arrays
 	bool	   show_zero;
+	bool	   is_enum;
+	struct {
+		void	*entries;
+		u16	nr_entries;
+	}	   btf_entry;
 };
 
 struct syscall_fmt {
@@ -140,6 +146,7 @@ struct trace {
 #ifdef HAVE_BPF_SKEL
 	struct augmented_raw_syscalls_bpf *skel;
 #endif
+	struct btf		*btf;
 	struct record_opts	opts;
 	struct evlist	*evlist;
 	struct machine		*host;
@@ -897,6 +904,56 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 	    .strtoul	= STUL_STRARRAY_FLAGS, \
 	    .parm	= &strarray__##array, }
 
+static int btf_enum_find_entry(struct btf *btf, char *type, struct syscall_arg_fmt *arg_fmt)
+{
+	const struct btf_type *bt;
+	char enum_prefix[][16] = { "enum", "const enum" }, *ep;
+	int id;
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(enum_prefix); i++) {
+		ep = enum_prefix[i];
+		if (strlen(type) > strlen(ep) + 1 && strstarts(type, ep))
+			type += strlen(ep) + 1;
+	}
+
+	id = btf__find_by_name(btf, type);
+	if (id < 0)
+		return -1;
+
+	bt = btf__type_by_id(btf, id);
+	if (bt == NULL)
+		return -1;
+
+	arg_fmt->btf_entry.entries    = btf_enum(bt);
+	arg_fmt->btf_entry.nr_entries = btf_vlen(bt);
+
+	return 0;
+}
+
+static size_t btf_enum_scnprintf(char *bf, size_t size, int val, struct btf *btf, char *type,
+				 struct syscall_arg_fmt *arg_fmt)
+{
+	struct btf_enum *be;
+	int i;
+
+	/* if btf_entry is NULL, find and save it to arg_fmt */
+	if (arg_fmt->btf_entry.entries == NULL)
+		if (btf_enum_find_entry(btf, type, arg_fmt))
+			return 0;
+
+	be = (struct btf_enum *)arg_fmt->btf_entry.entries;
+
+	for (i = 0; i < arg_fmt->btf_entry.nr_entries; ++i, ++be) {
+		if (be->val == val) {
+			return scnprintf(bf, size, "%s",
+					 btf__name_by_offset(btf, be->name_off));
+		}
+	}
+
+	return 0;
+}
+
 #include "trace/beauty/arch_errno_names.c"
 #include "trace/beauty/eventfd.c"
 #include "trace/beauty/futex_op.c"
@@ -1699,6 +1756,15 @@ static void trace__symbols__exit(struct trace *trace)
 	symbol__exit();
 }
 
+static void trace__load_vmlinux_btf(struct trace *trace)
+{
+	trace->btf = btf__load_vmlinux_btf();
+	if (verbose > 0) {
+		fprintf(trace->output, trace->btf ? "vmlinux BTF loaded\n" :
+						    "Failed to load vmlinux BTF\n");
+	}
+}
+
 static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 {
 	int idx;
@@ -1744,7 +1810,7 @@ static const struct syscall_arg_fmt *syscall_arg_fmt__find_by_name(const char *n
 }
 
 static struct tep_format_field *
-syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field)
+syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field, bool *use_btf)
 {
 	struct tep_format_field *last_field = NULL;
 	int len;
@@ -1782,6 +1848,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			 * 7 unsigned long
 			 */
 			arg->scnprintf = SCA_FD;
+		} else if (strstr(field->type, "enum") && use_btf != NULL) {
+			*use_btf = arg->is_enum = true;
 		} else {
 			const struct syscall_arg_fmt *fmt =
 				syscall_arg_fmt__find_by_name(field->name);
@@ -1796,9 +1864,10 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 	return last_field;
 }
 
-static int syscall__set_arg_fmts(struct syscall *sc)
+static int syscall__set_arg_fmts(struct syscall *sc, bool *use_btf)
 {
-	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args);
+	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args,
+									  use_btf);
 
 	if (last_field)
 		sc->args_size = last_field->offset + last_field->size;
@@ -1810,7 +1879,9 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 {
 	char tp_name[128];
 	struct syscall *sc;
+	int err;
 	const char *name = syscalltbl__name(trace->sctbl, id);
+	bool use_btf = false;
 
 #ifdef HAVE_SYSCALL_TABLE_SUPPORT
 	if (trace->syscalls.table == NULL) {
@@ -1883,7 +1954,12 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
 	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
 
-	return syscall__set_arg_fmts(sc);
+	err = syscall__set_arg_fmts(sc, &use_btf);
+
+	if (use_btf && trace->btf == NULL)
+		trace__load_vmlinux_btf(trace);
+
+	return err;
 }
 
 static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
@@ -1891,7 +1967,7 @@ static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
 	struct syscall_arg_fmt *fmt = evsel__syscall_arg_fmt(evsel);
 
 	if (fmt != NULL) {
-		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields);
+		syscall_arg_fmt__init_array(fmt, evsel->tp_format->format.fields, NULL);
 		return 0;
 	}
 
@@ -2103,6 +2179,16 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (trace->show_arg_names)
 				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
+			if (sc->arg_fmt[arg.idx].is_enum && trace->btf) {
+				size_t p = btf_enum_scnprintf(bf + printed, size - printed, val,
+							      trace->btf, field->type,
+							      &sc->arg_fmt[arg.idx]);
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

