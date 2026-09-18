Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2259352D2D6
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789766427; cv=none; b=H1pLyB64boFTnWVTavt0B/M43Dq96pNFGrwZ1CarhmlKdBdBcIEKmX6tJWdcWtvGNuii9+1tyrQ8L29PkMKsWBHhrNkinpP+qjckIG9DqT+ao24L0iO92hWM7OmqkO9sg9IP7vBaGjTNEFsuIgztbJpOskulouhHxRle/em4Rqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789766427; c=relaxed/simple;
	bh=js3MmCu39/cj46Xs9OQpjW7xXWJ5rM3UT+1/Hq5HO/4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s/EKEnyGRcp4N9Wh8QKsFZdx6WB+a8b8xGEom36CX6KBveaUMcUJylDOSKysqRvsRxQ/prN7DRlXUbiVKBuHMKvzF+uVzuYjvIcn3vNKczBZYaHq8vUpxjnQmU/cU8g+/lBZMmVHOsTSH6rB7dJzObrIhoX+xGXIKQAqmPESu5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ck6JLay6; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ck6JLay6"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39de4a68f7cso2048838a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789766421; x=1790371221; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p1wleqEAHJWzd5Fq3MOQlRkWIUYoY+UnMLT1UHUF+dc=;
        b=Ck6JLay6pXG1vlUFJv7h415OQq5Z4mjma7s/ZNBtus5hWgGh3RihOLFKHR+V4lNQ1z
         ps2+UPMeVu4RoSvrrxJOPDtBILWitotD24WoBcIlANMG8PWs3CaCRxjVvEHUiGybsCiN
         9BiDQlu+JjhO+L/hFTqZbjhYNM6fjaUjD7S9lhUk/BIZOc8ZG6wZWPeQgInAN8UPyE2/
         2sszLFtaduD1anAk2XrPzxrE9QOAyWKlqWY1JUF5HnZrRnrMrGiGwTSTLn19/JHvfT/q
         NGNDAMZdPXx+VjHozsGw0NNIJn03cWfyEBb/wBI9SmqdEa/zmoma4Q0eld4j2eBZhmp8
         4OqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789766421; x=1790371221;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p1wleqEAHJWzd5Fq3MOQlRkWIUYoY+UnMLT1UHUF+dc=;
        b=AzH0H1WYHxELIsYgy2zM+D4QM/fk7tk93eD+NfbPWdDeHZdpf54ldrdimw0tDywHnr
         A8RJerme+6ntZ9VQUdLSydqohlKy/mdNudpD2hjOWByC3UoBvd+PDNVfN6ndo6K7vQTw
         JxM3kz+jbvQD7DOy4fWuww3mgQ9VC/cggaeymbxxniSWqlL1llrO82AausS9uqgp0HmX
         voF6g8mzZgCtJ3lC1phKieLtIzGPi1do/pldo0sThwjEqhaukxC7xcABF2g3myjsW5CP
         10QxaIKSXOLHhY+okTr1VuGHA9xxmzkP30wknUb31Gdc6kjR+i1E36nWxZj1B0CGQGjX
         YU+g==
X-Forwarded-Encrypted: i=1; AKwUvBw9i/E6szSdhY0kgxEg4F8DVNSIfBFkUIyYSJsDOg9XIrzSVa2ztGOGFXoCH1FFDEHCDVaQ74rKxilT26GE2TI2@vger.kernel.org
X-Gm-Message-State: AFuF++mNuvim7xpF1DgBlWaX5IjWQ/9wTFcbgrpxij3q55r8jumfEVvg
	IMZOHvwsL4aLYchb/VNXvGrqktLnllvKVGB4uQY2n9+A0UqKiGdBcjZacLjV35CaLVx00+g6GaV
	l9B8ybvRP1A==
X-Received: from dlbsn6.prod.google.com ([2002:a05:7022:b906:b0:143:6c23:2cab])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5346:b0:39e:6c69:7779
 with SMTP id 98e67ed59e1d1-39e6c697a4fmr2208555a91.34.1789766420442; Fri, 18
 Sep 2026 14:20:20 -0700 (PDT)
Date: Fri, 18 Sep 2026 14:19:27 -0700
In-Reply-To: <20260918211932.2966061-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260918140659.2501976-1-irogers@google.com> <20260918211932.2966061-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918211932.2966061-14-irogers@google.com>
Subject: [PATCH v4 13/18] perf test probe_vfs_getname: Scope probe name to PID
 and make non-exclusive
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
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

Delete the probes from an exit trap as well as on the way out. A pid
scoped name is never seen again, so a run interrupted before
cleanup_probe_vfs_getname() would leave its probes behind for good,
accumulating a set per run. The fixed name at least meant the next run
found, and went on to reuse, whatever the last one left.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/tests/shell/lib/probe_vfs_getname.sh | 51 +++++++++++++++++--
 tools/perf/tests/shell/probe_vfs_getname.sh   |  3 +-
 .../shell/record+script_probe_vfs_getname.sh  | 18 +++++--
 .../tests/shell/trace+probe_vfs_getname.sh    |  9 ++++
 4 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 88cd0e26d5f6..4e915b6aefc8 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -1,15 +1,58 @@
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
 
+# Delete the probes however the test ends, not just when it runs to
+# completion. The name is scoped to the pid, so nothing that runs later
+# reuses or tidies up a probe an interrupted test left behind, and they
+# would accumulate one set per run. The fixed name used before was at least
+# picked up again by the next run.
+#
+# Tests may still call cleanup_probe_vfs_getname directly. Doing so leaves
+# nothing for probes_vfs_getname to find, so the trap below then does
+# nothing. A test needing cleanup of its own should call
+# cleanup_probe_vfs_getname from its own exit trap, since installing one
+# replaces this rather than adding to it.
+trap cleanup_probe_vfs_getname exit
+# Turn a signal into an ordinary exit so that the exit trap above runs. An
+# exit trap that returns leaves the exit status alone, so a test exiting 2
+# to skip still skips.
+trap 'exit 1' term int
+
 add_probe_vfs_getname() {
 	add_probe_verbose=$1
 	if [ $had_vfs_getname -eq 1 ] ; then
@@ -33,8 +76,8 @@ add_probe_vfs_getname() {
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

