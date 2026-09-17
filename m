Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB9239E80
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627394; cv=none; b=atiqvm6eiPxmS4wgM7eGDZI0glT5jW492iQN+AW7HIHdANUZjk/iDyUAMNJKzw1+CMBvsI3ElNXePRdpLWMmKdq7nGXIK+8L/vGNPGbSnBCH09zkP+EnL7/R2CrvU4mgSuFWplq+bei4tQfr9W4IBGLlm21FygIXPxD3MMZqQJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627394; c=relaxed/simple;
	bh=5Yuc8XAiW6kfWmbvTQBKbdZimkwARfCgP8aby2uGwA0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bd67J+GPRR3fp3Qo9a8xeW0ya37m5/lSGZcmL0Vmgh+WJ8E2FGHwrRr5r0E64OIrI2s8BqmerwbnFQ5onC46FvdkwccL5022M+HXp7PtRhL2FCj9t93UOVIulH/WzX5cgJUjuiAzFzOrm6dX3MK/oDNtRmLFXT0zkH9/h4Hyh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nbKmfIZU; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nbKmfIZU"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dbf293831so1102843a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789627385; x=1790232185; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z3dRiQJZJNOXkNTzggpxwH2qCkPBVHKNDZg538ILUlA=;
        b=nbKmfIZUMA1B9+a/RO+lQMb8mhmAALhblKzPwSFhpZqObZiz1NvUBSMYCjKRZX2fjZ
         iFF3CIJdaUuwz+D1SEFmfWG6B3n7SyxxgLkzrknzbHvI1BAZXPfyffEYr16kR1c36KKG
         N2666d4AoZkkPbgtwbqWMCmmSJuVM2zbUD4K3O5aO61xYXkFaYi1SEjgt5j9+FMPvusS
         R7ab4GHsm6QcJCs4eae3+jqrhSE8U8SPLe5cbi6FTCgIAQE/s3HpXVtwc37sGmdyVIZs
         ssTHijX4jZ/LTVZ9HSgfU0YWr0SiG2PPaUVcRiAbLSqxqE+TAMyzPj6v63VP6Htm+zbI
         7k7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627385; x=1790232185;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z3dRiQJZJNOXkNTzggpxwH2qCkPBVHKNDZg538ILUlA=;
        b=1wA8UxzEmp4ogz1z1EqLE4adaJNjNiWUXHPJu+bpLJa+Kc79fpjp0YCqDg9y2dHMA+
         O9apD8Hk/50/OxAGueQflnnDT4phiVrkGEmb44J717KQtzHc/eWN2p1/sLHKj8mQ4fRc
         rt2jLZL+qOA9/9u74ZTAphqzAs4Ndo7apSJPdTROpS4OhFwXmjmiswyhrN5reSj/sdSn
         YVLxbcD4fxXgPoWiReAl0Vt1RV15xva7KIX9zA4NSJF6Vg+FBKCkYOSQZTc8eFsJv/WN
         DSDwqYbGw+Igp+1c9AG877nvtXpB94OhOQRFvO0aHuBCVvlv6N+BKg3zGuWjPFPVXaai
         nVBg==
X-Forwarded-Encrypted: i=1; AKwUvByv653DL2C4Ekjao2tK2Y3iNonDffaQK6M4ATHTwOZRMXQg16ShpzqmVIZGuipeZknbA/Vt9gokwU4072hCiKO3@vger.kernel.org
X-Gm-Message-State: AFuF++mkpIDg19rMQUAqHYA1fbuqGZDFRc2J3H1f8eeyQhY8sMTyGefX
	ZckpgN+SaCsxEg0qIZhbIwsqk2uQSWvbCY73lE6IgLiwm15X099jamlt25eab3lT58+rMPQdrU5
	ZELAZcH3rEA==
X-Received: from dlbrn14.prod.google.com ([2002:a05:7022:150e:b0:143:8ccf:e704])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c51:b0:39d:f254:4173
 with SMTP id 98e67ed59e1d1-39e1e5047b1mr13970770a91.21.1789627384447; Wed, 16
 Sep 2026 23:43:04 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:42:31 -0700
In-Reply-To: <cover.1789626977.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789626977.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <09c5cdf8edb4c418e417d98a996e14d6b5e68f8a.1789626978.git.irogers@google.com>
Subject: [PATCH v1 09/13] perf test record+probe_libc_inet_pton: Scope event
 to PID, add retries, and make non-exclusive
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
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

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../shell/record+probe_libc_inet_pton.sh      | 83 ++++++++++++++-----
 1 file changed, 63 insertions(+), 20 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index eca629ee83f0..3eb51426373b 100755
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
+	expected=$(mktemp /tmp/expected.XXX)
 
 	echo "ping[][0-9 \.:]+$event_name: \([[:xdigit:]]+\)" > $expected
 	echo ".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
@@ -50,8 +60,8 @@ trace_libc_inet_pton_backtrace() {
 		;;
 	esac
 
-	perf_data=`mktemp -u /tmp/perf.data.XXX`
-	perf_script=`mktemp -u /tmp/perf.script.XXX`
+	perf_data=$(mktemp /tmp/perf.data.XXX)
+	perf_script=$(mktemp /tmp/perf.script.XXX)
 
 	# Check presence of libtraceevent support to run perf record
 	skip_no_probe_record_support "$event_name/$eventattr/"
@@ -61,9 +71,10 @@ trace_libc_inet_pton_backtrace() {
 	fi
 
 	perf record -e $event_name/$eventattr/ -o $perf_data ping -6 -c 1 ::1 > /dev/null 2>&1
-	# check if perf data file got created in above step.
-	if [ ! -e $perf_data ]; then
-		printf "FAIL: perf record failed to create \"%s\" \n" "$perf_data"
+	# Check perf record actually wrote data. mktemp already created the
+	# file, so test that it is non-empty rather than that it exists.
+	if [ ! -s $perf_data ]; then
+		printf "FAIL: perf record failed to write \"%s\" \n" "$perf_data"
 		return 1
 	fi
 	perf script -i $perf_data | tac | grep -m1 ^ping -B9 | tac > $perf_script
@@ -97,21 +108,53 @@ trace_libc_inet_pton_backtrace() {
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
+	local probe
+	for probe in $(libc_inet_pton_events); do
+		perf probe -q -d "$probe"
+	done
+}
 
-	if [ -n "$event_name" ] ; then
-		perf probe -q -d $event_name
-	fi
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
2.55.0.1082.g2b9226bbc0-goog

