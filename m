Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019404;
	b=k8h6A7JfAAKCsqsnry4LgIjZD8R53G1PkEsx0gwnHQmJoQgblRuZEo9zB6SECiS3H1zn
	 l/T9IgFEc+BPSuItgR+b2ZVf2mSx+9a6UqNsI67jva63b5yidjk4pgLWaPFFuJtlUwkq2
	 xyy2VOEF1svgoYGe9/D8rtlAxnCsILnp3OVy8WxGzL73S5velQWn1T7U/VdCiP7zp6H1j
	 1jaOjaUbjDFKe1COnn5/7YYXzfVw7Sog+Lj/o0tG1yBY3ZpJuQfLu3OucGranvVABYUpk
	 GbpVgTBbDDEkPpMHg10O7PBT0MY4P7a3jAVsUrIgoOeziBtYVqAyY8mAZUzDKiw9eZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=++mNA/ATFG+JHWKfnq2DLe8hXRW/WLweLbt37GPodEU=;
	b=kl3smIqbXgytfLCOC2iLUZvm2UttcAyHsHl+r6Mn+42yVI3SzCuVJ8qvsoVEekhUH4zo
	 t4xtlmuOtrtqRyR/4oVJ1JDNFhhJWViHgyX9e+nEDjkVMx58+fHARIZ5RjcX11S0iiGGh
	 wlelYrtx6LlUfljf216v61B6nx24ZhP+hdBPFle5zomIMRYsbbAtx+8wSVBZUsDbrueA2
	 q4vXCnQ6sFUu403HDUWnNxi/H4KafrHcDtU2kJE1tdozB2F9oZOHhcqPPNiOXSQRAzMp1
	 JAJWcMs02P7v6egA0EY1T4xLhSZE7TW+nSvL5hhpO0iquYKHkOh3sMqCU5wJfB+mAYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tjZIAzXX;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EA060A381A
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93EA060A381A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=tjZIAzXX
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-492f0a1b685so840558f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019401; x=1795624201; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=++mNA/ATFG+JHWKfnq2DLe8hXRW/WLweLbt37GPodEU=;
        b=tjZIAzXXo7Qc2tcqNCatr32uUr50tnaCysbm4XPzAIEAOhwN5hLin/BEeoWWtp3i4z
         r4uvMZPixtUY2Tx6ooeWULcsBL1mHcEHSMEPN8bX7qgciIgW/U2HPEVtGN3kmCwjdHDB
         CMeLYpKhkaEumysZVLqdJ/fVi01BSoJ1Aelz8T2WdJCA0YJ8jb8JFqhv3wB2oI3N1NGs
         34+nL43nmZIGSz4gGSgKQcqczcX2lR9fHzw2KNEkm/Er4bLmb6pg4kExkvY7qgx5I+7m
         EoIoS4RDhY4DPuUv84BXLW4RfvMDHUG1SM7XnTnJHiGXUB+yYHIL9/JwulGVtTw3/R4G
         B9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019401; x=1795624201;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=++mNA/ATFG+JHWKfnq2DLe8hXRW/WLweLbt37GPodEU=;
        b=EFuf4CGFTIEvoiu4T1JJ+irnP2JL3nS529VYkmpPRx4Z/6rYBkr+AF5tj4PRJDBYRC
         w4DJu29JxAYwSm4AbBwHAsEf7OS1yVMIqhKzzBnT/N2xJnwiLv2EmQGAD3B1sybCcEGj
         ZSsX4vhL+jD3Fav2jGffQV/5DqpbKfHtiH31JYxSQyOZuInXzoubyy+n4k/50fxgbrrc
         qZSYg2FcAiP+9wkybozBiuJ9cQRd9Gzr91AFqHzHJkU/BAa3zdU5A8p2QAeQJ9qCVbHe
         qW87qJZUBHaFkQi/4PgQGOBBC/7cFv5Lt8KCEOjP7w7dtnGh3A5dRcs58mL8OatYrAsT
         LHbQ==
X-Gm-Message-State: APuU4Z+VAUby3IDcKL7H9aa4WfaiS6CXF3h+/OD/y5PwAIthUg4i3PO3
	ZDeDomiasHvnTCFG376qQk0n/MvbRb8BikaXlFyjbXiL/N+xdcW0CV6U6w9Owp0yQLc=
X-Gm-Gg: AZFdTZdWDkKqYzeAodKFRYcRIzWwGVSobxnqpAU3xi2yZlCTIk+b1Qcmqr2W/6zi8gW
	qVenf9rA3fROahtEroeWZLYNhKcRxhgnnDuYqc8f+eFFK1gRV8LGe+FeqITypUxKCCfvk0b9kc3
	Ne/ZnWMUzxkRXaqcO+muMSynXMCqLFTvA2+AQMJcTINBZklkrrVXBpOrXKSzPV7/Pqz+GhmhLai
	34kNGSsS/fparzMf+ludPlfR0WTDlGVzkJ2jRNejxKRV39G/v1dqIi9ecLa9mPmf267jBr3V4u1
	k7Ejjx6dJgJGVPfcHhwvhU6p+FvGUl6aJae2UDrofyIqd/InRhKq2/s4upcSXvYzI6fUeXn02vj
	mvrsnFPWsM/tdJqjEH7S4zzbKe3jObwarsXwNqmLTyF2FDF4/8vbDc35Si4EwMd9f3LSYLOa0ff
	6RSxiTRHwsLKMHdcQfoAqp4NfAvsYGIxRy12fuiFiwhZ2DK7WgQ7V6mUK9X/10XwnptmeS1Z3UK
	XH4J3qh65ZCK04XUn85eutv6YdmnvKZvF6gAlpzeDxp7BFOSx/fhMroefgkFV5z9QvcXoQQlH+1
	Z0DaTIVi9VXOwXEg8qBaKTvU/y3sgiyH
X-Received: by 2002:a5d:5f45:0:b0:4a7:a8f:527a with SMTP id ffacd0b85a97d-4a70a8f55cfmr5263386f8f.7.1795019401089;
        Wed, 18 Nov 2026 08:30:01 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:30:00 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:34 +0000
Subject: [PATCH 12/34] perf cs-etm: Track sched out events
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-james-coresight-jit-v1-12-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
In-Reply-To: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Amir Ayupov <aaupov@fb.com>, 
 Suyash Mahar <smahar@meta.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

The sched in event might be dropped due to a full ringbuffer, so the
sched out event is still useful information if that thread is going to
be seen again. Call machine__findnew_thread() unconditionally as it's
harmless to do it twice for the same thread.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/cs-etm.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 67e3e2becd0f..1e1ff6cc8a5e 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -3018,16 +3018,6 @@ static int cs_etm__process_itrace_start(struct cs_etm_auxtrace *etm,
 static int cs_etm__process_switch_cpu_wide(struct cs_etm_auxtrace *etm,
 					   union perf_event *event)
 {
-	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
-
-	/*
-	 * SWITCH_IN events carry the next process to be switched out while
-	 * SWITCH_OUT events carry the process to be switched in.  As such
-	 * we don't care about IN events.
-	 */
-	if (!out)
-		return 0;
-
 	return cs_etm__associate_tid(etm, event->context_switch.next_prev_pid,
 				     event->context_switch.next_prev_tid);
 }

-- 
2.43.0

