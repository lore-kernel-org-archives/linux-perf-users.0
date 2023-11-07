Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57942358AB
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Nov 2023 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j5ptDbDH"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB15012B
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Nov 2023 10:36:08 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81e9981ff4so5999616276.3
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Nov 2023 10:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699382168; x=1699986968; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nvoe8zuzQD68UsZwn7syk08Ugz3HDvlC6EsBdsDkAvU=;
        b=j5ptDbDHZ4q2C2BUC5FnZV1JwcS6SZCaIuiapgFRKgZv5rvFpqPvQ5lZk2dFeyiKED
         oJwVY8G7/2T4xUncgZxg/8+JETVUYf74wBgBFGUELCzMcOAS032mLRrEu5f6Mv1W8WY2
         DCfR3G/k9Y7Z+89jRw6hfzOlV+QP6Xj5fyTtmeIa4jhND0aDhocswzGhUb9JgF8qjbRJ
         3b6F+WJV44vhozGQK8VKV/Et4lCn7R3oMU+MqpQOFDXYj7Sa7f9Sk4OOXjKht7KTNhT9
         gWgpLYbW296fGviaJqDmGI2CWABuwNe5W/mrNzZTCbVI927BqtnaJB9bb2VP8YYZDX/M
         /htw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699382168; x=1699986968;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nvoe8zuzQD68UsZwn7syk08Ugz3HDvlC6EsBdsDkAvU=;
        b=sSapJJDs6talmKaNAiVUF8BW/nvcUNyrXprdLy6NmY5Xg3yFMxtGPuxyg7vz/+rxio
         6YSJralZ7BJuDXXwYl6b6LNyNtnmMqagkooFqUgcpmJ+GbIsD+hMz767jJTGkgcAG3xu
         z+1IrQzsO+pSfi6BaNl4qsTpQZKr5k7+NIAMzhDnozVDqRq0FS/tLRgAm6hgqoInXW2p
         TY8yuyo721RelAWiGFFOmRNZARanGfvalLuLh5b8sHmSEXZV3KilGUyXEdZ0KpvQxDqC
         V2s3LsOevanKYXOkjrEb20tJ/KTzfyi0SaaXAUq1wi6oo7hFU+6U2lOjWenaktCDynQ1
         3zxQ==
X-Gm-Message-State: AOJu0YzzZTPxu5Jkbm5N3p9SGuAkYyjVub2uQg5YXQg4UPT1thMAr7F2
	pmg5iHEADc7fno3WzwKbFF+YSvxWfLM=
X-Google-Smtp-Source: AGHT+IFRRnefTI1OJ3Cyarh5zcrJx54/I32dAjRx9p8pXEs+7nT0L5MitcVUUOzjXKiwYBkd1gZwljim/Ww=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1788:b0:da0:c9a5:b529 with SMTP id
 ca8-20020a056902178800b00da0c9a5b529mr601875ybb.12.1699382167904; Tue, 07 Nov
 2023 10:36:07 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  7 Nov 2023 10:36:05 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231107183605.409588-1-seanjc@google.com>
Subject: [PATCH] perf/x86: Don't enforce minimum period for KVM guest-only events
From: Sean Christopherson <seanjc@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Like Xu <likexu@tencent.com>, Jim Mattson <jmattson@google.com>, 
	Mingwei Zhang <mizhang@google.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Don't apply minimum period workarounds/requirements to events that are
being created by KVM to virtualize PMCs for guests, i.e. skip limit
enforcement for events that exclude the host.  Perf's somewhat arbitrary
limits prevents KVM from correctly virtualizing counter overflow, e.g. if
the guest sets a counter to have an effective period of '1', forcing a
minimum period of '2' results in overflow occurring at the incorrect time.

Whether or not a "real" profiling use case is affected is debatable, but
the incorrect behavior is trivially easy to observe and reproduce, and is
deterministic enough to make the PMU appear to be broken from the guest's
perspective.

Furthermore, the "period" set by KVM isn't actually a period, as KVM won't
automatically reprogram the event with the same period on overflow.  KVM
will synthesize a PMI into the guest when appropriate, but what the guest
does in response to the PMI is purely a guest decision.  In other words,
KVM effectively operates in a one-shot mode, not a periodic mode.

Letting KVM and/or the guest program "too small" periods is safe for the
host, as events that exclude the host are atomically disabled with respect
to VM-Exit, i.e. are guaranteed to stop counting upon transitioning to the
host.  And whether or not *explicitly* programming a short period is safe
is somewhat of a moot point, as transitions to/from the guest effectively
yield the same effect, e.g. an unrelated VM-Exit => VM-Enter transition
will re-enable guest PMCs with whatever count happened to be in the PMC at
the time of VM-Exit.

Cc: Like Xu <likexu@tencent.com>
Cc: Jim Mattson <jmattson@google.com>
Cc: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---

Disclaimer: I've only tested this from KVM's side of things.

 arch/x86/events/core.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 40ad1425ffa2..f8a8a4ea4d47 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1388,16 +1388,25 @@ int x86_perf_event_set_period(struct perf_event *event)
 		hwc->last_period = period;
 		ret = 1;
 	}
-	/*
-	 * Quirk: certain CPUs dont like it if just 1 hw_event is left:
-	 */
-	if (unlikely(left < 2))
-		left = 2;
 
 	if (left > x86_pmu.max_period)
 		left = x86_pmu.max_period;
 
-	static_call_cond(x86_pmu_limit_period)(event, &left);
+	/*
+	 * Exempt KVM guest events from the minimum period requirements.  It's
+	 * the guest's responsibility to ensure it can make forward progress,
+	 * and it's KVM's responsibility to configure an appropriate "period"
+	 * to correctly virtualize overflow for the guest's PMCs.
+	 */
+	if (!event->attr.exclude_host) {
+		/*
+		 * Quirk: certain CPUs dont like it if just 1 event is left:
+		 */
+		if (unlikely(left < 2))
+			left = 2;
+
+		static_call_cond(x86_pmu_limit_period)(event, &left);
+	}
 
 	this_cpu_write(pmc_prev_left[idx], left);
 

base-commit: 744940f1921c8feb90e3c4bcc1e153fdd6e10fe2
-- 
2.42.0.869.gea05f2083d-goog

