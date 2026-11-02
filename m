Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621744;
	b=nh0JGkYpI3c3/V26B/HPCidVlbwD62l9SfQlZ9uNpNAjD+ZVSQEQ4fdsLhd37VqKzpSg
	 4Og7wAtG3qAf8fSSI3JI8/Y6uyoNKtGGV+kDzviEvfeoN0rMTMSi5lzcTlRCKYxxaB3se
	 MdrWblAttJ2O/0dZ8IIt7mUpR0T7j0ZulNv4xiat7zl49LLGlQTgZeitLXbuzmvwcjRAr
	 94QzuIIhFJsDSkwjE6lsFB8ojc4Y4JDm8rf0JUAVZmpRCyD4WsVjaysEgUhBTP7UgAjlw
	 AIAmuzpqMkexb6FOjWPBwX1VB1alHVbXn7+I1uYGLbTbSdgeiSLvxDMn9ybC/4s2ERA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=mCLnsLSirANrZFkZpSvJ6WBM/VWZNAB053qbWLRSeJQ=;
	b=kJLFf7TXPlRCJoML5O3n4dIw29mjJbOvi/VC1/UjAiUDOcOEEXg6ncQmJpPrul+pQlP2
	 VcpJCC7lqIuDR0Iy2ioyX9lXVPSngC2assP7stV6FSZ46mb0xNqCZsWlD1wVY873fWdbE
	 31JjgjCZzfTi1zSAzQRQuaxjgOQ7anJKwkYA3VBDpFr80ldjFvguc8nAmSgyiVoKLaTID
	 u5MX8ja7ZEx6Y8VStiKvrpRPZiN26RVO4LR9Gy/BeBDYktwY/WifDjwOJYwwFc4kPM9XF
	 GOrbrkhhr3/uIQR0uznf3fQojuvLcx3KXF0HNw8VxXwYVCWZ6ZdUyzClSfs7LBVRHXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SDRVsbBE;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A31606A32D
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1A31606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SDRVsbBE
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a218c463d1so19308035e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 04:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793621742; x=1794226542; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mCLnsLSirANrZFkZpSvJ6WBM/VWZNAB053qbWLRSeJQ=;
        b=SDRVsbBEba4/1xZEakpe30lqmFSdjuNmoyL+qrLSCfU7O4Pf/M6aVyKI1utHy+acrA
         QpZMnwLss1CsMghsnzYv5zcHWYIGJTjX8t6B8Sd8v08nKHnopj6eH9IqLJ888NXABly2
         y060eqPV9e39wVz1lMRKkxwWtklIHWTszG1r36BmW9OB4VOMyW5GFyGxasq7R4Bd4sr/
         Eft3Vy5CeJv29t5MBxT1taJFf8UbKyRdeeD8HpZkVRcCV7zkyb72D4s0giIZBJcevhmN
         WL/o+tASPmc41syf8aFoaqpI4/L0ZYgelmIwqi1WLlrgbJPEk/uRQFqGBeBx+ftglLiy
         TCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793621742; x=1794226542;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mCLnsLSirANrZFkZpSvJ6WBM/VWZNAB053qbWLRSeJQ=;
        b=0wUkrEO8BN8ai0qmdbVtmgn1ziGlOAskRnrplLkLo6JeeCTzLSvPZV7v1zR3v9qccB
         D6B4XHuChrLdH9HWnj79gYb2Xf1WBDsCpPEzJaDrSbvrwCUSMat0AnW0+wT3veEcylqv
         fVGxJHjo+kjfZz7dE0FkCpvZ6hUanWLdW0IeDgvnOt3cZEKGwBl/XPkM7jfmSnojQdfZ
         O6PFuGhkhEm4u/UbGzbOx1qdEpqA3LJ7KPhcqbcY1ek/7odp+teK4Gu0ILY1bl0GcJkl
         rncs4xDOVFpckLklU8mz9B2vlcqihv7A44x+nR7YiXeaEMUAO2wbTLnLbDIZcYHde9wV
         Os6A==
X-Forwarded-Encrypted: i=1; AKwUvBwslgscZ7ijfnbB4xd/U6M0o/s6CzRznnhAYpHLlKEjt26MN5kQggBgEtm4AMo4+xd3rGEEcjUzyB2XS+q0OKCN@vger.kernel.org
X-Gm-Message-State: AFq9FYI9cUcxHB3Zc1IeQqlf2uuCvhhydp985L8WTcoX92DIeZmtQQ4V
	/aUu9zLiE4n61UY05aqzk9zskAgJqqpEiwBHNrsjHcu/c0nZPorf3iYgQ2WsIu4D+dY=
X-Gm-Gg: AYBFou1GXc42ASdM6xcU/7EGZlo6TZb9M2Eb4+91recnApJcJHn76Fa6P3HoDLVyXGU
	Jt9K/6oWrNV3BvFcjrHsH4CJdV+iWFGu6vFl4p6BhbrMIElC5KJ2qUjoAU75WIrQfwNkLDDBiHH
	IXuE8n4/uIxazI+ot/BaZfBf8A57EQ62rtoCm+OlPo3fm2ryexgf2nx77pO2LwX2+08cr6phRD4
	2D85Lr6PjOYVPcTQKBB2PVjW5dLZIPIcvMh5t7lC6+gRtQy3BHVr03ElNnsVUDtBz8GLQoQtKYc
	bQpYkqT7yMnedX93dCXsEFN/fprWKtr6X+EpD3K7B4FahO87E/OBq6uLkJAeH3yCdFQB7Qz0+fV
	2xN9Z5G15f+SyaMb2A0ODGQKdw+1MA3dU7E9p+ujIcY3QoULi8Y+YE3eVlru8cxdc/RTh5YPgpe
	amFDD9KpQB1qPUZ4lH4LTkfH2OyT2PALKnR1mMD+Qp4NpVsgq5RDlIyNtz4Uu9yZ8W7FVrVDJue
	2BDFNAmI79dM1XOj9HDygbNwAUnKLpG+lZzKebumno9HWT3bvx0WLvJbobt52ZtzUP4EXMh7Pq9
	cZX6WzMdZSgDpi9UymDFoo6/hgnB61Nq
X-Received: by 2002:a05:600c:3554:b0:4a1:e7ce:107b with SMTP id 5b1f17b1804b1-4ac150b20eamr237179415e9.2.1793621742230;
        Mon, 02 Nov 2026 04:15:42 -0800 (PST)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm434974855e9.3.2026.11.02.04.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:15:41 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v3 00/18] perf cs-etm: Per-thread mode fixes and snapshot
 wrap support
Date: Mon, 02 Nov 2026 12:15:14 +0000
Message-Id: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
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
X-B4-Tracking: v=1; b=H4sIANN+6GoC/43QwW6DMAyA4VdBOc+VEwjQapr6HtOEAjhttpF0S
 Yo2VX33Gbhstx7tw/fLvolE0VESh+ImIs0uueB5KJ8KMZyNPxG4kWehUNVYo4Z3M1GCIcHV2xA
 nkzONcKEI+RzJjGDdN2ikRpXGNBZJsHSJxOu18vrG89mlHOLPGp3lst38VsqH/FkCwh51rUvZW
 m3b46fzJoZdiCexBGb1B1UPoopRxKGyIzYo++ofet/OiPR15R/l7RbBajLrjw7F81KTWOIC225
 IHeWpY7nzwXfZfJCHueRGU6t9r5XpsWqOJk67IUwvXLj/AoXO2TWNAQAA
X-Change-ID: 20260605-james-cs-unformatted-per-thread-fix-50e723aa7f0e
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

Fix a few issues with per-thread mode:
  - On nVHE, everything looks like guest trace instead of host
  - Tracing multiple threads didn't really work

After adding a tests for those, it turns out there were some snapshot
bugs not picked up by the other snapshot tests. That showed that the
different snapshot searches for Intel BTS and Arm SPE were inconsistent
and I think all tracers can benefit from using the same pointer fixup
logic, so that gets refactored into the common auxtrace.c. Then SPE can
just share the Intel BTS search as it was obviously copied from it
originally. IntelPT keeps the more advanced duplicate data search, but
in the future that could probably be made the common one and all tracers
would benefit from using it (except maybe BTS if it always has a very
small buffer, but I doubt the overhead of the duplicate search would be
an issue). For now this is more of a refactor rather than behavioral
change so don't do that yet.

Signed-off-by: James Clark <james.clark@linaro.org>
---
Changes in v3:
- Keep the find_snapshot() callback instead of adding
  snapshot_has_wrapped() and monotonic_snapshot_head boolean (Adrian)
- Add auxtrace_record__default_find_snapshot() for the simple search for
  BTS and SPE (Adrian)
- Add auxtrace_record__snapshot_fixup() for any snapshot search
  implementation to use to update the pointers (Adrian)
- Reword UINT64_MAX timestamp comment (Leo)
- Fix disassembly test after rebasing onto exception sample fixes
- Only take 'perf_guest' into account if there is no PIDFMT_CTXTID2
- Improve decoding of old files by hard coding queue 0 for per-thread
- Link to v2: https://patch.msgid.link/20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org

Changes in v2:
- Remove stale "may be reset to -1 in per-thread mode" comment
- Set CPU when queueing auxtrace fragments otherwise
  auxtrace_queues__add_event() overwrites the queue's CPU
- Link to v1: https://patch.msgid.link/20260811-james-cs-unformatted-per-thread-fix-v1-0-90565318f5f8@linaro.org

---
James Clark (18):
      perf cs-etm: Fix nVHE per-thread decoding
      perf cs-etm: Warn for invalid timestamp option
      perf cs-etm: Turn on context packet timestamps in per-thread mode
      perf cs-etm: Use per-CPU queues for per-thread mode
      perf test: cs-etm: Increase window size in disassembly test
      perf cs-etm: Don't drop previous target for kernel samples
      perf python: Expose sample instruction length
      perf cs-etm: Use instruction length in disassembly script
      perf cs-etm: Increase default timestamp generation period
      perf auxtrace: Turn Intel BTS snapshot search into a generic one
      perf arm-spe: Use generic snapshot search
      perf auxtrace: intel-pt: Use common snapshot pointer fixup
      perf cs-etm: Queue partial AUX records
      perf cs-etm: Don't print missing buffers in snapshot mode
      perf auxtrace: cs-etm: Capture wrapped snapshots
      perf test: Allow infinite named_thread loops
      perf test: cs-etm: Add test for per-thread mode
      perf test: cs-etm: Test multiple per-thread threads

 tools/perf/Documentation/perf-test.txt             |   2 +-
 tools/perf/arch/arm/util/cs-etm.c                  |  34 ++++-
 tools/perf/arch/arm64/util/arm-spe.c               | 147 +--------------------
 tools/perf/arch/x86/util/intel-bts.c               | 115 +---------------
 tools/perf/arch/x86/util/intel-pt.c                |  21 +--
 tools/perf/python/arm-cs-trace-disasm.py           |  22 +--
 tools/perf/python/perf.pyi                         |   1 +
 .../perf/tests/shell/coresight/per-thread-multi.sh |  76 +++++++++++
 tools/perf/tests/shell/coresight/per-thread.sh     |  48 +++++++
 .../perf/tests/shell/coresight/raw_dump_stress.sh  |   5 -
 .../shell/coresight/test_arm_coresight_disasm.sh   |   4 +-
 tools/perf/tests/workloads/named_threads.c         |   7 +-
 tools/perf/util/auxtrace.c                         | 145 +++++++++++++++++++-
 tools/perf/util/auxtrace.h                         |  18 +++
 tools/perf/util/cs-etm.c                           | 113 +++++++++++-----
 tools/perf/util/python.c                           |   1 +
 16 files changed, 418 insertions(+), 341 deletions(-)
---
base-commit: 790454475c15508d68ccfc4b023642305100f18f
change-id: 20260605-james-cs-unformatted-per-thread-fix-50e723aa7f0e
prerequisite-message-id: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
prerequisite-patch-id: 4ef889ad751e344ae47c1d75a2a2e6cb2eadf6e1
prerequisite-patch-id: 636b39730334cbc5a76642c070e704ffe178e7be
prerequisite-patch-id: fb58f6daebdf5a194f8aa56ccc4022f932a5a6e5
prerequisite-patch-id: d240c10c6824f8ae6c3f10a1da01226a957f05fb
prerequisite-patch-id: 17b291db261e32dcb0d6f1ab2ed0adb7e0411813
prerequisite-patch-id: 45ae1d523c9e5c8c573309f1dab107a598f3d4f8
prerequisite-patch-id: 39a3eb25b3a45f4481760c25fa270773bcfd94f5
prerequisite-patch-id: 5723a15636c2a28ec40eb6b5c9836d162e971786
prerequisite-patch-id: d18054b586fc38bc832ead185e8c1fbb0ce46f39
prerequisite-patch-id: 6735b192189d7945613458abce3da871cb79b35d
prerequisite-patch-id: 387cb2c6181bef8f45a8fb167e8ef86e4a54ff69
prerequisite-patch-id: 50243a8d1739141aa24aa371a8452d4d2d078a99
prerequisite-patch-id: 2ae6f1e7707ba0c71a0678331b02d738fb25cb3c
prerequisite-patch-id: 1fa0a90cfbc904c4429c1427409125ac44b27aed

Best regards,
--  
James Clark <james.clark@linaro.org>

