Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1675B4FC35A
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663187; cv=none; b=HeNEgWWbB5KEgAp81NU9HqUMO5nij97JVzo9Eu5ghnQ29BoK+JIbjbLKwm6TGvON1Clx+LolqMuZfoF3JJxb8m3ifrspHrrI7BhR2gHKzDt1AaAGhjgIYJCrbDm65HZaKTCs79+zTh6Qsja15hfQsy4Cxu46wVoQ+hyg+noNt4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663187; c=relaxed/simple;
	bh=5Yuc8XAiW6kfWmbvTQBKbdZimkwARfCgP8aby2uGwA0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oiY3GOlfTQgBgSBZcdVsESFUyMgQu3cqQ4OvHAfNvoOzjHy7iBPV2J23KSOllbyFQDC4PAGgCJw2z2akEZ8Lt6H+HfI5J158Rndorbtz0UKvgQrrQoEQDNwmxa48Yna3wRcj6avA4+CpmUd9LfzPYUfAQ0aovtL7X9W0QRn5png=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvIkYjTm; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvIkYjTm"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39e3dad7ab3so1135364a91.2
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 09:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789663184; x=1790267984; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z3dRiQJZJNOXkNTzggpxwH2qCkPBVHKNDZg538ILUlA=;
        b=fvIkYjTm0NaoX3QPVWjuGV9ulNF4A6pyID3iMWoOJuD/Gg4gT+00AfZxJ6RK2ZUvG6
         NX32mE3IdVL0ib6r4A35ejzL34evva3Gfydb093ekXg6T7Tbvwdabmm7f8F0pnnkIrjJ
         422o3Xz/TpLmkr92muYIMLM+ArosEZzLwwuTRuq3bMqA4UN+6MvB1DSULjgxVnloGwdv
         W35X7Cjwf/qrVteLy+KJVAUdstM/smZMLFx8L/09H6M18t4Bf6vqZ1IrblB96ldd+ZfO
         FlLlmyNypKR9v6p+FzD3peiHFEtOYnMo6TozKCyzT8rvzhcih+OG2dV8PThLWmK9op3m
         vzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663184; x=1790267984;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z3dRiQJZJNOXkNTzggpxwH2qCkPBVHKNDZg538ILUlA=;
        b=iULcxf7tEgGaGyaUUuh94ccckBngnt/H1z4ZrfghSGXoMDB4LkSMhTLFBFCbnl6aRE
         0ljVVn5LojsluMZ/Qnj4vMkja8kCAbJG0l2n/K4HiBGQnfS380vuqGZ1M6XbVIc6PAnl
         +iRj06BXUniAciIaSwXO/GcbBnbyo/cYSR4M0U0i3BYiHIpHvMLsLZnEXLXEt4dMJdas
         sW7uTOaL56eY8XquKWhFJz1n9MmkdyouXcGK4aGOdk6KrLJuxzz6N6nVUEV0rUXcZ7qg
         RTjlVR5LrAZw3L19wd4KiH2+B+crxVsTLt1tqHLx9D9ldcrdc+hRdGTBe7blSHEopDGd
         wEEg==
X-Forwarded-Encrypted: i=1; AKwUvByu+Nerq+kCYOnVwQualyCtdGluDUyMRbS+jwImiOA6fxsWPuKLTjIGn2cWKeNuJacuOsKCZH+3tSMCnNJhea2c@vger.kernel.org
X-Gm-Message-State: AFuF++lsWo2PxlEYDha2NDzQ8tBVClSo6ybQDFGM9PQ/vKKoytHO6Yfd
	UJSz5MjU0bm6v15lfXwjDQaDnw29LxTL/5izzfIqnnjYla5uwucQyOHUWTMdn9s5mvev8uTprYH
	kVshXrOW8IA==
X-Received: from dlae2.prod.google.com ([2002:a05:701b:2302:b0:143:89e0:aa57])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ac2:b0:39e:5166:df84
 with SMTP id 98e67ed59e1d1-39e516728a5mr234633a91.16.1789663183798; Thu, 17
 Sep 2026 09:39:43 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:38:58 -0700
In-Reply-To: <cover.1789662556.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <b44b7608adab8e5575bc458a8d3e02105d199afe.1789662556.git.irogers@google.com>
Subject: [PATCH v2 10/14] perf test record+probe_libc_inet_pton: Scope event
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

