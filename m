Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A458533B6FC
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104426; cv=none; b=FEdsLJF5oqg6uwMegMd+qTqqG0qTOqSwLikIUW8MdVKQLWvntWo0PKOUUql2fsNqTcoSbvhE53ZDfS84KAKJvyFtWAt2TmHhdaRV/gMZkyFk5FilXNCX0zIyxWUIEmCgAq5kXD2cJLgaLkmar42Hgx5i/x9wtzpISdEYASxbEmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104426; c=relaxed/simple;
	bh=JMfdIbFJljImWyduhmJKjuMZLsCK68T1ZtI1jn34E+E=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=RxX8ZOUf9fOJMJd7taynyLlS3oG91Y6rjOh1aZhbFx4EtBdQnxaQzZyrT4/VN3MJ/gf0Q8HGYLLQVBmxxCxtdB0oP0qbSq0Pr/CnU9ppaKXBCt9E04Tb7uhHpQmegtCpoz2cZaUVW089p6r1VoHsoRu0JhG9l1cM6kdAl9JkTIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DWQDYVtB; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DWQDYVtB"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b71c5826fbso1247543eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 09:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769104421; x=1769709221; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KVcC9YyBbI/53TLEa68Oew+p0TyCl/2SmBv1BhTRbLA=;
        b=DWQDYVtB/BRdx0XVsdetJxOVUE1IHrJuYo2doLT3bPTPN6YuYT1tARocD1RI/d15Lj
         5r5nxTFIt1QmZDIU9Nf7omTEUOp+iEkfG1VeN9c/AqBAOW9G4xa5TgWyMDB5HjK0thdK
         l4w0baw1h2a+u6/SnUHmo+TNzHOief8jFbDg4EqqhEqBQZOYZkkY+p5ZPdt8y+rdOjYU
         CD5WH4onkQZacFTDBgx72wrH2fDcosPib9+WG5SFDujRSCUoHWRX8qQ7FVi5jkzovTsz
         4zWbyJQZOgFNgFAUWb+4QvIpz71shHh+rvWHuKUV94B3af8izIpeLXMpe65d4IGyZjOq
         Wjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104421; x=1769709221;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KVcC9YyBbI/53TLEa68Oew+p0TyCl/2SmBv1BhTRbLA=;
        b=gi9fRS/XZ2IFEbdGiiozK+7ZIWhLQWerTju2iVf8Qtfb8qh37Vwbbnliynj7qNpQp3
         udyP5XVYIG8vppyR8B1PxpxquQN91Jhy9vqjBbyHGOqDewh0B04qWcYXlV7JPcpbJfUx
         djYyeOUx9SsiaZiAZ+BMm/vKn9yjNqiMn5geH6cjejw2KuhSFLRtOWF0w0FAxO9P0+kh
         gCfszSG2iGpXz7RmtwFsP4vY3YVf421acvpHMM4n0cC1AE1+aBGpZeHn/+Gbp+K1TJAL
         OJRceeCyWO38cgx2WhOy0qM9xEBC2kf1ezFOUtSKVYM2gniAmWymtZvVGrALSf7ScluQ
         A+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWJc63PF28JSvbYI+fSyNHVmp9IpxyzJMDqCnsi17DQEWK0qbYnLWXOfp/aUxkJkxsXOh7GFdoP/vKtjWsOCovs@vger.kernel.org
X-Gm-Message-State: AOJu0YxTpVlqF+1P/02seO8tb9aJmCpuziT0kXCY7W9iMwmE4i0lwn28
	0FiHLZZ+AG19rv7nYj2Bb379Rt8VYT3f7ssmPQrWvWWJx4/GAI1EvhlWoFrXN3CiLtuClTnHcBY
	Q0r4YQdv5wg==
X-Received: from dybph7.prod.google.com ([2002:a05:7301:4187:b0:2b6:aa5d:9379])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:bc05:b0:2b7:2664:ae9f
 with SMTP id 5a478bee46e88-2b73995701bmr98407eec.1.1769104421506; Thu, 22 Jan
 2026 09:53:41 -0800 (PST)
Date: Thu, 22 Jan 2026 09:53:37 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122175337.591403-1-irogers@google.com>
Subject: [PATCH v1] perf tests sched: Avoid error in cleanup on loaded machines
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The stop_noploops function will kill the noploop processes that are
running for 10 seconds. On a loaded machine they may have already
terminated meaning the kill will return an error of no such
process. This doesn't matter and so ignore the error to avoid the test
terminating in the cleanup.

Fixes: 0e22c5ca44e6 ("perf test: Add sched latency and script shell tests")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/sched.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/sched.sh b/tools/perf/tests/shell/sched.sh
index b9b81eaf856e..b9637069adb1 100755
--- a/tools/perf/tests/shell/sched.sh
+++ b/tools/perf/tests/shell/sched.sh
@@ -53,7 +53,7 @@ start_noploops() {
 }
 
 cleanup_noploops() {
-  kill "$PID1" "$PID2"
+  kill "$PID1" "$PID2" || true
 }
 
 test_sched_record() {
-- 
2.52.0.457.g6b5491de43-goog

