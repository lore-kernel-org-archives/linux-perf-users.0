Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854126;
	b=jcjJbGw1FxCILelnNYloWI9g6Nytfy1SGON+B5W6EtERcfXZWnz9r1A9quFvIL/TD2Ba
	 9GtX0yRE5KR4xLnwF9cL1kh8SdVrpXrEkTv9cZpWHiVaaSy+eZvpAerS+KqLuBu2U5q/8
	 EeAI/MYnAZNY2NO6bQss+Vn83Eo8C2qnwUBEyFA40+GFcZPDfQMC4Abk8rIgrC7jdF9Hi
	 oagJP6WqQK7JAkih6zhMmfBsUwL3Dz4GBc7Fhqklxtdwmc+SOA3JxsOeHP+vbLejsn5qL
	 mQkriogTl1JVnJRNdI62cdh0rKYg+KJS65m8MCzaotR8O+MUjjSUlDrXZhCznnDMu4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854126;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=3x9cT1KyByPhy6LKIu5Yv62mG19UO3yaYMnxIWxgiBM=;
	b=0ZrdMIYgN+fKz+8/OTU5vY7kDoDeZZZ3m58PgEamG8ujoOf3TETbav7QYMhp5fjgk4K6
	 W5HPYJ+OgrSNRIjXVtn062vXIkE6ueuyiHzeyhrVmVLs1wDSVJua2i6yacAmML/HxWvs6
	 i+pJH8rnrciFor1gyRq9ULrJCX5j25GRNoiOuyP3/Eq0CLFSrZoRlgqBLYWkDmfALDita
	 B7xDjb8o/tmSS60uFeeFdv5fh8hJZHLcRARt1lhYI4HTy3rAn42sG5GlTJHGA9TRr4eYh
	 Ks1kjRJiwU7rIm94HXcpkoM6yopmNcdzmN3S0kMW7g7HCr66hk1fVif/QeAwWOpX5ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GuZyQNPg;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141B1606A330
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 04:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 141B1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GuZyQNPg
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36d1353fdcdso4246850eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 20:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793854125; x=1794458925; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3x9cT1KyByPhy6LKIu5Yv62mG19UO3yaYMnxIWxgiBM=;
        b=GuZyQNPgVmU6HizjMMJ/e+W18mfv/8z5EjT6uaMNYIMCg6x8UvFeRmhgJlgz3rIV1q
         +LP70bHG0QM9+pvolRD9fu9WFQ12R80V2r8SCnm+yT+fJ7NN4p1JsfrevydJW/Rxxvxw
         rk2loLNAk88CjLXIR/4TiCgUab5Dh+JwX+9eUwvMeYIVde5IW3HOQiQYPPHlI6ctXxlZ
         r1wD5d3Nnx+nifaKy8NUd52IYskJCszSj9KyBgGjKL8QdXZAJ/xPtIxcjTvdVbRp8BhC
         SN8LD+skh7iC0wtZaQu7de/kcUsechKnbosOnHGfiYezmQSZCBIK7VEzIriuAPE7Z/EL
         1rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854125; x=1794458925;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3x9cT1KyByPhy6LKIu5Yv62mG19UO3yaYMnxIWxgiBM=;
        b=b9PWCEy2h54YGjlXRtSmGCbsupNNifRyfXlPkygRDrKLXnOAl8oFajsr5RVqAmRlpW
         OASVtvgdWUveyCIi9Wag6LyGFb4qllI2DX3M2E0CV48dLZNbOhRMkXQXfku0wclitFQ+
         r8sj2XyBKdHUWodMyhVtASXFFmiLoTkZopIu4UFVaLk/UmmRxrfftlRqspeXAzd6AZQW
         3z6WlugB6vLSRrjBiXvQdIbDLBYrU2hjI+wwyJfeVo/R+EReR9lX/1u8KIO0r7EIn4iA
         vwJ8Ywo9vFaWfP8eD+Ckc3XBZhBuazUCQkcRijuDS8PZ+rzZalA6TbCHH1KYssgkGSqx
         BeMQ==
X-Forwarded-Encrypted: i=1; AKwUvBy7+zlE9xbKK13WOUXFYbyuQAhafpWOvOnhrQUiuRXoojBV3LLXbhfz37XX6zloCly2MmwUv+89YKFln3ODzzOc@vger.kernel.org
X-Gm-Message-State: APuU4Z/YjGIJjv1cBYEGXblbkiFUJxwfdF3eS49Ium6oEXuDU9U2RG2x
	KnFlCACRlIpx00ufNQKtF6w1CcXigFWLi6hJlGM3zd4lLuOWBIK08MbOQMcg6kKW8615XmlhcsD
	DWIqhhpu5rQ==
X-Received: from dybgh19.prod.google.com ([2002:a05:7301:13:b0:35c:794:f74])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:65d6:b0:368:72f0:353a
 with SMTP id 5a478bee46e88-36a42431e17mr22614402eec.38.1793854124717; Wed, 04
 Nov 2026 20:48:44 -0800 (PST)
Date: Wed,  4 Nov 2026 20:48:41 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261105044841.102295-1-irogers@google.com>
Subject: [PATCH v1] perf jevents: Don't encode MSRs with no value
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Edward Baker <edward.baker@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Perry Taylor <perry.taylor@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: kernel test robot <yi1.lai@intel.com>
Content-Type: text/plain; charset="UTF-8"

Fixes the events mem_trans_retired.load_latency (EMR) and
mem_inst_retired.latency_above_threshold_0 (NHM, WSM) that were having
their ldlat= value encoded as python's None.

Fixes: ffc606ada3d7 ("perf jevents: Add python converter script")
Reported-by: kernel test robot <yi1.lai@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202611050801.67bb4af4-lkp@intel.com
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 080e04b51b8c..e083f7495e67 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -396,7 +396,7 @@ class JsonEvent:
         event += f',{value}{canonicalize_value(jd[key])}'
     if filter:
       event += f',{filter}'
-    if msr:
+    if msr and msrval:
       event += f',{msr}{msrval}'
     if self.desc and extra_desc:
       self.desc += extra_desc
-- 
2.56.0.455.g6c5a503b38-goog

