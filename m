Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB57277C9E
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776043413; cv=none; b=lqgJx2q02Ecfhr97LWJcPT/eWESRkqRZnF+oMjPwXvB+R8EUjrVT1s3IZ8ZNNEXlVrxWwFCSMr7oLypWyzkwh+EqvPSyT6KBQc2sSNyOzFqS98aejduNqvsCks8oW+AJ/TTY/yL0lCd1sIsoPCxYoq31doRr+CLl/pynA2rqp9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776043413; c=relaxed/simple;
	bh=bwZsKPXpFj0EagILS74wobtw3QdQZQfP3x9LOTF4xSw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V8HXSX4PDmo4S0wQBp6mWOR+LfMkfj0G+FJuli14zrp8SP4mhoeeDNhHUwsgCpmMnrmVkPxnZ5EUKtDnYhwvjAv1rgFoMSsz7VrzARUrDsB1VVek1lpPZU/QJDbi/3HZD0lZnLXEJeAsoVWsgvn3/ZEJf42PuFiR6AO0SarHRuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ixku8520; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ixku8520"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2d8a677cdfaso677201eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 18:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776043411; x=1776648211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KJsfPYVO08tCC/QkaQf/uBEFF+74z2Xz18vy6UCdEwM=;
        b=Ixku8520Mm1SuL6kJdrjYDdegySkdKrXLwg6kew+mc0UNHBH3DQPDtCGYZsrhxvpQG
         Y/OsgLtKRJrNrtzfdpXbDTiBZZ5675v0fvXeBEs+137vJAKrPsX4HzOZhMtZe1KsaAcA
         iCeMmyDnjE6JDMTMscSg+n8JFH7/JnEQNhXmGhP3qioPXdArL7zCv0vS5/W0yosZX4NA
         3PfkMt4QXOy0wPXYYxzRHO4vK080E9K3I9waEsDJgYY0PXKoGkJPVkB9KXGwRkOlIQEK
         EVJEbtjomgSk277hZsEm9IbCsvgyukTMlXl2T7G3BmQokF3VH9FCC7JBc1DfK5hEql2u
         RlFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776043411; x=1776648211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJsfPYVO08tCC/QkaQf/uBEFF+74z2Xz18vy6UCdEwM=;
        b=fhn6EJyf+HY5+NSaiwsCrzV0zu9czxbBRYDEPz7ShLi5VZN53I0f1GAmOVKkkL7OTH
         MHCchxanUppnObt3SKHqSxw5o9flxaq6yVZ5EoxEfG+mrHK63X5y0l1qnerq7tDRmzsn
         FPV5s/+CGa9m/Rtd79xKBYN8laAxILiVJu7uErLLMP0Hmv9PuceCF6x3SV4bbRpQzof6
         AJGCwlJ/ZezK3yVLxJSnLC2dwp3vwQXFqOAnTe0hmiB9ajnb864oCn0kkmcB0Dla6VZp
         t0QG26VgsRPUXmcmFEqGL97Ob6VQ3aaXGum5pVBznV5HZ1uVV19/5Nb4ipqLz6SwR2cB
         o3/g==
X-Forwarded-Encrypted: i=1; AFNElJ+yInJMuPbmnWIcsoVNZl2sZwGp6oGy/KrRt5wwypf2aQtcrjed//beJEmjiiuHh5nNG4QPXR5L8MWRUrCkQAU1@vger.kernel.org
X-Gm-Message-State: AOJu0YxVPMdgbZQKxnoQS4Y8slmJiR9JbVAAYzlM29VGJPjsIpA3LElp
	tRBtKzNqTV27SXNJAVpdbPAa59whJj4OB5L25ruoC/78fqWsYFUDB6s/00anqzufd3k7LkMzWW1
	NgeUIfbGL8A==
X-Received: from dykp36.prod.google.com ([2002:a05:7300:ca4:b0:2d1:54d:3d96])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:2c84:b0:2c5:d833:a4f3
 with SMTP id 5a478bee46e88-2d58907b4admr6496179eec.18.1776043410741; Sun, 12
 Apr 2026 18:23:30 -0700 (PDT)
Date: Sun, 12 Apr 2026 18:22:21 -0700
In-Reply-To: <20260413012227.1089445-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260412020833.641177-1-irogers@google.com> <20260413012227.1089445-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260413012227.1089445-28-irogers@google.com>
Subject: [PATCH v11 27/33] perf synthetic-events: Bound check when
 synthesizing mmap2 and build_id events
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
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

Prompted by Sashiko code review, add bound checks when synthesize
mmap2 and build_id events to make sure the filename doesn't overflow
the event and lead to stack corruption.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/synthetic-events.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index de812a2befbc..a7fef7ac3da6 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2257,14 +2257,20 @@ int perf_event__synthesize_build_id(const struct perf_tool *tool,
 				    const char *filename)
 {
 	union perf_event ev;
-	size_t len;
+	size_t len, filename_len = strlen(filename);
 	u64 sample_type = sample->evsel ? sample->evsel->core.attr.sample_type : 0;
 	void *array = &ev;
 	int ret;
 
-	len = sizeof(ev.build_id) + strlen(filename) + 1;
+	if (filename_len >= sizeof(ev.mmap2.filename))
+		return -EINVAL;
+
+	len = sizeof(ev.build_id) + filename_len + 1;
 	len = PERF_ALIGN(len, sizeof(u64));
 
+	if (len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
+		return -E2BIG;
+
 	memset(&ev, 0, len);
 
 	ev.build_id.size = bid->size;
@@ -2303,14 +2309,21 @@ int perf_event__synthesize_mmap2_build_id(const struct perf_tool *tool,
 					  const char *filename)
 {
 	union perf_event ev;
+	size_t filename_len = strlen(filename);
 	size_t ev_len;
 	u64 sample_type = sample->evsel ? sample->evsel->core.attr.sample_type : 0;
 	void *array;
 	int ret;
 
-	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + strlen(filename) + 1;
+	if (filename_len >= sizeof(ev.mmap2.filename))
+		return -EINVAL;
+
+	ev_len = sizeof(ev.mmap2) - sizeof(ev.mmap2.filename) + filename_len + 1;
 	ev_len = PERF_ALIGN(ev_len, sizeof(u64));
 
+	if (ev_len + MAX_ID_HDR_ENTRIES * sizeof(__u64) > sizeof(ev))
+		return -E2BIG;
+
 	memset(&ev, 0, ev_len);
 
 	ev.mmap2.header.type = PERF_RECORD_MMAP2;
-- 
2.53.0.1213.gd9a14994de-goog

