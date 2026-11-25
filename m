Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795570713;
	b=IJNJvP8UB/sSUKtvCv389kJddEv//UZRn7PUfU7Ol1Pqk9nqqps+NbSt3W2fLLL+3lAK
	 y8f6VlhKgshb8osdWg8hkGOisuMyfGlNn4t0xoEN0OR3rDJnSyfD4EJQBM0FgTmvM1lFA
	 VhcSorm0oPDqpbYmszn3Vsm/byEtd4A9w/7YPxvH+PtwKcf9tePsuyQ8DEfx8ZVTZ0xeF
	 DQQ3+CuIT8IcItpPzKCc09ZqMZr6HhlJfeiCDuRNCTdc5L5ODl8s0cPBzu3dkJrFsBjLy
	 fRn+WAuCSHxvXRC6GkYzJLENlLIAfSYv24+ZhdihttJW07RVwGNUdiiV8MfC7VqZdUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795570713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8Vv99MPpkslfI31+Mx5b7uT41xxx/LrADAwFgaN3tlY=;
	b=CC9QDaXVyzUOjWEx6uX+kri/e7bvDDLRdN4111Qyf4GxQv/XS1fsxNBnklb62oiREkBk
	 FK3mmq5kKyPGBwskIE7wQWFMSFBTSgj8hxPLoHp1lo5pD0/tG+kb2r8GgkeMDrHY/C/Tm
	 Ok+a5zjjGHzscs9kGfjJWOIf/ZvSkTN2RlI/6novr2EH2poU2ggpLi/lqVgLZ02ac4Sa2
	 S+/6E75r7apicKGE1lgBh0c4DtriQJKQCxsKa4DpdcU2FbL6kiQ2WzJFqeh8IX5nOpwij
	 SKqjIBKyJiObj9mOmWBpRFtLYz+YFNkAGCL+Z+jaraufkb9YUUTF5Ewagv6q2bNqvsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GFuy7yXk;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0C4606A323
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 01:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E0C4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GFuy7yXk
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33fb4680717so13410254eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 17:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795570711; x=1796175511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Vv99MPpkslfI31+Mx5b7uT41xxx/LrADAwFgaN3tlY=;
        b=GFuy7yXk0uHaGiYhxMTpDBkZnfZ6B0cUDHX8fkhSMzvEehYUvNjgajp95CqTsUWDHF
         0D9qWi2e2hIudkXWKpfoAw/Nfvr16ceeRPyRD2/46wRaVjwYgLkthc62YL9vJdEXPMuW
         iNpsk4bJ9Cd3MYxXHwsEDsjtIp5YbXtYiT72LTMGLFHKpQ0p86Rm9OwPJsiFla3MKZ14
         we8d1myisgP+wicTxgSps5hybh/1aQPmdFBxmdV8Vm2yRp5+i8TDcjHR8NszJPTIZ4oi
         4HtoWh3ibmxzJnM1gUMvyE8qrQ0yuJwQsTFzL73tbCjY1par8QHn6U0wor465cskQdqU
         /X6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795570711; x=1796175511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Vv99MPpkslfI31+Mx5b7uT41xxx/LrADAwFgaN3tlY=;
        b=OSaHYrq89vmLLtnrpLyFRFtCSmQ3rPFpIX4rHbYS0tzLtnCYYmIqYBD+yeEaYwBFW3
         gdRSlIr5HvSS0axSbKLMvDVlzS4dKEVd3Ch5+vqFjaE6VJbXcQlY3AIPGpSlEkWV2KNS
         yvOeYecgJjX0z4fY86GMcgek6qH0QWhPbPzn+464zoGFkq01E6ExEAAsv75iENuBjMSb
         rerPRfsDogvQ3pL/b3OzEgtlNimEoq/Yzibm2EEbcOdC5Jpy3VONWjWZAengfvbeY1Q2
         IoHRHQQS5X1qVHFaJPpTApYWTQIJ5N7fWlA+JtFpJ9qmmhe9SSiMFlDAlGNzthFexwDE
         n1Uw==
X-Gm-Message-State: APuU4Z8fnr0+NZl+LkbyEK+iYsnAsNnbcFF6kAjmWt3BrNt3GYzYJJM4
	hSUCh81TMgwDPG8fGALzZtPzVT//+LMYFNI/ywUVeE4CDkxSQYn6OMv/W1ZJeJ91
X-Gm-Gg: AZFdTZcrkCiFYdbN9tJ6mBwpr6SK3+MvEcvS1DKQe+x4pNuzjeYxpVeLgfL1LLHx61w
	stz9DsdNriaqSOY+4xLU+VERZguUtXf9Mz+kZb0PFzpz/CMRRpoxXSDGH050tVNarAex+nwr/HX
	1pRmhesCkW1fCuVFSxLKAjciCdjUN0uTbOlXVl3kYhDIx6PW9nGZJ016/PVYBx1MjRe6fNFwFHu
	UZr0vmu3ALRDteGXG5408/55stSt7Kz8FWSu9c6m9KxuMRZOISV2D3FBpidF9y2JLGtOuqaw26n
	HCngjWddIBnc9AHQfp9q1erQ0nOIHtNDFcNF5911EWvYGOzZSpxXuobaALVIzOOQ9nkQOpjo2E2
	gEPqWTBSYbbCjBtpM3ZrEKg46Z4iLWlvi+uv3axiiM5gylxeywDzVaxpXraMZI8uEsd8bY/FT03
	KA2WynEYt+YXUWkNmAcdcgXioHkbR1JkKN0fF7AuzQ24adkFsiAhpB9kmmzuqEC7bnhKbRYynci
	uFcXS8XmNXrGAzjZ1U4qW6bf+iLHoxWtA/0zt/nC3EXtYCNHx9w55DJRqTqZTkgHpDq2f7UMb3a
	FdmUkIWVNVgKMAMN4WJx
X-Received: by 2002:a05:7301:9a82:b0:369:4c3f:8a5 with SMTP id 5a478bee46e88-3856ef45385mr17875756eec.14.1795570710976;
        Tue, 24 Nov 2026 17:38:30 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm47889173eec.23.2026.11.24.17.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 17:38:30 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Hang Zhengyang <hang.zhengyang1010@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v6] perf stat: Refuse a group mixing tool and kernel events
Date: Wed, 25 Nov 2026 01:38:26 +0000
Message-ID: <20261125013826.1495729-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124135630.1027716-1-takano32@gmail.com>
References: <20261124135630.1027716-1-takano32@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A tool event has no kernel counterpart: user_time and system_time read
/proc/stat, or /proc/<pid>/stat for a workload, and duration_time keeps
its value in perf itself.  perf-list(1) says events from different PMUs
cannot be grouped except for some software events, and the tool PMU counts
as software, so a tool event stays in the group the user wrote.

The parser splits it from another software PMU's event, such as cpu-clock,
and evlist__check_cpu_maps() removes members whose CPUs do not match the
leader under -a or -C.  What is left is a group that cannot be counted.

Before this change, with user_time or system_time as the leader,
get_group_fd() handed the procfs descriptor to the members and the kernel
rejected each with EBADF.  With duration_time as the leader there was no
descriptor, so the members got -2 and failed with EINVAL, "broken group
leader" appearing only in the debug log.  Either way perf stat printed the
tool event and "<not supported>" for the rest of the group:

  $ perf stat -e '{user_time,cycles}' -- sleep 0.05
                   0      user_time
     <not supported>      cycles

Before this change too, with a kernel event as the leader, the members did
open, but the group read failed with ENOSPC.  perf sized the buffer for
leader->core.nr_members entries, which included the tool event, while the
kernel filled in one entry fewer; readn() then asked for the remainder
with a count below the kernel's read_size, so the rest of the group came
out as "<not counted>".  That was the shape of
-e '{cycles,instructions,duration_time}', which had not been counted since
commit 6828d6929b76 ("perf evsel: Refactor tool events").

Counting such a group means moving the leader to a kernel event and
letting the group read skip the tool members; that is left to a separate
series.  Splitting the tool event out and warning, as
evlist__check_cpu_maps() does, would let the kernel events count, but the
tool event would lose the group's window and the warning is easy to miss
in a script.  The braces are the user's explicit request, so perf stat
should not quietly reinterpret them.  Ian's "perf pmu: Don't treat tool
PMU as a kernel software PMU for event grouping" splits it in the parser
and this check then has nothing to refuse; Hang's patch opens the members
with group_fd = -1 instead, which this check preempts.  Only one of the
three should be applied.

Refuse the group before the workload is started:

  A tool event cannot be grouped with kernel events: user_time

That is followed by "Put it outside the braces", as in
-e '{cycles,instructions},duration_time'.  perf stat used to leave the rest
of the group uncounted and exit 0; it now exits 22.  Namhyung Kim preferred
the refusal to counting the events one by one.  get_group_fd() no longer
trips its BUG_ON() for a tool event with no descriptor, which is normal for
duration_time; the BUG_ON() only fired in a DEBUG=1 build.

A group of tool events only is accepted, as before.  A weak group led by a
tool event is left to the weak group handling, which splits it in the open
loop: get_group_fd() reports that no kernel group can hang off a tool
event, and the loop splits on EINVAL before any member is enabled.  Any
other weak group that mixes them is refused like a strong one.

Sashiko's review of v5 found that the split was skipped for a leader that
is a tool event but still has an fd.  user_time and system_time do have
one, a procfs descriptor, so fd == -1 was false and that descriptor was
handed to perf_event_open() as group_fd.  Under -a with
perf_event_paranoid > 1 the member cycles:k failed with EACCES, which is
not a split condition, so it stayed in the group while its fd array was
freed; enabling the group then dereferenced NULL:

  $ perf stat -a -e '{user_time,cycles:k}:W' -- true
  Segmentation fault

get_group_fd() now returns -2 for a tool leader with or without an fd.  The
fd it may have is a procfs one and cannot be a group_fd for the members.

The test no longer requires cycles to be printed when no hardware cycles
event can be counted: the evsel falls back to task-clock or is renamed,
and the group output is still checked.  A weak group led by a tool event
under -a is now run as well, so the crash above stays fixed.

Where the core PMU covers only part of the CPUs (hybrid x86, big.LITTLE
arm64), evlist__check_cpu_maps() takes the tool event out first under -a,
so no mixed group is left to refuse.  Sashiko's review of v4 raised this
and the NULL dereference that the get_group_fd() change above prevents.

The code, the test, the man page and this message were written with
Hermes Agent (deepseek-v4.1-flash); I reviewed the result, built perf, and
ran tools/perf/tests/shell/stat+tool_group.sh and checkpatch.pl --strict.
The -a segmentation fault above was reproduced here.  The EBADF and the
group-read failure were not re-observed: kernel events cannot be opened
here (perf_event_paranoid=4).

Fixes: 6828d6929b76 ("perf evsel: Refactor tool events")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/sashiko-outbox-227849@kernel.org/
Link: https://lore.kernel.org/all/sashiko-outbox-231330@kernel.org/
Reported-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Link: https://lore.kernel.org/all/20261111-tool-pmu-leader-v2-1-3faa0fb98c51@gmail.com/
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/all/awC_aZXD5FBGu4mO@google.com/
Link: https://lore.kernel.org/all/awTXdgY38s2bijW5@google.com/
Cc: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/all/20261123071913.653315-7-irogers@google.com/
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v6: Sashiko's review of v5 found that a tool leader with a procfs
    descriptor skipped the weak group split: user_time and system_time
    do have an fd, so fd == -1 was false, the procfs fd went to
    perf_event_open() as group_fd, and under -a with
    perf_event_paranoid > 1 the member failed with EACCES, which is not
    a split condition.  Its fd array was freed and enabling the group
    dereferenced NULL.  Reproduced here:

      $ perf stat -a -e '{user_time,cycles:k}:W' -- true
      Segmentation fault

    get_group_fd() now returns -2 for any tool leader, with or without
    an fd; the fd it may have is a procfs one and cannot be a group_fd.
    The -a cases no longer crash and the refusal is unchanged.  The test
    runs one of them, so the crash stays fixed.

    The test no longer requires cycles to be printed when no hardware
    cycles event can be counted: the evsel falls back to task-clock or
    is renamed.  That was Sashiko's Low finding.

    Two comments in builtin-stat.c that described the EBADF route
    were updated to the EINVAL route that get_group_fd() returns for a
    tool leader.

    v5: Namhyung Kim confirmed on 2026-11-24 00:16 UTC
    (https://lore.kernel.org/all/awTXdgY38s2bijW5@google.com/)
    that the group should be rejected rather than counted event by event,
    so this keeps the refusal and drops the question from the message.

    Rebased onto v7.4-rc4.  The perf-tools-next branch fetched here is still
    at 2026-10-27 and does not carry tools/include/linux/stddef.h.

 tools/perf/Documentation/perf-stat.txt    |  14 ++
 tools/perf/builtin-stat.c                 |  69 +++++++
 tools/perf/tests/shell/stat+tool_group.sh | 237 ++++++++++++++++++++++
 tools/perf/util/evsel.c                   |  11 +
 4 files changed, 331 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat+tool_group.sh

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 8ea17da89976..e52925ff776b 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -65,6 +65,20 @@ report::
 	Multiple PMU instances are typical for uncore PMUs, so the prefix
 	'uncore_' is also ignored when performing this match.
 
+	Tool events such as duration_time and user_time are read by perf
+	itself and have no event in the kernel.  A group of a tool event and
+	an event from a different software PMU, such as cpu-clock, is split by
+	the parser, which warns that events were regrouped; -a and -C split
+	a group whose members do not share the CPUs of the leader in the
+	same way.  A group that is not split and mixes a tool event with an
+	event the kernel opens is refused, as in -e '{user_time,cycles}',
+	instead of printing the tool event and leaving the rest of the group
+	uncounted.  Put the tool event outside the braces instead, as in
+	-e '{cycles,instructions},duration_time'.  A group of tool events
+	only is accepted.  A weak group (:W) led by a tool event is left to
+	the weak group handling, which splits it when a member fails to
+	open; any other weak group that mixes them is refused
+	like a strong group.
 
 -i::
 --no-inherit::
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 37752d6bfef4..21cf17d3dcca 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2469,6 +2469,70 @@ static int parse_tpebs_mode(const struct option *opt, const char *str,
 }
 #endif // HAVE_ARCH_X86_64_SUPPORT
 
+/*
+ * A tool event like user_time has no event in the kernel: perf reads it
+ * from a file such as /proc/stat, or computes it in perf itself.  A group
+ * that mixes one with an event the kernel opens cannot be counted.
+ * get_group_fd() has no group fd to hand to the members when the leader is
+ * a tool event, so the members cannot be in a kernel group with it; with
+ * a kernel event as the leader the members do open, but the group read is
+ * rejected as the kernel knows only the members it opened.  perf stat used
+ * to leave the rest of the group uncounted in both cases, when the CPU maps
+ * had not split the group first; refuse the group instead.  A group with no
+ * event the kernel opens is left alone, as perf reads each event in it.  A
+ * weak group led by a tool event is left to the weak group handling in the
+ * open loop, which splits it when a member fails to open; any other weak
+ * group is refused like a strong one.
+ */
+static int check_tool_groups(struct evlist *evlist)
+{
+	struct evsel *leader, *evsel;
+
+	evlist__for_each_entry(evlist, leader) {
+		struct evsel *tool = NULL;
+		bool has_kernel = false, weak = false;
+
+		if (!evsel__is_group_leader(leader) || leader->core.nr_members < 2)
+			continue;
+
+		/*
+		 * The members of a group are not necessarily adjacent in the
+		 * evlist: evlist__check_cpu_maps() makes a removed member a
+		 * leader of its own without moving it.
+		 */
+		evlist__for_each_entry(evlist, evsel) {
+			if (!evsel__has_leader(evsel, leader))
+				continue;
+			if (evsel__is_tool(evsel)) {
+				if (!tool)
+					tool = evsel;
+			} else if (!evsel__is_non_perf_event_open_pmu(evsel)) {
+				has_kernel = true;
+			}
+			weak |= evsel->weak_group;
+		}
+
+		if (!tool || !has_kernel)
+			continue;
+
+		/*
+		 * A weak group led by a tool event is left to the weak group
+		 * handling in the open loop: get_group_fd() returns -2 for a
+		 * tool leader, the open fails with EINVAL, and that is what
+		 * splits the group.  Any other weak group does not get that
+		 * far, so it is refused like a strong group.
+		 */
+		if (weak && evsel__is_tool(leader))
+			continue;
+
+		pr_err("A tool event cannot be grouped with kernel events: %s\n",
+		       evsel__name(tool));
+		pr_err("Put it outside the braces, as in -e '{cycles,instructions},duration_time'.\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 int cmd_stat(int argc, const char **argv)
 {
 	struct opt_aggr_mode opt_mode = {};
@@ -2947,6 +3011,11 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__check_cpu_maps(evsel_list);
 
+	if (check_tool_groups(evsel_list)) {
+		status = -EINVAL;
+		goto out;
+	}
+
 	/*
 	 * Initialize thread_map with comm names,
 	 * so we could print it out on output.
diff --git a/tools/perf/tests/shell/stat+tool_group.sh b/tools/perf/tests/shell/stat+tool_group.sh
new file mode 100755
index 000000000000..ff7142977979
--- /dev/null
+++ b/tools/perf/tests/shell/stat+tool_group.sh
@@ -0,0 +1,237 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# perf stat tool events in an event group (no_mlock)
+
+set -e
+
+out=$(mktemp /tmp/__perf_test.stat_tool_group.XXXXXX)
+stderr=$(mktemp /tmp/__perf_test.stat_tool_group.XXXXXX)
+err=0
+skipped=0
+
+cleanup() {
+  rm -f "${out}" "${stderr}"
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+# A tool event has no event in the kernel: perf reads it from a file such
+# as /proc/stat, or computes it in perf itself, so it cannot be counted in
+# a group that is opened with perf_event_open().  Such a group used to
+# print the tool event and leave the rest of the group uncounted, so perf
+# stat has to say what is wrong instead.
+
+# Whether this kernel lets the user open a hardware event decides whether
+# the accepted cases can show a measured value at all.  An event that is
+# not supported prints a "<not supported>" line even when perf stat exits 0.
+kernel_events=1
+if ! perf stat -e cycles -o "${out}" -- true 2> /dev/null ||
+   grep -q "<not supported>" "${out}" ||
+   ! grep -q "cycles" "${out}"; then
+  kernel_events=0
+fi
+
+# CPU-wide events need root or perf_event_paranoid <= 0, so -a can fail even
+# when a per-thread event works.
+syswide=1
+if ! perf stat -a -e cycles -o /dev/null -- true 2> /dev/null; then
+  syswide=0
+fi
+
+refused() {
+  local group="$1" tool="$2" rc=0
+  shift 2
+
+  echo "Testing that perf stat refuses ${group} $*"
+  perf stat "$@" -e "${group}" -o "${out}" -- true 2> "${stderr}" || rc=$?
+
+  if [ "${rc}" = 0 ]; then
+    echo "perf stat accepted ${group}  [Failed]"
+    err=1
+    return
+  fi
+  if [ "${rc}" != 22 ]; then
+    echo "perf stat failed with ${rc}, expected 22  [Failed]"
+    cat "${stderr}"
+    err=1
+  fi
+  if ! grep -qE "A tool event cannot be grouped with kernel events: (${tool})" \
+      "${stderr}"; then
+    echo "perf stat failed without naming ${tool}  [Failed]"
+    cat "${stderr}"
+    err=1
+  fi
+  if ! grep -q "Put it outside the braces" "${stderr}"; then
+    echo "perf stat failed without saying how to write it  [Failed]"
+    cat "${stderr}"
+    err=1
+  fi
+}
+
+# The events named after the group have to show up in the output.
+accepted() {
+  local group="$1" name rc=0
+
+  shift
+  echo "Testing that perf stat accepts ${group}"
+  perf stat -e "${group}" -o "${out}" -- true 2> "${stderr}" || rc=$?
+
+  if [ "${rc}" != 0 ]; then
+    cat "${stderr}"
+    echo "perf stat failed for ${group} (${rc})  [Failed]"
+    err=1
+    return
+  fi
+  if grep -q "cannot be grouped with kernel events" "${stderr}"; then
+    cat "${stderr}"
+    echo "perf stat refused ${group}  [Failed]"
+    err=1
+    return
+  fi
+  for name in "$@"; do
+    # When no hardware cycles event can be counted, cycles falls back to
+    # task-clock and the evsel is renamed, so it need not appear.
+    case "${name}" in
+      cycles|cycles:*)
+        [ "${kernel_events}" = 0 ] && continue ;;
+    esac
+    if ! grep -q -- "${name}" "${out}"; then
+      echo "perf stat did not print ${name}  [Failed]"
+      cat "${out}"
+      err=1
+    fi
+  done
+  if grep -q "<not counted>" "${out}"; then
+    echo "perf stat did not count an event in ${group}  [Failed]"
+    cat "${out}"
+    err=1
+  elif grep -q "<not supported>" "${out}"; then
+    if [ "${kernel_events}" = 1 ]; then
+      echo "perf stat could not open an event in ${group}  [Failed]"
+      cat "${out}"
+      err=1
+    else
+      echo "perf stat could not open an event in ${group}  [Skipped]"
+      skipped=$((skipped + 1))
+    fi
+  fi
+}
+
+# The tool event as the leader and as a member, a common group that puts
+# the tool event last, and a weak group led by a kernel event, which is
+# refused the same way.
+refused '{user_time,cycles}' user_time
+refused '{cycles,user_time}' user_time
+refused '{duration_time,instructions}' duration_time
+refused '{cycles,instructions,duration_time}' duration_time
+refused '{cycles,user_time}:W' user_time
+
+# The tool event in the middle of a group, and the first of two tool
+# events, which is the one the message names.
+refused '{cycles,user_time,instructions}' user_time
+refused '{user_time,system_time,cycles}' user_time
+
+# evlist__check_cpu_maps() takes duration_time out of this group (it is
+# read on one CPU only), which leaves cycles and user_time apart in the
+# evlist; the tool event has to be found anyway.  On a machine with one
+# CPU there is nothing to split, so either tool event can be the first.
+# When a core PMU covers only part of the CPUs (hybrid x86, big.LITTLE
+# arm64), -a gives the leader a subset of the CPUs and takes the tool
+# event out of the group as well, which leaves no group to refuse.  The
+# command is then counted instead of refused, and either way it must not
+# reach the tool event through a member with no descriptor.
+rc=0
+perf stat -a -e '{cycles,duration_time,user_time}' -o "${out}" -- true \
+  2> "${stderr}" || rc=$?
+if [ "${rc}" -ge 128 ]; then
+  echo "perf stat crashed on -a  [Failed]"
+  err=1
+elif [ "${rc}" -eq 0 ]; then
+  if [ "${syswide}" = 1 ] && [ "${kernel_events}" = 1 ]; then
+    if grep -qE "<not supported>|<not counted>" "${out}"; then
+      echo "perf stat left an event uncounted on -a  [Failed]"
+      cat "${out}"
+      err=1
+    fi
+  else
+    echo "perf stat counted -a without full access  [Skipped]"
+    skipped=$((skipped + 1))
+  fi
+elif [ "${rc}" -eq 22 ]; then
+  if ! grep -qE "A tool event cannot be grouped with kernel events: (user_time|duration_time)" \
+      "${stderr}" ||
+     ! grep -q "Put it outside the braces" "${stderr}"; then
+    echo "perf stat refused -a without the full message  [Failed]"
+    cat "${stderr}"
+    err=1
+  fi
+elif [ "${rc}" -ne 0 ]; then
+  echo "perf stat left -a with ${rc}  [Failed]"
+  cat "${stderr}"
+  err=1
+fi
+
+# A group of tool events only is read by perf itself, a single event in
+# braces is not a group, a tool event outside the braces is not a member,
+# and a weak group led by a tool event is split by the weak group
+# handling.  The member of such a group must never be enabled through a
+# descriptor that was freed; that used to crash under -a when the open of
+# the member failed outside the split conditions.
+rc=0
+perf stat -a -e '{user_time,cycles:k}:W' -o "${out}" -- true \
+  2> "${stderr}" || rc=$?
+if [ "${rc}" -ge 128 ]; then
+  echo "perf stat crashed on a weak tool group under -a  [Failed]"
+  err=1
+elif [ "${rc}" -ne 0 ]; then
+  echo "perf stat left a weak tool group under -a with ${rc}  [Failed]"
+  cat "${stderr}"
+  err=1
+elif ! grep -q -- "user_time" "${out}"; then
+  echo "perf stat dropped user_time from a weak tool group under -a  [Failed]"
+  cat "${out}"
+  err=1
+fi
+
+accepted '{user_time,system_time}' user_time system_time
+accepted '{duration_time,user_time}' duration_time user_time
+accepted '{user_time}' user_time
+accepted '{cycles,instructions},duration_time' duration_time
+accepted '{user_time,cycles}:W' user_time cycles
+accepted '{system_time,cycles}:W' system_time cycles
+accepted '{duration_time,cycles}:W' duration_time cycles
+
+echo "Testing that a tool event on its own is accepted"
+if ! perf stat -e user_time -o "${out}" -- true; then
+  echo "perf stat rejected a tool event on its own  [Failed]"
+  err=1
+elif ! grep -q "user_time" "${out}"; then
+  echo "perf stat did not print user_time  [Failed]"
+  cat "${out}"
+  err=1
+fi
+
+echo "Testing that the default events still work"
+if ! perf stat -o "${out}" -- true; then
+  echo "perf stat without -e failed  [Failed]"
+  err=1
+fi
+
+cleanup
+
+if [ "${err}" = 0 ] && [ "${skipped}" -gt 0 ]; then
+  echo "perf stat tool event group test [Success] (${skipped} skipped)"
+elif [ "${err}" = 0 ]; then
+  echo "perf stat tool event group test [Success]"
+else
+  echo "perf stat tool event group test [Failed]"
+fi
+
+exit "${err}"
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d060fca8090f..d4cc705f3379 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2381,6 +2381,17 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
 		return -1;
 
 	fd = FD(leader, cpu_map_idx, thread);
+	if (evsel__is_tool(leader)) {
+		/*
+		 * A tool event has no perf_event_open() descriptor, or has
+		 * only a procfs one (user_time, system_time).  Either way the
+		 * members cannot be in a kernel group with it, and its fd
+		 * must not be passed to perf_event_open() as group_fd.
+		 * builtin-stat.c decides on the weak group split from errno.
+		 */
+		errno = EINVAL;
+		return -2;
+	}
 	BUG_ON(fd == -1 && leader->supported);
 
 	/*

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.53.0

