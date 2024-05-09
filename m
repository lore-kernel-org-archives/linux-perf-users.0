Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC148BA27
	for <linux-perf-users@vger.kernel.org>; Thu,  9 May 2024 02:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715220935; cv=none; b=Xeg+yreA+fl+ROnIXO7i38JyXiSkqttUCgs+n1TmpBV+yCcdVw5QxQG6egBUGjvqagSm8ZBVtRTUmrLCdFhyOGwD+2Qc1FquRQbpYDHB/RMvkhul1mLx/17FxxjretGwU5qT4OBp1DdLt2YC1QUTnvmPuOVj+8F7ozsNrEVTBsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715220935; c=relaxed/simple;
	bh=Wf1EvEkDUHh/solrgXXsbkUrt+KqdOeMQ+M1GaAgAAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rSSnbSTsKbNCeGqaUfoL2EyRqJg89pbvXa5V5zIl/0ELaRL8iN7z3T0mwfPl0bHFxdSLGHnVUj8tWcibwJDO5sX0dozN1QkguXiY5nuBEWSGN/vK3FP4GN2KrCIkZDvS5lf6E8Qx7LQXCnThUEr3Svi/U0iGFukswrqZMzec3a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=KC9UcVFL; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KC9UcVFL"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso312825a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 08 May 2024 19:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715220933; x=1715825733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9fxIkAne6MLj2unx85v1dfJVqW67G69sWljeMKDpPwc=;
        b=KC9UcVFLdkZKODJ6p54VY6g4MHQhzjj/+c9eJqPnamMF+7gGJlUwxZ0d6otIDjbflK
         K6xIsXz/TJyeYL0wqS8Fblp9WkrQoWbQhO0JwGOuVE8Z55tAncwbxQRsFsJZdaDgxhah
         ZjXIzIySHCpL4k6JVb/KSweVMuwc0tZNy1tEFYjt8kvhwdMk4q2hjO8RgIJA1yN59r4h
         /ojFrxpW2qyytXlaZj8jIJ6sbXputPxTWRRZ0O3gXvEDRwD5qelZXXloGwdYbCskT3xU
         Ko/FpGHnmUbbpaVl4Z7KOEOVO+FuIGaDPCmbqXRSuZopl8gaWQpnsu9iVeAkD6U7fUsE
         53fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715220933; x=1715825733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fxIkAne6MLj2unx85v1dfJVqW67G69sWljeMKDpPwc=;
        b=nCZw+njEJVqEKKS5nSYZDFuWWCAaUYpea3mA3alp6ruy3LeWAEg2wRfVCtBcGmNmQc
         FN482rswf4Q8mbtWVHxBLGdqJvQc1IUquUyT5qe3lwi3EiaKCjGnbeIrG93LX/HgzmGM
         IP4FjgTo0oB2O+n2KwfqlLMBjeBBrSxAVlm42dIeQkKGnAAoeJCpIQvnlwBwCydd3NbZ
         Cr/7r66wAJR49ikDQkVrBL/9sUp94LCV+76iC8RaSKLsorrFWRkKBXvgH7fiFbhElnkD
         yrUWa/psYl3cOOrRfKhG7uvBas/Ht9lo7pkNxOyEUKSk8sVIZqv4LNh6v/FjMqbd9qrC
         4HxA==
X-Forwarded-Encrypted: i=1; AJvYcCWCmAsdpFcrAMTZq4Su+fQRnqjluIz/Ixck8scDSHOtSA1Rj+2PJ2HAvUQMEwnnnJ1S6lqZ+4fozNUQ58vw36Bm61dD3UKtHIzJeKYqbhVusw==
X-Gm-Message-State: AOJu0YzG14zABoPkDMkaDKPypJ64AWS6zZ7i0ugYFSW2d570fMRDtSVF
	woSIUIMxn33X59TpnrjZeNymORF2UeTEFSoJVVv+EhS78cdxQSR2loNlzZ/boUk=
X-Google-Smtp-Source: AGHT+IHZ9jRoKKp0h7NT5gHjkgyTEvRFuMix9kyTJj50uyJt2h4HmefYnbrdEjHmjyVE87F9L6RSOg==
X-Received: by 2002:a05:6a21:9988:b0:1af:d0bc:d144 with SMTP id adf61e73a8af0-1afd0bcd40bmr2031451637.53.1715220933069;
        Wed, 08 May 2024 19:15:33 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d176fsm2339115ad.58.2024.05.08.19.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 19:15:32 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH 0/7] perf vendor events riscv: Update SiFive CPU PMU events
Date: Wed,  8 May 2024 19:14:53 -0700
Message-ID: <20240509021531.680920-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series updates the PMU event JSON files to add support for newer
SiFive CPUs, including those used in the upcoming HiFive Premier P550
board. Since most changes are incremental, symbolic links are used when
a set of events is unchanged from the previous CPU series.


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
2.44.0

