Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AEC42AA1;
	Mon, 10 Jun 2024 09:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013307; cv=none; b=VteX5dCQoAMevuUr6FjwUduejQ/eYkMRTlrAb17OKUbTEykRoBUNckSO9PsvD37VZUHTPdK02X/DjS29+aIJW5SveHe3LJzdMzBT4d5N3ounjW4QocMo+3E8UqoY6gUxnfqEtR3kn4nEF5gNrgzf/RZGqZ0Cjgm4kW6ZB0aOpdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013307; c=relaxed/simple;
	bh=qv4nrgv/tX8ob6foi0KDq9uLPeb3wRED/tucnkRZlAM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=svc4O4WAl/Ca1fPHCyeOYJdOB94k858Ria41p3ayx2CkcrU83h8W40cuQ5y2DDA3K7d42H7j8Q6KVzD9qg7vobYOUedecFhqRml9sJdt578sJVWgYYEMhV1xcvI/WpwuX21JJYcsKPFpx6/KT1OMJ9BVwvDn3ArdZu8p86aHNao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E549112FC;
	Mon, 10 Jun 2024 02:55:28 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 17B673F73B;
	Mon, 10 Jun 2024 02:55:01 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Fangrui Song <maskray@google.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Guilherme Amadio <amadio@gentoo.org>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 0/6] perf: build: Fix cross compilation
Date: Mon, 10 Jun 2024 10:54:27 +0100
Message-Id: <20240610095433.336295-1-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes cross compilation issues.

The first patch sets the package path if the package configuration path
is not specified. This helps the compiler to find the architecture's
package in a Multiarch system.

The patch 02 sets the Python configuration path and renames the .so to

The patches 03, 04 and 05 fix the static build failures.

The patch 06 adds document for how to cross compile.

This patch series is tested for building perf on x86_64 host for Arm64
target.

Changes from v1:
- Kept the cross-compile-pkg-config if it is available. (Namhyung)
- Removed the patch 02 for fixing pkg-config path for libtraceevent, as
  this will be resolved in Guilherme Amadio's patch "perf build: Use
  pkg-config for feature check for libtrace{event,fs}".
- Added patch 06 for document.


Leo Yan (6):
  perf: build: Setup PKG_CONFIG_LIBDIR for cross compilation
  perf: build: Set Python configuration for cross compilation
  perf: build: Only link libebl.a for old libdw
  perf: build: Link lib 'lzma' for static build
  perf: build: Link lib 'zstd' for static build
  perf docs: Document cross compilation

 tools/build/feature/Makefile       | 54 ++++++++++++++++++++++++------
 tools/perf/Documentation/Build.txt | 37 ++++++++++++++++++++
 tools/perf/Makefile.config         | 20 ++++++++++-
 tools/perf/Makefile.perf           | 26 +++++++++++++-
 4 files changed, 125 insertions(+), 12 deletions(-)

-- 
2.34.1

