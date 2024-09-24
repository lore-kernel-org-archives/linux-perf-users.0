Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A0612FF72
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 20:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209767; cv=none; b=msUeXECcAltULYxeofCni1sirBkgUewYUeu5dzK7cnCSAycSXrc+uyvoCcRapZUOBLLttjqk760KLnD1STstUC5S2wzzeNfsMAW4SI9QpZ3VMl3CSleVyJW/WJ7zv9Jr07MhKyKp/YVjvJNhSN8z/UpHPWalK8qb2vSRTF2H9Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209767; c=relaxed/simple;
	bh=mFjhdQiwvR9CAqZB6ZhikCzrE0gEej86IXDZhFy6CX4=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=QqmvjnSNaliXigp/kmRQVCoarhfcFRPZyR8Bg8X7PiEqngtpyIMjJ0o/uIT7PXNCAVZPsPrhg0Zcr0j7s3bSwMWNJ0HPUnUh+JndvJg649KZiD+35+oENCMKTVh2Djj1Wrjsk9KbJnlpulF3+a7KBN2OEHCgh99OizqPLsQMlwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YuUNo6/P; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YuUNo6/P"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e24b43799e9so366970276.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 13:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727209763; x=1727814563; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nn8ECyCmWyPn9tXLc8lNZejR80O62lwdh1iFMAs+Rqo=;
        b=YuUNo6/PE5J24a3sNTFYd1PLvyaEBqttAdNd+BMuK8wCktxAeyPvH8Xtx1azaR3Lp4
         iLzqrkWTvoQhMUCzG9AwrQ6NawDB8ul9sGwm2CxW9SLjLwlnXNFpt1zqNZUUpbDoizrn
         BBYk3WzccCF78jBQwaiw8E9o81WgCaS4iV5GEex0wGToFS5IyRosQelZWH9ZHdEdQyRS
         gOSmyeQ991wBjwfTWBd49Vf0RkHM/tWbhbYeYW9W+QhFCXnhjse92tzdLnrWmNTxqDlN
         90fqjyJqnhn6Erqq4r3OO7b/zW/T7tgF7kBhTMrVULrO8wz5uXYSoJsFa8MM1mWumokK
         X1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727209763; x=1727814563;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nn8ECyCmWyPn9tXLc8lNZejR80O62lwdh1iFMAs+Rqo=;
        b=W0paTqUzph6IWZKSUeiEpHFSPeMSaEK4iW4Pc1nZ1Fv6kL09I32sOnO9KUnE5Pd/Cn
         s9206CqZmD8b8rQ/WuCyOTv7M7ggu+J6xGyn5s2FE9TjNS6CG9SSOGRzrucwU6wd3IHO
         Yr2t52Kryw5VFk4rzA3qM8jwO5YYt9SK1WY2c0OO+/CRrlGwfc8H9S1HlwWCQ0aaNzRV
         5b0OOl2ETTJvboyIPy1uMYQH+0rzzPN/QT+94pnDDVxykIhN8Ol1PLBYXDw5Sq4Jgv8v
         WFNuuB+hZW4fLyDVvSRR5ZeE0A+W7xRcGKKO1c3AfXDtbmKzlTLTv82ZjMbzVACJolwf
         F3+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUI4Yya+I8UnM+SeImovTfjdDdXJZnXneJoWMTuQZkmKntKcvUulKJ6CFUdIvvTPXNWfmrxvV8GSQzoXqmR0kwX@vger.kernel.org
X-Gm-Message-State: AOJu0YyJkj+Bq2w1ZeWpEG9qB4PPqXlCJtBhSTRhEGMms6eYkdKi+Fru
	qeApbl0q5TKGBshtyGUqtBDq2Hk1tfnOmU7AlJqoxxaL1Eo+Ol00318uCQaJ/SQQoujeLdRCK+Q
	fBbiR/g==
X-Google-Smtp-Source: AGHT+IF9aApUK33I6f+5seodeuhmYm49UBu0r6pcj/qZiBEC6FE68CAKJFmd469r3veH4l1UEVa5sCABPcz1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:965e:4297:88a9:5902])
 (user=irogers job=sendgmr) by 2002:a25:9c84:0:b0:e20:2b5b:c6e6 with SMTP id
 3f1490d57ef6-e24d9bdb37bmr8964276.9.1727209763324; Tue, 24 Sep 2024 13:29:23
 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:29:13 -0700
Message-Id: <20240924202916.1560687-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 1/4] perf stat: Fix affinity memory leaks on error path
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Missed cleanup when an error occurs.

Fixes: 49de179577e7 ("perf stat: No need to setup affinities when starting a workload")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 689a3d43c258..cc55df3ccb18 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -767,6 +767,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 			switch (stat_handle_error(counter)) {
 			case COUNTER_FATAL:
+				affinity__cleanup(affinity);
 				return -1;
 			case COUNTER_RETRY:
 				goto try_again;
@@ -808,6 +809,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 				switch (stat_handle_error(counter)) {
 				case COUNTER_FATAL:
+					affinity__cleanup(affinity);
 					return -1;
 				case COUNTER_RETRY:
 					goto try_again_reset;
-- 
2.46.0.792.g87dc391469-goog

