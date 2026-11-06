Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962121;
	b=Ha3btFTIJpdKh45ANGSKMTdIHp9qPjWEFZTp9Xe2Nf7f+B8N6y2PYKgQ1hki3OOoS3Xf
	 kPTMFIpjfzIhRhPCQ1ujXBrCWjxwNNWQit74x+NAUw7toFbaE0tPCbJGnFV8FPnuQui6G
	 bBFL+g/Dz56DGk6lnptQ/p2K/QxV62x03AXzcvR87bSaPqgNse1u5e9MNR/VUTISs/p5+
	 u0wF1JYawwz4zZ/d1JDou8nzgH/Tvb3XWbI93FX93AVmLcS3eJ6vb/tqNzLafU7hD09Cc
	 fPzY2RrQdixGQanOtQNrK6SpSN2jXhw1iQSOjK5kZCTfHLO/xzdmt/axHBYwGsMBnIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=WIaieGGBZ//QGoNLj878zCBnNschlkTQti7AhZ3wdkI=;
	b=odAKZ0VqM8VtHD0LblLWi6aBh3sXxJ4Cbpq92qq7YVoCSolXAkOkuwtdJN6x9RqWG7XN
	 5HkZ6/28nPjcXTNFAU3H5h0kXKT1Yf1p0Q9oNsC/t5Qxye1S1jbpAHrbh5K76W8movhKN
	 fTqhyOk0wF6eYNGgHTtyY9ebnYjY+yuZ4p1yrLFqApWx3RLuYbsyS+T35OhV4a29NuTiI
	 ZwJELhIeexUmJw7806TC7vGdW/BqtKadzw8duGCwRx/CV7rnqssMYNKsX3D0AUv7eHFf/
	 UZSJzlySG6lcVqXIgB1M95ZrNWTpDB0nkTPC0H8ZqGtLQMV+U7p+M4pxn3GDGGbK19g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fyJ6tW+C;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54B606EEA1
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 10:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F54B606EEA1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fyJ6tW+C
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4922dbcee23so256285f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 02:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793962120; x=1794566920; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WIaieGGBZ//QGoNLj878zCBnNschlkTQti7AhZ3wdkI=;
        b=fyJ6tW+Ceau7nBdlIjAZ3IVJchO+6mMOJ1SK1lOTAW4EpwyoyVfWU6kHu9uKA+rNYA
         3W+fIQAi+wjxlB1/LMRGLu+9D72DySrdd4kweKAb6wo0NuhMdCiAD7PhYRc+KR+nnm2E
         TM0lPPgcuEtnQ3Iudgf88ErsIWNV2Hmk0BrcIHti7AdekPwufCm1Z7D7kaJRE8oqfMSC
         8u4Q6LyU3i59k2skIWHvveVKriEQceuUzxrY1xO16UlypF+9/r+2fgs/S3ZU8hJBiipn
         qLgYQ9Izn4ifvHmp2hWJfD4TaE87/7yaentXSYr3PkMydXdgEMY0jvliLEnbDlO39XIh
         DpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793962120; x=1794566920;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WIaieGGBZ//QGoNLj878zCBnNschlkTQti7AhZ3wdkI=;
        b=icb3xeeYpqhdfmK7qkgSke1Dbik6DQ9EiyoUmycvSw9zrycB8vS53xIzX257yHzjZ5
         U0mGRG5BkznCliDKS9Ho+TPVcwH0OPM+bjvM2yRTDHYRyXiiRmUcC8Qw4ihi/JyP55jM
         KMGeIZ7EEvLL6BQhNCe6SHxru6ZfPJKboLnxWB8ydRV2Eobjv++kRpYzo3C7kDOg4BeT
         p44dHqIpbsS/1ArruMP7Q+GJys4Zm8X/WPdW1mODeXTWr9IkjMBnayZi8mJhIKk7nWvK
         sSRJ3+RNrYfOYlg4ypLgLo9wTT5TelORNWZUY637moAYhgvcnKTyeb+pqWHIQ8VJuvEq
         mzMw==
X-Forwarded-Encrypted: i=1; AL+hErHGvbTXH/sYw+ReAKQFEFJ2Dkjt2uk6FwwCvcTJQCU0F7h9GO7AIe/m6YvZA/FMOrvbCVmUwaOja63I81Ayi18U@vger.kernel.org
X-Gm-Message-State: APuU4Z/ppvpf+NUK4RNK6DWYyDo8rzK1U8js/rdPQzCnlc5UfU/KvNaN
	saCeNvL1JTeO6ntc+JGIXB9szHvD2Ac8dSJUD/2HQZk0t4O87olEoaqTn1Qjst1H1Pg=
X-Gm-Gg: AYBFou2ciLfpSkIqbdrM9JMZC7xry68nkYcBgJJLsjdVfDP7xxOY9zw76FxiZQgve7O
	ce+w4ZRi/c2ao9AVr4dhy/rC9iMnQovofgBvwK33/fCRYGvmV2qK3zOYFfHl3pNWp/X/FB/b3LD
	99hUsRcc1pR7YafMrS0QvuVkLJvo51xr3n+OuuI1RmFWvgKPYPsXVzEa0DSihEAuMoAT7uCCdMX
	cvN4bO36IGbPE1FePU3gxpxZIkM7mH2//2js3rATwXz0LG3qcd4VRiXsb5eojCbhF6gz52oiqJJ
	V6DwRUGDE57LWkoo3sH2OalH2mJj2M0Zc6pO3c5yVP+pAU2h2Gz8iiDzdcMudzqwyUb14xMfhlt
	kdz20vybd+zKSJH695vHLvozhVS9Ony0ZeNeKr0YL+hTt75nc0HhizSPsN+D9xrL+G3Ffy3rJ7i
	Np5FplJTH7XXxMGSpchk/I9iFy466A9/BXD4KLqd6hfrmXklu42/MgMUqxQoBjtanbpTo1ku6IM
	GoZ7RN6Rmc8JkwI2rL3MwQoQUoorVnAa+cJSDqgwlIsdtQe5BxZfO69PQ5vEkRVXhvx1vQq3TAj
	N15/2/X3p9pfNTbAwaOa7CilibAFU10d
X-Received: by 2002:a05:6000:46d7:b0:48e:21f7:79ff with SMTP id ffacd0b85a97d-49277123e64mr3043355f8f.33.1793962119602;
        Fri, 06 Nov 2026 02:48:39 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d6d63ae2sm3232248f8f.11.2026.11.06.02.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 02:48:39 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 06 Nov 2026 10:48:10 +0000
Subject: [PATCH v2 4/4] perf test: Don't starve per-process tests with
 system-wide events
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-james-perf-test-fixes-v2-4-9a912662f822@linaro.org>
References: <20261106-james-perf-test-fixes-v2-0-9a912662f822@linaro.org>
In-Reply-To: <20261106-james-perf-test-fixes-v2-0-9a912662f822@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Jakub Brnak <jbrnak@redhat.com>, 
 Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Some tests intermittently fail when run in parallel, for example "Check
branch stack sampling" fails with no branches recorded at all.

The default event is cycles:P which there may only be 1 or 2 HW counters
for on Intel because it's precise. System wide or per-core precise
events hog the HW counter leaving other per-process tests with no
samples. Rather than make all the tests that use default record commands
run serially, just make the system wide ones use a software event which
has the greatest possible compatibility. They don't need precise
sampling or HW counters anyway. The per-process tests can be left alone
as their events/processes never run concurrently on any one core.

The LBR filter is another resource shared by all events on a CPU, and
the system-wide LBR test uses different filters to the per-process
branch stack test, so mark the LBR test as exclusive.

This fixes the "Check branch stack sampling" test and other flakes when
a system-wide record from another test runs at the same time, for
example:

  $ sudo perf record -a -o /dev/null -- sleep 30 &
  $ sudo perf test -vvv "Check branch stack sampling"
  ...
  Testing user branch stack sampling
  ERROR: Branches missing ^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$
  ...
  Testing user branch stack sampling [Failed]
  ...
  Testing branch stack filtering permutation (call,CALL|SYSCALL)
  Testing branch stack filtering [Failed empty script output]
  ...
  ---- end(-1) ----
  138: Check branch stack sampling : FAILED!

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/record.sh          | 6 +++---
 tools/perf/tests/shell/record_lbr.sh      | 2 +-
 tools/perf/tests/shell/record_sideband.sh | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 01dc3e22fa73..e4789e2bcf43 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -388,7 +388,7 @@ test_system_wide() {
   echo "Basic --system-wide mode test"
   local ret=0
   perf_record_with_retry "${perfdata}" "check_system_wide" "perf test -w thloop" \
-    -aB --synth=no || ret=$?
+    -aB --synth=no -e cpu-clock || ret=$?
   if [ $ret -eq 2 ]; then
     echo "System-wide record [Skipped not supported]"
     return
@@ -471,7 +471,7 @@ test_cgroup() {
   echo "Cgroup sampling test"
   local ret=0
   perf_record_with_retry "${perfdata}" "check_cgroup" "perf test -w thloop" \
-    -aB --synth=cgroup --all-cgroups || ret=$?
+    -aB --synth=cgroup --all-cgroups -e cpu-clock || ret=$?
   if [ $ret -eq 2 ]; then
     echo "Cgroup sampling [Skipped not supported]"
     return
@@ -491,7 +491,7 @@ test_uid() {
   echo "Uid sampling test"
   local ret=0
   perf_record_with_retry "${perfdata}" "check_uid" "perf test -w thloop" \
-    -aB --synth=no --uid "$(id -u)" || ret=$?
+    -aB --synth=no --uid "$(id -u)" -e cpu-clock || ret=$?
   if [ $ret -eq 2 ]; then
     local logfile="${PERF_RECORD_LOGS[${#PERF_RECORD_LOGS[@]}-1]}"
     if grep -q -E "libbpf.*EPERM|Access to performance monitoring" "$logfile" || \
diff --git a/tools/perf/tests/shell/record_lbr.sh b/tools/perf/tests/shell/record_lbr.sh
index 8d51afeb437b..6b6af59db871 100755
--- a/tools/perf/tests/shell/record_lbr.sh
+++ b/tools/perf/tests/shell/record_lbr.sh
@@ -1,6 +1,6 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
-# perf record LBR tests
+# perf record LBR tests (exclusive)
 
 set -e
 
diff --git a/tools/perf/tests/shell/record_sideband.sh b/tools/perf/tests/shell/record_sideband.sh
index 2182551873be..f16889e3fa9a 100755
--- a/tools/perf/tests/shell/record_sideband.sh
+++ b/tools/perf/tests/shell/record_sideband.sh
@@ -22,7 +22,7 @@ trap trap_cleanup EXIT TERM INT
 
 can_cpu_wide()
 {
-    if ! perf record -o ${perfdata} -BN --no-bpf-event -C $1 true > /dev/null 2>&1
+    if ! perf record -o ${perfdata} -BN --no-bpf-event -e cpu-clock -C $1 true > /dev/null 2>&1
     then
         echo "record sideband test [Skipped cannot record cpu$1]"
         err=2
@@ -39,7 +39,7 @@ test_system_wide_tracking()
     can_cpu_wide 1 || return 0
 
     # Record on CPU 0 a task running on CPU 1
-    perf record -BN --no-bpf-event -o ${perfdata} -C 0 -- taskset --cpu-list 1 true
+    perf record -BN --no-bpf-event -e cpu-clock -o ${perfdata} -C 0 -- taskset --cpu-list 1 true
 
     # Should get MMAP events from CPU 1
     mmap_cnt=`perf script -i ${perfdata} --show-mmap-events -C 1 2>/dev/null | grep MMAP | wc -l`

-- 
2.43.0

