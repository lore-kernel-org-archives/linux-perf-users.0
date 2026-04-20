Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2039BFED;
	Mon, 20 Apr 2026 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708547; cv=none; b=GiskU6QiEuqdppa8rMGr42xSXsuiamQJY83wyFM5RkLeqI7Yy5IIqTw00I4NXfgKQBTjxOnuLLkahkwIBRxjDmHhHkx3S2yY2GUvKQ9d9Xv/SjRo3p5W8zs2gKneRKpzi0U6/ZuTmK/gSX1c6rGYzBEzwHZ56yw1Cm0QnK4Yf9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708547; c=relaxed/simple;
	bh=ugXANQpGDWXWXLhUDxqaXGflX7mG8CbTgtz54WX+3fM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qCPUdHtMbIzcDUWRQ6b2jXJ1YHjdJSVGSse+6f3KMAMjOVIn3JJM3UkSZJcHk27HQanOudesahvDYFpmy5pxA4WBgirrXy6AtGu9wyCrXQX6vjr1itxk1RTgSr9vwfUA+OIW10dFxopPbJlI06Bq5VnUSJWt2b4niBVBu9g+yfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpIHmBrW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpIHmBrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B60AC19425;
	Mon, 20 Apr 2026 18:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776708547;
	bh=ugXANQpGDWXWXLhUDxqaXGflX7mG8CbTgtz54WX+3fM=;
	h=From:To:Cc:Subject:Date:From;
	b=JpIHmBrWMY3EzlkDsxGohkhCxh9F/o9ZdN/EDHRGa06oGyv63SiPh0x2J1RR21NSm
	 PoceLn4JjqDluNcCyVgaORxq0o33Gw79GHKeWIyBq3vfz8MYY0cQ0I7KT12DcKidSf
	 bzVzRN/iIAF9F202nj0y85m8u+FVNjJWcjKQ3FroFfhhDDijyAGEttPrrkVLKx1hw7
	 GOcKgMLoxkNGu7DgZ5demzTpm97awPgiVgOoVUrMObduqsMQ+5h+9oT11w0AV7F9Il
	 hIIKBQGORSiHpwEq+boTAMntAPKeHsINy3jq5Tm3ox3YFTDtY0IUuB+DjmbPJeGHNn
	 QBlVgr/FQ0qfg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf build-id: Fix wrong return value checking
Date: Mon, 20 Apr 2026 11:08:58 -0700
Message-ID: <20260420180858.129075-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The {sysfs,filename}__snprintf_build_id() both return the actual length
of build-ID.  But in their fprintf counterparts check with sbuild_id
length which contain a terminating NUL bytes.  So they cannot match.

This resulted in perf buildid-list -k prints nothing.  With this fix,
it can show the following result.

  $ perf buildid-list -k
  9524074000cb36cf2559a5b52f0555dab47da553

Fixes: fccaaf6fbbc59910e ("perf build-id: Change sprintf functions to snprintf")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-buildid-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index a91bbb34ac946360..8ad39ff9a4b8a4b4 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -61,7 +61,7 @@ static int sysfs__fprintf_build_id(FILE *fp)
 	int ret;
 
 	ret = sysfs__snprintf_build_id("/", sbuild_id, sizeof(sbuild_id));
-	if (ret != sizeof(sbuild_id))
+	if (ret != sizeof(sbuild_id) - 1)
 		return ret < 0 ? ret : -EINVAL;
 
 	return fprintf(fp, "%s\n", sbuild_id);
@@ -73,7 +73,7 @@ static int filename__fprintf_build_id(const char *name, FILE *fp)
 	int ret;
 
 	ret = filename__snprintf_build_id(name, sbuild_id, sizeof(sbuild_id));
-	if (ret != sizeof(sbuild_id))
+	if (ret != sizeof(sbuild_id) - 1)
 		return ret < 0 ? ret : -EINVAL;
 
 	return fprintf(fp, "%s\n", sbuild_id);
-- 
2.54.0.rc1.555.g9c883467ad-goog

