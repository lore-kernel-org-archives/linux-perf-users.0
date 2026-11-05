Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879132;
	b=b31OsVjM52tMM3gnOi9DttxY0DJT8A/bfFNz6EB2FB1SL1YWI7gerxN1KnJhJwbyYeDi
	 Ij83/BO9bxy9BjmM2zmLNTSRT0bYMvTidKGtQcA4u6c8H6gCJLm9delT0n4HgUvLjWHpt
	 sSza4kSC6oKyqYahmIkuWS5R2J9qwfhJspxk69c6W7WXVXsrc8U2ep9L6KBrkfv9kZmju
	 sPSw7dNrbkxRauIJ57umjsZ2q7mpLy08KYF1D1xXizMNPmXrBSLg0Q/K5mE6E+HPbiARA
	 SsnKiOJm3l0rUAKDXdi6EtF8F0ORc/m5TyWqGl80IWec6ciIykpxCMIyeqvseYgaOvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=z49MEnSEMTTPulUvnX3mC1j6+RjZ98X7wWOuw2hUt64=;
	b=WhKVwe9W+QFLOGpeC1Ae6GGhj6n76qaOSxSA1LXyl21cMRYFSuMmR9pjczwsyWNZaJeO
	 tKZLO3Afol3jJDYvusIiuWI/jXVw5SD7rtNxSLdNHFQYI5H+djcHh/LzzCcIc4QBBao/p
	 UX8iTS/W8tQ70eirTbUxxDjdcFiWzthEaMmBb91dAIhxiwOOaQIl9WZ/4RLCocB1zGAMC
	 Xb45H3PeFDfYINp90ZP7GECPX7dKJ9epQok3VoaLXj+LoqnDeCYuuBYw2tBCVfhYyhqL7
	 HIzp3+IfW87GH1NpHQReV10eamTlNZl62+/RFvsN7q7tU+NVOY9vv5XZNmV3FMVT0gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yILaHeZc;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BF960A381B
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 11:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51BF960A381B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yILaHeZc
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so13736825e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 03:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793879130; x=1794483930; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z49MEnSEMTTPulUvnX3mC1j6+RjZ98X7wWOuw2hUt64=;
        b=yILaHeZc6PMoxawalEI2guQkSUg2FMKKo5Cp/DrUT2PIApDrUgx3D1dK02yTVA6C2x
         AmNBh2iGE6RidU1GP2wSWZcmfi9lWE1XETgYPPHCX3f/rmgnP9XR69UtHvWzy7AAnWgw
         NLrwh9FAIM5ntGj/x1V77QZGv6DoLDTxED/l/RhCA90JIL4EDtoSwIq1yh+xFLEDVq3E
         vvTkP4dbciCHCDu/UzsArZww27OYuuMrulZhNwY23B9fSKc9pzAYs5souOzEQqEFrqSI
         RKrXWWp4ZF1L6M/HYavQobB0xU72oPgjasPU1RyLF87EvMLfZZGtez6+WPWmmFKvJTo7
         owUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793879130; x=1794483930;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z49MEnSEMTTPulUvnX3mC1j6+RjZ98X7wWOuw2hUt64=;
        b=oz1AtWVeUjf+BzX1Y76koOfm0XSTzKD5Bil3LyK2VKuo3p8UeS8mQMIaOKDyVHjvtE
         xezLQGUNKjIzpdl5nUW/ODia/F4PRT2nZf8wbg4qSj48peHt1T2fdPl7hhTQwxSMwG08
         K7XmtPbEOhHGowTggxCaOpVCMgjTF46RrbvHDzN+HeU38vS4LPx4guwR6n9iDIlVUo5I
         fD6okOBWgJTOuiNDuR6e3mdxpJ6PO0ITTCfnhczYHC82bX1RT8HVWVa5iticUcLc+APu
         G+6MbpwxcwItuX2GnXrfvngcIA9yGgbqFGWvr6JaPo3X+1/xV8K7Ule2DS8xG4B6NTvZ
         NKsw==
X-Forwarded-Encrypted: i=1; AKwUvByX+JNV7olFQwZMNPX1Kwmy8UPFEt3uBGD25WIQgcl2XLw327280V0lOYviSXoYwwR4IuPqa2SC/LO6k8h/KyQp@vger.kernel.org
X-Gm-Message-State: APuU4Z+ubTSAMXbsUUdVPo7z9rqVaJ/U/t4NAsL/JYCZpghcXQos7MS/
	GUe+revBBGkTNmrqek2dzRmK3p6hDiwJHW5qLMDsECtZhSrHfjmiIzLCsaVxb2YENsc=
X-Gm-Gg: AYBFou1mLtByuBBxbJT5De1yzCKtSXU5yaQb4K2kXGNBuirTO6tFnnuk4c4o5ZRg7Et
	nVWOTmNdV1xvuXpqDAY7Gv/PZsMrQo4ig6EKp54m3NKn6UXOs8Lp0ULF3v6ZKKSZcrqofXQZAom
	DiuWa/pQxHaBvX/fp7B03hGMQnRskYVUTops5AHG8j2Ozh5uFguf7ynDU8hjxNcqa2PIoRWSZrW
	DLgCJMIQzZFtMwRQtHBLkkMFqyo7y7H54Dhh9VAsPqZ17YS9ROaNsJxJRxeUOQsVniXYjF8eAc4
	CmVcdenC4ttC/AbZGFumTV0I13qXN1FsuXZQitrFGnFn0LQGbGW+rAc+mW7/cxBTxsnhe5+jWVn
	0Vykksttr9LjroGeno1vCtUcEXtWwLXOm28Ccr9ivtINTzDOEJfIunRfPxHJBRGHWajAYvvzNCk
	2ivm066n2UOqh2rGAS2Q1iu1tW7TOKbo4Jjs2RV2I4xq87lt3+NiohRyI3zHDVVfnesOr/6zg7e
	G2Sdtfr578piDB4W380fvNKcnYUz9M73K2nR5j/SVVta/LE/WVvxaYSVP6J+BdAKcRNHcZsz/Td
	xM1rTr0C5uBMVIupk1OJfE88zd3ZAMX6
X-Received: by 2002:a05:600c:83c5:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4ac1970b976mr357815775e9.33.1793879129751;
        Thu, 05 Nov 2026 03:45:29 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46538sm56679525e9.5.2026.11.05.03.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 03:45:29 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Thu, 05 Nov 2026 11:44:56 +0000
Subject: [PATCH v4 08/19] perf cs-etm: Use instruction length in
 disassembly script
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
Message-Id: <20261105-james-cs-unformatted-per-thread-fix-v4-8-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
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

The disassembly script adds four bytes to each branch sample's IP to
include the final instruction in the range. For an exception sample
whose IP identifies a faulting or interrupted instruction, this
incorrectly includes an instruction that did not execute.

Use the decoder-supplied insn_len to calculate the exclusive end
address. This preserves zero-length exception entries, includes executed
syscall instructions and also uses the decoded size for Thumb
instructions.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/python/arm-cs-trace-disasm.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/python/arm-cs-trace-disasm.py b/tools/perf/python/arm-cs-trace-disasm.py
index 5a7daf927bea..7cf0af5d2780 100755
--- a/tools/perf/python/arm-cs-trace-disasm.py
+++ b/tools/perf/python/arm-cs-trace-disasm.py
@@ -315,11 +315,12 @@ class TraceDisasm:
         #     [ sample_prev::addr .. sample_next::ip ]
         #
         # sample_prev::addr is stored into cpu_data and read back as
-        # 'start_addr' when the new packet arrives, and sample_next::ip + 4 is
-        # used for 'stop_addr' so objdump includes the branch instruction at
-        # sample_next::ip.
+        # 'start_addr' when the new packet arrives. Add sample_next::insn_len
+        # to sample_next::ip so objdump includes the last executed instruction.
+        # The decoder supplies a zero length for an unexecuted instruction at
+        # an exception entry, excluding it from the range.
         start_addr = self.cpu_data[str(cpu) + 'addr']
-        stop_addr  = ip + 4
+        stop_addr = ip + sample.insn_len
 
         # Record for previous sample packet
         self.cpu_data[str(cpu) + 'addr'] = addr

-- 
2.43.0

