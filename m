Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE36E1CA80
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Sep 2024 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727553365; cv=none; b=BFZC6jP5XWR4sNsQ1a3O178qNsOhftak31tCBs1FcDH4tJSUN5PGUcs4ZKCqFtN2kaDx9UknsTkleiwhLQ2XcWItyUu8OFeReoXrRTkuBxU6p16NS9S/lXfpveGhZKFA4XlS9jaC8XjYveZtWB8/FP59bmhXMEO7WyfcPs9c95Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727553365; c=relaxed/simple;
	bh=AKcBgcTW8U0PWies9vDhP22L+eeNI1o1j1gLuWGVL/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FfrWrNDDFzq8lyWyIQPdSrKcA1+n+TPqwsbiCplESe/I5AlnI5TWWN9Ctm1EZw8nbWC1SyNv3AQ9gqK3qq6ib8yrUBL5Mbg9znB8NT78V13ugA8YuBnOwEmSBhZvRbziKhCRjSxowHgOalbTfmxTGa2Lt8rVLgVnyMnvHOxYiAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B13512FC;
	Sat, 28 Sep 2024 12:56:26 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AA52C3F64C;
	Sat, 28 Sep 2024 12:55:54 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v3 0/5] perf arm-spe: Introduce metadata version 2
Date: Sat, 28 Sep 2024 20:55:42 +0100
Message-Id: <20240928195547.59780-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series enhances Arm SPE metadata in the Perf file to a
version 2 format and maintains backward compatibility for metadata v1.

The version 2 metadata contains a global structure with fields for
metadata header version number, header size, CPU numbers. It also
expands to store per-CPU metadata, which includes the CPU logical
number in the kernel, MIDR, and capacity values associated with Arm SPE.

This patch set has been tested the perf to decode the Arm SPE metadata
v1 and v2.

Changes from v2:
- Added comment for arm_spe_find_cpus (Namhyung)
- Corrected resource releasing in arm_spe_save_cpu_header() and
  arm_spe_info_fill() (Namhyung)
- Changed to use calloc() for allocating metadata pointer array
  (Namhyung)

Changes from v1:
- Dropped LDS bit exposing from Arm SPE driver (Will Deacon).
- To simplify the change, this series did not include multiple AUX event
  support.


Leo Yan (5):
  perf arm-spe: Define metadata header version 2
  perf arm-spe: Calculate meta data size
  perf arm-spe: Save per CPU information in metadata
  perf arm-spe: Support metadata version 2
  perf arm-spe: Dump metadata with version 2

 tools/perf/arch/arm64/util/arm-spe.c | 122 +++++++++++++++++++++-
 tools/perf/util/arm-spe.c            | 151 +++++++++++++++++++++++++--
 tools/perf/util/arm-spe.h            |  38 ++++++-
 3 files changed, 296 insertions(+), 15 deletions(-)

-- 
2.34.1

