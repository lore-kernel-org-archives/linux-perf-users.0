Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5981A0737;
	Mon, 24 Jun 2024 18:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252743; cv=none; b=rJW5+aY+Rb/kkSlu3V4r4rMjckJ2hXvnLinjqNd1ZSiwzg1Of0++qBeVBPP/XF0pGPU6xfLc50eOicAryS46hYeV7QML3xT2hvnrE0bw1xOF1BglNXSUVLyDnxUw6bQC5J6xRzII8FroYE/te8Dyv/fOGz1YJ4JCqc7sowlGyDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252743; c=relaxed/simple;
	bh=FCflzXRfIBkmPrsJBiVLv4B/Bs+p5pIjpGSmNemb7DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sH5yUikaVtQxBrM1muJKraniIlsV2IuZDTiNetDWj4SC4GF0L19wbEoidHXw8WDypS/jxfwBTBHjgLVaY41JaIix+ul0x4C+7wRXtmeCO8dfzVIuRaeyzGRXs85lzrqNOiadjkqrKm+WDR/KrnWcOdPIYQGGNOn7UbP2t4VrgM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OV6dsw/A; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OV6dsw/A"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70670188420so1499968b3a.2;
        Mon, 24 Jun 2024 11:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719252741; x=1719857541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfFvNRUd3k0l2BbDbdovkMoUJ9munmVB6DMhjUi2umk=;
        b=OV6dsw/ASJZ8EMiFg4NhLBlONfxt7qhYvXnQhTI2d9sZv17MS2/3Rk9gzH8pZx0CvJ
         aEDZKl8yLtCuJeTp+iaAEEneLNZQPdL2oOKqd0PeeC8AF7pGZAMlDKKq63qODR3lA+5U
         bhwPljZOVKvoqfT6y4hWn7EksX9rZAmDSIzRmU9L5jxyQIRR+/HCOVleN75IW+PNPYBS
         D5haAwoLUxAYuwZTvgcmLHgN39CQUb0ZaYCZQ7Tf+kYqKX7WgESn0GKR/F4VUXy0SBEq
         5ilzkImyPLEDSMY0fXbAxJP0B94YkLPkQ6Z7LHCzAnFkz1TtNJH0ylSV+7zvkL+HaCiq
         3PKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719252741; x=1719857541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfFvNRUd3k0l2BbDbdovkMoUJ9munmVB6DMhjUi2umk=;
        b=Pw693KZTh1fEYp8YZvm7Lc4qQdVxdvCE11ZyRi3/4heVScXfRWxbUFsPmi4DSS1fO7
         /arNEx4iBYZDAcGNtY3iw09Y0WAsPICUE7Zn+mWAoKJ8bDnyw6rUcfYTuWvT0Gl71rVV
         bh99NOQEET6o41MC4pxPqpsdwKx1PlCHuMvob5bUau8BU0mtpltB464OZzk9IYoNJpq+
         jv1W7oFuM9rqy+whX7zKkIsnl/0QnOCgdpF1E1rL6Qhwsxt16o5J1x5Lfj19MkTpB1y/
         L3j4b1Jv5633aCNtEhFCgo3wOi+x+tP35E0ZTttUp9eMmp+stlVCQz1yUkKSFRlANjDH
         pApg==
X-Forwarded-Encrypted: i=1; AJvYcCWJGDxiGosxhkovWK3fqO7CDvtZEiCEcKyh5/955ePgheEbduayeRh5hwewi/5mEUAfi1QvVsnIVXV/HU0jgXYVZuOYsSWaDCwVt8u/5YB8x4p+/+6lyfGN/ZWW0/ohCAQbPaAKc9YgfUkgCUnT9g==
X-Gm-Message-State: AOJu0YzPuIVzYjIjS5UrWW9q3cqa6R3X4Uxu9DICqy9stw8h9S8nuXRv
	XAtcHrjILtueBAU2AGX0WVfwuPnDaC9cIZ8hiKzsGnov4vUbRObc
X-Google-Smtp-Source: AGHT+IHClCSMjxca4Uj2fkM9yj5SluBqQMZN7gbvGZOiuuo91xhHQxe957FhV91D0R3Typ/ET3J6IA==
X-Received: by 2002:aa7:93cb:0:b0:706:65f6:3ab9 with SMTP id d2e1a72fcca58-7066e55590bmr4947056b3a.20.1719252740753;
        Mon, 24 Jun 2024 11:12:20 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70651290157sm6525157b3a.150.2024.06.24.11.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 11:12:20 -0700 (PDT)
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
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 4/8] perf trace: Filter enum arguments with enum names
Date: Tue, 25 Jun 2024 02:13:41 +0800
Message-ID: <20240624181345.124764-5-howardchu95@gmail.com>
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

Committer testing:

  root@x1:~# perf trace -e timer:hrtimer_start --filter='mode != HRTIMER_MODE_ABS' --max-events=2
       0.000 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff2a5050, function: 0xffffffff9e22ddd0, expires: 241502326000000, softexpires: 241502326000000, mode: HRTIMER_MODE_ABS_PINNED_HARD)
  18446744073709.488 :0/0 timer:hrtimer_start(hrtimer: 0xffff8d4eff425050, function: 0xffffffff9e22ddd0, expires: 241501814000000, softexpires: 241501814000000, mode: HRTIMER_MODE_ABS_PINNED_HARD)
  root@x1:~# perf trace -e timer:hrtimer_start --filter='mode != HRTIMER_MODE_ABS && mode != HRTIMER_MODE_ABS_PINNED_HARD' --max-events=2
       0.000 podman/510644 timer:hrtimer_start(hrtimer: 0xffffa2024f5f7dd0, function: 0xffffffff9e2170c0, expires: 241530497418194, softexpires: 241530497368194, mode: HRTIMER_MODE_REL)
      40.251 gnome-shell/2484 timer:hrtimer_start(hrtimer: 0xffff8d48bda17650, function: 0xffffffffc0661550, expires: 241550528619247, softexpires: 241550527619247, mode: HRTIMER_MODE_REL)
  root@x1:~# perf trace -v -e timer:hrtimer_start --filter='mode != HRTIMER_MODE_ABS && mode != HRTIMER_MODE_ABS_PINNED_HARD && mode != HRTIMER_MODE_REL' --max-events=2
  Using CPUID GenuineIntel-6-BA-3
  vmlinux BTF loaded
  <SNIP>
  0
  0xa
  0x1
  New filter for timer:hrtimer_start: (mode != 0 && mode != 0xa && mode != 0x1) && (common_pid != 524049 && common_pid != 4041)
  mmap size 528384B
  ^Croot@x1:~#

Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Howard Chu <howardchu95@gmail.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/ZnCcliuecJABD5FN@x1
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 62 ++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b75d96a4ad55..774bb3534df4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -932,6 +932,37 @@ static int syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_fmt, stru
 	return arg_fmt->type == NULL ? -1 : 0;
 }
 
+static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct syscall_arg *arg, u64 *val)
+{
+	const struct btf_type *bt;
+	char *type = arg->parm;
+	struct btf_enum *be;
+	struct btf *btf;
+
+	trace__load_vmlinux_btf(arg->trace);
+
+	btf = arg->trace->btf;
+	if (btf == NULL)
+		return false;
+
+	if (syscall_arg_fmt__cache_btf_enum(arg->fmt, btf, type) < 0)
+		return false;
+
+	bt = arg->fmt->type;
+	be = btf_enum(bt);
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
 static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, char *bf, size_t size, int val)
 {
 	struct btf_enum *be = btf_enum(type);
@@ -965,8 +996,16 @@ static size_t trace__btf_enum_scnprintf(struct trace *trace __maybe_unused, stru
 {
 	return 0;
 }
+
+static bool syscall_arg__strtoul_btf_enum(char *bf __maybe_unused, size_t size __maybe_unused,
+					  struct syscall_arg *arg __maybe_unused, u64 *val __maybe_unused)
+{
+	return false;
+}
 #endif // HAVE_LIBBPF_SUPPORT
 
+#define STUL_BTF_ENUM syscall_arg__strtoul_btf_enum
+
 #define STRARRAY(name, array) \
 	  { .scnprintf	= SCA_STRARRAY, \
 	    .strtoul	= STUL_STRARRAY, \
@@ -1867,6 +1906,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 			arg->scnprintf = SCA_FD;
 		} else if (strstr(field->type, "enum") && use_btf != NULL) {
 			*use_btf = arg->is_enum = true;
+			arg->strtoul = STUL_BTF_ENUM;
 		} else {
 			const struct syscall_arg_fmt *fmt =
 				syscall_arg_fmt__find_by_name(field->name);
@@ -3792,7 +3832,8 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 	return __trace__deliver_event(trace, event->event);
 }
 
-static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(struct evsel *evsel, char *arg)
+static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(struct evsel *evsel, char *arg,
+								   char **type)
 {
 	struct tep_format_field *field;
 	struct syscall_arg_fmt *fmt = __evsel__syscall_arg_fmt(evsel);
@@ -3801,13 +3842,15 @@ static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(struct evsel
 		return NULL;
 
 	for (field = evsel->tp_format->format.fields; field; field = field->next, ++fmt)
-		if (strcmp(field->name, arg) == 0)
+		if (strcmp(field->name, arg) == 0) {
+			*type = field->type;
 			return fmt;
+		}
 
 	return NULL;
 }
 
-static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel *evsel)
+static int trace__expand_filter(struct trace *trace, struct evsel *evsel)
 {
 	char *tok, *left = evsel->filter, *new_filter = evsel->filter;
 
@@ -3840,14 +3883,14 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
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
@@ -3860,9 +3903,16 @@ static int trace__expand_filter(struct trace *trace __maybe_unused, struct evsel
 			if (fmt->strtoul) {
 				u64 val;
 				struct syscall_arg syscall_arg = {
-					.parm = fmt->parm,
+					.trace = trace,
+					.fmt   = fmt,
 				};
 
+				if (fmt->is_enum) {
+					syscall_arg.parm = type;
+				} else {
+					syscall_arg.parm = fmt->parm;
+				}
+
 				if (fmt->strtoul(right, right_size, &syscall_arg, &val)) {
 					char *n, expansion[19];
 					int expansion_lenght = scnprintf(expansion, sizeof(expansion), "%#" PRIx64, val);
-- 
2.45.2

