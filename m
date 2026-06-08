Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C5E1EE7B7;
	Mon,  8 Jun 2026 01:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780882276; cv=none; b=kVVGBO/rHm81ZJD41sLXBrzDdaKS24m3qOqFiIKOv65j3evi65c6EpD6y8yni1YHELcZFtFMvOOgtRtm5rZg3sh1PEvgg+g85A+jMeF31tKOEFD3zbtIlaoHdrZ8AHbmXRup7ZIZtkDL6DKUbJeo2icX3mAAIqpX5a33ksN6n60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780882276; c=relaxed/simple;
	bh=5VWP2TekBIjJm70E0VzMP3ju0hgOjK8Wt8W8C1t9uZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swj5Nddm0w23C5I9fndRIOB5jIfbo44GmynmoLP2dxq7HTB0JJWGvsxwP3+Oy7BHWR+9vUJfd/KHaAgfxxPW9tC7sPECNW1cM1NoxkAG0jfQFDHTxp8d5rTqOPjXSc7kOAj7DXmIaaA4YNrGIK093mecqsiwP8JgxamIXO/+F5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYftv8dB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYftv8dB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070101F00898;
	Mon,  8 Jun 2026 01:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780882274;
	bh=R5WxjEJlqlEk6iV+ivR2s+nGEBp270wPJyGXkOmIs10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cYftv8dBlzwg5+wiqn8FzvtM1I9ETC+R2JvOAtxFVQgYT56c/mR7lBCdBI46ugl1G
	 cwGZGHrKnfFiow9U9NsNDmOHA0TzEF5F5bAzH8K/X/bNUZgUyghg9+mMG+NkzRtrGl
	 nJRUKJoX8k94bUS2+k7Fa+aXbRxL9GaIHUjzQfpPNp/mApWd0CQSYeb3KVHxbDuXHW
	 OMlveSHTa/bSaRH7L9JL+s1F85MEATL+3o4kOOz912YYVQ1Yw5C8Jau8ZiSSLEAmTt
	 2YcVNvu31JZPQSmO4/tLMuFjT6PAZC+dO8Cuk3oQ6Dh0T5MPBQ8qOuarLvzBsiAIbk
	 zOzQcDoAo7zLQ==
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
Date: Sun,  7 Jun 2026 22:30:45 -0300
Message-ID: <20260608013057.1942953-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608013057.1942953-1-acme@kernel.org>
References: <20260608013057.1942953-1-acme@kernel.org>
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

