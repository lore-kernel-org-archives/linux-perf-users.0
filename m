Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967120ADF3
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632183; cv=none; b=ommBC7cEO5BTzIUkwQ3V9Hf4ycOAq6X7UhUqHQprt+JgiMwNVwnf7ygkiZIsAdLAD+mVhEEHUA9ltPjMCb1hsnVYjjjijmQM7RGHRX/36ucMJhz2yEsEO1egVFZaPAl80zIyT335is0J4JYnviWnIyJHLMhUlLxAtzA4aYAwevQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632183; c=relaxed/simple;
	bh=j9xoZhKUCxCRzKJME1b4ctoFywjIrcKy9BRs5A8oUiA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fc46PASJuEwXlZjmVxy347dNAfbNSHM/HKmrFQoYzZupf0+9CRw+MsVSy4m/3R78eFx0ilP3KZuC/thnEyyo0a+qxsDNZQ95A+IH+JtTcfjN0MxzpiiGKs7eE8KdfN+4Ta05eNOSPcvwZhKPaV75gFW+bBlT/T02AzaB9awtEfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8AVxat9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8AVxat9"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e355f1ff4bso1267407b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 00:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728632180; x=1729236980; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rgB00BYIV9qluKgj4RC8eehGF10YxeeBjZZWHyrv1y0=;
        b=I8AVxat9xAgei/C//nqIzXdAJBCUCCuO9S/PcN8lkDsLEfSR2WQQD25ufO5LuXQSKB
         detIvKc4+F7p2zvxeO7xfq+iXL2GwY61F/3Byi0JfvEFDzjDDpvXfdNoxgrfwpdqzX4F
         ATnw+iyoGV3888CymuzTSHQ1M81ys+mmGDXj4LR0bsF4QR3IB/kOz3aaz3oqtgr74b99
         xcxKB9YohduVKUFt8fY+o9eSfoGk2pdHkfnlZ8BHPXaHkSsvzQxcEZbMz0i8/vWPY6kN
         8uhODS7W1JHjKdZs8gLkdUWwMD3345Yi84fl+n7qo4IkTYgOTwMKdRBq91aRZ057xXN0
         L2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728632180; x=1729236980;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rgB00BYIV9qluKgj4RC8eehGF10YxeeBjZZWHyrv1y0=;
        b=DF5l692Si2GFLWWDBaye7qN4Q11+EZR6639IPZ8DURCJj48Jb0Je5nJwbsw6xt3K3o
         XvvPCyd3uPAHN2GlkHD5QeF3cY1xWMUae+7dFtzvhHSWzs0Ep4MCyjvOlbwNwS/NU3KE
         8Ts94D92K/8u0Y6YvzWXaapJVUYFEKmSD+7Zyy3UOb6E7P1KD/8CH30ku8Q9dlRbcupQ
         i5ycR1fXTEO0N0gZOmkYm/tEJp+9+W7oZDCKQdKXYHgNt+Ii/NKrBLVHmWq6JZomlwNk
         FfTixxehtSsxSWlmtiaoUnv3q4dwZm4IqEAydACZjwn2KPE2ACcXzZQ5A101uM3GuoK5
         YZcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlr/kDu5zYUB6m7Sk9kn/HeiUbMIiV4gLWFJyPQLsxFynwY/Eu7dMPnF9G/tlrhEkyvUbtO6H/ZaZMUlO1oRcy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Z6RvDp/wINuFUVfq8Di5bsHgajsazsm4H2no91y3klresj/4
	oTC6Yr4Timu6BPyCItSMucJm3OrY71rKbRzXNm8r3fR5NopgS5dbu6bDFP6RXXtM0Ofqk3LRIoD
	myTMKvg==
X-Google-Smtp-Source: AGHT+IFAgo37u8rfjVAYg4qiXtWEdAHj0LY5XoBITiq7BqupjjYH0ReOmowk3vBX1hWxCN/0yj8Fi53KsVtF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a05:690c:4449:b0:6e2:2c72:3abb with SMTP
 id 00721157ae682-6e347c85db8mr432917b3.7.1728632180691; Fri, 11 Oct 2024
 00:36:20 -0700 (PDT)
Date: Fri, 11 Oct 2024 00:35:54 -0700
In-Reply-To: <20241011073559.431302-1-irogers@google.com>
Message-Id: <20241011073559.431302-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011073559.431302-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v1 3/8] perf test: Reduce scope of parallel variable
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The variable duplicates sequential but is only used for command line
argument processing. Reduce scope to make the behavior clearer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index df0466d3def6..6b8ef198d975 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -41,9 +41,6 @@
 static bool dont_fork;
 /* Don't fork the tests in parallel and wait for their completion. */
 static bool sequential = true;
-/* Do it in parallel, lacks infrastructure to avoid running tests that clash for resources,
- * So leave it as the developers choice to enable while working on the needed infra */
-static bool parallel;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 
@@ -566,6 +563,12 @@ int cmd_test(int argc, const char **argv)
 	};
 	const char *skip = NULL;
 	const char *workload = NULL;
+	/*
+	 * Run tests in parallel, lacks infrastructure to avoid running tests
+	 * that clash for resources, So leave it as the developers choice to
+	 * enable while working on the needed infra.
+	 */
+	bool parallel = false;
 	const struct option test_options[] = {
 	OPT_STRING('s', "skip", &skip, "tests", "tests to skip"),
 	OPT_INCR('v', "verbose", &verbose,
-- 
2.47.0.rc1.288.g06298d1525-goog

