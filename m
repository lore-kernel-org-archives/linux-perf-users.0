Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778D5566A;
	Sun, 29 Sep 2024 01:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727572034; cv=none; b=rpSp9RfOj5jyh98SXSJTmbYqjK3tsvINotVxPQmnXTP52EJ8Dqv51nlmsAc8J+vqn55hkjjw+LXVog2kB85MGI9tWNOWqHsAx80xp9W4FKHnpC921SZ9y6fkLL/Lj1C65NAt8KL30I0KRR5jdF3XXKEgFPmHwsaX5tH2qfuBmSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727572034; c=relaxed/simple;
	bh=hTmqR77oFiyEbCsEVBw14WDY2v8FcP70Mml8JvW2rGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UWidad+WhuvDMTmMZfXubjIh1HYhcmM+DVHz+aajnns1N81KXJA/o8ZLErr0kLE4BhX9cL06mOn4VP1Orrn3SnlpY2wSW6zgenEwofSBsDl8s4cBFJ3xRtrzVtj14mjVo01c4UEB5JOdUCXs3PNlG0DXv6J242RNRiQTqPHNe/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=PQxOviIQ; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="PQxOviIQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=loBAEQ8XjMK91po1cPDTn1W0amEAW4cIC/JkA8QAxZ4=; b=PQxOviIQjXl5x28C
	TQhyflH9vbfQjd2BfiKi7T6w1XHtRempDfgV3n9NIh0cvJMxELkihf0FqjX/4RHA9fzk+d28PKHbq
	0zhIxSXBwCT8dm8fg+UvvdJ4oOkB55jCc6zFiZ0LnGzWcRJJQUxlp2jhkxPAfmSFjTb/MIaAnMO1u
	MmBeNja+WuVejQNazjGKUwxbz1SH3fNvptO7JI6+AllohTnB/hWJWK3M/w+FXFv/w7Etz7u8iNlLn
	Th4niRqbL0A2yinuU4IX9eoVxNQ7yLw5RflFyPXjxKYYhmvIRjVkLXZvP1pRtfzbH/qhl+vGSg4eZ
	9gGDQr16twGIh9E6Jg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1suiOr-007mTN-2Q;
	Sun, 29 Sep 2024 01:07:01 +0000
From: linux@treblig.org
To: irogers@google.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	jolsa@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] perf: Remove unused add_perf_probe_events
Date: Sun, 29 Sep 2024 02:06:59 +0100
Message-ID: <20240929010659.430208-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

add_perf_probe_events has been unused since 2015's commit
b02137cc6550 ("perf probe: Move print logic into cmd_probe()")
which confusingly now uses perf_add_probe_events.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/perf/util/probe-event.c | 18 ------------------
 tools/perf/util/probe-event.h |  1 -
 2 files changed, 19 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a17c9b8a7a79..698a92875374 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -3705,24 +3705,6 @@ void cleanup_perf_probe_events(struct perf_probe_event *pevs, int npevs)
 	}
 }
 
-int add_perf_probe_events(struct perf_probe_event *pevs, int npevs)
-{
-	int ret;
-
-	ret = init_probe_symbol_maps(pevs->uprobes);
-	if (ret < 0)
-		return ret;
-
-	ret = convert_perf_probe_events(pevs, npevs);
-	if (ret == 0)
-		ret = apply_perf_probe_events(pevs, npevs);
-
-	cleanup_perf_probe_events(pevs, npevs);
-
-	exit_probe_symbol_maps();
-	return ret;
-}
-
 int del_perf_probe_events(struct strfilter *filter)
 {
 	int ret, ret2, ufd = -1, kfd = -1;
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 7e3b6c3d1f74..4850e52f274e 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -159,7 +159,6 @@ void line_range__clear(struct line_range *lr);
 /* Initialize line range */
 int line_range__init(struct line_range *lr);
 
-int add_perf_probe_events(struct perf_probe_event *pevs, int npevs);
 int convert_perf_probe_events(struct perf_probe_event *pevs, int npevs);
 int apply_perf_probe_events(struct perf_probe_event *pevs, int npevs);
 int show_probe_trace_events(struct perf_probe_event *pevs, int npevs);
-- 
2.46.2

