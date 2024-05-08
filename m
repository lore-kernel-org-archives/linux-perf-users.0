Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7ED75818;
	Wed,  8 May 2024 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715175790; cv=none; b=orgBIu+DA/G+i2S7F5zco1T/UzSOf0xPnwL0x8DE0WLAjQArsk1sP/e8Hv/9GCm/eqYUiRldb/kU+lAKP93+cDJdm0AjJra2xdYCayf+BgB8LGFkaWckpMw5fXuuUrAL4c59KnThCGKcKjBtD1/t/Lij6WhOJySZPAuNm4PP5cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715175790; c=relaxed/simple;
	bh=f3ORKPUuuxPvn/SDUoAA/2zcl8K8/9tPG6vej4gbSY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LsK9/UOG4bglU46sYyDtkzLqZztrfPWZ0gr76nRc0voqvfoe+P/Tklf6db7NVhM9OW3cWdcUO5wwy9A/c22J/NkMr+3c58m7dqFGMt5wjjKmgi7FlWL02s3evEeXqGZ8J+Ixd1J2AI12Hc75ch2MvJXf99gQQW+QE/YXwblUUBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91A7E1007;
	Wed,  8 May 2024 06:43:33 -0700 (PDT)
Received: from dsg-hive-n1sdp-01.cambridge.arm.com (dsg-hive-n1sdp-01.cambridge.arm.com [10.2.3.10])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9F92A3F6A8;
	Wed,  8 May 2024 06:43:06 -0700 (PDT)
From: Nick Forrington <nick.forrington@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Nick Forrington <nick.forrington@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>
Subject: [PATCH v3 0/1] Perf lock improvements
Date: Wed,  8 May 2024 13:42:57 +0000
Message-ID: <20240508134259.24413-1-nick.forrington@arm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improvement to command line handling for perf lock info.
---
v1: https://lore.kernel.org/all/20231031120526.11502-1-nick.forrington@arm.com/

v2:
* Drop previous "perf lock report: Restore aggregation by caller by
  default" patch. Not required for newly collected data with LOCKDEP
  tracepoints.
* Display map and thread info (rather than an error) when neither or
  both of --map and --thread are specified.

v3:
* Update --help output

Nick Forrington (1):
  perf lock info: Display both map and thread by default

 tools/perf/Documentation/perf-lock.txt |  4 ++--
 tools/perf/builtin-lock.c              | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.44.0
