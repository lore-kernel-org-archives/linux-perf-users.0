Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07D83D5225
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916664; cv=none; b=ZYod+tLg6SxTY/Gl/A9ELwCmtxr/sHoOCe865PROOcnwh4FBfidiQUw8BavXjVrAP0bqnqVCN+OSzCrmpGJKFBmuBYuG3edDtH22DKogpXMZ1Gxhb8swaztsZ4aBT6ewpsX09R9nPcajiOXiQhaA5Bg9Kdqky5YI4z3v61Gc4t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916664; c=relaxed/simple;
	bh=ped4oeUx8WgaZrq0OJqveDNMfVIsOIFMzCbdMxiNJGc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FLpoqNs9gXCoMp5RdihVm3VxuXP5c4q9Seg0XbVSmMtCyLRu4YMmAa9qEK41mjoD1krD+qOOcudP2CW8iOJFgOn7V0IftZ8PWtAGo+BoQvzdq8BIsgo0qmX32Iy3JInoCUtsYDvmd4SkMnJDFhkox4fARLo/9PFjBNy6s2G3oxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ha9A8lVK; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ha9A8lVK"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c35f2c09dso7470312c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916661; x=1777521461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AwhzWjeAfY7iRZoKXm8kUKtx9dtFGM1SO+wyXvhJAN4=;
        b=ha9A8lVKB2QJK/RF0JMigd9fUoyi7fgxuCs4ych4SX/NDVlNYWzH6B8JH6cEsgoLtx
         DxChcEa9GazJV18OETGIED1ooO00HoL3GNh780JNQTU9Eyo7yXL0d/gQkKNB1q7LFgug
         Q7sNwjOhVHiV0PMLoS1sViCvIhmJZEoisHeKx0EyloE37LLWska9zJoDkkzYTfysMtxC
         vN4kMdu0txU7JXT+uB9NufBHe+KO0yHo5YlHxbDi6vIq2Mg+s4+jb9zxDRTPbd1gv71Y
         Iukqhnt+R9bvAeGc3fFw2Hh4aX1QiXA/xJ+Szm+QYwPrvIEIOVaW6Mdm2YqItSIzw2SO
         LWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916661; x=1777521461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwhzWjeAfY7iRZoKXm8kUKtx9dtFGM1SO+wyXvhJAN4=;
        b=Czv5jFYdSx9MdiaHjgOo5aYOu2SBBSOBF3LwDDPm6JL6lpSNZ4WoSwYm6J9NySfJTR
         lCbKwdFPtBzjhJF+VYMip83YhvBdrVgs4RxESE9ZSAujiIxigrvSUEgRyyMlze+IOon3
         HtTR5Xjl6M/T1uE4jb/c7/np8qiB07r1NPe/1gkxYgV/v47Da4roiRP5yT570cwyrDeN
         +8nXf0xMUZLxPMysYRVF1/OgVDHkIMQvpzzsJkdV12Ml3HRjOc6MrISZarI++Lh1FHCJ
         J5RJy1nhWEJ5io5571lS881tOQb7dNJeckxaIoRp9CfxNPiSRHgy55xAcWGh6+t8hYbi
         Y8jQ==
X-Forwarded-Encrypted: i=1; AFNElJ8HeHXEd/3JixikHngpDUXobGp/onBlS73LLLty2SQYWovynxplSMaBndDcviaD4H4DDXfacK6TmjAwFZzXovAZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyD44g4aNpK0Ybg9bMA1pTKm5MUCy4OY3hO1cR1N/eVrJv3Zgg1
	+6qeHQDa6Ld7zK30iV6UdVUG3KV3Fft2V3KSOqODeO/sRf9f8Hy64t/ilh6PAmOdWhGygUZuAVk
	AQg0yLpKIqQ==
X-Received: from dlbui16.prod.google.com ([2002:a05:7022:3d10:b0:12d:b27b:7405])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6884:b0:11b:9b98:aa4b
 with SMTP id a92af1059eb24-12c73f6443dmr13587783c88.6.1776916660714; Wed, 22
 Apr 2026 20:57:40 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:55:23 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-57-irogers@google.com>
Subject: [PATCH v2 56/58] perf script: Refactor to support standalone scripts
 and remove legacy features
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
Content-Type: text/plain; charset="UTF-8"

- Remove -g / --gen-script option as it is no longer needed.
- Hide -s / --script option to imply running standalone scripts
  directly.
- Update find_script to search in 'python' instead of
  'scripts/python'.
- Add support for launching standalone scripts using fork and execvp,
  skipping the event processing loop.
- Update list_available_scripts to look for .py files directly in
  'python' directory.
- Remove all references to scripting_ops and clean up unused functions
  and variables.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

 - Fixed strncat buffer overflow: Updated the strncat call in
   find_script() to correctly use the remaining capacity of the
   destination buffer instead of sizeof(path) - 1 . The declaration of
   len was moved to the top of the function to conform to C style
   guidelines.

 - Fixed execvp path searching: If find_script() finds a local file in
   the current directory without a slash, it now prepends ./ to it.
   This ensures that execvp() executed by the child process knows to
   look in the current directory rather than searching the system
   $PATH .

 - Fixed premature loop termination in docstring parsing: Removed a
   check in read_script_info() that caused the loop to terminate early
   if any fallback description was found (like an SPDX
   identifier). This restores the intended behavior of searching the
   entire header for a better "description:" tag.

 - Updated subcommands and usage: Removed "record" and "report" from
   the usage text and stopped passing them as valid subcommands to
   parse_options_subcommand() .

 - Fixed lost command-line options: Reconstructed the arguments passed
   to the standalone script to include -i and the input file path,
   ensuring that the user's choice of input file is not lost.

 - Added error message on execvp failure: Added a pr_err call in the
   child process to print a descriptive error message if execvp()
   fails to launch the script.

 - Fixed uninitialized status in waitpid : Initialized status to 0 and
   verified that waitpid() successfully returned the child's PID
   before evaluating its exit status. Also removed unnecessary braces
   and fixed indentation in that block.
---
 tools/perf/builtin-script.c             | 767 +++++++++---------------
 tools/perf/util/Build                   |   1 -
 tools/perf/util/scripting-engines/Build |   1 -
 tools/perf/util/trace-event-parse.c     |  65 --
 tools/perf/util/trace-event-scripting.c | 333 ----------
 tools/perf/util/trace-event.h           |  75 +--
 6 files changed, 294 insertions(+), 948 deletions(-)
 delete mode 100644 tools/perf/util/scripting-engines/Build
 delete mode 100644 tools/perf/util/trace-event-scripting.c

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c0949556d1bb..9b672edac2ca 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -18,6 +18,7 @@
 #include <sys/param.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <sys/wait.h>
 #include <sys/utsname.h>
 #include <unistd.h>
 
@@ -77,7 +78,6 @@
 #endif
 
 static char const		*script_name;
-static char const		*generate_script_lang;
 static bool			reltime;
 static bool			deltatime;
 static u64			initial_time;
@@ -95,6 +95,7 @@ static int			max_blocks;
 static struct dlfilter		*dlfilter;
 static int			dlargc;
 static char			**dlargv;
+static unsigned int		scripting_max_stack = PERF_MAX_STACK_DEPTH;
 
 enum perf_output_field {
 	PERF_OUTPUT_COMM            = 1ULL << 0,
@@ -1730,6 +1731,143 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
 	return printed;
 }
 
+#define SAMPLE_FLAGS_BUF_SIZE 64
+#define SAMPLE_FLAGS_STR_ALIGNED_SIZE	21
+
+static int sample_flags_to_name(u32 flags, char *str, size_t size)
+{
+	static const struct {
+		u32 flags;
+		const char *name;
+	} sample_flags[] = {
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL, "call"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN, "return"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CONDITIONAL, "jcc"},
+		{PERF_IP_FLAG_BRANCH, "jmp"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_INTERRUPT, "int"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN | PERF_IP_FLAG_INTERRUPT, "iret"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_SYSCALLRET, "syscall"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN | PERF_IP_FLAG_SYSCALLRET, "sysret"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_ASYNC, "async"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_ASYNC |	PERF_IP_FLAG_INTERRUPT,
+		 "hw int"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TX_ABORT, "tx abrt"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_BEGIN, "tr strt"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_END, "tr end"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMENTRY, "vmentry"},
+		{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMEXIT, "vmexit"},
+		{0, NULL}
+	};
+	static const struct {
+		u32 flags;
+		const char *name;
+	} branch_events[] = {
+		{PERF_IP_FLAG_BRANCH_MISS, "miss"},
+		{PERF_IP_FLAG_NOT_TAKEN, "not_taken"},
+		{0, NULL}
+	};
+	int i;
+	const char *prefix;
+	int pos = 0, ret, ev_idx = 0;
+	u32 xf = flags & PERF_ADDITIONAL_STATE_MASK;
+	u32 types, events;
+	char xs[16] = { 0 };
+
+	/* Clear additional state bits */
+	flags &= ~PERF_ADDITIONAL_STATE_MASK;
+
+	if (flags & PERF_IP_FLAG_TRACE_BEGIN)
+		prefix = "tr strt ";
+	else if (flags & PERF_IP_FLAG_TRACE_END)
+		prefix = "tr end  ";
+	else
+		prefix = "";
+
+	ret = snprintf(str + pos, size - pos, "%s", prefix);
+	if (ret < 0)
+		return ret;
+	pos += ret;
+
+	flags &= ~(PERF_IP_FLAG_TRACE_BEGIN | PERF_IP_FLAG_TRACE_END);
+
+	types = flags & ~PERF_IP_FLAG_BRANCH_EVENT_MASK;
+	for (i = 0; sample_flags[i].name; i++) {
+		if (sample_flags[i].flags != types)
+			continue;
+
+		ret = snprintf(str + pos, size - pos, "%s", sample_flags[i].name);
+		if (ret < 0)
+			return ret;
+		pos += ret;
+		break;
+	}
+
+	events = flags & PERF_IP_FLAG_BRANCH_EVENT_MASK;
+	for (i = 0; branch_events[i].name; i++) {
+		if (!(branch_events[i].flags & events))
+			continue;
+
+		ret = snprintf(str + pos, size - pos, !ev_idx ? "/%s" : ",%s",
+			       branch_events[i].name);
+		if (ret < 0)
+			return ret;
+		pos += ret;
+		ev_idx++;
+	}
+
+	/* Add an end character '/' for events */
+	if (ev_idx) {
+		ret = snprintf(str + pos, size - pos, "/");
+		if (ret < 0)
+			return ret;
+		pos += ret;
+	}
+
+	if (!xf)
+		return pos;
+
+	snprintf(xs, sizeof(xs), "(%s%s%s)",
+		 flags & PERF_IP_FLAG_IN_TX ? "x" : "",
+		 flags & PERF_IP_FLAG_INTR_DISABLE ? "D" : "",
+		 flags & PERF_IP_FLAG_INTR_TOGGLE ? "t" : "");
+
+	/* Right align the string if its length is less than the limit */
+	if ((pos + strlen(xs)) < SAMPLE_FLAGS_STR_ALIGNED_SIZE)
+		ret = snprintf(str + pos, size - pos, "%*s",
+			       (int)(SAMPLE_FLAGS_STR_ALIGNED_SIZE - ret), xs);
+	else
+		ret = snprintf(str + pos, size - pos, " %s", xs);
+	if (ret < 0)
+		return ret;
+
+	return pos + ret;
+}
+
+static int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz)
+{
+	const char *chars = PERF_IP_FLAG_CHARS;
+	const size_t n = strlen(PERF_IP_FLAG_CHARS);
+	size_t i, pos = 0;
+	int ret;
+
+	ret = sample_flags_to_name(flags, str, sz);
+	if (ret > 0)
+		return ret;
+
+	for (i = 0; i < n; i++, flags >>= 1) {
+		if ((flags & 1) && pos < sz)
+			str[pos++] = chars[i];
+	}
+	for (; i < 32; i++, flags >>= 1) {
+		if ((flags & 1) && pos < sz)
+			str[pos++] = '?';
+	}
+	if (pos < sz)
+		str[pos] = 0;
+
+	return pos;
+}
+
 static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
 {
 	char str[SAMPLE_FLAGS_BUF_SIZE];
@@ -2571,8 +2709,6 @@ static void process_event(struct perf_script *script,
 		fflush(fp);
 }
 
-static struct scripting_ops	*scripting_ops;
-
 static void __process_stat(struct evsel *counter, u64 tstamp)
 {
 	int nthreads = perf_thread_map__nr(counter->core.threads);
@@ -2607,35 +2743,14 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
 
 static void process_stat(struct evsel *counter, u64 tstamp)
 {
-	if (scripting_ops && scripting_ops->process_stat)
-		scripting_ops->process_stat(&stat_config, counter, tstamp);
-	else
-		__process_stat(counter, tstamp);
+	__process_stat(counter, tstamp);
 }
 
-static void process_stat_interval(u64 tstamp)
+static void process_stat_interval(u64 tstamp __maybe_unused)
 {
-	if (scripting_ops && scripting_ops->process_stat_interval)
-		scripting_ops->process_stat_interval(tstamp);
 }
 
-static void setup_scripting(void)
-{
 
-	setup_python_scripting();
-}
-
-static int flush_scripting(void)
-{
-	return scripting_ops ? scripting_ops->flush_script() : 0;
-}
-
-static int cleanup_scripting(void)
-{
-	pr_debug("\nperf script stopped\n");
-
-	return scripting_ops ? scripting_ops->stop_script() : 0;
-}
 
 static bool filter_cpu(struct perf_sample *sample)
 {
@@ -2708,19 +2823,7 @@ static int process_sample_event(const struct perf_tool *tool,
 		goto out_put;
 	}
 
-	if (scripting_ops) {
-		struct addr_location *addr_al_ptr = NULL;
-
-		if ((evsel->core.attr.sample_type & PERF_SAMPLE_ADDR) &&
-		    sample_addr_correlates_sym(&evsel->core.attr)) {
-			if (!addr_al.thread)
-				thread__resolve(al.thread, &addr_al, sample);
-			addr_al_ptr = &addr_al;
-		}
-		scripting_ops->process_event(event, sample, evsel, &al, addr_al_ptr);
-	} else {
-		process_event(scr, sample, evsel, &al, &addr_al, machine);
-	}
+	process_event(scr, sample, evsel, &al, &addr_al, machine);
 
 out_put:
 	addr_location__exit(&addr_al);
@@ -3029,8 +3132,7 @@ static int process_switch_event(const struct perf_tool *tool,
 	if (perf_event__process_switch(tool, event, sample, machine) < 0)
 		return -1;
 
-	if (scripting_ops && scripting_ops->process_switch && !filter_cpu(sample))
-		scripting_ops->process_switch(event, sample, machine);
+
 
 	if (!script->show_switch_events)
 		return 0;
@@ -3039,17 +3141,7 @@ static int process_switch_event(const struct perf_tool *tool,
 			   sample->tid);
 }
 
-static int process_auxtrace_error(const struct perf_tool *tool,
-				  struct perf_session *session,
-				  union perf_event *event)
-{
-	if (scripting_ops && scripting_ops->process_auxtrace_error) {
-		scripting_ops->process_auxtrace_error(session, event);
-		return 0;
-	}
 
-	return perf_event__process_auxtrace_error(tool, session, event);
-}
 
 static int
 process_lost_event(const struct perf_tool *tool,
@@ -3063,12 +3155,11 @@ process_lost_event(const struct perf_tool *tool,
 
 static int
 process_throttle_event(const struct perf_tool *tool __maybe_unused,
-		       union perf_event *event,
-		       struct perf_sample *sample,
-		       struct machine *machine)
+		       union perf_event *event __maybe_unused,
+		       struct perf_sample *sample __maybe_unused,
+		       struct machine *machine __maybe_unused)
 {
-	if (scripting_ops && scripting_ops->process_throttle)
-		scripting_ops->process_throttle(event, sample, machine);
+
 	return 0;
 }
 
@@ -3211,10 +3302,9 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.mmap = process_mmap_event;
 		script->tool.mmap2 = process_mmap2_event;
 	}
-	if (script->show_switch_events || (scripting_ops && scripting_ops->process_switch))
+	if (script->show_switch_events)
 		script->tool.context_switch = process_switch_event;
-	if (scripting_ops && scripting_ops->process_auxtrace_error)
-		script->tool.auxtrace_error = process_auxtrace_error;
+	script->tool.auxtrace_error = perf_event__process_auxtrace_error;
 	if (script->show_namespace_events)
 		script->tool.namespaces = process_namespaces_event;
 	if (script->show_cgroup_events)
@@ -3251,96 +3341,55 @@ static int __cmd_script(struct perf_script *script)
 	return ret;
 }
 
-static int list_available_languages_cb(struct scripting_ops *ops, const char *spec)
-{
-	fprintf(stderr, "  %-42s [%s]\n", spec, ops->name);
-	return 0;
-}
 
-static void list_available_languages(void)
-{
-	fprintf(stderr, "\n");
-	fprintf(stderr, "Scripting language extensions (used in "
-		"perf script -s [spec:]script.[spec]):\n\n");
-	script_spec__for_each(&list_available_languages_cb);
-	fprintf(stderr, "\n");
-}
 
 /* Find script file relative to current directory or exec path */
 static char *find_script(const char *script)
 {
 	char path[PATH_MAX];
+	char *exec_path;
+	size_t len;
 
-	if (!scripting_ops) {
-		const char *ext = strrchr(script, '.');
+	if (access(script, R_OK) == 0) {
+		if (!strchr(script, '/')) {
+			snprintf(path, sizeof(path), "./%s", script);
+			script = path;
+		}
+		goto found;
+	}
 
-		if (!ext)
-			return NULL;
+	exec_path = get_argv_exec_path();
+	if (!exec_path)
+		return NULL;
 
-		scripting_ops = script_spec__lookup(++ext);
-		if (!scripting_ops)
-			return NULL;
-	}
+	snprintf(path, sizeof(path), "%s/python/%s", exec_path, script);
+	free(exec_path);
+	script = path;
 
-	if (access(script, R_OK)) {
-		char *exec_path = get_argv_exec_path();
+	if (access(path, R_OK) == 0)
+		goto found;
 
-		if (!exec_path)
-			return NULL;
-		snprintf(path, sizeof(path), "%s/scripts/%s/%s",
-			 exec_path, scripting_ops->dirname, script);
-		free(exec_path);
-		script = path;
-		if (access(script, R_OK))
-			return NULL;
-	}
+	/* Try with .py suffix. */
+	len = strlen(path);
+
+	strncat(path, ".py", sizeof(path) - len - 1);
+
+	if (access(script, R_OK) == 0)
+		goto found;
+
+	/* Failure to find script. */
+	return NULL;
+
+found:
 	return strdup(script);
 }
 
 static int parse_scriptname(const struct option *opt __maybe_unused,
 			    const char *str, int unset __maybe_unused)
 {
-	char spec[PATH_MAX];
-	const char *script, *ext;
-	int len;
-
-	if (strcmp(str, "lang") == 0) {
-		list_available_languages();
-		exit(0);
-	}
-
-	script = strchr(str, ':');
-	if (script) {
-		len = script - str;
-		if (len >= PATH_MAX) {
-			fprintf(stderr, "invalid language specifier");
-			return -1;
-		}
-		strncpy(spec, str, len);
-		spec[len] = '\0';
-		scripting_ops = script_spec__lookup(spec);
-		if (!scripting_ops) {
-			fprintf(stderr, "invalid language specifier");
-			return -1;
-		}
-		script++;
-	} else {
-		script = str;
-		ext = strrchr(script, '.');
-		if (!ext) {
-			fprintf(stderr, "invalid script extension");
-			return -1;
-		}
-		scripting_ops = script_spec__lookup(++ext);
-		if (!scripting_ops) {
-			fprintf(stderr, "invalid script extension");
-			return -1;
-		}
-	}
-
-	script_name = find_script(script);
+	script_name = find_script(str);
 	if (!script_name)
-		script_name = strdup(script);
+		script_name = strdup(str);
 
 	return 0;
 }
@@ -3551,16 +3600,18 @@ static struct script_desc *script_desc__new(const char *name)
 	return s;
 }
 
-static void script_desc__delete(struct script_desc *s)
-{
-	zfree(&s->name);
-	zfree(&s->half_liner);
-	zfree(&s->args);
-	free(s);
-}
+
 
 static void script_desc__add(struct script_desc *s)
 {
+	struct script_desc *pos;
+
+	list_for_each_entry(pos, &script_descs, node) {
+		if (strcasecmp(s->name, pos->name) < 0) {
+			list_add_tail(&s->node, &pos->node);
+			return;
+		}
+	}
 	list_add_tail(&s->node, &script_descs);
 }
 
@@ -3608,15 +3659,57 @@ static int read_script_info(struct script_desc *desc, const char *filename)
 {
 	char line[BUFSIZ], *p;
 	FILE *fp;
+	bool in_docstring = false;
+	bool found_description = false;
 
 	fp = fopen(filename, "r");
 	if (!fp)
 		return -1;
 
 	while (fgets(line, sizeof(line), fp)) {
+		static const char * const triple_quote_str[] = {
+			"\"\"\"",
+			"'''",
+			"r\"\"\"",
+		};
 		p = skip_spaces(line);
 		if (strlen(p) == 0)
 			continue;
+
+		if (in_docstring) {
+			if (strlen(p) && p[strlen(p) - 1] == '\n')
+				p[strlen(p) - 1] = '\0';
+			desc->half_liner = strdup(skip_spaces(p));
+			in_docstring = false;
+			found_description = true;
+			break;
+		}
+
+
+		for (size_t i = 0; i < ARRAY_SIZE(triple_quote_str); i++) {
+			const char *quote = triple_quote_str[i];
+
+			if (!strstarts(p, quote))
+				continue;
+
+			p += strlen(quote);
+			p = skip_spaces(p);
+			if (strlen(p) > 0) {
+				if (p[strlen(p) - 1] == '\n')
+					p[strlen(p) - 1] = '\0';
+				p = skip_spaces(p);
+				if (str_ends_with(p, quote))
+					p[strlen(p) - strlen(quote)] = '\0';
+				desc->half_liner = strdup(skip_spaces(p));
+				found_description = true;
+				break;
+			}
+			in_docstring = true;
+			break;
+		}
+		if (in_docstring)
+			continue;
+
 		if (*p != '#')
 			continue;
 		p++;
@@ -3630,13 +3723,15 @@ static int read_script_info(struct script_desc *desc, const char *filename)
 		if (!strncmp(p, "description:", strlen("description:"))) {
 			p += strlen("description:");
 			desc->half_liner = strdup(skip_spaces(p));
-			continue;
+			found_description = true;
+			break;
 		}
 
-		if (!strncmp(p, "args:", strlen("args:"))) {
-			p += strlen("args:");
-			desc->args = strdup(skip_spaces(p));
-			continue;
+		if (!found_description && strlen(p) > 0 &&
+		    strncmp(p, "SPDX-License-Identifier", 23)) {
+			desc->half_liner = strdup(p);
+			found_description = true;
+			// Don't break, maybe we find a better "description:" later!
 		}
 	}
 
@@ -3667,9 +3762,9 @@ static int list_available_scripts(const struct option *opt __maybe_unused,
 				  const char *s __maybe_unused,
 				  int unset __maybe_unused)
 {
-	struct dirent *script_dirent, *lang_dirent;
-	char *buf, *scripts_path, *script_path, *lang_path, *first_half;
-	DIR *scripts_dir, *lang_dir;
+	struct dirent *script_dirent;
+	char *buf, *scripts_path, *script_path, *first_half;
+	DIR *scripts_dir;
 	struct script_desc *desc;
 	char *script_root;
 
@@ -3680,10 +3775,9 @@ static int list_available_scripts(const struct option *opt __maybe_unused,
 	}
 	scripts_path = buf;
 	script_path = buf + MAXPATHLEN;
-	lang_path = buf + 2 * MAXPATHLEN;
 	first_half = buf + 3 * MAXPATHLEN;
 
-	snprintf(scripts_path, MAXPATHLEN, "%s/scripts", get_argv_exec_path());
+	snprintf(scripts_path, MAXPATHLEN, "%s/python", get_argv_exec_path());
 
 	scripts_dir = opendir(scripts_path);
 	if (!scripts_dir) {
@@ -3695,26 +3789,24 @@ static int list_available_scripts(const struct option *opt __maybe_unused,
 		exit(-1);
 	}
 
-	for_each_lang(scripts_path, scripts_dir, lang_dirent) {
-		scnprintf(lang_path, MAXPATHLEN, "%s/%s/bin", scripts_path,
-			  lang_dirent->d_name);
-		lang_dir = opendir(lang_path);
-		if (!lang_dir)
-			continue;
+	while ((script_dirent = readdir(scripts_dir)) != NULL) {
+		if (script_dirent->d_type != DT_DIR &&
+		    (script_dirent->d_type != DT_UNKNOWN ||
+		     !is_directory(scripts_path, script_dirent))) {
 
-		for_each_script(lang_path, lang_dir, script_dirent) {
-			script_root = get_script_root(script_dirent, REPORT_SUFFIX);
+			script_root = get_script_root(script_dirent, ".py");
 			if (script_root) {
 				desc = script_desc__findnew(script_root);
 				scnprintf(script_path, MAXPATHLEN, "%s/%s",
-					  lang_path, script_dirent->d_name);
+					  scripts_path, script_dirent->d_name);
 				read_script_info(desc, script_path);
 				free(script_root);
 			}
 		}
 	}
+	closedir(scripts_dir);
 
-	fprintf(stdout, "List of available trace scripts:\n");
+	fprintf(stdout, "List of available scripts:\n");
 	list_for_each_entry(desc, &script_descs, node) {
 		sprintf(first_half, "%s %s", desc->name,
 			desc->args ? desc->args : "");
@@ -3754,93 +3846,7 @@ static void free_dlarg(void)
 	free(dlargv);
 }
 
-static char *get_script_path(const char *script_root, const char *suffix)
-{
-	struct dirent *script_dirent, *lang_dirent;
-	char scripts_path[MAXPATHLEN];
-	char script_path[MAXPATHLEN];
-	DIR *scripts_dir, *lang_dir;
-	char lang_path[MAXPATHLEN];
-	char *__script_root;
-
-	snprintf(scripts_path, MAXPATHLEN, "%s/scripts", get_argv_exec_path());
-
-	scripts_dir = opendir(scripts_path);
-	if (!scripts_dir)
-		return NULL;
-
-	for_each_lang(scripts_path, scripts_dir, lang_dirent) {
-		scnprintf(lang_path, MAXPATHLEN, "%s/%s/bin", scripts_path,
-			  lang_dirent->d_name);
-		lang_dir = opendir(lang_path);
-		if (!lang_dir)
-			continue;
-
-		for_each_script(lang_path, lang_dir, script_dirent) {
-			__script_root = get_script_root(script_dirent, suffix);
-			if (__script_root && !strcmp(script_root, __script_root)) {
-				free(__script_root);
-				closedir(scripts_dir);
-				scnprintf(script_path, MAXPATHLEN, "%s/%s",
-					  lang_path, script_dirent->d_name);
-				closedir(lang_dir);
-				return strdup(script_path);
-			}
-			free(__script_root);
-		}
-		closedir(lang_dir);
-	}
-	closedir(scripts_dir);
-
-	return NULL;
-}
-
-static bool is_top_script(const char *script_path)
-{
-	return ends_with(script_path, "top") != NULL;
-}
-
-static int has_required_arg(char *script_path)
-{
-	struct script_desc *desc;
-	int n_args = 0;
-	char *p;
-
-	desc = script_desc__new(NULL);
-
-	if (read_script_info(desc, script_path))
-		goto out;
-
-	if (!desc->args)
-		goto out;
-
-	for (p = desc->args; *p; p++)
-		if (*p == '<')
-			n_args++;
-out:
-	script_desc__delete(desc);
-
-	return n_args;
-}
-
-static int have_cmd(int argc, const char **argv)
-{
-	char **__argv = calloc(argc, sizeof(const char *));
 
-	if (!__argv) {
-		pr_err("malloc failed\n");
-		return -1;
-	}
-
-	memcpy(__argv, argv, sizeof(const char *) * argc);
-	argc = parse_options(argc, (const char **)__argv, record_options,
-			     NULL, PARSE_OPT_STOP_AT_NON_OPTION);
-	free(__argv);
-
-	system_wide = (argc == 0);
-
-	return 0;
-}
 
 static void script__setup_sample_type(struct perf_script *script)
 {
@@ -4026,17 +4032,13 @@ int cmd_script(int argc, const char **argv)
 	bool show_full_info = false;
 	bool header = false;
 	bool header_only = false;
-	bool script_started = false;
 	bool unsorted_dump = false;
 	bool merge_deferred_callchains = true;
-	char *rec_script_path = NULL;
-	char *rep_script_path = NULL;
 	struct perf_session *session;
 	struct itrace_synth_opts itrace_synth_opts = {
 		.set = false,
 		.default_no_sample = true,
 	};
-	char *script_path = NULL;
 	const char *dlfilter_file = NULL;
 	const char **__argv;
 	int i, j, err = 0;
@@ -4057,11 +4059,10 @@ int cmd_script(int argc, const char **argv)
 			   list_available_scripts),
 	OPT_CALLBACK_NOOPT(0, "list-dlfilters", NULL, NULL, "list available dlfilters",
 			   list_available_dlfilters),
-	OPT_CALLBACK('s', "script", NULL, "name",
-		     "script file name (lang:script name, script name, or *)",
-		     parse_scriptname),
-	OPT_STRING('g', "gen-script", &generate_script_lang, "lang",
-		   "generate perf-script.xx script in specified language"),
+	{ .type = OPTION_CALLBACK, .short_name = 's', .long_name = "script",
+	  .value = NULL, .argh = "name",
+	  .help = "script file name (lang:script name, script name, or *)",
+	  .callback = parse_scriptname, .flags = PARSE_OPT_HIDDEN },
 	OPT_STRING(0, "dlfilter", &dlfilter_file, "file", "filter .so file name"),
 	OPT_CALLBACK(0, "dlarg", NULL, "argument", "filter argument",
 		     add_dlarg),
@@ -4185,22 +4186,17 @@ int cmd_script(int argc, const char **argv)
 	OPTS_EVSWITCH(&script.evswitch),
 	OPT_END()
 	};
-	const char * const script_subcommands[] = { "record", "report", NULL };
 	const char *script_usage[] = {
 		"perf script [<options>]",
-		"perf script [<options>] record <script> [<record-options>] <command>",
-		"perf script [<options>] report <script> [script-args]",
-		"perf script [<options>] <script> [<record-options>] <command>",
-		"perf script [<options>] <top-script> [script-args]",
+		"perf script [<options>] <script> [script-args]",
 		NULL
 	};
 	struct perf_env *env;
 
 	perf_set_singlethreaded();
 
-	setup_scripting();
 
-	argc = parse_options_subcommand(argc, argv, options, script_subcommands, script_usage,
+	argc = parse_options_subcommand(argc, argv, options, NULL, script_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (symbol_conf.guestmount ||
@@ -4223,21 +4219,7 @@ int cmd_script(int argc, const char **argv)
 	if (symbol__validate_sym_arguments())
 		return -1;
 
-	if (argc > 1 && strlen(argv[0]) > 2 && strstarts("record", argv[0])) {
-		rec_script_path = get_script_path(argv[1], RECORD_SUFFIX);
-		if (!rec_script_path)
-			return cmd_record(argc, argv);
-	}
 
-	if (argc > 1 && strlen(argv[0]) > 2 && strstarts("report", argv[0])) {
-		rep_script_path = get_script_path(argv[1], REPORT_SUFFIX);
-		if (!rep_script_path) {
-			fprintf(stderr,
-				"Please specify a valid report script"
-				"(see 'perf script -l' for listing)\n");
-			return -1;
-		}
-	}
 
 	if (reltime && deltatime) {
 		fprintf(stderr,
@@ -4253,149 +4235,54 @@ int cmd_script(int argc, const char **argv)
 	/* make sure PERF_EXEC_PATH is set for scripts */
 	set_argv_exec_path(get_argv_exec_path());
 
-	if (argc && !script_name && !rec_script_path && !rep_script_path) {
-		int live_pipe[2];
-		int rep_args;
-		pid_t pid;
-
-		rec_script_path = get_script_path(argv[0], RECORD_SUFFIX);
-		rep_script_path = get_script_path(argv[0], REPORT_SUFFIX);
-
-		if (!rec_script_path && !rep_script_path) {
-			script_name = find_script(argv[0]);
-			if (script_name) {
-				argc -= 1;
-				argv += 1;
-				goto script_found;
-			}
-			usage_with_options_msg(script_usage, options,
-				"Couldn't find script `%s'\n\n See perf"
-				" script -l for available scripts.\n", argv[0]);
-		}
-
-		if (is_top_script(argv[0])) {
-			rep_args = argc - 1;
-		} else {
-			int rec_args;
-
-			rep_args = has_required_arg(rep_script_path);
-			rec_args = (argc - 1) - rep_args;
-			if (rec_args < 0) {
-				usage_with_options_msg(script_usage, options,
-					"`%s' script requires options."
-					"\n\n See perf script -l for available "
-					"scripts and options.\n", argv[0]);
-			}
+	if (argc && !script_name) {
+		script_name = find_script(argv[0]);
+		if (script_name) {
+			argc -= 1;
+			argv += 1;
+			goto script_found;
 		}
+		usage_with_options_msg(script_usage, options,
+			"Couldn't find script `%s'\n\n"
+			" See perf script -l for available scripts.\n", argv[0]);
+	}
+script_found:
 
-		if (pipe(live_pipe) < 0) {
-			perror("failed to create pipe");
-			return -1;
-		}
 
-		pid = fork();
+	if (script_name) {
+		pid_t pid = fork();
 		if (pid < 0) {
-			perror("failed to fork");
-			return -1;
+			pr_err("failed to fork\n");
+			return -errno;
 		}
-
-		if (!pid) {
+		if (pid == 0) { /* child */
+			__argv = calloc(argc + 4, sizeof(const char *));
 			j = 0;
-
-			dup2(live_pipe[1], 1);
-			close(live_pipe[0]);
-
-			if (is_top_script(argv[0])) {
-				system_wide = true;
-			} else if (!system_wide) {
-				if (have_cmd(argc - rep_args, &argv[rep_args]) != 0) {
-					err = -1;
-					goto out;
-				}
-			}
-
-			__argv = calloc(argc + 6, sizeof(const char *));
 			if (!__argv) {
-				pr_err("malloc failed\n");
-				err = -ENOMEM;
-				goto out;
+				exit(-ENOMEM);
 			}
-
-			__argv[j++] = "/bin/sh";
-			__argv[j++] = rec_script_path;
-			if (system_wide)
-				__argv[j++] = "-a";
-			__argv[j++] = "-q";
-			__argv[j++] = "-o";
-			__argv[j++] = "-";
-			for (i = rep_args + 1; i < argc; i++)
+			__argv[j++] = script_name;
+			if (input_name) {
+				__argv[j++] = "-i";
+				__argv[j++] = input_name;
+			}
+			for (i = 0; i < argc; i++)
 				__argv[j++] = argv[i];
 			__argv[j++] = NULL;
 
-			execvp("/bin/sh", (char **)__argv);
-			free(__argv);
-			exit(-1);
-		}
-
-		dup2(live_pipe[0], 0);
-		close(live_pipe[1]);
-
-		__argv = calloc(argc + 4, sizeof(const char *));
-		if (!__argv) {
-			pr_err("malloc failed\n");
-			err = -ENOMEM;
-			goto out;
-		}
-
-		j = 0;
-		__argv[j++] = "/bin/sh";
-		__argv[j++] = rep_script_path;
-		for (i = 1; i < rep_args + 1; i++)
-			__argv[j++] = argv[i];
-		__argv[j++] = "-i";
-		__argv[j++] = "-";
-		__argv[j++] = NULL;
-
-		execvp("/bin/sh", (char **)__argv);
-		free(__argv);
-		exit(-1);
-	}
-script_found:
-	if (rec_script_path)
-		script_path = rec_script_path;
-	if (rep_script_path)
-		script_path = rep_script_path;
-
-	if (script_path) {
-		j = 0;
-
-		if (!rec_script_path)
-			system_wide = false;
-		else if (!system_wide) {
-			if (have_cmd(argc - 1, &argv[1]) != 0) {
-				err = -1;
-				goto out;
+			execvp(script_name, (char **)__argv);
+			pr_err("failed to execute script '%s': %s\n", script_name, strerror(errno));
+			exit(-errno);
+		} else { /* parent */
+			int status = 0;
+
+			if (waitpid(pid, &status, 0) == pid) {
+				if (WIFEXITED(status))
+					return WEXITSTATUS(status);
+				else
+					return -1;
 			}
 		}
-
-		__argv = calloc(argc + 2, sizeof(const char *));
-		if (!__argv) {
-			pr_err("malloc failed\n");
-			err = -ENOMEM;
-			goto out;
-		}
-
-		__argv[j++] = "/bin/sh";
-		__argv[j++] = script_path;
-		if (system_wide)
-			__argv[j++] = "-a";
-		for (i = 2; i < argc; i++)
-			__argv[j++] = argv[i];
-		__argv[j++] = NULL;
-
-		execvp("/bin/sh", (char **)__argv);
-		free(__argv);
-		exit(-1);
 	}
 
 	if (dlfilter_file) {
@@ -4487,77 +4374,12 @@ int cmd_script(int argc, const char **argv)
 		goto out_delete;
 	}
 #endif
-	if (generate_script_lang) {
-		struct stat perf_stat;
-		int input;
-		char *filename = strdup("perf-script");
-
-		if (output_set_by_user()) {
-			fprintf(stderr,
-				"custom fields not supported for generated scripts");
-			err = -EINVAL;
-			goto out_delete;
-		}
-
-		input = open(data.path, O_RDONLY);	/* input_name */
-		if (input < 0) {
-			err = -errno;
-			perror("failed to open file");
-			goto out_delete;
-		}
-
-		err = fstat(input, &perf_stat);
-		if (err < 0) {
-			perror("failed to stat file");
-			goto out_delete;
-		}
-
-		if (!perf_stat.st_size) {
-			fprintf(stderr, "zero-sized file, nothing to do!\n");
-			goto out_delete;
-		}
-
-		scripting_ops = script_spec__lookup(generate_script_lang);
-		if (!scripting_ops && ends_with(generate_script_lang, ".py")) {
-			scripting_ops = script_spec__lookup("python");
-			free(filename);
-			filename = strdup(generate_script_lang);
-			filename[strlen(filename) - 3] = '\0';
-		} else if (!scripting_ops && ends_with(generate_script_lang, ".pl")) {
-			scripting_ops = script_spec__lookup("perl");
-			free(filename);
-			filename = strdup(generate_script_lang);
-			filename[strlen(filename) - 3] = '\0';
-		}
-		if (!scripting_ops) {
-			fprintf(stderr, "invalid language specifier '%s'\n", generate_script_lang);
-			err = -ENOENT;
-			goto out_delete;
-		}
-		if (!filename) {
-			err = -ENOMEM;
-			goto out_delete;
-		}
-#ifdef HAVE_LIBTRACEEVENT
-		err = scripting_ops->generate_script(session->tevent.pevent, filename);
-#else
-		err = scripting_ops->generate_script(NULL, filename);
-#endif
-		free(filename);
-		goto out_delete;
-	}
 
 	err = dlfilter__start(dlfilter, session);
 	if (err)
 		goto out_delete;
 
-	if (script_name) {
-		err = scripting_ops->start_script(script_name, argc, argv, session);
-		if (err)
-			goto out_delete;
-		pr_debug("perf script started with script %s\n\n", script_name);
-		script_started = true;
-	}
+
 
 
 	err = perf_session__check_output_opt(session);
@@ -4587,7 +4409,6 @@ int cmd_script(int argc, const char **argv)
 
 	err = __cmd_script(&script);
 
-	flush_scripting();
 
 	if (verbose > 2 || debug_kmaps)
 		perf_session__dump_kmaps(session);
@@ -4603,10 +4424,8 @@ int cmd_script(int argc, const char **argv)
 	perf_session__delete(session);
 	perf_script__exit(&script);
 
-	if (script_started)
-		cleanup_scripting();
+
 	dlfilter__cleanup(dlfilter);
 	free_dlarg();
-out:
 	return err;
 }
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 70cc91d00804..91457de2ea18 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -94,7 +94,6 @@ perf-util-y += tool_pmu.o
 perf-util-y += tp_pmu.o
 perf-util-y += svghelper.o
 perf-util-y += trace-event-info.o
-perf-util-y += trace-event-scripting.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-parse.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += trace-event-read.o
diff --git a/tools/perf/util/scripting-engines/Build b/tools/perf/util/scripting-engines/Build
deleted file mode 100644
index 54920e7e1d5d..000000000000
--- a/tools/perf/util/scripting-engines/Build
+++ /dev/null
@@ -1 +0,0 @@
-# No embedded scripting engines
diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
index 9c015fc2bcfb..374cf82fd86e 100644
--- a/tools/perf/util/trace-event-parse.c
+++ b/tools/perf/util/trace-event-parse.c
@@ -14,71 +14,6 @@
 #include <linux/kernel.h>
 #include <event-parse.h>
 
-static int get_common_field(struct scripting_context *context,
-			    int *offset, int *size, const char *type)
-{
-	struct tep_handle *pevent = context->pevent;
-	struct tep_event *event;
-	struct tep_format_field *field;
-
-	if (!*size) {
-
-		event = tep_get_first_event(pevent);
-		if (!event)
-			return 0;
-
-		field = tep_find_common_field(event, type);
-		if (!field)
-			return 0;
-		*offset = field->offset;
-		*size = field->size;
-	}
-
-	return tep_read_number(pevent, context->event_data + *offset, *size);
-}
-
-int common_lock_depth(struct scripting_context *context)
-{
-	static int offset;
-	static int size;
-	int ret;
-
-	ret = get_common_field(context, &size, &offset,
-			       "common_lock_depth");
-	if (ret < 0)
-		return -1;
-
-	return ret;
-}
-
-int common_flags(struct scripting_context *context)
-{
-	static int offset;
-	static int size;
-	int ret;
-
-	ret = get_common_field(context, &size, &offset,
-			       "common_flags");
-	if (ret < 0)
-		return -1;
-
-	return ret;
-}
-
-int common_pc(struct scripting_context *context)
-{
-	static int offset;
-	static int size;
-	int ret;
-
-	ret = get_common_field(context, &size, &offset,
-			       "common_preempt_count");
-	if (ret < 0)
-		return -1;
-
-	return ret;
-}
-
 unsigned long long
 raw_field_value(struct tep_event *event, const char *name, void *data)
 {
diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
deleted file mode 100644
index 0a0a50d9e1e1..000000000000
--- a/tools/perf/util/trace-event-scripting.c
+++ /dev/null
@@ -1,333 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * trace-event-scripting.  Scripting engine common and initialization code.
- *
- * Copyright (C) 2009-2010 Tom Zanussi <tzanussi@gmail.com>
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <errno.h>
-#ifdef HAVE_LIBTRACEEVENT
-#include <event-parse.h>
-#endif
-
-#include "debug.h"
-#include "event.h"
-#include "trace-event.h"
-#include "evsel.h"
-#include <linux/perf_event.h>
-#include <linux/zalloc.h>
-#include "util/sample.h"
-
-unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
-
-struct scripting_context *scripting_context;
-
-struct script_spec {
-	struct list_head	node;
-	struct scripting_ops	*ops;
-	char			spec[];
-};
-
-static LIST_HEAD(script_specs);
-
-static struct script_spec *script_spec__new(const char *spec,
-					    struct scripting_ops *ops)
-{
-	struct script_spec *s = malloc(sizeof(*s) + strlen(spec) + 1);
-
-	if (s != NULL) {
-		strcpy(s->spec, spec);
-		s->ops = ops;
-	}
-
-	return s;
-}
-
-static void script_spec__add(struct script_spec *s)
-{
-	list_add_tail(&s->node, &script_specs);
-}
-
-static struct script_spec *script_spec__find(const char *spec)
-{
-	struct script_spec *s;
-
-	list_for_each_entry(s, &script_specs, node)
-		if (strcasecmp(s->spec, spec) == 0)
-			return s;
-	return NULL;
-}
-
-static int script_spec_register(const char *spec, struct scripting_ops *ops)
-{
-	struct script_spec *s;
-
-	s = script_spec__find(spec);
-	if (s)
-		return -1;
-
-	s = script_spec__new(spec, ops);
-	if (!s)
-		return -1;
-
-	script_spec__add(s);
-	return 0;
-}
-
-struct scripting_ops *script_spec__lookup(const char *spec)
-{
-	struct script_spec *s = script_spec__find(spec);
-
-	if (!s)
-		return NULL;
-
-	return s->ops;
-}
-
-int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char *spec))
-{
-	struct script_spec *s;
-	int ret = 0;
-
-	list_for_each_entry(s, &script_specs, node) {
-		ret = cb(s->ops, s->spec);
-		if (ret)
-			break;
-	}
-	return ret;
-}
-
-void scripting_context__update(struct scripting_context *c,
-			       union perf_event *event,
-			       struct perf_sample *sample,
-			       struct evsel *evsel,
-			       struct addr_location *al,
-			       struct addr_location *addr_al)
-{
-#ifdef HAVE_LIBTRACEEVENT
-	const struct tep_event *tp_format = evsel__tp_format(evsel);
-
-	c->pevent = tp_format ? tp_format->tep : NULL;
-#else
-	c->pevent = NULL;
-#endif
-	c->event_data = sample->raw_data;
-	c->event = event;
-	c->sample = sample;
-	c->evsel = evsel;
-	c->al = al;
-	c->addr_al = addr_al;
-}
-
-static int flush_script_unsupported(void)
-{
-	return 0;
-}
-
-static int stop_script_unsupported(void)
-{
-	return 0;
-}
-
-static void process_event_unsupported(union perf_event *event __maybe_unused,
-				      struct perf_sample *sample __maybe_unused,
-				      struct evsel *evsel __maybe_unused,
-				      struct addr_location *al __maybe_unused,
-				      struct addr_location *addr_al __maybe_unused)
-{
-} static void print_python_unsupported_msg(void)
-{
-	fprintf(stderr, "Python scripting not supported."
-		"  Install libpython and rebuild perf to enable it.\n"
-		"For example:\n  # apt-get install python-dev (ubuntu)"
-		"\n  # yum install python-devel (Fedora)"
-		"\n  etc.\n");
-}
-
-static int python_start_script_unsupported(const char *script __maybe_unused,
-					   int argc __maybe_unused,
-					   const char **argv __maybe_unused,
-					   struct perf_session *session __maybe_unused)
-{
-	print_python_unsupported_msg();
-
-	return -1;
-}
-
-static int python_generate_script_unsupported(struct tep_handle *pevent
-					      __maybe_unused,
-					      const char *outfile
-					      __maybe_unused)
-{
-	print_python_unsupported_msg();
-
-	return -1;
-}
-
-struct scripting_ops python_scripting_unsupported_ops = {
-	.name = "Python",
-	.dirname = "python",
-	.start_script = python_start_script_unsupported,
-	.flush_script = flush_script_unsupported,
-	.stop_script = stop_script_unsupported,
-	.process_event = process_event_unsupported,
-	.generate_script = python_generate_script_unsupported,
-};
-
-static void register_python_scripting(struct scripting_ops *scripting_ops)
-{
-	if (scripting_context == NULL)
-		scripting_context = malloc(sizeof(*scripting_context));
-
-       if (scripting_context == NULL ||
-	   script_spec_register("Python", scripting_ops) ||
-	   script_spec_register("py", scripting_ops)) {
-		pr_err("Error registering Python script extension: disabling it\n");
-		zfree(&scripting_context);
-	}
-}
-
-void setup_python_scripting(void)
-{
-	register_python_scripting(&python_scripting_unsupported_ops);
-}
-
-
-static const struct {
-	u32 flags;
-	const char *name;
-} sample_flags[] = {
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL, "call"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN, "return"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CONDITIONAL, "jcc"},
-	{PERF_IP_FLAG_BRANCH, "jmp"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_INTERRUPT, "int"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN | PERF_IP_FLAG_INTERRUPT, "iret"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_SYSCALLRET, "syscall"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_RETURN | PERF_IP_FLAG_SYSCALLRET, "sysret"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_ASYNC, "async"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_ASYNC |	PERF_IP_FLAG_INTERRUPT,
-	 "hw int"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TX_ABORT, "tx abrt"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_BEGIN, "tr strt"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_TRACE_END, "tr end"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMENTRY, "vmentry"},
-	{PERF_IP_FLAG_BRANCH | PERF_IP_FLAG_CALL | PERF_IP_FLAG_VMEXIT, "vmexit"},
-	{0, NULL}
-};
-
-static const struct {
-	u32 flags;
-	const char *name;
-} branch_events[] = {
-	{PERF_IP_FLAG_BRANCH_MISS, "miss"},
-	{PERF_IP_FLAG_NOT_TAKEN, "not_taken"},
-	{0, NULL}
-};
-
-static int sample_flags_to_name(u32 flags, char *str, size_t size)
-{
-	int i;
-	const char *prefix;
-	int pos = 0, ret, ev_idx = 0;
-	u32 xf = flags & PERF_ADDITIONAL_STATE_MASK;
-	u32 types, events;
-	char xs[16] = { 0 };
-
-	/* Clear additional state bits */
-	flags &= ~PERF_ADDITIONAL_STATE_MASK;
-
-	if (flags & PERF_IP_FLAG_TRACE_BEGIN)
-		prefix = "tr strt ";
-	else if (flags & PERF_IP_FLAG_TRACE_END)
-		prefix = "tr end  ";
-	else
-		prefix = "";
-
-	ret = snprintf(str + pos, size - pos, "%s", prefix);
-	if (ret < 0)
-		return ret;
-	pos += ret;
-
-	flags &= ~(PERF_IP_FLAG_TRACE_BEGIN | PERF_IP_FLAG_TRACE_END);
-
-	types = flags & ~PERF_IP_FLAG_BRANCH_EVENT_MASK;
-	for (i = 0; sample_flags[i].name; i++) {
-		if (sample_flags[i].flags != types)
-			continue;
-
-		ret = snprintf(str + pos, size - pos, "%s", sample_flags[i].name);
-		if (ret < 0)
-			return ret;
-		pos += ret;
-		break;
-	}
-
-	events = flags & PERF_IP_FLAG_BRANCH_EVENT_MASK;
-	for (i = 0; branch_events[i].name; i++) {
-		if (!(branch_events[i].flags & events))
-			continue;
-
-		ret = snprintf(str + pos, size - pos, !ev_idx ? "/%s" : ",%s",
-			       branch_events[i].name);
-		if (ret < 0)
-			return ret;
-		pos += ret;
-		ev_idx++;
-	}
-
-	/* Add an end character '/' for events */
-	if (ev_idx) {
-		ret = snprintf(str + pos, size - pos, "/");
-		if (ret < 0)
-			return ret;
-		pos += ret;
-	}
-
-	if (!xf)
-		return pos;
-
-	snprintf(xs, sizeof(xs), "(%s%s%s)",
-		 flags & PERF_IP_FLAG_IN_TX ? "x" : "",
-		 flags & PERF_IP_FLAG_INTR_DISABLE ? "D" : "",
-		 flags & PERF_IP_FLAG_INTR_TOGGLE ? "t" : "");
-
-	/* Right align the string if its length is less than the limit */
-	if ((pos + strlen(xs)) < SAMPLE_FLAGS_STR_ALIGNED_SIZE)
-		ret = snprintf(str + pos, size - pos, "%*s",
-			       (int)(SAMPLE_FLAGS_STR_ALIGNED_SIZE - ret), xs);
-	else
-		ret = snprintf(str + pos, size - pos, " %s", xs);
-	if (ret < 0)
-		return ret;
-
-	return pos + ret;
-}
-
-int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz)
-{
-	const char *chars = PERF_IP_FLAG_CHARS;
-	const size_t n = strlen(PERF_IP_FLAG_CHARS);
-	size_t i, pos = 0;
-	int ret;
-
-	ret = sample_flags_to_name(flags, str, sz);
-	if (ret > 0)
-		return ret;
-
-	for (i = 0; i < n; i++, flags >>= 1) {
-		if ((flags & 1) && pos < sz)
-			str[pos++] = chars[i];
-	}
-	for (; i < 32; i++, flags >>= 1) {
-		if ((flags & 1) && pos < sz)
-			str[pos++] = '?';
-	}
-	if (pos < sz)
-		str[pos] = 0;
-
-	return pos;
-}
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index 7bdf44403e3a..19f22ac1faf3 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -7,15 +7,9 @@
 #include <sys/types.h>
 #include <linux/types.h>
 
-struct evlist;
 struct machine;
-struct perf_sample;
-union perf_event;
-struct perf_tool;
-struct thread;
-struct tep_plugin_list;
-struct evsel;
 struct tep_format_field;
+struct tep_plugin_list;
 
 struct trace_event {
 	struct tep_handle	*pevent;
@@ -79,73 +73,6 @@ struct tracing_data *tracing_data_get(struct list_head *pattrs,
 				      int fd, bool temp);
 int tracing_data_put(struct tracing_data *tdata);
 
-
-struct addr_location;
-
-struct perf_session;
-struct perf_stat_config;
-
-struct scripting_ops {
-	const char *name;
-	const char *dirname; /* For script path .../scripts/<dirname>/... */
-	int (*start_script)(const char *script, int argc, const char **argv,
-			    struct perf_session *session);
-	int (*flush_script) (void);
-	int (*stop_script) (void);
-	void (*process_event) (union perf_event *event,
-			       struct perf_sample *sample,
-			       struct evsel *evsel,
-			       struct addr_location *al,
-			       struct addr_location *addr_al);
-	void (*process_switch)(union perf_event *event,
-			       struct perf_sample *sample,
-			       struct machine *machine);
-	void (*process_auxtrace_error)(struct perf_session *session,
-				       union perf_event *event);
-	void (*process_stat)(struct perf_stat_config *config,
-			     struct evsel *evsel, u64 tstamp);
-	void (*process_stat_interval)(u64 tstamp);
-	void (*process_throttle)(union perf_event *event,
-				 struct perf_sample *sample,
-				 struct machine *machine);
-	int (*generate_script) (struct tep_handle *pevent, const char *outfile);
-};
-
-extern unsigned int scripting_max_stack;
-
-struct scripting_ops *script_spec__lookup(const char *spec);
-int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char *spec));
-
-
-void setup_python_scripting(void);
-
-struct scripting_context {
-	struct tep_handle *pevent;
-	void *event_data;
-	union perf_event *event;
-	struct perf_sample *sample;
-	struct evsel *evsel;
-	struct addr_location *al;
-	struct addr_location *addr_al;
-	struct perf_session *session;
-};
-
-void scripting_context__update(struct scripting_context *scripting_context,
-			       union perf_event *event,
-			       struct perf_sample *sample,
-			       struct evsel *evsel,
-			       struct addr_location *al,
-			       struct addr_location *addr_al);
-
-int common_pc(struct scripting_context *context);
-int common_flags(struct scripting_context *context);
-int common_lock_depth(struct scripting_context *context);
-
-#define SAMPLE_FLAGS_BUF_SIZE 64
-#define SAMPLE_FLAGS_STR_ALIGNED_SIZE	21
-
-int perf_sample__sprintf_flags(u32 flags, char *str, size_t sz);
-
 #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
 #include <event-parse.h>
 
-- 
2.54.0.rc2.533.g4f5dca5207-goog

