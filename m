Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879123;
	b=VX6JVj4dNqyZU5jhv+2md+rv3+PUzlkAyhBOYMykGDhcEMVjaEmg0vLH0Za4Q29+Pz02
	 iFQ9Ky1W+744rLuzP93zItZnqp4jFP05nmoRdhSAdNTaUwFBhEs86JLW2wxjlBTchBRuA
	 jemlIAL9KZUKJp0IqgiAZvuqTspfNX/gF6R9whuj6TeOfZxZ2Ga9oFQ+bJ9OpSwCwVe0A
	 xgd5kyd6P7W7ue67AMULcj5TC8nV5mBVza16Y7WCbfynLyv+OhO5xvmS9+uC2V1xmgxPJ
	 qiuVoGo5xUh33b0lHGvj0jjVTN5JGUTGHYPlTZjoBUdi3/VnshkfkcpRo0Cneb9j91Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879123;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=W6GeqvCDvQ3QbN1jcZxC8ady49yeVHXTODTPfPeIuGY=;
	b=v/00RhqSZKqBnNemi2kgo4r9K0rwhI3T5dAGeN9u/1qARN2momLgqA3EXMtvRRM2mTDH
	 1T9t3eMI2C4/Gu05CeXbcUQ9ZPhlFMfq/PLxDxOs2xzWEESaQhBQiveDLpIy934ocWybW
	 9XKrm9iwwBIVQRnK9xk/cFyrSOPTRKmM0mf3rZ8Nk+34bggXxahM04WS+ZAcDRpydPdIE
	 aALSFS1ElvWKZ86AGtySWzpEZZcW/pfZ9h+crqhSsAMjycpx5vzRsiVOO7tQYLj9a/ZeA
	 dMepGn/guhbnztI6qdDItsX2sjk0RDc1pWEuLnqsOysNLjuDyer7CLxjpDFZJhkFVFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Z1qyw+go;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFB26083615
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 11:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AFB26083615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Z1qyw+go
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so14997575e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 03:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793879122; x=1794483922; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W6GeqvCDvQ3QbN1jcZxC8ady49yeVHXTODTPfPeIuGY=;
        b=Z1qyw+goqKq0ulI1TfrViW8NeoXgdHe4XMoj/zL+7NaseRo32DFCq9fCsKIHTsSnzB
         U7XlszNcUgctorLtiL5kyyLJTODbM5IGCB6M8mqyMkmrbDqKxIvlDwePqm+cekiUBi8v
         kONFd2MxNA/8xB8erm+gufZVlW1h9IR/vUjZExpxFXqTpAc0DJ321ihd6xtCII0UyXaZ
         cmKCVzdj7FHsxT9QVZMnwPOeAtQbgWNtwVMsOoLRanYCtDdNGHemzmEvmb3z3gIGjmzR
         f7ObqX5rcpCyVYQR2Vdk6fDuIQYE/GFvDIW7sGpalgrpM81bBRG78RuYpIh8gGSJ/4Z8
         CK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879122; x=1794483922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W6GeqvCDvQ3QbN1jcZxC8ady49yeVHXTODTPfPeIuGY=;
        b=P8uadk2HM1S/SMjiJWHHUQxmtPo2UP1yebxZbYHZ4e+l61xcjQNfgV6RSh26EYOyZP
         3+hc21D0PrIA1S2x7OlhX/YMhsi36RP0l7rNzVZ8ZA1yhI+sFcM6iOYjlORqHar0rXxq
         m+2JzehcxR0vTn2NW3a+iii+4IOh73ekChObUl4x1qpdQoNEgPdCwAEVoHWeD1qOG35n
         G/amNLTeJlbjphh3hIwacN5+157ft+PGe6stIsFsmuJ+JXw1p/f7eNt/AHLCncBc7mvd
         jI5zih7Fi11azM81xETJD9gLbyHMn+ZVkd4iF8xaYIfD2clD1rd/OUPvzfHiZU/8jTGV
         4WIg==
X-Forwarded-Encrypted: i=1; AKwUvBznaD//cdgar54AC/1AQHERxGBEAVmlNBVWstHiPwix4TBC4U0qI1Far6W4+kvRbK2atYz3ktYSpW81iBKAL679@vger.kernel.org
X-Gm-Message-State: APuU4Z+Id60QkqvxKiwQVkpaxPnwV6sHanCVUCfcgDoWGfRopnHBTBAd
	x7sTk6mBJlBwSwvijc9r7JNTSHCrz+P0jU3nFJ0Pu7+thxBvxSKh+bGmBjVS/XQ3LDg=
X-Gm-Gg: AYBFou2MnXLENXPCr/cm3tTo5cvvJQv2vKAlE9LfaU6iWPDSMAG0eJvMUW9AX10zNEP
	au20liuiS6mlutsZHe6/qHLQno81FooAUidFaXqtCf7UIq+qALlgohBd7RfmigZj7uEViY2NinE
	I6pfkL10F79sz6h+WMpxp++Hci43nJ41GkrLBYj8cNYOeUS1WmtVsTu5m/TDQ1OtbpzL/OhoSxz
	6jZJqilPCwgcsJwWL6TVUM6VqMVAX1eZsdlcdFLpfYGTaC7bZwkedOP1BvqaZyCyg+vi+rGdCwb
	aksThHCrz/xIZLd1U0LULh8Z9fGn49wAF2p2MtOizio8lK2XAsqqpwPLKcoaYKTuIT+2eZMxG6B
	DJWtRZ+ZmDCq281ukpIbKaOubo6pbQlU/WVsizdPIPNVg3asDQGHQDCTOZ9bXHPHz/yA2OqJYjI
	tkbbkEE6u0HvCO8owuuTAJejnhpoF+KFT2+Xrg+nMwO7y1C0HHp1C42VltkR/qlLOxuS9Rc7IN4
	0jqupHLGWd/3R+PCcSVqkOwDQHgwTPBcMWV2aRBbJJXjE1vxe8YNZV/DXbXBnc6qHaG0FZG6alE
	BCKWow+iishmKeT6/WLlHt53U/esr2L1sA==
X-Received: by 2002:a05:600c:6099:b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4ac185bc1d2mr385653795e9.26.1793879121877;
        Thu, 05 Nov 2026 03:45:21 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46538sm56679525e9.5.2026.11.05.03.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:45:21 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Nov 2026 11:44:50 +0000
Subject: [PATCH v4 02/19] perf cs-etm: Warn for invalid timestamp option
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
Message-Id: <20261105-james-cs-unformatted-per-thread-fix-v4-2-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

Instead of silently returning an error, print a useful warning.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index d2861d66a661..acfdb3f53821 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -176,8 +176,11 @@ static int cs_etm_validate_timestamp(struct perf_pmu *cs_etm_pmu, struct evsel *
 	 *  0b01000 Implementation supports a maximum timestamp of 64bits.
 	 */
 	trcidr0 &= GENMASK(28, 24);
-	if (!trcidr0)
+	if (!trcidr0) {
+		pr_err("%s: timestamp not supported by HW, disable with %s/timestamp=0/\n",
+		       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
 		return -EINVAL;
+	}
 
 	return 0;
 }

-- 
2.43.0

