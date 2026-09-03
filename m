Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C1645FFB1;
	Thu,  3 Sep 2026 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788435003; cv=none; b=gjNT6Wc6qfBfpk4qOIK65p6t/JxWsd/hmjAVqkkrfgfwOTyvFG9edE1cJPmYj3dz/t2sLu93kG11YzYKoPCj7UPIA+t7Huzlc0bXsDPAURh1/6olIX07mpDk7f4b6pNB3Yh4BCuN4nv41XoTMZPbo0rssaE8u89uOMSQKaZQo5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788435003; c=relaxed/simple;
	bh=E0SrowS+8/XzY1xxTjt1HOtVGWNHrsF2OH7jRaJbuJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JSUko//hY/tzMK+t+vh7a353X7KL3pOHB+D28+CPYsXve3OFUk5P5pVOdZXwEDFz05MIsuVgx/2B5EWGW1dtsrMlGmiKHD4GExQNHFBoSkEJAeaeL8e7BBWNYYb5Q61tcgolquv55K/t8xDuAx/MS3GWpeg1t6Hyj89K36rkF2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dFtYR3wZ; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dFtYR3wZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=4M
	K0iYVfe40FU1BITi2Afs1n55yiE1KIJ8X6abAbjl0=; b=dFtYR3wZF9con/blsY
	7iWpvdO0+97ccdBssFK3qju5RZ7DBc2NTU0pgdCgT7K1yLPbxtLce1UsxplkMjUW
	l5bkCuzq/w9XibJEW/TdZm50IjG0Kzdp6A4VRgccfnhbCjVooo6VYnhDIk8mW4aU
	b+vOGY/2J+GR+H6X/uEqfNyps=
Received: from nans.company.local (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDH2+fjWZlqt3sRPw--.51326S2;
	Thu, 03 Sep 2026 19:28:36 +0800 (CST)
From: nanshuaibo <nanshuaibo811@163.com>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	nanshuaibo <nanshuaibo811@163.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH] perf sched: Make output_name variable static
Date: Thu,  3 Sep 2026 19:28:34 +0800
Message-ID: <20260903112835.1694260-1-nanshuaibo811@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDH2+fjWZlqt3sRPw--.51326S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtr43KrWkWryxWFWDurWkXrb_yoWfArg_Cw
	n3Ww4UZr98ur9F9r9xA34rXr1xta1YgF4Dtr48WFsrCF4UJF4qvrWDua9xAFyYqrsrJ3W7
	Gr4FgFyYkrWDCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRRPfQDUUUUU==
X-CM-SenderInfo: pqdq2xxxdlu0qyrrqiywtou0bp/xtbC6AWQy2qZWeWD2gAA3g

The output_name variable is only used within builtin-sched.c for the
stats subcommand, so declare it static. This fixes a sparse warning:

  builtin-sched.c:4140:12: warning: symbol 'output_name' was not
  declared. Should it be static?

Signed-off-by: nanshuaibo <nanshuaibo811@163.com>
---
 tools/perf/builtin-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index dd39a4fb..22486df2 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -4137,7 +4137,7 @@ static int disable_sched_schedstat(void)
 }
 
 /* perf.data or any other output file name used by stats subcommand (only). */
-const char *output_name;
+static const char *output_name;
 
 static int perf_sched__schedstat_record(struct perf_sched *sched,
 					int argc, const char **argv)
-- 
2.43.0

