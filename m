Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BF71BBBF1
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 05:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727760219; cv=none; b=mOYYiJMM69tNbQde0oqQwv90+uFFMXuAAmO3bJu0tSkGRvHOgcA1khu2NKwzmFKqU+iNU2NZWiJmLUdSndg/lQeS2zl7xli85j0iFaSDEpJHOjiptQpqKVFWA+byQ1gdjY0vpVeVc2zb7FWXmKzOYcsCd/V1e+A7eQ5xpW8auMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727760219; c=relaxed/simple;
	bh=3sJTix9+hVyh80kzwiZoBEnIVXZyPC2rJ0LryrXs4fY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Xv+FemG7wrt74zb1vkNv+ezRUiXelC8kOymI1dN2PMm9+tuyIjBymWjpGFxTRWEb52KLxToX/+2McDJytzhapDXUhVEX8+7kcbXHS4xZRI0i+4ZdGQk6pzTdgNDzd7MAZhbza/P945irnCRdX+BLt96sl2CCGfzZTporBqkdQlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMnMk1sm; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMnMk1sm"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e25d62bfe12so7615793276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Sep 2024 22:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727760217; x=1728365017; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EQMGtk6GwbaXhFywRtPjz9CEeNpxRP/qdOj8Kk4AmBM=;
        b=SMnMk1smLogyOYM242/SVzs2VobsyNZJTEKFsFqkG8gFtf2SnfiGSBSAozec8RYtre
         5YfvnsBUDpHfohldhl0l+tFBsyKYeDpVqnc38zoNrkgp2a83Re3pRmp/OMrHK/YRalTW
         WbsaiICN+ZrGfEiREx2zdMlw1WwmWlSShyab/xbVET2HcXhhPbGF4vhlZ9x5QnrIgHVv
         d29Sy3H+djfQvwU3dUyHiLIy6kUkkN5xuRIKLq04LecoIFkJu+/+xs1gyzjAo5O8o8+f
         lF7Wgu4NHytUTlRfH76hAmOSLdaiczcmgRDeOSXu2J9TlVf3EbsVNpneSr299rfqtzyP
         3IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727760217; x=1728365017;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQMGtk6GwbaXhFywRtPjz9CEeNpxRP/qdOj8Kk4AmBM=;
        b=fT665g4XHn1XLwEV3nHw6v7DezSZQnLG0FRjFFZvjGo/re76DPcwPnQDh5TOdCbhYy
         ritQIvIhoxMX8kML5jAs175BrWukaHZdBdcN0ApImF7dmvteXXIPT8B8IrIKQt4Hw/7E
         vig+Qjbg1J4VMcLapASFJBq9smMZm6kEY76XOtL9ZZGW2Q+/Egg5RRbB337PXB6ezuhq
         1evNFelRbDHcIPwHdPGcEEV9S4S4N2HvODS+7YuSEIXHkW53B0WzWiYq8YaM4/IcnXj2
         /tiBueX4jttE3w/9upibK/j1danLZPQivH/R62esN9+91ZuF/TB0mQC/PwAetkExriTJ
         hnLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGcsyDZdFmuz8pdppaDWQgfhjRbQ35RF3rFbzERYrHNnfLGkIfaLLZt5pWcIWc97Qut0y12AOepENYPN1IMYzU@vger.kernel.org
X-Gm-Message-State: AOJu0Yye6cekD5SSxnE07/gd5hMPxO+4ariKRTsTRigdWB9PIFmA5m/R
	OD/1+GJewejUicabj+bg86T5E5Jgf+Fu3/OnowD1UCGD6f/++vhyrZYveI5+UVDIbZLL9tpqWEc
	oHzc6qQ==
X-Google-Smtp-Source: AGHT+IEtJ5iHDU4WG7YqVYSBmkd2+4f6hQoz49uFn7BXq4j2kS3RcFmOmtpe5Dixo6yM80mfjOYYyRnT+UeT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f420:67c7:1eea:bb12])
 (user=irogers job=sendgmr) by 2002:a5b:f0e:0:b0:e11:5f87:1e3c with SMTP id
 3f1490d57ef6-e2604c8b9d5mr55878276.11.1727760217150; Mon, 30 Sep 2024
 22:23:37 -0700 (PDT)
Date: Mon, 30 Sep 2024 22:23:25 -0700
In-Reply-To: <20241001052327.7052-1-irogers@google.com>
Message-Id: <20241001052327.7052-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001052327.7052-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v2 2/4] perf test: Fix memory leaks on event-times error paths
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These error paths occur without sufficient permissions. Fix the memory
leaks to make leak sanitizer happier.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/event-times.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index e155f0e0e04d..deefe5003bfc 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -126,6 +126,7 @@ static int attach__cpu_disabled(struct evlist *evlist)
 	evsel->core.attr.disabled = 1;
 
 	err = evsel__open_per_cpu(evsel, cpus, -1);
+	perf_cpu_map__put(cpus);
 	if (err) {
 		if (err == -EACCES)
 			return TEST_SKIP;
@@ -134,7 +135,6 @@ static int attach__cpu_disabled(struct evlist *evlist)
 		return err;
 	}
 
-	perf_cpu_map__put(cpus);
 	return evsel__enable(evsel);
 }
 
@@ -153,10 +153,10 @@ static int attach__cpu_enabled(struct evlist *evlist)
 	}
 
 	err = evsel__open_per_cpu(evsel, cpus, -1);
+	perf_cpu_map__put(cpus);
 	if (err == -EACCES)
 		return TEST_SKIP;
 
-	perf_cpu_map__put(cpus);
 	return err ? TEST_FAIL : TEST_OK;
 }
 
@@ -188,6 +188,7 @@ static int test_times(int (attach)(struct evlist *),
 	err = attach(evlist);
 	if (err == TEST_SKIP) {
 		pr_debug("  SKIP  : not enough rights\n");
+		evlist__delete(evlist);
 		return err;
 	}
 
-- 
2.46.1.824.gd892dcdcdd-goog

