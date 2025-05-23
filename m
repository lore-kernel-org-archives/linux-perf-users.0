Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B8D1ADC67;
	Fri, 23 May 2025 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748038918; cv=none; b=XMu6Tafm2LJ+FVhAO4Rc7Ou3Ja1OoKG0P7QpworjEy3uf3AphCGz9HsJtbwj9fXC8E8Sy13ctOqSau/lkV9dG5ZhzPG0VdvTd5AW78fcnNtNRfdwE0X7fQ/PdwVX6l5jwbrbAkSmWyWacN7++hoqEFTiakWqB4ejJUCrf4CePc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748038918; c=relaxed/simple;
	bh=AiDAoyQjHRv2JDTsgsxGZeHVPr7H6J1azUzkcdYGflg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UOoGLLC2nv2c9mTVx2hoiBra7pRdMs9txYadZSexI2FUI7tFoa1gAKrHWfWGY/+MdGJZESjMSUKlclH8GlcE0Sp7M93E18niPX2M+JcUup9t9hv171XExYDzLA9mzRyUx3Sd2gPJbHA8SpB5/F1tzcSTm2n+YWe1eX3vmniVyrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4xh3qfX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4xh3qfX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E805C4CEEF;
	Fri, 23 May 2025 22:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748038918;
	bh=AiDAoyQjHRv2JDTsgsxGZeHVPr7H6J1azUzkcdYGflg=;
	h=From:To:Cc:Subject:Date:From;
	b=Z4xh3qfXOt31hAXeYQCqZzobkM2LLD4tPVMEuzNnrMHPNuhLP1igFwOSu2Z/tMm3h
	 LIpcmF+ZtJNhmODyPHm3QoyeARMFTiA/SSdYJEMQuhXobRWBIdPhZSodYMNdoali+V
	 WGXjLdBlWn9+qlgUM1f+kMQ/XyHvFFBXl+yNk7iJ4CEKylqxp1aooWXl0gMkT7Im3C
	 zOtvf6P+dAbkZYMwzNDmjn3AhK57IuuDBPaeuXcpWyIYsUgNJnTNW6wpqfrvMagsro
	 Zain0DzBXjcyDSux6hNb4U8cobtwGSUT8vjFHHdRpaSkhf7K3qDSuJAZJGtCOcyMz1
	 7Rf/tFFZFFcZg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Leo Yan <leo.yan@arm.com>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 1/3] perf mem: Describe overhead calculation in brief
Date: Fri, 23 May 2025 15:21:55 -0700
Message-ID: <20250523222157.1259998-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Bangoria <ravi.bangoria@amd.com>

Unlike perf-report which uses sample period for overhead calculation,
perf-mem overhead is calculated using sample weight. Describe perf-mem
overhead calculation method in it's man page.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-mem.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index a9e3c71a220557d4..965e73d377724607 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -137,6 +137,25 @@ REPORT OPTIONS
 In addition, for report all perf report options are valid, and for record
 all perf record options.
 
+OVERHEAD CALCULATION
+--------------------
+Unlike linkperf:perf-report[1], which calculates overhead from the actual
+sample period, perf-mem overhead is calculated using sample weight. E.g.
+there are two samples in perf.data file, both with the same sample period,
+but one sample with weight 180 and the other with weight 20:
+
+  $ perf script -F period,data_src,weight,ip,sym
+  100000    629080842 |OP LOAD|LVL L3 hit|...     20       7e69b93ca524 strcmp
+  100000   1a29081042 |OP LOAD|LVL RAM hit|...   180   ffffffff82429168 memcpy
+
+  $ perf report -F overhead,symbol
+  50%   [.] strcmp
+  50%   [k] memcpy
+
+  $ perf mem report -F overhead,symbol
+  90%   [k] memcpy
+  10%   [.] strcmp
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-arm-spe[1]
-- 
2.49.0.1151.ga128411c76-goog

