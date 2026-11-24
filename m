Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528598;
	b=aNcXXL6UVtA3YnEZjknpLedLDvtX56RD2r1eQchhO1DSTvBoPD9CTYqtSSgnPOO+LYX9
	 zgN5d05H4jUYdBB6aN5B7WMrDmG8m4LheXjcj/G/i0qHTeeRIPOcUNeSug4H4+PUFo3a3
	 3XZp9DPHV9PWPB6YADUZL0KdNhCuu9M6G2WTgMpKXuKWyPPmPNxwaru4yN3rF+cfm5XDu
	 RxE59DpJYy6wGA/StkWzVULxicgTPGeSdcUeh3mY8Qq/UxYNvinRYkltq4fKb0+m9Xgz6
	 KIy3pVbHFCnwvflX12IpWib/GH/v5pCxbmH0pcW4yZNVohjYLxU62rPQwbI6DxpguwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LlmXuALX9mBfGSWiCyUcAzbrnd33DvSWTB08RoMtXac=;
	b=GGrSiPJWOs+40WX6ryRsZRDMVz2TGThP0e7Nj2NR+9gVnHR7wS4AIZSB5f/dU6H77Z8M
	 hYBPSYeufSgZU39W9HiQtuDbbFmpXF33mNB2d3dh+FouMWqVtOt/5O7VOvOTXpGXOZbFr
	 ABowdZuwA3+/Gk/V2lg2DBXBCgHTGEz7AvPU//PQM8+ut0BzC//z7kIL3EqBvQdl8mQyw
	 1hZHiyBhmaThuEDUwznUt10y0Wj+pSvz2w1/SwnObtEHFpLPWB/+3rBxLRmA8+9tfonO0
	 81w/raUUGGpMGlnSqUuOREPWrYgR59SSe9t5ajx9provbIgUvrHcib/W6rAH+jol4yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=doLcza8A;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F83A606A321
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 13:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F83A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=doLcza8A
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7d2ccd3c7a2so1457461137.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 05:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795528597; x=1796133397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LlmXuALX9mBfGSWiCyUcAzbrnd33DvSWTB08RoMtXac=;
        b=doLcza8AvU6tbBqYT26ghWAw31oENO7LUs/ktKmL/Mzh6KO4kC41gvbM68BraUdATt
         jJ1SUbp97nz5OiLCpc1TEy8IDu9QfDiDE93/KJ5EFUkdzVEhj9EDlFx5Dody316kW3q+
         dCb83xr4+lmA2IGTyVtq6Qke+A3WLPNYRiEv2DMSCHiZ3nY+MWavyaP/FM98/8v1vruD
         nRerFSW32PiV9mQWDt4zYOvczqMtgbpSwG6QJuKDaZ2Gw1VH334nzthGly5EmyzNsF7I
         wGL+nais7HRwPzUN2PXTy/JW7/NlqxfsNBJr48yJe2Bvr5EULGc3ALF/U/4fkJfwfXdQ
         SWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795528597; x=1796133397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LlmXuALX9mBfGSWiCyUcAzbrnd33DvSWTB08RoMtXac=;
        b=OgNjaOUG6Tic8Bj4wAUSGibxSJcbpC6rApKQr8vNtwI+Bm2fApNGyoiECPrrsR2Yhh
         KT60+fCJMM1RUIwOXbaAz92ZAjaNrFbnqIFOxD5K2gc3jUWht7OAu8xLgpM0WCcFq78S
         oH0Z1r6p0PSFygR2SKorc8SdVDlC6k+kS2ii0OPamETNQgpyzm54koevEJs8DnXHylQC
         subafTGkD1GkO4gT87loElzRvXzVAe4qEve4WvAdLAQo+FYXjYp+kkY6jML9kI9Kxb+5
         K0INqilhbAr3KMxvYoaYD4z7Hs5EZEftkaUaaKG+kfrI02KjhfOE2QXXoYcbUgbEXmCG
         SzYw==
X-Gm-Message-State: APuU4Z/DLKJp+meLzPKitKs3nZ1KxjikTLOMLETiKBmrNxSyBFQIN8sa
	diU76FbhlEX6kFWJl/g1IwdmI7HL+XKb8qzWgAvYnCz3ZK248nwm1m+UxvKXjhmn
X-Gm-Gg: AZFdTZdzLNcD0gWQLXtr3i12rJcOfoE7QAxPFKdQdsdjdtAfBdRL7hj4IlO3x6ZpoF9
	INQlCNBpw8F5Mxghb2Me9xc95AUS6JwE9TZDPkdlJCi2pubPxvHO/CDMUq6ZQ33BbhD4+cgNu0G
	sZqSzWxDrKIpInQAcL9zjcwOvvUYmN+Pbbxnp/77QhZ36wMr1nnOsDQFZNjIHkLLpmlgwhAYEOf
	wk1NmiLTZb+KMp7ULRNSOOxvgXELUTF7HB02uD3KdOXzxwjktgGA5ANwiyrlNJAsD59HgiCRNLO
	e2av0Kfw1ExjTQgtzHagUutEctfGppuiOUD89B3XYiL40M6SB2BjinRc/FNMqCPUjhg3H3Gi+L5
	xoPpFe1WOv3Y0eiOInAZwhhqsO5TfvjJfNLmdqucSbF4xcqAgmiuECKTUIegJZ1OKIlgGyx7igW
	/qonXe5FzP6jBXHIWA8hR02weY7aPgKRD3L9NbO27Ck3aEjLsch3gwCgvhuEK0j7RJ92pIcB1zh
	ed8qpWG1pmbrpJWk0OHkYofcyPE17oBzfK4n6ZYYpKa9fylbEIJ5HGVNVk/uFzrXCR6PU+FHjz3
	Py9sUHNGIO5YDZQMZjpHzYm/bwta28NKqBlofUSfRQ==
X-Received: by 2002:a05:6102:3712:b0:7b5:4700:3a58 with SMTP id ada2fe7eead31-7d739604ad6mr7044200137.31.1795528596499;
        Tue, 24 Nov 2026 05:56:36 -0800 (PST)
Received: from a1-free ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7fa0467sm15504627137.6.2026.11.24.05.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:56:35 -0800 (PST)
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
Subject: [PATCH v5] perf stat: Refuse a group mixing tool and kernel events
Date: Tue, 24 Nov 2026 13:56:30 +0000
Message-ID: <20261124135630.1027716-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122085947.3107661-1-takano32@gmail.com>
References: <20261122085947.3107661-1-takano32@gmail.com>
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

With user_time or system_time as the leader, get_group_fd() hands the
procfs descriptor to the members and the kernel rejects each with EBADF.
With duration_time as the leader there is no descriptor, so the members get
-2 and fail with EINVAL, "broken group leader" appearing only in the debug
log.  Either way perf stat prints the tool event and "<not supported>" for
the rest of the group:

  $ perf stat -e '{user_time,cycles}' -- sleep 0.05
                   0      user_time
     <not supported>      cycles

With a kernel event as the leader the members do open, but the group read
comes up short: evsel__group_read_nr_members() counts the tool event, the
kernel has one entry fewer, and the read fails with ENOSPC, so the events
come out as "<not counted>".  That is the shape of
-e '{cycles,instructions,duration_time}', which has not been counted since
commit 6828d6929b76 ("perf evsel: Refactor tool events").

Counting such a group means moving the leader to a kernel event and
letting the group read skip the tool members; that is left to a separate
series.  Splitting the tool event out and warning, as
evlist__check_cpu_maps() does, would let the kernel events count, but the
tool event would lose the group's window and the warning is easy to miss
in a script.  The braces are the user's explicit request, so perf stat
should not quietly reinterpret them.  Ian's "perf pmu: Don't treat tool
PMU as a kernel software PMU for event grouping" splits it in the parser
and this check then has nothing to refuse; Hang's series opens the members
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
tool event is left to the weak group handling, which splits it when the
members fail with EINVAL or EBADF; any other weak group that mixes them is
refused like a strong one.  A member that fails with EACCES is not split
off, so such a group prints the tool event and "<not supported>" for the
member, as before; the libperf change posted to perf-tools-next keeps it
from being dereferenced when the group is enabled.

Where the core PMU covers only part of the CPUs (hybrid x86, big.LITTLE
arm64), evlist__check_cpu_maps() takes the tool event out first under -a,
so no mixed group is left to refuse.  Sashiko's review of v4 raised this
and the NULL dereference that the libperf change above prevents.

The code, the test, the man page and this message were written with
Hermes Agent (deepseek-v4.1-flash); I reviewed the result, built perf, and
ran tools/perf/tests/shell/stat+tool_group.sh and checkpatch.pl --strict.
Kernel events cannot be opened here (perf_event_paranoid=4), so the EBADF
and the group-read failure were not re-observed.

Fixes: 6828d6929b76 ("perf evsel: Refactor tool events")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/sashiko-outbox-227849@kernel.org/
Reported-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Link: https://lore.kernel.org/all/20261111-tool-pmu-leader-v2-1-3faa0fb98c51@gmail.com/
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/all/awC_aZXD5FBGu4mO@google.com/
Link: https://lore.kernel.org/all/20261111101625.2204836-1-takano32@gmail.com/
Link: https://lore.kernel.org/all/awTXdgY38s2bijW5@google.com/
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v5: Namhyung Kim confirmed on 2026-11-24
    (https://lore.kernel.org/all/awTXdgY38s2bijW5@google.com/)
    that the group should be rejected rather than counted event by event,
    so this keeps the refusal and drops the question from the message.

    The NULL fd dereference that the v4 review found is fixed by the libperf
    change posted to perf-tools-next
    (https://lore.kernel.org/all/20261111101625.2204836-1-takano32@gmail.com/),
    so this version carries no crash fix of its own and goes on top of it.
    It has its own Link entry now.

    Sashiko's review of v4 raised the NULL dereference and the -a case, so
    it is credited with Reported-by and a Link.

    A weak group led by any tool event is left to the weak group handling.
    get_group_fd() sets errno to EINVAL when the tool leader has no
    descriptor, so the open loop splits that group on EINVAL just as it
    splits a user_time leader on EBADF; before, the split depended on
    whatever errno happened to hold.  This also splits
    -e '{duration_time,cycles:k}:W' before the member with a closed fd is
    enabled, which measured clean here.  The BUG_ON() no longer fires for
    that case; it only did in a DEBUG=1 build.  The errno is set in the
    tool branch only, so a leader that was skipped for other reasons keeps
    its old behaviour.

    The -a case runs on every machine now and checks the result.  There are
    two probes: one for a per-thread event and one for -a, because CPU-wide
    events need root or perf_event_paranoid <= 0 and can fail even when a
    per-thread event works.  accepted() always fails on <not counted> and
    only skips on <not supported> when the events cannot be opened.  When
    -a counts but the probes say full access is not there, the case is
    reported as skipped instead of passing silently, and a refusal has to
    name the tool event and carry the hint.

    The group-read paragraph now says the read fails with ENOSPC before
    evsel__process_group_data() is reached.  Fixes: is at the top of the
    trailer block, the subject is the same as v4, and Hang's series is
    named instead of v3 because v2 already opens with group_fd = -1.

    Rebased onto v7.4-rc4.  The perf-tools-next branch fetched here is still
    at 2026-10-27 and does not carry tools/include/linux/stddef.h, so perf
    does not build there.

 tools/perf/Documentation/perf-stat.txt    |  14 ++
 tools/perf/builtin-stat.c                 |  71 ++++++++
 tools/perf/tests/shell/stat+tool_group.sh | 212 ++++++++++++++++++++++
 tools/perf/util/evsel.c                   |   9 +
 4 files changed, 306 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat+tool_group.sh

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 8ea17da89976..c5885cf331fa 100644
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
+	the weak group handling, which splits it when the members fail with
+	EINVAL or EBADF; any other weak group that mixes them is refused
+	like a strong group.
 
 -i::
 --no-inherit::
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 37752d6bfef4..f3d3343d1ef9 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2469,6 +2469,72 @@ static int parse_tpebs_mode(const struct option *opt, const char *str,
 }
 #endif // HAVE_ARCH_X86_64_SUPPORT
 
+/*
+ * A tool event like user_time has no event in the kernel: it reads
+ * /proc/stat, or keeps its value in perf itself.  A group that mixes one
+ * with an event the kernel opens cannot be counted.
+ * get_group_fd() passes the leader's descriptor as the group fd, and the
+ * tool event has a procfs descriptor or none at all, so the kernel rejects
+ * the members with EBADF or perf gives up with "broken group leader"; with
+ * a kernel event as the leader the members do open, but the group read is
+ * rejected as the kernel knows only the members it opened.  perf stat used
+ * to leave the rest of the group uncounted in both cases, when the CPU maps
+ * had not split the group first; refuse the group instead.  A group with no
+ * event the kernel opens is left alone, as perf reads each event in it.  A
+ * weak group led by a tool event is left to the weak group handling in the
+ * open loop, which splits it when a member fails with EINVAL or EBADF; any
+ * other weak group is refused like a strong one.
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
+		 * handling in the open loop: the members fail the open with
+		 * EBADF when the leader has a procfs descriptor, and with
+		 * EINVAL when it has none, and that is what splits the group.
+		 * Any other weak group does not get that far, so it is
+		 * refused like a strong group.
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
@@ -2947,6 +3013,11 @@ int cmd_stat(int argc, const char **argv)
 
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
index 000000000000..0d630a70f1b5
--- /dev/null
+++ b/tools/perf/tests/shell/stat+tool_group.sh
@@ -0,0 +1,212 @@
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
+# A tool event reads /proc/stat, or keeps its value in perf itself, so it
+# cannot be a member of a group that is opened with perf_event_open().  Such
+# a group used to print the tool event and leave the rest of the group
+# uncounted, so perf stat has to say what is wrong instead.
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
+# the tool event last, and a weak group led by a kernel event (it opens
+# and then fails its group read).
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
+# handling.
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
index d060fca8090f..ef811b1f1e6a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2381,6 +2381,15 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
 		return -1;
 
 	fd = FD(leader, cpu_map_idx, thread);
+	if (fd == -1 && evsel__is_tool(leader)) {
+		/*
+		 * A tool event has no perf_event_open() descriptor, so -1 is
+		 * normal for it and the members cannot be in the kernel group.
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

