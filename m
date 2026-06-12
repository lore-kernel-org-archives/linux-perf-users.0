Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198D43D25AF;
	Fri, 12 Jun 2026 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781303088; cv=none; b=ZkcHFPTKqtmSZRmLvzBaf+qblMylaDOQyWgxLY1JoEnE42nORG9X6yBMHycTyK+GiF3307KZekdelFg/my9Xch/Ezdi4qKqWUrRsNJqOxYtPDrSq6AG9sWfxrHxAcXknWBS1srbOz9YsBdDO/tZRuC83auaGzAnyECKoByF20Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781303088; c=relaxed/simple;
	bh=GPQL6kuquXgSoupC/MydkLZ8edpQzukBi1PwfjKRsA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hM0RINlB2rjrA6xTR0e+yw2gpFkPtY3OdplUxrmJWIr4Evq9wEFhWiHzjzjMn8q/aEVFW4cpMc3Iw1yjLTMBbvCdDLcu603oaAJMv8aXQItmKCh6Go1Mlq2QDt3E/+tTmRFPpZ4ViV+ILgAYD0XP9kUMrFxOWbsJjqIUr2tPi7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgkbPfkI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgkbPfkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7906B1F00A3A;
	Fri, 12 Jun 2026 22:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781303086;
	bh=5+8eGUHAU69i6rx7CDdOyZKaiIeecP1hshyCWJgUUbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BgkbPfkIn5/rSosGlNpLikt0PLgioqN0VRLtFG5iSMJkM7hfPQVux6BJWIxy191da
	 VUcIcjVNvmlCuNQ7iieXmiYuXA+mp/EOsbykuF7fWJceira7mKU9bifNO1xzt/xDct
	 kHK+nrR+r9D5I4PGb8b04Sqno8pICl0bINN+zLehy0321CoHpFcwAVBfsOmwG9Vu64
	 f+3liObBCknqksUx4Tu2SM4B3zcxAR8BcV30TgR0SdYY00/vxyL278dNdkbhecP0e6
	 +bYyepijDaJBZWkE1HGrSNq6gIC3pVkVOOskCJeh27HSNVLJV57uIYx4KcALiiMseV
	 SHew6A9Nuibsw==
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
Subject: [PATCH 07/13] perf hwmon: Fix fd check to accept fd 0 in hwmon_pmu__describe_items()
Date: Fri, 12 Jun 2026 19:24:06 -0300
Message-ID: <20260612222413.40791-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612222413.40791-1-acme@kernel.org>
References: <20260612222413.40791-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

hwmon_pmu__describe_items() checks 'if (fd > 0)' after openat(), which
incorrectly rejects fd 0.  While fd 0 is normally stdin, if stdin has
been closed (common in daemon/service contexts), the kernel reuses fd 0
for the next open.  With fd > 0, the sysfs file is not read and the fd
is leaked.

Change to 'if (fd >= 0)' to match the standard openat() error check.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: 53cc0b351ec99278 ("perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs")
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hwmon_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
index efd3067a2e591050..ed544dca70c380b2 100644
--- a/tools/perf/util/hwmon_pmu.c
+++ b/tools/perf/util/hwmon_pmu.c
@@ -435,7 +435,7 @@ static size_t hwmon_pmu__describe_items(struct hwmon_pmu *hwm, char *out_buf, si
 			hwmon_item_strs[bit],
 			is_alarm ? "_alarm" : "");
 		fd = openat(dir, buf, O_RDONLY);
-		if (fd > 0) {
+		if (fd >= 0) {
 			ssize_t read_len = read(fd, buf, sizeof(buf) - 1);
 
 			while (read_len > 0 && buf[read_len - 1] == '\n')
-- 
2.54.0

