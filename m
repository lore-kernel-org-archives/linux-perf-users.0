Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794599630;
	b=NMDEz0RFbp3EjIRsPklFkyR4Al+y8Cl4okC5CC8KuwGGfu5GMXqkCnGTs71JUloAejzN
	 4baRil5DZ0UnkBIQ/YREVZN2NB4u4Jwu7apY/Y1eEdFaWqY+UOnZnXb8yP/xCeyQBRCLV
	 Xwis7HowhSLTyPHNx5a/pIKnGOtCWsb9QCrSoxQmExl5lMSTqbLHNovbnToo9xDmr2XAF
	 wg2MMBi0DK/YeBTVs5TIvIoiFTi3zm0UlvPdYrqum1VP6jH8ArIv+i2+y6ttWVH6Lv/Jw
	 TAQJQxi2yFoeOTpdKq9dU2MlrXJhlqXLRJuAjRL8r6dcxkZyVwxN5DEIA4Z84E/V9QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=6O38ETLEbj32ufhG7MyecNbPniPzbxOSw7ptiJplfvA=;
	b=VL+qZqMtTJxIUkzgoc5t6M60oNyc7H7gZxWZKNBU19mOJVGVF/VJD2U9cSbDHGiogTZL
	 T7hy4BXuC7mRq8VkTDRJORHnDZin92D56B4sBMp2IOZvInz81dCa/UFVZi19UNRVPiZvj
	 0hZ6PmL3QBCRZ2PB0mit78V/yIKliphiHpIZAKWV3H6raRZNupwtbYpGr7QMKZFRE/VNR
	 IcJaTEifFZSPSfLLjzG1D8GzNyx8X/ZCtf5tPMznTz5fSMdMgy8rjD/uYCsLqO/d+6tuV
	 UMERHVp+Fm9y/LHjMpzzPihHXlt+t/0hYAuqC3ZP18ihsR/tWv0z1HA352MoBVtksdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UIc+KZIn;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9836560A260A
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 19:53:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9836560A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UIc+KZIn
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36d1353fdcdso5889027eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 11:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794599629; x=1795204429; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6O38ETLEbj32ufhG7MyecNbPniPzbxOSw7ptiJplfvA=;
        b=UIc+KZInkfeSJgsOHmWiulrirJAbIp9dI6rhRqKPFFI2NOCiuIYN0u8I6Z8K4CBD32
         vl9EbQ3PS+mddtf6yYgnlOaZCBKaE07O+K8kPnG8SAI4c/mYVeTpcNFk4nKvuxABLGLz
         bifS/FD57HYhJkEjnI/1yxtfgCCsH7/EW+qA1W46eKV1ineweol54mlUF7F7Un6QaHsU
         1DUGr7ixIzDXK1St6DBfy6cUJNp9cbk5+2/vH87h/1y6L5YKAnEuESzRp9U7asUJJQgn
         itTQHcaI5eFZwIOzqUzcZDM51hfhAsjSoLKXvDm+qCc/GXTN6YPKk/RDheuhtSm45UkT
         dZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794599629; x=1795204429;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6O38ETLEbj32ufhG7MyecNbPniPzbxOSw7ptiJplfvA=;
        b=jkQpRa/mi5hwwijxGOlIBSHJY9q7rvkyrC2B8Np0xwOLYmYZnldoxxyEuUXs8lodNd
         W435o2WTwF8tDp4wkZxjuvjgw+Htd4oQjBA117XkRGiOaXBT+UElsOoPUBUUXm+bFXb4
         ijgk4IL55T2XBDtgt8OfJgAfR0q07w06oH2+y4rvIyemUjqnaDzndYLVtUWkNGmKqime
         555DozoCWvTYNMvPc5adfBCsjrLC7H24BVc8wxnrphbJUI4Vjah335xd6RlKgLsILIju
         LdCDm9yxP3EDlsak+aIAVvrSM5ZDWLes3ENJPpheGNfJkLnkvQUNfsuKXKK9bZPWI8gD
         zoqA==
X-Gm-Message-State: APuU4Z/UHTtOYFYZDMA6742O3CDyyBo1pf/+QqY3SGZNaUH3Hsc+xj2G
	5IOeQ4r/78WzOTfyJUHhfwHcHKviTQrYpo5Y9ktNYwAIdWOf01aAIUXaUxQNl99AWkIaw00UFka
	nGZLt/QDh6g==
X-Received: from dyhb22.prod.google.com ([2002:a05:7300:1496:b0:36a:ead:4dcc])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:fd09:b0:36d:4570:a32d
 with SMTP id 5a478bee46e88-37963953f0amr2866228eec.2.1794599628447; Fri, 13
 Nov 2026 11:53:48 -0800 (PST)
Date: Fri, 13 Nov 2026 11:53:09 -0800
In-Reply-To: <20261113195335.2865725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113195335.2865725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113195335.2865725-5-irogers@google.com>
Subject: [PATCH v2 04/30] perf metricgroup: Don't prefer tool events for
 displaying a metric
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

pick_display_evsel() selects the event of a metric that perf stat shows
the metric alongside, preferring an event that isn't a tool event, such
as duration_time, and that is used by the fewest metrics. A tool event
used by fewer metrics replaced a non-tool event, so whether the metric
was displayed with a tool event depended on the order of the metric's
events. For example, CPUs_utilized could be shown alongside the
duration_time tool event rather than cpu-clock, and cpu-clock not shown.

Only compare the number of uses of events that are both, or both not,
tool events.

Fixes: c8035a496141 ("perf metricgroup: Add care to picking the evsel for displaying a metric")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 779fe56fe8d0..98f3ba8f9533 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1388,8 +1388,10 @@ static struct evsel *pick_display_evsel(struct list_head *metric_list,
 		struct evsel *candidate = metric_events[i];
 		size_t candidate_uses = count_uses(metric_list, candidate);
 
-		if ((selected_is_tool && !evsel__is_tool(candidate)) ||
-		    (candidate_uses < selected_uses)) {
+		bool candidate_is_tool = evsel__is_tool(candidate);
+
+		if ((selected_is_tool && !candidate_is_tool) ||
+		    (selected_is_tool == candidate_is_tool && candidate_uses < selected_uses)) {
 			selected = candidate;
 			selected_uses = candidate_uses;
 			selected_is_tool = evsel__is_tool(selected);
-- 
2.56.1.703.gf848ed807c-goog

