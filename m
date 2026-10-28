Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793212301;
	b=Bawcqq3KE1FRGaRx6htrleYDmwashnzvI4jqPAvWXGZImw0w1ueNp9q9VoRyo5aJM0O5
	 68r5YaLetfHy3QSBpmnnUU5OfrYs0wTB/FjCa6ROxjysjXUmEe/QTTv+LfkI2OhHa7ZBz
	 A5907emOIjOyIYWZzYkvAkidf67hRRwlLl6ZRMHsyDW9G7uEP3TMQqIWuuhH65rxeWy1M
	 RbHcOAba9SU28FCSvjHDxE71Z8tz3CXSijFb9qs99EgwH4gDLxedZugQ4Jek2mcaaeq2w
	 S/J7sVx4geepRg3pyECR3BgtKl7X7YtnFe5QpJ5kIU2UizmEGH0n5FDOCSPkCPejK6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793212301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=X+QvVRHeWMxizCTRKzuAHQ+22/m0nu959maLN9qWALg=;
	b=HwhV5qfTuEqRTqvQhoDNHnCT6vW6EtIoeVACElG9eeeU/sS6PX4Ed4AAElPZ3Vx3Zrbj
	 S3kf5L0yWMwuX5M6oYrz8Mxn4Aig20Db5NZtx660/cJzoAH5ECNHoTCL7Yhdx3zC11VrI
	 BH9eUIYCVAAlboCUq52OCRQgG4qBZj4Y3PfSb9SrF4MOmsY6PjkniGgalSqvfwdwTpbkD
	 NuGsSCfw8DbDWlLkB2XOR+nABXjzsK7+tI8FsWxSf4tYgHupfDKrrKQHek89CDcTrbG5R
	 WpjUDiJd/azztFyZ8PrKrsMtn8MMZT3/Gv9fvjX5vTXyigR2zRDzTWKQVUKcRsdqg1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Q3I/SShW";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FFD606A31A
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 18:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1FFD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q3I/SShW
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so12873625e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Oct 2026 11:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793212299; x=1793817099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+QvVRHeWMxizCTRKzuAHQ+22/m0nu959maLN9qWALg=;
        b=Q3I/SShWWIQLoN2RtHEvS3tWyt5qY8W/OL12MoF4oRRZohECYlsMONQyUzyl3lwFs3
         dS8/l5SIzHnQV95IUGRfYVivCw80NKIlwiVbB5EfxMB2OSFPl/mQQTgSbC83u9K1E5gB
         beQYiwuVcn+D1KL+RCmy+NZzb5kgy7hbubOhgQdyADaiKZa3TLTwWRrr05JHXZ6Hrq7L
         UtyDKdZ7795d7EDIeGC5/E0R5wXO4N0GIBIUC0LTKVMN2Mr+aHlzWFAIZ552k6mDtHby
         dsLy5FvT5eOaQOEtxMEDuMGr+KSRP+VoW1ehD95Cio/5wcmRqahTaDDG02V3tIwYsa2E
         8fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793212299; x=1793817099;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X+QvVRHeWMxizCTRKzuAHQ+22/m0nu959maLN9qWALg=;
        b=GhjrGfiztTTRWrhD5PYdH4ztXrHhFW0usF+Ws63FiEO+Tu9vELur9Vrx4LY5dz9JTX
         M1lOum5Vqjhw71UOXBY3lXszfTCjt1hwMRw6cZfiQyVAPPf4ICLPiWnIi3aR3rnMOB1y
         kLwxjK8o/t5lwkzW7gVa1xofmQ/d3eCW0YxnoQR9dwi4oZZSv+hsQokl3jKebeTFPb14
         QX9qtJNJTRiG98yCjdCGBYgPdey4jSFAIjUE2x9j/0fCMLK70Kbb06rrRRrqERykNryx
         HKlttsuKUJnDjxRsdvse+ynHYYoP70cj8IQfVqPxOiKke8Fe8MglncZ3rS/Bo1On7UeI
         3ypg==
X-Forwarded-Encrypted: i=1; AKwUvBxehnDynYhH1Sr4pBLeHAGJ60C7VbFiUKtSgqPSD/imKVY0+rpy8aZOPrkKBwD5BPyb+ACF/0lYQuQEezwu/FN/@vger.kernel.org
X-Gm-Message-State: AFq9FYIcA3NU0iGYFjDfOu1J00DfvMfSDOztGGWjoabl8z/nB2gQE4BV
	PUjFoxVeC2ZocsoJ54S+BjVfuUKt2/nwGDoFAEGJAeZm8QpBIwiRvZ+LdnTQU30Qdgg=
X-Gm-Gg: AYBFou07D3dAJOPlSLXx2/ZEXoLXLv36FURlqANdHhOtndZcdZoOLuhlsFlkxjQFxod
	GJL/JtGv3Zq714F72JpT3Hwz+wOfbHYu/alvbQDrDT0WiBbPZ35qk8HgFxrGCiZasf8jpxZyTdl
	ixZiW8iKJFjB4p/K65I32ARLKDa6CmMp+sAuDWlBLQJS+eg62y3dZ3dJupgPF2fwUuMcrdxh0KV
	FXeXVMirJqEKtVBa+aycVz50kIrJ+OhzrQN9psONScem7Wgqw3yteY15Ju2zo+k7kAre1yNAqT9
	XztmFWOyug+E7RTtna5g6/OoLZTHui4QBgY1hZYrjz9ePpRBwm3MkTHUmv8YH8fLzRfO78dsS9G
	J6Fah55gVTdIUoK3nOuHpFX7znpqiTCjftSSuYKJG9JnJLpyn2ZAFOCG6mUTODzzm6rKurv38O1
	4M7ZngdPJ13MV8QHCggOEuvaP2i9ZY1YVKaffsx8toh29EJ3pnNKaJdpEB07LdsO7ho1FYGyz78
	uo9cI7GnMpqG30smIOPUN2N1t9H2YdiDNv5x5t5Bpz6gi72kQq4U388hCKzA/jGbiLo3r9+S6yC
	IEcZLaqQQdDsrGmijRwlWI2lPH30huZCo/HbpztihkvqNOZ0
X-Received: by 2002:a05:600c:4452:b0:4a2:fe3:121b with SMTP id 5b1f17b1804b1-4aa4eb767d1mr29197025e9.28.1793212299033;
        Wed, 28 Oct 2026 11:31:39 -0700 (PDT)
Received: from localhost ([5.83.201.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f25fsm29193591f8f.2.2026.10.28.11.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:31:38 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: John Garry <john.garry@linux.dev>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@arm.com>,
	Leo Yan <leo.yan@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf cs-etm: Fix spelling mistake "should't" -> "shouldn't"
Date: Wed, 28 Oct 2026 18:31:37 +0000
Message-ID: <20261028183137.537812-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.55.0
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
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a pr_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/perf/util/cs-etm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index bdcf94813129..65bce2450549 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -434,7 +434,7 @@ static int cs_etm__map_unformatted_trace_ids(struct cs_etm_auxtrace *etm)
 			continue;
 
 		if (!intlist__empty(etmq->traceid_list)) {
-			pr_err("CS_ETM: Unformatted queue should't have trace ID\n");
+			pr_err("CS_ETM: Unformatted queue shouldn't have trace ID\n");
 			return -EINVAL;
 		}
 
-- 
2.55.0

