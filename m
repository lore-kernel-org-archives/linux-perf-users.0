Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D79F72612
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 01:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760406560; cv=none; b=B8AYJ6WWhdyxvIr9eQJv212AdFQh4huI0I+P76mLisP/k+VqGi3JAkReGS+EPTiFzRH8LGF3hqoOyGdaoui54qF2EZcdI0V37cqJogOP4+Zc2876rTRmzBHvUR4eBr2GbUxVQM0AvRMzj6hCL/9eUNyT0QRHHDRxxUEgnTEvqg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760406560; c=relaxed/simple;
	bh=S9mB3m7QAB7n5Q++JS2mU6ur8NcHYw+2duPedcCjz88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hO3SCZJ6tPMOOXoKq9KDuXl7DI+BBBdpnm2bkZM8nUY5pa9T2Iu5+U19zvIJof7CEKnrhYzXwDwh3i/DpwKuOfLxHYyIr9dFhr0WSyzziiIc+YC97YlhQN476qPqLt2C6SfP553XG5M5fiBxBstXfN03rwPQjHHOYRlHI1RTp5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdafQ+/P; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdafQ+/P"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso1598828a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 18:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760406558; x=1761011358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S9mB3m7QAB7n5Q++JS2mU6ur8NcHYw+2duPedcCjz88=;
        b=kdafQ+/PBFy7behFEiE3wvf5prsgoahiziB6SdSAtisZlUqJd3wsgwDzaIMs/LU5Pi
         nIgpQ0G2lNQkowP7NKOM1hhuPSTBC1MJ++Jke2nCRG+NHu4/19n3gUfHcjGPVQ8zwFGc
         GsOOcBXTAt6LdBI2aiyNpKtE2SPvGtKBbN2TEQ5CooZc03w6v+MGua68Two9gWJVIMyR
         mmoIs3VZqzXk9zpfZoIXDtz0mG8Z7aZWFtUOGsYzTi7hiIvbkZJ+yvVl8vwpYMSEu8mg
         dfJRrZuY8Hvzy6HoTGzPNs/lRgsrHXfu07Gb5nuZ1fA9kTvpzTykyZU0vCGvrD9b7eUb
         4sCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760406558; x=1761011358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9mB3m7QAB7n5Q++JS2mU6ur8NcHYw+2duPedcCjz88=;
        b=AUPWLb0BlqgejQZTaiEaMVQ3rNPLxJZwZZDtM3jydKdbQSE2Qv7PoZePMavvyy3Me6
         bHbVBdwPV7VpRIvhs5hXB+o4nhmq+SxV5dULjyLv+33P3QwwucJyCOU9EATYwJ5O3+ix
         E6RELAmsDZwVB5P9B1pjCZzm7LhhfApvOZv4h5iGZ8G5GAEd6iigipUkpantdky7rkhY
         dnk4mp1BLPtFNYG2WFMV+f34o47xqFwIoCXRaRQOi71AHcGCZ7/JjrIJ+2jHAfPMoSFS
         ySWmMEhE1yiUDEs5FnsGy6sOFJW0FlevrcO1fqOzoXCatdyQ1JrFfpbmvgIYuhTxtGfX
         CtvQ==
X-Gm-Message-State: AOJu0Yz0sz0I9qhqYs/GMIHNhhYz+3mb3o2lXTIE8LH8w35lRPcn9PJQ
	6GkuNzqEsfo+Qc/CdSHjR+g6b6MHvZje70HEa637a8Ym1D+RnMavEv/L
X-Gm-Gg: ASbGncusnBolZKHrI1CE2vvFXPMbN2x1jBStD7fAFqd8jbANT8773DFjV5IpwzOHmbq
	2CXlztErVHQTpVXLLeATs1BdN4Dv4xlMxh4cxPoXsLqFjPJSftjLFHwRmQ5cAnQZSo33h+XdJlf
	Zm8wL/89HPyCyYCC9WNsHAh2EzaVzfx/exeKFs3rkNO8ln/33qH9cT8ldLCpQheKQ/QFN63Gb1Q
	eCSu+GussU/2hbVZv2IMGv2lMMVZSx5AVTRXKCE5YbYgCVnB/a0XEvZrs5pVJU+uwPNqB81hfpl
	CCaUq39HKYuGuxJAwEx8z3e5JjOHXP31RR1pAWL5L3g/xS2d4A/p1+Xk0LYY8QJ6JoYcxppYzIW
	hfHcKWcKqYV94jEuhB8ANAFykQA3cyXpW8fhKQzSJFRyXe3Y7++13OJ7Twt5lug==
X-Google-Smtp-Source: AGHT+IE8pZcQRgUaWvehyNj++AfZMd8qovR+xA7bP6PF5yqBYWdrBtBT+erT3EcXL6EsvnVpwit0kg==
X-Received: by 2002:a17:902:ce81:b0:250:b622:c750 with SMTP id d9443c01a7336-290272d7330mr316171655ad.27.1760406557845;
        Mon, 13 Oct 2025 18:49:17 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29034f082b7sm145291085ad.59.2025.10.13.18.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 18:49:17 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>,
	Eric Lin <eric.lin@sifive.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2] perf vendor events riscv: add T-HEAD C920V2 JSON support
Date: Tue, 14 Oct 2025 09:48:29 +0800
Message-ID: <20251014014830.613399-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

T-HEAD C920 has a V2 iteration, which supports Sscompmf. The V2
iteration supports the same perf events as V1.

Reuse T-HEAD c900-legacy JSON file for T-HEAD C920V2.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
Changes from v1:
1. Update comment and add missing CPU version.
---
 tools/perf/pmu-events/arch/riscv/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index 0a7e7dcc81be..d5eea7f9aa9a 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -20,5 +20,6 @@
 0x489-0x8000000000000008-0x[[:xdigit:]]+,v1,sifive/p550,core
 0x489-0x8000000000000[1-6]08-0x[9b][[:xdigit:]]+,v1,sifive/p650,core
 0x5b7-0x0-0x0,v1,thead/c900-legacy,core
+0x5b7-0x80000000090c0d00-0x2047000,v1,thead/c900-legacy,core
 0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
 0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
--
2.51.0

