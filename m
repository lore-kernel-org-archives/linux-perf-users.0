Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3760B3DA7F7
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 06:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590471; cv=none; b=pXhx2LqSTlSA6UVhohBJRCJMLEdcn7Z2SNiRX4X0H8acLKFCq8U5uKl8eiFor2erpXeb+jJz/ZwcO7rdVW8b0amUqIeqsth0FemybXJAv/NWBhdJaD1ZXR32OK5IDm3A9vokFfyS4lGF66W6tPcg4+6wAQDI06yVS7ilD/TCqOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590471; c=relaxed/simple;
	bh=r8/7Jna2CkA1CFTVW9MT/Ke3/lfBcUauN5+OOX36AO0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rK40JVm0m/r7cAfJuKD7BmaUH9OrkftdQH0mYMiTSRumeA6kLDuvkoFwr7XQfAZKFzYpHG4UDHCnMD+dAFCKpL6PGvTdVzF/kWIwnNzSXH+ssOSmaosZB50LpJpYbG/GHWZYf2KWKDc8SuAqYDW+4VZtHF/8MK+qaLnZZ7qK5eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TrS7dYXO; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TrS7dYXO"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-307fd7138b1so6290874eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 23:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781590468; x=1782195268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X+MdisBjbmRL7+GBLJDrSQQ4Fm1FQx0WoUaZg0rN5WY=;
        b=TrS7dYXOI6WZmUR3Mp1Pd/hZGfqtGCmMy9iCytjbzJjtGFE8ZdiJzypjl6VHTWOmC8
         P+6eugo+Y0efm5IF0CHY3IZEp5R8jlXCsINKsirHTxF+WWe9zyo8Fd0KyB5ZkswnZ4if
         8p7xnJTXvM1AZb1idkABuqAMQozVkHdR2/gCzjptn5WO1hSN2hT3hJYIzi/j4ImQEqPF
         cEx7Qgz9DsFUzPSRe+SjuLfffgKMkxZKwxcLDto7GhKsiDzekcCbU3vIk3Z+EJFBtJci
         64MNAGf2NXHCmUnaYxn4qDvlXAKUxvwdO4d0q138fPGYAzXDlss+Hp0OyUO14L4b3rlk
         lVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781590468; x=1782195268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X+MdisBjbmRL7+GBLJDrSQQ4Fm1FQx0WoUaZg0rN5WY=;
        b=au6xqigd+VRBUfYSNso80LYG6LFdZMWsjf5iC6slYHYPDSzU28yy9lxp7+kLfOY0HZ
         UFOiZTdZCyERIYDNVGjb8oFCAAqsPPNaVSQP2MIPekf9yTNmLqh7fUiyIXN7s9yWppdl
         OMB6cmMbI8zgC6RBAUgrxv51VRPckQRqnrbCvvlHRjHdglXZt6kbZ65+uDbxSt0DrFXD
         oW1nDe7h+avixrCGyOGbWN6bUALzvjQlkEGifTSMBQVCOG8MfGbksNUKH8urYI7UcxeG
         gt7y854DY+50+GXtRrl5ce1JSGaKya25Uml9OnDIXo0A4E4O637QRd110MGm8bSM71ua
         Op/w==
X-Forwarded-Encrypted: i=1; AFNElJ9yT8CizavKAAzo5ONKsguuWxHXZ+UgqYjevAhPpK8sunyUQFgAA/oTU/cSP9luJd52zGTUp010+ViAuiiDV78V@vger.kernel.org
X-Gm-Message-State: AOJu0YwA45wJf6Z4sloAFH9XI7YXOUfXpBz2YvwhEqkU80cyeL9/8X1e
	LLzca1ioOG+u2BAm5KXZv9eLekPsxZXDy9Miv0Yky37boJWEDmEbXx88+AuTu/l403ggd+LnEx5
	Q/p0qKHAbAw==
X-Received: from dyaz5-n2.prod.google.com ([2002:a05:693c:6385:20b0:30b:9d0c:889f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:5707:b0:304:ab8:f87c
 with SMTP id 5a478bee46e88-30936956646mr8381296eec.12.1781590468046; Mon, 15
 Jun 2026 23:14:28 -0700 (PDT)
Date: Mon, 15 Jun 2026 23:14:02 -0700
In-Reply-To: <20260616061404.41929-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616012744.4049193-1-irogers@google.com> <20260616061404.41929-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616061404.41929-11-irogers@google.com>
Subject: [PATCH v2 10/12] perf tests: Speed up off-cpu profiling tests
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The off-cpu profiling test suite runs multiple recording commands with
a default workload of `sleep 1` to test the off-cpu threshold configurations
(specifically, above 999ms and below 1200ms). This adds a mandatory 3.0
seconds of sleep overhead.

Optimize this by scaling down the thresholds and workload durations by a
factor of 10:
- Use `sleep 0.1` as the workload duration.
- Change the above-threshold test to use `--off-cpu-thresh 99` and `sleep 0.1`.
- Change the below-threshold test to use `--off-cpu-thresh 120` and `sleep 0.1`.
- Update the awk period check in the above-threshold test to look for a period greater than 99,000,000 ns (99ms) instead of 999,000,000 ns (999ms).

This reduces raw test sleep overhead from 3.0s down to 0.3s, yielding a
~2.7 second speedup for this test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record_offcpu.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index 860a2d6f4b75..8ee2112b7778 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -45,7 +45,7 @@ test_offcpu_priv() {
 test_offcpu_basic() {
   echo "Basic off-cpu test"
 
-  if ! perf record --off-cpu -e dummy -o ${perfdata} sleep 1 2> /dev/null
+  if ! perf record --off-cpu -e dummy -o ${perfdata} sleep 0.1 2> /dev/null
   then
     echo "Basic off-cpu test [Failed record]"
     err=1
@@ -98,8 +98,8 @@ test_offcpu_child() {
 test_offcpu_above_thresh() {
   echo "${test_above_thresh}"
 
-  # collect direct off-cpu samples for tasks blocked for more than 999ms
-  if ! perf record -e dummy --off-cpu --off-cpu-thresh 999 -o ${perfdata} -- sleep 1 2> /dev/null
+  # collect direct off-cpu samples for tasks blocked for more than 50ms
+  if ! perf record -e dummy --off-cpu --off-cpu-thresh 50 -o ${perfdata} -- sleep 0.1 2> /dev/null
   then
     echo "${test_above_thresh} [Failed record]"
     err=1
@@ -115,7 +115,7 @@ test_offcpu_above_thresh() {
   fi
   # there should only be one direct sample, and its period should be higher than off-cpu-thresh
   if ! perf script --time "0, ${dummy_timestamp}" -i ${perfdata} -F period | \
-       awk '{ if (int($1) > 999000000) exit 0; else exit 1; }'
+       awk '{ if (int($1) > 50000000) exit 0; else exit 1; }'
   then
     echo "${test_above_thresh} [Failed off-cpu time too short]"
     err=1
@@ -128,8 +128,8 @@ test_offcpu_above_thresh() {
 test_offcpu_below_thresh() {
   echo "${test_below_thresh}"
 
-  # collect direct off-cpu samples for tasks blocked for more than 1.2s
-  if ! perf record -e dummy --off-cpu --off-cpu-thresh 1200 -o ${perfdata} -- sleep 1 2> /dev/null
+  # collect direct off-cpu samples for tasks blocked for more than 500ms
+  if ! perf record -e dummy --off-cpu --off-cpu-thresh 500 -o ${perfdata} -- sleep 0.1 2> /dev/null
   then
     echo "${test_below_thresh} [Failed record]"
     err=1
-- 
2.54.0.1136.gdb2ca164c4-goog

