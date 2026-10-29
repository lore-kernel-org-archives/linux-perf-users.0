Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.166
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793265514;
	b=SnuRoZokXUqsNiqJlDq54Os961YVKl4a3OMQkz0VtPAvyWImnPFf+qHTvwDKkx7sUkrg
	 FEJqY2WHblKldGvtVQ7qxOpZKAfotxUKaQuLTps9Y6uP/fDUFKCMtReWrOW4ipVEA0ZOY
	 1l+g9no9JCt01p/bI8f6mPU/ggSrpWiF3ha+rZ22T3jG4HkdCUcjo7Q3ZqDdjnw1gpxrB
	 sErJogiZJkCWSbH61uJmySU3AvhUbg7tPoYX3epD+u2Q8FfSaMQqSptS48eqwxeEatppy
	 RFnDlUKZCtrvyYzmUzJsdtw0Bz2qyX7PN9sBixvmj/RQG0bKyRssxqCIoApK86/f9Kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793265514;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=UUMdZ3ie3jcl+J5Wy3XGELZjy7F67Xdh83pBlOCHFc8=;
	b=zWSAAiEhTm4kbIzyBpB8JPwjkGQwZYvM5f1N/ILMi2twtaSy1Ow4X0UmeurTGqSmTJru
	 6dn13bKPPwAC3drxd2jmnBVyosx6qnTrML2Hco4wkUiwy6h+Oyq4y4GM8Y6dKqaBrc9++
	 kFAnpa1O2vDKiEb0AfQXh/UtwV9YdNUzk0fVc9E1Ak/UyAYDhGCapbQ4pN0py6Q17lKgo
	 9e67VoIYdrcm0Su/IjhOfrhkclljBRSCP3XK3YGtNuSP8l/iaV68FBGpljGGPT7lOGEQQ
	 Bb6QrGPqaFE5GX3oytFlm1GzmSuVcZN03cM8HVmN3iJyXI46gkyJc3enUI2Vp0zptAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outer-limits.org;
	spf=pass smtp.mailfrom=outer-limits.org;
	dkim=pass header.d=outer-limits.org header.i=@outer-limits.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=R2QaMxkB;
	dkim=pass header.d=outer-limits.org header.i=@outer-limits.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=B98FBW9b;
	arc=fail smtp.remote-ip=81.169.146.166
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6914A606A326;
	Thu, 29 Oct 2026 09:18:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6914A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outer-limits.org header.i=@outer-limits.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=R2QaMxkB;
	dkim=pass header.d=outer-limits.org header.i=@outer-limits.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=B98FBW9b
ARC-Seal: i=1; a=rsa-sha256; t=1793265498; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pKRAs49xWHKCr6jPSeuSpIPuNRJGxLUu2+eZ5F/EeJs04oMU4XNpWxQ+3mju83dsru
    V8tdUyU4QMw8fUiOxMFYD3uk0Bir3bqu8MH/WzYxZGCtIjUt+3pgBDSPrmGhkwkR/Lmv
    cLfqFjXOo/RnzqGXx7H61tm/gBTGzOTTl1AVFZ+H0tMF/wnemZHLaORmVho67wUtZsW6
    C2VjoPylbuRDCv/6rolyNkxtBtDNpz1+MGdU9u6NvBlIPYOmKW3WG+BiXjtvwgJml/CZ
    lsa/w2hdD/NeSWiofcAQ6xCdLqEYwTZfN74ll1BiWbf2CqZ9ZQDglQRU3Na8zvepIfLy
    JUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793265498;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=UUMdZ3ie3jcl+J5Wy3XGELZjy7F67Xdh83pBlOCHFc8=;
    b=m0Y2kghUUTUcUwcPUwzLrK6K1sJA7a73vg6GtaQq70PlOcjn3aO1Fjb5Ihjc1IXzAN
    dgerUU0fwy7UGDQQgHPdFAUAsrKNdHh/gFtr4vvhGFInQDXwOJ6OZJIeV1eiUCVSSYh0
    jZF6OB+FUDnkY2apiv6tI4nxfLDByJUk9myqBL6OmURqDvWTF2Hhtm55w259CnCmuekf
    FM/X6U3IC01FLw7/k5x/pj/stlAVpy8F6moQn22KNmN0HkUc9OPHe5E+VNJEmT4JsiOu
    OacLHdvo2YjUhzZhlp4Cn8GimGHJmQ1GBV4BzxbOvyfzaoKnD0ztcxdYnzcU3MiyFMtO
    b7sw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793265498;
    s=strato-dkim-0002; d=outer-limits.org;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=UUMdZ3ie3jcl+J5Wy3XGELZjy7F67Xdh83pBlOCHFc8=;
    b=R2QaMxkB1l2N4WnpCeQhMuLl+1jSMcXeWhDG1i9ufk/DHJi47MDSRHWEjOCIH3ObSi
    3/en8Z5eS3ZI3GFbBVmdOf1ocnV7dPDLz2mHi2Dt8r2vPeq01mtKbx56xNPfQYUAHOX5
    9/UeUN5TjlObFlpekHmz+rkyIKn8WshMTtS+qZ9DS9b53sLnwFKctMEoV71UMJ3CjAFH
    cdVZjXFXJuPB35B2d2fhTg0OcNj8l1dMzPUKFK43kzd+1v56vxS7oaHmbaPZypN4secG
    kLEEciABSz7osnN2sGSnH22+E8SgSecxmD9OridAuXGGmFm8e0T9KS2mVgd2EMGjcsTF
    D8Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793265498;
    s=strato-dkim-0003; d=outer-limits.org;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=UUMdZ3ie3jcl+J5Wy3XGELZjy7F67Xdh83pBlOCHFc8=;
    b=B98FBW9brfrZby+WrOusqmcTbr+sq1jZEXsK1z9BHwhxt1WaZ6Xg4QuEv+qocJcRvM
    KJsQ7wuxOGZPWgw6CdCQ==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBFXdk1Z5IDmIqDY7xpnOs6mGD64frXxHtrE3e66udIGwZnWwLgga9o="
Received: from julian.home
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id J82cde29T9IHvXL
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 29 Oct 2026 10:18:17 +0100 (CET)
From: Julian Vetter <julian@outer-limits.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Vetter <julian@outer-limits.org>
Subject: [PATCH v2 0/2] Remove remaining __get_unaligned_cpu32
Date: Thu, 29 Oct 2026 10:17:34 +0100
Message-ID: <20261029091736.28742-1-julian@outer-limits.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

This is the remainder of my series removing the deprecated
__get_unaligned_cpuX() helpers. Patch 1/5 of the previous version was
already applied as commit 50b4233a22b1 ("include/linux/jhash.h: replace
__get_unaligned_cpu32 in jhash function"), so this version only contains
the remaining patches, rebased onto current master.

There are no users of the helpers left in the tree, so patch 1 removes
include/linux/unaligned/packed_struct.h. Patch 2 does the same for the
tools copy.

Signed-off-by: Julian Vetter <julian@outer-limits.org>
---
Changes in v2:
- Drop patch 1/5 -> already applied
- Squash the three tools patches (3/5, 4/5, 5/5) into one
- Include linux/kernel.h explicitly. It was previously pulled in through
  packed_struct.h
- Also drop the "#pragma GCC diagnostic" in check-headers.sh. The
  pragmas were removed in commit 10a62a0611f5 ("tools headers: Remove
  unneeded ignoring of warnings in unaligned.h")

v1 (RESEND): https://lore.kernel.org/lkml/20250707122500.724699-1-julian@outer-limits.org/
---
Julian Vetter (2):
  include/linux/unaligned.h: remove deprecated __get_unaligned_cpuX()
    helpers
  tools/include/linux/jhash.h: replace __get_unaligned_cpu32 in jhash
    function

 include/linux/unaligned.h                     |  1 -
 include/linux/unaligned/packed_struct.h       | 46 ------------------
 tools/include/linux/jhash.h                   |  9 ++--
 tools/include/linux/unaligned/packed_struct.h | 47 -------------------
 tools/perf/check-headers.sh                   |  2 +-
 5 files changed, 6 insertions(+), 99 deletions(-)
 delete mode 100644 include/linux/unaligned/packed_struct.h
 delete mode 100644 tools/include/linux/unaligned/packed_struct.h


base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.53.0

