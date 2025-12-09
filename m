Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4073002B9
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Dec 2025 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765301783; cv=none; b=eUDR/BgHmYz4CnkJ5MNH5dS92JvUbVxPnJT252ZLvAMRIk49O+1WOyy3Flf/nXKbD9BTKNvIGWE02mzld1VibHr9oPE6a7k4o9uAyWhWPUGR1jgQ4m83HhiPSuBqVuQim847tI6cySawdJJKpgleTB1awQ+Brx+7lPph9PEkwmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765301783; c=relaxed/simple;
	bh=2J4VNMTx7hncImwcZzxIKLa0er9axnz0Fzr3Wf9tUQk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dUJHBgMiOePtim5CDrmaTyS9/gZUEg3NzeAwi/KRa1Zzb5Mt1OmAPScKpqjRgJC0JuRt/CWh3qGqUC9z8B0D3cpErsT+mQu9k+E+FouHk1tiBbob1DMtJ20Hxr/cuP8W1MwmVoA2+RYKQd0qLpABcJgswOa/ImevXQduXlU4bkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AU153jSo; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AU153jSo"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-11bd7a827fdso81789c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Dec 2025 09:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765301780; x=1765906580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MHFT62zcP+uzBhJJkYNqwWKNM/LVKwF9++8ZaNQtnLE=;
        b=AU153jSoN/p8I8+iSdJzCL7j1hxo8jRbeIIa6ZMp0XCn6Y8ukxk8pcP0NjATIXZH28
         r9KuoYvzDlS7yxHaYwcvp7BcyjyxBkILnMg/cShMVDfSAJ6TkVKC1nDA2UArGsNWScET
         l4UYEdE5+/v14NEfRTp2+NEn3Yu5sRkL6JuH10SmoSoegGGrL50O5NvkRUKyL4Sytyev
         XFxjaJKJVRuW0dxCLa2Rvm3oO/wiNIcNpnmJqMWYchZvQb9jEQK4kYz/ZJcWi5VZo23g
         G9HL0DResKGo8vM3cclkFyRZEH8Ck5KXIp5AAeH9cfREFWK0Y9jtDjoLFSQf2Fe9OQbQ
         QEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765301780; x=1765906580;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHFT62zcP+uzBhJJkYNqwWKNM/LVKwF9++8ZaNQtnLE=;
        b=dJg+fr1ssm/eTgQcj6YcJS9HHMo3eIE5y774wpR+jGmHMmRgy7QUnGXRKqWCYkS8ql
         oFJgvW/nO3PODewxV2s0HA0PSp+2R8ruWcHtFVEZfrLrp/ZOjcs79UEfQoZFOUkhjngW
         z+Bg8klYoLdSkWGJVvVUDeW/6rrD0q1N1DJmAe7e8COKzXP/zhh680r6y8BciuGL18J5
         lPEFtXJi23RI1eg2AKA0FHU+oIhNZCftSTqt49e94m+1haKESgY4MPJ0zFNAWlngXRtS
         iHJoFi9nJ7as6Jm5bWhkp1k/FWRLWb2j5EwFggEFTDBcRo9gaorFl2HBQnFsV4bcAL9f
         ZNiA==
X-Forwarded-Encrypted: i=1; AJvYcCVeSSSC+l+8chcTg1cFDKtGptXAJh5CCQI6YoYZDCUBgMxnZeAD+tLRkvnGXffXvzcm6SLluCnvOs/foMckPDAP@vger.kernel.org
X-Gm-Message-State: AOJu0YzHip9/JYZ97P/6jRHGxMJ5/mU4KtKIoLmgWG4VS6FZa4PwHEXZ
	vWatHKIOpTDzoRGsvbudG5YGGbxgsw6DjdCi1+aZrW8PRII+FfwRtHbpix1teYl29Qh6g44kGuD
	LjMY78sYqTA==
X-Google-Smtp-Source: AGHT+IGH5qKcGCeDOkGypUsW1qg77Dqskx2nxip9KgH11cgR6u1rp1/Lii/alrmJCzILGhU3Cy+RFpDcAbIx
X-Received: from dlbeg42.prod.google.com ([2002:a05:7022:faa:b0:119:49ca:6ba0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:98c:b0:11b:9b9f:427c
 with SMTP id a92af1059eb24-11f251c3934mr1393470c88.13.1765301780303; Tue, 09
 Dec 2025 09:36:20 -0800 (PST)
Date: Tue,  9 Dec 2025 09:36:10 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251209173610.2033973-1-irogers@google.com>
Subject: [PATCH v1] perf stat display: Make %f precision consistent
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Chun-Tse Shao <ctshao@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Commit bc22de9bcdb2 ("perf stat: Display time in precision based on
std deviation") added multirun workload elapsed time. There was an
effort to make the precision in the output most useful for the user,
however, when gathering over runs it means the formatting varies. This
change just makes the output format fixed.

Before:
```
$ while :; do perf stat --null --repeat 3 sleep 0.1 2>&1 | grep elapsed; done
          0.101140 +- 0.000149 seconds time elapsed  ( +-  0.15% )
         0.1011396 +- 0.0000218 seconds time elapsed  ( +-  0.02% )
          0.101331 +- 0.000124 seconds time elapsed  ( +-  0.12% )
^C
$ while :; do perf stat --null --repeat 3 sleep 1 2>&1 | grep elapsed; done
          1.001317 +- 0.000146 seconds time elapsed  ( +-  0.01% )
          1.001377 +- 0.000172 seconds time elapsed  ( +-  0.02% )
           1.00253 +- 0.00131 seconds time elapsed  ( +-  0.13% )
```

After:
```
$ while :; do perf stat --null --repeat 3 sleep 0.1 2>&1 | grep elapsed; done
       0.101406408 +- 0.000064778 seconds time elapsed  ( +-  0.06% )
       0.101367315 +- 0.000027253 seconds time elapsed  ( +-  0.03% )
       0.101434164 +- 0.000084750 seconds time elapsed  ( +-  0.08% )
^C
$ while :; do perf stat --null --repeat 3 sleep 1 2>&1 | grep elapsed; done
       1.001525467 +- 0.000051703 seconds time elapsed  ( +-  0.01% )
       1.001375093 +- 0.000116200 seconds time elapsed  ( +-  0.01% )
       1.001141025 +- 0.000046361 seconds time elapsed  ( +-  0.00% )
```

Suggested-by: Ingo Molnar <mingo@kernel.org>
Closes: https://lore.kernel.org/lkml/aTQRgAOpKyI53TEq@gmail.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 6d02f84c5691..2ce0602974a1 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1397,21 +1397,12 @@ static void print_header(struct perf_stat_config *config,
 		num_print_iv = 0;
 }
 
-static int get_precision(double num)
-{
-	if (num > 1)
-		return 0;
-
-	return lround(ceil(-log10(num)));
-}
-
-static void print_table(struct perf_stat_config *config,
-			FILE *output, int precision, double avg)
+static void print_table(struct perf_stat_config *config, FILE *output, double avg)
 {
 	char tmp[64];
 	int idx, indent = 0;
 
-	scnprintf(tmp, 64, " %17.*f", precision, avg);
+	scnprintf(tmp, 64, " %17.9f", avg);
 	while (tmp[indent] == ' ')
 		indent++;
 
@@ -1421,8 +1412,7 @@ static void print_table(struct perf_stat_config *config,
 		double run = (double) config->walltime_run[idx] / NSEC_PER_SEC;
 		int h, n = 1 + abs((int) (100.0 * (run - avg)/run) / 5);
 
-		fprintf(output, " %17.*f (%+.*f) ",
-			precision, run, precision, run - avg);
+		fprintf(output, " %17.9f (%+.9f) ", run, run - avg);
 
 		for (h = 0; h < n; h++)
 			fprintf(output, "#");
@@ -1462,17 +1452,11 @@ static void print_footer(struct perf_stat_config *config)
 		}
 	} else {
 		double sd = stddev_stats(config->walltime_nsecs_stats) / NSEC_PER_SEC;
-		/*
-		 * Display at most 2 more significant
-		 * digits than the stddev inaccuracy.
-		 */
-		int precision = get_precision(sd) + 2;
 
 		if (config->walltime_run_table)
-			print_table(config, output, precision, avg);
+			print_table(config, output, avg);
 
-		fprintf(output, " %17.*f +- %.*f seconds time elapsed",
-			precision, avg, precision, sd);
+		fprintf(output, " %17.9f +- %.9f seconds time elapsed", avg, sd);
 
 		print_noise_pct(config, NULL, sd, avg, /*before_metric=*/false);
 	}
-- 
2.52.0.223.gf5cc29aaa4-goog

