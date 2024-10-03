Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5291A3A9B;
	Thu,  3 Oct 2024 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727981616; cv=none; b=n26fdYo/azBb0zPrES8wD61GD8ELKHWoqj2p66nRsPfwDxtdwLaAfQruv8dHGiqNM43f/6jwWWlsuam8XWLinFldS+Un+vtjg7d0rAI9UYtArUOLIUOUWANFhkwOTELPMqpEMT8RUgFgURXnASuKtwgifYLfmJK3WpDatFJK53M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727981616; c=relaxed/simple;
	bh=M+N5y4p/1wx3nrgY9SQGenXEcYHpilMJK3GPxepMn8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=diTQRnngx7xf9cchIqvkUjc7BB/5f6pU9TRJczcFl8QVZe5UC+q76dWM3A2xYFnX3fWfxc4DknE0+oVSGCMLjMRoRE4NNhJRAWuwpwKqCV2foOOeEostOFY3SpeDwaaZPCYdbbKfawrZ+uuEGQkE7tznvZ2SQ/88hKsYEI4k8wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86921339;
	Thu,  3 Oct 2024 11:54:04 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F27443F640;
	Thu,  3 Oct 2024 11:53:32 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 0/7] perf arm-spe: Refactor data source encoding
Date: Thu,  3 Oct 2024 19:53:15 +0100
Message-Id: <20241003185322.192357-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As more Arm CPU variants (not only Neoverse CPUs) support data source
encoding, they share the same format for the data source packet.

To extend supporting these CPU variants for Arm SPE data source, this
series refactors the code. It converts the Neoverse specific naming to
the common naming, and then based on the MIDR stored in the metadata to
decide if the CPU follows up the common encoding format.

At the last, it extends CPU list for Neoverse-V2 and Cortex CPUs.

This patch series is dependent on the metadata version 2 series [1] for
retrieving CPU MIDR. It has been verified for per CPU mode and per
thread mode on Cortex-A725 CPUs.

[1] https://lore.kernel.org/linux-perf-users/20241003184302.190806-1-leo.yan@arm.com/T/#t

Changes from v2:
- Rebased on the latest metadata version 2 series [1].

Changes from v1:
- Dropped LDS bit checking in data source parsing.


Besar Wicaksono (1):
  perf arm-spe: Add Neoverse-V2 to common data source encoding list

Leo Yan (6):
  perf arm-spe: Rename arm_spe__synth_data_source_generic()
  perf arm-spe: Rename the common data source encoding
  perf arm-spe: Introduce arm_spe__is_homogeneous()
  perf arm-spe: Use metadata to decide the data source feature
  perf arm-spe: Remove the unused 'midr' field
  perf arm-spe: Add Cortex CPUs to common data source encoding list

 .../util/arm-spe-decoder/arm-spe-decoder.h    |  18 +--
 tools/perf/util/arm-spe.c                     | 135 +++++++++++++++---
 2 files changed, 121 insertions(+), 32 deletions(-)

-- 
2.34.1

