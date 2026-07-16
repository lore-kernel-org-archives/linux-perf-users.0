Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C031438AC8C
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185411; cv=none; b=CukYNKaj5OUb5xDIasxfrIqFC8otLAEqh3bqEZqmfWuOU5tWpmA0skVMpoXBPoruISzzeElFIegGMdwZVQo9nec1CiW7V6dGv0KqRE1Ppa4/2tJJHqp2dZDxC9iiPJf9XNDBlppUYzEwNEf32zB2d9w6u6fZVsuM1hP2QXGaIck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185411; c=relaxed/simple;
	bh=2zRqavbTgYkq8HwTfEKM0Me45DGRRl8qebYC5U0RZho=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CauVG4New6J7Sl6Wg1R70XjJ3WyJGBGY8n8KP+vg65jkNamUfEG3eP006LFCEsjEQQMw8aEqA0KQ0czaKJVxWzfeGzX47JuWrt6oRU7ezlWCHR4SuhzzpTvSO1R9XN2EDWRiMNPeALerDGuCq0LkB36D4Cw2tbcWWQ+VO6e8kCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zsx6x2f1; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zsx6x2f1"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c8894570b58so2330479a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784185410; x=1784790210; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zcjJZCGcC+t8od9G4IqAATvOsW/z+G4n2l1/yDPO6Gk=;
        b=Zsx6x2f1eunK4mvl9zvFzNlc7yKOtsOkI426GkKgql2zhfhuFmW+O6SbfaUNMx5Pc3
         GtKqvk+XG54Lii6MxmmQ3hZ93dFdS43FaXeElDJDja8kleVymeBvevOcHCtn79HmhKst
         paLIv4U1oDGDVBDMWtNwAdQOOh2sGwiieV5kdvT6IWygh5R24lWzQg2YqbLSM1TFfC0z
         vlWzxg+v3+7fYcqFmvdS+T/f8033LK2/KuSOMPs8hXdT5cYlN8Kwb+ap58SsEf+7hV0I
         OpMXMt5qqIcrlDaHmHRyAIWcjs/Z2+lwWrz6VpOD5lFnB14/9NXxr8+94K5CBnqK76wi
         KmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185410; x=1784790210;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zcjJZCGcC+t8od9G4IqAATvOsW/z+G4n2l1/yDPO6Gk=;
        b=DLVVHkz8Wks4NBiQ/mlg7rdkvLKjxmvgICKVeeOXxhSuPQttargglSDJsQX7nRywQP
         kt2/RUpUEwPNtOGv8yQ/nVlA/ELN/44e2zVzAu5X0O1CiQ5m5t/khgthVz+sW/e848iT
         6TpCZaSffs70xKr/QL0YUGbCetIQgKUjo1MTpTBbJiYglz48a67osaDz8fPXF6Npyryp
         9K3BW+WI9TEMBATgMJPKEK0M7YkdQNku2cr5XL+kd/3/WF9efDtZyieYjzpZI8pX9yJZ
         4O/33W41fJ+knknVgciPAI7YY0axb/ria5zBorMc+B6WPlSGbjMOJGZ5offel706jOn9
         Lf6w==
X-Forwarded-Encrypted: i=1; AHgh+Rrngy8Ch65iLeZ0kP5KC7NYKEqBtmq229bYsA2COvh2tMVva79b3KnM3iOD/A/u+xQ//mxO7HUeKqbNLfKrBXNs@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+I0T7sE+8oBjBmIvTUd1ievvw52xVte9PM7M4injQOs5T1YWl
	YRjVXlEO1tYlIPS3zLbok6g2nIuvcaBgg/BlP9FoZiOYLIStATqB0ns8NSjZLvXydMqCovXx2XC
	rvAbcwVfkFw==
X-Received: from dlbph10.prod.google.com ([2002:a05:7022:370a:b0:13b:9d10:4fe5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9216:b0:3bf:bde7:d66f
 with SMTP id adf61e73a8af0-3c11076c6ecmr23488176637.2.1784185409798; Thu, 16
 Jul 2026 00:03:29 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:02:58 -0700
In-Reply-To: <20260716070303.507066-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716043223.388233-1-irogers@google.com> <20260716070303.507066-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716070303.507066-10-irogers@google.com>
Subject: [PATCH v4 09/14] perf stat: Extend CSV output linter to test advanced
 PMU and metric-only checks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ctshao@google.com, 
	namhyung@kernel.org
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

