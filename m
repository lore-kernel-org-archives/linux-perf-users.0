Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201C419D89A;
	Sat, 15 Jun 2024 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718432949; cv=none; b=mh6ybEYnWv2FDQdq3XRrhmd33UOkjJX35GddC9NoDa5QT/18WfvkDYF6mFlUkc7TIXOzeBY9x5EybGMkiwZ0VcNomgQdIGw/JMytbIr0q8GDetx8cwFnHVtYJX2GH8yjXA0HNwFu8z43MMu8cEjWYbFz1eCezzNHhPzR1ZfRX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718432949; c=relaxed/simple;
	bh=IQok1HuquWIHYQmIQkI+jdBUMwdYsKKI8KD7SQz86IM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HY6Gq9DJt7ElDaop0e8IIKVI32keZBzVH+ypwU227IjSRx+D5L8+wNTh4qNlXtIo3iZtiF3Lixwa1vAp6PqdzRnSVcKpDFSvUz5HDVIGSHsemHbfmQyj/YxkFbcepSu2mIj3CNwS4sJTizO+FzAkv+VA5pbiH3EVt97BueLsJcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leyJ9ybQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leyJ9ybQ"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6e40d54e4a3so2250888a12.0;
        Fri, 14 Jun 2024 23:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718432947; x=1719037747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ajxNHKL83DfdDsScVuG0CAYsN/qSLQQ6Xufi+wlTVMw=;
        b=leyJ9ybQ6sRCyrOwT28COcHUpoP58Ku9wBzgkclb+lF8zc8Q2JXcb/ZtlFcqiR8xZm
         UMecb/OlHav0s7HICllGhGO6nlqFa6BRmFDI3ir8HGrEjrX+Ytaj8niVhVKVe1y5nl4K
         RZh6MFKmDSoHAGK7tg6xLfT9CDXYB4q738dxwe7QmwHUMfRY4lSB8Gt6qCKf9CaThVGJ
         0sirTUlMuyrPGiCuvcyyBDsUYwOHQNrHw8ONq8A48kdO9jpV2SlI01LWheXMyeq/UtKD
         92usoW3xQv5MMLtthvJ1AZiPRFsd/PmAtgN6B7BEXrdDXt3EBIrYzxfFt/wjVBSADoSA
         1FJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718432947; x=1719037747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ajxNHKL83DfdDsScVuG0CAYsN/qSLQQ6Xufi+wlTVMw=;
        b=fB5it5dD9HiZJKJ7YQdYiyxGqFk9y9L1BoBRqpmZcfRSCBiI/+feicjxNMmbpYT0EV
         BUdVI+PQ7MJaYQB340YdHRGITMSy3BydZy9t4oUV3FlVo429aAwx4wKI4Wz6mLGP8PIT
         nbyx69bRGvnCqqKaXtBrd2iSTdb3E53VV4Xm6/a+9WmhFy/I0SYFpm0+ba9sxwIPArgd
         DQIv1twmweA7Pog1ArP+vS7Vf+OUTNV6/Qyf+1fArs6PjXXjsEYt88mySIpKj232qyFm
         7tOnMRqbjexhq7xOCd1O8lIHwU33WJBUk7c9JWmh5NYzi459FPQK5c73BxfXWSx2Po8H
         1X0A==
X-Forwarded-Encrypted: i=1; AJvYcCX+d0+dmu9hSnNcShpo53MIGUOhVdPcElIsFqc1t2VhJ21yHfesydV7D8CG0OVFdaE2QVf2rFEyQXYUqciJNHUdqHwPkOwHElJQKkAT9HsNx5KervI0wtDC6qB7KAyO5bP61GuXzK8zFCbrFWkBag==
X-Gm-Message-State: AOJu0Yw+20/PqmBp6+ZUBjDlurraNYdxisysZYE6m0w+WjRrJ4UtN91R
	UJoA/nluDLv6oFONgszarYTafE0Iw4EFAngglBW/r9SRcCPL7W+mtcNQE5bwFlg=
X-Google-Smtp-Source: AGHT+IHvLV0HzGRZrtPqJhGcnKKrk93Mv1VxkcNy0myZP4V2fIRyl2s1JtI9y8Ycej+kLQvWKZEJkQ==
X-Received: by 2002:a05:6a20:3943:b0:1b1:e7de:4d36 with SMTP id adf61e73a8af0-1bae7d9b830mr5297901637.2.1718432947037;
        Fri, 14 Jun 2024 23:29:07 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c466c3f9sm5087641a91.37.2024.06.14.23.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 23:29:06 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] perf trace: Filter enum arguments with enum names
Date: Sat, 15 Jun 2024 14:29:58 +0800
Message-ID: <20240615062958.367524-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before:

perf $ ./perf trace -e timer:hrtimer_start --filter='mode!=HRTIMER_MODE_ABS_PINNED_HARD' --max-events=1
No resolver (strtoul) for "mode" in "timer:hrtimer_start", can't set filter "(mode!=HRTIMER_MODE_ABS_PINNED_HARD) && (common_pid != 281988)"

After:

perf $ ./perf trace -e timer:hrtimer_start --filter='mode!=HRTIMER_MODE_ABS_PINNED_HARD' --max-events=1
     0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, function: 0xffffffffa77a5be0, expires: 12351248764875, softexpires: 12351248764875, mode: HRTIMER_MODE_ABS)

&& and ||:

perf $ ./perf trace -e timer:hrtimer_start --filter='mode != HRTIMER_MODE_ABS_PINNED_HARD && mode != HRTIMER_MODE_ABS' --max-events=1
     0.000 Hyprland/534 timer:hrtimer_start(hrtimer: 0xffff9497801a84d0, function: 0xffffffffc04cdbe0, expires: 12639434638458, softexpires: 12639433638458, mode: HRTIMER_MODE_REL)

perf $ ./perf trace -e timer:hrtimer_start --filter='mode == HRTIMER_MODE_REL || mode == HRTIMER_MODE_PINNED' --max-events=1
     0.000 ldlck-test/60639 timer:hrtimer_start(hrtimer: 0xffffb16404ee7bf8, function: 0xffffffffa7790420, expires: 12772614418016, softexpires: 12772614368016, mode: HRTIMER_MODE_REL)

Switching it up, using both enum name and integer value(--filter='mode == HRTIMER_MODE_ABS_PINNED_HARD || mode == 0'):

perf $ ./perf trace -e timer:hrtimer_start --filter='mode == HRTIMER_MODE_ABS_PINNED_HARD || mode == 0' --max-events=3
     0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, function: 0xffffffffa77a5be0, expires: 12601748739825, softexpires: 12601748739825, mode: HRTIMER_MODE_ABS_PINNED_HARD)
     0.036 :0/0 timer:hrtimer_start(hrtimer: 0xffff9498a6ca5f18, function: 0xffffffffa77a5be0, expires: 12518758748124, softexpires: 12518758748124, mode: HRTIMER_MODE_ABS_PINNED_HARD)
     0.172 tmux: server/41881 timer:hrtimer_start(hrtimer: 0xffffb164081e7838, function: 0xffffffffa7790420, expires: 12518768255836, softexpires: 12518768205836, mode: HRTIMER_MODE_ABS)

P.S.
perf $ pahole hrtimer_mode
enum hrtimer_mode {
        HRTIMER_MODE_ABS             = 0,
        HRTIMER_MODE_REL             = 1,
        HRTIMER_MODE_PINNED          = 2,
        HRTIMER_MODE_SOFT            = 4,
        HRTIMER_MODE_HARD            = 8,
        HRTIMER_MODE_ABS_PINNED      = 2,
        HRTIMER_MODE_REL_PINNED      = 3,
        HRTIMER_MODE_ABS_SOFT        = 4,
        HRTIMER_MODE_REL_SOFT        = 5,
        HRTIMER_MODE_ABS_PINNED_SOFT = 6,
        HRTIMER_MODE_REL_PINNED_SOFT = 7,
        HRTIMER_MODE_ABS_HARD        = 8,
        HRTIMER_MODE_REL_HARD        = 9,
        HRTIMER_MODE_ABS_PINNED_HARD = 10,
        HRTIMER_MODE_REL_PINNED_HARD = 11,
};

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>

---
 tools/perf/builtin-trace.c | 89 ++++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bd16679fb4c0..1148c3edee97 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -904,11 +904,36 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 	    .strtoul	= STUL_STRARRAY_FLAGS, \
 	    .parm	= &strarray__##array, }
 
-static int btf_enum_find_entry(struct btf *btf, char *type, struct syscall_arg_fmt *arg_fmt)
+#define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
+
+static const struct btf_type *btf_find_type(struct btf *btf, char *type)
 {
 	const struct btf_type *bt;
+	int id = btf__find_by_name(btf, type);
+
+	if (id < 0)
+		return NULL;
+
+	bt = btf__type_by_id(btf, id);
+	if (bt == NULL)
+		return NULL;
+
+	return bt;
+}
+
+struct btf_parm {
+	struct btf *btf;
+	char *type;
+};
+
+static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct syscall_arg *arg, u64 *val)
+{
+	struct btf_parm *bparm = arg->parm;
+	struct btf *btf = bparm->btf;
+	char *type      = bparm->type;
 	char enum_prefix[][16] = { "enum", "const enum" }, *ep;
-	int id;
+	struct btf_enum *be;
+	const struct btf_type *bt;
 	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(enum_prefix); i++) {
@@ -917,11 +942,38 @@ static int btf_enum_find_entry(struct btf *btf, char *type, struct syscall_arg_f
 			type += strlen(ep) + 1;
 	}
 
-	id = btf__find_by_name(btf, type);
-	if (id < 0)
-		return -1;
+	bt = btf_find_type(btf, type);
+	if (bt == NULL)
+		return false;
 
-	bt = btf__type_by_id(btf, id);
+	for (be = btf_enum(bt), i = 0; i < btf_vlen(bt); ++i, ++be) {
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
+#define STUL_BTF_ENUM syscall_arg__strtoul_btf_enum
+
+static int btf_enum_find_entry(struct btf *btf, char *type, struct syscall_arg_fmt *arg_fmt)
+{
+	char enum_prefix[][16] = { "enum", "const enum" }, *ep;
+	const struct btf_type *bt;
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(enum_prefix); i++) {
+		ep = enum_prefix[i];
+		if (strlen(type) > strlen(ep) + 1 && strstarts(type, ep))
+			type += strlen(ep) + 1;
+	}
+
+	bt = btf_find_type(btf, type);
 	if (bt == NULL)
 		return -1;
 
@@ -1850,6 +1902,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			arg->scnprintf = SCA_FD;
 		} else if (strstr(field->type, "enum") && use_btf != NULL) {
 			*use_btf = arg->is_enum = true;
+			arg->strtoul = STUL_BTF_ENUM;
 		} else {
 			const struct syscall_arg_fmt *fmt =
 				syscall_arg_fmt__find_by_name(field->name);
@@ -3776,7 +3829,8 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 	return __trace__deliver_event(trace, event->event);
 }
 
-static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(struct evsel *evsel, char *arg)
+static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(struct evsel *evsel, char *arg,
+								   char **type)
 {
 	struct tep_format_field *field;
 	struct syscall_arg_fmt *fmt = __evsel__syscall_arg_fmt(evsel);
@@ -3785,8 +3839,10 @@ static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(struct evsel
 		return NULL;
 
 	for (field = evsel->tp_format->format.fields; field; field = field->next, ++fmt)
-		if (strcmp(field->name, arg) == 0)
+		if (strcmp(field->name, arg) == 0) {
+			*type = field->type;
 			return fmt;
+		}
 
 	return NULL;
 }
@@ -3824,14 +3880,14 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
 			struct syscall_arg_fmt *fmt;
 			int left_size = tok - left,
 			    right_size = right_end - right;
-			char arg[128];
+			char arg[128], *type;
 
 			while (isspace(left[left_size - 1]))
 				--left_size;
 
 			scnprintf(arg, sizeof(arg), "%.*s", left_size, left);
 
-			fmt = evsel__find_syscall_arg_fmt_by_name(evsel, arg);
+			fmt = evsel__find_syscall_arg_fmt_by_name(evsel, arg, &type);
 			if (fmt == NULL) {
 				pr_err("\"%s\" not found in \"%s\", can't set filter \"%s\"\n",
 				       arg, evsel->name, evsel->filter);
@@ -3843,9 +3899,16 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
 
 			if (fmt->strtoul) {
 				u64 val;
-				struct syscall_arg syscall_arg = {
-					.parm = fmt->parm,
-				};
+				struct syscall_arg syscall_arg;
+				struct btf_parm bparm;
+
+				if (fmt->is_enum) {
+					bparm.btf  = trace->btf;
+					bparm.type = type;
+					syscall_arg.parm = &bparm;
+				} else {
+					syscall_arg.parm = fmt->parm;
+				}
 
 				if (fmt->strtoul(right, right_size, &syscall_arg, &val)) {
 					char *n, expansion[19];
-- 
2.45.2

