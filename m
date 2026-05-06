Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A1921A434
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 00:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778028360; cv=none; b=SjPw1qJrcccqQ2ww2rFPlt3MAVmlLdgGnzNTzkJjewgClxy7TTdbz1jtZwYmUL8Lx17gVXGAS0Yg35auHYVwaBVSeGtYLWcqi2jIJI2Z899QJLDXXR/YXEJUmbUIqeDS/2462vOhweQVS9uLMVtSiz4HXZMFXVVEGocgB4jbVSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778028360; c=relaxed/simple;
	bh=c9ejlYjPiFjsPhz/yehQpWJw1IyWFFw1CL0F74SsqP4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QII23IvDQz0gycJK6OxIpeI+1L1+VD1ZqTDzIezCOzj9f4tGITapkW7eTmQCc5pQh1WkgJ7TVrH3EfVIhA4h7tp7kHjHUGCs0FCR8BAHYseM897mDUhv5b1imqLbuD/61zJa71DieTXqdYuRNP1f78NcIRMb73nzrDVqU3hhpOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b28r90HH; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b28r90HH"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12dece274b1so7992653c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 05 May 2026 17:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778028359; x=1778633159; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vkt4oU+hEVEUN5xjbaGhASHDDjx1y3R0jVDB1yo0F0U=;
        b=b28r90HHVBPJVxhM9ShzY05Z0qsNsFCFehWaCgnNHn7SdcqZBSj59A65HZgukQNSnR
         VG40RACZxVwYXt9C4958cCU0xdsfy2nl+sxnuX9e7133RqSOYseExyrZ4u4qV2EAgrtN
         zng99nHfIFk4DjZq6bFr8IxBe8w1QiJJXYP+u5P2aDGQxCyDdH0/xFbyAnQZfFAyarcC
         +vLJpNjK4auTs0ZRV3KhBS/QU1R4x3XRPaOZLLjPAMncxQdpqX4D6ZvZeq1nWOZNYyMA
         x4KrF9qmfm/CxSzxU+KhvjrEtYXbp5oSpN+BBk2R/35dmMqM197+GNZRd/Q+Sf0nmIXz
         npog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778028359; x=1778633159;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vkt4oU+hEVEUN5xjbaGhASHDDjx1y3R0jVDB1yo0F0U=;
        b=YJzyQWaD0m+4KQmfzl4150HI3CY3ZYaCgs3G4SEkj7ImX7enKKWhQ0xctfyHpkWU/R
         6q6xn15uAGCd7uw8ADeDLjRuoptRa9zEt5aHDOWDJekhlJF1fEvVG/VYYXJWwCyPQWji
         idQavzNOPoCDPupWi/eyBtdgZqiAG2wTloUusQbMnZTH5ZCXAz9khwb95JwqzeJKfEzD
         +vVDo04com23gJGUMa8VTgXW5769iFgRrUQul+eiikJLH3EERduH7T0oAef7YlyvN+kv
         7CZXIatm6kOcQD3NfGsQxh292MQVLamaaAsEa1VJ9WtlRdtiYHNEzAyS/9Ys+y+f51Iy
         3FpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8L4UvkPG/cvqSCZr/MQz1xC8nXGRdQhLeS6EOIbi3EqRMUagCjhfhN107GbTh5W76poxa9FVv03ZKje1A0peD0@vger.kernel.org
X-Gm-Message-State: AOJu0YzuhV4hDVVm27HtFiItxz8y2N/wJ4hwn2+dbfmG+EhGN2kBZ60d
	4LymhRZBGphWl7mO/7W/7iQoLV4HGk2IqjJ/LM8M2JxvsfgyFZ0pJDt/a1pfi1j9nLvpYK5gsUc
	m0f+6cYboDw==
X-Received: from dlbrs9.prod.google.com ([2002:a05:7022:f689:b0:12b:fba9:5eb0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f005:b0:128:d967:4678
 with SMTP id a92af1059eb24-1318e812013mr719263c88.23.1778028358417; Tue, 05
 May 2026 17:45:58 -0700 (PDT)
Date: Tue,  5 May 2026 17:45:42 -0700
In-Reply-To: <20260506004546.3140141-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504072937.2103453-1-irogers@google.com> <20260506004546.3140141-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260506004546.3140141-2-irogers@google.com>
Subject: [PATCH v5 1/5] perf sched: Add missing mmap2 handler in timehist
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, gmx@google.com, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
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

