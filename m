Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B5C2C0F8C
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Apr 2026 02:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775959739; cv=none; b=KvGNot64MXxXB6KRiQxWpJCs5RIoOFC1SziRODj/uRJ4kLRUbNnsCTYOc8wGPDuB0mofgPqpAHS9197g7bPyFi8nQmui1xhsY6x7ENVIuqkmayPtMXY5/FRAUGYxJk4Rt6S5slPmFR9V4thD3U8HGDymnqtN2PI7c5P+riYx1is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775959739; c=relaxed/simple;
	bh=AI4hgNPYM961Rsmo/MATnC5LgMcHCNhSpOwIyaEyTW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ChAVwqBCgGFDS7/GChnBGrbZBzeuP+hEkqME9p87pX3McN5Lx08MwC9VkE5zDu+yOYhgOYAZ2wM1JtSr1KGQVpwVn5bXwkYYu0BgLHJyPCsmt6Tet+pqHzzvznlrxaqz3GZqqKMBIabvqGrMm8pkWCuAx4wD81PVOuEJFZWb5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vw0rsSmG; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vw0rsSmG"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c35f2c09dso2693546c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2026 19:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775959737; x=1776564537; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r2YgOBKc5+NauJSjA/2HOheGJtIx4BD2mO0j7ZktIOo=;
        b=vw0rsSmGDmPXQ2VCBOxY/1VimBuNjx4kK+oW51dvsvWuigybbXtG/tfDgycQK7teMn
         tlqxHQmyhBECMlkmaaJDeIe6IPHMlC2Pzo2xtO2gj1OXYBbRmssQdsdfIXrFF+kFnpLH
         eceJFOs88xpoKmgsaI+vWTEkNYQr8tnjnYKEs0z1zJqG67W68S09JAph7jBfalpn7Yan
         +Ew+imno1TC4OmYsZrtWFMU8VDsLU1av0gcoBnd6wfBfyXvHhaleM0zdOcm+o/Zct7G3
         m90oWXRv9AgJ6ZOL2JeuZsSxBCeusziHWQq+Ac09Ko6CfNRXfACk9EcwibvCkddDy6Ka
         Baaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775959737; x=1776564537;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2YgOBKc5+NauJSjA/2HOheGJtIx4BD2mO0j7ZktIOo=;
        b=TXxQmq+zVcSknifVgFTnqMyTl7EhG7QnT5qQOuhpDBU26ceu65ZsX6pwM+Y0pBGX3J
         yYIfmEIOZySPR2VErNnegol21ldnKQ2U3jfAL8dvtA9DKpgf9y6qWqyAZ4F1ACGv36nF
         9ofhlpJA//NjrUEyYTkAsbbWvDTMzh9i7AxAmT4JU88QinXbqGI52RjFbFjLM+dB3A7E
         FoSurqYKi1QkcbIpJt8hG58EbxvA+ppAIb8fqnnO1wSUOtBeLE+rLq836ktGfxNM6NB8
         e3XgX0q2YfyyW6Czkj1UN0g3J4thRBsxGP2pLDHBtwQIOWEff1rPsL+HVnFDZqnwhrAS
         qZeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb17bbduZBLL5YY9inApj+AGquhImzzW0yRWc0Fw1Kml3UKPTxPyosO1eyktXVC8g6316sdWCYqd2EujptoWYh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6bzn8oSAIVopQsuojJnhP1kQiAp8M82CeYiDnbKjHMMNSdqA5
	cJ+9HQqKvzold5yaTjc4qIZDSJ7P1QsC5/XCjHAlv0Cfh46BSWvp5lYlkKUOcat+ZvIyA0/5IGX
	U+is8EhImJQ==
X-Received: from dlbpu11.prod.google.com ([2002:a05:7022:e88b:b0:12c:20df:7530])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6982:b0:12a:6a64:81ee
 with SMTP id a92af1059eb24-12c34e6b3f3mr4164605c88.3.1775959737195; Sat, 11
 Apr 2026 19:08:57 -0700 (PDT)
Date: Sat, 11 Apr 2026 19:08:11 -0700
In-Reply-To: <20260412020833.641177-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260412020833.641177-9-irogers@google.com>
Subject: [PATCH v10 08/29] perf lock: Constify trace_lock_handler variables
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

Structs don't change and so constify.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index fcc33089b945..064b3aa4bad7 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1186,7 +1186,7 @@ static int report_lock_contention_end_event(struct perf_sample *sample)
 
 /* lock oriented handlers */
 /* TODO: handlers for CPU oriented, thread oriented */
-static struct trace_lock_handler report_lock_ops  = {
+static const struct trace_lock_handler report_lock_ops  = {
 	.acquire_event		= report_lock_acquire_event,
 	.acquired_event		= report_lock_acquired_event,
 	.contended_event	= report_lock_contended_event,
@@ -1195,13 +1195,13 @@ static struct trace_lock_handler report_lock_ops  = {
 	.contention_end_event	= report_lock_contention_end_event,
 };
 
-static struct trace_lock_handler contention_lock_ops  = {
+static const struct trace_lock_handler contention_lock_ops  = {
 	.contention_begin_event	= report_lock_contention_begin_event,
 	.contention_end_event	= report_lock_contention_end_event,
 };
 
 
-static struct trace_lock_handler *trace_handler;
+static const struct trace_lock_handler *trace_handler;
 
 static int evsel__process_lock_acquire(struct perf_sample *sample)
 {
-- 
2.53.0.1213.gd9a14994de-goog

