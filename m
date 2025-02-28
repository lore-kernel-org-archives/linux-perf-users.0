Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41205276D3B;
	Fri, 28 Feb 2025 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740733820; cv=none; b=kJJtLMQsL9/Mq0Bc5NbPANkOHM7eMTI1rKHgDEjB3/tstyMtraa27NRElfn8QF0nxQEn/3FNecU04z1xHpDkrw2BWWw+iB7rDvtj7jzVIQQO2022xk1I5WSH0m+QrwB7nOI46uXd3Fkblyw9YCikvqgkza2WenBAkhxFnn2nabo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740733820; c=relaxed/simple;
	bh=zYuheaLRkGMKUeaIoglrA/mLPSp23bqptLq8iPOQi1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uj9Tn0IY1w50lG4sFtvkki5xcNCN9bJ8yF1VXfYqoqXSDGcNsmbHEd7zxON8T5g3RZB7ErOJxBpi1EJ/dOYP/igyde8Xeh1GU/oygzNTfyMKrPkPszEYm4NQ40PtEAV6WIcPxLD3X6TrBz03JnwKsL7yp1ZHr7fQLgH+dU4xsOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vg8qzmtZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vg8qzmtZ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43996e95114so12888085e9.3;
        Fri, 28 Feb 2025 01:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740733817; x=1741338617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qpR4ebVigelsQjVDpmMUs9XPyS7tiT52viaXvhEX3N4=;
        b=Vg8qzmtZRs/N1IKnrNYdGcRhbdAtdh1bsmzoh0ZwnRbpveA5AkWTsz5Vn269db+9Ou
         VvYCDqeicNVgR72vodZcC+scLVo9HoZikt7W8LHOlyElYE2eGdGrUZ8qddmAus1xKXoX
         GTe7AyDCHo3urPeqA5E4ImdvZHL1Evz6yViY9YHvv0RtPkWU5Ooj6B9V8ZHcAVXRZXbG
         1jgs+041IgIefsUOjQp4KexRGbXCxTpIwDQz161Xmxfg4lkZu3wqCPh02DC+mgVzNA5a
         8IVlzYXBzN1jkRTRFZPhj0LbcT3YFw81b0uXAuWqHDt8ntFQH8ljXSli1ESz2HW80t2M
         BBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740733817; x=1741338617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpR4ebVigelsQjVDpmMUs9XPyS7tiT52viaXvhEX3N4=;
        b=MFw9lQCzja9DhTksoQsNu4LeNpOZYe29lZu7cIqwKC3ylJE16YpAz9HdYXtcweZqn4
         CCAd0eocaZ/4DrNNKpWz6UTAq/uS50NCkbTTdbJMzReDntg4kfBHSTlIBe5PJWzMJMFk
         4I2bykTMFw7lrRpSUstUII8ud5Mjh7BV5PM4cNGIlQAplOwwtG1ISIiHA2TxD32IAtnO
         jX0GHDAxvuHQ6Kq+xTuHwKO6jUsI9inRP5/yhz12jnAUd5ydJURZyL6VWEsjAQ3+SMt4
         iAmxxvOrwSxk7Zldi6ekN6QUgnuoi44JrXKmiVkrkuKOcPE6wSkJUH54OlPuAyaS6uwI
         B9zw==
X-Forwarded-Encrypted: i=1; AJvYcCUi9qayc919Yz8D87j03BB72Bp8c+c/oG3PiipqWBPP3y+SSY95hz1Os2O04xzlA33zEXAMegoDfGI74gE=@vger.kernel.org, AJvYcCUt16aZtZ5+0i5CJzpTn7fSAKInTk9aAi9OGo8sLOt9TFDkwkBLo6GQv6ZMlziYzS5YND7puMveu5PYHroDvySKWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfCf+pHGa3Jb9mwc7EnC2YSx3dqGKB9VAg/stvXd4mhX9t3/5O
	owe2jEX+mjJoc3zKk7lEcUn5GuddUEINY7c1YupTaj3cS6CubXH/EfAml6SzZxo=
X-Gm-Gg: ASbGncsWAr9E+KFrlsnB3TENdSZfeCGeTe8z2HxTbEHawiSbB9XLLcU+sFH6PGk6pI+
	fcUDYseolxppT3+7LqdzWpm/6SADY+n4oeRyNNhvfrlc6Im3agb/S+uxfmlAoyOpgnrSBDvic3g
	Bd82YQ6lkYSUEE92iNfWtQk9RGf0ZWtJZkhIF7w68ATRFn7aw1PaUiF9fIpUHpBPzJ5+TEcm5Z5
	iaGs50S8r4AvlRt/KqIFZc6N/JnG6M3kjMsxLR8xLaKyNnGu/IQc69d6mvnKnzPiYI2qr7OrhPP
	G1B2KOe1E+3hLCOHSzGe3ZEsPAI=
X-Google-Smtp-Source: AGHT+IF+n4GSoo2919+P+amVD+5Ilemud3QF+MjZa9U0BBFi95q2jJ/6Ag+A6ciSJrzf8QluIAMPlg==
X-Received: by 2002:a05:600c:4705:b0:439:a138:1d with SMTP id 5b1f17b1804b1-43ba67606cemr18066245e9.22.1740733817353;
        Fri, 28 Feb 2025 01:10:17 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e4847e62sm4588103f8f.67.2025.02.28.01.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:10:16 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf test mmap-thread-lookup: Fix spelling mistake "sythesizing" -> "synthesizing"
Date: Fri, 28 Feb 2025 09:09:41 +0000
Message-ID: <20250228090941.680226-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are spelling mistakes in TEST_ASSERT_VAL messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/tests/mmap-thread-lookup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index ddd1da9a4ba9..446a3615d720 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -229,11 +229,11 @@ static int mmap_events(synth_cb synth)
 static int test__mmap_thread_lookup(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	/* perf_event__synthesize_threads synthesize */
-	TEST_ASSERT_VAL("failed with sythesizing all",
+	TEST_ASSERT_VAL("failed with synthesizing all",
 			!mmap_events(synth_all));
 
 	/* perf_event__synthesize_thread_map synthesize */
-	TEST_ASSERT_VAL("failed with sythesizing process",
+	TEST_ASSERT_VAL("failed with synthesizing process",
 			!mmap_events(synth_process));
 
 	return 0;
-- 
2.47.2

