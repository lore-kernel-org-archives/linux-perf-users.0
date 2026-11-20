Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212836;
	b=yYukIT//jbf3SKV7VarwwJifAEz4fpBpgJ51EcI8lze5oYNFmUp40vjj3d90qyEXc1W1
	 GFrCulfrgrM8K8Ju6REVw9tmChgTNdbwol8f3gYzckYoyxkB6ORqu8/pdGSVOj1aE3CbI
	 yhCVGbwVyjfX+tir/Iaus5QFMgD+ZZ867lKkR9Z5wnmYdrVDVSZ8pPWRhmcWfiiMvDPYI
	 tqvGJpsoU3iQMF1EtHAU6YQeErN3XE60mtDp/8fnZ7gmo3GxyIcyWHFesjwoIy/Z/FZ9S
	 BqJrHEynYuBX3vT/06TBPAKM5KIMD8YKVlx85tjO5cM3Hu+XkNlnKzdQqo3puZdHqcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=qZdMAm29i2lB188sbmGGTc+2IJf3WyF7WYFVB9nwzmw=;
	b=hbQNpBLh/8TDfeQ5XgIdU1uZuFO9LmILSiofcOqQWGejoxnn856nC3/Ed+1UwsYvnwYa
	 jZROf0Msb2vuu/Thbo4SJ/ZHUqvHiGqK3bQTNZ4KfhZcb7SlR2BBwju4oeebM1ZCegF+f
	 JHPvLCdXkS2tMVeMgTIy/Y7Bz1ljqF8GiPgT5HMtr6ry/4oCj808yVuoe9JkITx32G3fB
	 PspWCUjkQms6Fu66P0x1bxuwmewoTM6ySMqDOu18ckhnlu9EF2/p3tY8JBlU82uiV4jwV
	 9xNMBFnGyHxE7lW3f0Svfc/8OpErSUV9i3lKoYP040/RYfUZBd8QImnn8iZcWJTIaDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WEtgcrIk;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C5606A6AF
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 22:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 080C5606A6AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WEtgcrIk
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so2138639eec.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 14:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795212834; x=1795817634; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qZdMAm29i2lB188sbmGGTc+2IJf3WyF7WYFVB9nwzmw=;
        b=WEtgcrIkVFQTqXNb3RiVYhcNLtxmqjybnhFcRSCqB19B2dnO72V+8JUXIVQesJR54T
         RWXU4QtQghYyIi0BLW0RW/VdPKM33HSaBSgYJ2TobNmpKe5p4CV0iaXP0JeQE6OmczvD
         ncLQZTWTIFtCJosQR6x7xr1ecj5QuDT5RSGmcoFfIIn8uVPuDF3ZGJNub5bjMRi6v3ZR
         5tJZAkfrTnOljhdmFoEzYFWtounRgFOu+FCIc6ojbOcMlesoIC6e+YAkcew31zwDrWua
         oePg4fxbTACeZrBxcn0ZrOCSugGlBZRki7mcLl0KVLDUcNBE8q6ZJfUJaNfdEOR5xpmk
         TFSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795212834; x=1795817634;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qZdMAm29i2lB188sbmGGTc+2IJf3WyF7WYFVB9nwzmw=;
        b=BncEzFu/bY6SvNIWF0sFJ4WWTafBz78bOf69ES6HcE5AYW0UBVdZLHtEQtmMNqEaDm
         u2tIAIiCgSa5JxAO4tZ/q9dfevzyacjoutZrmxP09t/wH+CN2qPKSb+ccIr83msVpUoT
         sYHFkaJBAMTNNwV8EewFlgT52aFM4Dru2//BKymMBFP+lOmela0ituGQFxfZ40KSxc1s
         UVp4mok3/qIAsSEchNCTCe5NlcAy9Um812udIU/0i3dbEuGeYVNgITfALZjm6KHHoU/E
         TteG3PbZPWZLTPAZtsHar3bfe9rDMypnCI8tjIZq7Ozb9cTBfUeVpu1L1r8dGaMwOEEs
         Z3Yw==
X-Gm-Message-State: APuU4Z+/IM/zGXHPKy/i0MXKVWU+ECVcU5jo3iNgHW7cEzDkczBzwpio
	iiIZyrhV9QqEYlbAiqgSA4BHis5b8huVL4ow9lC9pswnCGF07PLoAg5stvGj2PQ9vRzrLf8GBnA
	bsdN9as3Rmg==
X-Received: from dyah11-n2.prod.google.com ([2002:a05:693c:83cb:20b0:384:337f:4c9d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d205:b0:36a:1f8:a56e
 with SMTP id 5a478bee46e88-3856fe564a1mr3602765eec.23.1795212833694; Fri, 20
 Nov 2026 14:13:53 -0800 (PST)
Date: Fri, 20 Nov 2026 14:13:05 -0800
In-Reply-To: <20261120221332.2245191-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120221332.2245191-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120221332.2245191-5-irogers@google.com>
Subject: [PATCH v3 04/30] perf metricgroup: Don't prefer tool events for
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
2.56.1.750.gf70dc682cf-goog

