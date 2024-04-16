Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44ED6CDCF
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 06:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248158; cv=none; b=lpPVaWmKcfykxE3hyii7iT3MLEmViv59Jt1dMd+nUdpG5BWc7pN73C+9ILTI2Ej7B9l96d9KdTkHsOctIFHgKl73Fypk9q7EG+zExQOsxuyYwuRE5y2xeNwu/OiZulvxTK/VyhxIdAkgAv065a5AiFpSS+447h5J5i8FZ47CXZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248158; c=relaxed/simple;
	bh=jUPnR8Eh1nwHTyI5wvU5SHFzAhN1eHw5S1/Bwquryzg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=m+IgLUNttcXOVyjbcD1I/vD1fj74Ac+WQmvKsIgsGRzlnCp/YlRXjRMPnCspXTmibrSYeUbyH5tYaLhsBDValzmCgMxth5dUgLl8wa3KJ2cDzaU61AxYlX9LLB1W8cMdEaNbAyzEspWM8fqs/FHHNCAqQ3oECOP0V4jHrkdvzJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T4zthJnQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T4zthJnQ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so6690216276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 23:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248156; x=1713852956; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJgB8sDKrPml3/XRc3D6gD41xE7ASJL2MP2+Oe/niCE=;
        b=T4zthJnQjIgsQSTjSiNfDEarAik0KXjq92p6b3EBIeUPznZRCGJ4Ar/gsCIUiWkotW
         l6t5+Zji2uVxVHC7mPk/vGoTeOHyf2C0WSmpPNhDsudRIp5QrHfIDqmdqcpCPw14lMqs
         fpGRN4h6vnZWfH0OA56y9WRVmS21SML5rQDx/gXlzLAsoFbwoQk8EixnBRw5d7gYAzSA
         2bCM48y7m/rBQWwYisR65iZYGpANvn6zJp4HAm8WNrxTmPeWxmqJT7ztSLIKvz5nlEkJ
         GLcTiW7Wswmdn7TXiRDFaW/89eOzdOyT9qpb9AobL/xZP+8cVCzay3ZwGrz0oDkY+BF/
         RZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248156; x=1713852956;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJgB8sDKrPml3/XRc3D6gD41xE7ASJL2MP2+Oe/niCE=;
        b=h7sibfYLtBFtqP/D7ZAMXUrE+ZcUNrZhO3SbYM65X3eQibcj8RAlX3eT5M/g7PkKtB
         8ZZdYgk5nfiXg2nJUDe+RpES8Y3MO3R64InDjyCl6L6mQerdOpIFvOjX5xL8PZRqwMhR
         OavfUqdAe0SwlS7ykGSMoMwDUxyjXA/9vUhpf8IR3WsYvrdjs7qF/KmxChI6day6S7W4
         8+VPBy8FVqoeIP82mvFoECyofDq4E60qwZc8NftPaWZg0MmeW3cZI4tzjGQENwz/24xE
         OBG9lLezfrF7CDmVccP5NXJPkdQJzNde4lZUjt+pNdyW1hAM4PknFTOHSmdbO+R/k1my
         i5JQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6ExFfonbGRgBLMOQWfPBxlqBIjBb0M9Rrj/Ibz1K76TGd5EgFBmsytvJm9xZDJ2gD+Rc36ZaSkQV9lCtwTD2XbEvwGmTBu23WGJGiVdCVZw==
X-Gm-Message-State: AOJu0YwBYf1Vv5rAExFzTjYdU1DjIPZC09vc1auPZ9mZJO3AfM/qVkRN
	AwV9HaGib7ZyG2sxsDk8LYlXCE+UOdVyXB4GqbM46EJK9dF+qCddFFaGWYxY0p6xBfwFVLjC2kE
	ydgG15A==
X-Google-Smtp-Source: AGHT+IFvz2/ElMb8sqisE4iRWPUFBqPFEJev0kX5N83qt2rasL8K27n6w9ssQTNUocmaX8KnE4uhTcFVZFa+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a05:6902:1509:b0:dc2:398d:a671 with SMTP
 id q9-20020a056902150900b00dc2398da671mr3887166ybu.10.1713248155750; Mon, 15
 Apr 2024 23:15:55 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:21 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 05/16] perf tests parse-events: Use branches rather than cache-references
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Switch from cache-references to branches in test as Intel has a sysfs
event for cache-references and changing the priority for sysfs over
legacy causes the test to fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 0b70451451b3..993e482f094c 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -942,8 +942,8 @@ static int test__group2(struct evlist *evlist)
 			continue;
 		}
 		if (evsel->core.attr.type == PERF_TYPE_HARDWARE &&
-		    test_config(evsel, PERF_COUNT_HW_CACHE_REFERENCES)) {
-			/* cache-references + :u modifier */
+		    test_config(evsel, PERF_COUNT_HW_BRANCH_INSTRUCTIONS)) {
+			/* branches + :u modifier */
 			TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
 			TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
 			TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
@@ -2032,7 +2032,7 @@ static const struct evlist_test test__events[] = {
 		/* 8 */
 	},
 	{
-		.name  = "{faults:k,cache-references}:u,cycles:k",
+		.name  = "{faults:k,branches}:u,cycles:k",
 		.check = test__group2,
 		/* 9 */
 	},
-- 
2.44.0.683.g7961c838ac-goog

