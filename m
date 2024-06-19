Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E067EEF5;
	Wed, 19 Jun 2024 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785205; cv=none; b=RPLhBk+MeMNmBZ/SNyti0NqCzxIcWzoMSfmVvMn91N4GMutPqWBTipmT0mgU6puP5oYxBBjf5BNmqat2IqoKBhO5JpGI9DuJkHTKL7mWFsUL9H73bLkY7rM/4qIAEIwQeqSIqAIKj8/HawYkU0vB+XQd5AmHxylLrkQ+ME4bOik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785205; c=relaxed/simple;
	bh=/LZWj7oaqNHKukw2mT2SK+cZhXWIt6cUnNRXQtMon/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9Rdg4dxYKVPQnKzLEczjKmjIO+laXYRtf9hPJ94ElF0CnqO9BALjc4uA5rQZQzOGE3s/+nA/odDAmQMHcfRWqpZJYpG8ogE+JFrknGQkeNlxAValjo+RDX//oM+n/IMv2WSxWODixu9iq0dt+T68zOxVChqEKt/r5oVMiw2sIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITupTZh4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITupTZh4"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f862f7c7edso42739515ad.3;
        Wed, 19 Jun 2024 01:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718785203; x=1719390003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAYmpGaIlWdxgsMDkaG8zIxFictKgFkTjRCndchDMo8=;
        b=ITupTZh4jZraFr5Q0S27dAQQ/8/EF8/J8EIReWlTwh2mt/YuEnzLZUGVArmT97PhGO
         yLSeOQ4BfqNuwrLjsE2rJIaHgt4yyd/DAEUx++HM+whSB4Z17858Dm5T+XaunafqMwSI
         91XDHWtUkr/eW6qozrAmp/Q7++hzmMDfjsJVyz3Z0OXnlt3Sf9//pxOptyrdUemKsM0X
         613ZigSeHYRM/cnnEamIwZUseg97Zs8k6JWjVnWWU3aHmlhHKO7CEYZbGO40xf6s33bA
         YcEsxtOGCWy8DcQLQN4Jjv+M3tGUed5XYBgNFQpYBkoTQ75lo44jmJYUQcc1kP4FEp+f
         BBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718785203; x=1719390003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kAYmpGaIlWdxgsMDkaG8zIxFictKgFkTjRCndchDMo8=;
        b=XWZW2FGfGAIDZnLEOf98gHqNtN1zXCOLZhpr5P11xf5XGiifopwND13mIb5eKtfokz
         D9AxbZBdqOYQHW03shr25L+HsNw0/BengWBof3szcOnWDRMm3JpI1KZKaLXuUyZ3KR5M
         dHJIJg/0dhYC+aAvNgYSs2erXU1Wr40CRaRHd1BY+WY6Gi3QhFuS6xQGhYK9/hJ1QcO1
         XSrvEK3EL8xwVFCnF8g9VtgrIgUYQ5PkoyoCIBSRGaSy8vvsBdMN30fupOnO/4zpRXz3
         msQ3nZ8MSvLjk2l50Cqq+SrdxfAQ3GlXModj64wgpqzX04FwE0IKZlBlX+b/wDdyh+Rm
         YCUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZXqPOAmDGcMU7t59aUwNjhtCSWfbkIp2er6GVE3DMzyOoRxnvFcL+mktxn86296d2uTRmzZs4R3i5ASS3JmIDYUmt2yoO7mtL3BKyXaCco+F2SOEjwU1HrKt0vDpBhL35IwS6NH+LDf9R8oZvVw==
X-Gm-Message-State: AOJu0YzUkL+XBoC02fk7DJCCDFDmKsSL1spPYEt1cRTNmnlNTiIaXFl+
	wIFOQBNMSXQlE3WqSdSLX5HOt39Mb4+4T/hDjNF3AfgbohyOJFPW
X-Google-Smtp-Source: AGHT+IFgftcucoFbUM8uwfsYsAAE572uQqDK+s6ybdqzlvlcyet5YSsOUg7O/GR6vGlt5OY27tW7Qw==
X-Received: by 2002:a17:903:1c2:b0:1f7:1687:3062 with SMTP id d9443c01a7336-1f9aa46582dmr23615645ad.61.1718785203190;
        Wed, 19 Jun 2024 01:20:03 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1decfsm110368105ad.250.2024.06.19.01.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 01:20:02 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 4/5] perf trace: Filter enum arguments with enum names
Date: Wed, 19 Jun 2024 16:20:41 +0800
Message-ID: <20240619082042.4173621-5-howardchu95@gmail.com>
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

Tested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
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

