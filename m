Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570C5389105
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176396; cv=none; b=EIfu0ZbwhPSZgIw7FzgSfO5dYhZjWSTaL4VLHQuYkudtjV2KBKLJDQPtBdZq8fAPXVrAcMVfJoP89ux/vxMEX3NdmudGUgcWqI8ChEkg0bHtLh0IN06RxxewGaIgeSK0h3mmAWg983UqMYKuZ3MyYKoRrBgQ1F1oa/DXSvYJUQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176396; c=relaxed/simple;
	bh=zR7mlcbI4TNldle6aO32Mnii3tEtVON8sRL9dr2eLsA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ISm968Go9JmKJOba7OZfC6wty4ECizwjmiYTXuLXL0q+Yx0xJcU+HA7fvZoObBhP+oEEuzeGYJX/VPtfc/TJfTMLGFQr2zizgJNbJZOGlxJguEJ30uQ7u1e5Uppkh8WiStVCKEdcgx6k/OBRC0Q1xGMLJt12jFZhKIRlrz9AET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QSdpzRdK; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QSdpzRdK"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c890bac374eso15406929a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 21:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784176393; x=1784781193; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qfUl4LGt9dp20bOLuYgeMbQL4uHxb1wteh9z3KRDuS0=;
        b=QSdpzRdKzoGyhfM3I8YJBV97aynkknv631p8UxEh+AqfyviS5cTdH6CHu3kua6Pkxu
         WVMuR1Wm868tLmH6notlCvwwxvfKCVZAnPGXNg6s9N5uPRxb6WbGWhwP7LTTCZGa0qtc
         A4ISP1bQijd9aBjrJ35KxGWp9c9EHkmWt1CfQ06+5OgjmwEH42TGWHhdAC74Ld6Q40lt
         4PFgJpk8HiduDC1QlDpozIIhD7dWNq5OX0WoFJvOOKfzFGecVTqjvsAwuR00UBAJplDi
         ol33a9lRY2caAHNR0HSNjgoBrHrvhlep6PaA8x5NQKCkzrjz9eVcSHTlct9U91V0iXpe
         GUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784176393; x=1784781193;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qfUl4LGt9dp20bOLuYgeMbQL4uHxb1wteh9z3KRDuS0=;
        b=Qe9P3xNaujVdjVa4JMiq3hE5pfkIdWMhWEaC50xAKHiI32BHalQcuCvYN8szSquatL
         qHiQq83ibw1aSEK4goAtqzos450YYf5bPF2X/VOGm2P7+CNlIVEXzYCSrKJHgJ5hkJK7
         VDctu1Aw6p3L0lW1BOu0ePCDUnvwGOfn1JpotKmi3wfDiL7ouU/C38USuglyq0mF2SVK
         2jK4PVVkr6+zYv1qyPz1ebK//2sOPX/0jZTxYGiXvQrzfhoabh6zDBTIPCt/I0s4vHig
         3AltTN2XWH8IeulfUr/AeziEhVuL+Gi0ysXcQpmB3BRGyj/7SYsekq+KqUYpRhhJ929O
         mtmA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7DqG/hnnTtDtYjipZ7nkPHQCZu5qas3IAB1ih7L3oiu+4Tpxl0ObZNeKmD+Znnk6LlusCrga2Omb4eyW7Jb72@vger.kernel.org
X-Gm-Message-State: AOJu0YyuVsfdVNbpjXj4lz0KCR/58xErj9UNmx4wuYI0mblUMbFhafaZ
	5VWbyldewTEIoXDZ83tHJ74Ms+GLe2NRtCJmD90mAOMKeg58Ihkl4t4vhSCv3+q93aN4/SGGXpI
	oX6XC9vHwzw==
X-Received: from dlbrd17.prod.google.com ([2002:a05:7022:f111:b0:138:5e8:1b36])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3a42:b0:3c3:8c91:5da0
 with SMTP id adf61e73a8af0-3c38c916004mr1415933637.15.1784176393355; Wed, 15
 Jul 2026 21:33:13 -0700 (PDT)
Date: Wed, 15 Jul 2026 21:32:18 -0700
In-Reply-To: <20260716043223.388233-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525231900.3527228-1-irogers@google.com> <20260716043223.388233-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716043223.388233-10-irogers@google.com>
Subject: [PATCH v3 09/14] perf stat: Extend CSV output linter to test advanced
 PMU and metric-only checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	ctshao@google.com
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch extends tools/perf/tests/shell/stat+csv_output.sh to run the
advanced hardware PMU, topology-aware aggregation, and metric-only
checks a second time under the --new CSV print flag:

  - check_per_cache_instance
  - check_per_cluster
  - check_metric_only

This guarantees that CSV outputs produced by the decoupled printing
callbacks are verified and column-valid under advanced aggregation modes
and metric-only CSV row-column layouts.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash

Acked-by: Chun-Tse Shao <ctshao@google.com>
---
 tools/perf/tests/shell/stat+csv_output.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index e4153a03d716..c48d9e2b6429 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -102,7 +102,10 @@ then
 	check_per_core "CSV (New API)" "$perf_cmd"
 	check_per_die "CSV (New API)" "$perf_cmd"
 	check_per_socket "CSV (New API)" "$perf_cmd"
+	check_per_cache_instance "CSV (New API)" "$perf_cmd"
+	check_per_cluster "CSV (New API)" "$perf_cmd"
 fi
+check_metric_only "CSV (New API)" "$perf_cmd"
 
 cleanup
 exit 0
-- 
2.55.0.141.g00534a21ce-goog

