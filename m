Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6313B895B
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Apr 2026 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570758; cv=none; b=KaNYN75uqkTzNSdSKjBIOxT2HoCBI/EJ2R18ywE1eJ5Bx8cmf2toZK/foAmDh+8VXwrSb2rzMEhOOrj5TYRotyPhn7JWLt9BlgVSgKL1pso/05TgCTcbYdbQLawGsjZg2jT3rx6d7MGtyaRSgGR3geisLejLC12q1Auzt+hekYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570758; c=relaxed/simple;
	bh=1TtLlyGoEjpcMlM0IIi6mugXWU7ed7R1NsJlS7WhIk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HecLK7caMRJfUAGRVp/mUs/r+iuyr62TYAM2lPLFLg8zVIjeyDsKjPUqZw1SQ2i6SAhbmhl6T6ApbitG1mZitwBNS/nnHF1Z4//8TjG0VMK67fp6obuZz7dP8nQ5eO7q9M3lagiwLY44mdyid1wpz/F7we9oQ4pVB1tXfoTo0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A2KFQXvJ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2KFQXvJ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43cfbd17589so4018964f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 07:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775570755; x=1776175555; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpsJulnDdvHBRscZw94/N6Zs1iwUAKYW6ZQQ9YyXyQU=;
        b=A2KFQXvJ+/VJNJpeFajXPdXp8dZXQGkBky29JDCWWklSpaHX51w0iR4euI0y+4HaDd
         3LdNNfmIZ+peERPTgJ7J0IKyEA3jk9CYD6XBIlshZYcw994vG5pM/cdgoIHfI2sxwx5Y
         peD5McVpX4Ix0YAzBWAOF7kD4uDl/2rJnadaEtiTFz4/yCr66hpyaXRFl4T/Vo7Jznc0
         wH9TJoF0cMehLPOuc/tFj8Cmq4K39PS0pISA6T2R89z3MPTTtti8BrfrEUPPW+bYIz7m
         uEPHrGv6Nqpi0v6V42Q0Ar1XqD3FQx4iLD6pDn5GkxV3CqhqJ7KnXbiiwgpjc+PnEXyF
         pe7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775570755; x=1776175555;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QpsJulnDdvHBRscZw94/N6Zs1iwUAKYW6ZQQ9YyXyQU=;
        b=Cn9lcdfr+lnDtkFWpPZP3dtlT0Qo+vMeOMKmzcs+kLuO63Jc0hW8nNJWvqRcH9Y3ph
         ptUUhWJgFhGHf5HGRzBNsrQGIJPEGhmy8qBxhmk2P44nLTAMDT1be1rJ5FU/5FQpGknG
         rU+SHI7LiUBD/eQj5uzDa2+KWrX1bRrdAxzxNg6VgFg8PQpcTxMWiGYGe83eukIPRXOC
         UxUFzt0NjGG7ZcovsLB4jLInq/RHchUb+XuIDUaWZbzbtpefsKdkP8lpeNfATs9evw1G
         0IdwLvJgTS56P8OkP0GeBWlClQlErNy98SoOBY4EKjYOZljDciCPNHoglU7s7WZ/t6hx
         piYw==
X-Forwarded-Encrypted: i=1; AJvYcCWp0+ciGr4l0eHsoNJeFSvhwacir8CLTkg6xGH271hEDpkExtRKGHmAi0oemxE/Nsv6R6uob1DCISEJ/HIRt9of@vger.kernel.org
X-Gm-Message-State: AOJu0YyKBW3jCBvxvKWn8Unsvdaa4hY7g2GTBAfanCnxfroqWvx5P1fv
	QJIINKNRdwwQ8oKF6b8sLZABxp4evsYfGkLYSj8B9NCKL6cyVB+//ZUwdl6sBc2H9LQ=
X-Gm-Gg: AeBDietSMBxyV+7frKY2LJBmrnfdA6NDWT7ivFxoCkxtjLocmBrmUrbWynYsXxFhdSp
	SElyUJ11d9mHxKhtObENuM5gXEux2bPeIYbBrQhlRLuehdXiCJvHqpFnjhXBw6ZMbM9ttqfpbbV
	zYzrznnmeBOgot8S7VXtZKhfSRCJ8GTNQfkX4+4M0fUt/vECDiE98SW44VUBSwNszEuvwQf7xVP
	lGGa7twU2rIrm/F2qHWoS5y3PAIialjG/6gaZXmZ5ZAJEpCEeZTd3f35WnaXdSAU7d4jsDjJf85
	iQELEU3vVlAQV6UOnLCAXAW8bB0fwkpjQBJcOcQjEfJO96R8K+B/F319+pbCKThkgCeot6i160F
	fAKrE6IIbMYq8mqEucKU9t+OQrc9TifnGuNDuVX3Xg4YWJ6ALMuI5vD9Pse67xW+xJJ/r2lqoGk
	2jJBvdX5D3g49LlgfxzYizqKbXXTHOlivJ
X-Received: by 2002:a05:600c:a4a:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-488997a44e2mr248941935e9.22.1775570755200;
        Tue, 07 Apr 2026 07:05:55 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e822227sm626876145e9.4.2026.04.07.07.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:05:54 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Tue, 07 Apr 2026 15:05:16 +0100
Subject: [PATCH v2 2/6] perf arm_spe: Handle missing CPU IDs
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-james-spe-impdef-decode-v2-2-55d3ef997c48@linaro.org>
References: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
In-Reply-To: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
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

Don't call strtol() with a null pointer to avoid undefined behavior.

I'm not sure of the exact scenario for missing CPU IDs but I don't think
it happens in practice. SPE decoding can continue without them with
reduced functionality, but print an error message anyway.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/arm-spe.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 7447b000f9cd..fc11f32e4911 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -968,16 +968,23 @@ static int arm_spe__get_midr(struct arm_spe *spe, int cpu, u64 *midr)
 
 		pr_warning_once("Old SPE metadata, re-record to improve decode accuracy\n");
 		cpuid = perf_env__cpuid(perf_session__env(spe->session));
+		if (!cpuid)
+			goto err;
+
 		*midr = strtol(cpuid, NULL, 16);
 		return 0;
 	}
 
 	metadata = arm_spe__get_metadata_by_cpu(spe, cpu);
 	if (!metadata)
-		return -EINVAL;
+		goto err;
 
 	*midr = metadata[ARM_SPE_CPU_MIDR];
 	return 0;
+
+err:
+	pr_err("Failed to get MIDR for CPU %d\n", cpu);
+	return -EINVAL;
 }
 
 static void arm_spe__synth_ds(struct arm_spe_queue *speq,

-- 
2.34.1

