Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86577332909;
	Wed, 10 Jun 2026 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110343; cv=none; b=UlVbrb6hQZarXdldMm1oJu9pcyRYQCKiXMlukmVc9Zj9IXbeUzya8MsHToRr0mtlEhGwK3ORGzdh/CpNK9f7etFSR/mwSfMBylALI3N1hgMxl5s96YbweUJfnxwdZmoyeWI3fgFVQgTCPuCN2hpLW/B9zpwfXTbGfEjRj+Px+R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110343; c=relaxed/simple;
	bh=VC6q+mtq8KwC5Y4PLY6wDdpjHfEtE2CGjR6ZMYxBHMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJkhrZqXHIeI62LSHqQkm+f3QMfKH8sjyinWSsh3lDrHzXgFYR8irf8PGQCVmAsIO/T2q3lbqsIH04bi8TtFR3r8fV/+bmkweDHVfuf7DoCyIQOmonBZSbrMPZ9/+ioblM2loLkjcWEFVgw9kb0wesaC4fFOHuMeTiNz91Bfhdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4nVxycl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4nVxycl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D731F00898;
	Wed, 10 Jun 2026 16:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781110341;
	bh=HnEEYaaAEIVtR7qYXVTM1b0f6ONnauIaMoMKazEsRPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y4nVxyclrQLTnDhccHX3PcgeCDCssIGRXURR60HenLlctDp2ibWBKpGrExzYNC+qD
	 0k44Yvqg9IKUTlQlnL+uVb+i/wYynrjHofQvDvBWrBhOanlu1OO+pgJxxPjY2vw8jh
	 E79XlzxYoqSmcQ3k42cWuLfKDrLkLTHwRJoQXSr1jdgiI2OdFrbA+yGjcBNZdV6Dg+
	 QhRNngl9SWlMbPBxKkRqS5W5G3uLMA6wPRB3L8k4pv03KgDWXyxoAtgoGTpnX3CHZK
	 R1RbYCjNpHixX6ZMR3WXxs642hg4OiN+3G3F1UZ/tzg51q9bu2DE6EmkrELY/9ww1h
	 k4AVIaxqUmnAg==
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
Date: Wed, 10 Jun 2026 13:51:55 -0300
Message-ID: <20260610165207.2077258-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610165207.2077258-1-acme@kernel.org>
References: <20260610165207.2077258-1-acme@kernel.org>
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
Reviewed-by: Ian Rogers <irogers@google.com>
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

