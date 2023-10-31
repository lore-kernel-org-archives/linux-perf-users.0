Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264EA13AF0
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Oct 2023 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id E48565595;
	Tue, 31 Oct 2023 05:05:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4403CC15;
	Tue, 31 Oct 2023 05:06:18 -0700 (PDT)
Received: from dsg-hive-n1sdp-01.. (dsg-hive-n1sdp-01.cambridge.arm.com [10.2.2.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1964D3F738;
	Tue, 31 Oct 2023 05:05:34 -0700 (PDT)
From: Nick Forrington <nick.forrington@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Nick Forrington <nick.forrington@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 0/2] Perf lock improvements
Date: Tue, 31 Oct 2023 12:05:23 +0000
Message-ID: <20231031120526.11502-1-nick.forrington@arm.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Perf lock improvements, to re-introduce aggregation by caller to perf
lock report, and improve command line handling for perf lock info.

These changes are technically independent, but submitted together to
ensure they apply cleanly.

Nick Forrington (2):
  perf lock report: Restore aggregation by caller by default
  perf lock info: Enforce exactly one of --map and --thread

 tools/perf/Documentation/perf-lock.txt |  4 +++
 tools/perf/builtin-lock.c              | 49 ++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 3 deletions(-)

-- 
2.42.0

