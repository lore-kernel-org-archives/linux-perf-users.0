Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D129E157A5B;
	Fri,  5 Jul 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720185672; cv=none; b=GM5BC4bHMZs0i2rnGQmDjh7RvszxLJl9oewe9TCGMD+22gBhldv4dRn4xqluJtaSbs81oQdMUNEk83b+DevoG/jqmZiAmrReI1uOlHc0vpx4UyawFTzUpmBKr1+UZWZtP9Z/2hl/aInudqcXiqxf8YkOFmaoCnN0zTI3ezrSrwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720185672; c=relaxed/simple;
	bh=9LVGdFIrTGDbjOh+XA8Z0YC/ZXcuGb1K9vsLn965MHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XS2ltidt/ETtSMHXqLrZdePl+Qx0B2dNk4cWvllhVIseLWFyiWxh5h4zb2eUtTY+OLcRI+BQpoZ2aP7RPhEgbgwOw0awly4YR3lHrzARzbiRCXn8WzwVhqX+7QIFvZK8ARvhIcp24X0kv8JzdOMVeKLFVzM7R1Z0x2r8VAxlfwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J23Xjr4v; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J23Xjr4v"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70aff4e3f6dso1183941b3a.3;
        Fri, 05 Jul 2024 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720185670; x=1720790470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFnq702W1wouPPtmwM6wErXmz26QeU/F3Y7O+wXoTK0=;
        b=J23Xjr4vionLbWUTzZSQOcT3lzzROueeu7EKF++MP0/yvTobkfg6t9sD0PXJK+n7O+
         YlmQvluWXUY4W5qi6LRAVWIlxXzTMrUPK3iU8EXFed6qCwAN6YU/7Vl0q8ElIlaVoIPW
         EZixeR5bVcrueo57dZSOUgdQ+WPSSRQgvbtXsE6YzCfBPZzk9HvTpvuVWiBNmC/IWXHf
         ABFvaBv7xhNcWYFjURRHMMolM8Zk4YmfmSY5rCv958JJFrZltZ4/ul/uD8h5ceLTwdQi
         ejx6nDqTgMrxXVn9sSf0N6IiXq5ZxGci/ugeqkV7F6eaK2i5WE0FzlSkCZ/cEuO+iz1y
         lGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720185670; x=1720790470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFnq702W1wouPPtmwM6wErXmz26QeU/F3Y7O+wXoTK0=;
        b=UT/k3nE/FKNwaqgE4wXtpay1bunugPR3b70xRQwTNwhp7nescNmV9plrHtIic7bwxk
         3Z43FCsNaagQQXKz/plExQ3mBc/fFKQcgCZIsOVWCsYVkttLdhN/dhpFqeEwqsrUlM8R
         NK4qeSJWkLGxAbnjugCEnzMO8QnULmhK301lLW517Tdz4nlHO8Yxxqk7yJhpkD235DXU
         RExVXzULFEA7hln6eF3QmUCa9SllwlYTGjAeClrK4F1FRcX56MCIc+WPPuESm1VD4eyl
         4eCMRV+/wC8OTHkaDfn3MzKzjdo6WQQIuk+aNffgJR3UEmgM8h+UsZgHIVQSiHOubert
         M9vA==
X-Forwarded-Encrypted: i=1; AJvYcCX9FLoq1K//LeoIyDkihq8NAED3MObv2l0TPmsYi/Hi3R4v7RTlwA6oL+4O/rEH0j5XNel3Jz/yfr00DiCTbhvsmFgxYP+2LJk8T8UOvYidul1oTT5omGsPMODU4kJYzG3roWY8hYR3UXtra3MA2A==
X-Gm-Message-State: AOJu0YwgH4C3E8lTFBLTZnVpKQzT6oGxJZnZMjhu8ryT1Ut/Pz79Kko5
	ui093aVvQiwzUV32JOqU95cQY8BfFuU5srzcYM4Vz2HrWaBuDGHXtDHvPC18
X-Google-Smtp-Source: AGHT+IHMXkERqiJ306NNH5xtSyh4oWiOkR6KYw1bp41GHQw50XGmpQtAfpX/O3XiwCh3vGitDgJybQ==
X-Received: by 2002:a05:6a20:c995:b0:1bd:23c7:ebfb with SMTP id adf61e73a8af0-1c0cc8db0f4mr4769522637.62.1720185670067;
        Fri, 05 Jul 2024 06:21:10 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a956260sm3328974a91.19.2024.07.05.06.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 06:21:09 -0700 (PDT)
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
Subject: [PATCH v5 8/8] perf trace: Remove arg_fmt->is_enum, we can get that from the BTF type
Date: Fri,  5 Jul 2024 21:20:58 +0800
Message-ID: <20240705132059.853205-9-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240705132059.853205-1-howardchu95@gmail.com>
References: <20240705132059.853205-1-howardchu95@gmail.com>
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

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Tested-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240624181345.124764-9-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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

