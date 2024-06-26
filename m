Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461F019413F
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 20:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719434214; cv=none; b=fnLeXBnrjZXJweAuvsmcSZuPcRehSgAVVWwp6zfyb/lLYekxrAZtOZ20bQ5yNFb5YALIYPJ+HicT+H5m4koX7tVQQNz1nXY1ugwu5dZ4+gzR8oF5U1SD8aDTf1PQ132ilRXb89nua0UJh5E77N23n7UXiVTMqjAWhUyWGXzZsW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719434214; c=relaxed/simple;
	bh=tz6IrydlIAL03yTzezHDaA3gvT5YEyeJ8FoCdimUD7E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=C66+B7JungZyLv0F0wYfuCTBikVAfxR+32rG3CMiE1WUQPCjDsL8fY0dxdt+eNPT8hxjN6d7vvT3K9zxOcS6abfmOAIIBwXsND3HsE6aM9zk+3RsXnMrtJ3E8k2tF0H4IbTkxpEF2cfzVj0AMyK4kesOGOzosHOOC9men/96c7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEYXZzYh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEYXZzYh"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dff189c7e65so14702672276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jun 2024 13:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719434212; x=1720039012; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xUgjNt0xneeMqPZ/Mwlp/Zt17wNAbGBqOmTw4fJjROQ=;
        b=uEYXZzYhIJqWThqjDNjKRSpZ0YCkfJv9TFN3CXDVWHRBc1zLFcTJ9eQTtVVyrdOyhu
         gvJwLWUox09sW3kshN7GZTu3z6Av7+ozg/HzXudw4Z9dmP/eBwQ57pszLRG/VdRdzE2V
         XPv8SASHY863xmgVq107B+O/Osp93ktYIhjPY0XYwByw7X5HSuUhY9rEwbyvN9zXtO+Z
         O2B9lURYSJTQKFayAxB3yPtDZyHeqWuqJUzg10eSQerUWfLVvfDC0UnHP7o+LCcuGTeV
         iUh3SAQ3rLzQwKUyGwhOj40TQjm73zQ5BtC1W9oNnX698iR8FnhNH35K90mpIfOlYvNr
         gEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719434212; x=1720039012;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUgjNt0xneeMqPZ/Mwlp/Zt17wNAbGBqOmTw4fJjROQ=;
        b=ut6FVaZHHloD3kDVJ6cATSt/VWS/vJ8wjxkY3BJWtG6O1+r07O61vC+nn/xc5TqwXu
         f+oGg5VwjpLgfFZr3iDlyQgb31Kw+EDIri/EnEq1KVojH343hHIgHyIj8PHv2cGEf+T/
         mdKhZftixyEK8hPRP+SleH1+diJuEkPsNDcE1WcE9jHB68c/4iRtl7Sq2QrMwbtON+4l
         H+7Z6YOeNfMGS5QMoi9Bk5mejhGH/+0gmmvh4/vJTBN1gqAXTeiTlli8nI6gF37ROfF/
         UUFcyTNd5OBTB3SYkuqMtBDH8WRdB4QsWbX0dz7s4MXE6qmwJWMMAwHQQ819GRxRxO4a
         K1gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJZ8dEnk2VB+Kl3uKc9u4ivMvh8YNgfjX3QhBYO0ct/xBo9t0cxOScxOEmk1caPv0P+WZIhhXSlweiuM4vCL8C5j8kfjyU8OP3NtQbcOjigg==
X-Gm-Message-State: AOJu0YyG8S9EFI+d1BBgqTrvtzrsFzsaJpkwuewcLMR/XkVy+pVvdXRu
	IgVBAKxT/438V8aBsofmUkOmtw5XIqATXRFhAZP4yoMB961mlcLuz8GnRYzcjjtaG4Si1MRaDyl
	IrpEVDQ==
X-Google-Smtp-Source: AGHT+IFkDSWMucqUyPP/weWWjzyS2QYWG8qQwQFISbqoPdxZMm5/69UxoFZkkGsqMZ6C+gcONv53ELx2EAOp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:23a1:25b9:2412:56de])
 (user=irogers job=sendgmr) by 2002:a05:6902:1241:b0:dff:3ec0:71c1 with SMTP
 id 3f1490d57ef6-e0303fbf483mr458676276.8.1719434212285; Wed, 26 Jun 2024
 13:36:52 -0700 (PDT)
Date: Wed, 26 Jun 2024 13:36:08 -0700
In-Reply-To: <20240626203630.1194748-1-irogers@google.com>
Message-Id: <20240626203630.1194748-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626203630.1194748-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v2 06/27] perf kmem: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Reduce the scope of the tool from global/static to just that of the
cmd_kmem function where the session is scoped. Use the perf_tool__init
to initialize default values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 859ff018eace..b3cbac40b8c7 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -986,15 +986,6 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	return err;
 }
 
-static struct perf_tool perf_kmem = {
-	.sample		 = process_sample_event,
-	.comm		 = perf_event__process_comm,
-	.mmap		 = perf_event__process_mmap,
-	.mmap2		 = perf_event__process_mmap2,
-	.namespaces	 = perf_event__process_namespaces,
-	.ordered_events	 = true,
-};
-
 static double fragmentation(unsigned long n_req, unsigned long n_alloc)
 {
 	if (n_alloc == 0)
@@ -1971,6 +1962,7 @@ int cmd_kmem(int argc, const char **argv)
 		NULL
 	};
 	struct perf_session *session;
+	struct perf_tool perf_kmem;
 	static const char errmsg[] = "No %s allocation events found.  Have you run 'perf kmem record --%s'?\n";
 	int ret = perf_config(kmem_config, NULL);
 
@@ -1998,6 +1990,13 @@ int cmd_kmem(int argc, const char **argv)
 
 	data.path = input_name;
 
+	perf_tool__init(&perf_kmem, /*ordered_events=*/true);
+	perf_kmem.sample	= process_sample_event;
+	perf_kmem.comm		= perf_event__process_comm;
+	perf_kmem.mmap		= perf_event__process_mmap;
+	perf_kmem.mmap2		= perf_event__process_mmap2;
+	perf_kmem.namespaces	= perf_event__process_namespaces;
+
 	kmem_session = session = perf_session__new(&data, &perf_kmem);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.741.gdbec12cfda-goog

