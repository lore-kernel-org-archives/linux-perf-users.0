Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F0343DA3A
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 11:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939064; cv=none; b=Zg2FtQn5u3h7O0NHN6N4VKwzR3l2f6EMA/BrQAEvbKGz6dcZ2k2oeEFxlBBeZv3cVGy8YnwgjP9ZXav76bUGiOy/NFvwfrffERrTydPNFTFwExmc9S5k6PkvHUbRIBAkhUvFODpba/gwNVCG3UMeRDNcYVIFIk/DFpVKCj5IvIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939064; c=relaxed/simple;
	bh=mLgYdA8LNeIVBIhVKv4DKZ5z4KQrG5eRjIhue9LVJ4M=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eh2e6bWv3QImyjO+V0BGoptI1GM/r9LThApMBBunuz1IyIIULkG80Y1JBN5sBlcOQgCm26fUsEJqqozc5Yr/1Dx4Cpld4f0WkTqaDkSDr4vo0Hihh+wSp6UlAuNoQczV9TMia1RQSuJpXuBIK7b9rf0D9rwg7nyFsSdysekj+EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JeFzUXqt; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JeFzUXqt"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3920so56865065e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 04:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790939060; x=1791543860; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4HWvBIY2tEG2DSLTqqgJSdpMrQ0RYX+Wo9cgrgvmKcM=;
        b=JeFzUXqtOyKA47TvK7V3k3GlrTM2x8HM17YrUPreJT2NbBME61ZWFSRSKyNrnvIeAg
         8y3S/bklomnBHXjaioSes2QuPtpnjxyhSpDYVIly7/mW2TfJfuvQXTe/DPlXJCrnz856
         /wL0LITPjKu3VFRByDymv541nxECW6vG/vjPfW5JjYR+RJoOwvrkzVX+ePqt3MbSIdPm
         Z5xf6nn14EYzDWNmSL66o6mLJGnDLk4cR6+i4L+zfbs+/jqjWHBT2olg9QOxNBHIYVSK
         gdMzJXUUGeqsWsRBdbVbhU+pgJM/lUpZOkkewtO3ajCiLOD6NA2iI7boqWhj9xIK6DP7
         0LSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790939060; x=1791543860;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4HWvBIY2tEG2DSLTqqgJSdpMrQ0RYX+Wo9cgrgvmKcM=;
        b=hQCZscS6f8+OzpnUHuupGB5pNXJndNA1dPPu/4E83cOkOKBNMo3CFpiOFMQ3A87/n7
         6Su7OMhmEKOJXziRwOSiRQ0s6R0+D++uRWFSTtyabMPDoGlDj0jHJxdsrcm87e9suhnw
         FmR0vLXO/kHFLO1jKPTwo/VrDaXcuC7G979QEBnsRkLHm8nh/h/HPXqnWuN4mSBOHp26
         pTUX4CaRUFX076fSgN+9kEC2MZZ2qBE0zXgupLrDq5khZCLs94Mi5FUs5lGVlZmuoH69
         ft0T/bBweaK9w5056vNB4c0Px+BSZEPIVJ4z8W6XjMncmB6c2n6W48IuUJv9Uyy/oy90
         OMnw==
X-Forwarded-Encrypted: i=1; AKwUvByhd2sEeaacCMDLzzRdQTeKY1IXcRqbjkp6g9IXUZgfVN5E0puwKhC/FAf3Rv2KZs2DDHMDpx00z9iKS/SUeftk@vger.kernel.org
X-Gm-Message-State: AFuF++mQfBKWWBkE96NgpHe9hAmU4HQEIz0YWGmXC+mcftO23h7aMHPm
	esUJKLu0tmFCG6Tu5AXnv2kFeKR/ovP+45evlDDW/diBFkdJVxE5wbdDKhjGhp/t/9A=
X-Gm-Gg: AYBFou2QDeHZa7oSKIRP2R10Gf86v05+SBGq+Sfu2QtmbGBH/uWug/Cqzs+VdLEGYd4
	EJFzHAD8TdenqLFhJzZ9I3uO62N/1xqESv6B1z1IgfmC7sgKbQMkagptfQHBeuwJs4XAq9yEumq
	kC0YObH+MaD3+3/VSYma8hc1443Lam0eZ1holIayphYVhRDOrntuNwyVbffqrDBgx/MANV6u56i
	Y5/0boTB/XjTsPDQKIyCay2DbFmplqfjI4LB/EIPmybyAvpkxn+x81mW3N1s0eabO/fj+JVN+Xv
	BvgyHJUP21HP3hcsPJj6yUwfewB2oOIJRqc/BbFUOrGoPhPBLCTrKjBGT+sT6dzVWkekPH6gTPM
	7nuRJcaAF8mf0kXG+8JsYafE8Rdpijzc/jQvzHM87Rd7LGglHEPk+vbt8jq5/FHmKJnXTTTmIA2
	HWzwPG+OfOwRi0njQErQ0uE0D0nCl/0Nr1UBs8ZNwDEWhTw2YS7rt84Mw/nf3ROtF0U3p+VneDw
	w==
X-Received: by 2002:a05:600c:4e48:b0:4a0:561:d0fa with SMTP id 5b1f17b1804b1-4a02769cf5amr46752105e9.18.1790939059584;
        Fri, 02 Oct 2026 04:04:19 -0700 (PDT)
Received: from pop-os.local ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280c6597sm75669465e9.9.2026.10.02.04.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 04:04:19 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Subject: [PATCH v2 0/4] perf: cs-etm: HW_ID improvements
Date: Fri, 02 Oct 2026 12:03:52 +0100
Message-Id: <20261002-james-cs-hw_id-output-failure-v2-0-7a194aa61173@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJmPv2oC/4WQS26EMBBEr4K8Tke2+RhY5R7RKGrs9uBowMQ2J
 NGIu8cwi1lm+WpRr7rvLFJwFFlf3FmgzUXn5wzypWB6xPlK4ExmJrlsuOINfOJEEXSE8fvDGfB
 rWtYEFt1tDQTC8MbwSpLtGpY7lkDW/Zz975cHB/pasyY9wqclSw9Hw+unY52tDxOmRAYWCpDGQ
 GggV0LNSckSUVlO/SYP2YCRQPtpcqkvVCuqVre17BSXlbWkUPEO9aC0rqzuuJJKCNWwY9boYvL
 h9/zCJs5d55hWin8O3gRw6ExdSmNw0Lp8u7kZg3/14cou+77/AXxPQ4xiAQAA
X-Change-ID: 20260706-james-cs-hw_id-output-failure-1d06d042ef96
To: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 Mike Leach <mike.leach@arm.com>, Leo Yan <leo.yan@linux.dev>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, 
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.15.2

The driver might not always be able to write HW_IDs, but we don't need
them for unformatted mode anyway, so fix that in commit ("perf cs-etm:
Synthesize missing HW_ID mappings for raw trace").

Include some other minor improvements encountered on the way to appease
Sashiko, like properly freeing queues and ("perf: cs-etm: Respect
--no-itrace option") makes debugging broken Coresight perf.data files
easier.

Signed-off-by: James Clark <james.clark@linaro.org>
---
Changes in v2:
- Drop driver changes and move to https://lore.kernel.org/linux-perf-users/20261001-james-cs-retry-hw_id-v1-0-4d45ab46cde7@linaro.org/T/#t
- Don't process any HW_IDs for unformatted queues, just create decoders
  unconditionally with trace ID 1.
- Use zfree() instead of etmq->decoder = NULL
- Remove dependency on "[PATCH v2 00/14] perf cs-etm: Per-thread mode
  fixes and snapshot wrap support", it wasn't functionally dependant,
  just touching some of the same lines.
- Link to v1: https://patch.msgid.link/20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org

---
James Clark (3):
      perf: cs-etm: Don't add global v0 HW_IDs to unformatted queues
      perf cs-etm: Free partially created queues
      perf: cs-etm: Respect --no-itrace option

Leo Yan (1):
      perf cs-etm: Synthesize missing HW_ID mappings for raw trace

 tools/perf/util/auxtrace.c                      |   2 +-
 tools/perf/util/auxtrace.h                      |   1 +
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  12 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |   2 +-
 tools/perf/util/cs-etm.c                        | 184 +++++++++++++++---------
 5 files changed, 123 insertions(+), 78 deletions(-)
---
base-commit: 78148c85297024ffe7a709acb7cc4fc907271176
change-id: 20260706-james-cs-hw_id-output-failure-1d06d042ef96
prerequisite-change-id: 20260605-james-cs-unformatted-per-thread-fix-50e723aa7f0e:v2
prerequisite-patch-id: 1aa32269a3a7dc76840dd8a24cb5a8715507e898
prerequisite-patch-id: ef471f468351462f67efa58a09a3461306ac5a0a
prerequisite-patch-id: c78946cf4ec1c7722570865403a3562625bdaa33
prerequisite-patch-id: 0b953eee0252db3c7ba3ef1e3397048a94482ca2
prerequisite-patch-id: 27da72c2f01bcc68205bbcc14d5019369c02cb83
prerequisite-patch-id: 365c6d5f71c754e4c690b5ebed3453565bb5b809
prerequisite-patch-id: 64e9419a41082a2db3daf255baf0fb40efbae5dd
prerequisite-patch-id: 1dc2e6ef8e76b369736b4c88560302861b2e4faf
prerequisite-patch-id: b7de38ec4d90f5b45d56390a4e5919a1d6439951
prerequisite-patch-id: 3548d5b161cfb8c11a166ca2b3228ca4821f1ca0
prerequisite-patch-id: 97e66600218a2b32e5b21d0abcb6321590f98de9
prerequisite-patch-id: 292282b20bd8ad7d096ee7ffbc55dcfb75455f53
prerequisite-patch-id: c80259b47850ba65c985c85a29c8cf4948463d59

Best regards,
--  
James Clark <james.clark@linaro.org>

