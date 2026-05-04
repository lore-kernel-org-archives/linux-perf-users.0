Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91162E1EF4
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879803; cv=none; b=ad+quqAEtFvX0nTjoFc6TXXUJXrtYlZwGZxOJrebgK76d22IiBeZLOY9/Ha8WndY/SdIsypIbMb9wxG6B+XIpoPpY1XTk001+dcrgbslx17wI+F148VvrXnU3yYHp2Yb34Dsz5rUHhhPEe6s4GNFMldEQSpzb2Om/CmhIp+q1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879803; c=relaxed/simple;
	bh=c9ejlYjPiFjsPhz/yehQpWJw1IyWFFw1CL0F74SsqP4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hu5IPJ67eE5IEcrsyQTRY4DpN4710K/7LMooLP+4Wdmz/fvehPjuVEkuYsqaSORgr0IZGFm0ZU3XSo3VI0GIPj+M1tZ/3Lfmkk5es7SdkKxWOiuIztOb229SLc4XkqrUSBt2FAQRZuXPw8syCbBmizHw3jiqbKmE+WCFAXIxhOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T/Ucbmm2; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T/Ucbmm2"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c35f2c09dso4930059c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 May 2026 00:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777879801; x=1778484601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vkt4oU+hEVEUN5xjbaGhASHDDjx1y3R0jVDB1yo0F0U=;
        b=T/Ucbmm2mmSSJgk/g6RDzcY4qO5lsVNRfNNIHXsHd0Rp5YHDHL0OmjKNZoV1aa4rJc
         DvyNXUp68m3fhOPq3Jc0WOgg4U8IvswRKR9/f9Tk1xIHakcfjQhF0fDp8YWW9IxegS7W
         6r59nOUYj9Y2LJujEGoqCUG9gO52YHiCHNzZG+0bD4+lw6J55wmj95tlP+HP0X74idYG
         8zhaG0hR+jqfNxz8HT+iIKJZj541kMWb0HOw0Kc0bJlZjax8yelSpxImFK1I30HmgJcJ
         x+/QmVXvmhZBgUwywKOJgNJBXasylCm/lazQ0QBqAttrOUgLjPAm9Fppi/LUJU7Et01a
         8U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777879801; x=1778484601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vkt4oU+hEVEUN5xjbaGhASHDDjx1y3R0jVDB1yo0F0U=;
        b=FPPyeMu0thDUvpA0tmcqLrO8pFwOC9DIf4KdsYsUiK6Nw69NcNb4UOeiriZvEEI/Ta
         efgREqcbR6juZnqtYnkHFQkzs8L+3CgFneFuIuDXz0zjXSpJvR85qIhkAHMwe23jq5gy
         27JfCqkKpFcglt6fJNifWyXE2DCrl9xonY14aj5qxRG6fvFBM6xaPIgh9Y51AQtPzEZq
         bgExI+FSLBwjAOnmBb4X8FWU3zscQFErKSuO80uDZjlY03uZyfFZMB465jTU6K5kPCpL
         V5czhYZvBDuossj37KDqfIZtkVlkETZz4NXX0wMLq6EfW2pmlqXfK6eTOT/RQGh5IXWW
         /oaA==
X-Forwarded-Encrypted: i=1; AFNElJ8bylqxy0Vn0WxnUb8C7p9R25xRsbc6jaqeGaARxBLAmKJNggqCmlzO2CRA+LT9U99UvkAK8a88/FwkoxrKFm2A@vger.kernel.org
X-Gm-Message-State: AOJu0YzaZE2WDZ/pTeDR4yH41vDJgSQUNuhFDqAYytqSAXmDtTO2otAT
	AJGhTn38TkxLP2+M00Lbdhe7/oIBu0pULa7Qd2t5nbWQXL0nXqKLTwjs0QIn8BjIfnQgBw8o1jI
	PfSWZJpzgiA==
X-Received: from dlbrl9.prod.google.com ([2002:a05:7022:f509:b0:12d:cbbc:2a7b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2401:b0:130:6904:e82d
 with SMTP id a92af1059eb24-1306904e8bbmr620839c88.31.1777879800803; Mon, 04
 May 2026 00:30:00 -0700 (PDT)
Date: Mon,  4 May 2026 00:29:34 -0700
In-Reply-To: <20260504072937.2103453-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504035125.1851720-1-irogers@google.com> <20260504072937.2103453-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504072937.2103453-2-irogers@google.com>
Subject: [PATCH v4 1/4] perf sched: Add missing mmap2 handler in timehist
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, gmx@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

perf_sched__timehist() registers event handlers for options using the
sched->tool struct. It registers handlers for MMAP, COMM, EXIT, FORK, etc.
but completely omits registering a handler for MMAP2 events.

Failing to register both MMAP and MMAP2 handlers causes modern systems
(which primarily output MMAP2 records) to silently drop VMA map mappings.
This results in uninitialized machine/thread mapping structures, making it
impossible to resolve shared library instruction pointers (IPs) to dynamic
symbols/DSOs during timehist callchain analysis.

Fix this by correctly registering perf_event__process_mmap2 in
sched->tool inside perf_sched__timehist().

Assisted-by: Gemini-CLI:Google Gemini 3
Fixes: 5bbfec0ad93c ("perf sched: Implement timehist option")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-sched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 555247568e7a..241c2f808f7b 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3299,6 +3299,7 @@ static int perf_sched__timehist(struct perf_sched *sched)
 	 */
 	sched->tool.sample	 = perf_timehist__process_sample;
 	sched->tool.mmap	 = perf_event__process_mmap;
+	sched->tool.mmap2	 = perf_event__process_mmap2;
 	sched->tool.comm	 = perf_event__process_comm;
 	sched->tool.exit	 = perf_event__process_exit;
 	sched->tool.fork	 = perf_event__process_fork;
-- 
2.54.0.545.g6539524ca2-goog

