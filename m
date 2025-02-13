Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0798205E3B
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 22:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739484226; cv=none; b=e9m3PlSVf6U60qaeMgF23JLNhwXNiSVex9j3jW+gHkrrji2Ce272KYx3CpvrZlqeiHsM9n5Y6JMbmXhiqdEOSOFYnPuc0kYYMtqGjRIv0+MfaB8MmyhXEjvDOIsH+TTiCFu3KSJsBKf+z4VmpvhUN/PdjossTKFJb1j43Okfjb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739484226; c=relaxed/simple;
	bh=vRm1GqPMyqXA4pzClKC7bvwwNmM1WifeOw0DDoJQWxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F4qrSoSCrnw2FhVSFhDEgsCH1oF8jQUuVjBkZDtgoL5psHrlJyoQOwIeqbKkpPksYUWq9bMpd6lJYZvDxEVGMJmvC4Dwe6dYjBs43sQxUkG3lixGmL+kvmS+wRjmxLbGjf11f1lhzPpehUnjVteZhi9FtWsiM5NLG6ZZkcgJBec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mKZSZQHY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mKZSZQHY"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fc0026eb79so2562503a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 14:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1739484224; x=1740089024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vofSNuCMlReC+WuFTXGYAG+iOC4hNVftxe7EdwNqb5U=;
        b=mKZSZQHYlozsiTZI+eZ2aZ9RN+TbJcsjaUfm7VZ3EPztIaJa8xcuNrBAu+K6JCjStr
         NhMVjDIxXlx8Kr65ANodrFcnY0KeEF2X2uXuTZAs4z9OCk9iGl85RbucbEpxmObyIPp/
         FtgA9yusEAv26k4XtiZqEO+6VYJoRITx6RF5hfb4nholpfgcFDtxApTKcQo9s1mQvjRu
         XrlfRYpJgdes+1japH60Mgb2DgCCvRu8L1PnoUHaqq7CYriijXH8yoFX9cxWYfeNiCFX
         B7T9F0WCiuyUhrJk+RFFvDxIe+I/1cq4eESLJWtJKxAt3W4F8z69rywNHFhG9Um/EOHs
         SqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739484224; x=1740089024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vofSNuCMlReC+WuFTXGYAG+iOC4hNVftxe7EdwNqb5U=;
        b=k+fKUABNH+mvOT85+Webw2X4+LOGAVG7el1wTRCFRSAr8rdpQ1qHnN8X+Z0xicyw9v
         hbunnAs0pEVvKkj+P2JBpD+RDwb9TW4jEy9Dwgml8303tsKChOrPsmhSpwdQJbrfqC2Y
         4sbBYU0Hxh5NdK7eEhh9TUH33hB3n0lRFdUp36KPh8CeVoj7yIPywryep6H+DwrsWizE
         yfwPT3A6rfjCYJgfEBI0Kqm4OZc5k4W/Kz6NVVz74gOhDXF/SfeDf1xDOq9JkfDQIfiW
         Kbqfa5xjqh+s1DWWIrrrcLmIjPTHa2Ct8qH8eUZM4pflk8V1hiSEteM/wpW/TO/htiVl
         HGmA==
X-Forwarded-Encrypted: i=1; AJvYcCVTMScb09b/GliB8GoBtlmOS5YuYKFv0SQIIagI87JHvzdKpuoHiQtNvW9fsr0YPY/40jz25p5M3dic7/Oeo8s+@vger.kernel.org
X-Gm-Message-State: AOJu0YzIzg6DS+VPjcuvvRpIEUNPoXShIE3Ofc7wgqMmEOi5+up+GIeg
	mWkXijkf6o8sB14h1SoiTDJdGrICg+leK6cRdYTYfqWga24gB51gwC4pg9u8BRA=
X-Gm-Gg: ASbGncsmvVB8y1lKpi6Y7nGFQCTyjdfrA9FDpZ1wiVFt1e+cS+gvkPxEVmbUdnJ2XxT
	SlbiXBMrQj6aKnibBdyV2nCGh1hRQug8nYWVTW5askRdYp7nyal496ZJQjqNJArRqJRaf3WDcL8
	1r1lc+oTVIzju9nR7ZeCRdQeod8YBpsqv7EU0GEBLbesB6n8afMXgn2t7eYlXbmTisMLxrwhRG2
	0r3olzTmeO1V9ZV7X4chCbGmBqqWeO40fQYL3IhH9jeLTATDIyc73+2kRuUAfx8G5elZHfpcCbD
	fBpyPEPAIZudLKRL+SLgJ82nnSSVBgL3ZYtbRg==
X-Google-Smtp-Source: AGHT+IHZZb2Jta84jO1YUZkaqS3bvyvNnQldZh8oh2u99VvWuVBNfNp7QsimOh8/7XV9ie22K9NXig==
X-Received: by 2002:a05:6a00:3d46:b0:72f:f872:30a7 with SMTP id d2e1a72fcca58-7322c37d9b1mr13653146b3a.6.1739484224011;
        Thu, 13 Feb 2025 14:03:44 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e438sm1847491b3a.94.2025.02.13.14.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 14:03:43 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [RESEND PATCH 0/7] perf vendor events riscv: Update SiFive CPU PMU events
Date: Wed, 12 Feb 2025 17:21:33 -0800
Message-ID: <20250213220341.3215660-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series updates the PMU event JSON files to add support for newer
SiFive CPUs, including those used in the HiFive Premier P550 board.
Since most changes are incremental, symbolic links are used when a set
of events is unchanged from the previous CPU series.

I originally sent this series about a year ago[1], but received no
feedback. The P550 board is now available (and I have tested this series
on it), so it would be good to get perf support for it upstream.

[1]: https://lore.kernel.org/linux-perf-users/20240509021531.680920-1-samuel.holland@sifive.com/


Eric Lin (5):
  perf vendor events riscv: Update SiFive Bullet events
  perf vendor events riscv: Add SiFive Bullet version 0x07 events
  perf vendor events riscv: Add SiFive Bullet version 0x0d events
  perf vendor events riscv: Add SiFive P550 events
  perf vendor events riscv: Add SiFive P650 events

Samuel Holland (2):
  perf vendor events riscv: Rename U74 to Bullet
  perf vendor events riscv: Remove leading zeroes

 tools/perf/pmu-events/arch/riscv/mapfile.csv  |  6 +-
 .../cycle-and-instruction-count.json          | 12 +++
 .../arch/riscv/sifive/bullet-07/firmware.json |  1 +
 .../riscv/sifive/bullet-07/instruction.json   |  1 +
 .../arch/riscv/sifive/bullet-07/memory.json   |  1 +
 .../riscv/sifive/bullet-07/microarch.json     | 62 +++++++++++++
 .../riscv/sifive/bullet-07/watchpoint.json    | 42 +++++++++
 .../cycle-and-instruction-count.json          |  1 +
 .../arch/riscv/sifive/bullet-0d/firmware.json |  1 +
 .../riscv/sifive/bullet-0d/instruction.json   |  1 +
 .../arch/riscv/sifive/bullet-0d/memory.json   |  1 +
 .../riscv/sifive/bullet-0d/microarch.json     | 72 +++++++++++++++
 .../riscv/sifive/bullet-0d/watchpoint.json    |  1 +
 .../sifive/{u74 => bullet}/firmware.json      |  0
 .../arch/riscv/sifive/bullet/instruction.json | 92 +++++++++++++++++++
 .../arch/riscv/sifive/bullet/memory.json      | 32 +++++++
 .../arch/riscv/sifive/bullet/microarch.json   | 57 ++++++++++++
 .../arch/riscv/sifive/p550/firmware.json      |  1 +
 .../arch/riscv/sifive/p550/instruction.json   |  1 +
 .../arch/riscv/sifive/p550/memory.json        | 47 ++++++++++
 .../arch/riscv/sifive/p550/microarch.json     |  1 +
 .../p650/cycle-and-instruction-count.json     |  1 +
 .../arch/riscv/sifive/p650/firmware.json      |  1 +
 .../arch/riscv/sifive/p650/instruction.json   |  1 +
 .../arch/riscv/sifive/p650/memory.json        | 57 ++++++++++++
 .../arch/riscv/sifive/p650/microarch.json     | 62 +++++++++++++
 .../arch/riscv/sifive/p650/watchpoint.json    |  1 +
 .../arch/riscv/sifive/u74/instructions.json   | 92 -------------------
 .../arch/riscv/sifive/u74/memory.json         | 32 -------
 .../arch/riscv/sifive/u74/microarch.json      | 57 ------------
 30 files changed, 555 insertions(+), 182 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/cycle-and-instruction-count.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/firmware.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/instruction.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/microarch.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-07/watchpoint.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/cycle-and-instruction-count.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/firmware.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/instruction.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/microarch.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/bullet-0d/watchpoint.json
 rename tools/perf/pmu-events/arch/riscv/sifive/{u74 => bullet}/firmware.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/bullet/microarch.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/firmware.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p550/memory.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p550/microarch.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/cycle-and-instruction-count.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/firmware.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p650/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/sifive/p650/microarch.json
 create mode 120000 tools/perf/pmu-events/arch/riscv/sifive/p650/watchpoint.json
 delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/instructions.json
 delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/memory.json
 delete mode 100644 tools/perf/pmu-events/arch/riscv/sifive/u74/microarch.json

-- 
2.47.0

