Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674926;
	b=rOXvle68dgkZ1C6nJS8cPWaZJWWJ5gAF/96pgXZLqwmAXFBh4fZdEtXeGMcUXpLo+F7x
	 9F4zcKtTjIfC11Yzre2gosHm4iFjaqKy+iypPuASel0WJZ2mxEWB2p7TE77bHfqNc8eV7
	 wEvCgmr5aQatsy6DfkfKzvY/DVQu6dG3hoRF8w/KIeWmrhtlRqAcbUoUWxIsb9oCU+68d
	 2NpQonBgybX5uOwiqyUjdfTMFKNzCZ6ywQpfRYLTnsmEz2fjBnkQkqWDLqVrfCwSu7ZLf
	 bAzSPr08A7ZbuUgnwo2Oi/+yFRf0tGYE7bSCNlKD2oCSA6nCvUIcuByjUfiRc1g6QrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=vUuHLakRNbr4esv7p2rM0pJWyo4Q85EyExt4ND+SVOs=;
	b=PUFEJzjZE9//uaGgOdEmUWzVnTqsIlZ+92pzyH11XJmkxfF2bHGul22seIDDqNWm6UGf
	 Tt4Sd550HoPDjpPobLXkbG5XaKbPxJxsJs7YkMFXixkUuw4DiWYBGj9gIjFujJsG3vph8
	 eGKo3RmCPpzYwvP+hbwE7kSaP0Kv9l6dpvzvAWbZijv2/Hjut78Gb1/aSw3SOwLd8txrq
	 jojzH9Pq+atYTzkGQjRJsPrH5qyybRHdGz7Gv0lbrtbqyHUPCa7cC/zkhe4NmxCfOFjOR
	 mVSeWDdyu4DNdpPCggNrPlDe/2JUv59H6+LLYl35AEGliTLUAPgAQjxdNtbcOtCo2VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eLpUGb3w;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17E9606A334
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 03:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D17E9606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eLpUGb3w
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8acda240937so29550947b3.3
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 19:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793674925; x=1794279725; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vUuHLakRNbr4esv7p2rM0pJWyo4Q85EyExt4ND+SVOs=;
        b=eLpUGb3wHXq8jxNH7vL6gAs00FArBPuaRRkm5Sr48oa0dd9zv1ziVP/slzkuD1xTYe
         yzS0l2ThjCIcy9ixhRQdSYXyCdw0Nwg3IZs8PDd2saGimBMkA7D5Tdy/FTehIGK3QwOq
         H2utf5BCXKNR3eo4TG5QDmUGQm/ihRBFLp5DtC9Ua7LbLeYNZxLl//qULqjZ/w8BbfUi
         wK1lVk5UYVTbGEM2w9lZCal19mcOyKUKvBj6jhjCrUweHfmx6iQN5oCMMHSFFBhmOT3E
         9q003PTeYOpI+V4ILAzgH0kCJDHccmYFzOKfZhLhS6e9DjfNeg70Gmn+BjM+vU1LfCHH
         6O4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793674925; x=1794279725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vUuHLakRNbr4esv7p2rM0pJWyo4Q85EyExt4ND+SVOs=;
        b=CM5OFdrVVsCRvkr7RlEzaR/l4espZ3O2HiyPqFU1SBQ/o6b1n4tuP5qPURQFJChhiB
         jzll2ixg0vwuv9jsphF5Fwrs6kvFQCqGOmUfdQ6w3NAo2xzAka4cHc9yKmebsVuRK1mf
         9SDazEGErc7DlqxuGYSCl/IVT6zYz9syN+OA/RREaZ1Myjf1PS5lQ2Ey0qFP+ZQuG8fX
         Qd+8cXJ0UUdCboqlF4bZezW/fM7Du6SVDP59pSTkStVTHtyakl9X6Zr36zaf8jZvUvTZ
         isnil0+X+yysxVsHr1KSkJvznJTegCLi9pBz1UUXs1ZA7i1VYX7qwde5+LUHaBvDDajf
         mevw==
X-Forwarded-Encrypted: i=1; AKwUvBwTkYj0D+vkr9HkOKDEPAsV18wrrBoa36YrUPUlmYfT8aA60h4Q27BBWmq+TZBW5U1RjLol1nx9N2ENMP1thG0X@vger.kernel.org
X-Gm-Message-State: APuU4Z8IUnu5gRoFUlOe1MvNK7ojjz++T93wJtkfimUZwuWo8jwSAMGf
	DTEl39Lz2+0Tis49xtswukXhI3OIkG8AvcIdEXjR5ULR8MpPj8O0aCtyRSorCYHg
X-Gm-Gg: AYBFou21uO2zKeTxKt0proECRw6PeuHPZxa6RK2jwoCq9xIflLZ+Db/kbsWGoDLPDyX
	PecYIJCkSuTxKrGEATenPYUVYa87IaDu7iYOtgp1GqNezZAoDpOqPg4MTU/vP++HRQz/YVKuyfu
	oahRTQLSCSF15zmXSOxwaasGcdSkdEvzjs5VV1ptHeRSskqqVJ8DkY8O83lIxeWhM1ghbPFQ5M4
	/ykMSM26RU9DBoXtJGm5BvKtQ8e6rLZRxKvvd+zPkWPsIxK/1ufc+1JktwNQS+RmRwCiPdLXkHp
	/cp9ltOV98Sctulfg++yy8936vwoipLgZ061ueocc1+W37JjJt3+SxyT26q4doZiNWlv81B+Fry
	vkk39qsjf2efA2ak6Ckgqyy3Ndb5L+zvY6QiKHsSYVoZYnDeJk/8LcbY2GhhXkfzfoILhwxX0KS
	FAmV0EAMWBAqSgYpqVUOTl0D06JL6CXNzz2D+H6l2BwcMcUdnRoXrsX0kXeOiikcPKr0LdAZWw6
	Q4V/+z26J/Gk5tzx7CUy8wCAJkRJL4LPwvn1Icxzqb1CnzoSl4r8vLUdhY0sFtcHZwVr5GIG3Lr
	4kI4rcgj5+/pUkNUvlOiHfsOvkteLaubT6zFCzZ6rn4NIwMYH8SzWwWR1XHbuy25VRo/RdM61UI
	lddLzBb/fmA==
X-Received: by 2002:a05:690c:f8b:b0:8b1:8d69:1b20 with SMTP id 00721157ae682-8b2b65b31a0mr75897497b3.8.1793674924743;
        Mon, 02 Nov 2026 19:02:04 -0800 (PST)
Received: from localhost ([2600:1702:7a90:6f9f:8bc4:8aec:108d:7a04])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b714cb1csm64619807b3.18.2026.11.02.19.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 19:02:03 -0800 (PST)
From: Matt Turner <mattst88@gmail.com>
Date: Mon, 02 Nov 2026 22:01:58 -0500
Subject: [PATCH v4 3/7] alpha/perf: clear PERF_HES_UPTODATE when an event
 starts counting
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
Message-Id: <20261102-alpha-profileme-v4-3-61e00f5e1da8@gmail.com>
References: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
In-Reply-To: <20261102-alpha-profileme-v4-0-61e00f5e1da8@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, 
 Magnus Lindholm <linmag7@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Matt Turner <mattst88@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692; i=mattst88@gmail.com;
 h=from:subject:message-id; bh=bEa6cnf/NHGbPsC7PL/IhVePDwjtE880lWDMA14mV8w=;
 b=owGbwMvMwCW25rVmCc8sv+mMp9WSGLJe+i3WWGyUo7tsxyabVSaWdT90Tzg1T45PbovYtcm/L
 L7ihFpxx0cWBjEuhpliiixx6xVZZrXtWOpzWvoXzBxWJpAh0iINDEDAwsCXm5hXaqRjpGeqbahn
 CGToGMVD5PQYNDKLi0tTi3TTCooc8vJLEksy8/OK9fILUvMK0gv00jLTSjIy8ouKU4FG6OWllpi
 6OroZGRqYWDpamDlZOJqaODs7GTq5OTo6uzoZWZqbGDhbOpq4WpozcHEKwFwjuZyRYesSi4krsp
 s1n682DhcPf/HLL/nh87oMyzNcFU+aHrB5n2RkWKXTK77y1NHAA+oJvv48PnMfbqxxTJqid+P6T
 sOG7/z7WQA=
X-Developer-Key: i=mattst88@gmail.com; a=openpgp;
 fpr=3BB639E56F861FA2E86505690FDD682D974CA72A

alpha_pmu_add() sets PERF_HES_UPTODATE and maybe_change_configuration()
then programs and enables the counter, but nothing clears the flag until
the first alpha_pmu_start(). In that window alpha_pmu_stop() with
PERF_EF_UPDATE skips the count update, because the flag claims the count
is current. Since the next reload rewrites the counter, everything
counted since the event was added is lost.

perf_adjust_freq_unthr_events() does this on the first tick
after an event in frequency mode is scheduled in, which is the default
for perf record, and it then sees no count to adjust the period with.

Clear the flag where the event starts counting. alpha_pmu_add() cannot
do it, since the event is not programmed until the PMU is enabled, and
stopping it before then must not read the counter.

Fixes: a4eaf7f14675 ("perf: Rework the PMU methods")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Matt Turner <mattst88@gmail.com>
---
 arch/alpha/kernel/perf_event.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_event.c
index 70840c05d39b..ecec78c355cd 100644
--- a/arch/alpha/kernel/perf_event.c
+++ b/arch/alpha/kernel/perf_event.c
@@ -456,8 +456,11 @@ static void maybe_change_configuration(struct cpu_hw_events *cpuc)
 			cpuc->current_idx[j] = idx;
 		}
 
-		if (!(hwc->state & PERF_HES_STOPPED))
+		if (!(hwc->state & PERF_HES_STOPPED)) {
+			/* The counter is live, so hwc->prev_count will go stale. */
+			hwc->state &= ~PERF_HES_UPTODATE;
 			cpuc->idx_mask |= (1<<cpuc->current_idx[j]);
+		}
 	}
 	cpuc->config = cpuc->event[0]->hw.config_base;
 }

-- 
2.55.0

