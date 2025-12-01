Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C2529A30E
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 23:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764630568; cv=none; b=B4WBsn2BFCFNUiHxb5rBMqSYih8WkpVJIOPGbxW9ExztAFA2dBqU7rdrZesiX1yNL/B8z4ymhQ0xkbjeLAp807dSGV78C9dgA2ojBOd5J6eW33DFPPpLcZcuyyqTJ7XvihGOC8suoZLThs97/HGPiM4IsFnIFxB18PfNcRJq4eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764630568; c=relaxed/simple;
	bh=Da1DvrxjsiAb+0Vv05tmmbNsPmKfezppx2pVrkIBMWo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=t5D9ONvWjIgnZM9g5PUi8kErApWE68EcgsQUNzEkwbOd4Ko7shRQXIDOqR5CJk3166VQZgAmCTHBvd6iZbrskKm/D89X2orFUexJNnM8a+xedcksnkR8JrbeTTdFMlJsAohUpUUzVASCRtY0umRhIUPcxfRgcfStUMC6Ton01Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JEP6CFWj; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JEP6CFWj"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b99dc8f439bso7808520a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 15:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764630565; x=1765235365; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QElrcR6SoLYi+schx8NdZa4bIs82Q0X1SkMLk4x3MNM=;
        b=JEP6CFWjP7PkispNvbLc4RnDbG/1xXbVljMGn2GsvJifG+6ceoRoaeRU0kKUpf0ZcG
         p/uBzy6n1N9EXgpYE1sjhtwbI0/9ulWMwKazj8IFr9wgTIAYFLCNTwCRfTcff4DaThJM
         UeRQQ+p0Ul5KaqKQ5WNS55dtdcPGXEfjhqArtJi8MEGMUInnj+WhKiwaqsIJA4Nfwy3e
         /qUsnvS38u5PfW2O9b4LU40fbmZhrCT4xdEwKsHEoXD0mavqeaMMY37Q2wy0iSfGORef
         KZNogYM/2qmK5dYZLRQvAC6TtavSxwt4NS8G5zREhCj8j4o5kPJQysnpzF2guD2JFoS8
         ybnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764630565; x=1765235365;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QElrcR6SoLYi+schx8NdZa4bIs82Q0X1SkMLk4x3MNM=;
        b=sByaKk9YgTMD35ywejIGEBq0q77DGL0zjdO625rDpvumz9i/6NSWv2BHWns2JUlotc
         pJyFQ++IyY5fsOjH1Jv2MD80uE2n1jG1vZ7r88BzQZy9Fcp+7sN0gMUz/w6MGuLVrbW9
         XevqYbUnaCpx+WuYWlKXuuBeoeL76NFPHfyFCn5gZybTw3kYexT/arYHPRyYuE+FBaR7
         v4j8E/+/OhtLh6ilpMOewuV1H+esu0dq3kovFvARlPw6EpehAcT9oYek1gXSFJyNkxNX
         ntwpwuUEkUsIellXy4wW8wiERhr9e/LY2Zu2kX6MuZRb9yUgFfIH3C8ZP5ZE+yRvUUny
         tkJw==
X-Forwarded-Encrypted: i=1; AJvYcCVThOVSygNsuU27WY8VNCgLo9hB7la81pXVg6uwa7hZVM+TT5L4swgrjaYNdn5UBhSeQF3bxmu2vANp3mxz30HY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4hgs1EM2L95vxGQckQIuN5DQu08hL5HrUViQ0KZQS76iGm2nt
	jxXEQKLSeWRI18UgNqorndbcqmXVMencJwd6egATO+iTMvULY9iX+A+nAwHjUPcBbWD3PpugVk8
	QBZFn0xtvOQ==
X-Google-Smtp-Source: AGHT+IH0eKE9E+MmDgJ6isyMTdjuU1MafmVekNCODFQrh2vUpE7Jkc/yEQUQ1M+Rg3+C3Z5Vr0oCFflZrcVY
X-Received: from dyu3.prod.google.com ([2002:a05:693c:8103:b0:2a6:c856:f084])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:80ca:b0:2a4:5b32:2a4d
 with SMTP id 5a478bee46e88-2a7192a5b52mr26724491eec.29.1764630565064; Mon, 01
 Dec 2025 15:09:25 -0800 (PST)
Date: Mon,  1 Dec 2025 15:09:03 -0800
In-Reply-To: <20251201230904.290733-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251201230904.290733-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251201230904.290733-3-irogers@google.com>
Subject: [PATCH v1 3/4] perf cpumap: Add "any" CPU handling to cpu_map__snprint_mask
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If the perf_cpu_map is empty or is just the any CPU value, then early
return. Don't process the "any" CPU when creating the bitmap.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 89570397a4b3..a80845038a5e 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -684,16 +684,21 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size)
 	unsigned char *bitmap;
 	struct perf_cpu c, last_cpu = perf_cpu_map__max(map);
 
-	if (buf == NULL)
+	if (buf == NULL || size == 0)
 		return 0;
 
+	if (last_cpu.cpu < 0) {
+		buf[0] = '\0';
+		return 0;
+	}
+
 	bitmap = zalloc(last_cpu.cpu / 8 + 1);
 	if (bitmap == NULL) {
 		buf[0] = '\0';
 		return 0;
 	}
 
-	perf_cpu_map__for_each_cpu(c, idx, map)
+	perf_cpu_map__for_each_cpu_skip_any(c, idx, map)
 		bitmap[c.cpu / 8] |= 1 << (c.cpu % 8);
 
 	for (int cpu = last_cpu.cpu / 4 * 4; cpu >= 0; cpu -= 4) {
-- 
2.52.0.158.g65b55ccf14-goog

