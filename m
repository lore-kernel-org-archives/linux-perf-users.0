Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716062580F9
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 23:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749684974; cv=none; b=n7F0lJ6AwcVLP+IvcvC0whVYDGZPah2eqadOXWdNNmEt+ImCuohleQg/DjUBygBFzPyBs4SatNTNJzSVze3XULs3O/ADo+7JR58/k0Em/83m/bek8QpGWUZ49n3VIVbERnRDinAFcYNCisR0HVQubpncPxwYPw/ztLX+S2sCSjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749684974; c=relaxed/simple;
	bh=jnoqpsnRou4yUAIKYd4Tc10EfUDP1xEmutztyHBeMwo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=WLqYBylS5nl1L/xMVxe1b584rjmD/d+5Ih7hxy+wTd5WuH4SoLy6cZohTfBnkrK9pfOnQd6vjI6qVUPIxSxyOAc9PlzXgtRfeUR5HjeEaGJjz3aAhcXo6pxqhG8x15hizCHzc6RDaZp87kwB68cx9tXIy3TC9DS1kVp7UEXLeK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rH0i8YIr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rH0i8YIr"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31315427249so404961a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Jun 2025 16:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749684973; x=1750289773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fLRN1+7xUO97u+aruukoPK/pNq11GhEUvIp7GOuFZws=;
        b=rH0i8YIr/GR2WhJF7atBAvHt91Z/gE0b+mekLvKFGB85abzxdCpL8XMH+K0vERTLbh
         vFbMJ5Kr6aKOagBa6BihNfFFoQL7GHy2zs6Nse5Esxf7flIh5gd6ieFWvqEkEe2DYgRH
         uAMYwEnHxrLYRDs9hLlvVuFPyb75ZrXEuLrFMQGknhb1nPoytTdKOpGOVyNQL9o4ftih
         WmqREU9Hp7l6O26s/pLI72T7JLfeoMbfaLHY4pvqQ15eBmhm1becY5DiYzbnkpdG/ykr
         6S0gEHXU37lQKedoPzN1ol2m8HuuPiKs5dU6Ud7Q66B4WASAoemd+E472ByINhhVLG2I
         TP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749684973; x=1750289773;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fLRN1+7xUO97u+aruukoPK/pNq11GhEUvIp7GOuFZws=;
        b=hwwzoUjYI+Ln95TeYeN3ZYhipHzW1qgIZsr5ivOst6ktCkdE+m/0xZ9Ou16ldmHMl8
         bA0PLt8ej9XEzh0xHl0bL1H6Q0OHYhDv+pqsoytjmsfF38XCo1jx6ggrZYyWh8/sVLKE
         zZqSlIo8Mlhhd3cxRlD3KYdqtb1ReEqiHc927c483n8MFrg3uWHUhOUcnkoN7B1lEqew
         B2HvyZYfeQNC6JjPrCVV5DvpnkUKSWIsS6n8HPJpZnt8eA4Czzm2Gm7NKyHCRRF72cw+
         me7hAhfgV1gS4V2gTpdl4M76OXE8YWmEBRKMFXBUIQ5g6W6MaSJ9xopSuwhilYPnAph3
         Krjw==
X-Forwarded-Encrypted: i=1; AJvYcCXC/5S7H1zzLwK7I7dW6sY9oE5e13rn44lFAdP6hoMSqWsHd2kpm1t9xX1PnGp2onjsXdlv6vq6GN7Qix4HJkyG@vger.kernel.org
X-Gm-Message-State: AOJu0YzJWe4LZvxByJpgMs9UzS4/Bxrg8hhGDvD1/DLTOrWAxfvs2QJW
	53lHuEOmgUET2D/y+VaqwEtu8sZRKwuACwEVmNHA5m1ubrJfas1lc4NxyJD4PlIhCdmh3m7aqAQ
	WFRp0zg==
X-Google-Smtp-Source: AGHT+IGWetIUGkcTAEE1BtWo62T13R2WKFcG1h+M6UoNF2rX+2iuTUZBeoyXT0ekM55mM5b0TePWuyplLqI=
X-Received: from pjbqi5.prod.google.com ([2002:a17:90b:2745:b0:311:9b9e:5384])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5249:b0:301:9f62:a944
 with SMTP id 98e67ed59e1d1-313af22d449mr7778810a91.33.1749684972778; Wed, 11
 Jun 2025 16:36:12 -0700 (PDT)
Date: Wed, 11 Jun 2025 16:32:16 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611233239.3098064-1-ctshao@google.com>
Subject: [PATCH v1] perf stat: Fix uncore aggregation number
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Ian Rogers <irogers@google.com>, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Follow up:
lore.kernel.org/CAP-5=fVDF4-qYL1Lm7efgiHk7X=_nw_nEFMBZFMcsnOOJgX4Kg@mail.gmail.com/

The patch adds unit aggregation during evsel merge the aggregated uncore
counters.

Tested on a 2-socket machine with SNC3, uncore_imc_[0-11] and
cpumask="0,120"
Before:
  perf stat -e clockticks -I 1000 --per-socket
  #           time socket cpus             counts unit events
       1.001085024 S0        1         9615386315      clockticks
       1.001085024 S1        1         9614287448      clockticks
  perf stat -e clockticks -I 1000 --per-node
  #           time node   cpus             counts unit events
       1.001029867 N0        1         3205726984      clockticks
       1.001029867 N1        1         3205444421      clockticks
       1.001029867 N2        1         3205234018      clockticks
       1.001029867 N3        1         3205224660      clockticks
       1.001029867 N4        1         3205207213      clockticks
       1.001029867 N5        1         3205528246      clockticks
After:
  perf stat -e clockticks -I 1000 --per-socket
  #           time socket cpus             counts unit events
       1.001022937 S0       12         9621463177      clockticks
       1.001022937 S1       12         9619804949      clockticks
  perf stat -e clockticks -I 1000 --per-node
  #           time node   cpus             counts unit events
       1.001029867 N0        4         3206782080      clockticks
       1.001029867 N1        4         3207025354      clockticks
       1.001029867 N2        4         3207067946      clockticks
       1.001029867 N3        4         3206871733      clockticks
       1.001029867 N4        4         3206199005      clockticks
       1.001029867 N5        4         3205525058      clockticks

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/util/stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 355a7d5c8ab8..52266d773353 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -527,6 +527,7 @@ static int evsel__merge_aggr_counters(struct evsel *evsel, struct evsel *alias)
 		struct perf_counts_values *aggr_counts_b = &ps_b->aggr[i].counts;
 
 		/* NB: don't increase aggr.nr for aliases */
+		ps_a->aggr[i].nr += ps_b->aggr[i].nr;
 
 		aggr_counts_a->val += aggr_counts_b->val;
 		aggr_counts_a->ena += aggr_counts_b->ena;
-- 
2.50.0.rc1.591.g9c95f17f64-goog

