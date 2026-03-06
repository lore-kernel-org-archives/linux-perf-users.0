Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356A5396D23
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806134; cv=none; b=IfvkTqdrM8/WYz8zSh5ESCOnPWMfwubZZ5hsqsnj/vXDTcixCiAuN4P2l38Jn0X6MYYdPLrQJZ9zqI1kg0tHyEpZArW+Uo0Iv2zLeOwDFk2RAiWOJNCUbOSF77Nud9EzRnmachLkb7fyzH/z9k0JrlWWhnKwNrFEpAxzzYbIvTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806134; c=relaxed/simple;
	bh=sFMs2fJ+5mmMCa911jg8xv6T6E4xGGrps6RrAq3cfz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hMatGYZIplHie5TIQpLnJftRHcanBmGME0T2MNN2a/O30DknSJ3br4J2ASnBaV+2uRXpJEweJsQPZmGJD685vft9H7dc3tcUpmUR2EGvCoYWW7dgRKAuSvTuTQ9dSgB+dAg4jr2q69Ej1osuf5EPuaK2KIE396frwEThIMHZifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vPmKtfrL; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vPmKtfrL"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso1752794f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 06:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772806131; x=1773410931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2YHVtNrer6ZgCaM7gU2oNTFgWRDR0cCXzcTFScMMl0=;
        b=vPmKtfrLsEjQVKWpt4lkl4pznsVKF5byoWJDT7oHcM1EWzQ7NW3sQVcRy/WGFCuFN0
         mWTf7B1stSSd3iyEkAMf1bnaUGuHZk7GfvfAf9y3Afbb4l4IeTPc1h+bNfco4Pr6BFHS
         9u21veGTHt2wdTfqIYr/GxrK7ti6tC1CpE7SHKD1QnGgRLSAh2CBElyBlf3NL9MFgKc4
         74wtRBfKFyOS5M46m9PQOw3j1/GAgtmvjthZsA5Kes4hFqywPJ24tO5ma2tznhncqQN1
         NzWQd4WtHIYR+/3D4jRGnhRThsC1Q1dz2mAxOdl49dkTMect1qs8yzHhafNuroIGvfXU
         5NwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772806131; x=1773410931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R2YHVtNrer6ZgCaM7gU2oNTFgWRDR0cCXzcTFScMMl0=;
        b=GQ9HFluRbCKeKpmC4Vjm5oPV/UHhgsVcZCgI2upe6ErOUs7ERUHiLb5UZ7fa5sh4II
         KufluJg/fBcHJietCdB9Yzn2gfWxnFFyBrPeDEAv6XF6eg3C4fMDafHeWZCQtDQTp7OE
         MkSG53mR1AcBBlGe4tmMjB0wmkc3WbmU+YDOLCygQe9ft5XBTQlCRvha5LyXkkjCbhJq
         oh9iv67xTcXCpx1fvNiATx0R0vqY4EDW1yl/fnICwXb+kx4Jj1vo8FsXIYoT0woUqWQc
         Dbhn1GuVE59fLQ1Nrjj4VrUDo0ondinfsgVHswPwnVWDJuwX10pQJJF+7tFWvdWqfxBI
         Q93A==
X-Forwarded-Encrypted: i=1; AJvYcCWEAzSrz23FSZPqvgrX4IBNiovO7uXG/bHnYDxfNrZL6ua8zvYeJl4ihgoiKa6iOLYc6AtyrLZusfTwx7o7Tjuw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy72z8Q8zkrFfGCd8YjYSgnFCrofnsjDUSoTwO53UQTya9Yorr2
	n84LbR2uTq6isvQ18ZtZkoXFlowGIsK9AqUU+/qxHmIB5ZnmZxawraktdsfM1tubPFJnc/kdjIc
	C8UdNh0c=
X-Gm-Gg: ATEYQzwmjZ5w8Y/fLyMBHUwKx2gDHwonqY9z2EQ8SAs/kVRLNmeWAypDORqpgq2hiRT
	miHy75RP41BlVuteAAZp5XmHFFOyPkmLHcPEEN30IqCezAKroCB2DxS0eFv3ysA1Pex/017BgzM
	BG42JCs/XU4sVWJq/t7UWCtWn25q+uE5TOw3zkUfAz6JqBE5B2W+KVV23JUQQYcFBgJFViAY8GS
	Xj0NLkumr/IWHRJnPFs9QVyCl6JfjHC4eXjo577l4Yga0ewQokmNAHckSQ4DCH6HkE+5LtMSpGX
	XUzMyj67nXA1shIiavBNBfD9I84lNWUR4jCjFXNy/z41Dvko43887Vmxdgkh8DHoe0pNzR9ODm3
	PATAbE4oGOnOhxWyUndOSIYepVg7fEZ3Ie9HGFE/43nJR+YEpQRfZgyzRExL/j0t62zW0U6ImBa
	CmqsBegVy+vk6bP7ft3TllpXwCSvn/a8Bh
X-Received: by 2002:a5d:5f47:0:b0:439:c008:d81 with SMTP id ffacd0b85a97d-439da65c807mr3986639f8f.15.1772806130625;
        Fri, 06 Mar 2026 06:08:50 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae2bdf8sm4212967f8f.25.2026.03.06.06.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 06:08:50 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Fri, 06 Mar 2026 14:08:35 +0000
Subject: [PATCH v2 2/2] tools: Sync coresight-pmu.h header
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-james-perf-remove-etm_opt-v2-2-b411d3ae24b3@linaro.org>
References: <20260306-james-perf-remove-etm_opt-v2-0-b411d3ae24b3@linaro.org>
In-Reply-To: <20260306-james-perf-remove-etm_opt-v2-0-b411d3ae24b3@linaro.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@linux.dev>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.0

Update the header to pull in the changes from commit 3285c471d0c0
("coresight: Remove misleading definitions").

Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/include/linux/coresight-pmu.h | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
index 89b0ac0014b0..2e179abe472a 100644
--- a/tools/include/linux/coresight-pmu.h
+++ b/tools/include/linux/coresight-pmu.h
@@ -21,30 +21,6 @@
  */
 #define CORESIGHT_LEGACY_CPU_TRACE_ID(cpu)  (0x10 + (cpu * 2))
 
-/*
- * Below are the definition of bit offsets for perf option, and works as
- * arbitrary values for all ETM versions.
- *
- * Most of them are orignally from ETMv3.5/PTM's ETMCR config, therefore,
- * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
- * directly use below macros as config bits.
- */
-#define ETM_OPT_BRANCH_BROADCAST 8
-#define ETM_OPT_CYCACC		12
-#define ETM_OPT_CTXTID		14
-#define ETM_OPT_CTXTID2		15
-#define ETM_OPT_TS		28
-#define ETM_OPT_RETSTK		29
-
-/* ETMv4 CONFIGR programming bits for the ETM OPTs */
-#define ETM4_CFG_BIT_BB         3
-#define ETM4_CFG_BIT_CYCACC	4
-#define ETM4_CFG_BIT_CTXTID	6
-#define ETM4_CFG_BIT_VMID	7
-#define ETM4_CFG_BIT_TS		11
-#define ETM4_CFG_BIT_RETSTK	12
-#define ETM4_CFG_BIT_VMID_OPT	15
-
 /*
  * Interpretation of the PERF_RECORD_AUX_OUTPUT_HW_ID payload.
  * Used to associate a CPU with the CoreSight Trace ID.

-- 
2.34.1

