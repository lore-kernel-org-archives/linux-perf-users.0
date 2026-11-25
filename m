Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645653;
	b=HZ9GQSWmxn05avUBaRBPqgzUhmLiiTrn+n87k7jkpJ7wBlV8+F0lI5+crh3WsxH2LEnG
	 I4Sole+KcrIXVSvcRy6H5pRCmMAX2wfA6nPDL2hVmGylRFlN+zD52zwJmiCDrVaIlzhQU
	 b5hrJ5qnnj8706Zib2D4YNNeoRHl9K5BQ3eHCtM5Fxjzz9QuEjUSTdXYPu+R7tLNrKyl5
	 2GTmBWLCu5sV5eq3hIIEPUu8CtHBPHRTGt6323mt67UvANdCSNQlvpMStt9DAOGhyKeB2
	 XgNjRqU2KeFAoMQAsNKYe+IEzdjZXdfenrRdF4QgZnP080Nm1FrFkf3tuZThwjWhV6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DRnuMqFJjvegOsATh1tZxJBMDsNoWmNDpFi4sChApZk=;
	b=P3o1cEykanuxk8d0TMsRm27qjNG4c983FVXIKoUOnPPDez7qWs0HX0yETeeQjIBCODsR
	 wR1ssPu2/GjCUq7cM9rdfuKrByA7xrjvSCGglDs+9Fzi38ajZ6aLM2d3v1kG8kJEDinBe
	 QPmKCndiERX9gMpxHhNBqy03zVNuvD+8wR4XxnHLquko39gTlnIYOPLa/wZS0FyZ/JaL4
	 UQTIwToGBu3XdMCVggKTDn+Cp6yU3AkfZXNjoYFbksuFLsiMQYbfye3KcG25SRYnMH2yw
	 bTU+B/4qo0KBIRr1OcQvIV2dMGDYdXf0cbKZkvy7DixgCziJJ/OdK/kHq8kgBPSZEbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U5EbKiuH;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD58D606A32E
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 22:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD58D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U5EbKiuH
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1ae58d17cd9so6968663c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 14:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795645651; x=1796250451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DRnuMqFJjvegOsATh1tZxJBMDsNoWmNDpFi4sChApZk=;
        b=U5EbKiuHpuRy70OPiG/b5LuexJdnqe032SGF7pYkpRbvrtQdLWKtnwWE4PXybGGX8z
         SDgc8GJBn1HUERniX9xAStSep2Qxj0IUUOyrWPLEHO4JiTV1D5K2Ha2vm5HbLrAlVveg
         Kfb8isblwvzoTV+SVUqGzwocQxhIHJH7C8EA8khhFkhiqsEPdseEPJ5G4E6giz9HvFm2
         4MMjoh/d0LUgDPYJbUEZGrNLoHFSvEkhj3hxLsGq1znPIn1iMXhEL9P7rZ1GJgLpYRb2
         ptEa82dTKlJLxmb8k3G+joSVD61WtqkChT+hH64GQQZ+1bEdSCHpCyOa4rBIZuE1ASfH
         vokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645651; x=1796250451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DRnuMqFJjvegOsATh1tZxJBMDsNoWmNDpFi4sChApZk=;
        b=urF+RizRv4N42QYN1m2ieCsN33qwq02hxShFT91aFJyNtaXeTcuPbrXgXie29tdZUS
         jQoPuwAGMRKmtytKHykJp3t2As37DjUp+sRkgDZVMnS1lIaL6NwNl3nfxDVZCIXOWqJ6
         JkgHLDQxGESdAUH2UDk17brtiM+iaDXkWKexd+0twjpA9zju/rcRwuXgh2TPSq2QPiUm
         jBDzicS2VAu08f1JvdSW0FBwGwD4PLcLr2agMRcO8N3GFpl9EMAXIQAh+H0wfo7Eudks
         id84kQr0yhh76baBsdhFaZgf5Raxv1Z7zBMrAHGaKWLc/wlLI/88nakaXAqWfiEKb6rz
         UOwg==
X-Gm-Message-State: APuU4Z/e+MNZR0f8BmJEET9JnYKWAJRMtw1Y+Snew1fiFlgibW33JG3L
	ytzI89FoJFiZLQ9EApjh+o+EIGGSa4HL2TEEvAQ4tkDA/c8wDvUU6jBf9+CzkDtp
X-Gm-Gg: AZFdTZcXeyzqq/IuWo2xbef0jzk4Yn2bYdA7//UkvvYH/ArrxBkaMligldQnCDvDzxo
	/ijgAQZna0a1YeTVeALD6laCMCKHu/nQW6J5C7YJyms7o780RGyIQKnqoCj6mUvTfY9epftZBzH
	0+9AMHuIU41yT4WQXbcG5N56jOiAj0l3KgySQ8hNDTpkmwsJ/W9O50Eyn/JRMJ3IP2+yU5rlXtK
	4lTc3muenJ2Yaobw6dnLzQ06/10MNuzpOJYCOdsMsxjpw36cTWvENcx1tXNWmeLXriBnuLW3gl+
	6jlmtbm24q0ZocDZN6rsApIH3mR7jjhHE2c539tRAm6hcM/jjVFmBGzQm9Z/g5s5HOSzGDO5xMl
	5QqRMAQU+6rJh+CcBD/fTFk5yByfLDo4orktCYmW0N3mnDC9tQCfj8WR3zW7acwZBjtrQrCZFBa
	oe14l+sT8xqFqQkhMeZHvLZbGV9YNZtNCSLD9fxYG1gdQbli6bE9VWeLg95rxkuRn0LpGqC14Ni
	+VHRVuhVNKsW/sZVI8UnRE5FOZumErs3GCXZkhFvUKwrv+wVWMzUDqczloWxO2yN0Je0otCxK3Y
	PBe5AG+gncoZFXnGKHDi
X-Received: by 2002:a05:7022:f101:b0:1b5:4d40:e9ff with SMTP id a92af1059eb24-1b5568d7b42mr15723325c88.35.1795645650148;
        Wed, 25 Nov 2026 14:27:30 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556840494sm44953556c88.12.2026.11.25.14.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:27:29 -0800 (PST)
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
Subject: [PATCH v9] perf stat: Refuse a group mixing tool and kernel events
Date: Wed, 25 Nov 2026 22:27:25 +0000
Message-ID: <20261125222725.2554455-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125175450.2373258-1-takano32@gmail.com>
References: <20261125175450.2373258-1-takano32@gmail.com>
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
leader" appearing only in the debug log.  A DEBUG=1 build asserted in the
BUG_ON(fd == -1 && leader->supported) below first, and the early returns
above now make that BUG_ON unreachable on these paths.  Either way perf
stat printed the tool event and "<not supported>" for the rest of the
group:

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
the refusal to counting the events one by one.  A leader whose fd array is
NULL is no longer a bug: BUG_ON(!leader->core.fd) is gone, and a leader
that has no perf_event_open() descriptor, such as a tool event, a hwmon or
drm event, or a retire-latency event, returns -2 before the array is read.

A group of tool events only is accepted, as before.  A weak group led by a
tool event is left to the weak group handling, which splits it in the open
loop: get_group_fd() reports that no kernel group can hang off a tool
event, and the loop splits on EINVAL before any member is enabled.  Any
other weak group that mixes them is refused like a strong one.

The check itself asked evsel__is_tool() only, so an hwmon or drm event
went through.  Those PMUs are not opened with perf_event_open() either:
hwmon reads a sysfs file and drm reads /proc/<pid>/fdinfo, so the group
fails the same two ways.  The parser does not split
-e '{cpu-clock,hwmon_x}' because the software side adopts the other PMU's
name, and with the hwmon event as the leader get_group_fd() returns -2,
leaving the members "<not supported>"; with cpu-clock as the leader the
members open, the kernel fills one entry fewer than
leader->core.nr_members, and the rest comes out as "<not counted>".  The
check now uses the same predicate as get_group_fd(),
evsel__is_non_perf_event_open_pmu(), and says which kind of event it
found, so the message is not a lie for hwmon or drm.

Sashiko's review of v5 found that the split was skipped for a leader that
is a tool event but still has an fd.  user_time and system_time do have
one, a procfs descriptor, so fd == -1 was false and that descriptor was
handed to perf_event_open() as group_fd.  Under -a with
perf_event_paranoid > 1 the member cycles:k failed with EACCES, which is
not a split condition, so it stayed in the group while its fd array was
freed; enabling the group then dereferenced NULL:

  $ perf stat -a -e '{user_time,cycles:k}:W' -- true
  Segmentation fault

get_group_fd() now returns -2 for any leader perf does not open with
perf_event_open(), with or without an fd: a tool event keeps a procfs one
or none, hwmon keeps a sysfs one, drm keeps none, and none of them can be a
group_fd for the members.  The same change gives every -2 it returns an
errno, so a weak group whose leader was skipped is split as well, rather
than keep members that then have no fd to enable.

Where the core PMU covers only part of the CPUs (hybrid x86, big.LITTLE
arm64), evlist__check_cpu_maps() takes the tool event out first under -a,
so no mixed group is left to refuse.  Sashiko's review of v4 had already
raised this, together with the NULL dereference that the get_group_fd()
change above prevents.

The test no longer requires cycles to be printed when no hardware cycles
event can be counted: the evsel falls back to task-clock or is renamed,
and the group output is still checked.  A weak group led by a tool event
under -a is now run as well, so the crash above stays fixed.

Sashiko's review of v6 found that a weak group led by a tool event is not
split when the member that keeps no descriptor is a retire-latency event:
evsel__open_cpu() returns from evsel__tpebs_open() without a descriptor and
without asking for the group fd, so the member keeps core.fd == NULL and
stays in the group.  Enabling the leader walked into it, and so did
disabling it, which -a and -p always do around the workload:
evsel__enable_cpu() and evsel__disable_cpu() now skip a member whose fd
array is NULL, and the guard is on evsel__enable() and evsel__disable() too
so that the next caller of those does not have to rediscover it.

get_group_fd() returns -2 for a retire-latency leader as it does for a tool
leader, instead of reading the NULL fd array.

The test's "<not counted>" check was too strict on a hybrid machine: an
unqualified cycles expands into one evsel per core PMU, a per-task run uses
one core type only, and the other PMU prints "<not counted>".  The test now
skips a group that counted at least one event and fails one that counted
nothing, which is the regression it is for.  The retire-latency case runs
under -a, without which the workload starts with enable_on_exec and the
group is never enabled or disabled here.

The code, the test, the man page and this message were written with
Hermes Agent (deepseek-v4.1-flash); I reviewed the result, built perf, and
ran tools/perf/tests/shell/stat+tool_group.sh and checkpatch.pl --strict.
The -a segmentation fault above was reproduced here before the guard;
with the guard the command exits 0 and prints <not supported> for cycles:k.
The EBADF and the group-read failure were not re-observed: kernel events
cannot be opened here (perf_event_paranoid=4).  The hybrid skip was
not exercised: this machine is not hybrid.  The retire-latency group runs
here without crashing, but this machine has no PMU that reports retire
latency, so the member is read as zero rather than measured.  The hwmon
and drm paths were read, not run: this machine has neither PMU, and the
test covers tool events only.

Fixes: 6828d6929b76 ("perf evsel: Refactor tool events")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/sashiko-outbox-227849@kernel.org/
Link: https://lore.kernel.org/all/sashiko-outbox-231330@kernel.org/
Link: https://lore.kernel.org/all/sashiko-outbox-232396@kernel.org/
Cc: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Link: https://lore.kernel.org/all/20261111-tool-pmu-leader-v2-1-3faa0fb98c51@gmail.com/
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/all/awC_aZXD5FBGu4mO@google.com/
Link: https://lore.kernel.org/all/awTXdgY38s2bijW5@google.com/
Cc: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/all/20261123071913.653315-7-irogers@google.com/
Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>
---
v9: Sashiko showed that the hwmon case could never run.  perf builds
    hwmon PMUs in userspace from /sys/class/hwmon, so
    /sys/bus/event_source/devices/hwmon_* does not exist and the case was
    skipped everywhere; and even a PMU found that way is not selectable
    by its bare name, so the group failed in the parser rather than in
    check_unopened_in_group().  The test now covers tool events only,
    and the message says so instead of claiming the hwmon case runs
    where a PMU is present.

    The hwmon and drm paths are still read, not run: this machine has
    neither PMU.

 tools/perf/Documentation/perf-stat.txt    |  19 ++
 tools/perf/builtin-stat.c                 |  76 ++++++
 tools/perf/tests/shell/stat+tool_group.sh | 305 ++++++++++++++++++++++
 tools/perf/util/evsel.c                   | 104 +++++++-
 4 files changed, 490 insertions(+), 14 deletions(-)
 create mode 100755 tools/perf/tests/shell/stat+tool_group.sh

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 8ea17da89976..02de7a91d846 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -65,6 +65,25 @@ report::
 	Multiple PMU instances are typical for uncore PMUs, so the prefix
 	'uncore_' is also ignored when performing this match.
 
+	Tool events such as duration_time and user_time are read by perf
+	itself and have no event in the kernel; an hwmon event reads a
+	sysfs file and a drm event reads /proc/<pid>/fdinfo.  None of
+	them is opened with perf_event_open.  A group of such an event
+	and an event from a different software PMU, such as cpu-clock,
+	is split by the parser, which warns that events were regrouped;
+	-a and -C split a group whose members do not share the CPUs of
+	the leader in the same way.  A group that is not split and mixes
+	such an event with an event the kernel opens is refused, as in
+	-e '{user_time,cycles}', instead of printing the event and
+	leaving the rest of the group uncounted.  Put it outside the
+	braces instead, as in -e '{cycles,instructions},duration_time'.
+	A group of tool events only is accepted.  A weak group (:W) led
+	by such an event is left to the weak group handling, which
+	splits it when a member fails to open with EINVAL or EBADF; a
+	member perf stat does not open itself, such as a retire-latency
+	event, keeps no descriptor and is skipped when the group is
+	enabled or disabled.  Any other weak group that mixes them is
+	refused like a strong group.
 
 -i::
 --no-inherit::
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 37752d6bfef4..4fa3958c4cf3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2469,6 +2469,77 @@ static int parse_tpebs_mode(const struct option *opt, const char *str,
 }
 #endif // HAVE_ARCH_X86_64_SUPPORT
 
+/*
+ * An event perf does not open with perf_event_open has no event in the
+ * kernel: a tool event like user_time is read from a file such as
+ * /proc/stat or computed in perf itself, hwmon reads a sysfs file, and
+ * drm reads /proc/<pid>/fdinfo.  A group that mixes one with an event
+ * the kernel opens cannot be counted.  get_group_fd() has no group fd to
+ * hand to the members when the leader is such an event, so the members
+ * cannot be in a kernel group with it; with a kernel event as the leader
+ * the members do open, but the group read is rejected as the kernel
+ * knows only the members it opened.  perf stat used to leave the rest of
+ * the group uncounted in both cases, when the CPU maps had not split the
+ * group first; refuse the group instead.  A group with no event the
+ * kernel opens is left alone, as perf reads each event in it.  A weak
+ * group led by such an event is left to the weak group handling in the
+ * open loop, which splits it when a member fails to open; any other weak
+ * group is refused like a strong one.
+ */
+static int check_unopened_in_group(struct evlist *evlist)
+{
+	struct evsel *leader, *evsel;
+
+	evlist__for_each_entry(evlist, leader) {
+		struct evsel *unopened = NULL;
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
+			if (evsel__is_non_perf_event_open_pmu(evsel)) {
+				if (!unopened)
+					unopened = evsel;
+			} else {
+				has_kernel = true;
+			}
+			weak |= evsel->weak_group;
+		}
+
+		if (!unopened || !has_kernel)
+			continue;
+
+		/*
+		 * A weak group led by an event perf does not open is left to
+		 * the weak group handling in the open loop: get_group_fd()
+		 * returns -2 for such a leader, the open fails with EINVAL,
+		 * and that is what splits the group.  Any other weak group
+		 * does not get that far, so it is refused like a strong one.
+		 */
+		if (weak && evsel__is_non_perf_event_open_pmu(leader))
+			continue;
+
+		if (evsel__is_tool(unopened)) {
+			pr_err("A tool event cannot be grouped with kernel events: %s\n",
+			       evsel__name(unopened));
+		} else {
+			pr_err("An event perf does not open cannot be grouped with kernel events: %s\n",
+			       evsel__name(unopened));
+		}
+		pr_err("Put it outside the braces, as in -e '{cycles,instructions},duration_time'.\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 int cmd_stat(int argc, const char **argv)
 {
 	struct opt_aggr_mode opt_mode = {};
@@ -2947,6 +3018,11 @@ int cmd_stat(int argc, const char **argv)
 
 	evlist__check_cpu_maps(evsel_list);
 
+	if (check_unopened_in_group(evsel_list)) {
+		status = -EINVAL;
+		goto out;
+	}
+
 	/*
 	 * Initialize thread_map with comm names,
 	 * so we could print it out on output.
diff --git a/tools/perf/tests/shell/stat+tool_group.sh b/tools/perf/tests/shell/stat+tool_group.sh
new file mode 100755
index 000000000000..453570e416a8
--- /dev/null
+++ b/tools/perf/tests/shell/stat+tool_group.sh
@@ -0,0 +1,305 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# perf stat tool events in an event group (no_mlock)
+
+set -e
+export LC_ALL=C
+
+out=
+stderr=
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
+out=$(mktemp /tmp/__perf_test.stat_tool_group.XXXXXX)
+stderr=$(mktemp /tmp/__perf_test.stat_tool_group.XXXXXX)
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
+  if ! grep -qE "cannot be grouped with kernel events: (${tool})" \
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
+      cycles|cycles:*|instructions|instructions:*)
+        [ "${kernel_events}" = 0 ] && continue ;;
+    esac
+    if ! grep -q -- "${name}" "${out}"; then
+      echo "perf stat did not print ${name}  [Failed]"
+      cat "${out}"
+      err=1
+    fi
+  done
+  if grep -q "<not supported>" "${out}"; then
+    if [ "${kernel_events}" = 1 ]; then
+      echo "perf stat could not open an event in ${group}  [Failed]"
+      cat "${out}"
+      err=1
+    else
+      paranoid=$(cat /proc/sys/kernel/perf_event_paranoid 2>/dev/null || echo unknown)
+      echo "perf stat could not open an event in ${group} (paranoid=${paranoid})  [Skipped]"
+      skipped=$((skipped + 1))
+    fi
+  elif grep -q "<not counted>" "${out}"; then
+    # A hybrid machine counts only the core type the task ran on, so an
+    # unqualified cycles or instructions has one uncounted copy next to a
+    # counted one.  That is the machine, not the group.  A group that
+    # counted nothing at all is the regression this test is for, so count
+    # only the numbered lines that are not the footer or a tool event.
+    if [ "${kernel_events}" = 1 ] &&
+       awk '$1 ~ /^[0-9][0-9,.]*$/ && $2 != "seconds" &&
+	    $2 !~ /^(user_time|system_time|duration_time)/ { found = 1 }
+	    END { exit !found }' "${out}"; then
+      echo "perf stat counted only one core type of ${group}  [Skipped]"
+      skipped=$((skipped + 1))
+    else
+      echo "perf stat did not count an event in ${group}  [Failed]"
+      cat "${out}"
+      err=1
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
+# The leader is the event perf stat does not open: a retire-latency leader
+# keeps no fd array at all, and a strong group is refused before the open.
+# On x86 the parser sorts the retire-latency event after the leader, so the
+# case there checks that it counts as a kernel event either way.
+refused '{cycles:R,user_time}' user_time
+refused '{user_time,cycles:R}' user_time
+
+# -p keeps the any-CPU map of the plain case, but without enable_on_exec perf
+# stat enables and disables the group itself, so the refusal has to come
+# before the open.
+refused '{user_time,cycles}' user_time -p $$
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
+    # -a opens every evsel on the CPUs of its own PMU, so a hybrid machine
+    # does not leave a copy uncounted here the way a per-task run does.
+    if grep -q "<not supported>" "${out}"; then
+      echo "perf stat could not open an event on -a  [Failed]"
+      cat "${out}"
+      err=1
+    elif grep -q "<not counted>" "${out}"; then
+      echo "perf stat left an event uncounted on -a  [Failed]"
+      cat "${out}"
+      err=1
+    elif ! grep -q -- "user_time" "${out}"; then
+      echo "perf stat dropped user_time from -a  [Failed]"
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
+# A retire-latency event is read by the TPEBS reader rather than opened with
+# perf_event_open(), so it keeps no descriptor even while it is a member of
+# the group.  A weak group led by a tool event is not split when such a
+# member fails to open, so the member stays in the group, and enabling or
+# disabling the group used to walk to it and dereference the NULL
+# descriptor.  -a and -p walk the group around the workload; a workload
+# that starts with enable_on_exec does not, so this case needs -a.  Only a
+# crash counts as a failure: the event needs a PMU that reports retire
+# latency, and the run is otherwise free to succeed or to be refused.
+rc=0
+perf stat -a -e '{user_time,cycles:R}:W' -o "${out}" -- true \
+  2> "${stderr}" || rc=$?
+if [ "${rc}" -ge 128 ]; then
+  echo "perf stat crashed on a retire-latency member in a tool group  [Failed]"
+  cat "${stderr}"
+  err=1
+elif [ "${rc}" -eq 0 ]; then
+  if ! grep -q -- "user_time" "${out}"; then
+    echo "perf stat dropped user_time from a retire-latency tool group  [Failed]"
+    cat "${out}"
+    err=1
+  elif ! awk '$1 ~ /^[0-9][0-9,.]*$/ && $1 + 0 > 0 && $2 ~ /^cycles:R$/ { found = 1 }
+	      END { exit !found }' "${out}"; then
+    echo "perf stat read no retire latency here  [Skipped]"
+    skipped=$((skipped + 1))
+  fi
+fi
+
+accepted '{user_time,system_time}' user_time system_time
+accepted '{duration_time,user_time}' duration_time user_time
+accepted '{user_time}' user_time
+accepted '{cycles,instructions},duration_time' duration_time cycles instructions
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
index d060fca8090f..86ce9c1e7bc3 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1922,7 +1922,22 @@ int evsel__enable_cpu(struct evsel *evsel, int cpu_map_idx)
 				 * group leader. We must manually enable them in
 				 * userspace.
 				 */
-				int mem_err = evsel__enable_cpu(member, cpu_map_idx);
+				int mem_err;
+
+				/*
+				 * A member the kernel never opened keeps no
+				 * descriptor, and one whose open failed has
+				 * had it freed.  A weak group led by a tool
+				 * event is not split when such a member
+				 * fails, so it is still in the group here:
+				 * there is nothing to enable for it, and
+				 * passing its NULL descriptor to the ioctl
+				 * would dereference it.
+				 */
+				if (!member->core.fd)
+					continue;
+
+				mem_err = evsel__enable_cpu(member, cpu_map_idx);
 
 				if (mem_err)
 					return mem_err;
@@ -1957,10 +1972,20 @@ int evsel__enable(struct evsel *evsel)
 				 * group leader. We must manually enable them in
 				 * userspace.
 				 */
-				int mem_err = evsel__enable(member);
+				int mem_err;
 
-				if (mem_err)
-					return mem_err;
+				/*
+				 * A member with no descriptor was never
+				 * opened, or its open failed and freed
+				 * one.  It has nothing to enable, and its
+				 * flag is updated with the rest below.
+				 */
+				if (member->core.fd) {
+					mem_err = evsel__enable(member);
+
+					if (mem_err)
+						return mem_err;
+				}
 			}
 			member->disabled = false;
 		}
@@ -1991,7 +2016,19 @@ int evsel__disable_cpu(struct evsel *evsel, int cpu_map_idx)
 				 * kernel when disabling the group leader. We must
 				 * manually disable them in userspace.
 				 */
-				int mem_err = evsel__disable_cpu(member, cpu_map_idx);
+				int mem_err;
+
+				/*
+				 * A member with no descriptor was never
+				 * opened, or its open failed and freed
+				 * one.  A weak group led by a tool event
+				 * keeps such a member, so there is
+				 * nothing to disable for it here.
+				 */
+				if (!member->core.fd)
+					continue;
+
+				mem_err = evsel__disable_cpu(member, cpu_map_idx);
 
 				if (mem_err)
 					return mem_err;
@@ -2031,10 +2068,20 @@ int evsel__disable(struct evsel *evsel)
 				 * kernel when disabling the group leader. We must
 				 * manually disable them in userspace.
 				 */
-				int mem_err = evsel__disable(member);
+				int mem_err;
 
-				if (mem_err)
-					return mem_err;
+				/*
+				 * A member with no descriptor was never
+				 * opened, or its open failed and freed
+				 * one.  It has nothing to disable, and its
+				 * flag is updated with the rest below.
+				 */
+				if (member->core.fd) {
+					mem_err = evsel__disable(member);
+
+					if (mem_err)
+						return mem_err;
+				}
 			}
 			member->disabled = true;
 		}
@@ -2371,23 +2418,52 @@ static int get_group_fd(struct evsel *evsel, int cpu_map_idx, int thread)
 		return -1;
 
 	/*
-	 * Leader must be already processed/open,
-	 * if not it's a bug.
+	 * Leader must already be processed/open, unless it is one of the
+	 * events perf reads itself: a tool event keeps a procfs descriptor
+	 * or none, and a retire-latency event keeps none.  Both are refused
+	 * below rather than treated as a bug.
 	 */
-	BUG_ON(!leader->core.fd);
-
 	cpu_map_idx = evsel__hybrid_group_cpu_map_idx(evsel, cpu_map_idx);
 	if (cpu_map_idx == -1)
 		return -1;
 
+	if (evsel__is_non_perf_event_open_pmu(leader)) {
+		/*
+		 * A tool event has no perf_event_open() descriptor, or has
+		 * only a procfs one (user_time, system_time); hwmon keeps a
+		 * sysfs one and drm keeps none.  None of them can be a group
+		 * fd for the members.  builtin-stat.c decides on the weak
+		 * group split from errno.
+		 */
+		errno = EINVAL;
+		return -2;
+	}
+	if (!leader->core.fd) {
+		/*
+		 * A leader that was never opened, or whose open freed its
+		 * descriptor, has no group fd to hand out.  A retire-latency
+		 * leader is read by the TPEBS reader rather than opened, and
+		 * a weak group keeps it, so report it the way the open loop
+		 * expects instead of reading the NULL array.
+		 */
+		errno = EINVAL;
+		return -2;
+	}
+
 	fd = FD(leader, cpu_map_idx, thread);
 	BUG_ON(fd == -1 && leader->supported);
 
 	/*
 	 * When the leader has been skipped, return -2 to distinguish from no
-	 * group leader case.
+	 * group leader case.  Set errno the same way the two refusals above
+	 * do, so that the open loop splits the weak group for either.
 	 */
-	return fd == -1 ? -2 : fd;
+	if (fd == -1) {
+		errno = EINVAL;
+		return -2;
+	}
+
+	return fd;
 }
 
 static void evsel__remove_fd(struct evsel *pos, int nr_cpus, int nr_threads, int thread_idx)

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.53.0

