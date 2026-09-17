Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A5B436BC9
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627388; cv=none; b=uqfFreZctOzRyRZQw7IzVrJvf9ZQmUd05yIn4w3nadd9buwShrSy5F63IWDhroWB6CS6+UDfw+GAdcN3RFfFGQuRPjRmBhWOCtOT+SPmBrI0Dsz3FMB60bKMz4rLVfhKIQm5RX1F2PKFFchzeI/PXWbapmQj4zRbLB+fT/GIq6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627388; c=relaxed/simple;
	bh=/npCTcaijC5/X5gCIcLm38hBGQVHZa7g3OeFrirv27o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t8aunqotT4oSe8bc0wg+LX19pdU6yTO79Q8ra+Ybt0WGC1rvRL1/z++59ASBKaejpZZZAYqf5VtVNKUqRYCwgbydlXA3r+CRKkMTKBY+wOcQml9WIulD+gxP4BRKRRpc2f2vVqIoLToqLAF9NaSw0DyUxO/A0uyIafs7lSk6vDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vic4k6Z6; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vic4k6Z6"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39aee9b4cf2so1111939a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789627383; x=1790232183; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+++jh0v+Oa7psRCZBUK/IJfrh8ZKmGANC2vEsQ4ZRpc=;
        b=Vic4k6Z6Yr9lvKrt2VDAQ17SeD4Gw3qG4hIOe6fekGNzrWNyyHJkkgdT/XJtMf7qg1
         JJiYyDTTgNdW6TtjW81dzU3NAIxMXZ57IC5YuEGMnWmeOagzeymqKNGFhWhmMzIh0W/b
         gsdw1mwo375xlRF40Je0xc6kD2YPtFK1FKzOtGvlOQsYerYzC39jnQJq56N4ivwRV3UE
         6gRhfQN3pLcB2sUssUxBdoL8idxlaWVdVMwk3BNcBDB5gDNyZvsd/TjvRpvtxU9+GuQy
         /5GMLjJOFYfmNnUA9JB9O6w+245lq2Yek/s2+vR/zG4DjlbyI6yiu/7sSgsRDkEx4EH1
         b8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627383; x=1790232183;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+++jh0v+Oa7psRCZBUK/IJfrh8ZKmGANC2vEsQ4ZRpc=;
        b=y2p9X98CqMGeFXIg3AUW2WwvCE5r6dGCP/rD8r2eV6aKwyRuaVZPaeE7CwCI83xivh
         vg8bByJXZgsr5/XhPkhsaG5CtE7M7Ov1rXodNYUYDfmbUnwm3PBfXtDLkTTZ8RcdtuYi
         834UwDrqMvkEY+Vzr9KkxOcg2XmEga8DBUiVFrwJa7InpHg2Jk7yz52+8sZctk0EV5xJ
         3yZAASW+nAU9A8N+2K+oJOtoeQhYc5DWSa0GZVlonCJUSb/yezYWn4BMrIUpopoI2Qd8
         4ZeIOfee7+zf3i2/EcqGTrFJAFOJz6rg4vZfoGJqqQf8upHdsG39fZ/U0eaLvztHq/16
         sTqg==
X-Forwarded-Encrypted: i=1; AKwUvByeotljQpeUzohW7jzT4CI1012qzq14dCyEMz87JQfNzeiNBIImqwOdrlamRV23doNpUX65hCNtphC1EGlIbGSk@vger.kernel.org
X-Gm-Message-State: AFuF++llrrGKZEFSMTd95wcwu4h/4bRR+OQRMT6QeTN2W/iTCOA6rboc
	myjcC6mxAi9BPPThoKQ5eTn6J3B/B7TE/lnisS6asvFHQFw/awEsL/5CC15a64/JdNbgSLQ+0cz
	01GE8ZAJMPg==
X-Received: from dlg13.prod.google.com ([2002:a05:7022:78d:b0:143:9146:e482])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3990:b0:398:8870:b58f
 with SMTP id adf61e73a8af0-3dd5f57c3a9mr15302756637.14.1789627382884; Wed, 16
 Sep 2026 23:43:02 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:42:30 -0700
In-Reply-To: <cover.1789626977.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789626977.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <c389c325df9dfbc4e8a69bec2da2be75d7ee9c4d.1789626978.git.irogers@google.com>
Subject: [PATCH v1 08/13] perf test probe_vfs_getname: Scope probe name to PID
 and make non-exclusive
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The probe name `vfs_getname` was hardcoded, causing collisions when
tests ran concurrently. Furthermore, `cleanup_probe_vfs_getname()` used
`perf probe -d probe:vfs_getname*`, deleting probes registered by other
parallel tests.

Scope the probe name to the pid, and rename it to `getname_flags_$$` so
that it no longer begins with "vfs_getname". perf trace calls
evlist__add_vfs_getname(), which opens every event matching a hardcoded
"probe:vfs_getname*" wildcard, so a perf trace run by any other test
would otherwise pin this probe and make `perf probe -d` fail with
-EBUSY. That also unblocks making the perf trace tests non-exclusive
later in this series.

Enumerate the probes to record and to delete from `perf probe -l`,
matching `^probe:${vfs_getname}(_[[:digit:]]+)?$` exactly, rather than
globbing on `${vfs_getname}*`. perf probe appends _1, _2, ... when
getname_flags is inlined at more than one call site, so the variants do
have to be matched, but since the name now ends in a pid a trailing
wildcard would also match the probes of a test whose pid merely starts
with this one's, e.g. 123 and 1234.

Remove the `(exclusive)` tag from probe_vfs_getname.sh and
record+script_probe_vfs_getname.sh so they run concurrently in pass 1.
trace+probe_vfs_getname.sh has to stay exclusive: it is the one test
that wants to be discovered by that wildcard, so it sets vfs_getname to
a "vfs_getname_$$" name before sourcing the library, and would then pin
its siblings' probes if it ran alongside them. A comment in the test
records this.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/tests/shell/lib/probe_vfs_getname.sh | 34 ++++++++++++++++---
 tools/perf/tests/shell/probe_vfs_getname.sh   |  3 +-
 .../shell/record+script_probe_vfs_getname.sh  | 18 +++++++---
 .../tests/shell/trace+probe_vfs_getname.sh    |  9 +++++
 4 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 88cd0e26d5f6..89a4b6fa5ea1 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -1,12 +1,38 @@
 #!/bin/bash
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
-perf probe -l 2>&1 | grep -q probe:vfs_getname
+# The name of the getname_flags probe added and removed below.
+#
+# It is scoped to the pid so that tests running in parallel do not collide,
+# and it deliberately does not start with "vfs_getname": perf trace calls
+# evlist__add_vfs_getname(), which opens everything matching the hardcoded
+# "probe:vfs_getname*" wildcard, so a perf trace running in another test would
+# otherwise pin this probe and make the 'perf probe -d' below fail with -EBUSY.
+#
+# trace+probe_vfs_getname.sh is the one test that does want to be found that
+# way, so it sets vfs_getname itself before sourcing this file, and is
+# (exclusive) as a result.
+: "${vfs_getname:=getname_flags_$$}"
+
+# Print the probes add_probe_vfs_getname() created. perf probe appends _1, _2,
+# ... when getname_flags is inlined at more than one call site, so there can be
+# several. Match them exactly rather than with a "${vfs_getname}*" glob: the
+# name ends in a pid, so such a glob would also match the probes of a test
+# whose pid merely starts with this one's, e.g. 123 and 1234.
+probes_vfs_getname() {
+	perf probe -l 2>/dev/null | awk '{print $1}' |
+		grep -E "^probe:${vfs_getname}(_[[:digit:]]+)?$"
+}
+
+[ -n "$(probes_vfs_getname)" ]
 had_vfs_getname=$?
 
 cleanup_probe_vfs_getname() {
 	if [ $had_vfs_getname -eq 1 ] ; then
-		perf probe -q -d probe:vfs_getname*
+		local probe
+		for probe in $(probes_vfs_getname); do
+			perf probe -q -d "$probe"
+		done
 	fi
 }
 
@@ -33,8 +59,8 @@ add_probe_vfs_getname() {
 			return 2
 		fi
 
-		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
-		perf probe $add_probe_verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || return 1
+		perf probe -q       "${vfs_getname}=getname_flags:${line} pathname=result->name:string" || \
+		perf probe $add_probe_verbose "${vfs_getname}=getname_flags:${line} pathname=filename:ustring" || return 1
 	fi
 }
 
diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index 5fe5682c28ce..05f1d50732b6 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -1,6 +1,5 @@
 #!/bin/bash
-# Add vfs_getname probe to get syscall args filenames (exclusive)
-
+# Add vfs_getname probe to get syscall args filenames
 # SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
index 002f7037f182..1d4fb4a4fbfe 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# Use vfs_getname probe to get syscall args filenames (exclusive)
+# Use vfs_getname probe to get syscall args filenames
 
 # Uses the 'perf test shell' library to add probe:vfs_getname to the system
 # then use it with 'perf record' using 'touch' to write to a temp file, then
@@ -17,22 +17,32 @@ skip_if_no_perf_probe || exit 2
 
 # shellcheck source=lib/probe_vfs_getname.sh
 . "$(dirname "$0")/lib/probe_vfs_getname.sh"
+# shellcheck disable=SC2154 # vfs_getname is assigned in lib/probe_vfs_getname.sh
 
 record_open_file() {
 	echo "Recording open file:"
 	# Check presence of libtraceevent support to run perf record
-	skip_no_probe_record_support "probe:vfs_getname*"
+	skip_no_probe_record_support
 	if [ $? -eq 2 ]; then
 		echo "WARN: Skipping test record_open_file. No libtraceevent support"
 		return 2
 	fi
-	perf record -o ${perfdata} -e probe:vfs_getname\* touch $file
+	# Record every probe the inlining of getname_flags produced, naming
+	# them exactly rather than with a "${vfs_getname}*" glob, which would
+	# also match the probes of a test whose pid starts with this one's.
+	local events
+	events=$(probes_vfs_getname | paste -sd, -)
+	if [ -z "${events}" ] ; then
+		echo "FAIL: no ${vfs_getname} probe to record"
+		return 1
+	fi
+	perf record -o ${perfdata} -e "${events}" touch $file
 }
 
 perf_script_filenames() {
 	echo "Looking at perf.data file for vfs_getname records for the file we touched:"
 	perf script -i ${perfdata} | \
-	grep -E " +touch +[0-9]+ +\[[0-9]+\] +[0-9]+\.[0-9]+: +probe:vfs_getname[_0-9]*: +\([[:xdigit:]]+\) +pathname=\"${file}\""
+	grep -E " +touch +[0-9]+ +\[[0-9]+\] +[0-9]+\.[0-9]+: +probe:${vfs_getname}(_[0-9]+)?: +\([[:xdigit:]]+\) +pathname=\"${file}\""
 }
 
 add_probe_vfs_getname
diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
index 7a0b1145d0cd..146305f4d549 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -10,6 +10,13 @@
 # SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
+# This test must stay exclusive, and is the only one of the probe tests that
+# does: it does not name the event it uses. perf trace discovers it with the
+# hardcoded "probe:vfs_getname*" wildcard in evlist__add_vfs_getname(), so the
+# probe has to carry that prefix, and a parallel run of this test would then
+# also match, and pin, the probes of the other tests. The sibling tests avoid
+# all of this by using a name that the wildcard cannot reach.
+
 # shellcheck source=lib/probe.sh
 . "$(dirname $0)"/lib/probe.sh
 
@@ -17,6 +24,8 @@ skip_if_no_perf_probe || exit 2
 skip_if_no_perf_trace || exit 2
 [ "$(id -u)" = 0 ] || exit 2
 
+# shellcheck disable=SC2034 # consumed by lib/probe_vfs_getname.sh
+vfs_getname="vfs_getname_$$"
 . "$(dirname $0)"/lib/probe_vfs_getname.sh
 
 trace_open_vfs_getname() {
-- 
2.55.0.1082.g2b9226bbc0-goog

