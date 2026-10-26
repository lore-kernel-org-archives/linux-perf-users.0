Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792997471;
	b=vff91XeGM7Hr/cUby1IvbYaVnk3zeo5PClfiMSXUEgFK+yGdMysdmw0E8CxU8m/ABdhn
	 p82aQfO2BkRx47X6JYTheJKmAf8KhenMcxZcP+ZT84sdRnxKzLnuqdkU26VfuAC2CEUJt
	 6xRgfLtAy9UlCvHqkJ2KKwIsxo+IZNkdxdezH8ozd67fey17LRTPHH9wXqanoI3SIgclI
	 oAoxDEZOCOaWXZLVM2u3PVHJHVyn6sX0EZA5sFuNLPEe7hEWhKoodq8Zd9d/sd5otXtnL
	 jOr0D1srP9XzHoAa9wUy6suIwG20mEQP686xfdayftielzbgLF/WHW8MABpH94g/6aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792997471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=6c1yu8R84Uh/fs3ZooZsqGmwAQ1v3ZPKfyNO3gcjqXc=;
	b=j97ifQ6IZX5ffbRyx5BFaFzkbGuhVzk+NQjfjamWBGC47hlfvVlfWQYHjfHyMaWRb9f2
	 no2XAePQUGwGYzTNj6/ZwdWfw2uVyoMooeeLdBqW38iNlbARzQ7mOc4nW96jocdQkQJI6
	 VGp8cm+iPNBjWVATzDMp1aVHh1ro7jx2OA2NAqculM+EaQy2WXTtpBDFU7VrPgHvlb4kw
	 njmO4TgJD3t//wdQ+nLbCME/1wqul3gZdCeWEdmPax2w979uTrE/aMaWCuTkayo6Hl5oz
	 w6WU0IFNkUmlSBNoeKHBQJ+7eM8cQObxQxnVXwhsrTkNvPwK+XwvDNvl9UUm7Sp5jkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=l7DYYyfP;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB44606A32E
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 06:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AB44606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=l7DYYyfP
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so2768858c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 25 Oct 2026 23:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792997470; x=1793602270; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6c1yu8R84Uh/fs3ZooZsqGmwAQ1v3ZPKfyNO3gcjqXc=;
        b=l7DYYyfPinPzxtXW3WWw9Be28OUx7htOkozWRWqTda5nrXGpii/TR6m0p7JJVWAzkg
         mCLaUyjtWQXnrhp1aIMED3nxIRjBTIk9lgJm+gWOG0pHz299yzCXOB2VOtefKsGocl0i
         mATMit7uy2XkqQ5Y3a6PpQxgtWT2Tpdgz4fkaYdiOBps9q82ohKjr5/U1hCpgNZ7Wnnd
         TcKRwCRgb6GO1DB+0HbAkwHx7uIswHDS5u4a6W1J3uh/pf/l0shE+kYMTUIYTB2dqpRK
         N3QvkILMNTuWz+ZFg8ES22gZJY0rzA5Hehowxe1PHOHByxKn2p7CQmGoZ33stKa9Vhut
         QCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792997470; x=1793602270;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6c1yu8R84Uh/fs3ZooZsqGmwAQ1v3ZPKfyNO3gcjqXc=;
        b=10uh4YAg3PoPbSSc2WbXCaT08q9kQ0VOK8ZOsKRvEf9A+edrdVBCM9E05eBtlTZa1D
         Ytkugx6jh44WUxHHi6W2m0qiPja1pLpZwyXguVyUnvL9FRilZ/Ds8gUhbICqreixxnYG
         Z/wsgpdYQI/CpyfUHfoox/CN6ijhhsHxOqwyH2QzUDZRFhDkUHw3y9ijll4rwj4u3zbD
         Mbt7Abc2gFaj3IG++acJYsQIAgNjAZ03qp+Pa/lVrs4l3OyspsdW3HcDxEMTwpmUnz+A
         kUokJePxCNbRJTGrrD/tbPHgLltv5lSq7TPTOtpWwiunPbpFZKQPEjhHXDHuIc5gfsK3
         6srw==
X-Forwarded-Encrypted: i=1; AKwUvBxaYBqlA43NS5RKS/S/AlSRrEJFFHGseN8Pcl0WUAWzZRChJ1ujEVIOn6OcuwnL1wJBUaBHxVOmlbIyI3alYXFJ@vger.kernel.org
X-Gm-Message-State: AFq9FYJdGVRAAeE9FpvxM9Pqoo+ZcOHeM9MwMtRUghDv2Bc8ZUnOOqWE
	m2D8rT9peBnLEVrCHEvoHC2MiacmAepDLzJPw8zPplk33feXvqq7OIgQsMGTzeZ7sPV2MH0PimJ
	3PPQy6QZylA==
X-Received: from dybpl8.prod.google.com ([2002:a05:7301:4308:b0:359:72f9:2aa7])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e888:b0:187:efba:9ba2
 with SMTP id a92af1059eb24-1993a1e41acmr9779931c88.44.1792997469362; Sun, 25
 Oct 2026 23:51:09 -0700 (PDT)
Date: Sun, 25 Oct 2026 23:50:45 -0700
In-Reply-To: <cover.1792995775.git.irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <cover.1792995775.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <efe1d231090ef4dc43fe1f002a12c7c65c8ceda2.1792995775.git.irogers@google.com>
Subject: [PATCH 3/3] perf hist: Do not delete cumulative caller entries before
 stat_acc decays
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alireza Haghdoost <haghdoost@uber.com>, Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alessio Podda <aleph.pi.gh@gmail.com>, Michael Liang <mliang@purestorage.com>, 
	Shimin Guo <shimin.guo@skydio.com>, Tanushree Shah <tshah@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When symbol_conf.cumulate_callchain is enabled (the default in
'perf top -g'), callchain parent/caller entries have he->stat.period == 0
and accumulate their period in he->stat_acc->period.

hists__decay_entry() decays both he->stat.period and he->stat_acc->period,
but only checks if he->stat.period == 0 as the return condition for
deleting the entry in hists__decay_entries(). As a result, every callchain
caller entry with 0 self-period is unconditionally deleted from the
histogram on the first decay pass, destroying its callchain tree while it
still has non-zero cumulative period.

Only mark an entry for deletion in hists__decay_entry() when both
he->stat.period == 0 and (when cumulate_callchain is active)
he->stat_acc->period == 0.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/hist.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 443694926f1a..e75a4fcce975 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -409,7 +409,8 @@ static bool hists__decay_entry(struct hists *hists, struct hist_entry *he)
 	u64 prev_period = he->stat.period;
 	u64 prev_latency = he->stat.latency;
 
-	if (prev_period == 0)
+	if (prev_period == 0 &&
+	    (!symbol_conf.cumulate_callchain || he->stat_acc->period == 0))
 		return true;
 
 	he_stat__decay(&he->stat);
@@ -442,7 +443,8 @@ static bool hists__decay_entry(struct hists *hists, struct hist_entry *he)
 		}
 	}
 
-	return he->stat.period == 0 && he->stat.latency == 0;
+	return he->stat.period == 0 && he->stat.latency == 0 &&
+	       (!symbol_conf.cumulate_callchain || he->stat_acc->period == 0);
 }
 
 static void hists__delete_entry(struct hists *hists, struct hist_entry *he)
-- 
2.56.0.307.g5fe7bd680c-goog

