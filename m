Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DE815250F;
	Fri,  5 Jul 2024 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720185661; cv=none; b=L7H4ci/tg4hGcBw6EpjG80sCYztImnFS6SgFFQbPzpKjG7fRfaqdbO3WeG12tW61CpJttdbJ78HdIC7sCpO0YA+ApNHHq66ADOAKlW/0fGqZ5eeWJ9nXDO1uubuPKzIG98pCO768MLfSxP6bZu3Prr7NSc5KVNuSXftDq+tBqMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720185661; c=relaxed/simple;
	bh=wDgsftP4Z2gjtvPtuKIKy8aJh8WgfvjpQOBfMGDJbMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbzOHwxZ5BnDptoANJZRZ3QscdqwCOpXsLIxsPhdWNDTtU6pz36J8/NGOgRwS474sFVF4u+PsK7mMcC6E3Ogt1ejEyiDvHxzrbg+dMSbue8MrXcSGH02MJJ03+FVCBsCyUIw5DfGy1fbqLqpA0gi+RX2U2IlzjGaj9z4KU/a8K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcuUeKE3; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcuUeKE3"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2c96170d23eso1140091a91.0;
        Fri, 05 Jul 2024 06:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720185659; x=1720790459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYTot191GZo6DS32N1w+V73flNMPv1Itq1GPGesqtFc=;
        b=HcuUeKE3iSyUPkLrkx8jeKvdZeCUgO0OhWsg3R+2iHP05FxgvrZHYx83Gp37ixjNU+
         i78vPhgQltQlBLgnHkya0MWzl+4yPZOEAKgB2yDVT7O9UvKew3rGEMeWrVSNGtn+6tfk
         1eMud+kJcGZj2WfwwWlQGfPTeb6EvmJHqmkq0dlBJ8J73LSg8XU0ghVax1MuYlXpzi0R
         fnzY7BwXFIWHjARfiRFdwFPSoRyuVnwwubcyBkpR+0qrUHXeQ7cYgQCiKIbL6tyhARGo
         EumjWUH1Ia24RNZGps4Vg9CfU3xSk/jAQYlEsuivwJLTxjn2cAMvwuLVym2CgpxyLdgZ
         zqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720185659; x=1720790459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYTot191GZo6DS32N1w+V73flNMPv1Itq1GPGesqtFc=;
        b=qdLl20ZwGDf6rv9vVN9ZXVbY5YZZOyl8FAhOZVUCk3SNx0JA7afDKhRwqU0HSGb8oc
         cmieIkMGMotsVAE8VekGdmORs9iP4MBbCCnyHW2unhtY58AHfTvPul0nOu4NPhy2inB+
         fEaioO2y0PrYTM/jeoZBDHLvbS8iL39KUxEShLcfvWwv505pjL8OFG/nu83HwhQrIkFw
         o8MeQm7wLPJVm6wZ15r20HTlAt0cKtzhA5F/lIzGc87YcONoU//h6Z409bkWcX0qylCA
         8y56OcaIeKX7R2mnsl1Hi4aJTRMb53T11wunTGEVZJwMwCEDEhy1FsS30eDmcSrgiFhg
         +aQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxLtKHdqUtFXPCGI3raUAzjyUUzt6FwdbYA9xd4zuggY+SnIeMTighZazOJ/bal0qMoq4YTRhGJJ9FBih/QsNDsSfvFs6NnpeUElct3qPopJ4JixP2e0biy2CxH1zDMgKpuFg8RQ/KBkQNij2mAw==
X-Gm-Message-State: AOJu0Yyq7ZE7XAJtCkReFQX9pt8aDa1SSvWJ/EzbRjp+Rqj9qa/XqUrm
	auysJQexqAy6Aplf7B8gMgMi5tQgaSB14X8xhNreHLDI6nD7zuK6
X-Google-Smtp-Source: AGHT+IFTO8gY63VFci8BKxgM5Yq5F6qZwCpz32kmO8O4wOepxy/rQZh9GzTxK1qznhBBekHEWxKCXw==
X-Received: by 2002:a17:90b:193:b0:2c7:dfb6:dbe6 with SMTP id 98e67ed59e1d1-2c99c822e05mr2824515a91.45.1720185659536;
        Fri, 05 Jul 2024 06:20:59 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a956260sm3328974a91.19.2024.07.05.06.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 06:20:59 -0700 (PDT)
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
Subject: [PATCH v5 4/8] perf trace: Filter enum arguments with enum names
Date: Fri,  5 Jul 2024 21:20:54 +0800
Message-ID: <20240705132059.853205-5-howardchu95@gmail.com>
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
Link: https://lore.kernel.org/r/20240624181345.124764-5-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 62 ++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5618feb7d01a..e664001d5ed7 100644
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

