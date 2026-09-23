Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AEE45DF49
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147676; cv=none; b=YGAOdvy5+jrKUGnnfsR33ZWFA89JNUAHTOgweBxeqc+81X/BeNjVZiJHqO10LN7u540SDZQ1Ajh06ALVH9G0NLsMKn6hYLrQfYUjdd0E2x6j8hA1k+aWYTuOpNINAhoBf9ftFuYvyqbXxSgGqpkBhEXTjIgEKR8tanjw0eYfBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147676; c=relaxed/simple;
	bh=Tj3yDs8rwCDj/BB1fmxJiip60F8wgE92QfWT3F32Oec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SNyFpiOvnte27Ph8AAb6PZTv9BCXcHSJCN6q0pSOIt/cH9tOXitBsJAc9lTR+VPmAeGM65Hujd7pTIk1Zx5+5k1rw+bwHSS5chO0OKvZ1al37EbBtBxYVJ0GSQcPWXGxLhcFhbxIJ1ANnCNQuCMmV25eYsaQdacoABGL0n8t+2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dYWKAKMm; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dYWKAKMm"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-14383177746so903994c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 00:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147673; x=1790752473; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=liyi0vSB4PI71vdWOqs25tQFPCa2XdpECr64MsD1W7w=;
        b=dYWKAKMmDK7jhPkhaNQwB6yPBpOb3FT/HCaqH99dxKodtn5Kp6pUKF486zHos3r3T6
         4JyCOE4W+HvJ1URfRgNMtbI4JVQ6khQDqR12i1xG3FlR12RfNH18U5/q153c2R51hKB2
         DHAY816re/FNGLoOzQQ41iRFX88yWdvCvzG0JhVzJoaDwTg+fTSw49OdCkhN/zLF08Eb
         db4YLIKFvR570pt2a8imCEN+drDXgk3bJcNAw5wkypXBdEYNsGHA6VgWfMP7xaWJOf8Y
         xazX5zfPsUQ2WiW0Xc/V+A/6CmpdeVTJZ+0UXloHlS91p6oncQhoZKgksTwIAjl83Ow0
         P0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147673; x=1790752473;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=liyi0vSB4PI71vdWOqs25tQFPCa2XdpECr64MsD1W7w=;
        b=i9WopYPMZ63RN5aStWDDF7dG3vGSV4K8gSeH5fyxt8ZKfdVIuR64/LJ6KE3vSg6eEl
         4ETS8xN8Et7vGFdNe6p9EF2DdFBMA9LTA2xYlPNHCJKNqox9my1EHsiIi3A9vHTw0M5K
         s2bZ/wcs4S975lBf6XipnRAjdK7Jyf27k0ycZgOmrUWRQD8b9UUstOh/tWSVyG/yMD/3
         mqJdr26Dq+siSwzWCK8VgB57Yq42QIkSlfI7LSt+/kQck+4RM/oA1sifOUxaxMRfQY6R
         yoMjjoB9+OYTTKaoI8youE/fJlXw747tIyrqz+GhkDsH/I1rwVXTnGZj541MN1aanvrR
         vOnA==
X-Forwarded-Encrypted: i=1; AKwUvBxDKcPJ4G01RVrasd+4FRBkWH+ElmAOmNvyd7zfbJT4LZgDWJI5s+2ltJqUw9kNpjrJRbQ0yhp+X2g9YcOeA6Yl@vger.kernel.org
X-Gm-Message-State: AFuF++meQ4bdLo+4yEHr2DzhW9XkXjJ44FltcKg4sVwgnTsQhoLo0HKy
	1jbodX5mZlAA5thhgq8+7lTGbBXaXdes+EtO+cOs3j2soEC27kVM/2TNKFQ4NEKc+yKnLqeC6+D
	RfvJhRyG4dA==
X-Received: from dlam20-n2.prod.google.com ([2002:a05:701b:2094:20b0:144:ece5:c0c4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2044:10b0:144:c112:5f23
 with SMTP id a92af1059eb24-144f9179515mr2172461c88.24.1790147666238; Wed, 23
 Sep 2026 00:14:26 -0700 (PDT)
Date: Wed, 23 Sep 2026 00:13:47 -0700
In-Reply-To: <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <4315f435177b66e0b25ca9b74a89cc2f51d3801d.1790145937.git.irogers@google.com>
Subject: [PATCH v5 07/23] perf trace: Skip internal tracepoint fields in
 formatting and beauty map
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, howardchu95@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Linux 6.19+ added __data_loc char[] internal fields for string
arguments in syscalls:sys_enter_<name> tracepoints (e.g.,
__data_loc_oldname in sys_enter_renameat2). While is_internal_field()
was added to detect them, several places did not properly account for
them:

1. In syscall_arg_fmt__init_array(), when an internal field was
   skipped, the arg pointer was still incremented, causing the
   subsequent argument formatters to be mismatched. Leaving the slot out
   is only right for syscall tracepoints, where syscall__scnprintf_args()
   indexes the array the same packed way and sc->nr_args is counted to
   match. Every other tracepoint reaches the array through
   trace__fprintf_tp_fields(), which advances the field list and the
   array in lockstep, and for those a __data_loc char[] is an ordinary
   dynamic string to be shown rather than something the kernel appended
   to a syscall behind perf's back. Add a skip_internal argument so that
   each caller gets the layout it indexes.
2. In syscall__scnprintf_args(), internal fields were not skipped,
   causing spurious trailing arguments like ", 0, 16" to be formatted
   and printed.
3. In trace__bpf_sys_enter_beauty_map(), internal fields were not
   skipped, offsetting beauty array argument indices and breaking string
   and buffer augmentation.
4. In trace__find_usable_bpf_prog_entry(), candidate pointer checks
   matched on internal pointer fields, breaking signature compatibility
   matching between syscalls for augmenter sharing. Introduce
   next_user_arg() and advance both cursors with it, so that the two
   argument lists are always compared at a real argument and the walk
   ends when one syscall runs out of arguments rather than when one
   happens to have trailing internal fields.
5. syscall__augmented_args() computed the augmented payload as
   sample->raw_size - sc->args_size for any sys_enter style sample.
   sc->args_size deliberately stops at the last non-internal field, so
   on 6.19+ a native syscalls:sys_enter_<name> record leaves the
   __data_loc words and their string payloads in the remainder. Those
   bytes are not a struct augmented_arg, so
   syscall_arg__scnprintf_augmented_string() read a bogus length and
   walked arg->augmented.args out of bounds. This is reachable from
   trace__event_handler(), which calls trace__fprintf_sys_enter() for
   any evsel whose tracepoint name starts with "sys_enter_".
6. In syscall__read_info(), syscall__alloc_arg_fmts() was called before
   checking and dropping the leading __syscall_nr (or nr) field, using
   nr_fields - 1 unconditionally. If a tracepoint format lacks that
   leading field, the allocated arg_fmt array is one entry too small and
   syscall_arg_fmt__init_array() writes one entry past the end of the
   heap buffer. Drop __syscall_nr/nr first and size the allocation from
   the remaining fields.

Update these functions to check and skip is_internal_field() so that
arguments are correctly formatted and beauty map entries match the
expected syscall signatures, restrict syscall__augmented_args() to the
__augmented_syscalls__ bpf-output evsel, and size arg_fmt after dropping
the syscall number field.

Publish sc->args only once that allocation has succeeded. sc->name is
set earlier in syscall__read_info(), and a later call takes a syscall
with a name to have been read already and returns it as it stands, so
a syscall left with arguments and no arg_fmt to describe them would be
printed by walking the arguments and indexing an array that was never
allocated.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 194 ++++++++++++++++++++++++++++---------
 1 file changed, 148 insertions(+), 46 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f90c6bb4d8b4..6ffd4a0718ca 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2276,22 +2276,40 @@ static bool field_is_ptr_sized(const struct tep_format_field *field)
 	return field->size == ptr_size || field->size == sizeof(u64);
 }
 
+/*
+ * @skip_internal: whether an internal field is left out of the array rather
+ * than given a slot of its own.
+ *
+ * Syscall tracepoints want it left out, as syscall__scnprintf_args() walks the
+ * array with an index that skips internal fields too and sc->nr_args is counted
+ * the same way.
+ *
+ * Other tracepoints do not: trace__fprintf_tp_fields() advances the field list
+ * and this array in lockstep, so every field needs a slot or the fields after
+ * an internal one are formatted with the wrong entry. For them a
+ * __data_loc char[] is also an ordinary dynamic string to be shown, rather than
+ * something the kernel appended to a syscall tracepoint behind perf's back.
+ */
 static struct tep_format_field *
 syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field,
-			    bool *use_btf)
+			    bool *use_btf, bool skip_internal)
 {
 	struct tep_format_field *last_field = NULL;
 	int len;
 
-	for (; field; field = field->next, ++arg) {
-		/* assume it's the last argument */
-		if (is_internal_field(field))
+	for (; field; field = field->next) {
+		if (is_internal_field(field)) {
+			if (!skip_internal)
+				++arg;
 			continue;
+		}
 
 		last_field = field;
 
-		if (arg->scnprintf)
+		if (arg->scnprintf) {
+			++arg;
 			continue;
+		}
 
 		len = strlen(field->name);
 
@@ -2348,6 +2366,7 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 				}
 			}
 		}
+		++arg;
 	}
 
 	return last_field;
@@ -2356,7 +2375,8 @@ syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field
 static int syscall__set_arg_fmts(struct syscall *sc)
 {
 	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args,
-									  &sc->use_btf);
+									  &sc->use_btf,
+									  /*skip_internal=*/true);
 
 	if (last_field)
 		sc->args_size = last_field->offset + last_field->size;
@@ -2368,7 +2388,8 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
 {
 	char tp_name[128];
 	const char *name;
-	struct tep_format_field *field;
+	struct tep_format_field *args, *field;
+	int nr_args;
 	int err;
 
 	if (sc->nonexistent)
@@ -2407,24 +2428,35 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
 		return err;
 	}
 
-	/*
-	 * The tracepoint format contains __syscall_nr field, so it's one more
-	 * than the actual number of syscall arguments.
-	 */
-	if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields - 1))
-		return -ENOMEM;
-
-	sc->args = sc->tp_format->format.fields;
+	args = sc->tp_format->format.fields;
+	nr_args = sc->tp_format->format.nr_fields;
 	/*
 	 * We need to check and discard the first variable '__syscall_nr'
 	 * or 'nr' that mean the syscall number. It is needless here.
 	 * So drop '__syscall_nr' or 'nr' field but does not exist on older kernels.
+	 *
+	 * Do this before allocating, and size the array from what is left, so
+	 * that a format without the field does not leave
+	 * syscall_arg_fmt__init_array() walking one entry past the end.
 	 */
-	if (sc->args && (!strcmp(sc->args->name, "__syscall_nr") || !strcmp(sc->args->name, "nr"))) {
-		sc->args = sc->args->next;
-		--sc->nr_args;
+	if (args && (!strcmp(args->name, "__syscall_nr") || !strcmp(args->name, "nr"))) {
+		args = args->next;
+		--nr_args;
 	}
 
+	if (syscall__alloc_arg_fmts(sc, nr_args))
+		return -ENOMEM;
+
+	/*
+	 * Only now that there is an arg_fmt for each of them are the arguments
+	 * published. sc->name was set above, so a later syscall__read_info()
+	 * takes this syscall to be read already and returns it as it stands;
+	 * were sc->args set with sc->arg_fmt still NULL, the printing of that
+	 * syscall would walk the arguments and index an array that does not
+	 * exist.
+	 */
+	sc->args = args;
+
 	field = sc->args;
 	while (field) {
 		if (is_internal_field(field))
@@ -2452,7 +2484,8 @@ static int evsel__init_tp_arg_scnprintf(struct evsel *evsel, bool *use_btf)
 		const struct tep_event *tp_format = evsel__tp_format(evsel);
 
 		if (tp_format) {
-			syscall_arg_fmt__init_array(fmt, tp_format->format.fields, use_btf);
+			syscall_arg_fmt__init_array(fmt, tp_format->format.fields, use_btf,
+						    /*skip_internal=*/false);
 			return 0;
 		}
 	}
@@ -2642,10 +2675,16 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 	if (sc->args != NULL) {
 		struct tep_format_field *field;
 
-		for (field = sc->args; field;
-		     field = field->next, ++arg.idx, bit <<= 1) {
-			if (arg.mask & bit)
+		for (field = sc->args; field; field = field->next) {
+			/* Skip internal fields so they are not printed as spurious arguments */
+			if (is_internal_field(field))
+				continue;
+
+			if (arg.mask & bit) {
+				++arg.idx;
+				bit <<= 1;
 				continue;
+			}
 
 			arg.fmt = &sc->arg_fmt[arg.idx];
 			val = syscall_arg__val(&arg, arg.idx);
@@ -2664,8 +2703,11 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			 */
 			if (val == 0 && !trace->show_zeros &&
 			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].show_zero) &&
-			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].strtoul == STUL_BTF_TYPE))
+			    !(sc->arg_fmt && sc->arg_fmt[arg.idx].strtoul == STUL_BTF_TYPE)) {
+				++arg.idx;
+				bit <<= 1;
 				continue;
+			}
 
 			printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
 
@@ -2680,12 +2722,16 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 								   size - printed, val, field->type);
 				if (btf_printed) {
 					printed += btf_printed;
+					++arg.idx;
+					bit <<= 1;
 					continue;
 				}
 			}
 
 			printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
 								  bf + printed, size - printed, &arg, val);
+			++arg.idx;
+			bit <<= 1;
 		}
 	} else if (IS_ERR(sc->tp_format)) {
 		/*
@@ -2946,7 +2992,9 @@ static int trace__fprintf_sample(struct trace *trace, struct perf_sample *sample
 	return printed;
 }
 
-static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sample, int *augmented_args_size, int raw_augmented_args_size)
+static void *syscall__augmented_args(struct trace *trace, struct syscall *sc,
+				     struct perf_sample *sample,
+				     int *augmented_args_size, int raw_augmented_args_size)
 {
 	/*
 	 * For now with BPF raw_augmented we hook into raw_syscalls:sys_enter
@@ -2964,6 +3012,24 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
 	 */
 	int args_size = raw_augmented_args_size ?: sc->args_size;
 
+	/*
+	 * Augmented arguments are a perf trace specific payload, they are only
+	 * ever appended to samples emitted by the BPF __augmented_syscalls__
+	 * bpf-output event.
+	 *
+	 * Native syscalls:sys_enter_NAME tracepoints may also carry trailing
+	 * data of their own: since Linux 6.19 they append __data_loc char[]
+	 * fields plus the string payloads they point at. Those bytes are not a
+	 * struct augmented_arg, so treating them as one would make
+	 * syscall_arg__scnprintf_augmented_string() read a bogus length and
+	 * walk arg->augmented.args far out of bounds.
+	 *
+	 * So only look for augmented arguments on the event that can actually
+	 * produce them.
+	 */
+	if (sample->evsel != trace->syscalls.events.bpf_output)
+		return NULL;
+
 	*augmented_args_size = sample->raw_size - args_size;
 	if (*augmented_args_size > 0) {
 		static uintptr_t argbuf[1024]; /* assuming single-threaded */
@@ -3022,17 +3088,13 @@ static int trace__sys_enter(struct trace *trace,
 	if (!(trace->duration_filter || trace->summary_only || trace->min_stack))
 		trace__printf_interrupted_entry(trace);
 	/*
-	 * If this is raw_syscalls.sys_enter, then it always comes with the 6 possible
-	 * arguments, even if the syscall being handled, say "openat", uses only 4 arguments
-	 * this breaks syscall__augmented_args() check for augmented args, as we calculate
-	 * syscall->args_size using each syscalls:sys_enter_NAME tracefs format file,
-	 * so when handling, say the openat syscall, we end up getting 6 args for the
-	 * raw_syscalls:sys_enter event, when we expected just 4, we end up mistakenly
-	 * thinking that the extra 2 u64 args are the augmented filename, so just check
-	 * here and avoid using augmented syscalls when the evsel is the raw_syscalls one.
+	 * syscall__augmented_args() only returns a payload for the BPF
+	 * __augmented_syscalls__ event, so raw_syscalls:sys_enter (which always
+	 * carries all 6 possible arguments rather than sc->args_size worth) and
+	 * the native syscalls:sys_enter_NAME tracepoints are both handled there.
 	 */
-	if (evsel != trace->syscalls.events.sys_enter)
-		augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
+	augmented_args = syscall__augmented_args(trace, sc, sample, &augmented_args_size,
+						 trace->raw_augmented_syscalls_args_size);
 	ttrace->entry_time = sample->time;
 	ttrace->entry_cpu = sample->cpu;
 	msg = ttrace->entry_str;
@@ -3077,7 +3139,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct perf_sample *sam
 	struct syscall *sc;
 	char msg[1024];
 	void *args, *augmented_args = NULL;
-	int augmented_args_size, e_machine;
+	int augmented_args_size = 0, e_machine;
 	size_t printed = 0;
 
 
@@ -3095,7 +3157,8 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct perf_sample *sam
 		goto out_put;
 
 	args = perf_evsel__sc_tp_ptr(args, sample);
-	augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
+	augmented_args = syscall__augmented_args(trace, sc, sample, &augmented_args_size,
+						 trace->raw_augmented_syscalls_args_size);
 	printed += syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
 	fprintf(trace->output, "%.*s", (int)printed, msg);
 	err = 0;
@@ -4127,10 +4190,16 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
 	if (trace->btf == NULL)
 		return -1;
 
-	for (i = 0, field = sc->args; field; ++i, field = field->next) {
+	for (i = 0, field = sc->args; field; field = field->next) {
+		/* Skip internal fields to keep beauty array index aligned with syscall arguments */
+		if (is_internal_field(field))
+			continue;
+
 		// XXX We're only collecting pointer payloads _from_ user space
-		if (!sc->arg_fmt[i].from_user)
+		if (!sc->arg_fmt[i].from_user) {
+			++i;
 			continue;
+		}
 
 		struct_offset = strstr(field->type, "struct ");
 		if (struct_offset == NULL)
@@ -4149,8 +4218,10 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
 			name[cnt] = '\0';
 
 			/* cache struct's btf_type and type_id */
-			if (syscall_arg_fmt__cache_btf_struct(&sc->arg_fmt[i], trace->btf, name))
+			if (syscall_arg_fmt__cache_btf_struct(&sc->arg_fmt[i], trace->btf, name)) {
+				++i;
 				continue;
+			}
 
 			bt = sc->arg_fmt[i].type;
 			beauty_array[i] = bt->size;
@@ -4176,7 +4247,9 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
 			struct tep_format_field *field_tmp;
 
 			/* find the size of the buffer that appears in pairs with buf */
-			for (j = 0, field_tmp = sc->args; field_tmp; ++j, field_tmp = field_tmp->next) {
+			for (j = 0, field_tmp = sc->args; field_tmp; field_tmp = field_tmp->next) {
+				if (is_internal_field(field_tmp))
+					continue;
 				if (!(field_tmp->flags & TEP_FIELD_IS_POINTER) && /* only integers */
 				    (strstr(field_tmp->name, "count") ||
 				     strstr(field_tmp->name, "siz") ||  /* size, bufsiz */
@@ -4186,8 +4259,10 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
 					can_augment = true;
 					break;
 				}
+				++j;
 			}
 		}
+		++i;
 	}
 
 	if (can_augment)
@@ -4196,6 +4271,19 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
 	return -1;
 }
 
+/*
+ * Advance to the first field that is a real syscall argument, so that callers
+ * walking two argument lists in step never have to reason about internal
+ * fields appearing in one list but not the other.
+ */
+static struct tep_format_field *next_user_arg(struct tep_format_field *field)
+{
+	while (field && is_internal_field(field))
+		field = field->next;
+
+	return field;
+}
+
 static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace,
 							     struct syscall *sc)
 {
@@ -4203,7 +4291,7 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
 	/*
 	 * We're only interested in syscalls that have a pointer:
 	 */
-	for (field = sc->args; field; field = field->next) {
+	for (field = next_user_arg(sc->args); field; field = next_user_arg(field->next)) {
 		if (field->flags & TEP_FIELD_IS_POINTER)
 			goto try_to_find_pair;
 	}
@@ -4221,21 +4309,31 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
 		    pair->bpf_prog.sys_enter == unaugmented_prog)
 			continue;
 
-		for (field = sc->args, candidate_field = pair->args;
-		     field && candidate_field; field = field->next, candidate_field = candidate_field->next) {
+		/*
+		 * Both cursors only ever point at real arguments, so the loop
+		 * ends when one of the two syscalls runs out of them, rather
+		 * than when one happens to have trailing internal fields.
+		 */
+		field = next_user_arg(sc->args);
+		candidate_field = next_user_arg(pair->args);
+		while (field && candidate_field) {
 			bool is_pointer = field->flags & TEP_FIELD_IS_POINTER,
 			     candidate_is_pointer = candidate_field->flags & TEP_FIELD_IS_POINTER;
 
 			if (is_pointer) {
-			       if (!candidate_is_pointer) {
+				if (!candidate_is_pointer) {
 					// The candidate just doesn't copies our pointer arg, might copy other pointers we want.
+					field = next_user_arg(field->next);
+					candidate_field = next_user_arg(candidate_field->next);
 					continue;
-			       }
+				}
 			} else {
 				if (candidate_is_pointer) {
 					// The candidate might copy a pointer we don't have, skip it.
 					goto next_candidate;
 				}
+				field = next_user_arg(field->next);
+				candidate_field = next_user_arg(candidate_field->next);
 				continue;
 			}
 
@@ -4256,6 +4354,8 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
 				goto next_candidate;
 
 			is_candidate = true;
+			field = next_user_arg(field->next);
+			candidate_field = next_user_arg(candidate_field->next);
 		}
 
 		if (!is_candidate)
@@ -4267,7 +4367,9 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
 		 * more than what is common to the two syscalls.
 		 */
 		if (candidate_field) {
-			for (candidate_field = candidate_field->next; candidate_field; candidate_field = candidate_field->next)
+			candidate_field = next_user_arg(candidate_field->next);
+			for (; candidate_field;
+			     candidate_field = next_user_arg(candidate_field->next))
 				if (candidate_field->flags & TEP_FIELD_IS_POINTER)
 					goto next_candidate;
 		}
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

