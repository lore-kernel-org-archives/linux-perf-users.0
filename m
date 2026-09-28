Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB038B142
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619985; cv=none; b=j4YbBEPT3z1ojOKgsej4/E5jHvR3nHD/bVKLj0Hh38b7C7KZ+ntiuXZ3e0ccHIU0DPEw9BATkcnIdTqQw0bXujYNDvkjaLhZ3QlzxChEK/3tODL+f5xJ9tN2tU5NEYTVUjiJbOlBcEYnQv+vHgpykWwjew/VGiCRPj8OXY2LpLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619985; c=relaxed/simple;
	bh=w3NlFEyvJzAZZmgJDlvt3CnOvZGGYsCxvh+RIGdOzFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ULwRnjJ6rRUo0uJ9akw/a+PSAaoQYAeIwIOHKMA1Q7OPRmqvKhKwqAq3/SPufa5YSrkuudk6xm95nVxMEV/AK3c8tvIr0k1Lq9xvS2uOp9QIdANQRRdMEDUQEn/bN5n1P2U0beA30Mx8Nsi4s0p9Bz4tHAt9HOR3XLf7rGrOV8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nHe7fEQo; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nHe7fEQo"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so2024498eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790619983; x=1791224783; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZqU6q1a737Hr+IBPpKcss3zkg1I0C64fANCvsqa/Of4=;
        b=nHe7fEQot5OwPIm+JpavhH9XGAGuxsMB1fGql5RYCvdrlpmbMqVE0WGVykuGrcrjos
         Sr9YVJ1GDpI9jt7lD6a5rZTHNtHFT+P8Tj5VRLEGLTe7GF/TOj6OadyvuC4dogESsyyH
         rSnwOPp+W+Y0s2lLPUkPStVBGqCbhtJVa1zWjB5hP+C9kDCvuejLArYfug40IPC0CT4D
         DryMvCOfKIlLkO4Guksf8LF0Kx59qb4KuMtpbzsiRf0Vj8Bt4k1XhYVkxTvQIVGUCZic
         EgJNKlcnswgEQlPRePBGpIVVdK8yPnlGgvAJ+VpSplJEdeq0njJlm+InhlRaqbP4R7SH
         iz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619983; x=1791224783;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZqU6q1a737Hr+IBPpKcss3zkg1I0C64fANCvsqa/Of4=;
        b=V89mVP9Gm8ayZwLILNBSCIPFOBaRsFAhWoPsRGUu1T6+qLRqYpXpZ9VMWdi6JbCYCg
         H6maWGhFpz9vbwVpfJxMz6mCtL48EtnjI2Epg7HktFwGZa5whuW9rOCUZla6R292Bta0
         woBdQNhLvZ+u7XC6g5B1QBvDus8CtHXNnTslar8MJkIOinwQOlUB1qsUTcz2ewEER5Xj
         gHckYQ8ykPqaSWJmv9HtKlw6SgSIsFr5AsORM7K3Y849mt45loFAR5MPrN9ILt1GNcAy
         0z0FFKBRPlC2zYkhYd0pkDrA/VayuqOyDnoH0+4KzOqIShF0LQO+kzB48okEEiGNgSV0
         XFIA==
X-Forwarded-Encrypted: i=1; AKwUvBwKF5AWZzS2Fx+tiQoj+JQEVxCIBxFc+y4sG8G41QFDWzY2NMB+O8GatDNC3VjkOzDeUMCmdG9zmau6jMpwR8TX@vger.kernel.org
X-Gm-Message-State: AFuF++mLxoNwLUz40fZLAq6vBGrZTGkFRLakkw3Bq/pV3WJeeege7dLB
	AjrtzUjzqHoCm2DAoLnRGocDDu0QEG2Zq+K3kSbiYcwYar03bPPzv4tJd9CkydfS7RZjKii6GiA
	Pysc+OXkrcQ==
X-Received: from dlbep6.prod.google.com ([2002:a05:7022:1086:b0:144:c2f8:c025])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:5f12:b0:139:d82f:2fdd
 with SMTP id a92af1059eb24-146ce1aa79fmr9930472c88.8.1790619982141; Mon, 28
 Sep 2026 11:26:22 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:25:43 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-5-irogers@google.com>
Subject: [PATCH v6 04/26] perf trace: Bounds check augmented arguments before
 reading them
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

syscall_arg__scnprintf_buf() and syscall_arg__scnprintf_augmented_string()
trust the augmented arg's size, so a bad one reads out of bounds:

  #3 0x4c0fa0 in syscall_arg__scnprintf_buf builtin-trace.c:1955
  #4 0x4c2f3d in syscall_arg_fmt__scnprintf_val builtin-trace.c:2632
  #5 0x4c33ae in syscall__scnprintf_args builtin-trace.c:2722
  #6 0x4c43d3 in trace__sys_enter builtin-trace.c:3094
  #7 0x4c7865 in trace__handle_event builtin-trace.c:4013

Move the check in btf_struct_scnprintf() to a helper,
syscall_arg__augmented_args_valid(), and use it in both. When the check
fails, syscall_arg__scnprintf_filename() now falls back to vfs_getname or
the pointer.

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/arJ-gpzqOHk-gF8T@x2/
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c       | 23 ++++++++++++++---------
 tools/perf/trace/beauty/beauty.h | 17 +++++++++++++++++
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c39de91140a0..85db74965280 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1139,14 +1139,11 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
 	LIBBPF_OPTS(btf_dump_opts, dump_opts);
 	LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
 
-	if (arg == NULL || arg->augmented.args == NULL || arg->augmented.size < (int)sizeof(*augmented_arg) ||
+	if (!syscall_arg__augmented_args_valid(arg, type->size) ||
 	    arg->fmt == NULL || !arg->fmt->from_user)
 		return 0;
 
 	augmented_arg = arg->augmented.args;
-	if (augmented_arg->size <= 0 || augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg) ||
-	    (size_t)augmented_arg->size < type->size)
-		return 0;
 
 	dump_data_opts.compact	  = true;
 	dump_data_opts.skip_names = !arg->trace->show_arg_names;
@@ -1904,12 +1901,18 @@ static void thread__set_filename_pos(struct thread *thread, const char *bf,
 static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg *arg, char *bf, size_t size)
 {
 	struct augmented_arg *augmented_arg = arg->augmented.args;
-	size_t printed = scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
+	size_t printed;
+	int consumed;
+
+	if (!syscall_arg__augmented_args_valid(arg, 0))
+		return 0;
+
+	printed = scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
 	/*
 	 * So that the next arg with a payload can consume its augmented arg, i.e. for rename* syscalls
 	 * we would have two strings, each prefixed by its size.
 	 */
-	int consumed = sizeof(*augmented_arg) + augmented_arg->size;
+	consumed = sizeof(*augmented_arg) + augmented_arg->size;
 
 	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
 	arg->augmented.size -= consumed;
@@ -1922,7 +1925,7 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
 {
 	unsigned long ptr = arg->val;
 
-	if (arg->augmented.args)
+	if (syscall_arg__augmented_args_valid(arg, 0))
 		return syscall_arg__scnprintf_augmented_string(arg, bf, size);
 
 	if (!arg->trace->vfs_getname)
@@ -1938,13 +1941,15 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
 static size_t syscall_arg__scnprintf_buf(char *bf, size_t size, struct syscall_arg *arg)
 {
 	struct augmented_arg *augmented_arg = arg->augmented.args;
-	unsigned char *orig = (unsigned char *)augmented_arg->value;
 	size_t printed = 0;
+	unsigned char *orig;
 	int consumed;
 
-	if (augmented_arg == NULL)
+	if (!syscall_arg__augmented_args_valid(arg, 0))
 		return 0;
 
+	orig = (unsigned char *)augmented_arg->value;
+
 	for (int j = 0; j < augmented_arg->size; ++j) {
 		bool control_char = orig[j] <= MAX_CONTROL_CHAR || orig[j] >= MAX_ASCII;
 		/* print control characters (0~31 and 127), and non-ascii characters in \(digits) */
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 0f4801c61a5b..1cd307328bb2 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -124,6 +124,23 @@ struct syscall_arg {
 
 unsigned long syscall_arg__val(struct syscall_arg *arg, u8 idx);
 
+/* Is there a whole augmented arg left with at least @need bytes of payload? */
+static inline bool syscall_arg__augmented_args_valid(struct syscall_arg *arg, size_t need)
+{
+	const struct augmented_arg *augmented_arg;
+
+	if (arg == NULL || arg->augmented.args == NULL ||
+	    arg->augmented.size < (int)sizeof(*augmented_arg))
+		return false;
+
+	augmented_arg = arg->augmented.args;
+	if (augmented_arg->size < 0 ||
+	    augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg))
+		return false;
+
+	return (size_t)augmented_arg->size >= need;
+}
+
 size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STRARRAY_FLAGS syscall_arg__scnprintf_strarray_flags
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

