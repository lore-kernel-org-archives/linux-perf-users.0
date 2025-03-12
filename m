Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FAF101C8
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Mar 2025 05:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741759138; cv=none; b=uQxEwKhGaUsTL4GcL6hLcW7csu9Wdh1L79zj46+ym7lBHfnb0+9wVR+n104uHNtsACpRIOIAUAgpg3Id9NtIcMF/Lk1o4GY6PHMaF2nfEumKLwhV4KxwrEAL+7W8CK78kLzjgXZ0uk0Vi2/VJCyzrXfBojw3Czp6d/nr+gqGYBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741759138; c=relaxed/simple;
	bh=upHWTKFMcqxCm8JdJ3Wu6zMTEP+FCj94qr0zrv4qZSQ=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=rV+ahNeVrA+cFqvoIkPBBu7FbIaK6CpKgFtOu+oQe8hW9RK06DFdghHgJiPoDBfpWut8J+8jA3+tqwQMpHPdXrc5/piKll5/FVCsppFbIAlgktXkHSjdcRG27OkybirtW2dLUM2dKO0AX5dppVUN7pm8BEgs8DchYO4ZOGGcWak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tVdCO2ST; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tVdCO2ST"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fddfe0448dso7683427b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 22:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741759136; x=1742363936; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yVziTp6318IK4oEwMW2HlG8kz999ZqIs5QGLtSSa1UM=;
        b=tVdCO2STt/CBZtMTdpE55iaGUdgx1UfMv1HzDgb8XJXVoqB3LylFE++Ii3vvshDSHP
         Vah3KD33k86b+JYZy55X0MK2Oo3u8Npxj4MRFDDCn74HRHtSrvxr6SjcW0E/AhsoXljs
         Z7vxtzogSkBoustrfjVSwE9gmXcwLl1RWtzrqS1FG9zl6ZWz3qZFn6pTaaWizTcggIyH
         nZwOQTIhFjDuqhjnyqL5tkhhzMJ6LoRMfoR/6SerSAfiRZl7pO7gh65erv0FhcBAJolo
         raNYXVITxXuNDGEb4WeWsZ7VMYJLQvmFbGYNIvVDIlM9I8iAEWRoxAzvmkHIvfQOcH2b
         3M/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741759136; x=1742363936;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVziTp6318IK4oEwMW2HlG8kz999ZqIs5QGLtSSa1UM=;
        b=eMB7tiYkf94lXkgRjEEsPvSo/mFkCFct0ZvzODiwL5ZWok/I0N26PoIh/edJuL3+J4
         5+E0gfvPIVbz9WzVXnXzuxCrZ1eSl2obreYUsyNFAqhS26Bqu1YTPfQAtcrUuLWDZkgw
         8Xa4sE9QDAhkeXKDinkccT0NvfuK+bvC/WIat2ifPS1iDuYTQoLsSNMtIn4uweB2gk8c
         b9VW2O3CmCNG8yIFx2H+IMB3wZa0OcoWstCnxevWutTsD9uzWLKqyOCUZRTHgoKPGpxV
         PUITJDcLwGVHygpOFvVPi0+gW+zetvdpTatJjJBIrlnZnNXbfomGJODtcn9NioNtVcRa
         Ta1g==
X-Forwarded-Encrypted: i=1; AJvYcCXTN1TFvCa7pyyCjLguUyKfInvBHVPoydz12nGGJenVV+emgw3tSrOkYHHh4QqgMK0Kausgth8F3MD7rZooESPu@vger.kernel.org
X-Gm-Message-State: AOJu0YxjczNAykVLeq3ybi0IRWRymbIr2hSUowWvT6I5uc9eMjAO6ELC
	LOY22OqYau3mE3IyqXhDa6VEpC+0JBCe0ieFzL3f+SlAzwcLxmviR7RzrSUe4tgKgpxos1hSvzz
	Qhsws0g==
X-Google-Smtp-Source: AGHT+IEL92yy0pvHOGED+dLCRbbetGoDWCIZy3wkzaEPbjyqGE4mqp793eqhvDBNpOqQvq2yXjWDaD0dWRTy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8bc2:942f:1b93:42dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:2a88:b0:6fb:afe0:f186 with SMTP
 id 00721157ae682-6ff0a28f56emr6059927b3.2.1741759135826; Tue, 11 Mar 2025
 22:58:55 -0700 (PDT)
Date: Tue, 11 Mar 2025 22:58:46 -0700
Message-Id: <20250312055846.671522-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v1] perf tests: Harden branch stack sampling test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, German Gomez <german.gomez@arm.com>
Content-Type: text/plain; charset="UTF-8"

On continuous testing the perf script output can be empty, or nearly
empty, causing tr/grep to exit and due to "set -e" the test traps and
fails. Add some empty file handling that sets the test to skip and
make grep and other text rewriting failures non-fatal by adding
"|| true".

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_brstack.sh | 79 +++++++++++++++++++-------
 1 file changed, 59 insertions(+), 20 deletions(-)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index e01df7581393..6f5ae227b3e8 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # Check branch stack sampling
 
 # SPDX-License-Identifier: GPL-2.0
@@ -17,35 +17,54 @@ fi
 
 skip_test_missing_symbol brstack_bench
 
+set -x
+err=0
 TMPDIR=$(mktemp -d /tmp/__perf_test.program.XXXXX)
 TESTPROG="perf test -w brstack"
 
 cleanup() {
 	rm -rf $TMPDIR
+	trap - EXIT TERM INT
 }
 
-trap cleanup EXIT TERM INT
+trap_cleanup() {
+	set +e
+	echo "Unexpected signal in ${FUNCNAME[1]}"
+	cleanup
+	exit 1
+}
+trap trap_cleanup EXIT TERM INT
 
 test_user_branches() {
 	echo "Testing user branch stack sampling"
 
-	perf record -o $TMPDIR/perf.data --branch-filter any,save_type,u -- ${TESTPROG} > /dev/null 2>&1
-	perf script -i $TMPDIR/perf.data --fields brstacksym | tr -s ' ' '\n' > $TMPDIR/perf.script
+	perf record -o "$TMPDIR/perf.data" --branch-filter any,save_type,u -- ${TESTPROG} > "$TMPDIR/record.txt" 2>&1
+	perf script -i "$TMPDIR/perf.data" --fields brstacksym > "$TMPDIR/perf.script"
 
 	# example of branch entries:
 	# 	brstack_foo+0x14/brstack_bar+0x40/P/-/-/0/CALL
 
-	set -x
-	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$"	$TMPDIR/perf.script
-	grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"	$TMPDIR/perf.script
-	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$"	$TMPDIR/perf.script
-	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"	$TMPDIR/perf.script
-	grep -E -m1 "^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$"		$TMPDIR/perf.script
-	grep -E -m1 "^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"	$TMPDIR/perf.script
-	grep -E -m1 "^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"	$TMPDIR/perf.script
-	grep -E -m1 "^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"		$TMPDIR/perf.script
-	set +x
-
+	expected=(
+		"^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$"
+		"^brstack_foo\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"
+		"^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/CALL/.*$"
+		"^brstack_bench\+[^ ]*/brstack_bar\+[^ ]*/CALL/.*$"
+		"^brstack_bar\+[^ ]*/brstack_foo\+[^ ]*/RET/.*$"
+		"^brstack_foo\+[^ ]*/brstack_bench\+[^ ]*/RET/.*$"
+		"^brstack_bench\+[^ ]*/brstack_bench\+[^ ]*/COND/.*$"
+		"^brstack\+[^ ]*/brstack\+[^ ]*/UNCOND/.*$"
+	)
+	for x in "${expected[@]}"
+	do
+		if ! tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep -E -m1 -q "$x"
+		then
+			echo "Branches missing $x"
+			if [ "x$err" == "x0" ]
+			then
+				err=2
+			fi
+		fi
+	done
 	# some branch types are still not being tested:
 	# IND COND_CALL COND_RET SYSCALL SYSRET IRQ SERROR NO_TX
 }
@@ -57,14 +76,31 @@ test_filter() {
 	test_filter_expect=$2
 
 	echo "Testing branch stack filtering permutation ($test_filter_filter,$test_filter_expect)"
-
-	perf record -o $TMPDIR/perf.data --branch-filter $test_filter_filter,save_type,u -- ${TESTPROG} > /dev/null 2>&1
-	perf script -i $TMPDIR/perf.data --fields brstack | tr -s ' ' '\n' | grep '.' > $TMPDIR/perf.script
+	perf record -o "$TMPDIR/perf.data" --branch-filter "$test_filter_filter,save_type,u" -- ${TESTPROG}  > "$TMPDIR/record.txt" 2>&1
+	perf script -i "$TMPDIR/perf.data" --fields brstack > "$TMPDIR/perf.script"
 
 	# fail if we find any branch type that doesn't match any of the expected ones
 	# also consider UNKNOWN branch types (-)
-	if grep -E -vm1 "^[^ ]*/($test_filter_expect|-|( *))/.*$" $TMPDIR/perf.script; then
-		return 1
+	if [ ! -s "$TMPDIR/perf.script" ]
+	then
+		echo "Empty script output"
+		if [ "x$err" == "x0" ]
+		then
+			err=2
+		fi
+		return
+	fi
+        # Look for lines not matching test_filter_expect ignoring issues caused
+        # by empty output
+	tr -s ' ' '\n' < "$TMPDIR/perf.script" | grep '.' | \
+          grep -E -vm1 "^[^ ]*/($test_filter_expect|-|( *))/.*$" \
+          > "$TMPDIR/perf.script-filtered" || true
+	if [ -s "$TMPDIR/perf.script-filtered" ]
+	then
+		echo "Unexpected branch filter in script output"
+		cat "$TMPDIR/perf.script"
+		err=1
+		return
 	fi
 }
 
@@ -80,3 +116,6 @@ test_filter "any_ret"	"RET|COND_RET|SYSRET|ERET"
 test_filter "call,cond"		"CALL|SYSCALL|COND"
 test_filter "any_call,cond"		"CALL|IND_CALL|COND_CALL|IRQ|SYSCALL|COND"
 test_filter "cond,any_call,any_ret"	"COND|CALL|IND_CALL|COND_CALL|SYSCALL|IRQ|RET|COND_RET|SYSRET|ERET"
+
+cleanup
+exit $err
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

