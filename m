Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588AC330D25;
	Sun,  7 Jun 2026 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780874983; cv=none; b=L4XKVdQvBMcwRJNXVzndsLuuOkRdFbpHAbfiVOgXsEASeEmylPNlR+Fk/qSmlhddW+yNhhOlCFbQZk0KIDuXSK2vsljkU8XlkjHEfoHRl2bbEC5hU+HVPCLaItf6ZIPxB9Uq9P4RQ/43POaecgnVEODh8KrigOCpwH53/KophtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780874983; c=relaxed/simple;
	bh=5VWP2TekBIjJm70E0VzMP3ju0hgOjK8Wt8W8C1t9uZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HODfJAs6zmFnq7tpUiigeFujKlGfec3BHlgZLOvBREYdXecFT2r2bEZAMzYKgSMzYr8R8boKGYRjeyJje9EeApvb1ea4+N0uSrkdfNfJ4Vx92JEsMijfh+9q7eXhnZCNf1VAdAuw2V0AHoiEUu/WVOo+nUNos1AWecXZHB3M6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFSMe5HS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFSMe5HS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 917B61F00898;
	Sun,  7 Jun 2026 23:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780874982;
	bh=R5WxjEJlqlEk6iV+ivR2s+nGEBp270wPJyGXkOmIs10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dFSMe5HSbt1rt9B841OIinErlwktLchy3eA3edN/z6YQXYeECwE/XmEiNqrIajTj8
	 NYZJPC6oUMFe6Y6Yy2ybX+UK7B69apZqtm9YhmEauM+/Bi2kzEwypJ2SlhflFjCvyT
	 aB0dugJLmpWeYU3rMGTc+a5QBxiRN4mTXPRlSYPiYb8J4r5hQrf9wjnCdgWuUNNFJe
	 ITaeYlILVowaKRUXqX5zGEGECKjS/K4EyCXBLJ5ySgIu0TR+ggxYD64qROYxrG2aEx
	 zXgQsntLdL/ldm297Wrgs6h+USPVvcHMXqeFUlaM3CTKVBgnFrhV+ny8W5CsLKqm+R
	 j6Z81ZgAQEkfg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Don Zickus <dzickus@redhat.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 01/11] perf tools: Fix get_max_num() size_t underflow on empty sysfs file
Date: Sun,  7 Jun 2026 20:29:14 -0300
Message-ID: <20260607232925.1935819-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607232925.1935819-1-acme@kernel.org>
References: <20260607232925.1935819-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

get_max_num() reads a sysfs file (cpu/possible, cpu/present, or
node/possible) and scans backward from the end to find the last
number.  If the file is empty, filename__read_str() returns num == 0.
The loop `while (--num)` decrements the size_t from 0 to SIZE_MAX,
reading backward across the heap until a comma or hyphen is found
or unmapped memory is hit.

Add an early return for empty files before the backward scan.

Fixes: 7780c25bae59fd04 ("perf tools: Allow ability to map cpus to nodes easily")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 21fa781b03cc7409..1fab00ec4a59a0c7 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -448,6 +448,12 @@ static int get_max_num(char *path, int *max)
 
 	buf[num] = '\0';
 
+	/* empty file — nothing to parse */
+	if (num == 0) {
+		err = -1;
+		goto out;
+	}
+
 	/* start on the right, to find highest node num */
 	while (--num) {
 		if ((buf[num] == ',') || (buf[num] == '-')) {
-- 
2.54.0

