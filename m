Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019398;
	b=sWfvVmY0Hbb1zZFdMwQUdHUA1A0jXz9dhNFb2pL4FoyjfsA2rldfzFyqcHCDip8ZKYvZ
	 4QCd86y/Fcj/h/tMoN376PM/DZqAZ+8QpHxPTe4btwSfLlhYTNITbLz9wBkF0ctYe8nSD
	 Oqm/clcF9cpr1NzqIMHULbs4usPKJpQqhwQX6JoZIQ4eX0XoQENGLigLEoz/eEH38R9Mo
	 I23yS9HoPo1KQ3KM+Xjg7D8wo4G2RNRjPyqLKjNQR2IaAZM8coqORVdyVaC1U3eK3kYJ2
	 fprsqDLux068MbdldqnUUUCOClA1PerqGx+HH22KKaili6fe9/dTfYLmmeOLVbMPtPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=Rpi69KOE+RewZqGKWGe5fV1itNLcgLER2USO6GkvbTk=;
	b=etI54c/Fz8bU9VVq/NVN1FBKm5dTEoh3K6m5ccmFOUPbBXvS7u44lWdokwSpPszctw0T
	 FAuuIqKWI3sq86EuANPpxpSP9rTbKCJYtFi87rD2EPMMXBvFQRZgkWTxTbbmlI9P4hoAY
	 2E24j1cGnUgq3hrlECs2rGuptnTZpO87sVOOfG3e3a1Z/2fR0/DJjuloGyUWaoY+miG36
	 IYABKVaUe51IA0eyIP7nlwBo6+U2UeHFnl89Sq5Lnbq7ZtvpdSNIutv0jzYt4nKHGAEdE
	 K2QRn7svcUDUZx5xVCHyVxMIm0TGZ1xofJQc9s4fmV0igpm23NVPEC2eFCnWG2/FaDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wkCip4Oz;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD35860A2637
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD35860A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wkCip4Oz
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4a33359c1b3so845340f8f.3
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019395; x=1795624195; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rpi69KOE+RewZqGKWGe5fV1itNLcgLER2USO6GkvbTk=;
        b=wkCip4OzUWNZYLZ0v70NTtpvMUaclfhuWjrxWTLDEGCobEuISEM1r/1YXykE8OrNES
         sSdavPDScTpLIcsD42OOVDB8cBA/7n3a0ejFiNtH6Ox0hcrp0r4VRC+t9RqaxxYg0Emq
         jSqHByUX5gg+PCTLUQmXZp0Hcem1t/7WI5dAFC3KPqOUHPE6ZBUJ9AI3zLmVexSX3sYp
         NzzpfGaM2pY6RMKpRjJAWC5d3ESM2Ozxv4Jo/p9EKA7lW81Zcu5FJDnvs2lhXYx0Bhq5
         CLjSKrmZhexYRs8/Dk1HYu3cSv6M+uOSsWUfNMwBoOhQyE7UI0GZmke1n6O5v2HyLg5h
         smhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019395; x=1795624195;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rpi69KOE+RewZqGKWGe5fV1itNLcgLER2USO6GkvbTk=;
        b=Bv36Kp3HBUYukYHUvhl/5C41aSmdx6okzqfteoPXlWBgfEDwyLog80TY7fWKmWg16e
         dixVQqK8dy+YTEfiQ89NSDpVe3mZ9AQCYADmav+ykS/0/7ATCeWS9s+Fzanm3fYqhP09
         OT2VsQu4keHiieLxFO3pWg6YEUaVcfeU5uME3o8PbO49j+zr6k99WyKCjEZcZ9ftXDdk
         fy9Ow8v/uJRzrpH+4pSCPsf4QuTFjyZR37ai2bdeFfjO5ym9QiGjFqodmehrtL26Us0A
         Yga/C5APfqc17w9N73yHFB0nbXK6i5K2sMP07KvkLqqR8JNy9P3j6vxHesdvgvQgrgln
         Bwqw==
X-Gm-Message-State: APuU4Z9duPOkANdC/bweaUnrl2ZH3gUrK3bX3ssVymGINn7Kr8OFz36Y
	xVGPiyMpei0W30jH9UD9/nPFxu94uNEGuibDDa5cMFxCW5KwrmHRKv591spSpUV9y9w=
X-Gm-Gg: AZFdTZd5CYkUp0KhW4k9lsiGieBdWx2fW9OkY13+KWwOxmTwZtKJU7VKau5vPHQLrGD
	rXbOhYR2SKybmzYU/3rH4VTpdSphEttGM3VPlaQa6IGxkSD/20ZftSoq8af+lj6tWnMSWThcUGp
	rgiQfKak6FbHFr5Ef7UPQUxoMuIDqF9QRpvcgWsslGwVHacazs8MlWnewu1MjbvzAlBZ81b/aN8
	FiPPyqG26RucCxFZqn+3rqsgpy5QK2W34o1t06ale7bBQapqFeEBAWNHa6z7do/ia4V1J0jO/yk
	A3ntnUEqjw+dHC74dXX67W9AVB+Rf3awwv2SMcYCYIRiUtTy3VjAT7hVQ1AofYD9wnxci1/DpbD
	r5rjJIgOoLQUkobn1wUilQlMbwdzdY2pAmnYE6a1zTJq0sXzOjtpJv9W+FzH887c8SjQhuQUK8z
	HqC7Ycyq1H+Ai4GZYEZxhphr2n7QD+GHppYZBX61bTSwWpMHXqCYdejagu5QeWnUgC2BfgHDaBp
	IhEt7cv7jJMCE2nLAQP9zH4AxbCH++wQoCYIIJ0GYOM9m04cUZHNNVH38u2qdLWiZYL6l78hFge
	tlumJAEub6rdFgeEE8MSoSgux33smqSfFA==
X-Received: by 2002:a05:6000:1a8d:b0:493:c0a:507d with SMTP id ffacd0b85a97d-4a63648e24fmr6898857f8f.1.1795019395221;
        Wed, 18 Nov 2026 08:29:55 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:29:54 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:29 +0000
Subject: [PATCH 07/34] perf build-id: Cache the vDSO in build ID mmap mode
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
Message-Id: <20261118-james-coresight-jit-v1-7-dad4d90747f6@linaro.org>
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

Since --buildid-mmap became the default, perf record doesn't add the
vDSO to the build ID cache. Caching a DSO requires its build ID, but the
vDSO doesn't have a file so the kernel can't add one to its mmap event.
Build IDs that are missing from mmap events were previously read when
writing the build ID table to the header, but the table isn't written
in build ID mmap mode.

This breaks decoding of hardware trace through the vDSO after perf
inject -b. Inject adds a build ID for the vDSO, so perf script looks it
up in the build ID cache and can't find it:

  CS ETM Trace: Debug data not found for address 0xffff95edb310 in [vdso]

Fix it by reading the vDSO's build ID from perf's copy of the vDSO
before caching it.

Fixes: 53b00ff358dc ("perf record: Make --buildid-mmap the default")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/util/build-id.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 02233ef0eaff..cc813f421c9b 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -886,6 +886,18 @@ static int dso__cache_build_id(struct dso *dso, struct machine *machine,
 	char *allocated_name = NULL;
 	int ret = 0;
 
+	/*
+	 * The kernel can't add the vDSO's build ID to mmap events because it
+	 * doesn't have a file, so read it from the copy that perf made. That
+	 * copy is of the host's vDSO, so it can't be used for guests.
+	 */
+	if (is_vdso && machine__is_host(machine) && !dso__has_build_id(dso)) {
+		struct build_id bid = { .size = 0, };
+
+		if (filename__read_build_id(name, &bid) > 0)
+			dso__set_build_id(dso, &bid);
+	}
+
 	if (!dso__has_build_id(dso) || !dso__hit(dso))
 		return 0;
 

-- 
2.43.0

