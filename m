Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019407;
	b=B+npBMIMUfNhh9vJocpH9xow9RXEwePQ7hfkFIL/60Qgi8rahpB86u4+Op+dXLJUSTQW
	 nOyGLgpyysnSNf0JcU55GbQjWUPulMGJR+lQRD7HBnlNy03x1FuztVN3Sy9wl4BaI0b9G
	 GuekgijdIwCb/M+XuOnPJg0t8xwzJQ4Tt1yF9pfTPKhm07dnXREImFOKqA5w6wgv3zI9s
	 I2IC4p/+UCY/Rcd+Fr3zktHhST5FkSZ0Rnm7vnKe7FOQ1/2irCOFPk1e8mdRivsaYJuij
	 JX7dwE/c0DKVHXf7SBhKCsC4l0I5Zh2rFlKlp4UqD+kmx4U4bdTc2GVWnWcpvPhFM7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=XqjkmMfgNZGBMzqUNuESUkbxBno+SUpnXC2EkRATNvQ=;
	b=lCsE9a8McJl5R5BstPjOMLN7IgVblCxe+AWJ9CMWlTxbkRKLNiOxGqV88tSLKm45QHAe
	 JRqoqrEqmLwbjdWxgCOzW/Zi4O3embk9YZq/N0wf+BthBMce8LPZbpqC/2vNF09f/eIAf
	 wF8ZEr7EN+p/rSkZ6061PySc3mTNUqNOxeOonTGudr0yq14VivVLV+qam4Z3Uz8lpC/F+
	 RdYF4X0hGpQhz26ZIF2Wlonj3qyckHY5fB25ZYKQIjCzRb6QaDYcPdc4Je3RGmxZJqDMt
	 7ONnYTIn85bilB49F9DzUT68o0FWFmSDo7/ia1I1NjKVTS/mgAJ8WOpsvc+vFijxL8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Vy+e7XXW;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3D560A2616
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD3D560A2616
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Vy+e7XXW
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so13012715e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019397; x=1795624197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XqjkmMfgNZGBMzqUNuESUkbxBno+SUpnXC2EkRATNvQ=;
        b=Vy+e7XXW0pN2gfvhsLmJ/6EuzVd4ve2EwwSC91+KhZzJzsm4PxbO/08l7QGjiF/2ao
         ZocZMbuwmKdgRp6WoTdNkKI5AXIvoxUowMT1iINq2Jz1REUPrPls+vBGd+pOBxprRupr
         CbbvlXvWFULM/HYU7uSAJ83oyGvA6ebgXFZ4aDRqlYlY1/9qrBmEyz3fBTGisfqSE0Bg
         dHiIPNHtHLg9lE91uruGqAdUlGDVy5UIq4HwvzEK+aSn0RwdIRQG6auA+Blyf/2bYUpt
         493T4nKuSB/xcwSc5g1vuWoO7s3+al3fR3ZHOja43O4nIQpUX9sI1ku0zFyOxjLgVGNC
         MlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019397; x=1795624197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XqjkmMfgNZGBMzqUNuESUkbxBno+SUpnXC2EkRATNvQ=;
        b=CjgADEkPlCsB/uhfG58vef6j7qNZN8Q3BahPr9HceNHefGS2WAzBBZ/viHbqSVIot0
         cqQwlK8XxoYWWBcRp/NU2n5vt6hsb0jjLhINgALzdfrC87J/j35Qf+0RGI8njgwYB7j5
         aUPg4LBLFghhHg6l90lX2vhPxujyG9QBUP9wzFmSd4/2k1p/y0X3QEzEmctmHhY9aBEY
         XApi/Z9aozVWUZlpapAj892ZDsplcnbG+1dMnDRY0r08XE5MYImOT8bCMHxfPLFBZW6I
         fONUgerTn3YYzl0QUMGggIi1VXRG6/B7t3CM0+pmtxr+t5i1cLZxmOAoDeGoaqMyPuHU
         EB5w==
X-Gm-Message-State: APuU4Z9NFdrMtBPKO5d3sQpDhwehu7DPPOKx9z2FqHBfO1IBU+gpWhW2
	zyN00y0sFDvu6xiYI99R9Hnkn71tnIB6jh5+246N0uj17SlytMKLeYyKiqADBamnihs=
X-Gm-Gg: AYBFou2mRB1BaZFyswRIuoycd1ZqOnK0qEMHB2x3qoMEMe7cA/yLathnSuUvtSTCNTv
	ACTCIrJ+Ndjq+nLipQ3cSN0RBGnuKN1jSTjxIXFGylK7/iUmYVy2Gj1yeVICQoSEm/leRWH7ybZ
	nkwMJNFWVbViRyBK7VMIpgCfoUNpSYAFELQIF/562fyORLv7dPwksrL3NbY51pf/XrH62MA2qC6
	+KozYmhIPU/XZDGflrY+eV8c0EncKd72Bwo0hWCv2lF+PyPili81tLohhdamPp8Qsd8yWIcwekt
	/vLdYpCEBUEB3p5ix7HeSdI9SmRrBB56ZZmMyB78d+ZGTTgv1STW5mW0liOnwCemMNY28oFfiTc
	tX8RFBQRS6u8lFc5hUiCeIIcbYUhtR6haHDk3res4VQqlXXHXBJh2LPkWaEd5SS0ltekgvA9P0L
	qr5HVgB11VyYcAqoQWfKQBfL4c/vY8sSheqCWnMMRdftGw8w/ooWvMMes6PRT9TWv4vfTgsJ7Mn
	lzG9xUB6tj4sbpL9efuHxgRndbNXAksmE6yL1TdrQ7NYR4GfreDiruuLhIJFlVSdPLA+BER9TUN
	+yqv/1BbkKLb/dLjSc7vOGtAeAWVzVvC
X-Received: by 2002:a05:600c:83ca:b0:4bb:60b1:4409 with SMTP id 5b1f17b1804b1-4bb7da26fb7mr62550495e9.19.1795019397271;
        Wed, 18 Nov 2026 08:29:57 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:29:56 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 18 Nov 2026 16:29:31 +0000
Subject: [PATCH 09/34] perf cs-etm: arm-spe: Report error if default clock
 isn't used
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
Message-Id: <20261118-james-coresight-jit-v1-9-dad4d90747f6@linaro.org>
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

Coresight already reported an error if a different clock was used, but
this also applies to SPE so add the same error there.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/arch/arm/util/cs-etm.c    | 2 +-
 tools/perf/arch/arm64/util/arm-spe.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 809da6f1a892..5a64c17cf254 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -365,7 +365,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 		return ret;
 
 	if (opts->use_clockid) {
-		pr_err("Cannot use clockid (-k option) with %s\n",
+		pr_err("Cannot use clockid (-k option) with %s, can only correlate samples with the default clock.\n",
 		       CORESIGHT_ETM_PMU_NAME);
 		return -EINVAL;
 	}
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 53899c7de846..834419f04617 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -416,6 +416,12 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 				       evsel->pmu->name);
 				return -EINVAL;
 			}
+
+			if (opts->use_clockid) {
+				pr_err("Cannot use clockid (-k option) with %s, can only correlate samples with the default clock.\n",
+				       evsel->pmu->name);
+				return -EINVAL;
+			}
 		}
 	}
 

-- 
2.43.0

