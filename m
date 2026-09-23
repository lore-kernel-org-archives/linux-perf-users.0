Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D648846EC96
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147694; cv=none; b=G15UqFtLtlj1BJG8lDrQpk0eGp4EW6QmrCPmkJ2Im7pKT0j+/SdSP0lNKquE87xVCiHzVO4taGx3Ko5pQzJBoEhY/xtWWcngvLbXbsQpYcdtBS2SRndx54UPdW+Wi34xZGnCyo/GkuSjTolO66bbs8B78Z4V1+RWlhAnUfUCD4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147694; c=relaxed/simple;
	bh=0ZhD8bssDZ7dlaIyvyn5ilk6eduNKlg/RQWYWTYY4Q4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rqhx8/qoP2htu4rHuTuPp6WlY9K4xtVI75Y678wePcyT1UXAuIP9a/hAE4X488gFSyQyQV0kSor9ccjuKHbBLSgAEEWog2uDeGjEEaYd92kH5jicCZpL5p/3MAJKBxv7fnWuSIS54wCnP+8VngawVmf4AYNOJF0/OfbO+cc9BK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=flHIBsEm; arc=none smtp.client-ip=74.125.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="flHIBsEm"
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1438719cc1eso882883c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 00:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147691; x=1790752491; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ci+qALH0Ym3zO0P0k8BKqSlfohnst/RmWwz2GuRC2j0=;
        b=flHIBsEm2R2lVeP8B6ZXU4X8zTtBwa0Rz08ets/1iBN11Ly2S5rXaDxaF5yCsQ+Dbi
         vHBCpShG8j20YZvompzMw3J/RFNs3EAbKqVL1K3wUWKCvjYoP5VhFJGDVkrbrDN5tzgz
         Jvu7yruBuH78uFgqn7bYcAAXy2jLeZiui1C9bBRvkdrnakoKGSsCu1zeU7fOaV/7nxG+
         yLYQ3ixgyqEsv7iTmGvsR16sIeW5NFsu9LssgRf63UD5dbXaOQ1tM0vSbW+1ctF4sp8E
         ti4r1UeCS8vZKlFtsi+lvZXipTTDgdPGvHC7MNbXpoz1EFQdoyEDb1i8HRz3v/V+jk1D
         BymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147691; x=1790752491;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ci+qALH0Ym3zO0P0k8BKqSlfohnst/RmWwz2GuRC2j0=;
        b=LOSaFbtHtMCP7kd7YCOzEXy4Ov7UDKplNoL8Rpg1TaqtUCsT8PUZUBKzyKqPujeeLm
         ddBhri6trMeVqT+ul4DWmohS2oWrim6XbaZWsWgu0Iu8OwqaqmS7b4wcBHOPksQDjBWH
         VpVS5w6UwNwR+8v8M4dUN+Q7xoooLve2kUOggyvJ1vR2dr01Kp7wikoS31F7lSg2/vpE
         m2l5HiqrfPlzoLehVOWiIOTrSShV0IaJNprqWbREyN2WXbL0PSM7QTbqG4PfgzOlsRPS
         nYkWi5wLtas1Pg+Tc+X2wPquGsLEsF9yrGL6gPvQQqvFrm1m1pfVeS8MXovP/LwC34LW
         nJ0Q==
X-Forwarded-Encrypted: i=1; AKwUvBxC9cOhrN6arb82bQMX0/bNQaHwUbFsdKW01RJJYcSIn0XrDhfGTGXpDQho36BMoYZbwmaE7Kq4U+WOGBtYRm51@vger.kernel.org
X-Gm-Message-State: AFuF++m6E32HC8NU83bbznA1UojUQEksMuc1+LkXnfWiWnyN5S4o+kzV
	Viq1H3LFjr/hkq7IvenBgzGBIHAWC8lE7tDutkD3wgAXZjGKjsPLE6f0F/C/JpKZp2h742bTtHy
	Gw9AV+E1Qpw==
X-Received: from dlag1.prod.google.com ([2002:a05:701b:2501:b0:144:ce1e:6f56])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4546:10b0:143:298b:ba79
 with SMTP id a92af1059eb24-144f91ed3eemr1829369c88.40.1790147690400; Wed, 23
 Sep 2026 00:14:50 -0700 (PDT)
Date: Wed, 23 Sep 2026 00:13:59 -0700
In-Reply-To: <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <0ef35340076ebce0f85b453c4e30bcdf6a660818.1790145937.git.irogers@google.com>
Subject: [PATCH v5 19/23] perf test record+probe_libc_inet_pton: Scope event
 to PID, add retries, and make non-exclusive
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, howardchu95@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

The uprobe name was not scoped to PID, and concurrent writes to
`/sys/kernel/debug/tracing/uprobe_events` can occasionally return
`-EBUSY` when another process holds the tracefs inode lock.

Scope the probe event name with `$$` (`inet_pton_$$=inet_pton`) and add
a retry loop with backoff for uprobe addition. Drop the
`(exclusive)` tag so the test can run in parallel during pass 1.

A PID scoped probe is no longer cleaned up by any other test, so add an
EXIT/TERM/INT trap to delete it, otherwise an interrupted run leaks the
uprobe into the system. The trap is installed only after the root and
IPv6 checks that `exit 2` to skip the test, as trap_cleanup() exits 1
and would otherwise turn those skips into failures. Deletion enumerates
the probes from `perf probe -l`, matching
`^probe_libc:inet_pton_$$(_[[:digit:]]+)?$` exactly, rather than reading
$event_name: a signal arriving after perf probe injected the uprobe but
before the assignment completed would leave that variable empty and leak
the probe, and an `inet_pton_$$*` glob would reach the probe of a test
whose pid merely starts with this one's.

While here use mktemp rather than mktemp -u for the temporary files:
this test runs as root in a world writable /tmp, and predicting a name
without creating it allows another user to win the race and plant a
symlink. The perf.data check becomes -s rather than -e as mktemp now
pre-creates an empty file.

Pre-create the temporary files with mktemp rather than reserving names
with mktemp -u, and bail out if mktemp fails. The emptiness check on
the recorded data quotes its path for the same reason: unquoted, an
empty value would leave [ ! -s ] testing the string "-s", which is
true, so the negation would skip the failure path and the test would
go on to pass without having recorded anything.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../shell/record+probe_libc_inet_pton.sh      | 107 ++++++++++++++----
 1 file changed, 87 insertions(+), 20 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index eca629ee83f0..00367f26bfae 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# probe libc's inet_pton & backtrace it with ping (exclusive)
+# probe libc's inet_pton & backtrace it with ping
 
 # Installs a probe on libc's inet_pton function, that will use uprobes,
 # then use 'perf trace' on a ping to localhost asking for just one packet
@@ -21,20 +21,30 @@ nm -Dg $libc 2>/dev/null | grep -F -q inet_pton || exit 254
 event_pattern='probe_libc:inet_pton(_[[:digit:]]+)?'
 
 add_libc_inet_pton_event() {
+	local attempts=0
+	while [ $attempts -lt 3 ]; do
+		event_name=$(perf probe -f -x $libc -a "inet_pton_$$=inet_pton" 2>&1 | \
+				awk -v ep="$event_pattern" -v l="$libc" '$0 ~ ep && $0 ~ \
+				("\\(on inet_pton in " l "\\)") {print $1}' | head -n 1)
+
+		if [ -n "$event_name" ]; then
+			return 0
+		fi
+		attempts=$((attempts + 1))
+		sleep 0.1
+	done
 
-	event_name=$(perf probe -f -x $libc -a inet_pton 2>&1 | \
-			awk -v ep="$event_pattern" -v l="$libc" '$0 ~ ep && $0 ~ \
-			("\\(on inet_pton in " l "\\)") {print $1}' | head -n 1)
-
-	if [ $? -ne 0 ] || [ -z "$event_name" ] ; then
-		printf "FAIL: could not add event\n"
-		return 1
-	fi
+	printf "FAIL: could not add event\n"
+	return 1
 }
 
 trace_libc_inet_pton_backtrace() {
 
-	expected=`mktemp -u /tmp/expected.XXX`
+	# Create the files rather than just reserving names with mktemp -u:
+	# this runs as root and /tmp is world writable, so a predictable name
+	# that is written to later can be pre-created as a symlink by an
+	# unprivileged user and used to clobber an arbitrary file.
+	expected=$(mktemp /tmp/expected.XXX) || return 1
 
 	echo "ping[][0-9 \.:]+$event_name: \([[:xdigit:]]+\)" > $expected
 	echo ".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
@@ -50,8 +60,8 @@ trace_libc_inet_pton_backtrace() {
 		;;
 	esac
 
-	perf_data=`mktemp -u /tmp/perf.data.XXX`
-	perf_script=`mktemp -u /tmp/perf.script.XXX`
+	perf_data=$(mktemp /tmp/perf.data.XXX) || return 1
+	perf_script=$(mktemp /tmp/perf.script.XXX) || return 1
 
 	# Check presence of libtraceevent support to run perf record
 	skip_no_probe_record_support "$event_name/$eventattr/"
@@ -61,9 +71,12 @@ trace_libc_inet_pton_backtrace() {
 	fi
 
 	perf record -e $event_name/$eventattr/ -o $perf_data ping -6 -c 1 ::1 > /dev/null 2>&1
-	# check if perf data file got created in above step.
-	if [ ! -e $perf_data ]; then
-		printf "FAIL: perf record failed to create \"%s\" \n" "$perf_data"
+	# Check perf record actually wrote data. mktemp already created the
+	# file, so test that it is non-empty rather than that it exists. Quote
+	# the path: were it ever empty, [ ! -s ] would test the string "-s"
+	# instead and report success.
+	if [ ! -s "$perf_data" ]; then
+		printf "FAIL: perf record failed to write \"%s\" \n" "$perf_data"
 		return 1
 	fi
 	perf script -i $perf_data | tac | grep -m1 ^ping -B9 | tac > $perf_script
@@ -97,21 +110,75 @@ trace_libc_inet_pton_backtrace() {
 	# even if the perf script output does not match.
 }
 
+# Print the pid scoped uprobes this test may have created. perf probe appends
+# _1, _2, ... when the name is already taken, so match those too, but anchor
+# the match: an "inet_pton_$$*" glob would also match the probe of a test whose
+# pid merely starts with this one's, e.g. 123 and 1234.
+libc_inet_pton_events() {
+	perf probe -l 2>/dev/null | awk '{print $1}' |
+		grep -E "^probe_libc:inet_pton_$$(_[[:digit:]]+)?$"
+}
+
 delete_libc_inet_pton_event() {
+	# Ask the kernel what is actually there rather than trusting
+	# $event_name: a signal arriving after perf probe injected the uprobe
+	# but before the assignment to event_name completed would otherwise
+	# leave the variable empty and leak the probe.
+	#
+	# Retry as the addition does. Deleting writes to uprobe_events just as
+	# adding does, so it can lose the same race with a concurrent test and
+	# fail with -EBUSY. Re-list rather than assume the delete worked, and
+	# only give up once the probes are really gone: the name is pid
+	# scoped, so one left behind here is never reused or overwritten by a
+	# later run and would sit in the kernel until reboot.
+	local attempts=0
+	local probe
+
+	while [ $attempts -lt 3 ]; do
+		for probe in $(libc_inet_pton_events); do
+			perf probe -q -d "$probe"
+		done
 
-	if [ -n "$event_name" ] ; then
-		perf probe -q -d $event_name
-	fi
+		if [ -z "$(libc_inet_pton_events)" ]; then
+			return 0
+		fi
+
+		attempts=$((attempts + 1))
+		sleep 0.1
+	done
+
+	printf "WARN: could not delete event(s): %s\n" \
+		"$(libc_inet_pton_events | tr '\n' ' ')"
+	return 1
+}
+
+cleanup() {
+	rm -f ${perf_data} ${perf_script} ${expected}
+	delete_libc_inet_pton_event
+
+	trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+	cleanup
+	exit 1
 }
 
 # Check for IPv6 interface existence
 ip a sh lo | grep -F -q inet6 || exit 2
 [ "$(id -u)" = 0 ] || exit 2
 
+# Install the trap only now that the skips above are out of the way: it exits
+# 1, so arming it any earlier would turn an 'exit 2' skip into a failure.
+#
+# The event name is pid scoped, so unlike the old fixed name an orphan left
+# behind by an interrupted run is never overwritten by a later run: it would
+# stay in the kernel forever. Always clean up, including on a signal.
+trap trap_cleanup EXIT TERM INT
+
 skip_if_no_perf_probe && \
 add_libc_inet_pton_event && \
 trace_libc_inet_pton_backtrace
 err=$?
-rm -f ${perf_data} ${perf_script} ${expected}
-delete_libc_inet_pton_event
+cleanup
 exit $err
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

