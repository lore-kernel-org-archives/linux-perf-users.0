Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0E274248;
	Thu, 13 Feb 2025 23:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487630; cv=none; b=QRn/3wy+bcv3YE88e2rj+4nJOClQS+geNPHW4gGxpeP6Sti8FVM3Quxft79DCptJSiTSRXRXeZOVt+r/MILMY6F9eLHCODmeO0Zf2xyt1LRsudtgh1RkcV+mkWNFyZ+aq4zqo3nwiHkwJVslHKw3tZ7tGWJskcCqM+n5mwD4vY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487630; c=relaxed/simple;
	bh=ikG1TN6rDUOxIhapEuldyAS8weMydskL6gYwyosfnGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqEiTvSlPaDrQwTzMn7xAd3WEai3wFTZh2DNKSgirlHxDuEBlAr8GkaPe8/N4nO6jvnGctvFrLiocoUnBD0Va0pPVK9p+dHiDGh0lJzMPIEnIjqqqEix3j8k8Z2Tr+GJh4shGQmejky0zN0uXidnNJX2HeJcEd5wLwv7CMxuNzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9JsSv3M; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9JsSv3M"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220bff984a0so24867525ad.3;
        Thu, 13 Feb 2025 15:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739487628; x=1740092428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEFFMAJ36x+7ZOWQGJAZsnY5Yqg+IxQ7p+2U41q9RK4=;
        b=N9JsSv3MDUKQFp35g6f8TvawB89UuBaxIUnMiKvrlYoAzhCxZ1nsXe5pl2qRmEv7F0
         CmsCaIYkStjpA+HZwMpeJGivVwgt/PZILyalvmjk4de8CL3gjRZqdlrBL6vu5SwN6vwA
         B98O5l1TheA9RP8IWuyudGmv2VfSXEmZ5pUM6Q9bNs1YNuAOVWg9nmAtglLQuJkYXnon
         wCsZk7Z1trGc+TAoy6vE2EMeFO1MW1jblAx3nzN41wNN6CiH8/FCtqYuKfLCg5yGurgE
         jSmynDl5XnsmT+HcfcvHEkSbtxfWHkFclPVNCeCyI9yUdAxuitvEo4bsjCqxk1jllKO4
         Vg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739487628; x=1740092428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEFFMAJ36x+7ZOWQGJAZsnY5Yqg+IxQ7p+2U41q9RK4=;
        b=UjyihSzyXqF6D4Jp/i+s+2iu/08w7ArEs1kOXTgkqcfUJ+6cSl9jp7uiRO9Zao3nN2
         O/bxEjoUaDGO2fme9NUngXnfQ6fTIWY7qcD9bq0JZGB8QR1TEPXszGPB5XQTmdWkSO1G
         1T60AWuj/e8moRke3fWczUNo46cDR7vkZey4Gy2C7wnMFlq0JWFWPUHiET5YnzszLjaw
         mWQC58qJkf7V4vgiMA3CuNLtGId+i8pHm2pdq9QtX/WoCdA8US7uS3eTXXn1Mpcu5s2t
         5UbHdmwwEKgwx7uFyQ5xRq3qns+y4YG4DhL8ZZMBLaUkhyHMfuokUBZdJmPdEOTgTofq
         lZAA==
X-Forwarded-Encrypted: i=1; AJvYcCVWZw6m7nBsmh43O7613T5+n5hH1gMDOJbFSDC2aHzk7uTBD0AO5q6WaX92u4hgkTNdNm6f6zPrPxw7EtM8eZ1/vg==@vger.kernel.org, AJvYcCWXRAtQJCN5Jiov/CX9CovIIBOu14g3JEq1aP0LojsCNR5VMzLw9hEwGCKt6Fn7yyV5xg8NjvMJn9F55jA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1eu4cQVr3bghmvXCcp3WR05z29ct4t7T3+2QeLGGu38ArloSv
	p/QWP73mBkp5qM2AHin5W1Uvfyjrej5Xdd+qwOq8LOmQA6Q9gDJe
X-Gm-Gg: ASbGncsWULIiC15JrE2mLGWipvESs08uwZWOxpw3oFhbKbqUGLQGtFTi35HJmvWQUZ1
	wQH23kFKZkwVTV8Ydb9fWRjx/fg/mA+NNwDxWX7pO0nLLLpd9ULmj1XAhDM4aRVU4TKgjsVCRxG
	CEkRXiF+B4afA2MZuTNyi1G/TeFSY605X7bdxh2Sth+1QVExR32aEPwHwv7aQgo6WUImaIYbkZq
	PAoDP36sOn0SG0rSSYY3jOf79yisHi2qL6NvB8aWOSzH1EYKHTMqNxFSQ0GUpDSo0jhtY9ik6AE
	AQBbWaL1fMBLdb92Uoewaqy1ODQvE2Hh4cNiKp6favgXp8E=
X-Google-Smtp-Source: AGHT+IFohfSbEB1liEUcnA4N3fAQDj2EifKHmSJglbrdlBIoeSc+y8q6nOwXo2yUfPiX8FmEQftthw==
X-Received: by 2002:a17:903:1cc:b0:220:e9f5:263d with SMTP id d9443c01a7336-220e9f5288cmr21523915ad.7.1739487627614;
        Thu, 13 Feb 2025 15:00:27 -0800 (PST)
Received: from mbp.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5349210sm17641735ad.11.2025.02.13.15.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 15:00:27 -0800 (PST)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v15 10/10] perf test: Add direct off-cpu test
Date: Thu, 13 Feb 2025 15:00:09 -0800
Message-ID: <20250213230009.1450907-11-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250213230009.1450907-1-howardchu95@gmail.com>
References: <20250213230009.1450907-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Why is there a --off-cpu-thresh 2000?

We collect an off-cpu period __ONLY ONCE__, either in direct sample form,
or in accumulated form (in BPF stack trace map).

If I don't add --off-cpu-thresh 2000, the sample in the original test
goes into the ring buffer instead of the BPF stack trace map.

Additionally, when using -e dummy, the ring buffer is not open, causing
us to lose a sample.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241108204137.2444151-11-howardchu95@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/record_offcpu.sh | 71 +++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index 678947fe69ee..c5d6cae94c65 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -7,6 +7,9 @@ set -e
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 
+ts=$(printf "%u" $((~0 << 32))) # OFF_CPU_TIMESTAMP
+dummy_timestamp=${ts%???} # remove the last 3 digits to match perf script
+
 cleanup() {
   rm -f ${perfdata}
   rm -f ${perfdata}.old
@@ -19,6 +22,9 @@ trap_cleanup() {
 }
 trap trap_cleanup EXIT TERM INT
 
+test_over_thresh="Threshold test (over threshold)"
+test_below_thresh="Threshold test (below threshold)"
+
 test_offcpu_priv() {
   echo "Checking off-cpu privilege"
 
@@ -88,6 +94,63 @@ test_offcpu_child() {
   echo "Child task off-cpu test [Success]"
 }
 
+# task blocks longer than the --off-cpu-thresh, perf should collect a direct sample
+test_offcpu_over_thresh() {
+  echo "${test_over_thresh}"
+
+  # collect direct off-cpu samples for tasks blocked for more than 999ms
+  if ! perf record -e dummy --off-cpu --off-cpu-thresh 999 -o ${perfdata} -- sleep 1 2> /dev/null
+  then
+    echo "${test_over_thresh} [Failed record]"
+    err=1
+    return
+  fi
+  # direct sample's timestamp should be lower than the dummy_timestamp of the at-the-end sample
+  # check if a direct sample exists
+  if ! perf script --time "0, ${dummy_timestamp}" -i ${perfdata} -F event | grep -q "offcpu-time"
+  then
+    echo "${test_over_thresh} [Failed missing direct samples]"
+    err=1
+    return
+  fi
+  # there should only be one direct sample, and its period should be higher than off-cpu-thresh
+  if ! perf script --time "0, ${dummy_timestamp}" -i ${perfdata} -F period | \
+       awk '{ if (int($1) > 999000000) exit 0; else exit 1; }'
+  then
+    echo "${test_over_thresh} [Failed off-cpu time too short]"
+    err=1
+    return
+  fi
+  echo "${test_over_thresh} [Success]"
+}
+
+# task blocks shorter than the --off-cpu-thresh, perf should collect an at-the-end sample
+test_offcpu_below_thresh() {
+  echo "${test_below_thresh}"
+
+  # collect direct off-cpu samples for tasks blocked for more than 1.2s
+  if ! perf record -e dummy --off-cpu --off-cpu-thresh 12000 -o ${perfdata} -- sleep 1 2> /dev/null
+  then
+    echo "${test_below_thresh} [Failed record]"
+    err=1
+    return
+  fi
+  # see if there's an at-the-end sample
+  if ! perf script --time "${dummy_timestamp}," -i ${perfdata} -F event | grep -q 'offcpu-time'
+  then
+    echo "${test_below_thresh} [Failed at-the-end samples cannot be found]"
+    err=1
+    return
+  fi
+  # plus there shouldn't be any direct samples
+  if perf script --time "0, ${dummy_timestamp}" -i ${perfdata} -F event | grep -q 'offcpu-time'
+  then
+    echo "${test_below_thresh} [Failed direct samples are found when they shouldn't be]"
+    err=1
+    return
+  fi
+  echo "${test_below_thresh} [Success]"
+}
 
 test_offcpu_priv
 
@@ -99,5 +162,13 @@ if [ $err = 0 ]; then
   test_offcpu_child
 fi
 
+if [ $err = 0 ]; then
+  test_offcpu_over_thresh
+fi
+
+if [ $err = 0 ]; then
+  test_offcpu_below_thresh
+fi
+
 cleanup
 exit $err
-- 
2.45.2

