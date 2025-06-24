Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E192E7653
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 19:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750791816; cv=none; b=VNNQmjAi4GZgeL3wRCSfCOC8wHlB45JKRgX8WImuzZBEmR7QZh5oChs8uQTr+0EOoaJuNISpfWAESo7vEp73WfezUeo59WP6GEKYFzQPG+sI5/pkD6Tksji5TVAyqpDPSRCDvUXJCGpyeJRQBMFXi5dm4iGzR/uAwbPERAJzZ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750791816; c=relaxed/simple;
	bh=+VqdNyAU7xmLjbwR33lOaXTxN2lkq0tJ1SdzqhwGtgc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Oz6BnIgVXgINozX7IuDLA7VgNw4eWY/RJA+bZ+aOnfOzAqe5pPWXAx/gmW9+S5tVjcKWnUrY7e1sghD3BEIh3mKC9JmBf02ToOENKE4IRis00lc9MaacsV6nOW9LAlkYXF2h4Q1ka3r9NgpO91VGZ0tQabI37ef7k/8FRgK7bks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L2A7sj02; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L2A7sj02"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7492e654cdeso373102b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jun 2025 12:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750791814; x=1751396614; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Lm/IbEx6R0SSnBj56mL+ciOEH3EHGJ1ssPuhOnqIVE=;
        b=L2A7sj02fx9yKQXZCifUELgMtMoxvAyPn1AWDioNJt5NN9jiQfCem4FZw6etqHcnKl
         gGCfw5r3LdLvIhrEFp9ZeYarEpEe8+S9YAEP60dRnmTi0J0zB+GIfNTqe4tCrwqqNXv2
         hPAE1q5SwLAiL0Ofsf4YWnl7WJ9HOXuaXybu7YiY5JMcRBraeujcUX2rZgcGmmHdRabu
         MXtWqvcqywpYSXoPec6VW9/qkbOzeN577H4he7l55sf5Qy8FNWL6+Perowqm7pwHki59
         cmJNfwT7IJe5L3Ni9F/uYjY1YvpydXnzNjRz52hZ+/LhIxoovjv8YDQaQV2eKnhDZrfw
         omXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750791814; x=1751396614;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Lm/IbEx6R0SSnBj56mL+ciOEH3EHGJ1ssPuhOnqIVE=;
        b=HkOYGHqRohy4c1C2cS4E9oSHyfc6f9t7PaamYWw7OB1WX8JxNo+blmBeYhXoTdThms
         GI8NUXYf6s9O8A1UuOYUJItUtkJ80qAfa54W0Y9xPxzH8iHQ7Oa8BSE/aNhW53R9VCIy
         uYSOflNzjowTev04lEedHCmmNLOm/YiRNvEbFBDrBvJ7ZuUg83zob7JbqsglT6dzlaRx
         UFFcBvWvtCIEkB1yAj3TfuiPPyonmRX9RHZXI7HrF4daK0NqWpK+WRQ457pQCsAT7se0
         /y3g3+wUF227VGVaBKCqpsMB45dOsRyayHE7NCftITL9JwG4he5/w8villNapOhZR0cO
         6V3A==
X-Forwarded-Encrypted: i=1; AJvYcCUkChtLcpAk86Kw9FpJaz1a53yCucohyzAol7BHZudfv5skEVEQjC6ed8VEscUZcDPnKBkff1ablCBmTXV6L1lM@vger.kernel.org
X-Gm-Message-State: AOJu0YzpvGD4SF7OU7o4XcOOIAba+NbE9ezWHPLrbLgelYM+3K7cFf9a
	yC5lwIxqaCn33aMEUzWloTXXLzYEFPO863xhF83Mw3NQJZArkJHBuXJG5ItYWn7QJJZj3WrRKQy
	oA7geL1OUpg==
X-Google-Smtp-Source: AGHT+IGJ9yEUYLjTSRdiHE/QX5GvHiGdASKkqLhg/pDe3gFNZXNMK0+DtFMCh4mraC9S1u01oH1oQTEht+uf
X-Received: from pfhx37.prod.google.com ([2002:a05:6a00:18a5:b0:746:223d:ebdc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1146:b0:748:3964:6177
 with SMTP id d2e1a72fcca58-74ad44f267dmr327221b3a.19.1750791814219; Tue, 24
 Jun 2025 12:03:34 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:03:22 -0700
In-Reply-To: <20250624190326.2038704-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250624190326.2038704-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422-goog
Message-ID: <20250624190326.2038704-3-irogers@google.com>
Subject: [PATCH v1 2/5] perf test code-reading: Avoid a leak of cpus and threads
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Dmitry Vyukov <dvyukov@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The perf_evlist__set_maps does the necessary gets on the arguments
passed, so the reference count bumping isn't necessary and creates a
memory leak.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/code-reading.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index cf6edbe697b2..6efb6b4bbcce 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -749,13 +749,6 @@ static int do_test_code_reading(bool try_kcore)
 				pr_debug("perf_evlist__open() failed!\n%s\n", errbuf);
 			}
 
-			/*
-			 * Both cpus and threads are now owned by evlist
-			 * and will be freed by following perf_evlist__set_maps
-			 * call. Getting reference to keep them alive.
-			 */
-			perf_cpu_map__get(cpus);
-			perf_thread_map__get(threads);
 			perf_evlist__set_maps(&evlist->core, NULL, NULL);
 			evlist__delete(evlist);
 			evlist = NULL;
-- 
2.50.0.714.g196bf9f422-goog

