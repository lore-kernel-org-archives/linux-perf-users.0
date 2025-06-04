Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F31920D4F8
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Jun 2025 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749059169; cv=none; b=mzp3Z94gdupE3wEbn0IPiPNRAtSmigMzGRvaeWQUc7w1/6iSHOXAXpmD6GBJER9DYH3A53teYYnFfZ26QV9a4L9rEv+phBOPcix7vCeXymcVf80c+Ra+UjjVsxfy+IXhcY2USw8dxYJhlsggSw3lz5CKxB2XQp1saHw4rAsBJHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749059169; c=relaxed/simple;
	bh=w7mIdHYnZOGol/D2dFdzxKVsmI/XyoD3LHHc9aNTcAU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=EW4uQkJa9gDvYWcPxQJQ04PYFNcSQ23QSf3n37lIAaJ2YJhB1j5iQrO+Kl5D1ZUY5yWg3zr+3+R5K/xkAyXqMKWiia5q8pccFo5PataG4RZiiBsM1NRNM/lup4Gqzb6/KZZKLRCgKnWBO9O8QpRA0cCwt74/AVGsu2Vjhi1dT10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MRXAODZN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRXAODZN"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b26e73d375aso37153a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Jun 2025 10:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749059167; x=1749663967; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q4nC0yFLc46sxQrP9IOJa66NsAsdDZBCoBLNutFpXGQ=;
        b=MRXAODZNjSP7X1Saah4zSrAk2kbb3GuAAwQoPdDYWXHGmWLtWq+swdJdhXWpKUlMMS
         32T6p/ZZQ5Gagr7CsfCYiQOLlr4DBMxRXwjAzqnW3/jRKl8gk0HpuZ+khXvb3fjmoqA3
         l6aHHyv4Uif14BFDPWltlsM3arznHDLfEgrxGTapDrmcuyoK4wKz8/U2nfQCHQV+Sc8w
         nBZ92doOqWMXUb7zl8U9QNP9PDqpKIdleNTdT1c9zlm7wpT4t9GIuYj2oLOv6rR5h1zV
         RsMabPHYF+13wLk/bDV2LBeqq3Foju5nHFQjPbQNHR9pAGfCKxoTVRCZ9gKp9/zZIoWq
         cVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749059167; x=1749663967;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4nC0yFLc46sxQrP9IOJa66NsAsdDZBCoBLNutFpXGQ=;
        b=Ip8CGZozwNngLeAQ5eFcnKeF0F4n4dbmDbo1ItwcuN3Hzx2IGQVCE6xLLlW53uL9oD
         RxXTv3sTHCDcsYMrgd0WgX/9J+c6RRwCOvfbDhaIRFpdvRr2yet+DMwcfnnxUHV5WI7o
         Xr9MGcQEkq5MeJlLrfQDsFoCSCYxLDCvFGv2p6ZqUhMIyzdZlZTtNxqYYLnsSBTkW4rZ
         3CTkRzSuCwf5tStSI8nHE94X71dMdkkcOx88ZsnB71upTUGYmz2Fb6jbJifZPFP+qw4j
         fD5JlxcWiz15FILV0HDG2siMmzCEw8ve5wOhnsCmgBs0dNTSU/DBGmM/2syNSXlTmi9D
         B8YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHN6nh9bY3QZoZ3xjfrW0e80Seed+XYh12iliq+Ww53RH53pGzO7/TseYIfNwjyYKjXv598ECEw1aatULWX/lp@vger.kernel.org
X-Gm-Message-State: AOJu0YwzxHHEi7zQ14lOWCrlbrP041/p7a5cg4OcHFfrzASsDUHiDKvM
	cNrNUnksY7Kg7iLAS66en5+bxP82gKnTRlqpVTMFaJU+4gjIxkqlE9CtLrtFmh+5G4gmwzWRnis
	kGtkq2l2SwQ==
X-Google-Smtp-Source: AGHT+IHezvR+eTPfCS3Vq8TwC31u+IqeQ3bdfYHNH41ei/61+xbUnxM56xS7y/HR/6GQ10xXZnPrjjh9vTUm
X-Received: from pgbfe26.prod.google.com ([2002:a05:6a02:289a:b0:b2c:40c4:8bb4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:328b:b0:20b:9774:ac6c
 with SMTP id adf61e73a8af0-21d22aa2f8bmr5219599637.5.1749059167416; Wed, 04
 Jun 2025 10:46:07 -0700 (PDT)
Date: Wed,  4 Jun 2025 10:45:39 -0700
In-Reply-To: <20250604174545.2853620-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604174545.2853620-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604174545.2853620-6-irogers@google.com>
Subject: [PATCH v4 05/10] perf tests record: Add basic uid filtering test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Chun-Tse Shao <ctshao@google.com>, Leo Yan <leo.yan@arm.com>, 
	Hao Ge <gehao@kylinos.cn>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Gautam Menghani <gautam@linux.ibm.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Based on the system-wide test with changes around how failure is
handled as BPF permissions are a bigger issue than perf event
paranoia.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 587f62e34414..2022a4f739be 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -231,6 +231,31 @@ test_cgroup() {
   echo "Cgroup sampling test [Success]"
 }
 
+test_uid() {
+  echo "Uid sampling test"
+  if ! perf record -aB --synth=no --uid "$(id -u)" -o "${perfdata}" ${testprog} \
+    > "${script_output}" 2>&1
+  then
+    if grep -q "libbpf.*EPERM" "${script_output}"
+    then
+      echo "Uid sampling [Skipped permissions]"
+      return
+    else
+      echo "Uid sampling [Failed to record]"
+      err=1
+      # cat "${script_output}"
+      return
+    fi
+  fi
+  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
+  then
+    echo "Uid sampling [Failed missing output]"
+    err=1
+    return
+  fi
+  echo "Uid sampling test [Success]"
+}
+
 test_leader_sampling() {
   echo "Basic leader sampling test"
   if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
@@ -345,6 +370,7 @@ test_system_wide
 test_workload
 test_branch_counter
 test_cgroup
+test_uid
 test_leader_sampling
 test_topdown_leader_sampling
 test_precise_max
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog

