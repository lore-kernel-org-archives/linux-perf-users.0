Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619557;
	b=JzFP5K7ANw4fYW9ounzUcAA6tQ07PI3s5df+qrLDVwTl+Kb/OvFJRSKUmLL6ADDhghlU
	 7LBikqWXErhHTcLoB0UaYe6LajgMuEdXLRbUr0mC+TZNR8vsroFn4EzLtMI/wTLQ8QruR
	 JEgJm1dJ6389ch74AoKlrck8NWNoIJMxN5MZiRrp6oDFpdGRHBWn2BWBu1afzsCfYby2x
	 5YQP8vy07wlXMs3Ywu5bMx9fBIvF1Am4V8v2158JdE5Fso9fGsBNRFMhYrZykZmpQxgZ4
	 XGPolBnU8q90dY4g3lh+hhfaN9FF1LSK8F1+HjN4Go5W/ABBQHF+2+UwaqYth97fnPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619557;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=olkz0RE9qbyCNQWe7ovtGZ4zTZHV3lQiK2ePxCl1z6E=;
	b=rXzeJ30tQqIuvAxl6OkXBfKt/bzZYc0bcdglA7vIrpUGy7fztbd5iTZkuYcFUgTJBJQQ
	 zCU0ooIonIlI90LKy61R0YMQ4jUKjstLxyIqIyqpquCSXjoMXfrBaQ7MsstF6swPKHL/K
	 gC9Cjh5Cbto9SY2WF0EpPTHeN58KwPr3YBvdOiOchJbO8OzYQF8LetiPNae0GMQFFZJ92
	 mLIPLTmdJJStKuxv7ClFHX1zsu1Ds8xA8Y8pYiXWknbRhs1SQ8kBqTsjWs2P/gUTi2WbU
	 /UIotFoR40+JsXOW8bZLtjpCEcVRqbNAwwKzAbbLOAfhad5x2Se/Wa+AQXyKu7Je0/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nyVZ4GGk;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A402606A31E
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 15:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A402606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nyVZ4GGk
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so50934155e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 07:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795619555; x=1796224355; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=olkz0RE9qbyCNQWe7ovtGZ4zTZHV3lQiK2ePxCl1z6E=;
        b=nyVZ4GGku6PzbdxZyOx9rpBMV4gyQsFbpSUr6U0IEIK0OFQlOQkiFTsuUe3gg2mfqG
         aSo0SCCDxznd2e+hIun4zENnSn3+F9FbLQ0F4wbj8qQpilrdTcmqz72CsZf6P1443nWa
         wk7i3WVL7ra37eK4Ixc82enwLzb5OQ5F0KrK6Ec/s8gr2P6lYJJGZO7jkDwI9adOfLv7
         BydG6omRm0qTRIpcpz3FlwF/YsUky7cTfR3kTkyJMYTdpZ5UmBuF/wW0mYzfHKaMCPSr
         nDbHmRyl0YLL6qgnDs3izi0uEShscrzJva7VX6BeKecjHLuhTojvq+wATcShgPWuBy4q
         AEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795619555; x=1796224355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=olkz0RE9qbyCNQWe7ovtGZ4zTZHV3lQiK2ePxCl1z6E=;
        b=W/6QCkpdXKo/nA1AuD261BP2+UNz5lfyV5eAcw/hoOZE3TGCwCnBaMh8eMyOiOe9p+
         xa4jwvHgKA3FXTYNExn35jTfU98CuxX/rW6NidODvwNu93enL4ZByDb8IC6I1z6xaAQS
         mX7zgAyRAxiAN1w/UUcBHvsaK8rNQcRbB1w1QQ7oNX1I2kP7j/OBk37E02CgyBDNCpsn
         65H95TlOEOPXrc8x36atDlu01ZW0cnblPGLK47F7wq5tN4byb2MLHiW+z8sinC+4vS4i
         H4x0mc9Pfzxsgc6uI0kBbSd8pGwmR17oAqOJ2/kxxqsFd6KqEj3/T0udz6Rh2Bm0D61N
         eE/A==
X-Forwarded-Encrypted: i=1; AL+hErHufKOR404Dg6GLZT/V+CzrOKD16g1NGdxcaI36lmitqTFuQQWx3Mj2dxb8x45bzcfsUNEFnSDAxVKW5bwXQRxu@vger.kernel.org
X-Gm-Message-State: APuU4Z8P/QgHbi8TEcIphZ1QHDNfNWiN+FzVzJTgVIfj6pnKja2xyH+I
	RoCnWJuNxOjU/JYJJ9JReiQXP6siorlZZs76ceYgR6a+kd2bX6WIViOhfD8YFGdSQss=
X-Gm-Gg: AZFdTZeevgH2CyypTQKR0Si2RkD0W9tUMj+BOFjm8qRh170hmNcess/tyULTfGf/Xt8
	+GCyE9p1luZ0k/ZQZvQzD+0mVDE1ZUzEdvykRo1sf+MZgQiH/qP3jrzhPIL7Izbxc7p+77tVwYq
	zhChVb66GXzIX4oHoVHcb7hxcIDa1MNE4Tt4kv4ebtRxHxf5CC5Ae+N0ENzGYn+Ev8MH1DICpgD
	m7rKMHBk7fbMww5fwW8zYqvR+4mfyHYMGoo1EPglp/s+XwFaUuIDY+nceqXB2yV3Aatd2+tKLUk
	QwG4rSLM0J/uiPsSNY5FholMkiGbggk0V349xBdfcCRMITSWPNIQSzgSxKoTyxfGQDqfZwS0Eui
	lLUrNbw0dfmgZlJ3XKO+5IdQEb+St+TdGEFQnVLmp4+lhVyXRYPnPwCgL544nPU8NSt+lablwzT
	DpCBn/p6/e8COBvafgJ/qCGxhKo35wk7KSqJ/8g1jFf28RwXc8yTM1Xs23dHdzW1fsUrxlilJI5
	DkogP221ddt+sT2RuKxAjDibEveqCNJlzDFAFRq12LUn51kNZ4gTArLK1jUuvDPrAvnTjZBIP4y
	S6At57dbzrtdZiZ+EeIfKz24flei7v6S
X-Received: by 2002:a05:600c:1d86:b0:4a1:fa27:df7c with SMTP id 5b1f17b1804b1-4bb88922972mr383717985e9.34.1795619554605;
        Wed, 25 Nov 2026 07:12:34 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm39845282f8f.24.2026.11.25.07.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:12:34 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 25 Nov 2026 15:12:15 +0000
Subject: [PATCH 2/2] perf kvm: Don't create an empty perf.data in live mode
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
Message-Id: <20261125-james-perf-kvm-live-file-v1-2-946f478ce2a1@linaro.org>
References: <20261125-james-perf-kvm-live-file-v1-0-946f478ce2a1@linaro.org>
In-Reply-To: <20261125-james-perf-kvm-live-file-v1-0-946f478ce2a1@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Ravi Bangoria <ravi.bangoria@linux.ibm.com>, 
 Mukesh Ojha <quic_mojha@quicinc.com>, 
 Mamatha Inamdar <mamatha4@linux.vnet.ibm.com>, Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

'perf kvm stat live' creates its session with a perf_data in write mode
but with no path, so perf_data__open() defaults to "perf.data" and
creates an empty file in the current directory.  This is visible when
running the "perf kvm tests" test.

Do the same thing as 'perf top' and create the session without a
perf_data, passing a host env instead. Live mode never writes anything
to the file anyway.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/builtin-kvm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 785b761fb951..c48d56b18487 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1855,9 +1855,7 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 		"perf kvm stat live [<options>]",
 		NULL
 	};
-	struct perf_data data = {
-		.mode = PERF_DATA_MODE_WRITE,
-	};
+	struct perf_env host_env;
 
 
 	/* event handling */
@@ -1911,6 +1909,7 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 		return err;
 	}
 
+	perf_env__init(&host_env);
 	kvm->evlist = kvm_live_event_list();
 	if (kvm->evlist == NULL) {
 		err = -1;
@@ -1923,7 +1922,9 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 	/*
 	 * perf session
 	 */
-	kvm->session = perf_session__new(&data, &kvm->tool);
+	kvm->session = __perf_session__new(/*data=*/NULL, &kvm->tool,
+					   /*trace_event_repipe=*/false,
+					   &host_env);
 	if (IS_ERR(kvm->session)) {
 		err = PTR_ERR(kvm->session);
 		kvm->session = NULL;
@@ -1944,6 +1945,7 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 	perf_session__delete(kvm->session);
 	kvm->session = NULL;
 	evlist__put(kvm->evlist);
+	perf_env__exit(&host_env);
 
 	return err;
 }

-- 
2.43.0

