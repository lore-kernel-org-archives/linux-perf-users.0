Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A047C455181
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147691; cv=none; b=fBH01xjjBKN0YpQZwDqeHwFNm/tr/pZIUi6K64bZsakjdZL9+6It/gokO6jU5jw150xywecaxtm2M6HHnyI1MVQVtuss464XI1D2b6XRkisRXzomW6tiBBxoaYtizhd/kbs9VUQ2MlvA2JDjTpc1LzisOb3mlITi46MHX1ZrAnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147691; c=relaxed/simple;
	bh=QsG4MJ+9d8Gw2rlu7vt+kuuYK5BwpCbNXWox8MIEeP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rvNHs4ynkCdoKE5QGRFmoxq0jE3k35HiNNAkg3wdrnubCFNMMjuvbKzRlros8p1/AULg5JqzER5Y1WGljkFrO6KfSsQPriZkGgOBeti41zkUp8F8+OFHGSQM9HUi43i6XQQDu5hCAmgfLbmo9YZ8yFd/Onzc5ovjaGhb7QEjIrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=flGhhIPN; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="flGhhIPN"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-331b2ec616fso2391605eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 00:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147689; x=1790752489; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MWrqEnEjaqzlFKJHYlIpmLW2qV50R+anCoJc7h1aKtE=;
        b=flGhhIPNensCyjHYKT6RSyXR0SfvutCF0AsEjMObVbJ640YmBcDo6CJi2D2k4nyxhz
         KZXtT7+SzWXf+HMXE98+tsjLj/eerAsEC6mqKeY4Vv8iTkC3xuNFoW4TAMGl75raCo7Z
         QQQptoyiVBJUGpwrmgnRdcmqBD3BUjcZYOvHncuHAR++K0xl1nbxW9VjLCWj/pAktTkk
         VXlwKMT/s1CtpI5ThAlQ/nMNTo4oaZjCNoKRUT995VqVDOcJ+x8HPL0Wm7Dt7SLRRR/3
         epH0Ht0xYGpFh+0QFXDP3JxwTQ5kSb9HId0a2hv6JfFTEuuwY7Wd1ROfQl4wR2pEEnI4
         9YRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147689; x=1790752489;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MWrqEnEjaqzlFKJHYlIpmLW2qV50R+anCoJc7h1aKtE=;
        b=e+mhiLtcZuIHQdBc8qoX6g/5bKtUWyYdo0VYnNt3H0U+zYzSpSAjdJ5E/HsIwhVtAx
         KngE0hPo0ZGU0hxP/A0+5qkWzvc58iGsb6AnN/pNJhhxa/XAaSGQQ8hQ4EpYo4MgDd0z
         V2Sj3oVtTSc4krG0zBkyYvZi/hRLHrCZdfWiR/dXnJFsesup+OVeDq5z7x8FzJd93C8f
         cv9NtM8U8MOlJUS7NWNKJCztKFfdyaSTnLBMe0CbmqQKygNMOOSbKOv+4i5KrbPGMAy4
         GPw+T4Gplim+X1wV9LcMsd+ML495LMLtMrpcNOmfqxNvhcV5+G410gU5S6FVAsWlADsq
         Pp8A==
X-Forwarded-Encrypted: i=1; AKwUvBytXpaUgBs6XjKIMT90+hDNFZdN5my/BEMLDZxJbrT9QaMSFlT4E9rHXjXBSmYYwll1tCCYY4mlwyJ16aa/3vpj@vger.kernel.org
X-Gm-Message-State: AFuF++lvH6Hrl5vfdlvMsNv79YWPwZxb2fT6e8/BMNLQ3getayqtAlqQ
	MAvywZ8hS7nIQwxIoujjTct2RxIczdYXwVmWyH+51HAtsEuDMwbKWF3V4CxRXyjKTP2suUWERwu
	Sq7p/ZjPIfQ==
X-Received: from dybcr14.prod.google.com ([2002:a05:7300:ac8e:b0:314:7337:26d9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:23ca:b0:33b:944f:7e8e
 with SMTP id 5a478bee46e88-33e8dacd12amr1748482eec.21.1790147688466; Wed, 23
 Sep 2026 00:14:48 -0700 (PDT)
Date: Wed, 23 Sep 2026 00:13:58 -0700
In-Reply-To: <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <a894ccb359e5caada2243cb67a6ba041cd3b9b9c.1790145937.git.irogers@google.com>
Subject: [PATCH v5 18/23] perf test probe_vfs_getname: Scope probe name to PID
 and make non-exclusive
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, howardchu95@gmail.com, 
	namhyung@kernel.org
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
2.56.0.rc1.315.gc6ed9934b7-goog

