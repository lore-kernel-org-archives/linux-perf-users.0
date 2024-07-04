Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E111B0111;
	Thu,  4 Jul 2024 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097071; cv=none; b=Qv1JkIcFL4D2GtHY4VJI7agq2puLykV48qaxajTlmJsEIEzYWnysAKHTx/y7yvoscFZE047I7vM+XxubqQKppxcjQjVeEyTCRSGNODtP4mak15QtkjgxxOStLdEsexq6AHG+MOT/UH1EO4hl1tqiCE6Sqq75uGo6/dMHni4gFaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097071; c=relaxed/simple;
	bh=nNpo0ZuXzYf3+WtjOjL0cQD9p4VX8Z4rtX7xIBWGZnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c10dmNxXxHYh7rj7QITOFcC+ziJiL7s0XQZwjY2wHHKStZG6edEogYt5KbsKaUGEAwSm0SB1YgCJ3+67wSqE98/8jjc5n/Nt7HGvIMUJLd2TZFsQkphGmHA38bF8H4+SbPxFiYEzmYeybMCI1dKB3VrnTcie7u7QRw7lYPxUirE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htB/cbBj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htB/cbBj"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fa3bdd91c1so3788055ad.2;
        Thu, 04 Jul 2024 05:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720097070; x=1720701870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOZZRsIMsFCEeUFHxyJsA3wcVIrREBOvAUEAQZ8gA8w=;
        b=htB/cbBjgpOdESnDp9Fkqr/CaXdoX6Z7S4b7R/7a9j5jeQ8PAs1hn6mkrbSc6Ijr8M
         0BxRNKWjdOajjKVyZ/THys7QDcn/wsjwJ0ZZh51JEA7hywPVswjFOSoYLwWZl40BQ/1t
         4uNFQ3BN9AXgo56LCTKtf1QMP3mmrSV/ILP9nlXQeuDN7XmuX+bKZvqZfE4A+HrKt+4P
         c8P/JFdkgQMAwgdUPlxGfHsD8HFxnXAtg8hpfG8Y2tuOUokvhgnOYFqf0dfpr3lVyklJ
         TRItiBORI0ysaD3/+CYNs09PxbFHi2KJUrk0/cnrHKBp9s+kZoceaUjKF/Lqm4zL3wfT
         c/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720097070; x=1720701870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOZZRsIMsFCEeUFHxyJsA3wcVIrREBOvAUEAQZ8gA8w=;
        b=XzBIDuqzOHE8q0Y9uzD4iJ7r1fJT/OmL6ciCVxAS8GUpUu93eBcLAb266ngoWRNJkG
         i/VjXxeZpojP1N6ar0Dz3URK3+7rr0mAVWE580fID46AfgLN9W/28AuR+vTT42+3TW/Y
         7tziAoYVBn4Lv08KsxUpenY6f9FpQQX/u4zP+R8Jqf3076JbXJpXjUcferulpt0ClN6s
         9oJFBXvgi26WURgE1/cUxgVbLbapZOZIQIeFW2VTHYK5hqF6BdTiOWmAGc7jF2w6Rd73
         I7BpikpvnoebxYgTXkT4ExHBk2YrqIm/udYSgzS90RJhuNliKK6FSLWo5KC5YWt1sXSC
         qQpA==
X-Forwarded-Encrypted: i=1; AJvYcCWOENkYMCOD1NdZXSWWTYjhPkSQUS0o1hTBvVsp4F1qPeD763BlgDfUdHCunEZMZpefn9cJ71OUBaJq7P1U51IBVlKAzumg9WVSCfltls2Jh11gZdUvy9UPqFyM6T3vg7xZfpWxqWwB0yrYi40d1A==
X-Gm-Message-State: AOJu0YxYiDcuK6dfn1GsALrIUnoArcZoIg9KDImHwL39RSGgM4/Zq6Hv
	9w8vUzh290hB5jJMv219lG6IIOvBADaf40e+ZSI5lN3YDS4QIt0d
X-Google-Smtp-Source: AGHT+IEREQa3V1TZYqMuGAY3TF8kKhDOTUkaY1pjSYNzaZUov6MNMKlJxwunKwFWZ7sRkP3iD/g/xA==
X-Received: by 2002:a17:902:d2d1:b0:1f9:d6cc:e504 with SMTP id d9443c01a7336-1fb33e1890fmr16190015ad.24.1720097069478;
        Thu, 04 Jul 2024 05:44:29 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1598d35sm121578245ad.285.2024.07.04.05.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 05:44:29 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: adrian.hunter@intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	namhyung@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v4 8/8] perf trace: Remove arg_fmt->is_enum, we can get that from the BTF type
Date: Thu,  4 Jul 2024 20:43:54 +0800
Message-ID: <20240704124354.904540-9-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240704124354.904540-1-howardchu95@gmail.com>
References: <20240704124354.904540-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This is to pave the way for other BTF types, i.e. we try to find BTF
type then use things like btf_is_enum(btf_type) that we cached to find
the right strtoul and scnprintf routines.

For now only enum is supported, all the other types simple return zero
for scnprintf which makes it have the same behaviour as when BTF isn't
available, i.e. fallback to no pretty printing. Ditto for strtoul.

  root@x1:~# perf test -v enum
  124: perf trace enum augmentation tests                              : Ok
  root@x1:~# perf test -v enum
  124: perf trace enum augmentation tests                              : Ok
  root@x1:~# perf test -v enum
  124: perf trace enum augmentation tests                              : Ok
  root@x1:~# perf test -v enum
  124: perf trace enum augmentation tests                              : Ok
  root@x1:~# perf test -v enum
  124: perf trace enum augmentation tests                              : Ok
  root@x1:~#

Tested-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c       | 101 +++++++++++++++++--------------
 tools/perf/trace/beauty/beauty.h |   1 +
 2 files changed, 56 insertions(+), 46 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d9104fc4f61f..488c2cedc110 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -111,7 +111,6 @@ struct syscall_arg_fmt {
 	const char *name;
 	u16	   nr_entries; // for arrays
 	bool	   show_zero;
-	bool	   is_enum;
 #ifdef HAVE_LIBBPF_SUPPORT
 	const struct btf_type *type;
 #endif
@@ -910,33 +909,46 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
 
 #ifdef HAVE_LIBBPF_SUPPORT
-static int syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_fmt, struct btf *btf, char *type)
+static void syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_fmt, struct btf *btf, char *type)
 {
 	int id;
 
-	// Already cached?
-	if (arg_fmt->type != NULL)
-		return 0;
-
 	type = strstr(type, "enum ");
 	if (type == NULL)
-		return -1;
+		return;
 
 	type += 5; // skip "enum " to get the enumeration name
 
 	id = btf__find_by_name(btf, type);
 	if (id < 0)
-		return -1;
+		return;
 
 	arg_fmt->type = btf__type_by_id(btf, id);
-	return arg_fmt->type == NULL ? -1 : 0;
 }
 
 static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct syscall_arg *arg, u64 *val)
+{
+	const struct btf_type *bt = arg->fmt->type;
+	struct btf *btf = arg->trace->btf;
+	struct btf_enum *be = btf_enum(bt);
+
+	for (int i = 0; i < btf_vlen(bt); ++i, ++be) {
+		const char *name = btf__name_by_offset(btf, be->name_off);
+		int max_len = max(size, strlen(name));
+
+		if (strncmp(name, bf, max_len) == 0) {
+			*val = be->val;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static bool syscall_arg__strtoul_btf_type(char *bf, size_t size, struct syscall_arg *arg, u64 *val)
 {
 	const struct btf_type *bt;
-	char *type = arg->parm;
-	struct btf_enum *be;
+	char *type = arg->type_name;
 	struct btf *btf;
 
 	trace__load_vmlinux_btf(arg->trace);
@@ -945,20 +957,19 @@ static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct syscall_
 	if (btf == NULL)
 		return false;
 
-	if (syscall_arg_fmt__cache_btf_enum(arg->fmt, btf, type) < 0)
-		return false;
+	if (arg->fmt->type == NULL) {
+		// See if this is an enum
+		syscall_arg_fmt__cache_btf_enum(arg->fmt, btf, type);
+	}
 
+	// Now let's see if we have a BTF type resolved
 	bt = arg->fmt->type;
-	be = btf_enum(bt);
-	for (int i = 0; i < btf_vlen(bt); ++i, ++be) {
-		const char *name = btf__name_by_offset(btf, be->name_off);
-		int max_len = max(size, strlen(name));
+	if (bt == NULL)
+		return false;
 
-		if (strncmp(name, bf, max_len) == 0) {
-			*val = be->val;
-			return true;
-		}
-	}
+	// If it is an enum:
+	if (btf_is_enum(arg->fmt->type))
+		return syscall_arg__strtoul_btf_enum(bf, size, arg, val);
 
 	return false;
 }
@@ -978,23 +989,23 @@ static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, c
 	return 0;
 }
 
-static size_t trace__btf_enum_scnprintf(struct trace *trace, struct syscall_arg_fmt *arg_fmt, char *bf,
-					size_t size, int val, char *type)
-{
-	if (syscall_arg_fmt__cache_btf_enum(arg_fmt, trace->btf, type) < 0)
-		return 0;
-
-	return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
-}
-
 static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg_fmt *arg_fmt, char *bf,
 				   size_t size, int val, char *type)
 {
 	if (trace->btf == NULL)
 		return 0;
 
-	if (arg_fmt->is_enum)
-		return trace__btf_enum_scnprintf(trace, arg_fmt, bf, size, val, type);
+	if (arg_fmt->type == NULL) {
+		// Check if this is an enum and if we have the BTF type for it.
+		syscall_arg_fmt__cache_btf_enum(arg_fmt, trace->btf, type);
+	}
+
+	// Did we manage to find a BTF type for the syscall/tracepoint argument?
+	if (arg_fmt->type == NULL)
+		return 0;
+
+	if (btf_is_enum(arg_fmt->type))
+		return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
 
 	return 0;
 }
@@ -1007,14 +1018,14 @@ static size_t trace__btf_scnprintf(struct trace *trace __maybe_unused, struct sy
 	return 0;
 }
 
-static bool syscall_arg__strtoul_btf_enum(char *bf __maybe_unused, size_t size __maybe_unused,
+static bool syscall_arg__strtoul_btf_type(char *bf __maybe_unused, size_t size __maybe_unused,
 					  struct syscall_arg *arg __maybe_unused, u64 *val __maybe_unused)
 {
 	return false;
 }
 #endif // HAVE_LIBBPF_SUPPORT
 
-#define STUL_BTF_ENUM syscall_arg__strtoul_btf_enum
+#define STUL_BTF_TYPE syscall_arg__strtoul_btf_type
 
 #define STRARRAY(name, array) \
 	  { .scnprintf	= SCA_STRARRAY, \
@@ -1887,7 +1898,6 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			continue;
 
 		len = strlen(field->name);
-		arg->is_enum = false;
 
 		if (strcmp(field->type, "const char *") == 0 &&
 		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
@@ -1915,8 +1925,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			 */
 			arg->scnprintf = SCA_FD;
 		} else if (strstr(field->type, "enum") && use_btf != NULL) {
-			*use_btf = arg->is_enum = true;
-			arg->strtoul = STUL_BTF_ENUM;
+			*use_btf = true;
+			arg->strtoul = STUL_BTF_TYPE;
 		} else {
 			const struct syscall_arg_fmt *fmt =
 				syscall_arg_fmt__find_by_name(field->name);
@@ -2236,10 +2246,13 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			/*
 			 * Suppress this argument if its value is zero and show_zero
 			 * property isn't set.
+			 *
+			 * If it has a BTF type, then override the zero suppression knob
+			 * as the common case is for zero in an enum to have an associated entry.
 			 */
 			if (val == 0 && !trace->show_zeros &&
 			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].show_zero) &&
-			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].is_enum))
+			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].strtoul == STUL_BTF_TYPE))
 				continue;
 
 			printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
@@ -2942,7 +2955,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		val = syscall_arg_fmt__mask_val(arg, &syscall_arg, val);
 
 		/* Suppress this argument if its value is zero and show_zero property isn't set. */
-		if (val == 0 && !trace->show_zeros && !arg->show_zero && !arg->is_enum)
+		if (val == 0 && !trace->show_zeros && !arg->show_zero && arg->strtoul != STUL_BTF_TYPE)
 			continue;
 
 		printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
@@ -3910,14 +3923,10 @@ static int trace__expand_filter(struct trace *trace, struct evsel *evsel)
 				struct syscall_arg syscall_arg = {
 					.trace = trace,
 					.fmt   = fmt,
+					.type_name = type,
+					.parm = fmt->parm,
 				};
 
-				if (fmt->is_enum) {
-					syscall_arg.parm = type;
-				} else {
-					syscall_arg.parm = fmt->parm;
-				}
-
 				if (fmt->strtoul(right, right_size, &syscall_arg, &val)) {
 					char *n, expansion[19];
 					int expansion_lenght = scnprintf(expansion, sizeof(expansion), "%#" PRIx64, val);
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 78d10d92d351..3ed11e18ee2d 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -113,6 +113,7 @@ struct syscall_arg {
 	struct thread *thread;
 	struct trace  *trace;
 	void	      *parm;
+	char	      *type_name;
 	u16	      len;
 	u8	      idx;
 	u8	      mask;
-- 
2.45.2

