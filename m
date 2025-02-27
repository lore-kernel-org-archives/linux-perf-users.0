Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFC418FC84;
	Thu, 27 Feb 2025 22:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740693856; cv=none; b=quIfAQDx8qkjRkpjEHWfomuiRHcZDebciuNzILIqmyFT0nZHb8n2XMlP0YzWnB6+YJ8rBE4WQ97DdeljI98c2XhUxmvqqSYqM400m9JB67vLSeyfXA5FMyzMszURPdiKJ+LVwCDS+lcGuEMlgLgedvatEJ+47iKe/om9ymV3BrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740693856; c=relaxed/simple;
	bh=xngXQqYEAcf/7AhQRNhKxM2ws1Kd8055O4/vXTYh1qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VCv79byYN7VuSpsvj0HqA1WbvOc6qTOJuSgt19L1/aVvLr3f0rEMdwa3Q8NWALudiDxA1iuX4MaDqKXufi2TlcgB9tWq9MwzDaPZp/6ljmwyHsQiuhH8C4Fl7HFh91AKa/o0bj1RJYr4vptGnsdcrH1QZ3FMw54UtvUBVHHMolE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3r0tyFq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3r0tyFq"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso9648015e9.3;
        Thu, 27 Feb 2025 14:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740693853; x=1741298653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CTEICTXX0v/2ycsWLKp/kEJBl5CKbsp967v5/0zdLMY=;
        b=I3r0tyFq9X6+3koEpAkWH74+MZndeCO6RBjQqlPKQrP3F0dMRFctjGgi/nOq4Fyri/
         y0pGEoF/0IgQdgi0OJKbAISBm6USBt64OpOSQtiCyh1Uc3bwErgDFVDCo/wxFFBT7IfS
         R3JD3TOXTncjFbvpHrrd6LQSmeIyqnpjCi/zwBsjqLILFlviY+jTfsIEcPiC7/P/AUhh
         U+1UUAX45DgrAJ6x7qGT8tzWf+S0yv3FA8f2KcWmmjwT/yiccF6kuvsaLM9tqKkprnXe
         lH51OhbCHxkBfZVtONF4qfqQN5kexVxMjFUtioL8pGfWkQWmgG0d7kiDEu76Uf0Mmhqv
         /8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740693853; x=1741298653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTEICTXX0v/2ycsWLKp/kEJBl5CKbsp967v5/0zdLMY=;
        b=aRjVkor9ygC0FgRRZ/I1wpl7Falf/3ouwq4+ir+M5dwmjsFD5fRtfBBKc8xvKMtWGV
         T/CMkXbhDG/6781TySz5KGYltLeT199JlbTkxpNODnU/ugAUlizbxvPFB+P1Bazdr6s9
         DhqT1zPU5vJspGtuweIxLMzT929MvtKVbZMM4DoFyP8iuHn8XN8yUpxFMOKuJXSRH6EI
         44bK6OdNS+9jdXuKp5PJQaukwMH2PQkJmvdJj4x5Zhk1buXK0i5zLp6YgowW8ussESvu
         Fep2lD8K5CAelte2B7xMhlGkILXyyR0BZ9Vyp9HLOcTm7GdkJBQnt5LcTeZsHInJ0X9S
         J2mw==
X-Forwarded-Encrypted: i=1; AJvYcCUXrFv/hTlyhFe0iaXpkphP2NJL27wH1gqdKEHMypVlTNO52fMk1iFZfOqyJCvoLUTq096jLWyb1tDoDNWJwQujMw==@vger.kernel.org, AJvYcCVzppzRLWM6LTHgMAD7tSac8OKQ545hpKOznQO2g/dqFdHxQa8MocMXHuRHSXEqe8tVOiHnadDTU7IUQCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiuXdbyiZqdLtICQXgsv13ZsXp275i5wd9oLujVFlrMOmql+gw
	75lYyV+AJXT06CGdjieyhsybf+sL5U5KZeZ+wV4LmAQw8HdA6IYy
X-Gm-Gg: ASbGncu5EUS9Uh29+zCtJU6W/q9C0qCN0eFYlvBjXqJeSyKxowwlB17Zxx+1du4qvW9
	EhE4OPqFPtmSyPf1Uu3inVuHgfF0p3WE8PcsL6BUh50wjzwNWCxzlt9nE96BGlzNf1IGxVVb7tZ
	8aC4LDVi00F25uJn408u/472pwtlrc3zD4CR4vGzD7U+NqfZFhdIhoJHG8FBonqMwVMG1/9Hz8+
	AuBWhlX9yS/KL5B3KIogEWf0X5znIE6d4ZWKx2zRe2/wexvB2lrj/sRF1IkV7eGSjJr+pQCU95o
	CuIUH3gBblfSQ8Bv6qL2jtEHlLM=
X-Google-Smtp-Source: AGHT+IHYQVSTiCOehgMLftDnItrbUgzcs+nCocHyjI2ZzAf9fDCP0/5iMgqxOIVpoWgvLX6RiklQrw==
X-Received: by 2002:a05:600c:4687:b0:439:7b5e:820a with SMTP id 5b1f17b1804b1-43ba66e1baamr7596765e9.11.1740693852611;
        Thu, 27 Feb 2025 14:04:12 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43b73718abcsm35271345e9.22.2025.02.27.14.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:04:12 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf test: Fix spelling mistake "sythesizing" -> "synthesizing"
Date: Thu, 27 Feb 2025 22:03:37 +0000
Message-ID: <20250227220337.656384-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There are spelling mistakes in two TEST_ASSERT_VAL messages. Fix
them.

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

