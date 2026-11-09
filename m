Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232110;
	b=C8o2YJtf334/SHxWay2Auau85O/eAriRKBr0qVLPCQDQhKBGEmp+6PxRwfPLy0GQVvnl
	 JhBixv1rb6JSMogNuXk6etcitiUjfrvJIcPzYfMqZVrNVb9E1C53JKV06bQ5OGo2hzhU7
	 8Y+tVm9s7B46/rMQRgkEloVt8MDeFrbPGBnDXsx0MY4Pbd8xwSkq2GlcdyZIpMrvJAYot
	 sPl+1fKXg+30vb9wNFQdNGZ9pTsobxIxyfRLaYnaEvMoQpb9P+mdk3rmcSmGmwfEcUn74
	 A7D0jdmgkbxCS+WS8oPJzJprW3kZOLQyfUeoaSu2n9aiDmi8wTbbOY0r6OJy77LTJvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=WIaieGGBZ//QGoNLj878zCBnNschlkTQti7AhZ3wdkI=;
	b=3iBO3sq3kzVTw1taNJGnTJ4g93Qwl23/3Qln8jR5zN+tdTrYHFwe7LcbIkCuYwpsYj+s
	 Um/uyS92OR7WQwX5yMt+FixMi8IRqltk/juU/MTmzDSmXnYC0UIk2glBwRhYIBMl/nnSY
	 f+lcu/XpUtU/luFR9RzCLfD0Vb6YhFe/Kp4yT+gH4NXWRkgvNtBVim82nCGgolgP1RW+Z
	 xrghMbG+5XsDWigZkV8OJcNLYLh64iecA//llZuzplkdQNfMzlTkeIF/TcvebEcWI75bt
	 N/yxc0OVbo9tQXpsMB5du+YPf5TN/gt2L68RJ1p33Ib7awE7urwU/W+mCS/bfMATpgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ePFmRO2P;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD47B606D824
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 13:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD47B606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ePFmRO2P
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4910b863b84so567458f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Nov 2026 05:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794232108; x=1794836908; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WIaieGGBZ//QGoNLj878zCBnNschlkTQti7AhZ3wdkI=;
        b=ePFmRO2PzqoskyTr5nfoHyPN26NaKc33xYWQaKs/0oQaOVgZlgqxcfsE0DQA42xS19
         lCEuU0cvWs8k6J9vlRVB5i58lkd8JVAT/KkXCHIj7VejyNWsyxOErkC5x++T6bMLuCQD
         ffpPbMrhdMnIYH7ZB/lmSPQ+p1elqIK8R/jNJaOhT7xZfQrMnz8HoVoEV32X1FnCUyUL
         S3EITV+8qf7EEjvGg5p4gbQTQqB/tlqcsY8aIB0y8PeiXiWFtJjQA81jr607q9JcnM6b
         gHGky26+s/mYEXpmFObIBVaK4Bnq0PcA0SBrx3ioQXJEhGebg6ovBTfjh4kDp3X7sdtM
         2Eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794232108; x=1794836908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WIaieGGBZ//QGoNLj878zCBnNschlkTQti7AhZ3wdkI=;
        b=uzjzmFRb7hG730G9xGy/XMOmaI4HgLRzgIv+lxmcdcNGQLNhmQRWn3kgjgcnpadfa5
         zHBm85gT5uPnUONfwg3KGUUPD3OdQvTxMzTDhIxGGhVFekQDt5psQEKKUMPPWvnZ7Maf
         wsJ0x4ijrck9sQCeC8x3Dyu6rJBQsso2VjHs7A8uX/TEfCKdpfvZrVJYGAktujbCVkwW
         2Y+7+pCA7DVnWBswx7F8Yh0qxUWqAmPAkoD7Ycbq9h6ZoX4HFQZxu6/NneyDaTgwjGq+
         AXLLhHQBe0gF6gTAxe4O2lzVZPT87Ot7zOGBBSps+5uFU+eYFWJ4nfcZoeO3oLYB9RAg
         4JEA==
X-Forwarded-Encrypted: i=1; AL+hErEYQyiIxHZVG27/Y/GbOpa+vDbrPq2iYG3z/u+i+c6et2ztYOKzhSywu64ILAlT01yIUj+yYOpQwFVnsASo/9qB@vger.kernel.org
X-Gm-Message-State: APuU4Z+OSiu5dUETyyuQQtcMFGBssEYHkl/9E95i4L32cY0sTDv6vWor
	5fJ1Q7WP0aUnQm3s8yYDp97rn6pW1rNq+mn7xZtooHKsljk2MYCx+p7OByhVm8XZaqg=
X-Gm-Gg: AYBFou0NCSyP/ehGifT6rpA6QwKxIUhRs6kuKR0WZTQAkEN3FugYYpG7eyhvXBhFHJK
	GLnuUANIkoiMRgAqPHE9RDEhbor+vmKo8hNyFEbabJguihXTZrhjqb3vKlfYZnQA7hJ8lSO5USt
	fN1PTDOplb4r2Hk7iPcS18Rb5+4x0kGchcvs0a9HZdEM+YKKy9c8SxdDdVSgtOmynJDYmcJOhx2
	uK2kJU+mhgUCI3JIENpjxGmZzTCD6Ys4QGHsPfPVWSvQsJB3WO51l7cWFW06mmT5asR6TaLDTjG
	bg29lm4+8k2ziBKX/DyJou0jTxiozyS9t218Sjm8foFtihwGavTUJ780RDGPsZczd2XJcISyqiB
	A9NVSAB5qPUN2aQvRWQUUkrqPGrT9TRAphnqBRjwa9/lErNsE0nh2ll4w1ZQRTCo6ZSTYBgXi6C
	Izt385JxKRnOCaYiOfws6Z41GjZ5XGR4R8JeGGEjso6PczFbkTYWM43Sj1cVPWqsFqTg7ti0CSc
	pQUePBQwadorFNvAVB3wkgBVXBwYUsNV7AQKlHkLeffx5otsr9UfXCGL90dyCdfuFzNNRvO332n
	tWoo+BPFLinR1Q2yeHJu5uQW0dOT3kFv
X-Received: by 2002:a05:600c:3111:b0:4a2:180a:3417 with SMTP id 5b1f17b1804b1-4b94d75ec90mr80947465e9.1.1794232108132;
        Mon, 09 Nov 2026 05:48:28 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7bb101537sm98522045e9.0.2026.11.09.05.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:48:27 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 09 Nov 2026 13:48:11 +0000
Subject: [PATCH v4 4/4] perf test: Don't starve per-process tests with
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
Message-Id: <20261109-james-perf-test-fixes-v4-4-355ee6b81917@linaro.org>
References: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
In-Reply-To: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
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

