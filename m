Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8412205AAE
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736459472; cv=none; b=qpsAAqFPtoYnnAI+9Ca1gPHPwGo/feY4gDTydNyPOmMCv9eP2zF0lynP9JPbgKYXzB9MMA9MNuhqxMa59uXcqqyvVbsEtFhkRluXsfaq3YjSJFGNC6BToBNpIS/xtEIWha0yoZ9oRAjoRzW1xWKKcwWW2I1ABXXR6kEOucxoQ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736459472; c=relaxed/simple;
	bh=03zxN2UsxLOpbQk3XmD+PZeej4CtfK4bugESkK4+E9I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Wasev7Zb+mLSgY3DTRgv9sGg8r27MbOSHi/BbuAjp/gWQi6jEb1V6y2Egfs00rpL6JR6TXe39ExdEYItBVUZGVqoyGdrDiMjRFsFdwAfKH7SnkIVZXpi+nVmZT8ESAstrTJyy8FVUExDuHHouZapEL9syBeF54nzV8x6ThzU/3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sPtnQchg; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sPtnQchg"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e39fd56398cso3298425276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 13:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736459470; x=1737064270; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FgaDCd82RhWxCDiAHRf7hDKnWcYPhRmEM5CI1fivqE=;
        b=sPtnQchgkOk/RR8E/0zKBd9ApR6j+QvZqH4+gUc1iYEo9k+bhVcZxPZ9tQACveLWhv
         03ZNdSLJJMO6avQ008MHixARBbrNyEbTQwccJoT48ocEUodC25p8GC4e6ioyAo+2DT61
         HpB3OCA8XvyjS2yTHJ3cO0apEDhLoRmvSUKUSrL4H/8/bjbZ5Odnk6TdbeGRW8Cc9MdY
         q1ITHa1C2EJH3upNLAGuusTH7Hos0IQTsfsz3pvV7T/HjOKTdlCky8k595wmBkbHBSTK
         giFHlKO2fHDRzHmOLn7tooT19R2fp3eD948ZEtQAdFdc68ddyXPp9MSgC9Qf03ELAnPm
         6qqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736459470; x=1737064270;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7FgaDCd82RhWxCDiAHRf7hDKnWcYPhRmEM5CI1fivqE=;
        b=Ynw7sraIZAfIe1Ky2aXEF+m5hlytZn2g1nHm9JASNkTj/hy057gihk+TWIUeXDGR91
         coB/6dHikrc053DK0Ndcnoc/zlP6h35eIfWk/eOyvLScOc1TzxdIcIlHyBoqZAqDv7L6
         ldki4K9xxHykdqSFXkNvNwziXR7YFviGyggiD5bupVHvBumXAOdaOjZulsUU5+qXdLFa
         fGePCpMdDGS8P/inLcb423avsk23gaAVdeEPfWGigfHbdpt4Y+Cw0kPiLe9LEAWAVyzo
         9YdV0lC0mm4sOGAgalyYJ6M/tRWtQwJbVTOVy5agiNjjQfJ6shPmowB1Yv5R8/Z1w7Vd
         osww==
X-Forwarded-Encrypted: i=1; AJvYcCW7hTmy4SlZ6n1VgaVHygsVJk/4PeN2oumLncXBLdm3ab7Hyn2BXkr+QZ2Ue2mI4EXMXQ5i5Sbppqi89dQyARGC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzda+XrbMU1ooH1KVutCCt+MphPjbnvYM4rTosvE3HhkXXliexB
	z2s3hpd2KwKLpDOfFbaSJqdtDDG6mG6QRKYgwFvE+qst1auwbl71vqeLMxJlei/wc/Tt4Ya70M3
	jMe2T4g==
X-Google-Smtp-Source: AGHT+IGnwX6L2FUl2G02NKrPL02+5oEhagwozaUuxDFAZBw9MxOCG2u4MAxOOJBXh733/cqFCLlq67k65p81
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a05:6902:15c9:b0:e39:8506:c03d with SMTP
 id 3f1490d57ef6-e54ee273f9emr23376276.9.1736459469828; Thu, 09 Jan 2025
 13:51:09 -0800 (PST)
Date: Thu,  9 Jan 2025 13:50:53 -0800
In-Reply-To: <20250109215055.454888-1-irogers@google.com>
Message-Id: <20250109215055.454888-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109215055.454888-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v4 3/5] perf test: Remove parallel option documentation
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The parallel option was removed in commit 94d1a913bdc4 ("perf test:
Make parallel testing the default").

Fixes: 94d1a913bdc4 ("perf test: Make parallel testing the default")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-test.txt | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/perf/Documentation/perf-test.txt b/tools/perf/Documentation/perf-test.txt
index efcdec528a8f..8f8a3c367570 100644
--- a/tools/perf/Documentation/perf-test.txt
+++ b/tools/perf/Documentation/perf-test.txt
@@ -35,12 +35,6 @@ OPTIONS
 --sequential::
 	Run tests one after the other, this is the default mode.
 
--p:: 
---parallel::
-	Run tests in parallel, speeds up the whole process but is not safe with
-	the current infrastructure, where some tests that compete for some resources,
-	for instance, 'perf probe' tests that add/remove probes or clean all probes, etc.
-
 -F::
 --dont-fork::
 	Do not fork child for each test, run all tests within single process, this
-- 
2.47.1.613.gc27f4b7a9f-goog

