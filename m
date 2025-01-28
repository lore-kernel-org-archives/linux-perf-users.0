Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FED1F91FB
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 05:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738040424; cv=none; b=TzJlMMgrop514f6JewPbTdZkw8wCyrdAWwc65+QadL0C/HRl9Vbs/a7F0ckPj0KV0i99kkIdf8PSyGlyel6BhOIzOjnnn/VCCC+MKBKTG+IhJxCC8BQqv9kPb2PVmIvr7Lg4sYNAVFa/op/TvWK68qwNZJck2ORxa4wQiqnfwhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738040424; c=relaxed/simple;
	bh=GjWW1PZeSMVVp/YE0YLQ4xt4IwvJzVvhTdWUcKrLGJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lSCL8symQ3b/hhSsKOt5LSVk2qYVE1NVRmYnLVIkK2hEl15CBPvS4QZ/VwaXQudL6rwCsJk5BzeBApRPaiW1rs+Yf1vNkGqqtY/bVEIRqbwmmE7xl/swUqsHKcM5ZLoZwZBkoydkEY7e5uGwMtlGkSTBuJ6et8wscsj4tMMREjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fq70pdjD; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fq70pdjD"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so9188340a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 21:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738040422; x=1738645222; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Msmauk788mzUDGMUfQ29+G0+6TVWgLFLPWjnpzGrxFY=;
        b=fq70pdjDp+tFzPDZdeItpKIjxTiitr55X65s0lc8Is5V9I9s6cXTf8pIbArfblzVXt
         8l/jdbE9BwcPFzCn2//5AkTnmaA5dKNBfe5LXCujtrCa2Uvs2tuUUgFzu0llJYM2a/DM
         1/MHrxpNQKZqBJlzstd7cXnqNgixi0NXyr7zIY6q62dwPWApWQrYBCrwz5vM+vI/F07j
         3iKnfM1LYYJB9cuQIhMvE2crGQcFGhqRCqerYo0qSCPlnnIk1IWwMjtdNhc/lEDjz/gw
         q9uQSlLXmYlZOhkEA1sqhry5FBDNwsykz4ofg0L/XuFXzIV/hbFn8JG3RF/6TB94JMmZ
         zaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738040422; x=1738645222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Msmauk788mzUDGMUfQ29+G0+6TVWgLFLPWjnpzGrxFY=;
        b=A8P65P5yiWEn3qxLz7YNHM7Pf9/XoeE/vK/3DNuEmHytZsk7/woAaO7MfvsJiWliP5
         61lGOyo0D/mg5kbfYYS70U8wLcbCiirtmSUFNtOlRt0eAOABcJfJdUB/qXElJw2ZrjO8
         Id0RvrSeeoAqXUGIh0qDT3rDw3cpI6AMOg1m1hLvRRDKhM2/Qe0aNodgv6fytYg0JU2/
         5LjiNNS/Ocbb5H1cbSA5GxgfNJ5GGbcun6lBPu5bv9qKRojNTKPOIn1pRmwCwkyl/th0
         2a7yeVA61VmR1F5UNyIp2xZiRacq2JsY0TnvB53RQHk+EyF8SnbzRDUi7j0MYr0FrtSj
         40Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUnzPLK9CyNM7E49zZo5ozw7p4uW3xdc9EmMB3naCBK14mUxwVCcGdjKrZfwoPgDAIMu3RZ/ldInXxtPB8w+yQj@vger.kernel.org
X-Gm-Message-State: AOJu0YzTnyAF9/LSkNAcNrmRVkADx1yP7TgjRU5lAhL69svFeIuIN8My
	JtFiNocXTR9VP4o1QGEILixfNlXMMcrf+VBBdfq4TZSxIk7RhSRO9uqwtTbBvfw=
X-Gm-Gg: ASbGncvAIq7cQOjL9svzKlwThxdF1yIpTaK88veqEyCaNt7Mp8d/2SSlArM77aeA4Dj
	8w62MrQrgnWgqN1KJzYIn9OXB5bNLfru56kmoIf3xk/N13bw2zU00XidFw4Nde0KTdg4k0Cq+zj
	LnSSUgsT+uUxkD2tnS2/oA7S7oN5kwynUtI2FkyyGIo8Lkup9fcsrIog+7yLhOzTgOawZkP2zOx
	M0Up5Ntf/DZabCgMAZFEZOonOHNUxRnu4fkSax4TCAklNjsnkShNUpd97WXGK27lwxwidb4cHjm
	kk0NsUTsawaNGCkmRvw0tHgDz7Wc
X-Google-Smtp-Source: AGHT+IELryn7Li8G6uRsK1ux9a/8YArLklBlMT1VjVPaGUmGZLNmSMTAlEJHZzc25zLYxiYqH+BJ4A==
X-Received: by 2002:a17:90b:1f8a:b0:2ee:f687:6acb with SMTP id 98e67ed59e1d1-2f782c94b50mr63592948a91.13.1738040422123;
        Mon, 27 Jan 2025 21:00:22 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa5a7f7sm8212776a91.11.2025.01.27.21.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 21:00:21 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 27 Jan 2025 21:00:01 -0800
Subject: [PATCH v3 20/21] tools/perf: Pass the Counter constraint values in
 the pmu events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-counter_delegation-v3-20-64894d7e16d5@rivosinc.com>
References: <20250127-counter_delegation-v3-0-64894d7e16d5@rivosinc.com>
In-Reply-To: <20250127-counter_delegation-v3-0-64894d7e16d5@rivosinc.com>
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
2.34.1

