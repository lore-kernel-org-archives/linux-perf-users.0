Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6DE25C704
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 23:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764630703; cv=none; b=ZuQ/MdVHIs76I4Sm25hp5GXbk9FwmNS4daUQ1TL5OeOFBoRUwZSrOw9NlyjzjcNJaQ/eU94ZeBNXg6qKbh98yjzYSaDFTrLbZ7kGyX43KDXPN8r28E4UFvd814lCFN0PfdwhblMQlnNWhXQEUnMmVZiexYCQyfBeNsXOmc+fxpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764630703; c=relaxed/simple;
	bh=uMZz143jWc52luqVLAtJT9U2+4OfZDNhG31QyEH57oY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=rckaFBgrtmHZO0phN42NUlEL1SGJVygfwmPWuM1f++Pyo9tHPZ6euBPUO78lYB7yaNZZvfUpl3QpQJskCiMGX+fbX/ItRWIVtAFEmAmt3298k8WELuDOqSreMOBUXI/lajsA/CpxqbdY1SCQ+hw9DNcV7Bsg6s0LcBivvonfJWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iw+aCYJh; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iw+aCYJh"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso6538743a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 15:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764630701; x=1765235501; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qvrcYzJX4HQd95gXath2BIDINA9x1lNmgQSwyPq3BcY=;
        b=iw+aCYJhb3ccM90xx8eiaPMeiGzvC2E2az5Evbtt3VwHJ4d8Li6I6Yza49hNAr3DdD
         EA6nnwUX9/9Q3UHy9NUesJORkGAq/zvZTnjFMOCZJpPEmIqQamF0XUR3lexeXxdsgRac
         9KRHopyMKGW8vA0XbDWT87w+L0WBBKb/dRqqM3yVm5eK/ULQM+32CinJD1C+KMmr0nx/
         GiuNGRYJCJMZJ/pZZJI0fokIfFc94iS0F7NhAKTg8esfEW392gqeJSR1riLopcRYLxqN
         /npONrFsD3PXHuGLAFeONRMQf8PrDcdwAaYgwG0ShzOWT2jmFfwrAddUln9aY97ndwHY
         GKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764630701; x=1765235501;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qvrcYzJX4HQd95gXath2BIDINA9x1lNmgQSwyPq3BcY=;
        b=wFbNvTAm+jhNmWMn3+3jpiFHL03FUhCWZLALTcoksoDWWaqTZT5bwdPDJ1IZRPPWG8
         T3XrKSNyw0npMXmxP26DiRjds7yLu060Op1kdLNgul9XX/6pHf8qdE68sM3VqCIU9alp
         eqXrlZRpN4yLwVdZuYfkY0hvzSbZQyDfS5PcwPawenoNMM3IJMmiBW+PLf7TU02aRLmG
         mgWZPXDu9lAeN+i8upSVYAAAktRdfNJ9M7QCih0moxj35hUfjElPBIIfShfl6FsOlbys
         yaf4ybbhiJ6+IP/HhbDdA6l5tvgomXoX2zwSaaxMLu4aDUttULv4xlV55P3FcBnr2ivx
         IyUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6rMO2iLwg+Z+fvQeeNHk5mMciY8KpLBjR/Pv8YAVT9RJBY0afEHbhTU3W4TidlSWHwRpRaryciWRai+r4IoqK@vger.kernel.org
X-Gm-Message-State: AOJu0YwmHvuwUqJ4y3l6ZXvLNmpreynTfDdaukCtao8nn4UPQz6+iMQA
	F2J4jOlu+Vxs1h6knD2zaZOsWnTU1l/zTpYR5mH63jZDjBDMLoXJAe5JbICV1NvXCzjMWg7XyFm
	N/aVC9w7zBQ==
X-Google-Smtp-Source: AGHT+IEhFTw4uLES7YC4xtveOaW/ZNPK2Ajlq2jGh4lhwhN8iyHF5TXqmGNa6X1yA0hJBPaifOCQ+1DB4S+C
X-Received: from dybfx7.prod.google.com ([2002:a05:7300:c387:b0:2a4:75c7:9884])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e517:b0:2a4:3594:72d1
 with SMTP id 5a478bee46e88-2a718aea47amr16201978eec.0.1764630701279; Mon, 01
 Dec 2025 15:11:41 -0800 (PST)
Date: Mon,  1 Dec 2025 15:11:36 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251201231136.293248-1-irogers@google.com>
Subject: [PATCH v1] perf test: Fix hybrid testing of event fallback test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The mem-loads-aux event exists on hybrid systems but the "cpu" PMU
does not. This causes an event parsing error which erroneously makes
the test look like it is failing. Avoid naming the PMU to avoid
this. Rather than cleaning up perf.data in the directory the test is
run, explicitly send the 'perf record' output to /dev/null and avoid
any cleanup scripts.

Fixes: fc9c17b22352 ("perf test: Add a perf event fallback test")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../tests/shell/test_event_open_fallback.sh   | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/tools/perf/tests/shell/test_event_open_fallback.sh b/tools/perf/tests/shell/test_event_open_fallback.sh
index 9c411153c01b..9420a7557c13 100755
--- a/tools/perf/tests/shell/test_event_open_fallback.sh
+++ b/tools/perf/tests/shell/test_event_open_fallback.sh
@@ -6,24 +6,9 @@ skip_cnt=0
 ok_cnt=0
 err_cnt=0
 
-cleanup()
-{
-	rm -f perf.data
-	rm -f perf.data.old
-	trap - EXIT TERM INT
-}
-
-trap_cleanup()
-{
-	cleanup
-	exit 1
-}
-
-trap trap_cleanup EXIT TERM INT
-
 perf_record()
 {
-	perf record "$@" -- true 1>/dev/null 2>&1
+	perf record -o /dev/null "$@" -- true 1>/dev/null 2>&1
 }
 
 test_decrease_precise_ip()
@@ -49,7 +34,7 @@ test_decrease_precise_ip_complicated()
 
 	perf list pmu | grep -q 'mem-loads-aux' || return 2
 
-	if ! perf_record -e '{cpu/mem-loads-aux/S,cpu/mem-loads/PS}'; then
+	if ! perf_record -e '{mem-loads-aux:S,mem-loads:PS}'; then
 		return 1
 	fi
 	return 0
-- 
2.52.0.158.g65b55ccf14-goog

