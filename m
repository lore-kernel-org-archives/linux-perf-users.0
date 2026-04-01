Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEA2466B4C
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053588; cv=none; b=ZZd1H5iQVvaXYexEhA8zcka4K+4jCNCIe4gUWG2nUmjais/C8xN7UQO7Tipg6f32mUsfV0Nx11s1olCHuHFOSg1xxl20HWpkH8+ORJ2gw+CFlE+4Atf80jkYhkd2ukYNIriekJg5g96rRLF/7DlwbYPfMkQ+5GQsOICaq2T5x6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053588; c=relaxed/simple;
	bh=+FXiNbpAlmgCkXW5ith5w56rGcl3R0HNhjs0qhFXNjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BJDSCks1bS2FjoKfbZbwZDgZqgF6ILHL3FrycORwITHKZyUwQEXM2KvzqSyoU5v1wE2c7QBTRTFkCQWAK1bFwT69+dart4Hqi1m9wKt0lQrBsY8CI86GsFTAKzM4voup/SbXQYmVXBF4pPrAWYhYRyuF2bEZ7cKda8Z2NCZ2cwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DlkiQCu5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DlkiQCu5"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so64125445e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 07:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775053585; x=1775658385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m7bKqETK+WJUp6t0jb6uev5MchsKdP3VnlpvBvvpKLY=;
        b=DlkiQCu5MyLse/7ehjKRP4CsgeKglKCaDo83iLAgnLIdjGF58sq1ikXy4ZvehJWhre
         6O+iXPbHFn3kjBswRLbJ8iW2OvHeEJ7Ahcy61xTASuxZLSP76MgGaONkQIvugBEaY+y5
         lYCYrqEmhUcwShl5fOYHv8eKdXeZPkkPIRnUyHSNLV9H1VCMmh1ZNyQg7m3UuW1grWlT
         k3cE7MewEVNJUOAOrugmI52omikcdHj7MUDJ63TeJEnnQY+w/3+5PmNt9JxPQDRVJECa
         nNsoT2rQ4Wu+dhc7UWPV5EkjyC18LHE0SKj6w6JFuO4oJeNtKbrWWncfbfeZeQkBXYqN
         TYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053585; x=1775658385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m7bKqETK+WJUp6t0jb6uev5MchsKdP3VnlpvBvvpKLY=;
        b=LngbY5fBkdKuYaV+pyaFgetaUomLZleePFpfxMvpOSbqW6yaNAisvWt/rkRY9nPOtP
         yuZ6Nf/dNUeaHbIb7w6nglVVm4CGql1gyBvjbwVoSMsqW/w5pqorpOHuuye3o5G2vD77
         eEIhYHjBUeYf3zFLhmHz9gAA2ZF32ggjyH/hK6C1zjVTmVTfu0mnHWvoshY2p6M+xjL1
         HRx60bXQWlBVowCrEdtk7WqGG3jlMv4A60M2VSo2ZDvjvsFUn6TZi/jQvOgGBjy67CmL
         ORiiiicFUkzu6wKmBZvenaJJ3/0ME9rXSS9gx2Q/WgAyYDLw0O11WD6ZcnqueWozmspU
         EjWg==
X-Forwarded-Encrypted: i=1; AJvYcCVmAClrVgY+Y2uLw2EBUIN5lvDEK+VL6bNZPZkIgEkalda9omqBn/fuCdqsnlGuTBmIJqkiIMLRHOHg1CbBYQid@vger.kernel.org
X-Gm-Message-State: AOJu0YxXqUYaPeYQ9WiwytCZHJVgixfcbCon0um3afXB/DayjM8+C21w
	/zBYeDXMbhK1BiD9XY7Ryl2vyOPCZuXSabBsElELOgkcbTsN1bHNsY+rR/rFVvVkHLY=
X-Gm-Gg: ATEYQzw4nCNHvqlQBLApKBehX2ImI/MFfnTL5e4n26H9vXKNhth+eEYXPbcGzljHMUS
	iYiKmGDjN4QUzkTKStaDt7MRIFCWkU7TAvLLEcvdY3BQE67LYTszpwfKoBO3av7AstGWwubHPKk
	wseVBI7d03vWvUmKNYPzO5hicHkGv72Z+WZHyHZSXvjU+dgxSqzzYHfYNHEommTwNJ1X3iMjC+P
	oIvDDbmdeho95MLD3xUZ2RouCcFp/rnAE0QxwkggkrO+4Mdy5oaw6+k1JugLPfN+YCHL/If7Apx
	9dw9GuseQN+hewJu9wGmvqXiAfspDAB51TAYbV7aSVwpQcLmLPWX9ld8YrqI26lURcYmtkBlqri
	CC7+bqK/TwwaAAAYYnR5njVxApOR59ABZEvvsQnyfdGhC9nj7WDjfff0VCJ7m4fR2aXAcqOLRN9
	2O8wMgEWnYsQi4TB4gwIRlSxr4HKy5wYh7qqOpI1jOyAk=
X-Received: by 2002:a05:600c:a415:b0:485:41c4:e2e5 with SMTP id 5b1f17b1804b1-48883596671mr55626635e9.27.1775053585406;
        Wed, 01 Apr 2026 07:26:25 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a63c9b1sm2305595e9.5.2026.04.01.07.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:26:24 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Wed, 01 Apr 2026 15:25:52 +0100
Subject: [PATCH 4/4] perf arm_spe: Print remaining IMPDEF event numbers
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-james-spe-impdef-decode-v1-4-ad0d372c220c@linaro.org>
References: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
In-Reply-To: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Any IMPDEF events not printed out from a known core's IMPDEF list or for
a completely unknown core will still not be shown to the user. Fix this
by printing the remaining bits as comma separated raw numbers, e.g.
"IMPDEF:1,2,3,4".

Suggested-by: Al Grant <al.grant@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 42a7501d4dfe..b93712ce0aca 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -364,6 +364,24 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 						   payload);
 	}
 
+	/*
+	 * Print remaining IMPDEF bits that weren't printed above as raw
+	 * "IMPDEF:1,2,3,4" etc.
+	 */
+	if (payload) {
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " IMPDEF:",
+				       payload);
+		for (int i = 0; i < 64; i++) {
+			const char *sep = payload & (payload - 1) ? "," : "";
+
+			if (payload & BIT(i)) {
+				arm_spe_pkt_out_string(&err, &buf, &buf_len,
+						       "%d%s", i, sep);
+				payload &= ~BIT(i);
+			}
+		}
+	}
+
 	return err;
 }
 

-- 
2.34.1

