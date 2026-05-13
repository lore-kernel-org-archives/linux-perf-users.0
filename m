Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2533CB2D5
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713530; cv=none; b=fergQ6Q0U4qov6AIxITMJgKg4p3/JRfF+g30k0usQRr3iS/5QVpKgDVA5gfI4Dy2RUVfsu4asHSr+tGt7gXmTj6XXHWtC6+W6pdoUnQPfhLN9TWPG1Ns6XSbDiuB3SqqWm2F1Vf3y8eDoBBpCKcgPOh6RCk4fK/jupp9Q88YZIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713530; c=relaxed/simple;
	bh=23svWQR1tGNJcfl+pZvIGZaBZNczvDUriioTn7aANN0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u+yKJ6aDz7Xqha3GHQDekh8xecqXZDpPszF00F5Ft/tR0h9yl/60lDTOWzHntRpOwadlhTgVXAOIpBU+quqc3bJFjqdt5Hbm8pXTy+NQRXOtwTZCUzwumifFO5b3huKXlGrsxXl0ZWk/Xf9TJyC2C6Qi0RG4+mmZp9O6YHirQs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nO350r6R; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nO350r6R"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132a99125f8so14097786c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778713523; x=1779318323; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0MHviYuTRfGteEilTEQPYM3fR1esF0zt2OHpf3UUwpo=;
        b=nO350r6RPojpHZ8razD0wTnz1eYQjzAgme24+yws6OfSf277poWEv4d5T3KKlNUPkJ
         m+5odje1D8ACe4pZUHuzYrmdOAxs9U/ORYwRnyQR9KT3AtluWqVQGld4CndFi5oI+0jE
         8+BbEP1L9LDvAhLpmwafZo5FvrnOYnDP/qNA+nEUvYg/D6kegSvMDi2HJCjsMrZCdDQG
         +EQCfc19jhZseGF0EpwY8eXPJQmqBjO4nRz1/yvPLToduIO4ICw4SmaTcVOZc2ZLm3ak
         T9M/SMYp1gRU0lu1hNLq9O3Do2EjRWEgCAEBVvnzkoPRushs4zOy61pMxM4PypuMGi2T
         L4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778713523; x=1779318323;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0MHviYuTRfGteEilTEQPYM3fR1esF0zt2OHpf3UUwpo=;
        b=qT6ZQj991VCsG7gkbFVyNt1dBnciR19yoEs/piJHI35f8RPy2nmZ8fpnicdeJn8T6g
         vuvSKa9lQK4qGKG+IjrWWmBDo+B0WFUNUWuA6HNv/nI+uaFmKXM0LRf/c2SK9vja0NRx
         2EyNpsr/iU2wEu6Hx7KV4QfRHH+kD/7txWEm2Pj/VGBh/se9VhTfBOuBu/RGjqz4MOzn
         7AogaP2pq05uDYAYcsFKFGLuRMia8h1+tIldNgo1rvfAJiOtF1w6VDXREPLE6Dv/bkK8
         AHnD7h/AWKNtWw4umufZtpRlbLPtOxOqbRMB/H+3PaWeWCjgvFVutaAciZhmrAHySF7M
         NrgA==
X-Forwarded-Encrypted: i=1; AFNElJ82lkX0zTkyneAmknkuW3ssQZevlxpVa8Zbo8SokAYdZq0fj141cHe/7AdCMa04FjaWR2jLWAc/fUGfPucJncCR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+xmOh12qPT/FbaX7y9ptGhhIIluaEQyPl6M8h71UVQXp1qapD
	ljEFenY/tE245jEQF/2sT5MtVXEN9fFitdeW/NDI3lJd72YbVPqZStsGz1fRaFrbjsMC9Mx/ZsG
	4rJ3KUkqAOg==
X-Received: from dlb13.prod.google.com ([2002:a05:7022:60d:b0:132:8d92:4d7a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:23a3:b0:133:39a6:2bd5
 with SMTP id a92af1059eb24-13439c5c93emr3162456c88.44.1778713522370; Wed, 13
 May 2026 16:05:22 -0700 (PDT)
Date: Wed, 13 May 2026 16:04:45 -0700
In-Reply-To: <20260513230450.529380-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513230450.529380-10-irogers@google.com>
Subject: [PATCH v1 09/14] perf test: Fix subtest status alignment for
 multi-digit indexes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

When running perf test, the status column (: Ok) became misaligned when
subtest indexes reached 2 or 3 digits (e.g. 9.100 vs 9.9 vs 10.1). This
occurred because the subtest description field width (subw) was statically
fixed to width - 2, assuming all subtest index prefixes were exactly 7
characters wide.

Dynamically calculate subw based on the exact character length of the test
suite and subtest index prefix. This ensures the status column is perfectly
aligned vertically across all test outputs regardless of subtest index digit
count.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 193a7dec6d5f..765724817776 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -370,10 +370,11 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 			     int result, int width, int running)
 {
 	if (test_suite__num_test_cases(t) > 1) {
-		int subw = width > 2 ? width - 2 : width;
+		char prefix[32];
+		int len = snprintf(prefix, sizeof(prefix), "%3d.%1d:", curr_suite + 1, curr_test_case + 1);
+		int subw = len >= 4 ? width + 4 - len : width;
 
-		pr_info("%3d.%1d: %-*s:", curr_suite + 1, curr_test_case + 1, subw,
-			test_description(t, curr_test_case));
+		pr_info("%s %-*s:", prefix, subw, test_description(t, curr_test_case));
 	} else
 		pr_info("%3d: %-*s:", curr_suite + 1, width, test_description(t, curr_test_case));
 
-- 
2.54.0.563.g4f69b47b94-goog

