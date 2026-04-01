Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760AE2D9ECA
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053571; cv=none; b=MAF7eubng5/mXQoZ/iDR8hl9qlEjStSYWiWVGkDWWyK7N5Jhd575heqlc8tYivLo2aXvcf4pTr20YDY1AmQGPbazQRrSQHfJyp0RLylLwwM3gdBNcnarKn+zZNV9sYJvX/nJWNfALtbxpiNrBxXTTfnUj0w+IZ2srGe9yawSV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053571; c=relaxed/simple;
	bh=rW4/L0mHrLgBtVCY8atSxB5Ghgc6erbxhKc1Rbu6NBw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hjA/7C3r7/V1TeuhuoHyQ3nh+DQmd0Uj9jktKYvFC0p4wqMBm2PM1ZJM9u/q8IUsmeQ2cZBvj5wukIL5Jo0oy5pYhDqfv29JyJnpdEGdz9G5IBKNUVWWgzT6tWkedeKdFu8gCl2KoBxfdJv8Y3tUR+32TuJPq+MtN9bdnRQ+1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CrRcHsN9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CrRcHsN9"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488895ad947so3094285e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775053569; x=1775658369; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Udgig4ZoLsgYEXfdhxnO9tijZ1Z50sbtiQsa0q8gYbA=;
        b=CrRcHsN9LhuTfBLuUNsJGX/9KKDKohI3zrwKBrHm36wvdEja3Se1pVThF9vmDZW1i2
         o6XiGmKMr/DbO8MeCEaPi/tQQYt6VSM8hEhDk6vVI14EyV8SLXG3bw30ahZl5mUl9oGx
         MtUODkbRcfiW0ave9QSemKpq4xoDdCOmK7t8GbFzHu86WFrl7WvOayB/r67rxQgx2vcO
         VLXcZA8MVDHV1TGJ9LHrWNTNxCsF68jzF2VPpEtFXldohl3KFX8e152gkkhScmB+JUk5
         sbYplFJSQWdknhpDP9RjLo62p/uqWpqsbFWeTGO6ym7a3Ub7fiSGiguAiMVIIRdNvrFV
         o2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053569; x=1775658369;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Udgig4ZoLsgYEXfdhxnO9tijZ1Z50sbtiQsa0q8gYbA=;
        b=EfQaiz7wpEVkFT517ziMV9o+qF7S0YHdK4M+tFGkgYnsKt/JyDLSawtSP8fyUwPAzS
         gLGEnOzmeS+AL5AUadJcfl0yrkJvH4KAkycK/aAeP+clJL6oVCm7uunqK05fkni/Rw6b
         G13crteT/uZTqqAzNGLHUI94zfT9Hf0JAHU3atMp1EidHtEfTjIStpgO92s/beYTZ8Bt
         pwJEF3za2HW/R6cTmnuZaA4qFgDk6qJ9k+YWr9fnnOPLttU8R0W4WrBEeck4ENbr3R9l
         zB4ZXEjfJShKKvPjb/IGggSk/3TYRArDzZv1S7JbREa6biiWUyGJKE5KfnwDxXcD13yg
         qe5w==
X-Forwarded-Encrypted: i=1; AJvYcCVGowoOvsbLCYHQnax7JUd7lRsyGh8uzMcTA9Peu1R/tuM85+EeYagNcVEJzCTnXMqMYI+FhwsPtdiK9jxGjLS4@vger.kernel.org
X-Gm-Message-State: AOJu0YxiVFzYfDj/76+/XntAVc7E9SpG8koRdgJgUBmpDwt7P6QHAQvo
	Gp1C1YnY4veDsDPQxV5Gq2QjXIpR2N7uAAnLRJSDj+k1R0xPtrtlonrEF6Nxn0BzmV8=
X-Gm-Gg: ATEYQzwvS43zcAU2kwverb8Pe8jHKzsbuzPgdmpFtKysXm0Ig91ON/2u5x4QKxkU+sD
	i773e/4VnDZQQ6RqI+AKhbB1x91AwKdi7WUaP9fCLF/mwPpJDGL74Vzjq9c1sSQYPmtB4po51Jf
	yNDnbklSmYJMXfUNYZkiO6htbCMNy17imRU9/yZOW8ZP7lCVa849lzs+31zZ8FdSNZhQc9OpH4N
	hwxveLAkxN26l979hYO7mKtsnUSj+qGkByNlEH4V3bzP5lTCK6eFi2PU87PltOgBouMSA0YuqHp
	vj4drCycU34qoPEu8CCwXsYXqBoQzxuzzavwZwsF7jD58a7a80NO7cQuDK+JusBKZNcWRbLXsuK
	iQ6fGVJbXofLWPpdmME1TYOpUWq4If9s39wHSNUWZBqcfqSUeHyxi19bnFHN2XO0OVfDa/2fW2v
	35gcfDabN/X05EejtvAsxXZV6JBN0umfFk
X-Received: by 2002:a05:600c:6986:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-48883595078mr63909095e9.20.1775053568664;
        Wed, 01 Apr 2026 07:26:08 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a63c9b1sm2305595e9.5.2026.04.01.07.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:26:08 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 0/4] perf arm_spe: Dump IMPDEF events
Date: Wed, 01 Apr 2026 15:25:48 +0100
Message-Id: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOwqzWkC/x2MzQqDQAwGX0VybsCfxdK+Sulh2XzRFNRlA0UQ3
 93F4zDMHOQoBqd3c1DB39y2tUL3aCjNcZ3AJpWpb/uxHYaOf3GBs+cqlixQFqRNwPIKQYNKUn1
 SrXOB2n6fP9/zvADz6bhjaQAAAA==
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

In the Arm SPE raw data dump, IMPDEF events aren't printed. Add the
ability to add names for some known events or print the raw event number
for unknown events.

For example:

  $ perf report -D

  ... ARM SPE data: size 0xd000 bytes
  00000000: b0 18 c6 32 80 00 80 ff a0  PC 0xff80008032c618 el1 ns=1
  00000009: 64 e7 42 00 00              CONTEXT 0x42e7 el1
  0000000e: 00 00 00 00 00              PAD
  00000013: 49 00                       LD GP-REG
  00000015: 52 16 10               	EV RETIRED L1D-ACCESS TLB-ACCESS

On N1 the event line becomes:

  00000015: 52 16 10                    EV RETIRED L1D-ACCESS TLB-ACCESS LATE-PREFETCH

Or on other cores it becomes:

  00000015: 52 16 10                    EV RETIRED L1D-ACCESS TLB-ACCESS IMPDEF:12

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (4):
      perf arm_spe: Make a function to get the MIDR
      perf arm_spe: Turn event name mappings into an array
      perf arm_spe: Decode Arm N1 IMPDEF events
      perf arm_spe: Print remaining IMPDEF event numbers

 tools/perf/util/arm-spe-decoder/Build              |   2 +
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 147 ++++++++++++++-------
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |   5 +-
 tools/perf/util/arm-spe.c                          |  49 ++++---
 4 files changed, 135 insertions(+), 68 deletions(-)
---
base-commit: 74e2dbe7be5037a5e5eed6bc1ad562747ac88566
change-id: 20260331-james-spe-impdef-decode-d944f4fdcff7

Best regards,
-- 
James Clark <james.clark@linaro.org>

