Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13EC3B3C03
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 15:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462253; cv=none; b=kFozYLEhZLKoMdWeLe021P5JNC/1fLY+tTAtaR636vVylBYqNKfTcL3b6wHtXDZtHh1aJ4heisvwNRdOgw6u7CZz/RFpuVMizRVWYz1EMD/s02RmuLMGOwNwKBGoMTaA8l0rXnA7Oklfy8GvKUjAb4oH7KgwghX7v6mMptMmNtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462253; c=relaxed/simple;
	bh=h2Q0M74fb6yudEF8zDu1K70Lt8wJfWd+FJHyFrYnfK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mrLSm+sVfYXRJPsC+vzIjIkED3lSZfK2b+fJ+FLVYwkprRLfEB33na/vSj/u8OnJ9f2pAWVmQIgGKAx0B7iToDafoTOdhZoUgLDQWgqEP6xZXrVgzssInT/vASOyl/r8Ip4G422CNp3e2BrHeFIeg1IeD9U/cWXu9arGuKa+7Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QJXDIZ6t; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJXDIZ6t"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4997581cdc1so7982895e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 08:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786462249; x=1787067049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zjkcq8l0GSb9YOwXmla3++8CiBcoyxIkWo/FH5SvfOY=;
        b=QJXDIZ6t38strAA327eSP6Z3PLF7JSiXgA4QSw772UKuiXGsqa5gOM+a+ecxUWo33U
         8KlP/0QGdogiLtwxCkvY2kW6d/ujTEkCuxBn/zIAmvIXzrg1J6Px79rMAyHCfRyYNjvx
         gleuqwC2H55UN/JmdxPq90LBebBYDhyqGymS4doBkMdjNjyTBiBQ5SJqKfaJL6FiGGLV
         PC4KUS5zzqhHGrKh5y9DPRY74lq6o8Go68feppvTdVenCYrXj1bW6nt+japP/PUUIBQH
         Gb2Sm8T48bo2usH9nlQQ4TE7gMWNr6g/HAUCOsSUY4Qiu0vKH+GLV++468p6s4A5+VFm
         sZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462249; x=1787067049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zjkcq8l0GSb9YOwXmla3++8CiBcoyxIkWo/FH5SvfOY=;
        b=I9+dMISydNruuIHgbpmseoN7q5t9YglkHv1n/ikPwnpaDsZibvvWpqc2UKciLzOlkH
         36nzfWBmFe7swqtRVz5QA8/bDRZHal5Vijo3vjU3MHr9UZcGRfmU7vdFoZYYMzZSRtPu
         IkhR55M+RpZ/A3zI8qeJnB4jZ5DC+6IperxK4QwE0VpYYUxpqYx4/KrjOhfG6DyMziWg
         4YlzRAMEWH+xGfto74H1j2WIkwcGqOC8DJWqs+64bhTO5bdwYciVLT3ZYXCJgiKshFVF
         9zmqeW6+a09woR6alf/wQajU7XQulIYmI3nmAKBwNwSrFmSjZOzBeRlHzZ3f5s1AlksJ
         vmIA==
X-Forwarded-Encrypted: i=1; AHgh+RpunnprXPVR0vyZy+6az/9aFoP0Wr8ZrxoGUn46qxIVLm74Nxzg6L0kFEft5p2tjOJRLeBH62aAIBf7o+Tu1qhx@vger.kernel.org
X-Gm-Message-State: AOJu0YyisWewhW5xV6QB58OiN2XUgeJOBXEN4/kk7JZhN1khmz00bACD
	SP/05xxtwAtvUkTJEmXoAkMsUDeKnS1lsHFB+5il4ekMv1SwLS9mrUU0rQYxyv5XMbQ=
X-Gm-Gg: AR+sD13M++6w/UAhNf+N8JwgWwLX5keQVW/qOKU4AwiEt5TYw38sakQLG3eNaVKDoCO
	ue2CkoKRJ7YAw1a5E1ru6+dziuzy2B6gtg252IkRvPkT5if4Qi40lW5w32SUYMZeoSvn35HSwa+
	buPyYFdZp+Y7kSBFiuq8sljGuwVHSaVIvGJn4Eao/6JUYbSv5eDIq+xpUUU0qzYrSxoyWrdW8zG
	DZoAvXjRVAIwrMYVcea0jPy2CT24xPzhktaCv5t/45ZmLXTVciUPfVK1li364/EHBplLmfcpLfE
	O3YVRJ+T9dUOzkkkDjyNlh8G+/CLik6yX4K9r1fdaHiDRrajAkMMq8Iu/bg5GKFYBphFWSGSuau
	q4I3LvHAZ1/amIH5emuw4uSa7DG87w4GG/mvKkRQhOIQO5TgZaX+iGXq/131oFC8zlTfNx+xVco
	aZ0oEKlBWV/e20qjWkYzIH0Qzed8lp2McFyjTx3uuydnMWeS6qvybIFqqFJENbb4mN
X-Received: by 2002:a05:600c:4513:b0:495:3e08:ad19 with SMTP id 5b1f17b1804b1-49978468c2bmr59898875e9.9.1786462248915;
        Tue, 11 Aug 2026 08:30:48 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977dfacb6sm49865395e9.1.2026.08.11.08.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:30:48 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 11 Aug 2026 16:30:05 +0100
Subject: [PATCH 02/14] perf cs-etm: Warn for invalid timestamp option
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-james-cs-unformatted-per-thread-fix-v1-2-90565318f5f8@linaro.org>
References: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
In-Reply-To: <20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>
Cc: Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org, 
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-doc@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Instead of silently returning an error, print a useful warning.

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

