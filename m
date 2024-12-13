Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2641EC4D6
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 21:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123892; cv=none; b=oHzFbLqI/LtsBEUISW0jfkKnjCRpoNTRd4mGhlr6BpxcumRpPvpWdM4b93fRaYvfhlCWWOL84Rij0MJNF7RRG/ANO052tB0zykSsKxdwBxnn3/r6eXZVlRKfswpjeGVMAN9JiIFlQVcPgF2gV9/W0kLppo+PkAgfebfVuVDt6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123892; c=relaxed/simple;
	bh=mEVKQkxWRXJdiQoRyQuxChdbGiNav5HSCWY6DgzLwTc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OVRFBbbSVqzHdiu+XEs4ricpioCQV3nSXgn8Ity1w0FL/8Fm4xTpUBiMIRWBP3XUeoHzpnrj0ELzNOrfG55Yu9bmcI8BciJ3Xz5M5IBp6RqM1r0s+m9zww5x28Il/tVe8y//CzfmS7KBFFfOuSSxKfEEEUsLnogiFZfuezc5/wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qvTYisBc; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qvTYisBc"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ef7c67eeb8so26859137b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 13:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123890; x=1734728690; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJDiQRFCSz2pV8y7FxqzQDhy9JPoVRfT99ZbYeMgH0I=;
        b=qvTYisBcnfvpD/6+tR+dI7nxRScD5uSVyt9vrYXk0zc5UXaHZ4/JGVG0FYaNQAJGA1
         3z2bQQY1X9DpjuwAl/72Q/xy5dWPaDtCDe4eJLQozNZ5j0vqyXulVl02WgvJtB3yE4FV
         DvDmAgRvICpvsJcsxrQzq3sjPzV6+I7Ni3Ex1e97CGiFhCTw3Y/GGoX7MiCwckiUTwM1
         0WO5F7GJz9+PLL9jsNoAjPW2i5viRN9hG/V8LEH97yIUJuPdCGtT3R3pTM84ScCG8yS5
         kBfBC6SaZfm80pszmVWqQX/jDtCWPIxwQwBrmmgKwxs5xyeQbQUUza26gIoKpf/Y63uE
         aOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123890; x=1734728690;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJDiQRFCSz2pV8y7FxqzQDhy9JPoVRfT99ZbYeMgH0I=;
        b=TkJSCKD7V+MBeZril5sdZwriu2zk15MXQE2xAboynbEqG6pertLhy2Ba+jQmLLIU/b
         84Kj6GGLVjVmrTOBY0sQYMvgON3MqZI+ZU1I1kBNbOcMOrwyk5LK8Nbr9DVADuTqD+js
         QzmhveUCND5eZTnf+BJXwaDtNPxJRn62kpaHOFpJreYeI5kx+00BDDq63QN50AwZAbx6
         bTqzPrSGMLty5Lxs8mQ8EM+3sDVH6pKpZQ/qWEkYZCqdsSQObH0/Lh+v5XF5Hni4CNL4
         sVGPwFG94c7VX8piZqdaafdAnpwatZ1+KjrOhBtTU5ikqq1hySxsiKGc5wrhoWZp4J44
         A8qg==
X-Forwarded-Encrypted: i=1; AJvYcCX5+fY2/2VdyL95k5MPmHxipsCUz4LKXhijNVMgE2gdpNrgRvlLVCLXGa0BZ0G4OEZl20zu8jgCbWCoC2uRr9rI@vger.kernel.org
X-Gm-Message-State: AOJu0YxBC793JUv0TPX6nWm0WzcopvvvSYNBQ1vjaQE8TYNKVWhZSbUt
	12zh4Q0PTfcQZLh25NaYTCBzm6OaYl3XbLiTQG+iDATPfRBKEaN2WqAr0tP2nj9baaS94Q4hwmN
	rM5dYUQ==
X-Google-Smtp-Source: AGHT+IHs+WAfXli6hbB79/PjfvyzF4H7kHc4JY48mxpcyZssQCRvhWFB5cQ1OWLUaDs/bXboaKHIfiq3EJXP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:9a50:5183:644a:3472])
 (user=irogers job=sendgmr) by 2002:a05:690c:245:b0:6ef:e0ce:df9f with SMTP id
 00721157ae682-6f279b74b43mr118527b3.4.1734123889783; Fri, 13 Dec 2024
 13:04:49 -0800 (PST)
Date: Fri, 13 Dec 2024 13:04:25 -0800
In-Reply-To: <20241213210425.526512-1-irogers@google.com>
Message-Id: <20241213210425.526512-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213210425.526512-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 8/8] libperf event: Ensure tracing data is multiple of 8 sized
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Perf's synthetic-events.c will ensure 8-byte alignment of tracing
data, writing it after a perf_record_header_tracing_data event. Add
padding to struct perf_record_header_tracing_data to make it 16-byte
rather than 12-byte sized.

Fixes: 055c67ed3988 ("perf tools: Move event synthesizing routines to separate .c file")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/perf/event.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 37bb7771d914..32b75c0326c9 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -291,6 +291,7 @@ struct perf_record_header_event_type {
 struct perf_record_header_tracing_data {
 	struct perf_event_header header;
 	__u32			 size;
+	__u32			 pad;
 };
 
 #define PERF_RECORD_MISC_BUILD_ID_SIZE (1 << 15)
-- 
2.47.1.613.gc27f4b7a9f-goog

