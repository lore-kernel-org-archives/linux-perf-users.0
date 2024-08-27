Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EE954767;
	Tue, 27 Aug 2024 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777076; cv=none; b=DuK3KVrqDhkt8AQixOdgZjAxSGJCxjaViPMZ0dvvxToEEg6q+JH5aNZ80mJG7cVQWRgH5GVYl1z4Ok/aFxegfxukj7NVVqWvyj0vvMN4x5+nA0AamEG8pcM/t3WOpC1S5TA07x49e/Ih8UTPbSD1YLctoba7uO5NiHyi7ZH2ncA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777076; c=relaxed/simple;
	bh=EiGY5P6XTjDUe1V4OcObLD+qrQAq2fjWcwNLrUmnhxE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Kav5q9MjQmh2v98dEoAHaA3NHw+asa4uHvEkUu9Ho4NxirooOG1kWfruUwPZAnESbVkiQNP7dSJnMjNFOD0AmUF8AXvDacBRn/7HuYVk7JaRv22ixCmFCZhqmgkCJnGMHb01fyJwO+bilBt0H4HPFm8KqVD/245dF1DqZ7so+z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85390DA7;
	Tue, 27 Aug 2024 09:44:59 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 355F33F762;
	Tue, 27 Aug 2024 09:44:31 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 0/9] perf arm-spe: Introduce metadata version 2
Date: Tue, 27 Aug 2024 17:44:08 +0100
Message-Id: <20240827164417.3309560-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series enhances Arm SPE metadata in the Perf file to a
version 2 format.

The version 2 metadata contains a global structure with fields for CPU
numbers and the metadata version number. It also expands to store
per-CPU metadata, which includes the CPU logical number in the kernel,
MIDR, and capacity values associated with Arm SPE.

This set exposes a new sysfs node, ‘lds’ (Load Data Source), which
indicates if the Arm SPE supports data source packets. This flag will be
used to decide if the data source packet needs to be decoded during the
report phase, which will be sent out in a separate series for data
source decoding refactoring.

This patch series need to be applied on the top of the changes:
https://lore.kernel.org/linux-perf-users/20240823113306.2310957-1-leo.yan@arm.com/T/#t


Leo Yan (9):
  perf: arm_spe: Introduce 'lds' capacity
  perf auxtrace arm: Refactor error handling
  perf auxtrace arm: Introduce find_auxtrace_pmus_by_name()
  perf: arm-spe: Record multiple PMUs
  perf arm-spe: Extend meta data header for version 2
  perf arm-spe: Calculate meta data size
  perf arm-spe: Save per CPU information in metadata
  perf arm-spe: Support metadata version 2
  perf arm-spe: Dump metadata with version 2

 drivers/perf/arm_spe_pmu.c           |   3 +
 tools/perf/arch/arm/util/auxtrace.c  | 191 +++++++++------------------
 tools/perf/arch/arm64/util/arm-spe.c | 126 +++++++++++++++++-
 tools/perf/util/arm-spe.c            | 119 ++++++++++++++++-
 tools/perf/util/arm-spe.h            |  37 +++++-
 5 files changed, 328 insertions(+), 148 deletions(-)

-- 
2.34.1

