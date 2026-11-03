Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725905;
	b=t+UeR9bveNE3zU8grsfkDzwRFnvbOQ8QZdWbBzb8KRHQTiKUPa7mBaE9by5NQqksIxWu
	 kJI5fikWLmBD37WMYsiywQFqLr9jgOYo9WMHTq+BYxNf4psDjGiXA8mX9YxFtLWrAYXUl
	 MV9aCi3eT9mw8QIvhaStO7QUoBirLr7Ub0nDb0ImrEmM7CRwhd620GUOccZvMyPp3D5Zv
	 RbKfSbZu/QYGGzXOKYv1RtCEjNimGmnP3eWCMtPPvOQJpWj2MhbwjMy2qHFYz37pcFrRb
	 J96B2Tu/2iyp5VLSFMpovHCq2yI4e5IuAnjvE9a7bNxhpX8x6iwvI0R/LTOxvzRbOgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725905;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sNcOfKHXPTgVIscGPCJFbeSnoIClwuHgcVYSe9ouAP8=;
	b=sRb69Nvqd4cQf3s60oyOwTV0yrMHcJZA3yBdKGurqj6gevdwUTOOqdm6Lh0VM7lMpivI
	 jIyDg0puYgxdTh2ayaGpge27bTpkZaJfsE6sFd3aqz183nG+G1byQxpokcBfetjSb7pA9
	 6dVkX8qvpW8cYEAC7GwG4WZFt5R20/NUScRR2bAiukS3mzjdLQL0x2znVklm2kaFux8Az
	 mtTgCsB5GagRVLiBArFJHbmvOVUI3u2JfEFtAtwM8ONlsUYhSUN+IOxTtQlsmy7eoOc0C
	 Ok+L7FtYzjQks3lnAHcViRk6P7YDmlb+8xOWvvbrmZT2knFZ+mCP2AMQGKrFluHLGzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=NbubZkQl;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A67D606A336;
	Tue,  3 Nov 2026 17:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A67D606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=NbubZkQl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=NbubZkQlUEOdJDMa2w0FJklSCq3F8E0J9XDfTO/UeWB9xlbh7h2Tt/wkVHUdKIkK1jVs/P9SBbkpD
	 oWFstvP5uFdjdKaoRuLbnDws0UIlKwKw04MqnZ1eg4WfSDbtF3hyO984RQhD0h2dI/zMXecuzG2XGW
	 6YouqEPiumja/KSk=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66aea15c5b68-62320;
	Wed, 04 Nov 2026 01:11:39 +0800 (CST)
X-RM-TRANSID:2ee66aea15c5b68-62320
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHB-W5100250 (unknown[36.137.216.21])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56aea15c0a1f-00c2e;
	Wed, 04 Nov 2026 01:11:38 +0800 (CST)
X-RM-TRANSID:2ee56aea15c0a1f-00c2e
From: Gu Bin <gubin@cmss.chinamobile.com>
To: acme@kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gu Bin <gubin@cmss.chinamobile.com>
Subject: [PATCH] perf data: fix inverted strncmp() in has_kcore_dir()
Date: Wed,  4 Nov 2026 01:11:26 +0800
Message-ID: <20261103171127.1628-1-gubin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

has_kcore_dir() scans the perf.data output directory for a "kcore_dir"
(or guest "kcore_dir__*") entry and reports the match in `result`:

	result = d ? strncmp(d->d_name, name, n) : false;

strncmp() returns 0 on a match, which coerces to boolean false, so the
assignment is inverted: `result` is set to true on a non-matching entry
and false on a matching one.  Consequently the loop stops at the first
non-matching entry, causing the function to incorrectly report a
kcore_dir for any non-empty directory even if none exists.  Only an
empty directory or a failed opendir() returns false correctly.

Both callers in perf inject treat the return value as "the input has a
kcore_dir": they enable copy_kcore_dir and mark the output as a
directory, so for an input directory without kcore_dir the copy is
attempted from a source that is not there.

Negate the strncmp() result so a matching entry sets result to true
and the scan continues until a match is found or the directory is
exhausted.

The prefix matching is deliberately left unchanged: comparing only the
first n bytes also matches guest kcore_dir__<pid> entries, which is
what the fixed commit intended, and matches the kcore_dir* glob that
copy_kcore_dir() copies.

Fixes: 65691e9ff0c9 ("perf tools: Make has_kcore_dir() work also for guest kcore_dir")
Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
---
 tools/perf/util/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 33fd1b82019e..d4948e1d0633 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -531,7 +531,7 @@ bool has_kcore_dir(const char *path)
 	if (dir) {
 		while (d && !result) {
 			d = readdir(dir);
-			result = d ? strncmp(d->d_name, name, n) : false;
+			result = d ? !strncmp(d->d_name, name, n) : false;
 		}
 		closedir(dir);
 	}
-- 
2.55.0.windows.3



