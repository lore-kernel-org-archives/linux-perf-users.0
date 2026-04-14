Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DC839657D
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164775; cv=none; b=oq9wXZt2AKqP9CjnckLtQG4q84uiAcwPlnTegDJTqdJ49h5tKwJjeEKups+xGrD+/WXI0BLvaSw2DmspbmrGbC4EHt81YpyVaU8gt08y+aqYiFJD+61vDS66TUM790GfsFeReBh/ukLeaN4LglAVqqV5mPj87VaqbVWykohKaP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164775; c=relaxed/simple;
	bh=hOBC+CuCcisR9qG9510EKdQbR2McX0QB3qVFv5uO/vw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=muBp4XHKO9BzEji+u+LLdrSOHko94++r0DVCeifjsi4DWmv0FL9a/VjHUoBJer8TpIhlmKJ8ENt3zfctxN1afPFghwMo8CB+dYpjGv8JFB4f4fjNPSEikBlGfQeomTiqfsgFTZnFcfPa/JH1VFieaum0ArWxlj1ynivOyMdI7V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HdkTImn5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HdkTImn5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso51448215e9.3
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 04:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776164773; x=1776769573; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/UlFbfy1tsVpqkvx1d3PVwDBlDWdNrEuOEoNe4Rz2eg=;
        b=HdkTImn5gKznMopjGmbpoSEtfSuO1WIDAh08MSbUl7zvvblCMUUJq9K9CnGgUMMNtP
         AdqfPKNLmwEfUUzxzqrgmmpTbuVJqEAT8I7lbHlw7XyBGuDGj0tzoYbvihh93tdsHNQd
         yOYcS7KtA+Kl45ToZttwbPRBuUyELOVAXbsBh3YCO//zEcNdmoAYjO0pPdgn56tn1sU7
         rFvRz2tqvvNnAom6VOPJb1FusrMQMAVnEDA8mBQxkgS4tW57tNAXRaLpO/eyVkJ/hFzu
         oWhb39T5eZoHtB2VYqJR0DbXngPS7FTXhS6/84cQTPEWRxV+d9rT1e3NjONQ6yBVAysF
         zgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776164773; x=1776769573;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UlFbfy1tsVpqkvx1d3PVwDBlDWdNrEuOEoNe4Rz2eg=;
        b=lSZmdEYoyRqpXMISXKlGcnrMsohiWdShjxTXo3n9bAlPGT90KwoHfghx6qLgJPLhjl
         8ygVdjdGlKZPlASvWtfLJPky1MBRrX7GdE+Y/GqMNfNZ/chUdUNpYiu4bXBGiTJ0mzy1
         lBZLvygsSQUVuxKMMT0Y7spHqTAGdaJAJoG74h9F2/c+GTxq5QdkeN0QCikorVC/oZYn
         kZBmxbvuhjx7Jq2fo3jdEyWhCE64qTi6MeHMc4FOzHodjrpkyqs7GjxmBPwfTn0XY2IO
         PGtiDhqip3aj8nxPNmmwSBO1261J6mJeozAdIr+3Qtemkft3IY7fT7znXPRWoffJ/aTb
         v+BQ==
X-Forwarded-Encrypted: i=1; AFNElJ94gqDKv4yU7EP9zwgfSHpHRgczY1TwhquHUe8lnE/9lsltxJAyS+B4EyQKGMLVd96Lf+f7TajQ8+v9RvB2V2F2@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5mvESrSTRhki8T9zOBJnlVoSo6pTAgjsKoRnEXsdwAIMxGI3F
	8I26CTwWVeAGBMfaXh94BS5l/88g5A/l8P/O4BJZsBGmlBxLkXZaziURV+/gs6EyZtj7C6Hza5j
	o9+Nunfw=
X-Gm-Gg: AeBDieuVMbn9yW+5NTLWv7j+kJEJyx1RCXrgCXWKzWI+fxbP1nBVPfIM0uf7PtZC3Uy
	lUcvdSHNv/lo5iJCTbNtyehw0ccqYaai8H46EgZ4L/aipU/yvzf5kAzrMV6EOx/OI7Slmp1wkq/
	e60mn8NMsyXaaMvYevN0+iuxhBv0jjx+XvRio7vsfXin29gKAc4HYVZ7ea/4On4+0wd2L/7yN98
	39Y+lKRg2Er4XHMjpVEsJxeKiG5EbtZzwOMNGuS94TdTWIhgfvk5dwB1yFXEmJ+wRVzYkiUvMk+
	uUsYEmGOTlbpycd7pTQfFgoYW/T4Bs0LQgBoMHf3/UrB3lrnVj65yUDdgvUljY78tmb+dsF2P5w
	UigSdwD5z5hIWcnuDwBSILwOXXtXswELc7j8nsLj+jNe0BVmqhmW407puY+5FAnqZ3IVV0noaqr
	L+V0y7A4S5aLMK8UM9V9EzA73Bsxj4zPiZpgQvggM9IA==
X-Received: by 2002:a05:600c:628b:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-488d68603ffmr214529015e9.22.1776164772573;
        Tue, 14 Apr 2026 04:06:12 -0700 (PDT)
Received: from e133063.arm.com ([213.137.22.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d9dd86sm183254655e9.4.2026.04.14.04.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 04:06:09 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v3 0/6] perf arm_spe: Dump IMPDEF events
Date: Tue, 14 Apr 2026 12:04:46 +0100
Message-Id: <20260414-james-spe-impdef-decode-v3-0-63baf9c893b1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE4f3mkC/3XNwQ7CIAyA4VdZOIthhYnz5HsYD4SWDaNjAUM0y
 95dNi962PFv068TSxQ9JXaqJhYp++TDUELuKmZ7M3TEPZZmIOAgpKz5zTwo8TSWxWNEchzJBiS
 OrVJOObTOaVaux0jOv1b5ci3d+/QM8b0+yvUy/ZpKbJu55oIbFCg1WABhz3c/mBj2IXZsQTP8Q
 nobggI1DUpybautOv5B8zx/AP+fj8AIAQAA
X-Change-ID: 20260331-james-spe-impdef-decode-d944f4fdcff7
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>, Al Grant <al.grant@arm.com>
X-Mailer: b4 0.14.2

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
Changes in v3:
- Revert for_each_set_bit() back to a loop with BIT_ULL to fix both 32
  bit builds and decoding on big endian machines.
- Link to v2: https://lore.kernel.org/r/20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org

Changes in v2:
- Put MIDR in arm_spe_pkt (Leo)
- Use for_each_set_bit() (Leo)
- Use BIT_ULL() to fix 32bit builds (Ian)
- Don't call strtol() with NULL (Ian)
- Link to v1: https://lore.kernel.org/r/20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org

---
James Clark (6):
      perf arm_spe: Make a function to get the MIDR
      perf arm_spe: Handle missing CPU IDs
      perf arm_spe: Store MIDR in arm_spe_pkt
      perf arm_spe: Turn event name mappings into an array
      perf arm_spe: Decode Arm N1 IMPDEF events
      perf arm_spe: Print remaining IMPDEF event numbers

 tools/perf/util/arm-spe-decoder/Build              |   2 +
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  |  17 ++-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |   3 +-
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 144 ++++++++++++++-------
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |   5 +-
 tools/perf/util/arm-spe.c                          |  62 ++++++---
 6 files changed, 158 insertions(+), 75 deletions(-)
---
base-commit: 4e03d6494f9504f8af46ba68a2a8b6877c196789
change-id: 20260331-james-spe-impdef-decode-d944f4fdcff7

Best regards,
-- 
James Clark <james.clark@linaro.org>

