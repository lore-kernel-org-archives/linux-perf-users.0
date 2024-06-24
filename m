Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE26E1A254B;
	Mon, 24 Jun 2024 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252753; cv=none; b=Tjgas+pBSsfYELO6Oe87EXWnKNE3rdphZS0DxY5nTepkpmy0x7iUwqY2vCsLjp660fBW/DpjEo/ESLcIISCH7zVBlENbfD0Y2TxCrk3U2DH7xgI6+EFwl2Yy6Eolhf1+3XZe+3kQXEVxRaTZDgt9hOb5NO0sdEI/vJ597XUyibo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252753; c=relaxed/simple;
	bh=GM9v3HZVSqEmxMUKc0Yu6DGDU60uwNCVUO5wC3LrEag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWG2mjln49sXen9Qpp3uuWBibEqYYdeDN62Fd3ue37dd+x0EHsgGa050rOf2dzj3EpaL61XX4CX+DaeJgYHwfk8z7vNZxTc0qu7En3SD6XOi4zdXErGaSwDDDONSTbuSEVJAlsI+GkejNHfhOE5dMlTRnDuwS9ktW/YoMvC4QZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJWTh8+c; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJWTh8+c"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-706627ff48dso2001633b3a.1;
        Mon, 24 Jun 2024 11:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719252751; x=1719857551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnH79mxvIGsSdhtVkYLh+ulDnBmSarYvEBG6ogLOhec=;
        b=JJWTh8+c/Igvq3/UWDzdvl4itcH5y6sEYV4Wc4mDDVsEpGchgKfyjswh1g3AlhJnF2
         66zIapCWGO9jjgPdoCnSCCzMaZN6+LamRNUiYeyJy0CegOROpWifvl8eqGG4lbOIOdZI
         jsFjjiursZVnd/12g2+j5OKjoMhYCbO+Zxv/hOarCxSo0jTP/vjQF3D6CxJBWgeX0Ahv
         Uu9aRSKNdj6mp3uip2UIE6Ju3xxMVfpaVdRIw5cxsZCek+dlTuP1HPhirNgBdNoxogWu
         /jCGY2/ZDnX+zCEVeySR7sR0thfZ5TFrj9Vsmy6n58gDplv5hxoTDIAKZA1IL/CeccUV
         ckwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719252751; x=1719857551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OnH79mxvIGsSdhtVkYLh+ulDnBmSarYvEBG6ogLOhec=;
        b=s45252OVKW1Esrbn4lNueqhKhYNHM+5yhMMmTSEOqFbGa+pJJc/nOnyX99VePyox47
         6uyIOfsf0RUrTIS5F25VaDYdGN6xqyWUaLCfmWo2Nk6igCAZJ1p51rlkicyaQJWsgS4e
         ILOBk+m7cS/PUSO7EoMPAX6CsOJ2Sp+DsQqMa8pR1KekeK2miqCStHJmA31JJGqh2QsD
         zUJyTCnoQgmY5XQ7I+HKktMVkZ4cbNigQP9X01JX9Bhu/JKZXPmGaxE2i7enCfdXfEsn
         91f4gZr+GkXzIREz3WLZY1x//3nFIQoUMHEqxbY+J8SqyiDKAjZWu4Bg6baF4zBExFfA
         OhwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAIPefff8KyzVGsZdyfLAHZ0OZ0YCGqWE1wvEoBHS4dbXkD4sX47NuWu0ZbYGvVMrk7OiOjPlu61pxPHXmvcDiidpTfvUSlcngtkdH9l/a97Uv/JOswS0j4SWkEvd1jQmGgz5IoatynTD8BWH7fA==
X-Gm-Message-State: AOJu0YzVJicnYB5uDvqQMxBeWRzp89IU/9iNDqBvq01lri2MGBdFW3bH
	0ag9hwR7M/bf6rhkl02UZWGu161MwLYN9sMeXvvFNhE9INa6OUlY
X-Google-Smtp-Source: AGHT+IENNX+FrsxUvhp0lLd1yCJyDpoX5U2JbUho2R9JjsaMpUMzUO1PcNtDSUaBK0G8XVUxdAIe4A==
X-Received: by 2002:a05:6a20:da9c:b0:1b8:7cd7:7aa8 with SMTP id adf61e73a8af0-1bcf7fb9e2fmr7821556637.41.1719252751088;
        Mon, 24 Jun 2024 11:12:31 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651290157sm6525157b3a.150.2024.06.24.11.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 11:12:30 -0700 (PDT)
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
Subject: [PATCH v3 8/8] perf trace: Remove arg_fmt->is_enum, we can get that from the BTF type
Date: Tue, 25 Jun 2024 02:13:45 +0800
Message-ID: <20240624181345.124764-9-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240624181345.124764-1-howardchu95@gmail.com>
References: <20240624181345.124764-1-howardchu95@gmail.com>
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
index 1dd8b839e502..14141f09b4d6 100644
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

