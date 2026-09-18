Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FFA4F4CE6
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740456; cv=none; b=PUttDRJoLT9d+dVqou/8s5G5/c4N+M8yvd2FXlgRunzGn4bZSZfbW/gYNjQI1orzCiw0ajJgd8Pq230FU8WmY+XSOpNwJA2DhYnaun7ixnKFAsEsKHyksS3XvEb/8jYU5QuBO8P2QPmk1AfG9Fsx8N9nScmNHc7QnNFcM4mrBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740456; c=relaxed/simple;
	bh=BsS5nsnN3cXmHtCEI7BqlglY2nFdt11YaoNoFK3pjrw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ans9EIAiTIEZxJgHmFrJC9io++u4X/YsZqcrOhkTDr/CIcO3xHrc+ZQIkKRra5L+wYEbo9p71ayVICnbvDyXcz/y9HWp20B/6HodwlIQLpNXUY5zSXRt5PZSeqjo8d3wxhRPA7RS3QF104I36TrE9tjMIPKyesSa+GYjjuR85fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S5aYIlA9; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S5aYIlA9"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39d8646b10eso865657a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 07:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789740453; x=1790345253; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MEe9D2w+4Dyx7hV+twX4quw1LE1KttrX05zEETQXjKg=;
        b=S5aYIlA9X9rnmd/hOaxSE/MZhD7uUr8LYnlMLKvrn+XaPZlFZYzEI4z7BNhNOwzPQo
         LtoHO8WNdELEUspngYhEPdV8zWV6mlHGebnXbIc0n6gt1JTz3jTGNK4+E2oYlSrRmqPv
         o8yMUULhBfhAx4TiNh5i5q4XE8yZdWz7mK0s1RmCc6ffUnht4IRIS7r5baqpffuNsj4r
         kpGJXJdrIa7p/qFlHbhvmXvYA+VhuqG9zDumYDh8QWTqJsE9fI7TI6ijOJjyZ42f8Y8K
         tKjyH8CdvU9t1UhIHGSSkHa/7zvHseWAhOhvUSY1SZSYK+ekfv1AyzekKt360bNbJuZj
         EE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740453; x=1790345253;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MEe9D2w+4Dyx7hV+twX4quw1LE1KttrX05zEETQXjKg=;
        b=F/JFKwVzsmH/NHomNFgzlOCrSVi+wLz2Qyryq2a4oZBOvfa+d+YO6kqh7XPvfcfLbb
         8YG0S6I6codlGejqHdZdMBnKQsfEsuBy/oO+U3yvJwovFdxkBXyH2eVCUIbYrW61GomY
         HNb7RMv6xEndl3+8gDFEjpTQlHycKMVAK70QkbxBczBGl1fnkMuJDgUEGgpSOUXmRLwL
         kca0Z8gW4grIbntQSARjNQrSJ+c2E+ns24omGF2+8ZxnkMjTbOb6937t8CMMPdh25fzc
         JtNwdr7amk6BaxrBO7AgilEo4TOIxPQG6hbgg+WnmBMBgnzmnIWw/FC74ENRvUmlWVI2
         TwRg==
X-Forwarded-Encrypted: i=1; AKwUvBxUqLcpsX948PjF3ZUfX6AFDW0jHDbjNjJklB0bJmDtlh6mNpiwoCBiZm//+SUtbgmSbNHAeUSeOl8MSq1vVldt@vger.kernel.org
X-Gm-Message-State: AFuF++lmbHyVv4smXCcVYcfvjTmsWTaLa9KOXS99OC/yPyeFBWlelbUt
	UZnlrHAOqp88+QtZB7jHo03+YTVG0qol9U0UDNxH8XxiGirL2mT6EMb7xgJfcsp4D0DdVbKuB/E
	P+Pah6DOJNw==
X-Received: from dlaf10.prod.google.com ([2002:a05:701b:240a:b0:144:be75:f389])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b8e:b0:39d:efa9:cd25
 with SMTP id 98e67ed59e1d1-39e54c59c74mr11257639a91.2.1789740453112; Fri, 18
 Sep 2026 07:07:33 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:06:55 -0700
In-Reply-To: <20260918140659.2501976-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com> <20260918140659.2501976-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918140659.2501976-13-irogers@google.com>
Subject: [PATCH v3 12/16] perf test record+probe_libc_inet_pton: Scope event
 to PID, add retries, and make non-exclusive
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
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
2.55.0.1082.g2b9226bbc0-goog

