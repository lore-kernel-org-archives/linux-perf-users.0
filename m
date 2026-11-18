Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019390;
	b=o8sckJuS/RmTmBwn40dIopTx+C1w8IoNwE2MqSDvMPx5sEBr7SsNXf5uGTzzWrs5UQrT
	 e0chWaDbTjadIhk4VTRKCvO+4LMF17C6OC6W4UGZaKD2Szz6cjoSb7WKKFZ3tHnTlVNdZ
	 g5t2suUc6NBTOEDzax2ZVGvEfmVeF7TMgi61+eEjOGYlsd/nDNjPXMpCRho2u775ksJBh
	 kOtmGCtQdLq2fer4XptYsSOG2fZ80xrDTvDl828YbAB8zPEXfWoNVJh4qIMkLtYUUTXwE
	 +Q2YwISv/EantyUbvTyx5o9ITyf7mv4MVrlmRONA1Jns6bK/iePKOxSYtpMzKs1+imA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=iyz12xtbU90FsJpLymbYPQjt0B7C+A1RErrcfWx+fUo=;
	b=nUtqYLZeVjhkdPkYierzj7y/O01pWqjYEvR1S6r/chbm7NMa+6BwMF8dENl8aA7w5hb6
	 5sowpcczDfjJiQN9AMHBzfYbA/yJBFqoyqCwSDYyWqiz89KiYSbx6PIOw42FhqNcWbyVv
	 Ex0MhHU2kN+A2pVkNhqWWi3q/+80mWb31nhIbnEPhjNZzSusEOWkYKLNkZyiTqSAGK9Le
	 RCFPKg3UsObITgsgNRg6XfkDpHQcfngG++jNvP0mB4pCzSyfwefdzeytdeMxmqF8yHhmH
	 wUWbyEwo8P/y9Ge97PZyDuGcYQ/eqNWz03IRLwlgd5hig/VqKgDUC4euAge6vsDQMKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QDUAJ7wL;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D7560A2604
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96D7560A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QDUAJ7wL
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so546315f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 08:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795019388; x=1795624188; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iyz12xtbU90FsJpLymbYPQjt0B7C+A1RErrcfWx+fUo=;
        b=QDUAJ7wLTW4KcBSvxAWObf0SSkrnLIZbr6LwYdW57ldJrDoEEb7JifQeqfuz/BV+cs
         FRdB3GwpVpc7KnfWNisU1WDTAF4+6GICgJGjTqvOF9tgqIsnzP5ClXgVAbwhOevlowK/
         AHsQVDRu/h2kreP8obxIyUyQ5WJTltYFgzmgvTpMKiamgqfFRNkFrmZxSEQ/x3pBEUDT
         thFoSO0Yf+sTsL12txowHffIKc7wsgMvEn5CCXdm05Vddy4TsbwXuRR3qsjcQfewTR4J
         QJ9J47kJ2Hh2lWTw5XW4Hl0g2wFd+3CjJYOT/r/qI+oXARqToG4ej0Lp7gfJ/hSt4dpl
         vTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795019388; x=1795624188;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iyz12xtbU90FsJpLymbYPQjt0B7C+A1RErrcfWx+fUo=;
        b=B8BwtDTPnQJHcELjM8wDUBqKjOwQdSsMnu+VpUxYhkJKd08Qx5Yi+RS4G0Rx0WveYn
         jT4rZlY1MG/p5FSaD0Rxo/LB4o1evYMckeUnp3qW/dI6PExCfwy8EG4ulr68y9Y6VI0P
         uAlDWTXYs0TYoi8fEVps/mjCCdDS+5E5ZjJAtZU40nT/v77acTxrucXn1zZhIFw5tRNH
         Q3UT+pfoH740pZHY7EKtmJh4QoObH1uCcQn3zLfaf0Opeq9AEd5ZuCIer2zL0SNBqIKL
         Omu5NyCbZqmgh5Vn7Hv484RW6dLYKEfPf/IdFeLnBQSf53W9LMxg/m4aEv8XMrFeuJzC
         UfNQ==
X-Gm-Message-State: APuU4Z877I31MiK2w19hYO2Wp/tIcxo25uQ+LL/IXDQqa9XuWR0PdX5w
	EkhQakxOcqOMDJ6uCOXXg499p9/NqSGmeCaO0/Bw40CAyY4eFCV+b39H1Aep46QrD/Y=
X-Gm-Gg: AZFdTZdABNU/3sKMBSnnQHZbtTonDknFkBkgfVuU24GhyXJ/EJMiSLrd5tZRhZLvDN8
	6mVHlpeb1IbXdKp1bxBTnHS7JuMxN1g+IP1r4Z57agO15jcHon2fQE1F6ooc5cVLvnRmkQoXcr1
	Qzx8K8Og8AtybJfPiuKj/gg60Tfj+XAnXERMzI2mOsIZPTvrFZ+Nn3EQDf6r3iBVjtADDyUknp2
	fkX2ev64OH9G2yA2qRRluiERTgPmaX+pYz8/fABTIG9qETLE+42H4Bm25RLThC+MWbxwZlP22ph
	hBsPeSb5e464Nwo+vD3WDdNDPk5QK2mM5gzBWAReYrCv0QSCQvWJFJqKmNbHNkLEqJBRRWkkXAB
	tvmW73aMHLlukC3aeCPtwpc2X3Dd9bInugu2rdrx0o+kLs6lijXd50Df6Bh7HFjCCVcMawZ0ntH
	YowPL1aCuBzgqFGOPDbrZcJQjox2f/34YxzbzFckm5dwhaCtxJYWpinKUajQsfWNhy1NxZBaYfH
	WxTfmImVL4wfKDgYMtsi/yZ5hx8mWCaZDT3VZuXaOBEhmnwaWTJ5yKRxd4ELZ+yzj8Ri50dZB58
	jkOASx53pKQOoo5z1Ed9nGnC9VoKkHWB
X-Received: by 2002:a5d:5d01:0:b0:48e:720a:ccaf with SMTP id ffacd0b85a97d-4a63658254amr7372877f8f.5.1795019387957;
        Wed, 18 Nov 2026 08:29:47 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a654a8c23bsm4980927f8f.12.2026.11.18.08.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:29:47 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH 00/34] perf cs-etm: JIT decoding support
Date: Wed, 18 Nov 2026 16:29:22 +0000
Message-Id: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIAGPS/WoC/zWOQW7DIBBFr2Kx7lQDhjpYVZR7VFlgGGys2KSAo
 0pR7l6ctMsn/Xlv7ixTCpRZ39xZolvIIa4V+FvD7GTWkSC4ykyg+MCDkDCbhTLYmCiHcSowhwJ
 Coee6RU2tYvXymsiHn6f16/zivA0z2bKr/haJvreaK68Zq9Zsnrm++dxrnKP6r2XYVh/TYkohB
 1dKUKZExkHNwE0CQtcpTWhJSKlPl7CaFN9jGo97bDCZ6sfLEkrfDJ33HAftHNmDM51qUVqJnqQ
 ZPCeSXns0smXnx+MXuTt/sR4BAAA=
X-Change-ID: 20260824-james-coresight-jit-250f19309e35
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Amir Ayupov <aaupov@fb.com>, 
 Suyash Mahar <smahar@meta.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

Restructure the Coresight decoder to decode trace in order with the Perf
events. This improves decoding accuracy all workloads, but particularly
with JIT code when instructions at the same addresses are re-written.

The resulting decode loop structure is simplified to
cs_etm__insert_heap() and cs_etm__pop_heap(), which work in the same way
for all of the timeless/per-thread/per-cpu etc modes.

For every Perf event, we pop from the heap while the packet's timestamps
are before the current Perf event. When a packet is popped, the next
packet is decoded and re-inserted.

The same path works for timeless mode because we can just assign the
timestamp of the AUX record to all trace from that buffer. This also
improves timeless decoding accuracy because now we don't use the
timestamp from the very last AUX record for all samples.

In Coresight trace, timestamps come after their associated atoms and
Perf uses a single decoder for both searching forwards for a timestamp
and decoding. It does this by caching decoded packets into
packet_buffer[] and replaying them once a timestamp is received.
Unfortunately this does't work for strict ordering with Perf events
because while searching for the timestamp the decoder will decode trace
using previously seen mmap which is incorrect.

To fix this, add a "packet only" decoder for each queue. This is used
for searching for the next timestamp after a discontinuity and not for
decoding trace. Once it's found, the backend re-orders that timestamp
and the previous packet before delivering them to the frontend so that
we can be at the correct Perf event before processing context packets or
ranges. Excluding the tests, this patchset results in similar total
lines of code but if we updated OpenCSD to return timestamps and
discontinuities in the correct order, then it would be a significant
reduction in code and complexity.

This series depends on https://lore.kernel.org/linux-perf-users/20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org/

Signed-off-by: James Clark <james.clark@linaro.org>
---
James Clark (34):
      perf jit: Support JITDUMP_USE_ARCH_TIMESTAMP on arm64
      perf jit: Add name of clock in error message
      perf jit: Add address ranges to DWARF compilation units
      perf libdw: Don't look up the module by ELF address
      perf cs-etm: Use the exception level to tell kernel from user
      perf cs-etm: Don't read past the end of the map
      perf build-id: Cache the vDSO in build ID mmap mode
      perf cs-etm: arm-spe: Use arch timestamp in HW tracers
      perf cs-etm: arm-spe: Report error if default clock isn't used
      perf cs-etm: Remove old pipe mode support
      perf cs-etm: Track threads in timeless mode
      perf cs-etm: Track sched out events
      perf cs-etm: Handle PERF_RECORD_SWITCH events
      perf cs-etm: Always enable Perf event timestamps
      perf cs-etm: Use time from Perf samples
      perf cs-etm: Don't buffer non-timestamped packets
      perf cs-etm: Decode in order of Perf samples
      perf cs-etm: Don't special case per-thread mode
      perf cs-etm: Decode one packet at a time and don't estimate timestamps
      perf cs-etm: Remove the decoded packet ring buffer
      perf cs-etm: Fold packet state into the trace ID queue
      perf cs-etm: Rename trace ID queues to trace ID contexts
      perf cs-etm: Rename tidq variables to tidc
      perf cs-etm: Share the thread ctxt between frontend and backend
      perf cs-etm: Consume each OpenCSD packet immediately
      perf cs-etm: Split base and packet decoder state
      perf cs-etm: Add packet-only timestamp decoder ops
      perf cs-etm: Create timestamp decoders
      perf cs-etm: Find timestamps by searching ahead
      perf cs-etm: Invalidate OpenCSD's cache on MMAPs
      perf test cs-etm: Add a Java JIT source-line test
      perf test cs-etm: Test trace is ordered with context switch records
      perf test cs-etm: Test decoding of kernel modules
      perf test cs-etm: Add an HHVM JIT call stack test

 tools/perf/Makefile.perf                           |    4 +-
 tools/perf/arch/arm/util/cs-etm.c                  |   21 +-
 tools/perf/arch/arm64/util/arm-spe.c               |   11 +
 tools/perf/jvmti/jvmti_agent.c                     |    5 +
 tools/perf/tests/genelf.c                          |   70 +-
 .../tests/shell/coresight/context_switch_thread.sh |   20 +-
 tools/perf/tests/shell/coresight/hhvm-jit.sh       |   89 ++
 tools/perf/tests/shell/coresight/java-jit.sh       |   65 +
 tools/perf/tests/shell/coresight/kernel_module.sh  |   54 +
 tools/perf/tests/shell/coresight/lib/PerfJit.java  |   82 ++
 tools/perf/tests/shell/coresight/per-thread.sh     |   45 +-
 tools/perf/tests/workloads/jitdump.c               |    7 +-
 tools/perf/util/auxtrace.h                         |    2 +
 tools/perf/util/build-id.c                         |   12 +
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  790 ++++++----
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |   28 +-
 tools/perf/util/cs-etm.c                           | 1515 ++++++++------------
 tools/perf/util/cs-etm.h                           |   56 +-
 tools/perf/util/genelf.c                           |    2 +-
 tools/perf/util/genelf.h                           |    3 +-
 tools/perf/util/genelf_debug.c                     |   22 +-
 tools/perf/util/jitdump.c                          |    2 +-
 tools/perf/util/libdw.c                            |   16 +-
 23 files changed, 1643 insertions(+), 1278 deletions(-)
---
base-commit: b7ff10b9ddec8da75304c40fe4abf1ee4f9f0a43
change-id: 20260824-james-coresight-jit-250f19309e35
prerequisite-message-id: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
prerequisite-patch-id: 9c49b9ffb75309e9187eb2e3ef84026118fcfdb5
prerequisite-patch-id: 4ce0ba0ab1302c9043f0d0734d9cf6a35298bc47
prerequisite-patch-id: 5e69770fbaf94296da5c474ce09539a1993bc61e
prerequisite-patch-id: 41d797af2aba7e97ff4435ae2659629e026d36ec
prerequisite-patch-id: d5f67b3b704f4f4b3d9e39c4299d13a086b29363
prerequisite-patch-id: a99348cc2065af31840f652286f840f23395892f
prerequisite-patch-id: aa90408e69dedf9e68d7158f2499bd9fbc7b0b40
prerequisite-patch-id: cd31a650f8dd3e7a9795fa641eee2415b126ad29
prerequisite-patch-id: 922a7fe2937a575beb8d0e7777fd869a11023eb2
prerequisite-patch-id: b0436630e22fd92803e277cd08d782c50f135be6
prerequisite-patch-id: e136ff402ddf5121c63c1393b7fc00a826f60a69
prerequisite-patch-id: 8a2674fa45e40848742e8b8472003e2b9706211d
prerequisite-patch-id: df905386a100ac4b8b047328de08da86b3adf241
prerequisite-patch-id: 44ee88eeafd54c0148ed2332dc5e33f1ba6dfce4
prerequisite-patch-id: b9622164f99682ca6b813b9d38ced3e95170653e
prerequisite-patch-id: 2f22df1738caf5af3a631851d8a57fc3bfea7742
prerequisite-patch-id: afe679ea285ddc6cd281f697ce504b7a18888999
prerequisite-patch-id: f507254858995051e8e1b96fb9fd95506228c5e6
prerequisite-patch-id: 6fe822580ea330633f8a23260aa7b2c7de834ab3

Best regards,
--  
James Clark <james.clark@linaro.org>

