Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B4384CCE
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 01:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178105; cv=none; b=Ig9EnMvYRI4IOn7Xr/5r7JaJkkPRImzub8QbU61I45icFcRMzKLI6UVFZt7bBWVJcS0iHch7W9/5AvQ+88MzwxYkgoKuH6H9NVHquL1SB5GHFIJEU/p0io8PK5g2SXKF+LuC8egwk6nhRFh2FGWVDD1pXi0oKgR17OUOyd20Xdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178105; c=relaxed/simple;
	bh=if3rDbY0mAw7oekpT1KT2ElTNt9kO50FQyJflBN7lwI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oAW/U3SUHZYw66TapN/aep21xBlSUHvuRECCwEZKFpIDMkvk//UOlNAfVKQluZ1VPDPVA9uUVe1vbRkJfKSdbs4nIhjs6TrIhIWrwd3/NnsjUaXhZSvsM8ltpNX+b1dHxixlFbe/bgv9E4iz18FucXGkB33bv5jEwApNeXBrNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q8ULVMnS; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8ULVMnS"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30c13bb8ca9so5335728eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 18:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782178104; x=1782782904; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EJI5wToLjPh41STLj4ZBoAO3UZy1WhJlHVJQcalDvFU=;
        b=q8ULVMnSF16rDZeZYCtJnHGiSfTeEV3ajYVCyMS+KBhDcr5c2sQ3aNitrHODNz2YK2
         POuTmPrzf/SaV1ZNC43BqAqFJdkeSrVYRDmyIQlm4TvG2zouLRPRpQUj0fmhrPGCKGoN
         CIHKt6jneMn3r/iPG5yrqt9hy/+CzA6wa8qjjvx+FddFGOx+ie8uRwUPtuzcuGB/5m0D
         M2mCAaqHgrhSaU5q2maWHVT9y9fsON0bpsx6+q96IJrJ2jB+ADKLSZmpvcqcynANZe6F
         6IH7m0VW2rRhJ24CWwCqzDDjX1jcwd538PvfGrVT8pvGj5YLmUnokkBaRFYfuAqiyDYr
         DE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782178104; x=1782782904;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJI5wToLjPh41STLj4ZBoAO3UZy1WhJlHVJQcalDvFU=;
        b=SC3uewk47EPsJN9JrAmz88qchdOPAqZXbirwHkH/zorWvs7zXa9ZaI0gtRd8Lv/acE
         dqGbMV+3Rvt7zZumYhw+tZzYPDkgIPjR6On7vG3x3cwLoPQqK7mncu/A1udqlmDrV8pO
         hEZZahCiap4UCs/G4jEmMBb/9bGK4zlZzsBXfrCyILhDj3O5386NxI4dgrXQd6hpb9KC
         ou9nGUUmxmm7RfGDPlmT9CoZUCz/sxlgzA2VTufhrH6179E/BeYCwpXRZIsKUyMwZKfq
         HKDWjQ7+hkE/kFzhQpUyt/FCKwuUq8JfnDT91XepZ9WRcaj/Pv1dQrU2wTg2xSVMvV89
         /esg==
X-Forwarded-Encrypted: i=1; AHgh+RqOFn4g/M8xvYqdYIyz2TxOnyBAkFfiXgjUGNCYxvkGTs43vTUQMgUB2AGy0WzF3Al6XgaauTROIYkq5/YFzF+U@vger.kernel.org
X-Gm-Message-State: AOJu0YybqIQ/GzK9FqhjkmfkoReBiA2okkHk6leppIK+ONVKNy6bd7SV
	lgVQTm1keB1WYsajxAZq1M+sb7ScWkUES/vviWauNf4XkmOTgFG3yzaynVW8/kgnhAtpwxWvvpw
	pyN/RWtT9bA==
X-Received: from dybay34.prod.google.com ([2002:a05:7300:2d22:b0:30b:d3ee:4af8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6c12:b0:307:e4fa:894b
 with SMTP id 5a478bee46e88-30c5bb41657mr206836eec.8.1782178103215; Mon, 22
 Jun 2026 18:28:23 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:27:55 -0700
In-Reply-To: <20260623012758.2291858-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616164819.370939-1-irogers@google.com> <20260623012758.2291858-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623012758.2291858-11-irogers@google.com>
Subject: [PATCH v4 10/13] perf tests: Speed up off-cpu profiling tests
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The off-cpu profiling test suite runs multiple recording commands with a
default workload of `sleep 1` to test the off-cpu threshold configurations
(specifically, above 999ms and below 1200ms). This adds a mandatory 3.0
seconds of sleep overhead.

Optimize this by scaling down the thresholds and workload durations by a
factor of 10:
- Use `sleep 0.1` as the workload duration.
- Change the above-threshold test to use `--off-cpu-thresh 50` and `sleep
  0.1`.
- Change the below-threshold test to use `--off-cpu-thresh 500` and `sleep
  0.1`.
- Update the awk period check in the above-threshold test to look for a
  period greater than 50,000,000 ns (50ms) instead of 999,000,000 ns
  (999ms).

This reduces raw test sleep overhead from 3.0s down to 0.3s, yielding a
~2.7 second speedup for this test.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record_offcpu.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index 860a2d6f4b75..ee095df47358 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -45,7 +45,7 @@ test_offcpu_priv() {
 test_offcpu_basic() {
   echo "Basic off-cpu test"
 
-  if ! perf record --off-cpu -e dummy -o ${perfdata} sleep 1 2> /dev/null
+  if ! perf record --off-cpu -e dummy -o ${perfdata} sleep 0.3 2> /dev/null
   then
     echo "Basic off-cpu test [Failed record]"
     err=1
@@ -57,7 +57,7 @@ test_offcpu_basic() {
     err=1
     return
   fi
-  if ! perf report -i ${perfdata} -q --percent-limit=90 | grep -E -q sleep
+  if ! perf report -i ${perfdata} -q --percent-limit=70 | grep -E -q sleep
   then
     echo "Basic off-cpu test [Failed missing output]"
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
2.55.0.rc0.786.g65d90a0328-goog

