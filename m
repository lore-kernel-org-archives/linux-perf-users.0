Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214918;
	b=B9ZxSKAPLah/1u0mWrZduH6+D5tIlnauzk2vz3bt2xZuosuBztyeYedTj/iuCPput2HH
	 oae4CoX6KR43EH3W/QDN5h7S6ujqoKnHXOyBLS+ryNyTpzpNfXlfFHa/JvsfF5tUH9nx/
	 b301vgIkgW3E7gvWCuod/x+9c0vVnqdQWHV6l2gceP4iUO5N0Iqvc/wCCvcg4RZRaVAr/
	 U+v9WbI3wATHtthbAS5dWLwxkLtp24fDhd7KdgjLLerpiYwgF+2mfFQM2C7iUBDNDVMPT
	 Yhq6aGSU4IMsZKtuLIssdFJ9frixjDwsBCpjig01okiLpXzgtA4F06oGxyIQYTuoyHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214918;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 DKIM-Signature;
	bh=F8g6Wt9NOwF6DUxJqUEaQBioV069X8V8j/0l1jIw+2A=;
	b=Yex327mDYjsE3WPZBGLzhJBZGovj3cfYtmp6XNEXmvt7ZQrgd44sVMShB6BAQjce1v+I
	 wtT9jAZuM94Hi6ku9hrH4skw6hQrcUYHqP6eBOzgv5N2qz+trkJAzkonhu9aIrJx2OfEZ
	 P6Cy5UOPn4We+25hp50qffMDniibl9wTg34njwr5kDllQAgf4eaRrciV89afItkjTw2hk
	 1X2mb2yeXIqIwxYia/n+YqPhqKK11MFbu1yDVM9fam/lqTLffymj7zqX02BwUY6PCTq4d
	 CrNJwAGRmCwoBrB37KMFNGz8SmKL0VGGk5pju+y7tUFacHUgPuhZxW9hyrq5kyZOOoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b="X/4PLyEH";
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B56DA606A321;
	Mon,  9 Nov 2026 09:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B56DA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=X/4PLyEH
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Li RongQing <lirongqing@baidu.com>,
	Alexander Antonov <alexander.antonov@linux.intel.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH, next, v2] perf iostat: Release the port list if command allocation fails
Date: Mon, 9 Nov 2026 17:01:43 +0800
Message-ID: <20261109090143.1749-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc13.internal.baidu.com (172.31.4.11) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794214911;
	bh=F8g6Wt9NOwF6DUxJqUEaQBioV069X8V8j/0l1jIw+2A=;
	h=From:To:Subject:Date:Message-ID:Content-Type;
	b=X/4PLyEHFsNFleUoTyVpm1B3hQJbuIPLDulSdWMmK1g4ul2c6FoJYuyN3iiOGeoEt
	 sYAma4gBtO7U36s/q8vnun3Rm13BF4CgYGpCGJyujf3AVe8e8kLJ4E9iiWgm6q+Ic3
	 6h6oTxgjGldeQw3sljEABkMB+Y+YnNkiqyEsN5adKXHWXZZhFIb6yTIXtXlB723v4t
	 Onh7AG6lnV1blOLacn5b5DP/tYOkxBmVspPLWe2RKxjGSa7qee4MAYk1WdoN4hLa9r
	 FOGLm18LT0EGxgYoq5kpdjju3BqbxkMWniNgzMvXZKXzeV1MoHZkCfSf1bzjKAZ+VX
	 uIb+asvppyEtQ==

From: Li RongQing <lirongqing@baidu.com>

iostat_event_group() takes ownership of the root port list and frees it
via the err: label on both the normal and parsing-error paths. When
calloc() for iostat_cmd fails, however, the function returns -ENOMEM
directly, leaking the list, its pointer array and every port in it.

Route this failure through the existing cleanup path instead. At this
point no port has been transferred to an event yet, so
iio_root_ports_list_free() releases the whole list, and the trailing
free(iostat_cmd) is a no-op on the NULL pointer.

Fixes: f9ed693e8bc0 ("perf stat: Enable iostat mode for x86 platforms")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v1: rebase to next

 tools/perf/arch/x86/util/iostat.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/iostat.c b/tools/perf/arch/x86/util/iostat.c
index 7442a2c..d2cc2e7 100644
--- a/tools/perf/arch/x86/util/iostat.c
+++ b/tools/perf/arch/x86/util/iostat.c
@@ -310,8 +310,10 @@ static int iostat_event_group(struct evlist *evl,
 	int metrics_count = iostat_metrics_count();
 	char *iostat_cmd = calloc(len_template, 1);
 
-	if (!iostat_cmd)
-		return -ENOMEM;
+	if (!iostat_cmd) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
 	for (idx = 0; idx < list->nr_entries; idx++) {
 		sprintf(iostat_cmd, iostat_cmd_template,
-- 
2.9.4

