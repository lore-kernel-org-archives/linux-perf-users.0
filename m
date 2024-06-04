Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E23D143C61;
	Tue,  4 Jun 2024 09:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493562; cv=none; b=NuuF1H7GAdr+0qX6Vnjh6Me5PNxko/L9nJTmH6Y81wQR6qtpaNzmrBspI7wxus20h0bJetD/V4Urr0Z4FtZ5VKWqVm2zuwLMdv7z11N6JTgO7RLyhW1OEonQDExzTrqgjM+GwxpStBPXiXpvcxq73bnqioBluY98mIOgBIwX6Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493562; c=relaxed/simple;
	bh=AjPsIIc0/zREvVckEHHYWZm5WtuqGuLry5Be3vyjm9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JX5EJeao0USI7bQr4zZLOarNEDHm8BgsUgb23kAib/7+7S33S5bCUkar425CFlb2HMw8dAqZ0v9UuEIEyNx9E1UfYADjEFIzQfzLWLdWZcfJ5ys+oYPw0pPaHvU2TFagc+lCjYMwR6uXTJEUR2U26tBfiB9rrH90ePFQCZ7V6Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD3541042;
	Tue,  4 Jun 2024 02:33:03 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A50533F762;
	Tue,  4 Jun 2024 02:32:37 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Clark <james.clark@arm.com>,
	Ian Rogers <irogers@google.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Changbin Du <changbin.du@huawei.com>,
	Fangrui Song <maskray@google.com>,
	"Mateusz Kowalczyk" <fuuzetsu@fuuzetsu.co.uk>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 0/6] perf: build: Fix cross compilation
Date: Tue,  4 Jun 2024 10:32:17 +0100
Message-Id: <20240604093223.1934236-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes cross compilation issues.

The first two patches address the package configuration issue. It sets
the package path so the compiler can find the architecture's package.
The patch 03 sets the Python configuration path and renames the .so to
reflect the build target.

The last three patches fix the static build failures. Patch 04 is to fix
the issue caused by newer version's elfutils, and the last patches fix
the building failure for feature detecting binaries.

This patch series is tested for building perf on x86_64 host for Arm64
target.

Leo Yan (6):
  perf: build: Setup PKG_CONFIG_LIBDIR for cross compilation
  perf: build: Append libtraceevent path in PKG_CONFIG_LIBDIR
  perf: build: Set Python configuration for cross compilation
  perf: build: Only link libebl.a for old libdw
  perf: build: Link lib 'lzma' for static build
  perf: build: Link lib 'zstd' for static build

 tools/build/feature/Makefile | 42 +++++++++++++++++++++++++++---------
 tools/perf/Makefile.config   | 25 +++++++++++++++++++--
 tools/perf/Makefile.perf     | 15 ++++++++++++-
 3 files changed, 69 insertions(+), 13 deletions(-)

-- 
2.34.1

