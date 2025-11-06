Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A98335A146
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 23:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470971; cv=none; b=lMiNvsUTXaz9rObSWP1Ar10phqtWEnZBqeFsPFexhchOT56TmfPEG3W8CNcIlTQHUPfvr5j30r2pWfiBNMeYTMH3XrGzKtyiaw0u8XAAQVyFRIu+Hz2xJTgH2H5D2BdBR2e96sDGQ+Hp+zybwkSQv3AOxBX/2cIWycqd46DQebE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470971; c=relaxed/simple;
	bh=LLn9FDAlPcwSWZjUFvp9EB4XY1jJAmyC35CaM/eue2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Q6eFz6SvqurtNVTvXUZSGbf4/TvoeSVhx5fDtR5D0o3EDUesCd/B9lfg0+Rc7AWRqvItG2CH5FtXfDb/qh/gUrXAukfFpgvkX3MC962MORg1O59/a3f2E0wMHgeKsPIOi80E5Ok9UahGxX6VTnuyr7Uc3N2q4oudHWIw+cRIvI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1NLcQ74E; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1NLcQ74E"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-295fbc7d4abso1410085ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 15:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470970; x=1763075770; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Et4hjqXaxJjcCbzTA1Cjej6Oy43GlvxgQk6XgvQSd0=;
        b=1NLcQ74EZgycn3kNOtoGOgJIIjzLWz/BF7TUsHn9xcXkoq7AzNkTY6Wng8zgvJTDph
         uVw4D7ZP2mhh3r5Z04VJ11X7mjfKTc+ZOv0EDwEXvmExAPKkvT0SZekY8BmrqxTRnhd3
         UT71wtsvrrmF7sWrHxT++6ILcNA4DP+auE6wUnO5GzZRqRiItMWQOuY66IEwrW/rew7z
         9shjHLeqJ616FO2goCvdQHQtJEGKe8yWDKbnjsdI2unpZABp6GsmaZ0eUuV2B+v5ciC0
         P5tPCgz4WU2yw58mJVdIkMI6Tap2cHmoepDwilC1qyD4c5GBaL8evrK0yqJMmes06XLv
         6Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470970; x=1763075770;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Et4hjqXaxJjcCbzTA1Cjej6Oy43GlvxgQk6XgvQSd0=;
        b=aOIFD+yT8XPXAoO8E+6NCCEd9mKfVHJHHc0oerh8I3+BDCrppxlPEogo1p5YmCsBpT
         8+H0P29ax9GvU1asi8VvDHu/UhI+816PNn7mW/KaYssT5rT5olzHHDVOpOj0cbJdTpe1
         JklfQmkah+Fmc9RUeNHOS58buAZVIKLiwAH/vmYXTtlVTkdQhzSmLuQdMZJDvNJ+O4ii
         j9U7/F8rvXlVnyjRG0lhBvdtW1reYBeWAF0AVklgcT//luUu5y26tIdBIUeLtJkVo7Wb
         7HM3OMOjgZILuIxsTMGrAI0nBrz3G6NLU+xpBfehrkBX1b9NTu0NoF43jpgxzQpK7kXF
         D7Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWBETXXqeqlwUnf6INxjSMTTHkyKNqyFhvYgXduIozzcNu7MfOU6Q2unukFkYSMa5BhYnxPcpHHlgbl7ArzJdbv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2J0DUElKsrH8h90ERewGAEnbgnSY4t7HANwJuySJAgFQKVbbz
	wnzeVpto4A47AhW5ABGTZkURrA3Wve5vYPaV5SwXBd7vwvTSDDoXvBacLVT9DLpumjol96frq7b
	PvvVX+Fqt+Q==
X-Google-Smtp-Source: AGHT+IFCzEWuu8E6wOVwBRXCBSsioiFshS7Q4FDnLNqnIcuUiZKmhlPwpMmYDVVdcfSiH6o8aL2K6ccpLJe+
X-Received: from dlbqs13.prod.google.com ([2002:a05:7023:d0d:b0:119:b185:ea75])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dacf:b0:27e:ee83:fc80
 with SMTP id d9443c01a7336-297c04aaa05mr14080615ad.57.1762470969776; Thu, 06
 Nov 2025 15:16:09 -0800 (PST)
Date: Thu,  6 Nov 2025 15:15:06 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-17-irogers@google.com>
Subject: [PATCH v2 16/18] perf test stat: Update test expectations and events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

test_stat_record_report and test_stat_record_script used default
output which triggers a bug when sending metrics. As this isn't
relevant to the test switch to using named software events.

Update the match in test_hybrid as the cycles event is now cpu-cycles
to workaround potential ARM issues.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 8a100a7f2dc1..985adc02749e 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -18,7 +18,7 @@ test_default_stat() {
 
 test_stat_record_report() {
   echo "stat record and report test"
-  if ! perf stat record -o - true | perf stat report -i - 2>&1 | \
+  if ! perf stat record -e task-clock -o - true | perf stat report -i - 2>&1 | \
     grep -E -q "Performance counter stats for 'pipe':"
   then
     echo "stat record and report test [Failed]"
@@ -30,7 +30,7 @@ test_stat_record_report() {
 
 test_stat_record_script() {
   echo "stat record and script test"
-  if ! perf stat record -o - true | perf script -i - 2>&1 | \
+  if ! perf stat record -e task-clock -o - true | perf script -i - 2>&1 | \
     grep -E -q "CPU[[:space:]]+THREAD[[:space:]]+VAL[[:space:]]+ENA[[:space:]]+RUN[[:space:]]+TIME[[:space:]]+EVENT"
   then
     echo "stat record and script test [Failed]"
@@ -196,7 +196,7 @@ test_hybrid() {
   fi
 
   # Run default Perf stat
-  cycles_events=$(perf stat -- true 2>&1 | grep -E "/cycles/[uH]*|  cycles[:uH]*  " -c)
+  cycles_events=$(perf stat -a -- sleep 0.1 2>&1 | grep -E "/cpu-cycles/[uH]*|  cpu-cycles[:uH]*  " -c)
 
   # The expectation is that default output will have a cycles events on each
   # hybrid PMU. In situations with no cycles PMU events, like virtualized, this
-- 
2.51.2.1041.gc1ab5b90ca-goog

