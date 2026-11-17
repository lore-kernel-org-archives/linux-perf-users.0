Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941391;
	b=0PtfwibEmC0TNpjggYWad5RDe5m27smaCSywIZtzMIMdXII6IZXyfSUdQ8I7WV/foRa7
	 nGFtJSE0B7b/jEuNTGDeo2wm9BkTlDVLooXJ+1L7DPoP8KkTKC+neVnAC69ZDZjQGRYVp
	 cJ0+9E9r6GWFpj7l+SWoEmftcYCGzVBaOBiDwHgvp4cyuvi+JEfx2+x31CQPBWSNAE+1j
	 d9cC4aKgsvsmEDFn+hiymn+FzfhgFTMdvhC7l67/hjBIwXA1wOJ6hXP+BKbkXxBG0ZWnR
	 GimJ2yYhPaQM/Que/BMeaFt0UnelD9NsN5EJTAhfAOhsljTMTIognmXjd6dPtx2GUsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=fE96Bwoq4dvubLO/ytQscTwlirtJcyD7QHCmaubFJQM=;
	b=v9CbbYnmo/hxyuytL/xECUbSVbpcM2/v2O3fc/FmtNmY4UmRvXhRvazvHjejjWQjvLYB
	 hjoR/OKjexwXYQxs+s2aI6/Gu8Jz8qNvaNjkGwbpx59F52IPBBmsAyoy4SjGSF5qDs1k+
	 XaJtFklBvmB9gd9YCWKPLk7xywLgZuvhemBXOoFmiTDtUOJfPEchoWMRjOmVqhd30zcxW
	 ek926HC3joTO23OGDuRGkZKwG+gjK7wgutLBdUaV+3s6wSmH6uLRTE4h08I2vCIPkGuuV
	 bHbBZFjGjDtH/NSNkpAc0UGR1LP/4j63JcAwmXZ8CTVx2iNjFokdrPyGNGDqw3paBDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WW1MgN0E;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBE760A2630
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DBE760A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WW1MgN0E
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-33713e5e6daso270177eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 10:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941390; x=1795546190; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fE96Bwoq4dvubLO/ytQscTwlirtJcyD7QHCmaubFJQM=;
        b=WW1MgN0E610Ng/mUsdrMraSskJo17fZb1fON7UEmlBFyhEVKKchyibrIoPxMSyHET5
         thKIRP1YEZt79vZKCCim/zvSYsvxMduKm31ec5DGc2qP9ZWg3WrzigM8Oh4bA4SXU1QH
         HC49ZsHIKiK2gk+hqXR68p4l2XWMI3a0vTDWF6g+nskYW2WyEo40yskAlm/R6fhdzFiF
         pUV98xaovmjJqptj08FUKzpRz9Yp7oKtoEjH8u/g1db9D+gBDegs9yU6/yRkvCmQh9M6
         AEPcRMMf8dKHJMveKVvJH8jadIt/Ium6pGwaj8yTUWmHr49Jybhij42eDvL/d+Q55Hvk
         P3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941390; x=1795546190;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fE96Bwoq4dvubLO/ytQscTwlirtJcyD7QHCmaubFJQM=;
        b=rYC5TUX/r57HdPoFmLy2d5XLlBT0A1EmNeOAhLRInf5l4z5CsYThDt22USIJRg+m+8
         BzB+FxSMsrstX5BzOXL7tpGWOljzGi6ZOT6mQVsbSNifZa+S/SSIpxsSFjaXcmZE2rSL
         u0lOkFVBq4V/tepcdpMVA8+gANOjsAAlxQXaAdbsnMDFUprU4KSD40X5z9El2lXYT1Yx
         NHP6GHL3ZAWE1CSwTCRG6SG3BlBhts5RgmWTI69BV4Ose8kfn3aLfua82j/1mmuyeuZS
         N9RCOCMZmSps0ojZfcZX8ItPL0u9j2foWsjll1ECd/KiUOXIPVXSmWDQ2eboAWF8a5/j
         motQ==
X-Forwarded-Encrypted: i=1; AL+hErH3mv5oSinVlZhOmbXtHxbzPVa4D5y04TErvQMe/Hdh9U3LSa9WkSlSyHpTOH+81bAHj6I4rFrCEFr/qHvVuxlK@vger.kernel.org
X-Gm-Message-State: APuU4Z8mdnJdcr9SIprXMHWXzTeKBw9pM5OQx0b6DQXBcl4HoH6yPG8L
	JEdIRVnSVt0xYkFGVPb24NHaTWWJXqR0hoAA4xiKeXZQIKjpLaLIPUg0NUeu+Jzq2qBS1TnNerD
	eeNJnK/b6Zg==
X-Received: from dycnd10.prod.google.com ([2002:a05:7301:c0a:b0:343:520f:7a80])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:804c:b0:378:2e89:3958
 with SMTP id 5a478bee46e88-38280f22793mr277558eec.19.1794941389993; Tue, 17
 Nov 2026 10:49:49 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:44 -0800
In-Reply-To: <20261117184844.99889-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117184844.99889-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117184844.99889-24-irogers@google.com>
Subject: [PATCH v14 23/23] perf machine: Add __guarded_by annotation to machines->guests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Annotate guests in struct machines with __guarded_by(&lock) and mark
machines__init() with __context_unsafe().

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/machine.c | 1 +
 tools/perf/util/machine.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0cc593d5372a..70870baa157e 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -234,6 +234,7 @@ void machine__delete(struct machine *machine)
 }
 
 int machines__init(struct machines *machines, struct perf_session *session)
+	__context_unsafe(/* initialization */)
 {
 	int err = machine__init(&machines->host, "", HOST_KERNEL_ID);
 
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 80191545ee8a..67d517742fb6 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -3,6 +3,7 @@
 #define __PERF_MACHINE_H
 
 #include <sys/types.h>
+#include <linux/compiler-context-analysis.h>
 #include <linux/rbtree.h>
 #include "maps.h"
 #include "dsos.h"
@@ -153,7 +154,7 @@ struct machines {
 	struct perf_session *session;
 	struct rw_semaphore lock;
 	struct machine host;
-	struct rb_root_cached guests;
+	struct rb_root_cached guests __guarded_by(&lock);
 };
 
 int machines__init(struct machines *machines, struct perf_session *session);
-- 
2.56.1.703.gf848ed807c-goog

