Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621752;
	b=wdxskTLi0y0n/3kBFewSTOvAXH2AnejTkZaulIWFcMMRFkxwPjyCOgh/56BbwDRHhKwz
	 05x/AfLYyGAQE1J61nvMYb9UPGoz110xKMj47nV8HJHDVPjOvGJIGIhRUd29mS1oCLkEf
	 AVwSsZblxtD0uH4s++ZM1XB+f4jBEZYDBTP4x0f7f0xme3zm4UrUAuIALfbIqrTYyO+gf
	 wjPkKWoXtwb7t/st0S/PSTQGvxbCAZaTtC8tdBCeG/g79A+E/jh+NQmakE2jO+2WQMONv
	 zxafTKA5LXXVrgwxz9zeCxuxb80s2xtVkMKv7JQnnwf4t3Piv356zWZUqvwtG0zIb5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=oer2FEylh2AuHX11Qb8KMHS0ZlqBiWuym9WiBTameTg=;
	b=C4YJ9sLPABuu8m2HyeI/lQne/4aPPjNzJJ952pIq/JrfDX9Bt80FkRitH8cofbxgvWUk
	 /nkviVBOu3di4f3CgT4O25uu/P3A+Fd+qi251K83g7REKjoYg+K6Q35yHqPHIvMytdI4U
	 zzQxUYiCMLe+tEnObNyxLe2cKu2r2IPEdebI6I+Xq8RfPyyatN4eQAQd/lLJ/lec+u3RT
	 73i40HaYVHqgRFAmdKIuQ8P/ZvWHIk2OzUobjR45rdGQO818RVJKGAOrsDk0+N2WpT4My
	 kjg6isXt7QC9dE23pSTRVCyrijqofi5DENBcDpBDDG0lD7QUBz8UKK1/5SC3oHVctRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gvnO6Qr2;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85DF60A3827
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A85DF60A3827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gvnO6Qr2
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so24209275e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 04:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793621750; x=1794226550; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oer2FEylh2AuHX11Qb8KMHS0ZlqBiWuym9WiBTameTg=;
        b=gvnO6Qr2RYy5zQZT176OT/G2HVWIFwlXQzUK0wo4atjCzvz9E/z4GfaBV/6Il8L+OZ
         i8E7Lm0kFrsJcaKrMqvpGLMiTBZ2zvHVGZslCK3GlC3WrRSg2rn1Atmz58qDexatGiSl
         jdQY2U1LDfifRT9NUR7UPxFrT2DfOrL7hZPI4+FdOH/D8wOs/ZxP1JxtDfiUqXPjN1ZL
         9SHEZ8nP2o1Ecndpf7z68kI31CgVGPfj0kpckDpu0WycpRf+z3FMRrlByLcnFLgMmvHu
         kONwPH96y2jNPhcSLhgch7XLzK17ZbuxJ05/YDbDNBaFsYFPLTeJiWns7GEb7DXy+ZeR
         UK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621750; x=1794226550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oer2FEylh2AuHX11Qb8KMHS0ZlqBiWuym9WiBTameTg=;
        b=Vl6mB8xLI/TaFZpxauLBtWE/09GGzONCDxWQ1QwoCdoj/xJb1emzLC5oeFO6adFJ3p
         4UarGiqol/rK96PYRB7v1F5gBFLztwgSv7BnwKZzkDvtT4b+3fz15qCznhItk/3vqiHa
         BYmfbY26r17VYKwpC9PdQ6yPmNTlRst/nWK+fSAoFk6kI+mU6/b9JiHM/JOEyd44hePw
         Hhv1WYsIfGQyY27AOFdYFqWmel134AoNDoZr7V6WG66KpVtfU9xaW+9SDvsChBGC9IOS
         6vLQCsSK8XPKSn5NKH0cHQ00jr+MtDsyyUhM+zvKAsLyJ1wrUXbnPdqWEL/Jyr6LpSUz
         Rksw==
X-Forwarded-Encrypted: i=1; AKwUvBxmbm3gG4wfijrJwkz4XS3BWljMYdDZGPEvIM97H/tSWejbxAJp3e/fTDjyQsH4Nv4efB1BKb3j0fukR4ZMrntp@vger.kernel.org
X-Gm-Message-State: AFq9FYKwkgnVoVVksQ/Q3ZwyPnZpMJQ5UmIZ+sCSj6KcXjCBSqD1rit6
	S/AyQm7wgtMYweVVqIAgN6OGyPZ/+wsLq3IGiLQ2Q3bvfayIj6LI+lc8HUFibptpO74=
X-Gm-Gg: AYBFou2FSogisMC5HzkLx8xM+KwNpnOGA+2a3AbGmZq9s5794RodbODMS7P9jSG/Mxs
	xAviMjA2yEAwpPNtVK6hRZWqMTZbSM154sgkix9SAjgt10Lqddaf8dvK02NfU5fHgXREYhArswZ
	MthNyOlkQuSd9a3VPvPY85zSCFdMDaDJ3bjpATieeRbGpHnIfbaSYZTY/VLTm+OQmLrbzScgA7A
	p5GF+1zYhQPBX6oco7fL1rcBsv3syN8tc1QMnQC8a/anRCS8sNhJx92XNae+4s2u2xnuW8LSXKW
	vt/KUkkyaUJ/wr9ZHj/itHqnD5xWouYTTIBzK9sqDXiKiRn4P+180QQ6p5HXVCl2RxVzJ/MXAjT
	5RBj4TXpVVS1yHFpIkI5SyQWg2IQk2xVA2zi1sD8SPRnkJMATPwzf5nEdnxn3oG35EP2l+TXJYe
	xFRDUHYyJMSW2gXQcITgaGP1zzmmb9qb6Q/TKRQbSX2YQ8tObe3F1x77OeFCbGvZM+8hW0I0NtC
	/QZ6xhl6xw2EKD3+GbTCpF0ehRQWJIVc730yYLbPRfmK+bXWWl8hDKDJ1ekymI9RTdik1NXZ61c
	z6MMChMGvhSZwD8cz0v1GCr+1A1ipUCd
X-Received: by 2002:a05:600c:4e90:b0:4a4:f48e:78fa with SMTP id 5b1f17b1804b1-4ac175669e4mr220866395e9.12.1793621750147;
        Mon, 02 Nov 2026 04:15:50 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm434974855e9.3.2026.11.02.04.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:15:49 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Mon, 02 Nov 2026 12:15:20 +0000
Subject: [PATCH v3 06/18] perf cs-etm: Don't drop previous target for
 kernel samples
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-james-cs-unformatted-per-thread-fix-v3-6-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
To: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@arm.com>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>, John Garry <john.garry@linux.dev>
X-Mailer: b4 0.15.2

The branch target of the previous sample is used as the start of the
range to disassemble, but if that sample's DSO is "[unknown]" then we'll
drop it even though it's useful information. This happens when recording
userspace only. Save the address earlier for "Trace On" samples, before
we get to the early exit condition for unknown DSOs.

In a later commit to change the default timestamp interval, trace will
be collected that triggers this issue, so fix it now.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/python/arm-cs-trace-disasm.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/python/arm-cs-trace-disasm.py b/tools/perf/python/arm-cs-trace-disasm.py
index 1812ccaf4b20..5a7daf927bea 100755
--- a/tools/perf/python/arm-cs-trace-disasm.py
+++ b/tools/perf/python/arm-cs-trace-disasm.py
@@ -52,6 +52,7 @@ DISASM_CACHE: Dict[str, List[str]] = {}
 DISASM_RE = re.compile(r"^\s*([0-9a-fA-F]+):")
 DISASM_FUNC_RE = re.compile(r"^\s*([0-9a-fA-F]+)\s.*:")
 CACHE_SIZE = 1024
+PERF_IP_FLAG_TRACE_BEGIN = 1 << 8
 class _State:
     sample_idx: int = -1
     source_file_name: Optional[str] = None
@@ -252,12 +253,12 @@ class TraceDisasm:
             print(f"Event type: {ev_name}")
             print_sample(sample)
 
-        # Initialize CPU data if it's empty, and directly return back
-        # if this is the first tracing event for this CPU. This must happen
-        # before the dso == '[unknown]' check because the initial
-        # CS_ETM_TRACE_ON sample has ip == 0 (dso == '[unknown]') and
-        # carries the starting target address in sample.sample_addr.
-        if self.cpu_data.get(f"{sample.sample_cpu}addr") is None:
+        # Initialize CPU data on the first event and whenever tracing resumes.
+        # Trace-start samples may have no source DSO map, but carry the next
+        # range's starting address in sample.sample_addr. Instruction samples
+        # in the first range also have TRACE_BEGIN set, so only check branches.
+        if (self.cpu_data.get(f"{sample.sample_cpu}addr") is None or
+                ("branches" in ev_name and sample.flags & PERF_IP_FLAG_TRACE_BEGIN)):
             self.cpu_data[f"{sample.sample_cpu}addr"] = sample.sample_addr
             return
 

-- 
2.43.0

