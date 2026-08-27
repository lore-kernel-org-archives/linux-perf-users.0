Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A230347F791
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Aug 2026 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787844269; cv=none; b=LDQXg3SFS4v9pMqetHEFUh03E5vjjSpPRxQAdkgH+XBCiWNepF1ZlgtB0R09SKG7SaBeKfk1hAbHZ7nqcm4zyyZXmZ3c4C0fzeMTjV4mJdShaHXjeTk9StBUrmwAi03lzUjsZcMdg3x48sgfd6UlVBaQSomqVdP1bi7iA2uaz+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787844269; c=relaxed/simple;
	bh=gPPDBVz7emEv719U/1T+Q5qL4mRlgYE+mty6MZDOCpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ud/gByCfT2KgRbHBocsq858N68apfbXzGmVVRnzIiO54GBhMtAtPfEi1LdAw3R3IEpTvyd0Mn5qOiJgRb1odJjM0ICLbcysf4bFLBGtM6RMqcaoHziRQYmwd4KJHrLniJAPq6qc4xbsoD41I+ZQKh9PUd2nQRAKzaP91Vp/vlSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTX+DLHO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTX+DLHO"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-482dd6ee390so2277089f8f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Aug 2026 08:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787844266; x=1788449066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1DILcxOjqLfpxM3Ar5Lvo++XnVhWWEcd9Lq8Wh426u8=;
        b=mTX+DLHORA2LEyXjrThUXmnmBjwSn5QEYsOiPzmVoLy0ghQlCAVxoWJar36QfyWpsG
         W+8SPkcP1rxZnauGmUPOnBcgeBA5b3Mvyo86Vximv4Qp9DdpxWNzjfa8uD1kfCH1Al8w
         4tCEFQdgbs4Gou8G09QrMld4Pfdme8A52r9tfsAVfpktvOL3rXUJwuiKpKi+Pvhq45lm
         9saQ2tJpuhAh4xDtI1N2tvvuLdsy20ksGj6ShhKReyrY+iTGW3HEtnf/VuHoYNBJVC4b
         2y9aH9rHMFlSYVpV7w29gz6WH6zCEaVMQF6jHRw8VQ6VfLJD30ZgPJVmbpHEpLPYPTzV
         dPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787844266; x=1788449066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1DILcxOjqLfpxM3Ar5Lvo++XnVhWWEcd9Lq8Wh426u8=;
        b=Uu8cIvanw5rus2Gc/mz+Zz29jpP7S5OA2eJ8t+cfnTXzSU5Sc2lh3adq7i6eHPi9+j
         wvYjdPDgOcXsCWs59Pud5+FkUwwQ6wOizPdAcc+Y/QQyqNjUSSyTDqABs7DtypsPGtEl
         x+kWDYWabaV8TbNEdhwlH5BRznfjYhXA0adPoOzKNokW9Gdj8lqNMPAK0FdYgLwwApON
         raX8eb+Y9Xs25ugWENnvyfUHxg4WOKFLpu3ewFVDXblkL1lWG+KrRf4lmeGi18Q4H0AR
         I4tR3iuqsysfLDLjl2BlvtbSLjUB5zjcRZT9VtLW9IWe5ckmvfUf4Xz1AM2sXzXJquKI
         3zvQ==
X-Gm-Message-State: AFuF++mCi/slF2Va8REUeP6Rvgg+qR7UnPQCpV+osueLIDjotdBJzJLI
	APbZI3p4H6KaZ2Y8sZyDqO4YiZ4k/QtOsaeHxy8qMsVRfgogiN3cqYxr
X-Gm-Gg: AR+sD11NeLh2R+/YR15vzuaOpjjkO5MngIRiC82VhSK95sTmKDQOfTm0UFGny7VwjC0
	UxXdRci8YAa+C0QXNSfW3HuhwpCUDKqwBCvknHPVIEpLEL4+WuKoZqzayhhpqUHs2Y/xojcX1Yr
	KSYlOMpdX4hLVjfg7qF+AO14hRZtWpDO8DCzWwMxcIKXP49Hc9cPSPH5cAcvsjRRjpR5d3pGOYL
	Ejh6uEEiPGyuGVIBasCAhTATTw/UvghaQmt8j54X9YQ5Qk9ehcW+x19y4V4y8pEBMXbSFpYZDnq
	bnHtuAnfHUvnhUDI8DmK1EfjU5Hd8pPVIVq44e0j3emKxDoFWXMbVCDUgHvUs7SMYC6NdHDRZH8
	E2jXF1Xexki+sPAfzY84WD5GJ+RJ7UB7okZUtjJxGEY57xumat0U2QndTxdG4ELQgC6rSpUc/4P
	3FvriItBL9PM2Si4hrAP0HCMV0GhJB177zFgOjYvYlC4LUMvjnBOnBsIsv0sZpaZxjqbnrto7fl
	x8KJ6PFpJuC2A5qgXSbEuo=
X-Received: by 2002:a05:6000:653:b0:481:5167:d526 with SMTP id ffacd0b85a97d-482e269d904mr19918299f8f.6.1787844264757;
        Thu, 27 Aug 2026 08:24:24 -0700 (PDT)
Received: from amwld-tmagires1.us.drwholdings.com ([149.14.21.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e27ab1f3sm10257371f8f.11.2026.08.27.08.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 08:24:23 -0700 (PDT)
From: Tudor-Stefan Magirescu <tudor.magirescu@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.magirescu@gmail.com
Subject: [RFC PATCH v2 0/1] perf scripts flamegraph: Add --asm option
Date: Thu, 27 Aug 2026 17:23:53 +0200
Message-ID: <20260827152354.1513813-1-tudor.magirescu@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821090555.1B6DC1F000E9@smtp.kernel.org>
References: <20260821090555.1B6DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flame graphs report samples at function granularity, so a wide frame shows
which function is hot but not which part of it. Obtaining that requires
perf annotate, which reports per-instruction counts without the calling
context of a flame graph. This adds an --asm option that appends the
sampled instruction as a leaf node, so both views are available at once.

While testing locally on x86_64 I noticed that when recording using
--call-graph fp and :p event modifiers, the top stack frame of the
callchain and the sample information don't agree. In my case, it appears
that the callchain's ip is exactly one instruction after the sample's ip.
perf annotate seems to ignore the callchain information and only uses the
sample ip to record the distributions, which I replicated in the script,
so that both tools attribute a sample to the same instruction.

This approach has 2 problems:

1) (Occurs only when recording with --call-graph fp and :p) The sample and
top of callchain might not refer to the same function, which means that
some instructions might be misattributed to a wrong call stack. Is a fixup
wanted here, and if so should it live in this script or where the
callchain is built?

2) A binary object might contain 2 or more symbols with the same name but
different code (e.g., when defining 2 static functions with the same name
in different translation units). In this case, the approach cannot
disambiguate between them, so instructions might get misattributed. Would
exporting the symbol start and end for the sample, as already present for
callchain entries, be acceptable? This would also remove the objdump -t
call entirely.

Changes since V1:
- Warn to stderr and disable annotations if objdump is not found at startup.
- Resolve DSOs through perf's build-id cache rather than raw DSO path.
- Try debug before elf in the build-id cache to support stripped binaries.

Tudor-Stefan Magirescu (1):
  perf scripts flamegraph: Add --asm option

 tools/perf/scripts/python/flamegraph.py | 161 ++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

-- 
2.43.0

