Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2022DF12A
	for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874551; cv=none; b=onMKN10R8XMywYqVc/Z5IuKmOd8pZOiSXu306wbRqVw3N9205qkqe/EfbB+9rMDWorTkviKNN7cPt0ac7kqrlSTWgsIwo328tUAnVaxbDJRxQeXOwi60udZ6tz5CvuAnw+I8Jt033l3umv57lNPqBBO20e/kHA2zCQYsDYkZ/dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874551; c=relaxed/simple;
	bh=0lYXmqlBpYk30yEty0a21FLXkVSzUHTg5T5wQf3ZAeE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=K144qSL3kc5jJw0Qz1hglV3N0ST7vNr+TtxGLFALv5W94kRW26A2mECFXZn3WU0g5edxd0P9wAuXfuYCW/+0WiFFvSxzjAfLHuEmM4OVnv/tET4wDtDGZNBqIqwEWqqhPG3rjoCtqYZCNb4KEgXLLBGbntH1T7RP5zrb7+GOjB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Xg7tmdP; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Xg7tmdP"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4e63a34f3fso2251829a12.1
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 11:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757874550; x=1758479350; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TvKgbG4XWpm9j/FvFDZJd7wO0CKfdrc2kepJ8gLxvYI=;
        b=3Xg7tmdPIR4FY3+tzNRKBWwjSVfd7O6KZJsj8dEJl0s2eEc1hakrznlhxxcXr4ZQnO
         7jQkLswZBU7vqFCyMtfiLMbTwPsWRTKUmdWaT6ABumrP0YhWlLIjpTuqq3iA2gIAGJ49
         x7rcxbml/aY2EqSbYShHdYArwp9nC97Yc8N70wLEb2uG7a+MHYZioaq+6p9KfjB7Gf5V
         a+wV3/zkd0ZG+b+T51DNK+PnOAA+7DngVY3poCDSggmltJ5M7z8LlCmNtCvNc7Rzkrh7
         euh8WwF2IdJEzqnfV/w/yYw2ZaI704STvy5fnbSTwuoRQQTmUa04sv90B7lKtSu0wOUv
         M9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874550; x=1758479350;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TvKgbG4XWpm9j/FvFDZJd7wO0CKfdrc2kepJ8gLxvYI=;
        b=t22DB1I2ZZQyQNSOjAGX2Cy3TfsUEvtjeentAJ36ioIbBtuH5mlFsBFRSbak6r+qus
         P3G4tFSWET7O6q6skkpya4o/NnYoIGHe9IhsCj4GhPZTi+Z0yRI4xvXBytHL2bTnA73k
         lke2gbsRBjHNhpKLHb843G1fXKV6Z2PxliHDX0Irc1Al9Iq80J3a1UMakJ2zc4bNBxjq
         YlQ5npNAqROWrhhkp+hTDbuwBcFnyFaYxCWWYyofTPfMGOeW92QIrEDHF7Uyuqetqne7
         MVvwBofGyFsnR/cb+benMT1gyNS52Rvhhtu2hTJnEapdmBS1eUR0RqLpxIz+LcMlS7OD
         XlLA==
X-Forwarded-Encrypted: i=1; AJvYcCXlN9OspV5kpQboRnF1frr7m3oguB1XYEqKEWrN8dpoB5JHeZHNRQqSYyseOSTp+h0+X0X9k1ltEjotn+R1orLC@vger.kernel.org
X-Gm-Message-State: AOJu0YyjCJcDKuAQZLsXDwfxOWAN61854Xc1/aSN+amejlxPS6q8dmCY
	kdjdf7Yp6LaQrsEH8q1MMoOG0HknbzK2ZnW2QQZBuSekoqmtrXmzaDRMCIxPBGBgP9aDbX5QxF5
	wDkHxe+QWWQ==
X-Google-Smtp-Source: AGHT+IGxW9Yja9epoc4iIK/yOFAiIZoZRfLvsUOXZa2OGRrep9OIb1OYkQrTlNUDj0uJte5SI7cFznkvnVg6
X-Received: from pjss8.prod.google.com ([2002:a17:90a:1c08:b0:32e:12f0:20e3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:548d:b0:250:9175:96db
 with SMTP id adf61e73a8af0-2602aa853eemr12978800637.26.1757874549586; Sun, 14
 Sep 2025 11:29:09 -0700 (PDT)
Date: Sun, 14 Sep 2025 11:28:59 -0700
In-Reply-To: <20250914182900.1960567-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250914182900.1960567-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250914182900.1960567-4-irogers@google.com>
Subject: [PATCH v1 3/4] perf test: Don't fail if user rdpmc returns 0 when disabled
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In certain hypervisor set ups the value 0 may be returned but this is
only erroneous if the user rdpmc isn't disabled.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/mmap-basic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3c89d3001887..3313c236104e 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -322,7 +322,7 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
 		}
 
 		perf_evsel__read(evsel, 0, 0, &counts);
-		if (counts.val == 0) {
+		if (rdpmc_supported && counts.val == 0) {
 			pr_err("User space counter reading for PMU %s [Failed read]\n", pmu->name);
 			ret = TEST_FAIL;
 			goto cleanup;
-- 
2.51.0.384.g4c02a37b29-goog

