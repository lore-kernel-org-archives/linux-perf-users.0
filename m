Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCC9391E76
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775633214; cv=none; b=qmO3JJfMIxAY35CoWFG2Z8QTLeCTcknzc4kGYCX2zIR7tRdqtP3NGchmNedSvyatdg/dXwLNC/6FqSH6M09LR4GJSYfAW8ngS6+o4lqGT/1ZFabzEmDlinmltF9aIJmlGtmukFIiva6qHY3bPWYedleoKkHBmv1ECBArOmcvS4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775633214; c=relaxed/simple;
	bh=0Keft5t7OBXgX7YaxEhWnWuQSKMAek/Moq2pD9h81W8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BQD5H3vpTgO828VzoUjR0Jio0CP+FjCy5/3PxxrqZ2AzaqPFH7xz3GsMi5r9QK2ce3OfZp++3wlcvnqpLfma+NiuqYXRcVl7HjkPqXMwKmyBdqgYj9c2ypDd1nZ3guXylWuVv24wWZRlixDvURvjiCQy6MwvzZIZ+3ya7FXgRTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSpJ1VNS; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSpJ1VNS"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-127133794b6so9651780c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 00:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775633212; x=1776238012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DD9DzZmqkeGtfBm/333ve8pZcjoUvLLGIPaFR8uqSWs=;
        b=rSpJ1VNSncqDNPbjCcaL1GD7Acp0aslhJbFyQ5f7BR4TqFWx5ocqIjKbCXLXxHS4VQ
         Eo0EAsDxzWiif2e+BkM+QkNSNou8b66yr9KuY3GQIgEEglfWtidQI5PpxnfbM+f8dTQy
         msom+gkzRT5vvQ/HjBTU2wvV1+7PM13p+YPhL78mmf6gc1zBh8qGlAhbMiSeIIwGp78K
         vQSJcO3jtDICsjukOhgOsucvsunUFkQ+4fja7BigjPPn/G+RLy9g1xCfWscCYm3WzCAJ
         ceThPNU3S4NeRq1D/THkDLjGVrHqRyFyaDL4pSKCEWWIjv+HDLPK/ZaejTbRbzVJRGjK
         yEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775633212; x=1776238012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DD9DzZmqkeGtfBm/333ve8pZcjoUvLLGIPaFR8uqSWs=;
        b=N34m/SszmZdIEH8X23qmpC/I96Uk3p0dIDKelQqxUql13zPKz4OFTs23kn5x+YOy5X
         QMDwkMeKtqfpJ9PnbuPn23XEMMy677ZeC1BoJEW3Ax8NgSUyxQoGvbxU+S0zd/z+ndOG
         AgUXkLyT51ld2Kx9PlKu1/6KllEqB8qvAe9UfPOsoiXgKtztpB09uXKoHgY7Jcq9NOCn
         4fqnbuUOeBaQChK3uP85sb9ZNp5DjHrN0Y4jcl4bREA2I5oS5RQ//B7ZgHkW8F27SvNA
         HD3o1to5eIGkBVw3m4WNQhx93c34s1fjHlEnBSg5JgvHHwWSW1y1cfjNFXt68nKh0BNb
         CovA==
X-Forwarded-Encrypted: i=1; AJvYcCUN9TKTF5G2UwhKzjTxl6lPU1H4ENf23gFH1H/m6X+ggb2EYguXY4Lxq8W9s7hWX5Zgssl4iZZQD17G/AbNEC9E@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2aoFHZ0shOWeFYVPSOOnl/wxL/K7GKTYcyeiOxmD69xU+KVvu
	OSsArmK5KOqfpEs+RXIGt/UUyqpLSaFh5boEGZuaFsGihRMNCHsS40Hev0pwcAzoHi6AkRKpCDA
	A9uNRkgYCkw==
X-Received: from dlbts22-n1.prod.google.com ([2002:a05:7022:b056:10b0:12c:211d:3e86])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:52b:b0:12b:ee92:a60e
 with SMTP id a92af1059eb24-12bfb6ecb28mr10371316c88.8.1775633212028; Wed, 08
 Apr 2026 00:26:52 -0700 (PDT)
Date: Wed,  8 Apr 2026 00:25:58 -0700
In-Reply-To: <20260408072601.210837-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <adPyeCq3rQrTurju@google.com> <20260408072601.210837-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408072601.210837-21-irogers@google.com>
Subject: [PATCH v7 20/23] perf evlist: Try to avoid computing evsel from sample
From: Ian Rogers <irogers@google.com>
To: namhyung@kernel.org, acme@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

If the sample has an evsel, don't recompute using the sample.id.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-top.c           | 4 +++-
 tools/perf/tests/mmap-basic.c      | 4 +++-
 tools/perf/tests/switch-tracking.c | 5 ++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a66666e89f67..f8bca1cb5769 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1164,7 +1164,9 @@ static int deliver_event(struct ordered_events *qe,
 		goto next_event;
 	}
 
-	evsel = evlist__id2evsel(session->evlist, sample.id);
+	evsel = sample.evsel;
+	if (!evsel)
+		evsel = evlist__id2evsel(session->evlist, sample.id);
 	assert(evsel != NULL);
 
 	if (event->header.type == PERF_RECORD_SAMPLE) {
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 3313c236104e..a18d84d858aa 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -142,7 +142,9 @@ static int test__basic_mmap(struct test_suite *test __maybe_unused, int subtest
 		}
 
 		err = -1;
-		evsel = evlist__id2evsel(evlist, sample.id);
+		evsel = sample.evsel;
+		if (!evsel)
+			evsel = evlist__id2evsel(evlist, sample.id);
 		perf_sample__exit(&sample);
 		if (evsel == NULL) {
 			pr_debug("event with id %" PRIu64
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 22b0302252db..e32331fee277 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -138,7 +138,10 @@ static int process_sample_event(struct evlist *evlist,
 		goto out;
 	}
 
-	evsel = evlist__id2evsel(evlist, sample.id);
+	evsel = sample.evsel;
+	if (!evsel)
+		evsel = evlist__id2evsel(evlist, sample.id);
+
 	if (evsel == switch_tracking->switch_evsel) {
 		next_tid = perf_sample__intval(&sample, "next_pid");
 		prev_tid = perf_sample__intval(&sample, "prev_pid");
-- 
2.53.0.1213.gd9a14994de-goog

