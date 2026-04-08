Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5005387583
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633187; cv=none; b=myBfidUnA8M7jbgMmRLD7bo2doKAfmFsDXA7AAeydrTPy5CThUxL9PiimJ0A7e9t5nXJWojlr6CJQkAvkcd6zmEXXFm1FlRZZPxBTbclvRfD+iaE5UWr/xC53PGrHNg6ftbvT4O36RP20p5B/GUil7rKMnQdE9S/+m2cF22sRKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633187; c=relaxed/simple;
	bh=SYrJANGR3+3OE2V0oHZ0BNrkaTsib9ddsYIXs4rLT8E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bx67F7CgH7bAQD8OublcWwl5XBXGAgh4EzyN45GzTRgrEpfxjITWOqWUNOrAO8ln5Y6TUTRTMyxIzokP3zcvr0X6paGIaC9kFxq3BSWwIFhAbuEnh+N8j6WZW/QkUChu92e788vHhtMiugB+fXGTfutxs7IScEtsdfrgQoiDsj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xk41qPl3; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xk41qPl3"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1270dcd11c1so9980377c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 00:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775633185; x=1776237985; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n1+MYX0+5YGMm7TjdJ/WWiuEu/OsAkIHeLC0vTnO8zk=;
        b=Xk41qPl36KZvAQNQqnrzJL4Pj4dP3AqbovsKV/5t+bk2F5I8ym414+ep+jGaKqAs6Y
         YOAyFw0MQD2KBJEPBkCGsw6Gb1YxemXK6ivWqsTpPLKwRfhypyf2NcN3hNzIfEamtDzr
         7hK3UwCZrtldNxIqiBUvjPTf11UFQ3JxpnR12g7kxwjMe/PByuMsvaBFl9MU/Lz/9rZd
         qZ5BMQxkNUmcw/+B3EB+Tie92XQYxmLDpkU1M7JEPBHYu+OLjvko/72Cb5RGwGl1ndY/
         GRqFqfHeJzgXCwMhpG15CITLA4N+XgH6TGcl0Y2ipm77oqZJZedshgu2GXS0dbIGxOnE
         B3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775633185; x=1776237985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1+MYX0+5YGMm7TjdJ/WWiuEu/OsAkIHeLC0vTnO8zk=;
        b=g1SvRiOTSTV2XkPbyTTzDotjeXl4A0YXCblIaNsjcuFIQIjfMeZ3Lpm8JTYQSZNkmG
         S7PFUXIFT35NL/dv8fs5vEDP8hIO+HIqafCFLNnmik1ApZELeuyHqVgPOMRGd0PF564j
         pyPxrJg0U3CF2HlVWxbx3SS8wBm1jnFl8DkBxiis7gpvJ3EcxpX55gdh4lfUH/lZWoGL
         bqW7cr3nBEudEqh4/JYT66Z7fC8h4/vWPD0cZyS/bMosq12h3FG+/aRv57RNouRyH472
         9bbkfoSCDJeohO/3CtfyAJCF0AWSeDVD5fuQhysBQd0aj8uRgkuK62GNviqNDsjtnjOB
         L9hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcZV1f4ueR9GAKjeuil9EjHeYU+huDovJxDV8FXZsoXIX6mGaMSFO3mhaq5c11gCsGyrpD4pIRvYezcNUTgmai@vger.kernel.org
X-Gm-Message-State: AOJu0YzIGbz05COSB7D4FovVxUj7UeogTh8PuA9kuMYalF6QDvUmGc7X
	srutv0oFgZnOCNM93Ly9nxbZ0PdsuXPU/B5d6b/ROyg0mHGVRQlfLZz7sNux+zLJvxCKFZayFlQ
	XB28vDoKeBA==
X-Received: from dlbvv26.prod.google.com ([2002:a05:7022:5f1a:b0:12c:1fa5:ab7c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec17:b0:12b:ebb8:e518
 with SMTP id a92af1059eb24-12bfb779d53mr9253182c88.35.1775633184683; Wed, 08
 Apr 2026 00:26:24 -0700 (PDT)
Date: Wed,  8 Apr 2026 00:25:46 -0700
In-Reply-To: <20260408072601.210837-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adPyeCq3rQrTurju@google.com> <20260408072601.210837-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408072601.210837-9-irogers@google.com>
Subject: [PATCH v7 08/23] perf lock: Constify trace_lock_handler variables
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, 
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

