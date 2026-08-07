Received: from out-173.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622A386C1E
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 08:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090266; cv=none; b=RjHgZhagbn7rkyMGgJX9/1TBT5UxYRwrnH79o/X01tOxSB9xaPUn3oiRW5dK6oykXQXVb/yb2G0P8I5JnA7nzeCkZfLeCZp3xcjXErjyiz3oFyWup6xKblko3HjSEezalDuDxL4DG6rHyorXH1/SeGzrKuXQ0A/xcGH+nb+dS78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090266; c=relaxed/simple;
	bh=xHE/d0HYFsBG2ARy03z2OF2ujcxDA2oEvLrr0Z6o9Gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PnTEwttEa9GBppGSMjAISynQK3IHaKgsihNmIc49A1QcGG8K17C/wuNI6nzwTqz+Y7KYN63wtvSQA5UihtJU+UtDS1O2tUu369fGTJdeUQBBDikiLVja6X6bwkXcwYV+/x1M3PMUldMwC5eC0FzEg1xRFg6z3orU8kIr5l6OhVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qdJLcQ2p; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qdJLcQ2p"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786090259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skcFgrDrxZ6+DyRGwONJh0xEp2yNo2u6zqgzqw3g46I=;
	b=qdJLcQ2pXzogTF+VR1RyTUzTCLAs7XYMlH2k5MGk9344bDSEaNI57LbwiNFIq0zmXEXHlG
	zjSjGj8On+F8bGyVEVDtHHowtnQVfmTQRtVLg/6PZfasW7FutJHEyPqILPJSkJwVGIL2No
	9hIxarCbnD6ejV2sjqlDPygNW7lf6+M=
From: Atish Patra <atish.patra@linux.dev>
Date: Fri, 07 Aug 2026 01:09:15 -0700
Subject: [PATCH v9 20/20] tools/perf: Add RISC-V CounterIDMask event field
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-counter_delegation-v9-20-58658104e487@meta.com>
References: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
In-Reply-To: <20260807-counter_delegation-v9-0-58658104e487@meta.com>
To: Will Deacon <will@kernel.org>, Atish Patra <atish.patra@linux.dev>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Anup Patel <anup@brainfault.org>, Ian Rogers <irogers@google.com>, 
 Rob Herring <robh@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 James Clark <james.clark@linaro.org>, Namhyung Kim <namhyung@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org
X-Migadu-Flow: FLOW_OUT

From: Atish Patra <atishp@rivosinc.com>

Counter delegation lets supervisor mode choose the hpmcounter for an event,
but the hardware may only allow a given event on a subset of counters. Add
a RISC-V specific "CounterIDMask" json event field, handled like the other
arch-specific entries in event_fields[], that carries the allowed-counter
bitmask through to the driver's existing counterid_mask (config2:0-31)
format.

The value is the bitmask directly so no counter-list to bitmask
conversion is needed, and because the field is RISC-V specific it is a
no-op for every other architecture's events (unlike the shared "Counter"
field).

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index e9c6b7990880..e79143af6aa0 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -396,6 +396,7 @@ class JsonEvent:
         ('EnAllSlices', 'enallslices='),
         ('SliceId', 'sliceid='),
         ('ThreadMask', 'threadmask='),
+        ('CounterIDMask', 'counterid_mask='),
     ]
     for key, value in event_fields:
       if key in jd and not is_zero(jd[key]):

-- 
2.53.0-Meta

