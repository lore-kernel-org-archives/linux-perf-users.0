Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCBE38AC8C
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Apr 2026 22:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775167452; cv=none; b=M1ZwvTJ2rVy4mtsw/JJ2oo/hZBlLHgxCNW/i2Ciddl7NzmNunYIP1owDPZdWt9LQkjMFtafbTCyicuEsecOpfIV/NaEEynngG83Tecx4m5ITE2PbjnF3a8gVo8Hi+cJCxupasufUjgM+Qg4c2jSVUUCH7TUhZPSy7YdOFcqGp1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775167452; c=relaxed/simple;
	bh=iRouk0ngQoiEa0Vgp5uGB7SrOcFatK26XuwU83n6CAA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=UEI6kGyxyJI5bEizrm5sh7QR2E4yMPneIw23HkWuK87K0VPejJWRotKuDoEfnB54fJ0mbxOdWfQxrkMMbGLeaKbfnaA+k0KE4m6YK7ANrfFMbMlnJSWUAKJAkQNwmW7/icZ+PsI5pCjq4bHcfaaRJ4WS1IbCSOZUocGh8dWrK4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=skHHg+l+; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skHHg+l+"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12711ec96fbso8395873c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Apr 2026 15:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775167450; x=1775772250; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0YEbItHkRkpnU/lfd+rF7ORpm8vYnWtiloc9sGIoL/E=;
        b=skHHg+l+GS/NvcCbqPbREoS/PWh4HDWmbeFLOPLYaph0qCvEgmMgcF/TmrxgJhjDQa
         eQtK7jCxH5YTE4zET+isfmuVD7v81vsvhslRfKWG86R+r+Sa2yBiAZt9ORNKtltzJ0dJ
         GOy3W1WXZXKPEXT0Qw8f2wKYhAFBHZt26CHWLyU58qpuZaSiohf1GdpmeOJew3f/Rb82
         BpxAXEks7Nff3av1BVHBHJ4jnCEFhLh71ykTfrygwWdXC2Feaa134clTBDJiIk0f6hPO
         FIr1VCT4XWtItu2L4shDo+AZ72F7tCetKdeKZWshenX7o8E4RsWAuzOM1w8EmvtpGeKA
         +T5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775167450; x=1775772250;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0YEbItHkRkpnU/lfd+rF7ORpm8vYnWtiloc9sGIoL/E=;
        b=QxJ0vuunCy6qwVGObD8tLgUHKl4c9G3rjSD3H+uDRZRLNGy8DDQSXtag022hOf6W63
         ky2xq44SpynMlIzFCVep3pDR5YEZ0u28eBepbJWHWYO9odTXHDLT7YVmX7kZFb4UVt9l
         Tlb/aYQv60spPcnS/Mn907+Z6B6IljU/QNVIkj88sOAltiy8+W+SA2Lhf/ZiCu+P9Dmw
         pY2vqJ0i9mRKvOyCgztIJ4rT7JYPs61FBx+2xpxzleXoL2d8dO6eFN8RHgVdmjs5D3ub
         5+O/3AQPMZ7ut8M14IxkjtwyzyoX8nn47glcMYywmuYrX9HHtNH/hUj5xuACoaDiP9iB
         eLLg==
X-Forwarded-Encrypted: i=1; AJvYcCUSvKsIHEkHoiDhtcFOJF3eJFcuAlzVxpSbw+aAm6nERQgtg4IIgW7n7SUkAOg/urrQVywv2RlpQg4Dbl9u3OAv@vger.kernel.org
X-Gm-Message-State: AOJu0YxQwvrguR3wmXAPRz6JydLZSA0IdgNfK11TAc2sJIhIGwqKnlZE
	TLqi+Xf87uKeVMbxPTY78GNlYO+L0NhMr1uVfIKYkN4V3qIHCiG8Orr4I3yUIUDguJLb6CFprCl
	MD7ks99Ubnw==
X-Received: from dycae21.prod.google.com ([2002:a05:7300:da15:b0:2cb:b540:9519])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec17:b0:128:d455:8501
 with SMTP id a92af1059eb24-12bfb77a42emr349411c88.37.1775167449802; Thu, 02
 Apr 2026 15:04:09 -0700 (PDT)
Date: Thu,  2 Apr 2026 15:04:06 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260402220406.983248-1-irogers@google.com>
Subject: [PATCH v1] perf test: Stat std output match 2 metrics for stalled-cycles-backend
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Seen on ARM, the stalled-cycles-backend event can be given as the
event for both backend_cycles_idle and stalled_cycles_per_instruction
metrics. Make the metric match sufficiently generic to allow this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index 9c4b92ecf448..5a6bda436dd4 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -11,9 +11,12 @@ set -e
 
 stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
 
+# For event_name[i] expect to see event_metric[i]. 'stalled-cycles-backend' may
+# match both 'backend_cycles_idle' and 'stalled_cycles_per_instruction', hence
+# matching "_cycles_".
 event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
-event_metric=("CPUs_utilized" "CPUs_utilized" "cs/sec" "migrations/sec" "faults/sec" "frontend_cycles_idle" "backend_cycles_idle" "GHz" "insn_per_cycle" "/sec" "branch_miss_rate")
-skip_metric=("tma_" "TopdownL1")
+event_metric=("CPUs_utilized" "CPUs_utilized" "cs/sec" "migrations/sec" "faults/sec" "frontend_cycles_idle" "_cycles_" "GHz" "insn_per_cycle" "/sec" "branch_miss_rate")
+skip_metric=("tma_" "TopdownL1" "percent of slots")
 
 cleanup() {
   rm -f "${stat_output}"
-- 
2.53.0.1213.gd9a14994de-goog

