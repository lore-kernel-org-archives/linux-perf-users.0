Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E26021350;
	Tue, 18 Jun 2024 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724368; cv=none; b=SzSpsxV+8XxOpKUJQ5bJ3+J6inICHhDRYgGd0Ph2u3AA7k2vidfgUt2GgS+GwrPFtKlRRC88FaNEkBmWsyaN9Rk3B3P4UUXPc83NQcJzma6baaPujmSd4UhsarHW1tV2xo9Bymkoa4r03g3uF7We49vj/Lws2D7ZioI8/gChpYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724368; c=relaxed/simple;
	bh=VeBHc2r61GE7DI1N7wIy1Ckx4vaqM1h8Hv33LHs8McM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sx5nt9MWljI7v3eVtiaWsRj5hhxrLN+ZSOFuF/+HcGYQYhOB4Yc+IItzP0cyV+qelg98fEScS/ssniQ0hYp5R6hSm9lVdhrT//vJG1fG9dG9HC0m8Bdn8M480Id/fc91C3MNMp0Kw/x3JZuPFVGJLxNbofsq+COWTWlN0cDx2So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKhcWlL3; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKhcWlL3"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7061d37dc9bso871511b3a.2;
        Tue, 18 Jun 2024 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718724366; x=1719329166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvHqWmcR7mE4/kYvoM0yDq+w0jjL+BnJYOdtnxANNyk=;
        b=KKhcWlL3x8ZSq7YPMVUYoVGwkXzKz8ex06yeBOnkqJYSyReOBUaKfQYRhkotk4XoSJ
         zxL/4d984SBjc1RsugLGdlQc1Vi4aAaiqiIG/0iwDp2h0rlzE8DsFxuvdkPr2vvZqnAR
         gvrgc/BUNp4h0ANlBZrLVrX4Q7zUFQPx28gAsRBirASBb4frqjz/9r6nV2fujc58Lo2J
         Cn+B35x8RlYMQYHK2E+I8ArRtIVrqjGaIGkQ1/wJjbycqtPqhkmDSc5DNtWjjtO7M5o6
         AH9ll//Q6ipdbB0pjyZxru3ZyoBM0wEmM9fU+0JC5yUnc5rckI4rU61qaLKaRiSvZbG0
         EgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724366; x=1719329166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvHqWmcR7mE4/kYvoM0yDq+w0jjL+BnJYOdtnxANNyk=;
        b=orZZIR0swgjD57J9bRSf2EAYPDzLQ3aHAnCA1PE4mQm/Jir/ArRHxgKHfIhJqWXwMg
         FXGUrNz7+2xJysLRcfWhtnXR7S6ErADeYmfNq34rBbGG9MnpTDwr/9+7yv3JEHXMVw5z
         j95mabHuFug28JfFfuH7bqOpIcmTgPff2UmZ3+Hw0XvmXp7HQFkQYw11p+VsWiNf4kli
         8moaXlkCX75lQbC9HHelgbbbyWnZHmT1ONtmEg8814YBzRSzO5tV8Pli+Sz3c9+sjFFw
         u1PYOObm8Da4m23bd8P3NUY/s/qt8qmbkZGahQkybTHAzt92OP/VYTl5J16Unn6+Ir2L
         zJ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8hCWAR+ta2C+k7JtHF1YNfP920wYQtcoYXKlrft92ug6Cq6tAj8AgoD+RWpwtzCPsecJtS1ncq/RSGIUfcF4qpROwf1tTsKeqJTnlEtiqsh+pQrRoThacWxoDx4WuTl/VPR1ajMyTCAQKDAWLPg==
X-Gm-Message-State: AOJu0YyaObasr7WTFS2D/vsBC/gIE9Nh8Mz3hst523T1r/JbG2ZjFu0v
	35uZlAolKxkw1Rw+ZKkUMq3f08Kj35laWpiussvM2RaxsCE0pnIh
X-Google-Smtp-Source: AGHT+IHrutJtwDDbVCwQcEAS6KP9RlCVCkNf0nYrcwHV0PbO3Bvmj3E+BwIJHnkxp1uUDUXxPieEPA==
X-Received: by 2002:a05:6a00:2d02:b0:705:c0a3:3bba with SMTP id d2e1a72fcca58-705d71d132bmr17405306b3a.32.1718724365683;
        Tue, 18 Jun 2024 08:26:05 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb4265esm9071388b3a.116.2024.06.18.08.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 08:26:05 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v1 2/5] perf trace: Augment enum syscall arguments with BTF
Date: Tue, 18 Jun 2024 23:26:49 +0800
Message-ID: <20240618152652.3446472-3-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618152652.3446472-1-howardchu95@gmail.com>
References: <20240618152652.3446472-1-howardchu95@gmail.com>
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

