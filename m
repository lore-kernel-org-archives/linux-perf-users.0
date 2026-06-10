Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F7837BE60;
	Wed, 10 Jun 2026 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121204; cv=none; b=Z7QsqtgnyoCnYIYeNt8Sj9aVQCOvvgapExiEGkvfTixhDDkRv3UfpN4QZ9mO2SnCLd+D7LUvnBZc/Sfyk+GBowFIbS4BalmfdcgImGgGg1aT4U3h4rpJu+uHb3sPlt0Tohd70sW5+w5wEbZIHDPsfPKsoa5kB2QJwBAxvTUrs4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121204; c=relaxed/simple;
	bh=tSuNoyEus6B/PhxaI810nD2tj4zGzVYkVBkHmDSKz0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5trzTYNzLf41djF+iI0KBq0vHGy5A/qpBI5bSbLCkM5cI9D35OtWOqqIc5+MdGOf7/oGg4FN2E6i2/cOZR3yNZUD7LSVPK7tMWjtswwaggcwUvahu7yHQITbKmMF2EXP6kiygSI7aIpNEG25OT5gKefW+pFY1hTRRbj/c38pRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4a2HnlY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4a2HnlY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AEC1F00893;
	Wed, 10 Jun 2026 19:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121203;
	bh=e6pq4Pi2rTvQzgwveR9OLs8WTJXKO4Z+OmvvL6+9sQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G4a2HnlYCTEviNdTvw14pudrIxB6mHxbTCmnI+pnakJ9L8CpolnIb4ZZZQHAHtvfS
	 O0834DewF9gTb62UL9Lba3IrR+1sZO8xV7LislIdFGSn96rpH+0ro5bVAiT1W/midH
	 IBfkN2L0+AxwqZt2HSx3uG30gB59fPfIxgANUsguUvm5MC3fhRP07BIqCFh421Bc0S
	 u7urd+f3s7EcTr1ETnaAUO34h7fiMOahNW+m+0CmrcqYh/2i8TzHKmOFlwtBWoj0S9
	 HBBamN5NytCSAYQbh6x6s5H/0Hqrz4FUdbcIHSTeu/okoKHz2E9CKdyRG/Igks4bNK
	 wXRv5sU2ed6bQ==
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
	Cody P Schafer <cody@linux.vnet.ibm.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 15/23] perf pmu: Use scnprintf() in format_alias()
Date: Wed, 10 Jun 2026 16:51:48 -0300
Message-ID: <20260610195157.2091137-16-acme@kernel.org>
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

format_alias() accumulates strings into a caller-provided buffer using
snprintf().  On truncation, snprintf() returns the would-have-written
count, which can exceed the buffer size.  When used is larger than len,
buf + used computes a pointer past the buffer end — undefined behavior
even though sub_non_neg() clamps the subsequent write size to zero.

Switch to scnprintf() which returns the actual number of bytes written,
keeping used within bounds.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: aaea36174991ff39 ("perf tools: Extend format_alias() to include event parameters")
Cc: Cody P Schafer <cody@linux.vnet.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 4ddccc863727d6ca..2fce38140eb8af2a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2155,11 +2155,11 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 		snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
 		return buf;
 	}
-	used = snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, alias->name);
+	used = scnprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, alias->name);
 
 	list_for_each_entry(term, &terms.terms, list) {
 		if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
-			used += snprintf(buf + used, sub_non_neg(len, used),
+			used += scnprintf(buf + used, sub_non_neg(len, used),
 					",%s=%s", term->config,
 					term->val.str);
 	}
-- 
2.54.0

