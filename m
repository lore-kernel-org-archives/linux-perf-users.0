Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4094C3F077C
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078962; cv=none; b=hDdabFoXtG0TOZq79QZqibbkrdOJmzeJ/VTHlLa0hIsb8NaxZeLBNP/zbSmw/IXke44wmKI7E7JqFxImtLEH8QWq7dbbkOhF5MKRjm9iplx7M+yS/6I6G11F1ysUWx62iQOweyBuiH+gPZo8T8Wh+wH08pexllhvnrhh8T0Tc68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078962; c=relaxed/simple;
	bh=aLAu5L0fib6HrBbWc1UtveitoT71aNAt4ZUMnsx8dho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSEB3pumyul/R3GxT3ZII9SFqSohrifnmSqwtbzkT8cj//SIjXBPVzc2OUf9peq/HIw4N83wSCRZikPIu3ehVgK/sykfJlg4n/hDqNjsVUdNCSl85xv5TRDL/W660chsCgCQ3oGpZTn6AxTB17uR5hiKxpH5Wev4lSAAVQqBkhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu; spf=pass smtp.mailfrom=ncsu.edu; dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b=Avdkf+yA; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ncsu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ncsu.edu header.i=@ncsu.edu header.b="Avdkf+yA"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ad46a44easo10628066d50.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncsu.edu; s=google; t=1773078956; x=1773683756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCxAsFvxZFzdJH9MRwGNnxrTqhY6BlYrnwFDORcP738=;
        b=Avdkf+yAfDD3RY3Xb1GXiMz56HWZW+x3cTiP3yM34TR2jBh00IWAosDznPJHQWIR7h
         RS5qw3ZohpDsQTgxQB2QoGQ0cq+fQyvQZPzzki7UftDkxbR3oHgmT/lZSX1LCsnRwjrO
         3yPl4e3SyMo3OV5spm0/NnKii7z3qGCayXNQ69bGYItwB0sC3wMHiPhAKE5AkKY9nmSk
         E7ztARpdniAokPbIm1rVMT7VlXZqqAsXrRLoZEDCblDTmN1E3Yi6dtgcEdE+qng7UG/A
         /xKACCD05Kmy6YQh6SvaLo6yTz2SsbTAxxk1gdgs0RR/yMvgEbODrFmsEYO6/GcCOzNX
         0r3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773078956; x=1773683756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZCxAsFvxZFzdJH9MRwGNnxrTqhY6BlYrnwFDORcP738=;
        b=qFScEnk6snHlImP2m3z+gGY7d2A6r0nilHWbuO584ggEUWzWJtrNLBYfyJGWCGbeLg
         LLL+e8XciOay8lSKmcxZB2achs2uB9hVuzTW7Y5EUJHbrn6BMJSYwHd3JjQ1ldvMHOV/
         sWnFCiSBWl8KI5D0Dkpv0uWahk1hjqq0VzhXFC5tGbo0oTH/anBQzPO23vEqr9Xs99gK
         BziEiIeAMSUc0I0bUCc+RN5vbGPJIokrBUFFKiXGGwKzLoyy05pgNChGfROncr+qb6lW
         BGafeFuGLu52FSY8pGX5Rd5ewvvyi2wGgUTIUKdBbKmQnYIiDfNAVhaU41CFKklKyjdF
         OeQA==
X-Forwarded-Encrypted: i=1; AJvYcCVUpqtrN/pEYV6WySxUkvvQ3EfWUOiFOHzFnzK6vr5B3n42NbmuiaUr8gKDT6Q+yNXVMu/LPiK1Ua7FfN0cWo2o@vger.kernel.org
X-Gm-Message-State: AOJu0YwjTdXDdgBLWDStnIm8qKs4vUtKOQe4w0SL/9glNj9bR9oHXPYQ
	9F408Pzwl8P997DmIVFjGoOap+9LtRc6C5rCBALmL7EftCRgVA1HoBVoz+s+uaeTIA==
X-Gm-Gg: ATEYQzzwqfZBcoN0udjw/sS7cXQCwDYn85lG/UFf0Eysc90qHkT40alrft6IWnNArH/
	SrHprL7VgNkXJ0a2SAdgQRJXOuHOMmL5S9ye3MHVPDiGq5bDRk0wlmqiblsd0Yus4GIfkUuhk8F
	FE9o/dUDkETWOY8XvYNdeidjvqJUkbx9jcswjMW3ai4Es+y1vc+5o8moKYLoZ7YMJRBJjTr1qQA
	P9BVMZHe8vpBWIji4wQixzyfMrhrk8LGLeX4XjodGkijiBDJUc/JjfReI3+fMqMUjejOMSE2ANX
	BvuyrKDtgGsaLMaFJOFym4OeUwHkhxOA86A2c3HC2Spkwl/FlDEi0am2EaRRZf7XiclGlYNMTc6
	JdywOa/oEOSAYvEQegf1LhfUokN+OoCXEFGqPKx257gndAd8XEHH2w/3GUkr4c1o5FonvqGe+fn
	RvVfUjcJ7iBq9PQMKOG/rRhKKwsieV4Ia5m7321jb/8QucfZCTxV87HePo
X-Received: by 2002:a05:690e:4012:b0:646:b1f3:aeb2 with SMTP id 956f58d0204a3-64d1405ec3fmr11748106d50.3.1773078955907;
        Mon, 09 Mar 2026 10:55:55 -0700 (PDT)
Received: from um773-cachyos.sd.ncsu.edu ([152.7.255.206])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64d176e70e7sm4992535d50.20.2026.03.09.10.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 10:55:55 -0700 (PDT)
From: Zecheng Li <zli94@ncsu.edu>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Zecheng Li <zli94@ncsu.edu>,
	xliuprof@google.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zecheng Li <zecheng@google.com>
Subject: [PATCH v2 04/11] perf annotate-data: Improve type comparison from different scopes
Date: Mon,  9 Mar 2026 13:55:17 -0400
Message-ID: <20260309175546.916039-5-zli94@ncsu.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309175546.916039-1-zli94@ncsu.edu>
References: <20260309175546.916039-1-zli94@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zecheng Li <zecheng@google.com>

When comparing types from different scopes, first compare their type
offsets. A larger offset means the field belongs to an outer (enclosing)
struct. This helps resolve cases where a pointer is found in an inner
scope, but a struct containing that pointer exists in an outer scope.
Previously, is_better_type would prefer the pointer type, but the struct
type is actually more complete and should be chosen.

Prefer types from outer scopes when is_better_type cannot determine a
better type. This is a heuristic for the case `struct A { struct B; }`
where A and B have the same size but I think in most cases A is in the
outer scope and should be preferred.

Signed-off-by: Zecheng Li <zecheng@google.com>
Signed-off-by: Zecheng Li <zli94@ncsu.edu>
---
 tools/perf/util/annotate-data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 23a09bf58f86..6fe2efd48a83 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1629,7 +1629,9 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 			pr_debug_dtp("type_offset=%#x\n", type_offset);
 		}
 
-		if (!found || is_better_type(type_die, &mem_die)) {
+		if (!found || dloc->type_offset < type_offset ||
+		    (dloc->type_offset == type_offset &&
+		     !is_better_type(&mem_die, type_die))) {
 			*type_die = mem_die;
 			dloc->type_offset = type_offset;
 			found = true;
-- 
2.53.0

