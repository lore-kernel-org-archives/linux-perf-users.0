Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78995232
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 03:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486927; cv=none; b=g+N90n3ymwSfi8X8Fq83cCapFiVs2B6XxeJ1oMw+ligZ8IaMn+v3OWL7jJn/R1xNamOaNmZKEVTg7OIdTq6LsMRf8ZT2DYmXIIKcu5gG03O3zwP6GikoPUQSIGahWToiv/9cH3N+FVunZq5JPdp32FrTMdxSjGjoOfc+S3a/I58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486927; c=relaxed/simple;
	bh=o/osGCI+hvlD14sD3OCM5ESdLYEEWx1V7jgoXENiCKc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bZ9mz9mnXPRTFPibPRgfUKv6IlyzWnFf29chPDpm7EF3IOO6BDuZJlC9AeTslrevU2RiDRoNqg1Lv/PMkzjsqMyCNPr22lCVyBV/ilTEckBdRt4weoydtQ7+sT29JTAuf0hMmVSzXkbvVU9hHlPe33ImFXpkM00AOafUb3cHyuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bvs0jjKY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bvs0jjKY"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so7786901276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Feb 2024 19:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708486925; x=1709091725; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uv/9NgKdLz0z52mqtvy0vTSbbBgaPJcb0Vk69+L979Q=;
        b=bvs0jjKYG21ZkB+YgfE5BE740UXuO77Aq3aGQVuxlIvR4Api1Wd4UkAzo8tzSYpyxu
         qgIcKEqtQo9kzYmWGUOYEzQqHm3T419K97jcCG6JD54rA6kt9TW3725qnQ91FWLCSKld
         DkO2R3m1FoX6F5W9P+Lz18oSTagIl5/cO6lUWg1G7Uw/eXm39MRhHadPE9CjR24Tt3FS
         w8g6c+vm1zP/XJcMZJ9rTkmPOW5IHsHgB9NA5KU0rMlj3wY9F4rKgehtcnq40to/jKhT
         GaZmDyaiksQFqofW5FfXSwirlu2KlyFgPt0WQcQmCX1WZ6nZR/aWrE31NPuKo38UqC21
         W9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708486925; x=1709091725;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uv/9NgKdLz0z52mqtvy0vTSbbBgaPJcb0Vk69+L979Q=;
        b=s+RnHlppuJgZVJS/+XJ+FbjHFnpX63IIKnpQ1DYOUKtofcTcZ5t89wYewNS6TpinZO
         8D7SYU0n4pbxlH9KHwe7BhWqM6UikzG8aPxdAOJ/CYnUfxZ4KxaZqtGQ1ZSGp7lAw6O2
         gcH1V7iMtirv0YS6nwPuQHd59rnjuynQ13kHOduRuKcO0e6e8blBz2vNVSpfsHYfDNDX
         S+pPy1pe+ZEhGcI2nCrb7N3b0epe3jRTQnR/i4/uHfN87zwUkaon7+bm4q9YIvEAW7Hq
         mLG8YPf5VffEPtFLaG/RGQRr98LFUW8w/FUImx4gnMmTISza4l4AM4WUw7psRSC320C1
         Jy+g==
X-Forwarded-Encrypted: i=1; AJvYcCUPgHjL8+ze1lwzxkjaiMswOfdxXQS7kKR8iAjbU2aFymTSftjY3wTqq3OIYgXXPKaaZBdCk7MB80MYup9f34FeqymAqmmId+UpeafZe97z3g==
X-Gm-Message-State: AOJu0YzIULyGSfPtL1Cwtx7ZeqcYPpgZxwK4ZjyxgIEH1ii1VUOKPxqa
	z6fOhP9hsw5H02rbIPdiPMxbjhYjPSbtwJuKjHRYLer504trCHGnu7dTJRQjM3n25eybc9jO8SY
	pBrc3WA==
X-Google-Smtp-Source: AGHT+IGqHOfbFeUMm04fgBII6BGPdq0HLJ7wcSG61rdgw+C9Xjypqm77xVwuEi9AZKTTTzR7Hwymw6gQ+OLN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3c02:f882:5876:b7ab])
 (user=irogers job=sendgmr) by 2002:a25:db93:0:b0:dc7:9218:df3b with SMTP id
 g141-20020a25db93000000b00dc79218df3bmr708882ybf.10.1708486924814; Tue, 20
 Feb 2024 19:42:04 -0800 (PST)
Date: Tue, 20 Feb 2024 19:41:48 -0800
In-Reply-To: <20240221034155.1500118-1-irogers@google.com>
Message-Id: <20240221034155.1500118-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221034155.1500118-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Subject: [PATCH v6 1/8] perf thread_map: Skip exited threads when scanning /proc
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yang Jihong <yangjihong1@huawei.com>, 
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
index ea3b431b9783..b5f12390c355 100644
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
2.44.0.rc0.258.g7320e95886-goog

