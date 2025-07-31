Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9E6241693;
	Thu, 31 Jul 2025 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753945420; cv=none; b=f+p9ifGt9uC6p0HAggvi6lk15MpiXmiFc1EepKQURnEx8gozugLEcLS90hw9Xk58BMmKh7KSde/f/t3xIViE7AEBCR4uvAnMGAUDh0g0cW7H6QR5BmCnDcXqQlQ86P1YHIFJVFyzakd02IhqwyhjOitwMywM+J6G5NJVegL+X4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753945420; c=relaxed/simple;
	bh=FSDKA2EDSEAoBRRr4Iyc/rYXzglYyqJCL5b+rykOgRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTISCvHji8V26q8JgaJ5OQAIzre8Eolm/ppuzRS2IiCZw88+HvLRbU0Pwq1wS+xEePJsotxRK1ZhP1OpxWpWYOWfNUahXD/7mBOhfhQTdR7dLOB4ptvLCPucOOSY0kELiCnxTCw3jebLM0wHb37Mv7bwt5mVxjdFrPNtOTFySWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpWXd4dt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpWXd4dt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54152C4CEEF;
	Thu, 31 Jul 2025 07:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753945416;
	bh=FSDKA2EDSEAoBRRr4Iyc/rYXzglYyqJCL5b+rykOgRE=;
	h=From:To:Cc:Subject:Date:From;
	b=ZpWXd4dtRchl0h/UMjnMDAxKughj5NJy1iSIM0o85Hfl/3w3nNrW5AqM2aKcPL+aY
	 gHrJWA5b0Mn5dlDR1XM0aHdhvMNlqh16pzE2pnB0eNVt+Q7ZAsQbR3oP1IxKQ8gOWZ
	 RvGPts1ycv0ksmWu7isb7p32afKu6KceCOiZzMZU8SD3UKm/pW5ha2y33Wu3vuvIcR
	 Ey9Q/HffxKA/A2oDoxzTXFdw1ZOZVav09p+Zx8T3GqIpL78nnmzbAekYE/QGXhf3VY
	 qZ9iadXNgsVuO7g+wb2rLChfg0/pGYdk4UwRZrT63Sa45KCXJuts9T8ml9D1olNHti
	 pHJjBZeboKbrA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf record: Cache build-ID of hit DSOs only
Date: Thu, 31 Jul 2025 00:03:30 -0700
Message-ID: <20250731070330.57116-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It post-processes samples to find which DSO has samples.  Based on that
info, it can save used DSOs in the build-ID cache directory.  But for
some reason, it saves all DSOs without checking the hit mark.  Skipping
unused DSOs can give some speedup especially with --buildid-mmap being
default.

On my idle machine, `time perf record -a sleep 1` goes down from 3 sec
to 1.5 sec with this change.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/build-id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index e2b295fe4d2fe552..a7018a3b0437a699 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -872,7 +872,7 @@ static int dso__cache_build_id(struct dso *dso, struct machine *machine,
 	char *allocated_name = NULL;
 	int ret = 0;
 
-	if (!dso__has_build_id(dso))
+	if (!dso__has_build_id(dso) || !dso__hit(dso))
 		return 0;
 
 	if (dso__is_kcore(dso)) {
-- 
2.50.1

