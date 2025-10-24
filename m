Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA54B34EEFD
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 17:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328788; cv=none; b=AiU9HB9JuClM5ks9OtYkOKPbman9/bJNDfVZWSedQTerd/TuHkC88uCdP8FfG94GxFScC8CvlVu5llcYf9D3Q72jAqm9VlzWZjCqKOW59OU7N7n5mtDxTLZxlwE3YBpcfl5Kph8VCYG1dIR8SStLY5BZr6EYl2z1QahJrnjkeac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328788; c=relaxed/simple;
	bh=q1O8hLkBKOlhvk1PqTzz9AoGYbVsRGA0an5mkJTkoys=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=KLwfc0j1xV1Okw2wjoPepms52iLtMPG0O0mtZlneOHcywwws2vxCSIOEo6q4KO8fW2zCwmdJVDyyJ1NOoz/gm278JuHH4Rd9eTG+bm4OZBTZbCGcN75AiYSuKtwFnZSHa2+6fjh+sT/4CCBL1lY8eOUnmCZPd1g+8iqNGC7W4ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jtkJoI7I; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtkJoI7I"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33da1f30fdfso4973678a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 10:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328786; x=1761933586; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JmyzXEiuEakA9tINxzGZRCYfGFH2n3X7HRR3W7fGH50=;
        b=jtkJoI7I7p/P6Q4D+f/Dis7rpvxBAJT2Ykr+4jhpUocsi6nwyQ3tP7jJaU/KdJo8Ua
         wlyOetOYn9h02TeCZZo2Tp4QFMGPh1ySdk2A7SBYU4en9dKjZKKJlvTsG2DKq48jiBXI
         ZAEYE1wQiW82Hcr8MpSQrz+V/F6/YiK9Q5QRlndOvMceifM4hXHHmVXIK4PSFb7q+Cu/
         BaZCTrpFUY6sNq3XtULNFA7OHfa7RlcoAJwgIHz0xdX8NFXVI5a3G5uIQs5bKAABZb9v
         gtCdab0MiBPg+JQpB0RXIQfCKNbP8+Bd5VMu88fERR7Dcyguxar9MSyB1anV7Q9OP1bP
         CDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328786; x=1761933586;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JmyzXEiuEakA9tINxzGZRCYfGFH2n3X7HRR3W7fGH50=;
        b=UfKHoH5NdbZhVQBjes4OSa4VMoix2ILkYbnCAJ2h7ew+6COR45E+aNQ5qHpk+wB0v4
         x1qD297BECPIOXCW8rvp4hnrB03x4b4P1rusdarEXE+LKW3swNJBuhngOsdF6j3avtM9
         V+JZWc+cPn6Ggc36/P6E6+vqK1t6+Yj9j2t6O5Q2LFCcGaW/ty9ONUW2etzgcff3Y9LP
         t8BIv+dPAvArMhLyUJLDwHpUTl7mFbflgUKAUhoTb3AqNDTEHE46QkeaWHohvwohO5x5
         GkXTtj+NiZeHhIU4oZ0nMoQzenoNiPfy53t2jhyFabYom2kCiZmxtXuKxXWKcU1e0eOT
         alQQ==
X-Forwarded-Encrypted: i=1; AJvYcCULpVQl5v8/TQYDqZ8fkzgciLQ7QklGRuC2efabZdQxyPJ+A81qLTtlLjxKcCvx6XB9wq49d/WnyF0g1V9Hb57n@vger.kernel.org
X-Gm-Message-State: AOJu0YwjsVbplUlCy+/ASGEwVIDpy6/dQ0r8imR7/9DyE8qzy8+lEJRQ
	m0yWJx+zko55gYDVbtbVFmRxgzkLbgA442lLHThggwUWHcVoKwdO76KhubVuoJUBaQDuz/MyBpc
	TRTkzNararw==
X-Google-Smtp-Source: AGHT+IH3T1XEJnZO2R7yqtTin61a3Kd5JkyUZzfnB4kDi6C1ujwkEp7c2F6yvCfiEiGjcWhl+v0wQOEZtd3X
X-Received: from pjbqn7.prod.google.com ([2002:a17:90b:3d47:b0:339:ee5f:ec32])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d0e:b0:32b:c9c0:2a11
 with SMTP id 98e67ed59e1d1-33bcf84e114mr40783160a91.4.1761328786458; Fri, 24
 Oct 2025 10:59:46 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:56 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-22-irogers@google.com>
Subject: [PATCH v1 21/22] perf test stat: Update test expectations and events
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
	linux-perf-users@vger.kernel.org
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
2.51.1.821.gb6fe4d2222-goog

