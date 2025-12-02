Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768BD2C3258
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697867; cv=none; b=qy1KJHdHUUJRQvGsXGiLZi+SWyjcw5eyppMSyejHrz//EswnYuG+K3alpq3Ef8crAIbw3kGyxc0hpO5tOUdRvJe09cbfelsGieZSKS1lvzn8D7MvU6ZIUu5SP4YNdE5PddDIfm9RqP/DG59LzCL6tRPfY7ZYtRGgP+dPibNfwlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697867; c=relaxed/simple;
	bh=1MGEg68OAPpnEDOXdOpIbV+hPW6P24DxL9Ap9Ef0JVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=awkjJhI9HWSfoSVMEhuvBiripUSKAnkvSGdsnWT8PEH73MI16tq+NSEZ1aozkVOzY9gcu1PqlQ/l42cAt2Rsbzp3oeJIQVGcFX2qOhcZJFefavlIT+31Q7v+2o/67gsoDkbZg7lYOpS2uM+mMjWXyZEFbXEDiPj8qLWm4vHcwEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xu3ykvmP; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xu3ykvmP"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso7936828a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697864; x=1765302664; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9j2nD9pKAg4HaspT9MBZ6CGU49fK4DzkCnN37LNxG9w=;
        b=xu3ykvmPkp1xiL74edEcstnUpgQDM8DAXap5rAOUthWkUN1u5qXpzGYryO0idI2FET
         rsAAnZ7zZBPiBWl1XzQtQyfw/JPMt9YBpI+UsXCvjPZp4po/g+LRIgA6RTAfo/NTpJat
         dD6jYa1+qwZUiKCeMiNnEqhP7KrvQoHMTjvY9hOCcoEbnzspKxrWgeVDqdJC3n/x+Hfk
         +lRFJ+O4PdQBxDhs9XBiIGtfaQdY85VWJNFp8KiQpGhTvrnEoLVALULpIo9vxXze/fWj
         mvnj5FdheQ/fINCAuVHv/LSUtsS8hrBFasSgct2W2H9tVAIb0AG/HWf9srzMtyfOJrog
         gpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697864; x=1765302664;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9j2nD9pKAg4HaspT9MBZ6CGU49fK4DzkCnN37LNxG9w=;
        b=f7Bdc5FLG2v02ZPLUo1+mP7Ij0kqNzY2Qb0r9/REMzKRd1tDhYltmqmzFtOp6+sVj/
         BjNkLZD7bra3RMcUQYGImXfPk3dNrcgRE5bokCm/+0oSFxSxLHskvDJf+U7qq6MKb9eC
         ffBzMW8h6+Bcmy9QuA1+4lUQ7OURyeeVrfn+bx9dwwOb+XxqPSjC2UTAFLyW5ik+iO9Q
         M3xGPNjUGa4oEd09980KwUQjumaG9j8e8HjszZepV5g/+ONQOV6bVzkoS+6mbSyYJTFz
         9e/rvrj7GjlK4NC0kcD9De3CC4xLDtMFx8IiotRopTVSmK41o3LjOU2y0rLXEp2Q7wlu
         lYOg==
X-Forwarded-Encrypted: i=1; AJvYcCWrfwOFas51dHY053gNtRAWWUUDCWYytnyzw6Gxv7dRDplGeTbak31OHyu8nJD4kxDD3jYWPwJL473vxkHNvKkc@vger.kernel.org
X-Gm-Message-State: AOJu0YyxEGjO+RbVoXOpMYGrNWfNCV3v1tsz9+LZfU0OUL8LBXSUJE41
	QtVplviCWgvJc2L97hpqKDiqaNqznNwpIko+x6B2oisO2UOWDHx3CUDqprpmxHmQl5UQVdXXKUP
	Vy22LILlUfg==
X-Google-Smtp-Source: AGHT+IG9UvfE78E1OdBtiqQkaphk9mKjtLJwuhCfyL1TztsqLedsiK3sZFbFmUdXc5+L2ln2AzEOp5wGyNYM
X-Received: from dybqr10.prod.google.com ([2002:a05:7301:608a:b0:2a4:7c1a:3e18])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:50ef:b0:2a4:7fb3:7a96
 with SMTP id 5a478bee46e88-2a7192d82b0mr23551111eec.36.1764697863587; Tue, 02
 Dec 2025 09:51:03 -0800 (PST)
Date: Tue,  2 Dec 2025 09:49:57 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-3-irogers@google.com>
Subject: [PATCH v9 02/48] perf ilist: Be tolerant of reading a metric on the
 wrong CPU
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This happens on hybrid machine metrics. Be tolerant and don't cause
the ilist application to crash with an exception.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/python/ilist.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/python/ilist.py b/tools/perf/python/ilist.py
index eb687ce9d5a6..0d757ddb4795 100755
--- a/tools/perf/python/ilist.py
+++ b/tools/perf/python/ilist.py
@@ -77,8 +77,12 @@ class Metric(TreeValue):
         return perf.parse_metrics(self.metric_name, self.metric_pmu)
 
     def value(self, evlist: perf.evlist, evsel: perf.evsel, cpu: int, thread: int) -> float:
-        val = evlist.compute_metric(self.metric_name, cpu, thread)
-        return 0 if math.isnan(val) else val
+        try:
+            val = evlist.compute_metric(self.metric_name, cpu, thread)
+            return 0 if math.isnan(val) else val
+        except:
+            # Be tolerant of failures to compute metrics on particular CPUs/threads.
+            return 0
 
 
 @dataclass
-- 
2.52.0.158.g65b55ccf14-goog

