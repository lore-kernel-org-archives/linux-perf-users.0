Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EA223A8
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Feb 2024 00:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746523; cv=none; b=h/aUaRy+BLZcNloNaWQkRctxO3lOxF8IOrqfYPoBtrzjDvRkRdMH8AmLgKh0hKGV2ALRwIvK5uq7cPhNbGk4PC4EX0LLeUx8cW3wYc8h+9hhJCXirwbcGjm3m3E/8/rwRt4n23ApeBiDNZpwVhnnbhISNPvqkQvzHpuL/Mz37TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746523; c=relaxed/simple;
	bh=27wmXzsgBuwC0/tRLzTcix6eSwjml4hF8vNJfLSfj4s=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=h46l9i4HCO/yeRUzNr4F+9vC4MmnEJQV5Cp5mwqPwSUzsuiTiX2odq0fZ52k6NQ+sIcB+FISg9LTYQ5kmeFcCXsAUeEufdWMqZ8Jzl8LcimZV2ViSiQ6j6kVhcM0zNClUEKL11fz8BuLrIvdWd5NLIMKZ/lI6+Yhr5gM1AZfbUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RCpoy+4x; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RCpoy+4x"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ade10cb8so753458276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 16:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706746521; x=1707351321; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2F04A0OfF26PLB6g2tCcO6N4OtMZoaSU7mdBY8RaIms=;
        b=RCpoy+4xNYVZ43QkZLSHHifaV4kGY06lOGdGP8aikinISvVYTnjmdhEBoBqYIuEn0a
         EhDartG/g472QtNgZgtuXDjDPF7RiW6RC8VmXElaZSVjWi/XPvQrvqGkeseDFDYBPhwl
         MN7+/UYkBS75VH7yCrVq627ZIocrbAPgAzRfQSkQDm5utQJ5edzgyynXwLGCe8zFrsKL
         P6CIv4Dg3JKvGXV1kb+dZwsIhTideAFzyflIim862YviQZpVSY+YnVjhSiynJSFMQ8n8
         AvV6Npkt4Z5zgQlyKYG+noi6oGEGI5yaewQuGbTZmaEoDEwx1CSniwprfkPJezsbBXRl
         tMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706746521; x=1707351321;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2F04A0OfF26PLB6g2tCcO6N4OtMZoaSU7mdBY8RaIms=;
        b=HrTHqvNDVDPWErCwx1GkZSih6L7yZBM6C2vboUWTc090ccDOjZ/XDNtrH2lf0zqgSj
         +UHR+MwoizHTqCoSO2IfcG0qFKgmzQn6NFgYjfWmQBpPEJ/Z3WcRAW/cviAPBMmJGsHu
         KJ+reoyev+FtsEnvhU9za94DY8XZTwnsJwKy6vl2YBZMOp9gHbLSR0AwaxoLJTlRKZGe
         wiYtEWahXuRm/G5G550LXMu82D0q22XF9L+LBwMqeNSGsQUekauyYH58kwtXHnx2gnyE
         X+ahSCUAyRyZLmk9/1Os1bf6KwjG3vFgW81032eojkRL8xn2HDQKmLfIDWa2xs6gTUnb
         cXGg==
X-Gm-Message-State: AOJu0Yx0i/gP7bO2P6kZuaNPMmK5qaqMHBatRtSgbUmbDgmBSWWmUU1p
	w6sOGGOud9yYj1aLxROVT9I5gLkCwvTxHBTHnnt3Bk5m4SKHDqBrkvPaT+oeShhoDAtcaZs6hRe
	gdnrKIg==
X-Google-Smtp-Source: AGHT+IEK8rHCIOvwsV2OYlNOOUXAaJ8tOl4BTM1Fvzt31QXvwhU+AVupSdgj4QJrnxEwKerQdml7nlb2kwFT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:16c5:1feb:bf99:a5d1])
 (user=irogers job=sendgmr) by 2002:a25:8912:0:b0:dc6:19b9:5b83 with SMTP id
 e18-20020a258912000000b00dc619b95b83mr1132435ybl.6.1706746521125; Wed, 31 Jan
 2024 16:15:21 -0800 (PST)
Date: Wed, 31 Jan 2024 16:14:55 -0800
Message-Id: <20240201001504.1348511-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2 1/9] perf thread_map: Skip exited threads when scanning /proc
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Scanning /proc is inherently racy. Scanning /proc/pid/task within that
is also racy as the pid can terminate. Rather than failing in
__thread_map__new_all_cpus, skip pids for such failures.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/thread_map.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index e848579e61a8..18fbc41d09f3 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -109,9 +109,10 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 
 		snprintf(path, sizeof(path), "/proc/%d/task", pid);
 		items = scandir(path, &namelist, filter, NULL);
-		if (items <= 0)
-			goto out_free_closedir;
-
+		if (items <= 0) {
+			pr_debug("scandir for %d returned empty, skipping\n", pid);
+			continue;
+		}
 		while (threads->nr + items >= max_threads) {
 			max_threads *= 2;
 			grow = true;
@@ -152,8 +153,6 @@ static struct perf_thread_map *__thread_map__new_all_cpus(uid_t uid)
 	for (i = 0; i < items; i++)
 		zfree(&namelist[i]);
 	free(namelist);
-
-out_free_closedir:
 	zfree(&threads);
 	goto out_closedir;
 }
-- 
2.43.0.429.g432eaa2c6b-goog

