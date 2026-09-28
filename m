Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78883A6B6F
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790620024; cv=none; b=HjyrwU/ztKu7u0bNKNGS9f5LPMM7ScdsJrWdTS4AteNfKIXEoj3eYx1pRybkBdUdv49HDW9m0QSVPTioaIUSNCS8Ws58D3XkW0EWhmKApnnpTgdkfm5vsmLOgZecrGwXsOhQKtsbdz0VRPkzf9gjWFDswbIfjcfG+0KOE2jVmSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790620024; c=relaxed/simple;
	bh=QPkurUNLHrbW4WShlNIgz99p2Ah5p/u+IEn6RBCgCJ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VhbnEdNbQx+kvVhgAci9/A3iZctLVc6Oo/CzyDfxPKhbcaCe5E3+9vVr9YVbdHNrF6VCzZkw7Enh3bSCVScPbqAOb7qIvdrcjLyf06RyhsYRnItusLmZIM+9IUnapQ1lH6FLUWkTus0Rq4lBDG42eU9WEltgHG3TNKsej7aQEZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NdK4W0be; arc=none smtp.client-ip=74.125.82.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NdK4W0be"
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-30bcb065bfdso5950939eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790620022; x=1791224822; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=llfG9abcddaZI9taYuUgoaCq2DhnigFy/EMsixGQ00E=;
        b=NdK4W0beYctHi3Fb1NUrQ6V/0AxpzvXqf0r9tl9OrVHfZ8KEFcp8lWdhquVbXu43FX
         MYzA5myQP5ponUCIAOdBndOY7oKNZxSH6SHMSyP/A82Af5fyhZzUsgZ73evtqz3a8iqe
         3n2KXxVRxyMnBmVulOGMfza+XcUQ0fvDckvLRjct/niou03AICVGqSy9tV5Go7bkwt0T
         Lto3bw/dDHf+HjHnRWZUILDts6ipsahWZCRMT1mTO5+/JWRWWPvyaJAZROD7PO5GdfZE
         kKwSJ4S3GGPDpIXsawgy2nRFhM4KpqBoxmOvRQ3g3XN7Cu8cB2Kb3vVLSTFcBnk8Lo1M
         C8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790620022; x=1791224822;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=llfG9abcddaZI9taYuUgoaCq2DhnigFy/EMsixGQ00E=;
        b=G/gDGq3OCN7G1wjP0EekGuaOtht9v3GArYWU8HZvjLW3Snu/S6KmZE3MDWF7ZFKou9
         aIYZc/rrB8ipf/UU+KlvBZ0kYm0h/nKjmuHv5PdRO0kyCNFdvJkuBFsuFnOEiSiXYHsK
         6P6Wjkc3yBKDwOy0SAxgiDZ9DS2NE1C+1T0VoLtTHyNOZW2iSnkhfXR4StNDWZIflo3S
         +Q3Erpk0sUNQQWaeeXeyStqP2pOFA/6mROdChJkpijvvuWHyeckWQpM+/iCnXcJr7bUW
         cBxyXLGGxgHTRYBnSF9ywKZSje1GPxExBSeruEEKW/+dYkT8Iol0qUuvbve9rszQDdKB
         0F2A==
X-Forwarded-Encrypted: i=1; AKwUvBzqNF+zMdf9Tv2nsfQrfGM/mEnUhbFQBo4h38tqFv0JSHk6YZzaYZGWwpxxIJE9MrZGqgc7/QJQU/QfPXTx0p0/@vger.kernel.org
X-Gm-Message-State: AFuF++nl6YJP1D1S/G8DRLLRUrBcwurltmLRfd5muG7mOj2eB1vsjHF2
	J0tE82cL9tVWwDG53XJRtbWKdYesF6qN9Dp7dg0rOzGyTJdFPut0cMsG82UH/OVNqF8DRpOT9Fi
	U1ZiVaFaYHA==
X-Received: from dlbrn6.prod.google.com ([2002:a05:7022:1506:b0:144:dc56:6367])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4289:10b0:143:26f5:c618
 with SMTP id a92af1059eb24-146d02a7e38mr10085733c88.33.1790620020925; Mon, 28
 Sep 2026 11:27:00 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:26:01 -0700
In-Reply-To: <20260928182605.3649015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928182605.3649015-23-irogers@google.com>
Subject: [PATCH v6 22/26] perf test record+probe_libc_inet_pton: Scope event
 to PID and make non-exclusive
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Scope the uprobe name to the pid, retry adding and deleting it as
concurrent uprobe_events writes can fail with EBUSY, and delete it from
an exit trap. Create the temporary files with mktemp rather than reserving
names with mktemp -u. Remove the exclusive tag.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../shell/record+probe_libc_inet_pton.sh      | 85 ++++++++++++++-----
 1 file changed, 65 insertions(+), 20 deletions(-)

diff --git a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
index 4c9a308a450d..3a363a99ef41 100755
--- a/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
+++ b/tools/perf/tests/shell/record+probe_libc_inet_pton.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# probe libc's inet_pton & backtrace it with ping (exclusive)
+# probe libc's inet_pton & backtrace it with ping
 
 # Installs a probe on libc's inet_pton function, that will use uprobes,
 # then use 'perf trace' on a ping to localhost asking for just one packet
@@ -19,20 +19,27 @@ nm -Dg $libc 2>/dev/null | grep -F -q inet_pton || exit 254
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
+	# Create the files, as root a reserved /tmp name could be a planted symlink.
+	expected=$(mktemp /tmp/expected.XXX) || return 1
 
 	echo "ping[][0-9 \.:]+$event_name: \([[:xdigit:]]+\)" > $expected
 	echo ".*inet_pton\+0x[[:xdigit:]]+[[:space:]]\($libc|inlined\)$" >> $expected
@@ -48,8 +55,8 @@ trace_libc_inet_pton_backtrace() {
 		;;
 	esac
 
-	perf_data=`mktemp -u /tmp/perf.data.XXX`
-	perf_script=`mktemp -u /tmp/perf.script.XXX`
+	perf_data=$(mktemp /tmp/perf.data.XXX) || return 1
+	perf_script=$(mktemp /tmp/perf.script.XXX) || return 1
 
 	# Check presence of libtraceevent support to run perf record
 	skip_no_probe_record_support "$event_name/$eventattr/"
@@ -59,9 +66,9 @@ trace_libc_inet_pton_backtrace() {
 	fi
 
 	perf record -e $event_name/$eventattr/ -o $perf_data ping -6 -c 1 ::1 > /dev/null 2>&1
-	# check if perf data file got created in above step.
-	if [ ! -e $perf_data ]; then
-		printf "FAIL: perf record failed to create \"%s\" \n" "$perf_data"
+	# mktemp created the file, so check that perf record wrote to it.
+	if [ ! -s "$perf_data" ]; then
+		printf "FAIL: perf record failed to write \"%s\" \n" "$perf_data"
 		return 1
 	fi
 	perf script -i $perf_data | tac | grep -m1 ^ping -B9 | tac > $perf_script
@@ -95,21 +102,59 @@ trace_libc_inet_pton_backtrace() {
 	# even if the perf script output does not match.
 }
 
+# The probes added, including any _1, _2... suffix perf probe appended.
+libc_inet_pton_events() {
+	perf probe -l 2>/dev/null | awk '{print $1}' |
+		grep -E "^probe_libc:inet_pton_$$(_[[:digit:]]+)?$"
+}
+
 delete_libc_inet_pton_event() {
+	# List rather than use event_name, which a signal may have left unset.
+	# Retry as, like adding, deleting can fail with EBUSY.
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
 
+# After the skips, as trap_cleanup exits 1. A pid scoped probe is never reused,
+# so always remove it.
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

