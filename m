Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBA31A072D;
	Tue, 27 Aug 2024 16:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777504; cv=none; b=OKkEb71L68Fb6w/Nfo6zZYVbR7OygsHv8snOLqSyFCJB0kTEYxosZ2zb64tQK/rj1QDsgsRScVWWIalhXnxEHnQ5mYGEfxjha2CA4lT5RZyrJ3JAJt3hT3P5+lJGxpJ2k0Hk1R2L03ixGO+M8BkrRBCxFVRaz2DpoO8vTA6Q12g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777504; c=relaxed/simple;
	bh=shsZa5opXckEUX0RXL8kOMl38ge7TWGV2GdQHibDaSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WRidydV9tr8fO+A722EZtIrjUJE9KpDmpGJc62l2Gg8+pqYUWx33ttjg9QAlGoNG5pLuPPSJr06ogU1iMLi1F96SRxUa7WyyfKqCI8ktNkDRFBvTO3jU5TPXe/wt/KqXs7TU15aJz2MOvduibJggQR6Xz+EBkMnvX6fuKGJX9JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B008FDA7;
	Tue, 27 Aug 2024 09:52:08 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 727973F66E;
	Tue, 27 Aug 2024 09:51:40 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 0/7] perf arm-spe: Refactor data source encoding
Date: Tue, 27 Aug 2024 17:51:18 +0100
Message-Id: <20240827165125.3311306-1-leo.yan@arm.com>
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

This patch series is dependent on:
https://lore.kernel.org/linux-perf-users/20240827164417.3309560-1-leo.yan@arm.com/T/#mea6f658945a66d37c8633f4c94b2c79312acb573

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
 tools/perf/util/arm-spe.c                     | 136 +++++++++++++++---
 2 files changed, 122 insertions(+), 32 deletions(-)

-- 
2.34.1

