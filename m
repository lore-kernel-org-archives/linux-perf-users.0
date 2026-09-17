Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802BE5383CC
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663185; cv=none; b=i6QkKpkrBabNTsI+lhsx9903XY4Td9v13ZYpWP1tX8+eVDhnj+Mqts4sX/erQq3Fnd9Z0kQXIFHLMLQ94Fh4o2nXqb6U9/FIvSJW5LLN6aDNj3ggpDBm5eoOwNkU7KyUXuV3Ot+h12IZrtAQNaqpwVjKqyzyHqCiOoA/fwAbdKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663185; c=relaxed/simple;
	bh=/npCTcaijC5/X5gCIcLm38hBGQVHZa7g3OeFrirv27o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q63svzKTdkxAZ94wL5BZC2TufzCnZTVGtmeIPxB0kEW1s64H/OjlF7lLO/YwdaGQwuIwKco0E1taJsg9hjYMMdoeb4hdDWudRsXXCcR1D0Ync+e5JjCl67436e0+Z6ejP4oUGeMhneAbNoFrMO7FW8ldfnGwWGk6igkvTcSfTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pkt2+GWo; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pkt2+GWo"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso1423315a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789663182; x=1790267982; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+++jh0v+Oa7psRCZBUK/IJfrh8ZKmGANC2vEsQ4ZRpc=;
        b=Pkt2+GWoWHyOxE2gF0QvoOouRIiKlHJDoa6ofvWubis4fn4YXyp1THPz6qtHF+Vrk8
         R7//ZW9oFmtMy5tJWdHaxBaEbc4HLaM8Vug1/Vm4EMZ0ohhHC8CCIemK+X3BalVfQB5G
         We7i/zPSUOz9ehGo7XFMt/qptKLZRD7/0gvOHK7ZIWdkQaAFJIH1DGttaR47XcbduoQX
         wig5vNuvCWRmdStN2nJHP6q6JKE/0jvfpDAlibXuY0z5KSKTweeaJTveLM9dD4wIkEyu
         No+I7JykP+b3+Uf7n5qELYPS4TkzoXoZ111oZyUjnYVGzfG4u+Xeiz/Ytr2I8w6mKCty
         KRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663182; x=1790267982;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+++jh0v+Oa7psRCZBUK/IJfrh8ZKmGANC2vEsQ4ZRpc=;
        b=q7EXl6f2xl3hc7PV3odrVPAaklRTZ+S0/4CaXiAZy7uX3KyVD32zE60ch9tNHzvMAs
         +9STi+UGnCRDdT5ohPVyWYqw/mVQwJvvUwdR0v0Er2SySoWNwKc7rkhiQqLDtYzcsmye
         J3tycMSip049dvzeXmD/26Q/L1LJsL7v1QU0+KfCGJJ7kvial0qdGiLJhva/nq2UjMZp
         CrsDUCRDrDhNKO1RKKkVLlqt8LF/M37yoD9lZ+4a7PohTlYnzbp4ol7BsHlNSyR3Ran5
         w9dvRusLdvsc8ee9v7cLK+aDfdmS5ZmO+pZ4Ot4ewvpx4Zb8WQqEfVA0vM4b0SD86wwb
         ay0Q==
X-Forwarded-Encrypted: i=1; AKwUvBy1PdQPg96fb233rcBrODJHnLrxAsCjHmYkoaeguuIkNhgC+4YrTKYPKcK3sYZixVOncorh6FctXMdEcLWbPc/g@vger.kernel.org
X-Gm-Message-State: AFuF++nrhF72iV9OUNVDGikzx1DqUxr0/4CBpubnurQ+zKkFitCKyQ+9
	QUGWhBZ0G6ERNCrf6EtSDPx9MJV2tDQY/6toESWMdR+rW12pIF/NbmIqx3KMWAu3qLdOVMoyuRg
	ujzCVb3kXXg==
X-Received: from dlaj2.prod.google.com ([2002:a05:701b:2802:b0:143:966c:32eb])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:48cd:b0:39e:2ea1:e2a9
 with SMTP id 98e67ed59e1d1-39e2ea1e2b7mr11976493a91.8.1789663181748; Thu, 17
 Sep 2026 09:39:41 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:38:57 -0700
In-Reply-To: <cover.1789662556.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <429c3fbad8f697a85d27ec976ff2bf88a5d17087.1789662556.git.irogers@google.com>
Subject: [PATCH v2 09/14] perf test probe_vfs_getname: Scope probe name to PID
 and make non-exclusive
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
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

