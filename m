Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A380F35A140
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470968; cv=none; b=jOL8hD7KI6gWEhTExfmF/v0JDHhjjECVqZ5LfL+G99l6h3oSWLEoYh+bA+Pk9Wg3mGsEuiC4kz8av5H159W67JwLd+BvrEjq9mF3Cegb5UVjy9pcxnvLFyryA7NDDJ5gKAVxCZq38hGE5hcjIcdNZmcn9NB9zngH04aXJZtnVNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470968; c=relaxed/simple;
	bh=7NP/VCWcDtaQ9ddY1vDzUSspDiDop3c4KIH6lorm7/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=d+A/PctZxeqdhxr0VX/qblBwKA0JSB0SiFr7aTo31o4SE1Jt7Q39KGN2wnK2W9/vexEpxlUSjyZ4te0vF/J/BCZGVrHuE7fQAgXWRlyBkpysWanFzYteEY9CGfnAP6q3jArwZcS922+9/vS43BUXInTGkwOgvvD8v5oYHn69rsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xeMaEbx0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xeMaEbx0"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b969f3f5c13so164691a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 15:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470964; x=1763075764; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bf2tG0VSbGuTREXl21iJqSVPQmFIFuxPe8RAulQFiSU=;
        b=xeMaEbx08Izr0EBYBeICtvQU6q+mCCr8H/B4iS1/vGZW9q18QgGonmvl+e4ULOzMkD
         M+FEBLKyD23TFmpIt0sg4zqMOEUh+UNge3Brzgm2pjZEil+zjpDcz/+Ib4Ud4WzaLXj4
         Ok8YZ5nAhHB8HpxcImlbeJKltfEBER21wmGrW9sp+pjKZ+Vae0Q3cSVe47nXQ0k9Ujsc
         peayfcWlL8KoL/67xuSZ6ViJyfNX113EgopXehKHTGV3/ZYCvgIsxV5Jcba1tIwW7E1b
         TdPG6ssZys+dbBOWiBblOZzDBCgBPKLcXWX9FToKeIPX3jaKbUGQLfNKUmDUg0wkVDTw
         /h1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470964; x=1763075764;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bf2tG0VSbGuTREXl21iJqSVPQmFIFuxPe8RAulQFiSU=;
        b=q97yhPM8+mIlFdJJ5VsrrRjT3lKq+nu36vSTbICMJhA99xpCimLyfUpd92zYfJRY8V
         2KdEQoQSvW+RaU7488/RyyhGtm30h/Svp4xZhOfsA+KWAkGVXELoaAhtRMkTs0klBaKc
         Q7yQZgNxXXlLEdVqosheTzYbU+y1rz1SzoLAZIlbrFh10ET6f6C4oRVS7xGqtjf1Nc3F
         3q0kE+jyvl+bYJ0M7/WBr7NG0X39Kwx+2a37Q0k8oHxvStNT4x/qSZluruYnHg4Kj+qJ
         YKl1ry2sCGPOOTXoaGQGKXWRLjIvPRqUKVZuB6ZrFd9JKfKCDVyT3Ux/zi3Ls3f+SvAl
         9JbA==
X-Forwarded-Encrypted: i=1; AJvYcCVANA1LWeUYYfHHcEacBIXHz8aXRTNaSS0K3Xth6mUiebQhkMp4PxUA3qUzy0qmVR04U524mwZPVRfCPUWI+By4@vger.kernel.org
X-Gm-Message-State: AOJu0YwAGnFofzfI00pzZhDi14ZE0uVVGlgw1bZFroY0qgcZaxdRHA/0
	yKuY1KqZOzmPfFAAYxdJO6rCEOOdH8tuRYFK61waMHpsrbiCvQHgZBUKK3KfyV06/bNidfoJlVm
	og4MvrazfFg==
X-Google-Smtp-Source: AGHT+IFF93GvfK+PjXvMqPfUfs+sHTR0IeNpRh7CfwAQAd60QtdPtuxvWGZFwwLWH5LM0DIsyh/lKwBdwpHn
X-Received: from dlbrx9.prod.google.com ([2002:a05:7022:1709:b0:119:78ff:fe16])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1af0:b0:295:59ef:df96
 with SMTP id d9443c01a7336-297c03e9c63mr13878215ad.13.1762470963377; Thu, 06
 Nov 2025 15:16:03 -0800 (PST)
Date: Thu,  6 Nov 2025 15:15:03 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-14-irogers@google.com>
Subject: [PATCH v2 13/18] perf test stat: Update std_output testing metric expectations
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

Make the expectations match json metrics rather than the previous hard
coded ones.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index ec41f24299d9..9c4b92ecf448 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -12,8 +12,8 @@ set -e
 stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
 
 event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
-event_metric=("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of all branches")
-skip_metric=("stalled cycles per insn" "tma_" "retiring" "frontend_bound" "bad_speculation" "backend_bound" "TopdownL1" "percent of slots")
+event_metric=("CPUs_utilized" "CPUs_utilized" "cs/sec" "migrations/sec" "faults/sec" "frontend_cycles_idle" "backend_cycles_idle" "GHz" "insn_per_cycle" "/sec" "branch_miss_rate")
+skip_metric=("tma_" "TopdownL1")
 
 cleanup() {
   rm -f "${stat_output}"
-- 
2.51.2.1041.gc1ab5b90ca-goog

