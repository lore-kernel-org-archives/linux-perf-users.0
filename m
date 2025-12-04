Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855BE333727
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Dec 2025 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764888628; cv=none; b=MC10iCZrGyyshuj2+/un/O4d7pc9Bn8xfKKp3O4ZwXUj7A4hXCC4wa1PaDm0oEsdmzYlskcjxqTzNt2Bh0+ffcIl+OZ8itSpDCwy3a4g2+hH8B/Rcofn1xQJvtlQufeuPO2B/bT3NLs7r0qnacfuQPXlGGL28yrjHP5poWqfN+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764888628; c=relaxed/simple;
	bh=p2qLeL6ruS/pkqb6aE1taSPsrmNe+crh+IRoGZZnhU0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lQCtn/ejxxbosnP7wU8NO+gJmRfVU35sdv+xwUM+141SrkXiO9Of/ZQjmkWhD8+yhAUPkYPfiOg+la8fzdjp1OMG4s30t7fE8QIqfyEdz6YzpoSYgzcDoTgFic2NS++IGg4qqvT9DOai+up+0T6i1SHx5wmOUdtAo6gZMhrCRsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bk8LK1N+; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bk8LK1N+"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bc0de474d4eso3091460a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Dec 2025 14:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764888622; x=1765493422; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dDwI/M2EFWmojd9V/GQAN6QyfpviaBffARtENrFg12c=;
        b=bk8LK1N+mY0hmBpR+CDbfcGcAopSmnYz+6HuClE3drGyRnLMWysuTkCm88b3Zmg9kw
         swDZGT4IsUE/4P5pdfAlHQC+8b59UwRqymrkY3y7a5WQJFhs6xiYcbIwg+RDaCbFVBzR
         qXLX7uHUCNRSQ5fd11sBLYjeO6Q9z8kA3yPEAzxhcsxNzHfhdzvfDhSq3I9f70TWZoiY
         CIpTGARyR42vRuDWDbqq/D0nQV8uPl2rE4cD6X8Mc+w8b+90+PI2w1er/71gE1PPRLvA
         epRTaivvMuepauSBVfFsYQ+alCTvWknCPA5B7ALAAOO8U0ohEEMJAavf23OqEjBQrPpf
         +OCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764888622; x=1765493422;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDwI/M2EFWmojd9V/GQAN6QyfpviaBffARtENrFg12c=;
        b=Epg2r0w4x5/T0vT6J9DUv8D7yGUmqWQORMUgXL7EQ+wgXj3oiRg1zkMOaU08idcJzN
         D/WghAYQrMvtHWW50A9U+K3uePS6aV4QWIGB37EVb6eUfIVBtrPdzQyKi26DybZLmDNK
         2AZJrjR/tAKoQzpYCexqP1/BEVf3e8Kmt74gre0jXqty1limsbv+sYFvDwQ5etE01qXb
         Jz9BYsUqZVvsLlRjHRInZs4BnftmdDswJSzaAPn+bFbolrp/lIi/KKJC3wzXV17YJSIJ
         r9iFRjlmd0BvIWGIIeGLzTtR5AzlVxyLpehcB8DYT79vA30W8eeURCeSwqMdp13NMgxl
         r5ig==
X-Forwarded-Encrypted: i=1; AJvYcCXMqkL54eT2C9DjRcACggqR7HtrUntGMknSPtkymP2f2hXdQtUKAzGGDP9JyMdVJCWzuWXJ3jdVHB+cFzPfMlqk@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh5pvRhlMm7S9aZ0+fQ5LbpPqgHCxMCxarkgBgSL1aIZedMHpr
	jDxwAIyNSpQ3SGmtnAoynTKA94IkxocSX+bpECuh6gytXkIXtHS+JyQ7AyAHMlPYEjYeV/Fw/uK
	IuGD0yMgfDg==
X-Google-Smtp-Source: AGHT+IHt9EN97y1PErPO5IclmGoF4/jKv4qG2omMnV+lk8/HKNL8WPctEV5EcLxGp0k/+ElEa3kb7CVxLRW6
X-Received: from dybmc14.prod.google.com ([2002:a05:7301:198e:b0:2a4:721c:5daf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:f78a:b0:2a4:3592:cf76
 with SMTP id 5a478bee46e88-2aba45007c4mr2961738eec.26.1764888617729; Thu, 04
 Dec 2025 14:50:17 -0800 (PST)
Date: Thu,  4 Dec 2025 14:49:24 -0800
In-Reply-To: <20251204224924.639406-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251204224924.639406-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251204224924.639406-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf tests top: Make the test exclusive
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With sufficient tests running the load causes the top test fails with:
```
123: perf top tests                                                  : FAILED!
--- start ---
test child forked, pid 629856
Basic perf top test
Basic perf top test [Failed: no sample percentage found]
---- end(-1) ----
```
Mark the test exclusive to avoid flakes.

Fixes: 75e961730b9e ("perf tests top: Add basic perf top coverage test")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/top.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/top.sh b/tools/perf/tests/shell/top.sh
index 768ebcf7a89c..ad7fccd09025 100755
--- a/tools/perf/tests/shell/top.sh
+++ b/tools/perf/tests/shell/top.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf top tests
+# perf top tests (exclusive)
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
-- 
2.52.0.223.gf5cc29aaa4-goog

