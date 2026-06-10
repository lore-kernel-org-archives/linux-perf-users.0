Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C117B3563EB;
	Wed, 10 Jun 2026 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121138; cv=none; b=WtMVmqmWzRjMEQcx2GQrZIKoLuq8u9BYoHGhzdqBfKFhf6Qq5JY2GbClvhT5iWmWdUII1/SqI75A5F2Am7vCTCp3V6ujMz0YWv2B1pu2GKG6+zvTTxBClggXruU2Ut7b5x1Fo43FAaXCFiOwtpNO4k+biNQYI7bmIhgMsW31Qr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121138; c=relaxed/simple;
	bh=WJQnBquqrbGm0f6bQXii5NqAAP1Q6r9nqkm355YS9Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWApfcbKrxpti7DbnLkjq7M+drN46D/c52dTaP2DEB3ZGSxnxqJaQ34nyEaILVAu7oqn02QGFBzmd0H48at12ir3XrKzScqfWaLRBcT+xG0NXMaFFtYN97861bp3SJGt500uHzuvPp+xl9GNRkjTau4rLYUfwOUsyDBa1JLlKEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiYkDcTn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiYkDcTn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FC51F00893;
	Wed, 10 Jun 2026 19:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121137;
	bh=DlAjEgTMhVg4eLBqjolIXJ1HcApS+J3oidomX+qnl4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hiYkDcTnhhspJqnaAHa9z+Ngj63YwaWaUBIBplYJF34DhqiiMZLNQNLYUTHbzujJp
	 JaEQ3B8IbN5j1rtQjhPEiPkl5NSAl20FfWpru+IEzBvMO4K/+S2iYH1zylCzsfok2g
	 Hb1mP9XI0/bfCjKZ5VGHuR1DwHmjuBQFn48NwPo9uunDCkMU8JHcQJG9XJRFMuUUV0
	 A70/oMgZzNC1AdtzHJx05GrVPAqDHoGhZLqixejD3gt2PFuEvD0u5DuT83y/mAHQqL
	 z3onBoWzrwNnsDiPMact5RPcenx0EeAMFl0EQH6lShfMeh9NovnaeIviwPLgUiD/TX
	 5+WMNJju0HmVA==
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
	Stephane Eranian <eranian@google.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 02/23] perf pmu: Fix perf_pmu__parse_scale/unit() OOB access on empty sysfs file
Date: Wed, 10 Jun 2026 16:51:35 -0300
Message-ID: <20260610195157.2091137-3-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

perf_pmu__parse_scale() reads a PMU scale file then accesses
scale[sret - 1] to strip a trailing newline.  Only sret < 0 is
guarded, so an empty file (sret == 0) causes scale[-1] — a stack
buffer underflow that reads and potentially writes out of bounds.

perf_pmu__parse_unit() has the same pattern: alias->unit[sret - 1]
with sret == 0 accesses the byte before the struct member, which
may corrupt the adjacent pmu_name pointer field.

Change both guards from sret < 0 to sret <= 0 so that empty files
are treated as read errors.

Fixes: 410136f5dd96b601 ("tools/perf/stat: Add event unit and scale support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 50f54674430e6206..4ddccc863727d6ca 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -314,7 +314,7 @@ static int perf_pmu__parse_scale(struct perf_pmu *pmu, struct perf_pmu_alias *al
 		goto error;
 
 	sret = read(fd, scale, sizeof(scale)-1);
-	if (sret < 0)
+	if (sret <= 0)
 		goto error;
 
 	if (scale[sret - 1] == '\n')
@@ -346,7 +346,7 @@ static int perf_pmu__parse_unit(struct perf_pmu *pmu, struct perf_pmu_alias *ali
 		return -1;
 
 	sret = read(fd, alias->unit, UNIT_MAX_LEN);
-	if (sret < 0)
+	if (sret <= 0)
 		goto error;
 
 	close(fd);
-- 
2.54.0

