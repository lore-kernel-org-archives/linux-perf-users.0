Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0363C944E
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775248850; cv=none; b=dsueGxAyreqHQUGyk8iGmaoXcD0JQM5PQuMvqDBdGTe5AfntOJt2bqjwsZYxc/8SIlaREIxzxxiZmazpRNP47gR97b3j6gYzvPmjBRi9j9rxSB9e38GmC7EqzUGvxMCWbV9f7y+ZmuP+KYLKJ54YOJ5omWbtQtUXFuPJ42eQ+fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775248850; c=relaxed/simple;
	bh=SYrJANGR3+3OE2V0oHZ0BNrkaTsib9ddsYIXs4rLT8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ehPnjziOw8ztWzBoZ1208efB4xq1b0WnADFM+VahjgaBo/ixYmb+oJY69S11rOfUPLnGrtnd98YbexIeQGRzHN6DQa+KfiRTTFtMfcgsKP8/SMopfsbWSJtbdo2Xa/UIoB2xQ2sl+jFG9f6tPJjYdkFsZdRX0j6+5gyyVX+O3VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nw65JKWQ; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nw65JKWQ"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1276e71652fso4452830c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Apr 2026 13:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775248848; x=1775853648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n1+MYX0+5YGMm7TjdJ/WWiuEu/OsAkIHeLC0vTnO8zk=;
        b=Nw65JKWQwISRA8B/kN+sWy4oiWvZ5HLqfm1u2fou2xlodgjv4/FJZU4kh6hGB81rPh
         aHr7Mu7IwD4QSMmJkvSnu1LpJf4uDQ5jTLHvjAIoXujmtPc0dIk41lK412q+oQcg/5v3
         AIOVWEHA6gzvaikwnVdpjjnUrE7xjtZ0po+zw7v9E44+XSiXlFS1eMDDZDAHtvUuEUKF
         LiaaZuElog3HNmP4+hyc/PLs4J7oFfK3n5MzXHKKJ2gf8hB82RVYz0NCihtjaqvST9TZ
         8z9MYVmt77CA4ThCiXVM62awt+EzFCp7iEqs9EP8a81HGt6cy9bF+3cSc5gE3hxLgzqR
         7Oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775248848; x=1775853648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1+MYX0+5YGMm7TjdJ/WWiuEu/OsAkIHeLC0vTnO8zk=;
        b=atkiVuM1pzyoCKl2k8HDHF3yazOo0ki2bMPvX/vpkgKWWmCnxjJ3r+SdgJyFT70z4L
         afsaRI0aTGaqawrxp+pdbLSvWyw5ARn+BCURL/R25BoUPSGgJg2xqj7SPlmigZbnGQML
         mhpn6mW9Mqb+IVkMuXPmCnLIXa4dVo5PPKnaDJLGNtyBB8S97L+RgDZ99PporEgRa53M
         KaePRVEFlC0EDN7GJG5TRpt3/VUHmtqXgEOriw/rG/wceV01z51g6gP5GqEz2wEowMH3
         D4rZg++EWTWrUq2XhId69cPbJxH4jmuhJxL86DaUymvMevleRaXOrb/UYdRuUgVU+DDB
         cr0g==
X-Forwarded-Encrypted: i=1; AJvYcCUGzEGgksrPnyKE9ETyv23TzW6FC5e+hUYQTq3YDb9upzFz5OsskOhZuEEJzqHdIk4OrYqZOszv09nQL7eici5T@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf2Ei4v/qA4DQ73MozS6uqi2+fuMWTPkpfPFTR6kLiFYN3GG90
	eMIeLkyhusGZCgccRfeQ9rEDH8bsk/3L4zWtp29dh+8Bzd149LF01O2jkru4kgvl6wd+6T5t/W9
	toNT4FEoayA==
X-Received: from dlbvv18.prod.google.com ([2002:a05:7022:5f12:b0:12a:7349:f4f6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:41a3:b0:12a:6ab7:3f71
 with SMTP id a92af1059eb24-12bfb6ed48emr1799492c88.7.1775248847610; Fri, 03
 Apr 2026 13:40:47 -0700 (PDT)
Date: Fri,  3 Apr 2026 13:40:02 -0700
In-Reply-To: <20260403204017.2919994-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fXDd2_uqRHGOrbbjsAjbunsW67P-kONsmhm6UZWQUc-2w@mail.gmail.com>
 <20260403204017.2919994-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403204017.2919994-11-irogers@google.com>
Subject: [PATCH v5 10/25] perf lock: Constify trace_lock_handler variables
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

Structs don't change and so constify.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-lock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 8ccb64415d3b..7b23d22d8f48 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -1182,7 +1182,7 @@ static int report_lock_contention_end_event(struct perf_sample *sample)
 
 /* lock oriented handlers */
 /* TODO: handlers for CPU oriented, thread oriented */
-static struct trace_lock_handler report_lock_ops  = {
+static const struct trace_lock_handler report_lock_ops  = {
 	.acquire_event		= report_lock_acquire_event,
 	.acquired_event		= report_lock_acquired_event,
 	.contended_event	= report_lock_contended_event,
@@ -1191,13 +1191,13 @@ static struct trace_lock_handler report_lock_ops  = {
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

