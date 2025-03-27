Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752D82356B9
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104205; cv=none; b=fhtGh3IBBfdS7eguVKWXkPvXG8KNLAxFcf67km51mQ17ygcAwjRRfomGlSR04dFcBDvTmz6dfeXQJczSr+Oi0gQyW1pjdafBCGUwUKmSIhPAkzVnwUHCKWFdT1yrI/W3EveVgYxhmUhCAJp4I6Soin2CijbPVAUkroJabG6tsuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104205; c=relaxed/simple;
	bh=kRGau/48mTGJ2xTWuPcdi0eoSaf9cQvclbky87zpLn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j6leNU55Tx3AwmsHEKg/QEd/3CFHSGU216HNc2OnwBy3BjzVOydBTh+da22uwVAfY+qPOkGyhJv1Q+RCgsYahz5fFAR24Lr1m+37+OUyc7+AnQfG099CUqV4Y2raVqv5wt4SePCiZ4Zbum9qzS91gLov7dcX0p9ZoVlj7naMz3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aKcPq3io; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aKcPq3io"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-301d6cbbd5bso2242375a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 12:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1743104203; x=1743709003; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KJwNDXXlYjKjGqwwgKGhwlhZINc8dMq3L7uwB92VzFc=;
        b=aKcPq3io0myLMqyKgCWWNP9yJlar9YDkGvBa0uOQjm4sUHv/aptzwVzJSeH7pM01Zb
         NdMgKR6Lu1yBRE8AVe83m1OmwlcqcKxAFTIbhVoNp1PwqJzJHsEjtuhVILUCIs1049Rp
         ohpVcIMAYHCKafBE3BQzN7T676Ohomioza+WuPi5sKD3TYv/8ijFiuKWK7pw/LnoErPP
         jCHzTvT9ydfaXHTXajxqmxY805k6lZNxejOHESIuvY0VZWaYxryqFmNvppUsbko/s6mm
         K5to8GXAExmOdE3eBKoFN6qNnNKhyGzUIKlWzQAoBcj6pM+eR9A4kFZZpGOIk2ZVfIS9
         2LeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743104203; x=1743709003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJwNDXXlYjKjGqwwgKGhwlhZINc8dMq3L7uwB92VzFc=;
        b=LnZaPZ3vjYKM8IRM+kD8w8r6lDgKeBwL7ns6sxmzmwEiVuFdNRYD/5HZCLqKbgjbJP
         kNjz5nOJqNND62DZjPezGoqjb/4+zZjGfnqy/Lu4KNgAj9q5I4pkoCxfdgnVnfTNJ/H2
         0fbbLXuGt2EnxBreUA7ozTlg1TdpsY84GbUvlS1T2sfbn22L/GK296cDH70URbJC/muE
         aH+JqqrdOc1Fu6lkG9WbBRSMxyfvmcqTI4SaVQKKlwYUnikJfOMg4JGx2JeMxi4mAXZT
         xA0OW27C06++D8UVv0JUuGAr75FAWuz130hqtPGBQcGQ4Pu7sBzCQaobyj9p8baN0JwC
         vq8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZV6FkZbllYOhrfJgtjwgCI2Z7HpGlEBjZKCUjmX0kNfwmgbfCeBBw+HszOPKyoZr3sTltW+yv14BeO188vkfQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyM0RYxQGjFIiWYRNiq10y3agq8qzc5YembzLC4xHkFLRsbSHpa
	uIfx4HbqW4kruHkpz/J2CvmKAvz3W68i96gN0k1Ei8HZzg9082htcm0/PN6uZWY=
X-Gm-Gg: ASbGncsde4/3bBhS0xCre5V/muL59UT/sP0YBYjQdPdkfoTwuMUmzBuHVjqwJa8BeT5
	puCAOBVXaXid1hry753FqfFscz/WBu46UdRm9TcOf7UFsc/onH52Dw9XVtJ3CQk85pcO7m6v5BB
	x6HStfaM8zDUj8swUVFzrfiDcsImm6TTgcXdpV5OCVw6OOp01vt8XNRHS/VWd4PiWb1ViBQY9MT
	dxqVaPin5UmYflixvfsmX5RNAeQ6yOH1blIrmdFmgiOcMzmTjqve8MYgf52RU2MxGRdGbqlFbLp
	BKoJ+plOpxzAE2pYl27xejXVzwsIAvfThBY/A0wive2AXJgNHbu8gRdDAg==
X-Google-Smtp-Source: AGHT+IHr9lkacen5G6bNal8x27vd0zlzKk1gXvQpJoZ6ZU4fSbwcKifIx6nJFU8JTt0ZbyyT81dbnQ==
X-Received: by 2002:a17:90b:4d05:b0:2ee:b8ac:73b0 with SMTP id 98e67ed59e1d1-303a7c5b9eemr7219789a91.2.1743104202835;
        Thu, 27 Mar 2025 12:36:42 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039f6b638csm2624220a91.44.2025.03.27.12.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 12:36:42 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Thu, 27 Mar 2025 12:36:00 -0700
Subject: [PATCH v5 19/21] tools/perf: Support event code for arch standard
 events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-counter_delegation-v5-19-1ee538468d1b@rivosinc.com>
References: <20250327-counter_delegation-v5-0-1ee538468d1b@rivosinc.com>
In-Reply-To: <20250327-counter_delegation-v5-0-1ee538468d1b@rivosinc.com>
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
X-Mailer: b4 0.15-dev-42535

RISC-V relies on the event encoding from the json file. That includes
arch standard events. If event code is present, event is already updated
with correct encoding. No need to update it again which results in losing
the event encoding.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 tools/perf/pmu-events/arch/riscv/arch-standard.json | 10 ++++++++++
 tools/perf/pmu-events/jevents.py                    |  4 +++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/riscv/arch-standard.json b/tools/perf/pmu-events/arch/riscv/arch-standard.json
new file mode 100644
index 000000000000..96e21f088558
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/arch-standard.json
@@ -0,0 +1,10 @@
+[
+  {
+    "EventName": "cycles",
+    "BriefDescription": "cycle executed"
+  },
+  {
+    "EventName": "instructions",
+    "BriefDescription": "instruction retired"
+  }
+]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index fa7c466a5ef3..fdb7ddf093d2 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -417,7 +417,9 @@ class JsonEvent:
       self.long_desc += extra_desc
     if arch_std:
       if arch_std.lower() in _arch_std_events:
-        event = _arch_std_events[arch_std.lower()].event
+        # No need to replace as evencode would have updated the event before
+        if not eventcode:
+          event = _arch_std_events[arch_std.lower()].event
         # Copy from the architecture standard event to self for undefined fields.
         for attr, value in _arch_std_events[arch_std.lower()].__dict__.items():
           if hasattr(self, attr) and not getattr(self, attr):

-- 
2.43.0

