Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D7934DB63
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 17:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328784; cv=none; b=mctlgPFjn22O0+h8JeRlszECUBXAAsCl4dC6EZ+HyA+ilVyOfWsRByzvpzJrfGin4vDTJB18s2JqnJiQV5NbVW/oWP2eDwm8Rq+292o7pq56QosNM5kPufQpyondPelT6gtddMiNqcyJdqo4bOvl1320QtEViTMp5GaIjtq/11E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328784; c=relaxed/simple;
	bh=nnbzpYYoE1uErizC7KXzK9XKE4rE5R+0ONkMp4g7shk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Ebt7C6l20PZUjLkztKJnYouAxq6cVamvWuX7iH1fVrF7qaYqOXE/TcBE2tZuNvJASKidAicfmKGd+Nlq/bY12Nz/7O/FmXrXCaPzKD7tcAhnIN/m629PvKJB8q4dM8/oMH33Q5qr3VSws6oWxYE1v47/ec6BxBtEoQ4jQ48I8cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2SnJ84L1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2SnJ84L1"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6ce7f76617so3635293a12.2
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328782; x=1761933582; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qll4Tnbg7iSyg4HhuOtdcJhkqf9XcL7mLt6N2dgKiAo=;
        b=2SnJ84L1NHuDloRg1N0xFdk/5Tq391AzUKpiI9lf78+Y5iwKO8cio1Oqvb5x8IA0q0
         8rIqCpyqU5364X7xDrnNg6142KLtTIKeu1iXJZE28rADDYaaLwGWhDkCpeBkcquVcAbA
         SpwkWdvS82Tp6oElJDFmG4aUWXyQdIeEk2O7CEM1ug8+l+YELslc1fr2JKVx1ObKDqZn
         E0xlyPeMg/yToSvZ9wpvd336O6q88Em1zt0TVA+e0sqqzV7qVRVecghKsu7PcAvaoyvg
         3EDrGq//h+Yq4n52l63x97Rx50qC/uPRuf6ddXqy7DGFaDIEpdqjCipVcZiNEOzqfURI
         fzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328782; x=1761933582;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qll4Tnbg7iSyg4HhuOtdcJhkqf9XcL7mLt6N2dgKiAo=;
        b=Bnd5G/nbsntiptEEMuvnCLbuhMGPXmuORmWcj7qNmi/pwgH0bw2gQDsYynWYJVccL1
         lnYcpTb0jnzOM9w1VgJenx4dTtCjSSoMOXJQCOu8ZeMV7eqIf6+vMwshVOOxyrS7i1jM
         uFmM8TlVcYmxgb0jcK1G4YgNC1thdfa36u8GG/B7QblQ3wLy2K1ZwWYh8JEJhbbZMzgC
         n846NxTNLuIVHs0DXmsEmy/Cz+hfFIuU0RjN6LFVpANG5zlxB4U8V5QH3Vr8zHXw02jf
         v0S70WYFI1gMGB9mJrnj6OrmxOaviPmalZLfssL426uAv9K77rui/Y2JiQ7sSkYkbWKE
         iYtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVao30EOB/Cwp0cZoKQVkYgHDu0AjoP12JWP4d7NrCW/4Fc7Vn9pq/mw1ZLZC5bqqAM66G/3hYmdEjBIo9OD7zv@vger.kernel.org
X-Gm-Message-State: AOJu0YxMvrv6ZzsIrhXZ57jsr0AnUGlcYwDZr3gTLpfAYiylphhjALQ9
	ybajhX7Gcmei3F+G2u0PodeQiCcx77p1iB3Zx0gsmm7EeMy0KxEa2qCBEFkSCzTOgDbr4q+LZr+
	gUcEh97u08g==
X-Google-Smtp-Source: AGHT+IEj7v8hY7mfMTsEI1hA2dB953ZEYGmWJ9X89OsMwCloBEvnYhMZ48xa40L7Vl0BguVxjppBAdghME/g
X-Received: from pjn8.prod.google.com ([2002:a17:90b:5708:b0:31f:2a78:943])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a7:b0:33f:4e3d:b004
 with SMTP id adf61e73a8af0-33f4e3db1acmr1588439637.47.1761328782193; Fri, 24
 Oct 2025 10:59:42 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:54 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-20-irogers@google.com>
Subject: [PATCH v1 19/22] perf test metrics: Update all metrics for possibly
 failing default metrics
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Default metrics may use unsupported events and be ignored. These
metrics shouldn't cause metric testing to fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metrics.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
index 6fa585a1e34c..a7edf01b3943 100755
--- a/tools/perf/tests/shell/stat_all_metrics.sh
+++ b/tools/perf/tests/shell/stat_all_metrics.sh
@@ -25,8 +25,13 @@ for m in $(perf list --raw-dump metrics); do
     # No error result and metric shown.
     continue
   fi
-  if [[ "$result" =~ "Cannot resolve IDs for" ]]
+  if [[ "$result" =~ "Cannot resolve IDs for" || "$result" =~ "No supported events found" ]]
   then
+    if [[ "$m" == @(l1_prefetch_miss_rate|stalled_cycles_per_instruction) ]]
+    then
+      # Default metrics that may use unsupported events.
+      continue
+    fi
     echo "Metric contains missing events"
     echo $result
     err=1 # Fail
-- 
2.51.1.821.gb6fe4d2222-goog

