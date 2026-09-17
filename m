Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D90239E80
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627383; cv=none; b=A3nrVFcKNvhOMlcmzXmoBZO6CHC4yrit31VCPdMQz5Dhn83s1fB92rHTWjiYlhF+y9hrcmfyvY8PaFFBWmXW64CDSiuUCI8fO7cHmdyelBc5GtIl4nb+CLb7pQmhJvnwrjVK+cifTufylxX1qTZSwEZpaeXy6BdXkzj75JupmUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627383; c=relaxed/simple;
	bh=Efwg6Lp4URje4K6ap1NY7WHw9tf5g4FaF0Uk7IwjA5I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lpA83W7x3co54JLSvpLeSfv+GyTBLVJysFVVJkggIMei9Tzr5Xp/70tlAprQGyQ/rsHXbOC7WsMYWGePLBGvRnVKgQwevGvh/AjvFZpS8+USybRZbZIoyfZEsipH3mVfSCJ5Is10Iom+XtLhi+yKaqwuQ/cto7Fdzn+dVp4EnLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KPcz8wpy; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KPcz8wpy"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so756132a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789627381; x=1790232181; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Aji62SWFx1lY4aZnTGM78az2i6brsVbPSUcmX+4ftqQ=;
        b=KPcz8wpy8e+zWZnq1guMIyqtclqam5iDNFqK67z0LTFx9Zlu+jjWkXe3Gu1W30hGO6
         sqBV4UUMrLH5xmbyh3h4vxMHXtDZBfsENCpBkljnlOnfVMHWSXoWlMEU41Q0TXk9nMqz
         s0POZy52AXVTYgElOs90tGCxneWPPblJkHmgKiqRDWSuZ55biWfuvoUX4dbtYU/s0wfV
         Y0j20UcIiBe4P5fs+g7ZSiGfSPr5gLBWswrl51u+LTGimAwcXJ1N1AdC1VmDcMFoubhs
         q65rUQXdd08K49ItKD6N7N3j//gwibf0W+ChFi3IcmcnrDoK9Xrp9h0eL/z/lmOLv3Ts
         LWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627381; x=1790232181;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Aji62SWFx1lY4aZnTGM78az2i6brsVbPSUcmX+4ftqQ=;
        b=lqx+WHIOXYHGqyHYxX0d+cAjISYJcOKsQRcO7L5+9CKe9TOphFaK9g1Nr6xKJMDoGW
         TmYX78SsIuNODpQjX/DoogeDfgWptEJkKXN0zGlfd/LDW9nfALfD11O2jBXnGTO1PPAK
         5+01exXKWdiK6HfoB/EQv8hKrTnV618GGDQIONAcukY07yeUW8DIIvy2Vi8WeJXltdc3
         Y1vE7Y1kcvIACjfdXcs73D1jOhr7i90c0ycDGn8/tTPKe1h5WpNxFImmKw1zQI1ywshd
         bzt9aO3moMzd68CTeQ5+Wo1lZ0NKDvf78b9zBQYG+ec6Hrl6TjbBvEvf3kIedfckDLhu
         I1yQ==
X-Forwarded-Encrypted: i=1; AKwUvBwh8jv0p51GoSIH1Wd1wPefVqmmWezsy7+BU0d4o7RRNs74jwkImUxsJZ0Y/fqTWdYZ+Jn5JRyhOSEuwOPYw4H+@vger.kernel.org
X-Gm-Message-State: AFuF++lS/3PcNIOxpjilx4nrB1lO26WlSNmFwIODFgOAdsKQQ4NsRqOO
	nLQEpWwkg7pd+JuPFtnbHu132aVVATdZVwLAQk6De4RqcH7cRGL5rpB1ib7lrOSQ09sTi6sNV/W
	FdHhC/zRGEw==
X-Received: from dldyq26-n2.prod.google.com ([2002:a05:701b:455a:20b0:144:58aa:2e86])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3885:b0:39d:f253:ed66
 with SMTP id 98e67ed59e1d1-39e1e51d828mr12013395a91.22.1789627381072; Wed, 16
 Sep 2026 23:43:01 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:42:29 -0700
In-Reply-To: <cover.1789626977.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789626977.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <390cfc25923c5be2636ee0bd59a0b33d29ba0e71.1789626978.git.irogers@google.com>
Subject: [PATCH v1 07/13] perf test common: Do not globally disable tracing
 events in clear_all_probes
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

`echo 0 > /sys/kernel/debug/tracing/events/enable` disables tracepoint
events system-wide. When running tests in parallel, this kills active
tracing and recording sessions in concurrent tests (such as perf trace
and perf record).

Remove the global event disable from clear_all_probes().

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/common/init.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/tests/shell/common/init.sh b/tools/perf/tests/shell/common/init.sh
index cbfc78bec974..d2c7a31e2c6f 100644
--- a/tools/perf/tests/shell/common/init.sh
+++ b/tools/perf/tests/shell/common/init.sh
@@ -132,7 +132,6 @@ check_uprobes_available()
 
 clear_all_probes()
 {
-	echo 0 > /sys/kernel/debug/tracing/events/enable
 	check_kprobes_available && echo > /sys/kernel/debug/tracing/kprobe_events
 	check_uprobes_available && echo > /sys/kernel/debug/tracing/uprobe_events
 }
-- 
2.55.0.1082.g2b9226bbc0-goog

