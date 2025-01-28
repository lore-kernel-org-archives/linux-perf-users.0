Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42F11F8F0E
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 05:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738040422; cv=none; b=cT9134/41iCp4fujOJCXyeiMe0L1fwsbbwUaToCSumnmGTvj2ZgGlu4xwCt+JpUydKTLY8Whd2Ce6678XhG6PLnc82+LmtsOcF/bsaFih4SDx0W4BEIx679ve32bjzt+kFzZUXYC7/ib2+8iNa0mfxgj1XcK4F/TG7m7fvabXxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738040422; c=relaxed/simple;
	bh=XLVT31H4OpbUW1OFu7GetTjAoQ6wx83TWJr3zQGW1j8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RCx63PgjIlcFYNWD7ArCF6OPTGL3SJVBCHvh+bHrQJ4x+tTCLnJVwVTj2yQsaOsv3+9Wcw1qTwe3D9S3AkRLO6o1nBBI+DMONOd25aGxCDQ4hyla4mi7YD2l/95rLYA/YXDoHGn42+2Zvp+YB4a/RCN1/zVf1x8pV7AoBgMmKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jswm+Eb8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jswm+Eb8"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ef714374c0so8025091a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Jan 2025 21:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738040420; x=1738645220; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/NGMQ1cPPzFcGB6lbht2UloHcbpdvl9Eg+C6+XEyyV4=;
        b=jswm+Eb8hNtgHeC/tQi5TkzSonB4gAtEL1V8yy3IQhiKGGPB7cbliSgXn2aemvR6qh
         +6iado6hboVaw7HdksEBBBXb+NGeFfJV4q7jMmCKaSeDQki6Jtb+LLjywQYLk67i/Lg8
         aURCO8dlBsNuu+NGvQcH+q3KjxU2mTHTTS7LN0TaB0VhwjmXd4zSzFX5CHNq+5fvP1Ew
         97qvRVoQTyac1UgmF3TTx7zF+opsDRtg4+BsqQE5YjiB3K8iPw9+UMwoRe/dz/RgYCiz
         4FLoo0N/8OEJLbS9gOWFXzG87Aygh+mFW19ePTYcU7OBooulnzO+hT2w73DBatnHjqDH
         Olpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738040420; x=1738645220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NGMQ1cPPzFcGB6lbht2UloHcbpdvl9Eg+C6+XEyyV4=;
        b=qkn7pSV5ntDh4LA4ZvatHdCdUQIKnWpg7jiyJWD4PzgX8XV6DPP4lqc4fnFk4U4WfO
         qp0m98DqodKkV1/dmQXdXK9ghMXFozuFz0Pl6k3/dwzUcraJHzcTquAQ6Kyfsx2WvPM2
         jkiG6IwmaCblgSJOhHA/sniZ02qubBuHvkRo5QWofScOsD2XmwTgu1bABWyh71/iPeEQ
         9wXXclZ/7eFvdehVgmKunmtr1I3FN1Out+3j372snjWKe5OFIjFT68s33x/SRKwZyeoF
         yKawchMrkoZ/J4iZczEVluwzv17ie9spqMBrMj5Rj3Rw6zFt8esLHhpMNafKjZDyAbF8
         irfg==
X-Forwarded-Encrypted: i=1; AJvYcCU9nOJD4YirHvOnfxMHVd9/KfasKwfG2+LFhZpRai84QA8Q0CWkYMbgYGlVEvigpXQ8dvidbWe1E39Bch7hL1wG@vger.kernel.org
X-Gm-Message-State: AOJu0YyuG9amEg+I/cD6zUWyQHzM1nhlvUmCrualZ1NKKHiPSK+7+zJU
	u8DJyDglzqp75ctKFO0M0PoLc0ye0I0yhA41q02fB11ZNQhNtxoIa1mj6hsalbE=
X-Gm-Gg: ASbGncvY+qRcjm89lL2FFvvSDhbx51tgxbea4XRQjU1rIlu3i7huCaoOBwWGI6tbuDU
	TVTFTpj4XR/BDjZtlwbTzyG/2Go5p+viP4X7NgV9Sjc2C1POsj8k1JGo1RPH2kj+ueWdqKdXp72
	LDO8Qnn7c3E8NUAAsW508WFFKf5VoZPfpaNvAf9sLmUwEpjhPoH1JooH0kCFlW/eA76gPBQB2RT
	QPOTgqV0jF5yP/mAYqVLSJrhZXZmpszgufvDPexUW/+0JNjvkhIO1KiYoPPfQACzYHWIgBSfsvo
	poZHFhv1BdcyJAgrsjjU5c7ZABOk
X-Google-Smtp-Source: AGHT+IHlFzD2fu330ZMELwraV6ApNuAJVZ8yRk70aKuZKIqzynWDWx6XkmlUYZuDD9VCxD1qqsAaLQ==
X-Received: by 2002:a17:90b:6c6:b0:2f2:a974:1e45 with SMTP id 98e67ed59e1d1-2f82c0775e4mr3067861a91.16.1738040420191;
        Mon, 27 Jan 2025 21:00:20 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa5a7f7sm8212776a91.11.2025.01.27.21.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 21:00:19 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
Date: Mon, 27 Jan 2025 21:00:00 -0800
Subject: [PATCH v3 19/21] tools/perf: Support event code for arch standard
 events
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-counter_delegation-v3-19-64894d7e16d5@rivosinc.com>
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
index 5fd906ac6642..28acd598dd7c 100755
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
2.34.1

