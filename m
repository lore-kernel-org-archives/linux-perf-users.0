Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C427155757;
	Sat,  6 Jun 2026 20:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780776401; cv=none; b=qwbkWFbV1jgzWUuYci2gNiF+YayCeb33F73qxjgoHwlWQVAErUzgHIxdkGxFKyXEG978GiflHJjGYuETOcdH8ORDegw0OMRAUF54cI/zH4WH5cFJjL57caL9dRDo6091gO2CIthDtRhuPblIaP8rC39vW2HIMOsVRntmS5H95G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780776401; c=relaxed/simple;
	bh=MgPFe1riTYxByXU+9o65XAXLNS6j6GrUt3UbKk1GOKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aw839leHWRtHBiUHcILurd3zbkiICShhDgRlTvV4pjARfms3143Ny0dtuoJCDOXPTgxFTTYUIQz1+U+4fZL3DVWlRt7K2CzkNRh7k2HhN0NhqKWI9CyfS3b/CzPeqouF8pEuls4kUP0g6lqQjCxj6EGr4nQp1SJ9S2l1m6hHuIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lL525oa5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lL525oa5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301131F00898;
	Sat,  6 Jun 2026 20:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780776400;
	bh=hbST67JSXpzQHfuHrk5vsTjP587tEd8zXcSCma4RepY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lL525oa5/pC/BK2ihGymAgP76BE0R3vrApPgGBC9c9FQxZrGKNoqEpq7bQliPLdnZ
	 qp9SX5ZIKfLFlxLVmRXJem138+erED6rvyW2dTukFvBHUoz+SDe5OxjyR4MkPtOkGp
	 Kz69TV91h9FlZUGpQxSOTI6leFc5c29JEEYe1gAUZbTSDMHoGJpDfzXUXDZzrG8oYS
	 BkmYGLVDHqEOcyvvrqJ3DUE38l9mt5JhngxENs974BLVvt/bFF3aFC2nsAMBXoa3D/
	 E6/oJGk058zVX2UtpKdfciANQuwxuO4VExDU/el/UII70kzBD4aznYzdryHdCRto0m
	 5znpJNmR+AfPg==
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
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 5/7] perf tools: Fix int16_t truncation of max_cpu_num in set_max_cpu_num()
Date: Sat,  6 Jun 2026 17:05:57 -0300
Message-ID: <20260606200601.1861227-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606200601.1861227-1-acme@kernel.org>
References: <20260606200601.1861227-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

set_max_cpu_num() assigns the sysfs "possible" CPU count to
max_cpu_num.cpu which is int16_t (struct perf_cpu).  On systems
with >32767 possible CPUs the value silently truncates, potentially
wrapping negative.  This causes cpunode_map to be underallocated
and subsequent cpu__get_node() calls to read out of bounds.

The matching check for max_present_cpu_num was added by commit
c760174401f6 ("perf cpumap: Reduce cpu size from int to int16_t")
but max_cpu_num was missed.  Add the same INT16_MAX guard.

Fixes: c760174401f605cf ("perf cpumap: Reduce cpu size from int to int16_t")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index d3432622b2adc994..21fa781b03cc7409 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -494,6 +494,16 @@ static void set_max_cpu_num(void)
 	if (ret)
 		goto out;
 
+	/*
+	 * struct perf_cpu.cpu is int16_t (libperf ABI) — clamp to avoid
+	 * truncation to negative.  See tools/lib/perf/TODO for the ABI
+	 * widening plan.
+	 */
+	if (max > INT16_MAX) {
+		pr_warning("WARNING: max possible cpus %d exceeds int16_t, clamping to %d\n",
+			   max, INT16_MAX);
+		max = INT16_MAX;
+	}
 	max_cpu_num.cpu = max;
 
 	/* get the highest present cpu number for a sparse allocation */
@@ -506,11 +516,12 @@ static void set_max_cpu_num(void)
 	ret = get_max_num(path, &max);
 
 	if (!ret && max > INT16_MAX) {
-		pr_err("Read out of bounds max cpus of %d\n", max);
-		ret = -1;
+		pr_warning("WARNING: max present cpus %d exceeds int16_t, clamping to %d\n",
+			   max, INT16_MAX);
+		max = INT16_MAX;
 	}
 	if (!ret)
-		max_present_cpu_num.cpu = (int16_t)max;
+		max_present_cpu_num.cpu = max;
 out:
 	if (ret)
 		pr_err("Failed to read max cpus, using default of %d\n", max_cpu_num.cpu);
@@ -647,7 +658,9 @@ int cpu__setup_cpunode_map(void)
 		while ((dent2 = readdir(dir2)) != NULL) {
 			if (dent2->d_type != DT_LNK || sscanf(dent2->d_name, "cpu%u", &cpu) < 1)
 				continue;
-			cpunode_map[cpu] = mem;
+			/* cpunode_map allocated for max_cpu_num entries */
+			if (cpu < (unsigned int)max_cpu_num.cpu)
+				cpunode_map[cpu] = mem;
 		}
 		closedir(dir2);
 	}
-- 
2.54.0

