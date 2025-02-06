Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D692622F3BC
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Feb 2025 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738826630; cv=none; b=FV5eeNa0UuH1+/IDkunmWBt/HludJ7upYIYUxPqLy18UFAgF9yPiB394FLYBLRMZUGbgoVx0W5VPwnGDW8BkWiA6jMy6ZrZHV3nyirrJokalEaihiCLcfaWbKRTS+T9rOSJKM3pFfmBVFGKyet1qDmWla+sqNFrva/wpyuU0Prc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738826630; c=relaxed/simple;
	bh=muodTsnVAJre2gM2fI9IXU2vC9qgh8uwOpoYVBXjtVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AX4/NjSwb+w+wXVi5LPyTezbdirx6t5/ytPecIRdrWQiRGq7ZRVh5RHtZRAtRnVWKoekUfr8PJLI47mqYnytf0PDRUOWO+Gf1xxG0M0wQNN6z9Ri3fEs7A79t5iP4SKfOtpVmvfY36tqIzm4bc/3a+SEYBYjEXCNUQcHQcnDmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KtZ7MCkp; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KtZ7MCkp"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f9bac7699aso758354a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 23:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738826628; x=1739431428; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEHs3b5phPFn3BF7F+ULl9Hz6SGERFY3irR7WbMG6GA=;
        b=KtZ7MCkp39XIKyooKPPsQoq3ieX867zNVCupcWBaw9hdBQ6KmqcFplclSLVjo6ihxo
         +4IGD8wYbapojCkWClimv1shf3MZlOv2IyuLK9qF4C4XgbnddVQe2DR5HnFwA2N2iOi3
         O9aG8FJf5P5AudFIL9gKM//RBTlLE74nbZS+CatYlzGg5XLDo25IHL6zsLrmLmnBmt2t
         rycG/Rj4Pp4DMFr97CcCSQecCAJvdTLjXIKJ//OZE/9klNINBjqad9czNMBHBiEydBZq
         ONj4nWlFdzXeuJOKig5MsHNksinNc3VEyyojJQcAwYwoaaqCAGoKiZ+u/wdTWlAZNB7x
         T0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738826628; x=1739431428;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEHs3b5phPFn3BF7F+ULl9Hz6SGERFY3irR7WbMG6GA=;
        b=Vy7qO4IYoxi1zLPGI0hL8rtsurIMdqfGlqrl9kc2iAERHH7g/yE7ui96+6bRBZgEcX
         c4GAOPqP1HR8LByUlxJ6i72g15Ys6IBKCFm7SKIT56kWYVqP3Ysgt5q/u+LaetIyGfVK
         dTETsrVRkHxZ7rFIvfETIRfokakCNBsRRDAY+R6gr0/j45AWmMfrhOs9FZAcDrAzIR/+
         88lNCNLNxk8stw7DiliXzxe2xTPb4rOxyQ5LFepLP9SwzDl8TqNDx04ecJEqHJxEdHn3
         CrShRxFAqpckjirWhgktIIq+Lq2cPGig45l5B2ddAwNd6aZzTT1RMeeBOgyCi+6IjN/m
         o6KA==
X-Forwarded-Encrypted: i=1; AJvYcCUj18pc4KeCl0QVhC+ysYSeZDLJer7kjhvXRvoeAEFHL6xAehJ7/FUFK6GyW1oGJH3b34TtApB1GHhWDmKbb28e@vger.kernel.org
X-Gm-Message-State: AOJu0YxXccBHR9On8tnLI53EE7jXrap7E51afRdABEKx2mDqZUstNf0T
	RSOl7q7ByJX9YsAJHKkdRn5gtkzhr5zxOeQIN4lReJCs48rA8m9kDaDHQUgKXlI=
X-Gm-Gg: ASbGnctysBBi6o//eZgAZ5sZH5M1MiNiiTz5GUaTkqR0UolkZnG2Gb4NY9mreHNzqGa
	lQgsIAepmV6R0kjOCbJF5g9BvKMuCc9+rEX2oj964h6La6gQxNJNRrm9zPntqngqxFSY+YH3+8W
	js+UdVrL/OFEfZyl4NDhWIy2uxX7yvL4vKinJdSRpAC9YKIvGbYKSssVfjt8u0rBrAvU7TV7871
	nTNdDmBiPZoQGvvy3mNxAP3eeIdzmEnmdrIw8kTxeja0B9swKL1DkrwI42MDUmZ+YxyJS3NQoGr
	lPJQfknfLxV3cK/N/0Ijt+fYXIts
X-Google-Smtp-Source: AGHT+IEP7EfP8VYTZfd5HpBEgA2d9buHDVtURDszS/7//CqJNqgdAtdkSc3vqiKyaUdxMxfHiRPc5Q==
X-Received: by 2002:a17:90b:5108:b0:2ee:ba84:5cac with SMTP id 98e67ed59e1d1-2f9e0753cc2mr9646959a91.7.1738826627792;
        Wed, 05 Feb 2025 23:23:47 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a72292sm630883a91.27.2025.02.05.23.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 23:23:47 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 05 Feb 2025 23:23:25 -0800
Subject: [PATCH v4 20/21] tools/perf: Pass the Counter constraint values in
 the pmu events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250205-counter_delegation-v4-20-835cfa88e3b1@rivosinc.com>
References: <20250205-counter_delegation-v4-0-835cfa88e3b1@rivosinc.com>
In-Reply-To: <20250205-counter_delegation-v4-0-835cfa88e3b1@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atishp@atishpatra.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, weilin.wang@intel.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 Atish Patra <atishp@rivosinc.com>
X-Mailer: b4 0.15-dev-13183

RISC-V doesn't have any standard event to counter mapping discovery
mechanism in the ISA. The ISA defines 29 programmable counters and
platforms can choose to implement any number of them and map any
events to any counters. Thus, the perf tool need to inform the driver
about the counter mapping of each events.

The current perf infrastructure only parses the 'Counter' constraints
in metrics. This patch extends that to pass in the pmu events so that
any driver can retrieve those values via perf attributes if defined
accordingly.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/perf/pmu-events/jevents.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 28acd598dd7c..c21945238469 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -274,6 +274,11 @@ class JsonEvent:
         return fixed[name.lower()]
       return event
 
+    def counter_list_to_bitmask(counterlist):
+      counter_ids = list(map(int, counterlist.split(',')))
+      bitmask = sum(1 << pos for pos in counter_ids)
+      return bitmask
+
     def unit_to_pmu(unit: str) -> Optional[str]:
       """Convert a JSON Unit to Linux PMU name."""
       if not unit or unit == "core":
@@ -427,6 +432,10 @@ class JsonEvent:
       else:
         raise argparse.ArgumentTypeError('Cannot find arch std event:', arch_std)
 
+    if self.counters['list']:
+      bitmask = counter_list_to_bitmask(self.counters['list'])
+      event += f',counterid_mask={bitmask:#x}'
+
     self.event = real_event(self.name, event)
 
   def __repr__(self) -> str:

-- 
2.43.0

