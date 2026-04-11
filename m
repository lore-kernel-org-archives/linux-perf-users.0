Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C253264F5
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775890701; cv=none; b=ke1q0QuuSmbUe8Gy66FNNkQH2STVKRVdQaqAXes8Xc5yedKhYARFxZn8Vc3VT+ukM5k6g0ymSoqPz+13Y80DAp5W+ximey9QS7axmMyQEmaBtaUlD1Oa2SZ0hTTzJhMf3gD23/FGG4IEbfCTb8zV8dY+NqUsWo8jTxxSpSEVHtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775890701; c=relaxed/simple;
	bh=TORHr2hwj56t1K+9uUsjLQo6KHkuVY+QoSlV3b0luUk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lY/c9ORjQbsDjJsQDN14QpRcMa/DmoRhDSepkcfu3Vx9Di04O6K4YoORLyE8Bpe1QyhlJjZxNrDApQFxhSry/2vQnzOzeKSEWiu7bPI48YZknqQHvB9kuJBUf8BFXzUx9BMNNiTAyvp9AJ4PjzbR5GeSGcLSTF7OKjirH/X0vH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ku2Zr54G; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ku2Zr54G"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so3961842eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 23:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775890699; x=1776495499; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQS4P5hyltqhKwRzLCXyq1MWFkkdWjplTUZAMK0ialE=;
        b=ku2Zr54G7Xhx/PQYEYHNz0TGtn7tQwtjzZaM+4w4sBfNBqVFwaS6gpYGJUR0fS2yDZ
         RPePPbDUYTNsGwxGQ51EmJHtnWXWgY11KluTvCIfqphmj6s8dqPyPRt7ypCjPKJmJcvQ
         f8aqsk710wLUl1FTyiZkuhy5yddBR4AvdY+wJv+jWkXI1WF4E70re9faTWirQQ/GclEX
         yYkm8rSy1BLUCJ5dncZj69I8EsAqhKtf2+QEZldxMNrNIINoMdIOd7t7E3wxRGoEwC1R
         Fck9tPFZAUAOUuhwjIcjp3qXGTrIe3hc2qf2SVI14kGijEdF7ZAVvkRaVSMV5Mep/6jY
         umXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775890699; x=1776495499;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQS4P5hyltqhKwRzLCXyq1MWFkkdWjplTUZAMK0ialE=;
        b=I8G10gJKj2bGAi3rvii8WOn6KtZzfjtzrrvcLMz+8+wSlWNDd5B3tSAdfOjbUiThr+
         bSe7ZWMomV8lxw8YCx5aCuY1CNuaqBeL7GCmCwSB8CYW50l5uvROEtc5DCGMd9uCD9Su
         8AvViOH5+F/+UdBE4HSJyJ5r07S5MLNgoFZ9RuyXD1gySX1Tv+im8SYa+xGUmDe7a9q+
         CBW6PrJfkJwAyaUfzje50tAGzdLP5/j4eMr8/BGhcwJVwFeeFDvGAS5pKEL3nmwmYmWn
         5VyOXZyudHBq5Lli2yu43pdkyAlBN82anb2/Qjn45dyvjB1O0jsJibehk8wBrHdfp4Xv
         T3vg==
X-Forwarded-Encrypted: i=1; AJvYcCX8mSniIWaKpYeEnkBsCoWjgibsIlmhIz6fmpA1/fWLjLQH/uHwpAnjFGrshYASDCG9AZvP9hAu4u/LkQogJWmI@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu6HId55Bnv+JiQHZ90m+8+jLdGWuYrXzDQ8nrnNYayuQj7D6z
	JbgiD46jcjwR7h4XmMkgN3PN2NT08nciHIxclf762z5tw4bqi0tFHnJ1K2HgFfH7jlqxRCQ6uSs
	ISx65CkuM8A==
X-Received: from dlaf2.prod.google.com ([2002:a05:701b:2402:b0:128:cff2:6560])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:68d:b0:12c:33dd:fa15
 with SMTP id a92af1059eb24-12c34ef1940mr3545599c88.34.1775890699174; Fri, 10
 Apr 2026 23:58:19 -0700 (PDT)
Date: Fri, 10 Apr 2026 23:57:13 -0700
In-Reply-To: <20260411065718.372240-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408072601.210837-1-irogers@google.com> <20260411065718.372240-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260411065718.372240-25-irogers@google.com>
Subject: [PATCH v8 24/29] perf kmem: Add bounds checks to tracepoint read values
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org
Cc: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	ajones@ventanamicro.com, ak@linux.intel.com, alex@ghiti.fr, 
	alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Avoid out-of-bound memory accesses by bound checking order and
migrate_type when coming from page_alloc_event and page_free_event.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index daf2272c7337..33585e353efe 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -826,6 +826,16 @@ static int evsel__process_page_alloc_event(struct perf_sample *sample)
 		.migrate_type = migrate_type,
 	};
 
+	if (order >= MAX_PAGE_ORDER) {
+		pr_debug("Out-of-bounds order %u\n", order);
+		return -1;
+	}
+
+	if (migrate_type >= MAX_MIGRATE_TYPES) {
+		pr_debug("Out-of-bounds migratetype %u\n", migrate_type);
+		return -1;
+	}
+
 	if (use_pfn)
 		page = perf_sample__intval(sample, "pfn");
 	else
@@ -892,6 +902,11 @@ static int evsel__process_page_free_event(struct perf_sample *sample)
 		.order = order,
 	};
 
+	if (order >= MAX_PAGE_ORDER) {
+		pr_debug("Out-of-bounds order %u\n", order);
+		return -1;
+	}
+
 	if (use_pfn)
 		page = perf_sample__intval(sample, "pfn");
 	else
-- 
2.53.0.1213.gd9a14994de-goog

