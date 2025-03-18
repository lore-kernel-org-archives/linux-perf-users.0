Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523321C6FF8
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 04:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742271298; cv=none; b=W8WfOeVVW8A4Spr9f0NTvgXd8BBFX5ULDYzQb+TjCJ1I34hWgxK/J5Hebs6WL5xi6pvwdeyzHa0PehD1S6URpimXbtjiSed1eAnPxCkkVBA4ulZ3SrDRXSs8xIn/LBErRCfkMhc3qpKzft0p3ZmR+QbYueLsDFlweiy93/EOIlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742271298; c=relaxed/simple;
	bh=wkcLWmBn5YfSkrqCgjPW+KecUlbd3s8XqELqjHa497Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=nGA+itvBvxYTnn6FIAb1Kn4E+JfyOsV0vWFWsfRZdGAhim+QChkD89kWA8OEBviGKkFMQYt8GYIusavotUTCJNKIfbpbgSV3qdL8759WmwW7Iee22AqtGWZk3jBm/oyTt+gFKEScaG63g5RlKYFPTRUR+Q3Sri/ORJb5zUvX5PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mksoWD+7; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mksoWD+7"
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-2c2451f5cc8so4000178fac.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 21:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742271296; x=1742876096; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w5tqXzSB63leZ7R3ZWij8NvB4IshQW3WEuW90/a1hhI=;
        b=mksoWD+7pjMmmFzibDQohS8FQK9ZCv01UyDUJq4KZUfi+DZVNSn6hhoYOg7+EKwvOr
         cdh0/bKyqQz4wkkxkFVsHwcw12beoCU1ZhoWcvzW0s1h60G8vx+VYF4uy3N6R1ke+Q6u
         hHulVuy7MA+fPy9at9fv3/wYiDwkSLDcGWCnLFwjzyW1avkPIC5k+MnmzP48v5fLwkFN
         n6UvvM4YcVB1TBs9RQztFv2eRCJVrRdEO0Y3JvW0BT+BYEfJroMavMqPflyet03GnMUB
         qRqgG9IssMz9fBhBSAlrAz7+4t2nJJSxF+x1pBlqHw1UHiFsC2TaLmEAk+GjkbsjkLsT
         Eppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742271296; x=1742876096;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5tqXzSB63leZ7R3ZWij8NvB4IshQW3WEuW90/a1hhI=;
        b=SUKtJreyxwAp0IKnDSk60XaYfrO2tBaStjeqhx6h7BehtMwc/lWjrwtTDswfE0vrMW
         86ov6AJB/X9tySW0Lq5RC0l54fdE195tZ9ELgk2NXczcCtOBE8kFT539ho1GVALD+VF4
         39q6DE1bYVQIFA3wqyOeFNF8o6Fmwk5fTXoXdU5vV3AwE1MoOdMMQFqfxmlugCx0yRF9
         q4ZguuTajwr21TKXlbVw9PDrm9/EqlTsSnh+ru8fx8Sxu2YnL0rpMeYKVULqQPkdO3b8
         zU8ZEDAJp/fugZ3XkMQa8g2zb2GwdUzf6OHmaC6wdaNz37aq7Xd32Owgr0HmQEFx87xw
         uGEw==
X-Forwarded-Encrypted: i=1; AJvYcCVYKD1JhMPhDSNEGhBL5sCRfSrly41txL3YgkXByKZiOgmuyf6Z3A0L8ciUd5nS859RsQcif0nNZOO16Qi9Ua06@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvi18ee3qDlUMnSfcnqnigbsR4/k1zUee4RLfUGxI7afGacPVJ
	E9DxAxFQ8mvkX7/y57PVWxI9r7DyzZ6mDESVguVhYzS86StaUjBjJjDMvC2dggthV7VjbxBg2Vs
	hhRA7UQ==
X-Google-Smtp-Source: AGHT+IEkyqrCGwo/Q7at+ImZvcMpDLZizAESd0WtnXKupQeighIKPBCF5RT7wqXmUuEle6WQZ28QjSW2Y1se
X-Received: from oablv6.prod.google.com ([2002:a05:6871:4386:b0:2c1:64e4:adb9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:e40f:b0:296:a67c:d239
 with SMTP id 586e51a60fabf-2c690f3b3f0mr7815648fac.12.1742271296325; Mon, 17
 Mar 2025 21:14:56 -0700 (PDT)
Date: Mon, 17 Mar 2025 21:14:41 -0700
In-Reply-To: <20250318041442.321230-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318041442.321230-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250318041442.321230-5-irogers@google.com>
Subject: [PATCH v1 4/5] perf evlist: Add groups to evlist__format_evsels
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make groups visible in output:

Before:
{cycles,instructions} ->
cpu_atom/cycles/,cpu_atom/instructions/,cpu_core/cycles/,cpu_core/instructions/

After:
{cycles,instructions} ->
{cpu_atom/cycles/,cpu_atom/instructions/},{cpu_core/cycles/,cpu_core/instructions/}

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 96cfc7ed1512..b59fa407be44 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2471,19 +2471,30 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
 
 void evlist__format_evsels(struct evlist *evlist, struct strbuf *sb)
 {
-	struct evsel *evsel;
+	struct evsel *evsel, *leader = NULL;
 	bool first = true;
 
 	evlist__for_each_entry(evlist, evsel) {
+		struct evsel *new_leader = evsel__leader(evsel);
+
 		if (evsel__is_dummy_event(evsel))
 			continue;
 
+		if (leader != new_leader && leader && leader->core.nr_members > 1)
+			strbuf_addch(sb, '}');
+
 		if (!first)
 			strbuf_addch(sb, ',');
 
+		if (leader != new_leader && new_leader->core.nr_members > 1)
+			strbuf_addch(sb, '{');
+
 		strbuf_addstr(sb, evsel__name(evsel));
 		first = false;
+		leader = new_leader;
 	}
+	if (leader && leader->core.nr_members > 1)
+		strbuf_addch(sb, '}');
 }
 
 void evlist__check_mem_load_aux(struct evlist *evlist)
-- 
2.49.0.rc1.451.g8f38331e32-goog

