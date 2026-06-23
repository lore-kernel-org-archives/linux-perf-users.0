Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F83AD538
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 05:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192960; cv=none; b=E4w6/hspU//OAvWZaj+jL5sId0UADrsoPy4q5D4e9UcKO48gVEWRXpE0j84hsreO2ucALOuRXTFRdgzFtxuQ75co5kUoRs0SHCxlVE/eLk+94IbnjkE67rvLzy6BlCdphTbT10eyulQyH6EUvhSQY1ik42LWFa64lT4yUjRoE6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192960; c=relaxed/simple;
	bh=oqhYnROVYN+uhmhEILbW47ecwDxPD69BlZJGYzTiZtM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MxyuN/HS+fCcHYSDZb/lXKH9mmyUK3Oh9rt0I7baCyrFWHBWPRm5RnkBJofBsl61ba6oosvwVt1YPSAZpZW5MTE1uityyzVf/4xyviuzmU2n01wsR+It9vR8VRbr4lAS+dDK9PBBhil1TfseLCNOn0pu4F6t3TfNV++/9R9bNDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S2XT+sGe; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S2XT+sGe"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30bccca5620so7238871eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 22:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782192959; x=1782797759; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TOTWi2Oy80/u4HXNInRtNrjRvWfGKmddn99YBSkYc8Y=;
        b=S2XT+sGe5jVqgy9o45hEVC0kkwwaZ1NjZSZkDQHn/C46/aarn2y4NNrJLDdhekT+rI
         doNqcOdgMX+jpPKJB39pKLsyHgmdv2ZptvIlXab1tQ1m0qDMJ+HwBqMlMzz/4myu5mU3
         adfRfTD2iXeZtY3SDdchHIBYaHueThP5FP+j2/VgUgO/AK9N9Z7780bZdBaUiM3ZET5P
         4N2SCE6mwrdB5Rn2ZfasDC0HkA1wGwaaV/eT9HA+e+PSd0V1bhXVq+UzwkMvCmcOUsND
         umtJqYGTVO/IzOIGGLCmDGuC1UleT7ZfNoqHiMtBT958WZgbHO4rgzDyi88O1Hr3tGnW
         9S3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192959; x=1782797759;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOTWi2Oy80/u4HXNInRtNrjRvWfGKmddn99YBSkYc8Y=;
        b=LOopxsXxuU/W9IsuL3Vgs5ZqFv04TAQGGyFPvTfrp3cJw3EMaMj6kqwWOe4c0BZipk
         Y9JCPZgfeEUUKkhJqVKpKwL1IfF9dTdzlY7lNsYKcMUxLiHInpoFzc/+QVWqmHoziWpq
         TyyuDpyppWRvZbcXNMYBvz7f59n20tmO+FN1IfkImTXfg0X0TChvLm3ANf/ZmratRoEg
         Kq1FXoQeM7FR2Dz8SGE/u3lqu/5v6MHUc6/pI7DSSO1LaFb/CIKwhluf36eK6yo3yc6V
         OfacAOwsJYrQl4b9bhqIGLOkri7NuYd1/ieNKpw6zfjvPTLBJspL3ASpMAMZ6nS/INet
         UqUg==
X-Forwarded-Encrypted: i=1; AHgh+RrH0lbE24Rxn85/xAipzM76CsFp2et6KONXqPv0+/gPgxZRAsu11ImBfX6W6STdS2WkKbU1jWXA86awOWEoXHVY@vger.kernel.org
X-Gm-Message-State: AOJu0YxDHyfS1bs2fLStUkaBh7KJCSXi3nK7E5OwdMfPLKGZ+j+WiSF7
	7rOi2pHN66P5YDhO7dCAUwRLja18w2MH0OXG2g/PljTZpYybOnH4Hrku1w5AtS0SnHjwDJoV1Q7
	kFF+gRLXg3Q==
X-Received: from dycmb16-n1.prod.google.com ([2002:a05:693c:20d0:10b0:30c:c25:298b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:214b:b0:30c:544f:a861
 with SMTP id 5a478bee46e88-30c544fc9a4mr3008236eec.20.1782192958272; Mon, 22
 Jun 2026 22:35:58 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:35:15 -0700
In-Reply-To: <20260623053515.2677888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623053515.2677888-14-irogers@google.com>
Subject: [PATCH v1 13/13] perf python: Fix MetricGroup return type in perf.pyi
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

The metrics() function can return a dictionary where the value is either
a string or a list of strings, so the type signature in the stub file
should be Union[str, List[str]].

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/perf.pyi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
index f266c9baffd0..58b0b3ed819d 100644
--- a/tools/perf/python/perf.pyi
+++ b/tools/perf/python/perf.pyi
@@ -1,5 +1,5 @@
 """Type stubs for the perf Python module."""
-from typing import Callable, Dict, List, Optional, Any, Iterator
+from typing import Callable, Dict, List, Optional, Any, Iterator, Union
 
 def config_get(name: str) -> Optional[str]:
     """Get a configuration value from perf config.
@@ -12,7 +12,7 @@ def config_get(name: str) -> Optional[str]:
     """
     ...
 
-def metrics() -> List[Dict[str, str]]:
+def metrics() -> List[Dict[str, Union[str, List[str]]]]:
     """Get a list of available metrics.
 
     Returns:
-- 
2.55.0.rc0.786.g65d90a0328-goog

