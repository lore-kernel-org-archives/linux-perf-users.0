Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531E526B0A5
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459783; cv=none; b=ko11Bk0xlg5Qe0j6n1SN20LseCo/prm7dg+xRg7FL7y6smoHfvJfq5ES4Eu67t0gCV7CBiCOPIxpx7cAaYiLbXmCXD1qaIm5jk3FDKQtBQBQSufZadQlHiKYZyXaABN+4gyV5RAqBYLrkCWfPgAc1RjcjVeZFL3RSlOKOovNHEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459783; c=relaxed/simple;
	bh=XYQd5FgO+f4/zoT+BPLqYw+L6vd9M1g+EqKBL3Ufp3k=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=BrwZE5Cz+L0nvdWB5ftVnD4yjg5xz1g8JLhtVr6f4TGrjDG49R6emaE7/fcoPGiQVAsEaQjFfwXZmMkTutY5eaTM7ak5u8oKh39wmPDPwaxe4tIYNGWHw4JxV8M322NRu/brTDpu5m9uMhsSM/gwWVc3j7ptou/EpWiPux4w12s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=J5FYU31/; arc=none smtp.client-ip=203.205.221.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="J5FYU31/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739459477; bh=4elqHb9iSCoJx1TP7SHQuAGSp14JnKwx+dF2NU3w8co=;
	h=From:To:Cc:Subject:Date;
	b=J5FYU31/k8U9HksdCZiTfbaoCLBmHIgmdx+1am665xye2nDg6CRGDZ1kMs5B6tApI
	 kWxstS1eYZ+GeMTUfJCMwMU6vXU8eXwQnL9u38ZtCOF0zr2EbQZrweFKGxRXLcosTf
	 3OxRsqZf4TcGj87W8KcGwHyTfkgOnKSkg1Nqw4yc=
Received: from cyy-pc.lan ([240e:379:2251:3600:f57b:26f9:9718:486c])
	by newxmesmtplogicsvrszc11-0.qq.com (NewEsmtp) with SMTP
	id 2CB36647; Thu, 13 Feb 2025 23:11:11 +0800
X-QQ-mid: xmsmtpt1739459471t74z68yp3
Message-ID: <tencent_5360DA048EE5B8CF3104213F8D037C698208@qq.com>
X-QQ-XMAILINFO: NssJ/YX50roa03kn8l6aANiOT4FVy7HIrcyHzV6EHxPrV4028EaBSbBdbE9v/S
	 uswOi6tq88MyI7hKp5xp89/LJoa29iBHePzM5FdE9193G1OyTMeAQoIGhXMN4HA4mkqTWWyjnP+F
	 4kCnnar5CZBfHNBy4po90hUxq7bmChnUshK4J9kNbr/FEllC7hkSWGUo+GXwLpmKT9CGYIOt2MZK
	 2uOdmd1BdEBdT8EVPyk3D1YH33tlyo054vKn0LhvLkuEGgUYOw89sqQze7mwkmBcw6Zstpdgf2tW
	 7Avnvoc++vMRNe9iBye4x36Oyh2JoDzWtVXBYLSyp5kbVmrR6TBDII2DNqfclAIkLYx20hkmPCNq
	 LBhIHF3D9CL7vifdmuehd6WvZsOaikR47Z/ChtbO9H/ZVp4LPkzt4WZpgCYl7UhmxWSjFbl3JtWP
	 7emjDsSzS5MzW63C2Jfjwz2v/VJkag88U6hwx5ZUcNhqjfHniyv0Y8NGPfmWfN1nsZ6FNLVWmt1R
	 TSWAvW71E/zvqtQ0XpkcJVgFQNSe0os1XKG0tUdqAfGfJcdRqCRgufBmbUvE4oqYjy2B6tJDG6zW
	 8w+q54MKoNQB2SvMb9w/q3dVlDVvUROmxYIBvCFzEqB4gM7NE5AgVyBeRV1CaXSvpeOAs8GaSHIq
	 LcVurJU8g/NPJawA4+C0eUksMIX8RoyG8cWJ1YusOioEnHogBcPXo8sP3q7VxfBCx2vwTftRSrGU
	 iKq/tnHdpvNveKEVvbF/lwISJT7NK67Qcq8j7ungG+ejV6eFg2qQylhqEuQZd8zJ3n0CvlnkC0Lk
	 G1qrH4B8m42VyEhLgD3DQGutZqWIbIKpMLy44whsDkPrORX2oU7AczhIQy4iXNJoDH/fK0RTbTGn
	 Q1brjCAnnChSTmWiRrHVYyl1ensnArbkdy6JZwNl5HL9er8IeFZHz+k9jfPibOPoYtiDrfvuIVHN
	 gA0Hink6KsPjC91jHszc5iiFt1IBLynm3g3u+p8gtshVLc+q7UIifDReSUwpC1SnpkZ0+dtubSs9
	 EWoFPUjA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-perf-users@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Yoshihiro Furudera <fj5100bi@fujitsu.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH 0/2] perf vendor events arm64: Add A720/A520 events/metrics
Date: Thu, 13 Feb 2025 23:11:01 +0800
X-OQ-MSGID: <20250213151101.186593-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds the perf JSON files for the Cortex-A720 and Cortex-A520
processors. Some events have been tested on Raxda Orion 6 with Cix P1 SoC
(8xA720 + 4xA520) running mainline Kernel with ACPI mode.

Yangyu Chen (2):
  perf vendor events arm64: Add Cortex-A720 events/metrics
  perf vendor events arm64: Add Cortex-A520 events/metrics

 .../arch/arm64/arm/cortex-a520/bus.json       |  26 ++
 .../arch/arm64/arm/cortex-a520/exception.json |  18 +
 .../arm64/arm/cortex-a520/fp_operation.json   |  14 +
 .../arch/arm64/arm/cortex-a520/general.json   |   6 +
 .../arch/arm64/arm/cortex-a520/l1d_cache.json |  50 ++
 .../arch/arm64/arm/cortex-a520/l1i_cache.json |  14 +
 .../arch/arm64/arm/cortex-a520/l2_cache.json  |  46 ++
 .../arch/arm64/arm/cortex-a520/l3_cache.json  |  21 +
 .../arch/arm64/arm/cortex-a520/ll_cache.json  |  10 +
 .../arch/arm64/arm/cortex-a520/memory.json    |  58 +++
 .../arch/arm64/arm/cortex-a520/metrics.json   | 373 +++++++++++++++
 .../arch/arm64/arm/cortex-a520/pmu.json       |   8 +
 .../arch/arm64/arm/cortex-a520/retired.json   |  90 ++++
 .../arm64/arm/cortex-a520/spec_operation.json |  70 +++
 .../arch/arm64/arm/cortex-a520/stall.json     |  82 ++++
 .../arch/arm64/arm/cortex-a520/sve.json       |  22 +
 .../arch/arm64/arm/cortex-a520/tlb.json       |  78 ++++
 .../arch/arm64/arm/cortex-a520/trace.json     |  32 ++
 .../arch/arm64/arm/cortex-a720/bus.json       |  18 +
 .../arch/arm64/arm/cortex-a720/exception.json |  62 +++
 .../arm64/arm/cortex-a720/fp_operation.json   |  22 +
 .../arch/arm64/arm/cortex-a720/general.json   |  10 +
 .../arch/arm64/arm/cortex-a720/l1d_cache.json |  50 ++
 .../arch/arm64/arm/cortex-a720/l1i_cache.json |  14 +
 .../arch/arm64/arm/cortex-a720/l2_cache.json  |  62 +++
 .../arch/arm64/arm/cortex-a720/l3_cache.json  |  22 +
 .../arch/arm64/arm/cortex-a720/ll_cache.json  |  10 +
 .../arch/arm64/arm/cortex-a720/memory.json    |  54 +++
 .../arch/arm64/arm/cortex-a720/metrics.json   | 436 ++++++++++++++++++
 .../arch/arm64/arm/cortex-a720/pmu.json       |   8 +
 .../arch/arm64/arm/cortex-a720/retired.json   |  90 ++++
 .../arch/arm64/arm/cortex-a720/spe.json       |  42 ++
 .../arm64/arm/cortex-a720/spec_operation.json |  90 ++++
 .../arch/arm64/arm/cortex-a720/stall.json     |  82 ++++
 .../arch/arm64/arm/cortex-a720/sve.json       |  50 ++
 .../arch/arm64/arm/cortex-a720/tlb.json       |  74 +++
 .../arch/arm64/arm/cortex-a720/trace.json     |  32 ++
 .../arch/arm64/common-and-microarch.json      |  15 +
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   2 +
 39 files changed, 2263 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/fp_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/general.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l2_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l3_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/ll_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/pmu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/sve.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/tlb.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/trace.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/fp_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/general.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l2_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l3_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/ll_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/pmu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/sve.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/tlb.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/trace.json

-- 
2.47.2

