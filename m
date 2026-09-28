Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074E939C63E
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620021; cv=none; b=f9z/WopWOV5ngG+BT/EhQiEAPHJsRNelOL8dIvIZxJkzEyJQBhyUNnd25zvwycEDXDWtdIqR0H0kGbXk2V1toPH6MERQU946nQ9oV4zfsgPQx85g3iZTmdPQpTAz5qrIbuUZdgqhl0UiCH4MEw2oHfSvJFXLQHn6N3TTuAVjcUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620021; c=relaxed/simple;
	bh=Iq83VSy+OQapYoEQ0TtGDOjJxioYnfzBx0Kzv/7Axck=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nrjw7EyyrYIF1WayD2su38XcU2QiH1LZSQNYtlDWFFMOAoUZ8uIosD9zyXZ95cjZIkJtSwLeSWSa5ZpVypyH6VKZorucV9FNQelH/qLGetA6UezrHon3EKRzhtk0wD29LOk/n5oP3kZPTlF8vWxEjQIMbPbR5KYrswcyHDt1oOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vnoz62lA; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vnoz62lA"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-313d1015161so11558501eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790620019; x=1791224819; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8ciA1x+9O0b1rSzgdiYZqyc++5iHHSnk4az39TXa9sk=;
        b=Vnoz62lAFGacIiIZW9fnog/Z0NOwSIdAP6d/EcWe5agJWUxmi8FGSct5r2W+fSrYyW
         G69Do7bkGVMSdBhJuVkg1Gh7fhsSyi9NzsAOlqmJQnPafAtzvVLhKdEeJPy5jYtmsH2/
         dXZGJ/3k0lCE4uiX3b3sjEQPdh0RBkqK67cx8ZCC5LLYzOWPS/MOajKBV+M9sZHx39tc
         +o2DRp+S5+Ei08qUATNfYlT+pmRBfLDZ70/N86iqFilGLOmh5blkft212AU+GGhB/1lg
         F4+VKYZSudTPr7tRlOTpM1FyDLKutTLcbWtN/XRpt2kc2DobNGXgeM6b1ZC47PSm1wUb
         dMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620019; x=1791224819;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ciA1x+9O0b1rSzgdiYZqyc++5iHHSnk4az39TXa9sk=;
        b=yKWTh+Iv5fIoWPS72huB6AgvMtGL+EYJWDV0Bz6JqS5FfVwPOX+n0zEHd6Mss3rkl+
         11svKikWirsFAPfJt/z03j3eA2b/SYnKVMBFHUjLKCQbSbTBrzZf0KJs3YQcGspfIT0/
         iVHWAj/LWfOKGM48abHiYiR7PYZaTciqnVmZ2Bv7lvdDJp/Lf7n0J4wjglNESkpBpKc0
         fQqiJBg7W2QI5IB0FsydILSz0wr4tEfYYzLeUuYFGeKIor3SpMXrexG4NDScBVvcjOZ4
         lU1cpNjddGh2OO2emEVTWMfCLLVYbphPh9zjTUuQoz6gnw1hZmO8aqyUEtP0wOg4dr9I
         pmCA==
X-Forwarded-Encrypted: i=1; AKwUvByYzdlZJqTbEH8adoihPS4m0tT0ep+Q20efmi+cII4PTh6eiM7HvfmclnVSAR5sOFrVDveB73DkPFtggLY+vhHj@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4PpN1qhEZqMaIMaUUNVWOogE5NhSvvDBV1v38U73wuy8TfAmE
	zGefoxkWotidfwGPfR50p4AUKtiKLkPmqLjlK0E6rxdEEB1MvWx1Fj9TUnVlqimZoXtH3O3Mohv
	WcKMjDIC+0w==
X-Received: from dybdw10.prod.google.com ([2002:a05:7300:b90a:b0:33e:6144:b80b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2324:b0:341:49cd:6815
 with SMTP id 5a478bee46e88-342709b5850mr10120417eec.18.1790620018639; Mon, 28
 Sep 2026 11:26:58 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:26:00 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-22-irogers@google.com>
Subject: [PATCH v6 21/26] perf test probe_vfs_getname: Scope probe name to PID
 and make non-exclusive
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The fixed vfs_getname probe name collides between parallel tests, and the
cleanup deletes every probe:vfs_getname* probe. Name the probe
getname_flags_$$, match it exactly, and remove it from an exit trap. Not
starting with vfs_getname also stops perf trace, which opens every
probe:vfs_getname* event, from pinning it.

Remove the exclusive tag from probe_vfs_getname.sh and
record+script_probe_vfs_getname.sh. trace+probe_vfs_getname.sh needs perf
trace to find its probe, so it uses vfs_getname_$$ and stays exclusive.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/tests/shell/lib/probe_vfs_getname.sh | 25 ++++++++++++++++---
 tools/perf/tests/shell/probe_vfs_getname.sh   |  3 +--
 .../shell/record+script_probe_vfs_getname.sh  | 16 +++++++++---
 .../tests/shell/trace+probe_vfs_getname.sh    |  5 ++++
 4 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index a4230a83bcae..57a59ae7d4ae 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -1,15 +1,32 @@
 #!/bin/bash
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
-perf probe -l 2>&1 | grep -q probe:vfs_getname
+# Scoped to the pid for parallel runs, and not "vfs_getname*" so that perf
+# trace's probe:vfs_getname* wildcard doesn't open, and so pin, the probe.
+: "${vfs_getname:=getname_flags_$$}"
+
+# The probes added, including _1, _2... for inlined copies of getname_flags.
+probes_vfs_getname() {
+	perf probe -l 2>/dev/null | awk '{print $1}' |
+		grep -E "^probe:${vfs_getname}(_[[:digit:]]+)?$"
+}
+
+probes_vfs_getname > /dev/null
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
 
+# A pid scoped probe is never reused, so remove it however the test exits.
+trap cleanup_probe_vfs_getname exit
+trap 'exit 1' term int
+
 add_probe_vfs_getname() {
 	add_probe_verbose=$1
 	if [ $had_vfs_getname -eq 1 ] ; then
@@ -41,8 +58,8 @@ add_probe_vfs_getname() {
 			return 2
 		fi
 
-		perf probe -q       "vfs_getname=${func}:${line} pathname=result->name:string" || \
-		perf probe $add_probe_verbose "vfs_getname=${func}:${line} pathname=filename:ustring" || return 1
+		perf probe -q       "${vfs_getname}=${func}:${line} pathname=result->name:string" || \
+		perf probe $add_probe_verbose "${vfs_getname}=${func}:${line} pathname=filename:ustring" || return 1
 	fi
 }
 
diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index 36dc319eea0e..c40e5f3f0825 100755
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
index ce20663601dc..16dbbcfc0e40 100755
--- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# Use vfs_getname probe to get syscall args filenames (exclusive)
+# Use vfs_getname probe to get syscall args filenames
 
 # Uses the 'perf test shell' library to add probe:vfs_getname to the system
 # then use it with 'perf record' using 'touch' to write to a temp file, then
@@ -15,22 +15,30 @@ skip_if_no_perf_probe || exit 2
 [ "$(id -u)" = 0 ] || exit 2
 
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
+	# Name the probes, a "${vfs_getname}*" glob would match longer pids.
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
index 28d3aa8a9e33..ab13801d9e99 100755
--- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
@@ -10,12 +10,17 @@
 # SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
+# Exclusive as, without BPF, any perf trace opens all probe:vfs_getname* events
+# and so would pin this test's probe.
+
 . "$(dirname $0)"/lib/probe.sh
 
 skip_if_no_perf_probe || exit 2
 skip_if_no_perf_trace || exit 2
 [ "$(id -u)" = 0 ] || exit 2
 
+# shellcheck disable=SC2034 # consumed by lib/probe_vfs_getname.sh
+vfs_getname="vfs_getname_$$"
 . "$(dirname $0)"/lib/probe_vfs_getname.sh
 
 trace_open_vfs_getname() {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

