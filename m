Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965894;
	b=CXqcQFeKrkdRA19icZRwl1Bv2YqqrBIgZ5zgt8IM5R4iGr4Es6tfIb+b724aVcDbTUPz
	 1q0kbBcsnpjaDzneW1JlMwwid0aNyX4S+dXuGR7FBnqPcACWqpFOl3kVwXTK5tf/NcWLd
	 Zy45ZuY76P5sddWIbdoJqovmxfkov6CBisw3d+ZH2eqJqM9KkhqhBBaX0N8rnAcUjXShE
	 32XRbmn2T3VHdgWR6PBMe16IvzJr+2e57NYBONOqK9v9rFRjz628NmIXmG+ztbSwMMFUv
	 WtPvBdSaPuZ4THApyYWOA0YvUBbqu8lk4szvZibpnBhXEmyBECFU57Ykd7OmzPDL26w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:
	 Content-Type;
	bh=WqJecG14GS07cjQMqiYKTg40m/jsJ/DoHEnrZ2BoimU=;
	b=XmRoxtgAnwmQkOMXG/Z5mNWmPRe4nvpbqXb6ScBeRqKfPgFVH7wO+M/tAQ9ipJ1jH+W9
	 zLpSlAdzlc7ZdP9iHj7ioSzecyLbui8xsugOJss3HujmKTWAqU1ha0Aao4JSqcEI84FiC
	 UaVfWLQ9X69BF3l+e7UXrHv5TpnZ6/tTquVKHzQS+rQtuIaYsc8fChIRUZPoOzXDLEOBi
	 yOXPo1liDcDHwMSyjGXyVbECtAfGXXiOElT3LRuZOfjEx0r2o67uezasb4xSI2b7qfPIK
	 QDy3cAUufMvCbwFSMXJ/D/0VWqFbzog0yZeuOVbJ84yXrmc7YcWgv3uS8qscZcoALcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AtGADeB0;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C82606A32D
	for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 22:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1C82606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AtGADeB0
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-359b81ad4e8so3596241eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 15:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792965893; x=1793570693; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WqJecG14GS07cjQMqiYKTg40m/jsJ/DoHEnrZ2BoimU=;
        b=AtGADeB08dC8Z0twUtwipae0nFTvl5qJrtGaxHO7MPr+8QgJz4FVSyHGXDeaFjzvS4
         q2KtXxobDXdlxIKrnqlPe0+Q8R7XZhe5bfjSbnV1hUHDk0wrX9d6QiIeASjxW+hg1a6b
         8M1wzoW84dpR6q5zeK5f81kZ2VasAUbaTGsc9XgOoZP7m8NmV8IawSfkGMGASR2tAO4h
         nXZwIxUPrtQV3NyGHZbdMPE41yOkVjJYxvoWekbpDVewGnOMM8FPQDdKiZ6XEYWpPa7C
         BgFOlxEWo6uRFsN5lm1pvhkt2gfaOfugnVxgijY824o5ZolnYGvhv8MzIv1tCa+5BM3F
         xmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792965893; x=1793570693;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WqJecG14GS07cjQMqiYKTg40m/jsJ/DoHEnrZ2BoimU=;
        b=bdf/+wIMSgGpGNiCmvqbpyoZShVsLYL46fJU9j6D1NhiEFJVu7ODGE4K40w8m1dSo9
         SBIo72jc1L4DpQZUO8UaBXck0AvJlAq1G0T+uc7m9luucVhg0zN+XlM+84JXnkVgSOSj
         CdNRtAxVCwA7wBIp1jvEf3JyCF2VW3QjKKMmzvh0JvmRhp51HkrUywplsaBZhzF7OSfv
         rrVPAyKiPvLJCOEi+rti9ZIYvUFyUP425hbmi9ty8mII7Uw2Qf9mWSVL8/LSU86MG9rn
         oDUOCk69KFBbY7x1dKsQmV9QWDyBDYmY6cqMZj4sgD4iQ7B8nLzOr6OD7x151NG7rFtE
         veag==
X-Forwarded-Encrypted: i=1; AKwUvBxWCXLB/lnMrYJYEcIWtx1W0GnBl9o3PkgwPCdQ0wFBpJDkZWM/S/LZuBTAQx9xoWvFIz3XY6jKcAE+1ccsTTLQ@vger.kernel.org
X-Gm-Message-State: AFq9FYLLtgB5HmkL5qFvMS9A6vGiLci8Ga4PkudaAtWyqKMNdDVRwhcm
	7tIIta1XQNYcffGp/ZyAS0vp6StKElkDyJd+CAVV0LpgnWJYRhTdmFxBnT8yRGLxAp4aexuoSxg
	DeLHUANfj5w==
X-Received: from dyba8.prod.google.com ([2002:a05:693c:63c8:b0:369:f2bd:5ab6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3f17:b0:369:d7b0:99f0
 with SMTP id 5a478bee46e88-369e84a1c0amr9295533eec.21.1792965892350; Sun, 25
 Oct 2026 15:04:52 -0700 (PDT)
Date: Sun, 25 Oct 2026 15:03:47 -0700
In-Reply-To: <20261025220349.1244499-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261025220349.1244499-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261025220349.1244499-5-irogers@google.com>
Subject: [PATCH v1 5/7] perf inject: Use perf_tool__init() for --vm-time-correlation
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When cmd_inject() was converted to use perf_tool__init() in commit
a37c0436f379 ("perf inject: Use perf_tool__init()"), the
--vm-time-correlation branch in __cmd_inject() still called
memset(&inject->tool, 0, sizeof(inject->tool)) to clear the default
repipe callbacks. Zeroing out the struct overwrites all default stub
handlers set by perf_tool__init() with NULL, causing a NULL function
pointer dereference if any other event type is encountered.

Use perf_tool__init(&inject->tool, /*ordered_events=*/true) instead of
memset() so that un-overridden callbacks retain their default stub
handlers.

Fixes: a37c0436f379 ("perf inject: Use perf_tool__init()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index ce7562fc788c..c30f5aaabf4c 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2464,12 +2464,11 @@ static int __cmd_inject(struct perf_inject *inject)
 		}
 	} else if (inject->itrace_synth_opts.vm_time_correlation) {
 		session->itrace_synth_opts = &inject->itrace_synth_opts;
-		memset(&inject->tool, 0, sizeof(inject->tool));
+		perf_tool__init(&inject->tool, /*ordered_events=*/true);
 		inject->tool.id_index	    = perf_event__process_id_index;
 		inject->tool.auxtrace_info  = perf_event__process_auxtrace_info;
 		inject->tool.auxtrace	    = perf_event__process_auxtrace;
 		inject->tool.auxtrace_error = perf_event__process_auxtrace_error;
-		inject->tool.ordered_events = true;
 		inject->tool.ordering_requires_timestamps = true;
 	} else if (inject->itrace_synth_opts.set) {
 		session->itrace_synth_opts = &inject->itrace_synth_opts;
-- 
2.56.0.307.g5fe7bd680c-goog

