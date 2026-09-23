Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB8545A284
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147671; cv=none; b=sMGE7dQSq1Ggdw/hKiDIdK+phRc77+E8rHs3H/x2R32iI58X0iXdphlykCNPnUzn4CO3EZhDXQ90xV0yn8F+28aGx2p3ialcIG2lCy+1478UaexcKtEiJrysuDTseonZRIzaFtn7pwysw/wAf58dM+QG7jD8O6KrOqKiZ53rGag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147671; c=relaxed/simple;
	bh=5k0rS1+XJCFv2HYR1dRWlXW00OtVoNzmb+6fvtbV4C8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hbUICJ87zMSqOyuDUMNs3JSw35s93q70YUgE8a9Gs8vUUsG0+xtbhnFAyIN3hmhOMygXh435XmP+lX2rPbOEv1TLCGMLCtiACT6qtZJmBn3VZMO1jSUnU8vaPloG7DIyqKt3h5HlCu7hEV51FFfruT7oUvQ9LHzPA9rK7XvF1T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u17uAwSU; arc=none smtp.client-ip=74.125.82.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u17uAwSU"
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-32ab0911226so711369eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 00:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147669; x=1790752469; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B5G/9q1PZ/l1tPYX6weOFHFsE+Y/Z2BolEBxDoK3efw=;
        b=u17uAwSUpI+7i+cpxcnJezChsy3dSQMsmBdJ62502nd5lzpdDRa5+/97XEbLvCqf31
         wyPmQBlpW8L2dt/L451bEimQzbb5ZpiPOJQDUF7PdoEL2qlE6wAzxK3WAfVHkVRs2qYo
         5ZUqMkEjYdqFsjIGwyDXK6T1mgJ9p8Ifn7yBB6BQNaP/3VRinPSPC9oMcP4BxrwXVy/O
         Sm8eAQnkWon7sthHQS/FqnsWAwlJiBLTUj5SmBPYfpxNQFe8ETsbBEs27YNCpzX7EYnh
         lFG0mwWx6W+g76Wi0YbdbvXgmG4uvD2lUqZJTLyhDV5vnrjLuA6WE0pvE/zxWl+OFX+C
         fqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147669; x=1790752469;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B5G/9q1PZ/l1tPYX6weOFHFsE+Y/Z2BolEBxDoK3efw=;
        b=YcZQ+yqhzqxA+myc8PuZy8bed5u32bSlwuSfT0KSrGWOCWDf2SPQIaj5pt1KvgFCLe
         xmLix56QURyF//ytqZhtUISqId4lD5A+N6ygmcU1Ev3c8BOKSx4Ky+lB8zuinsXzmyf1
         jVahvh+JNhPE7cKxvm/Fm9ZOrYEapWgNQ8n1pdEOkt0s0KBmFysIyQw9UKubG+V4drYs
         QRIwKPxMMN3WBHPjYkYBbgDWbXkycgChC8028C6DojgPcGyxeSFnNrSvPrTrrRmxjS2S
         oZ5BhfAI6k3qfOD7IkdQnk+rJgQEJ7wrSuNsVLWXpEZvI+hVFGuJEZt7ZZbjkMHGRLkD
         DaCQ==
X-Forwarded-Encrypted: i=1; AKwUvBzx2Mqf2Y8TSWoMSy2dmAoHTaNdLOWjgj/sUpq9A0W8XAr886qh0H5E1wcFuXt3pQdtdM5lnakb0KolV0yvyi+G@vger.kernel.org
X-Gm-Message-State: AFuF++keeGpSkXE1LgOMALhu3Lq9989JbId5mIaipT0brykgd8KuaVDQ
	35iCF69MYqv6fhQMbbfbCuhetZiN7yF0d6tMCFppGaPzLLavvCB1oI9Nh3Xxh2HU5dxdOcNr+7Q
	NsGPa9cZAIA==
X-Received: from dlbtp12.prod.google.com ([2002:a05:7022:3b8c:b0:144:e5c8:7eb5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:3c0b:b0:143:1bb1:b3cc
 with SMTP id a92af1059eb24-144f8e175cdmr1801592c88.23.1790147668250; Wed, 23
 Sep 2026 00:14:28 -0700 (PDT)
Date: Wed, 23 Sep 2026 00:13:48 -0700
In-Reply-To: <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <99ab722ef23fa269a0c6a95381a7493fcd5d6e0a.1790145937.git.irogers@google.com>
Subject: [PATCH v5 08/23] perf trace: Bounds check augmented arguments before
 reading them
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, howardchu95@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Augmented arguments are length prefixed payloads that the BPF augmenter
appends to a sample: a struct augmented_arg header holding the payload
length, followed by the payload. arg->augmented.args points at the next
unconsumed one and arg->augmented.size says how many bytes are left.

Both the length and the number of bytes remaining come from the sample,
but syscall_arg__scnprintf_buf() takes the length on trust and loops
over it with no bound at all, so a bogus value walks straight off the
end of the static argbuf that syscall__augmented_args() copies into:

  #0 0x73104f in dump_stack debug.c:366
  #1 0x7310c5 in sighandler_dump_stack debug.c:378
  #2 0x7f749ea66fb0 in __restore_rt libc.so.6[19fb0]
  #3 0x4c0fa0 in syscall_arg__scnprintf_buf builtin-trace.c:1955
  #4 0x4c2f3d in syscall_arg_fmt__scnprintf_val builtin-trace.c:2632
  #5 0x4c33ae in syscall__scnprintf_args builtin-trace.c:2722
  #6 0x4c43d3 in trace__sys_enter builtin-trace.c:3094
  #7 0x4c7865 in trace__handle_event builtin-trace.c:4013

syscall_arg__scnprintf_augmented_string() likewise prints the payload
with "%.*s" and a length it has not checked, and both dereference the
header before testing it for NULL.

btf_struct_scnprintf() already gets this right. Lift its check into a
shared syscall_arg__augmented_args_valid() in beauty.h, which verifies
that a whole header is present and that the payload it advertises fits
in what is left, taking a @need argument for callers that go on to read
a fixed sized type, and use it at each of these sites.

An unusable payload now makes syscall_arg__scnprintf_filename() fall
back to the vfs_getname probe or the raw pointer, as it does when there
is no augmented data at all, rather than printing nothing.

Reported-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/arJ-gpzqOHk-gF8T@x2/
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c       | 29 ++++++++++++++-------
 tools/perf/trace/beauty/beauty.h | 43 ++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6ffd4a0718ca..eeaaab44016c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1139,14 +1139,12 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
 	LIBBPF_OPTS(btf_dump_opts, dump_opts);
 	LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
 
-	if (arg == NULL || arg->augmented.args == NULL || arg->augmented.size < (int)sizeof(*augmented_arg) ||
+	/* btf_dump__dump_type_data() below reads type->size bytes of the payload. */
+	if (!syscall_arg__augmented_args_valid(arg, type->size) ||
 	    arg->fmt == NULL || !arg->fmt->from_user)
 		return 0;
 
 	augmented_arg = arg->augmented.args;
-	if (augmented_arg->size <= 0 || augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg) ||
-	    (size_t)augmented_arg->size < type->size)
-		return 0;
 
 	dump_data_opts.compact	  = true;
 	dump_data_opts.skip_names = !arg->trace->show_arg_names;
@@ -1904,12 +1902,18 @@ static void thread__set_filename_pos(struct thread *thread, const char *bf,
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
@@ -1922,7 +1926,12 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
 {
 	unsigned long ptr = arg->val;
 
-	if (arg->augmented.args)
+	/*
+	 * A truncated or otherwise unusable augmented payload is no better than
+	 * not having one at all, so test it here and let the pointer or the
+	 * vfs_getname probe name the file instead of printing nothing.
+	 */
+	if (syscall_arg__augmented_args_valid(arg, 0))
 		return syscall_arg__scnprintf_augmented_string(arg, bf, size);
 
 	if (!arg->trace->vfs_getname)
@@ -1938,13 +1947,15 @@ static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
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
index 0f4801c61a5b..71f93372c34e 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -124,6 +124,49 @@ struct syscall_arg {
 
 unsigned long syscall_arg__val(struct syscall_arg *arg, u8 idx);
 
+/**
+ * syscall_arg__augmented_args_valid: can the next augmented arg be read?
+ *
+ * Augmented arguments are a series of length prefixed payloads that the BPF
+ * augmenter appends to a sample, with arg->augmented.args pointing at the next
+ * unconsumed one and arg->augmented.size saying how many bytes are left.
+ *
+ * Both the remaining byte count and the length prefix come from the sample, so
+ * neither can be trusted: a sample that carries no augmented arguments at all
+ * can still have a few bytes of ring buffer padding after the tracepoint
+ * payload, and those bytes then look like a struct augmented_arg holding an
+ * arbitrary length.
+ *
+ * Check that a whole header is present and that the payload it advertises fits
+ * in what is left, so that a beautifier reading augmented_arg->value stays
+ * inside the sample.
+ *
+ * @need: how many bytes of payload the caller goes on to read, zero when it is
+ * driven by the length prefix itself rather than by a fixed sized type.
+ */
+static inline bool syscall_arg__augmented_args_valid(struct syscall_arg *arg, size_t need)
+{
+	const struct augmented_arg *augmented_arg;
+
+	if (arg == NULL || arg->augmented.args == NULL)
+		return false;
+
+	/* The header has to be there before its size field can be read. */
+	if (arg->augmented.size < (int)sizeof(*augmented_arg))
+		return false;
+
+	augmented_arg = arg->augmented.args;
+
+	/* A negative length would make the bounds below meaningless. */
+	if (augmented_arg->size < 0)
+		return false;
+
+	if (augmented_arg->size > arg->augmented.size - (int)sizeof(*augmented_arg))
+		return false;
+
+	return (size_t)augmented_arg->size >= need;
+}
+
 size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STRARRAY_FLAGS syscall_arg__scnprintf_strarray_flags
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

