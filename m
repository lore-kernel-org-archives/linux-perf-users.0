Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E7E34CFB9
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328779; cv=none; b=puyJGUZY+4fvFaIUOzJSUhIfT6UkdcsTuMHYVVpsZAXDvLZ/BQZgwZML2pT4InwSr48Ma9wsFajj9rRR5zLva5rudYIjmrZYUJhNcsAZstvUD+AzY2kEDJzx4E9ZQHZ+6+fE7GnhpSH0Ebg5RPqBI1gtevZzucWNvg43De4+gA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328779; c=relaxed/simple;
	bh=EMIWmYJk4oxcW+eMiucvxkG58MQPnGfjcYpNvnxtnSE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=SkL4eWvIwYKSfBkOq97uL7O4V7rFtrh05OmLPMI8JKmTaGV6yhPeKQQbYNJA3d5X+yg7ktoyNPK9k3shaIDAsQs5kNbj2aKs2BlH/ik8Lbw9phyiPZLFW/YUIAMlPf8nsWIUaqeRpJMByCK1dUO83+d39F5ajE1uh31aftg4tGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o/mN+PzK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o/mN+PzK"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bb3b235ebso4906959a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328778; x=1761933578; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=525kLDCVrY5SIxBE3vSN6xCvavPC8e8IS2zf2hpQNrs=;
        b=o/mN+PzKPGvM8722WDK191XTJSxNdNxMt8lnEZzNjCaPB64/ATLo8uBvha0Ia8CCqg
         0/Z09t8J53U0NUotaXvDeD0XUrElwolyeTzsyNbDBWxIQOdeNcoy8x99bk1jShuI6ZRS
         FscfaoH6YZYtsRK0sf2barSmu5mVMM3V6nTWg11a59Y5twH2jTNoad10vYJnB3q/uOE+
         uPHqQhYxOdLiWtP+k4KCamdVggtVWNLjipAncVZ+VHJflKy5MuzWW6YtklDPt+YO7YfC
         4qZETNpSDVvu1kKMEUbd+CDD10q3BU+9I9PkzdH37IAjr1M51jCqkJZj6N0bx+qD+ih6
         wMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328778; x=1761933578;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=525kLDCVrY5SIxBE3vSN6xCvavPC8e8IS2zf2hpQNrs=;
        b=ad1ysMRiBaBjfh4kyOQ2CDI9+WPO/QxBTKEs2mnYLGA7X/HXU3i2SibjDUwZxjFshe
         ZRmpEhYjdPcQSvrZPkTdUHXvqRAi/cfxVRyxTzs1j2VfyLji6jJh4FWiA9J23+7dFV8F
         GH6Odl94ozEQA8JmhgKXEhwuwXobBupaghXVnqNeL9BlcA2OS6zkWncVpS6HhM8/Rj7a
         WBFEIoj0AZpYt0NmBijXU5qOkEyaEjWmJ2Svt/kRiac7nxHGpHeZHOl+b1IrSt1nJ0x3
         2dFT21rWWUGLJlC2o09r80Nop9hOC0GnrKAkQzD0tNA4u8+C1mzCvJ+eGs8q2ZLk8p7t
         5olw==
X-Forwarded-Encrypted: i=1; AJvYcCXjD9BjxNTaJpi+CbBZ9KE8d7g2UGuD1hk6hiYtTYotcPryQbWpf3U0VMVV/jMCYkgC3KHNvfsp57Y5fKSibZxQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx9U+2nZr6QZrAy5hTMULhSFJBdZ122Bzu27Ecd3Z/1RLOvwns
	94Baa7q4okOOF5TaVorHfrkxSeobIfp0dPdWmVlqOJywa/R5VpgjC4qK4kPgLJ6IMBBbeJv3I6a
	SNsT5Bou7/A==
X-Google-Smtp-Source: AGHT+IHVz7Q7RAEZzhshyfJcovdGc3s06xzAx0puc4rSHrN8CtieQtGcdRPJE/r2iwPYmz/WJ6vmtqApfEDm
X-Received: from pjot4.prod.google.com ([2002:a17:90a:9504:b0:33b:c327:1273])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3a46:b0:335:28e3:81cd
 with SMTP id 98e67ed59e1d1-33fd65ed34emr3787766a91.18.1761328777584; Fri, 24
 Oct 2025 10:59:37 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:52 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-18-irogers@google.com>
Subject: [PATCH v1 17/22] perf test stat: Ignore failures in Default[234] metricgroups
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

The Default[234] metric groups may contain unsupported legacy
events. Allow those metric groups to fail.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat_all_metricgroups.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
index c6d61a4ac3e7..1400880ec01f 100755
--- a/tools/perf/tests/shell/stat_all_metricgroups.sh
+++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
@@ -37,6 +37,9 @@ do
       then
         err=2 # Skip
       fi
+    elif [[ "$m" == @(Default2|Default3|Default4) ]]
+    then
+      echo "Ignoring failures in $m that may contain unsupported legacy events"
     else
       echo "Metric group $m failed"
       echo $result
-- 
2.51.1.821.gb6fe4d2222-goog

