Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFFDC136;
	Wed, 26 Jun 2024 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413719; cv=none; b=IX1vxWqa5MPNe9fRUZ+MqDycJ0DVNj4nYsnqD4f2d24akpcjW2eLLccGCQ+xAI8kP855e4xz3i+FT4SvpjI8fiud8u+F3/PIAvGzFxsLmRoP2JtwZIPe9l5F9vpt61xI1kn8UiQzjZ1aa1FlfXQmTgtgagkdxiT78BCVnV/346E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413719; c=relaxed/simple;
	bh=BnV3828VHC5anaOJje3ZzYdZwLyQ1I61vPHlsp509Mw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nz2z0Mi92A9XX8Z6wSvoEaXO05Y0y1j0OvwcHZuezhGyJm8Rg2x4DaN3xQR6ICcZ4o+Z0l3/bX3qrpixqZmLD0LIvh5TusBIowJuYn8KUEB7uerl0kr9+erSQnJYmZhSdv6+9B+Uw/JbUc3srq0yIthliARkHw73m03lDqR8DJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9633339;
	Wed, 26 Jun 2024 07:55:40 -0700 (PDT)
Received: from e127643.cambridge.arm.com (e127643.arm.com [10.1.33.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE4AD3F73B;
	Wed, 26 Jun 2024 07:55:12 -0700 (PDT)
From: James Clark <james.clark@arm.com>
To: linux-perf-users@vger.kernel.org,
	irogers@google.com,
	namhyung@kernel.org
Cc: robin.murphy@arm.com,
	James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] perf pmu: Event parsing and listing fixes
Date: Wed, 26 Jun 2024 15:54:44 +0100
Message-Id: <20240626145448.896746-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The second fix is related to the discussion here [1].

The first fix is unrelated but I just noticed it while fixing the
listing issue.

[1]: https://lore.kernel.org/all/ce31a50b-53db-4c6f-9cb1-242280b0951c@arm.com/

Changes since v1:

 * Add Ian's suggested-by tag on patch 2
 * Fix mistake where info.pmu_name instead of pmu->name should have
   been used in perf_pmu__for_each_event()

James Clark (2):
  perf pmu: Restore full PMU name wildcard support
  perf pmu: Don't de-duplicate core PMUs

 tools/perf/tests/pmu.c | 78 ++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/pmu.c  | 29 ++++++++++++----
 2 files changed, 100 insertions(+), 7 deletions(-)

-- 
2.34.1

