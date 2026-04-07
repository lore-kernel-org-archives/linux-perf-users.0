Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767A73AE6F2
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Apr 2026 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570756; cv=none; b=OI2ADSvDOJ/6xZv6FDgPJKk2k+5Nxq01VQUPYlXDhZzbK7RFZPTbUHbEj0Zznovhw9BXqsptdy1QV5w2ld3vAnvPNJVJ0UjZSQYAzshH9r77fqj1WX5Pe6bMbh/6/0jXKrsyT3f/cR+lXGh+oeEQgpQCN4nxoWcsDoJ2z6heY+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570756; c=relaxed/simple;
	bh=RRjuRk6b2bjMAm+aczxT9dOHtZw8COA5gAq/N1ANU7c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZdvT/3vud+Vcy0Ucl6pnL0i95msecK0gQYIFm2L1S1QprhC5kTvW9NC3sOWlvpKZZmfNp6nEVS89wx82V75bG4StqM8oJMFjrHodmO6AP3PPlWtvSNhAGittOCOtYEwp6H9JgJytTfxUFmpXk/aIqV65RBzzUvb6CGUPlXn0G+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ISG0JWhF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ISG0JWhF"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b983bb07eso2957406f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Apr 2026 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775570753; x=1776175553; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X/r/MGY53zMFfOMSK7WGpq8A1pzaXpaNozArFN59i/g=;
        b=ISG0JWhF2dLGJGA8NBXI797imP8Epxmpvm2yjv2AqmAKSd9Lx8L2RrNJg7E0wktQmz
         NdTHIEv5QCapXYyBl94Ecme+i0Sf2eHXbfF5YaR+J80YGftpGPL6jvyCmCIehABLG1af
         +0/Ktp0WtbqvUtvUIgC3KEn9thn0oe5FG8k0sMjQIRxvp/uoPKdL3++1rZzv9rud0pBx
         ApYGBWck3aJBDi/PnSDtgyStbyIH1zJVa29h1WvqBxhtL/K9OHxllh8aEL2G46LdSBzK
         XPxTj2VOKvhI5JbBToXL5ZNvkCbL2x9G/h4i6SC39feDSEBSfXxEv49A0/XWpmDfxCvK
         0rSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775570753; x=1776175553;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/r/MGY53zMFfOMSK7WGpq8A1pzaXpaNozArFN59i/g=;
        b=oQZ2h0FplLtZuvPaonvBwWmkkUAreRzj0s3fC853tYV65VhpLHcx8I5PEXzivqKHLL
         l5v1+l/5D188biU4/uDlrDHHSm7GyBM6Cq+hgveBhXxIj33wtWU7My6cz7Lebee6Dooy
         pxjieADf/rVbDOSlR1ueoazGu97XYmcrE3aAbAEs2Xf3sMDeJquBBw14YuLv16lQr66g
         DEGFG3mPrD50ZrEoJokpoaAMzrEPRV6djYC5zRxZJmK4zfRgeHn8RX2Gy9woANNZDizw
         g0VP1wMYPfh9Sb9/3zwCJ+lC8Ob1nneiBH+KL0WsL7IbtNs4TmT8d06DBVeHcuRrncaO
         qjLg==
X-Forwarded-Encrypted: i=1; AJvYcCUiC8JAV8OXVLGrWyQXv2Qto6cCtjgtpQHPs5F0R2eUVB1VlBMegCOsNUCZId1qUpa9dsHZnTBh9hou+SFKw7+u@vger.kernel.org
X-Gm-Message-State: AOJu0YzM/QbwsvWwpL6wKyuLdMx4HtCocSBZefjSx627JvE1Hft3L+pE
	ZPQFcpq3ZaTUpduB8D6vFThGbStImAyWatoUnHCIbfF/gTLin2QcI7zaL2AZ6bUh10s=
X-Gm-Gg: AeBDiev1hxu+zdtVifFD0aD938cG+cOvVDR+VUeSL7Iw7SsnNpmgaYZt9lxYNHt8S9i
	HtdrQrfAGiCUeL+GzBtm/s7KKEHGcAeVl7XJsO2D1S5OZc+9ON2HhTQyV9eQUQ8IT4+sGYcZ6Nb
	lXauyn0+L3RciHT017CQ9batKaYqgjNUW0QDWNmA5Wo1tEOF2rUvwTprX21ln00E7K7VD+v9iyK
	SlpYzrG0YkvBKmtr/Bj7ZbZxn9dj+Y8/6M3GhYt+cLEiI3tq0BdL79oL2Xa3KJ7BEAa80uJz7cW
	xUZcZaVmB6KubIM+r4LlVDj/C//WhLnT5skDndXNhmjRzlVgg2L2YQ4iXa9pWYxXkjXE+2ITSwS
	ZD50Q903P5EjeqAmnJlBnVSWDMNmvJOy3J9PS5GM2IW3B2lenpC0FxspjkOAkREM094b6MqVE+E
	XXBRYKnJD+gC+9ntXNin4B/0kY5jsKa+qn
X-Received: by 2002:a05:600c:348d:b0:488:be21:54b9 with SMTP id 5b1f17b1804b1-488be2155c0mr42030555e9.8.1775570752688;
        Tue, 07 Apr 2026 07:05:52 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e822227sm626876145e9.4.2026.04.07.07.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:05:52 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v2 0/6] perf arm_spe: Dump IMPDEF events
Date: Tue, 07 Apr 2026 15:05:14 +0100
Message-Id: <20260407-james-spe-impdef-decode-v2-0-55d3ef997c48@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABoP1WkC/3WNwQrCMBBEf6Xs2ZU0DRY9+R/SQ8hu2hWblESKU
 vLvxnr2+GaYNxtkTsIZLs0GiVfJEkMFfWjATTaMjEKVQSt9Ul3X4t3OnDEvtZgXYo/ELhIjnY3
 xxpPzvoe6XhJ7ee3m21B5kvyM6b0fre03/TmN+u9cW1RoSVHXa6e1cteHBJviMaYRhlLKB12kc
 VC/AAAA
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Al Grant <al.grant@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>
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
base-commit: 74e2dbe7be5037a5e5eed6bc1ad562747ac88566
change-id: 20260331-james-spe-impdef-decode-d944f4fdcff7

Best regards,
-- 
James Clark <james.clark@linaro.org>

