Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373220;
	b=CN//73PtoE+1395QSPySFSFLNn0HL3nK4DApJYkKEolWJ3EFc8+PS3CI8D/sAeFJVE5K
	 KvG9D1MDW3EC7GgcWe0eNpydfJ6t3ixMWK/jHTLhVODbjoy5SNdABPOHDhTIVdRtOtty3
	 1jcFlWDFvdrF41rr2hWZrg5UV1XESnp/AZmZP9fUOMx9G/POwtwTjuTpj5fYIx59sX3y3
	 xauQcRrxInNqWFwI94+x7T0k6XbGb5KRv+lTgeWdMDEi4U0pPuwd/1uDNp0xZ08+rfqcR
	 mU+O4XVb3S1rqUSSELXKzw9DAzCUweqtX0pCZbT/8ntM7Hq5fO9GCUDqw3g5IKJXZtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373220;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=1MLWFfUJ7F55h4sb4NUxEMLDS0WrEggl4s/5D7oHub4=;
	b=I84WEKjjYQMwPxbWFCjL8RmRpbK03djo3EpbkiTyme4rpH+PuSFJ+de6jvZT/hu7lfqy
	 yBHvom/Ts7MtE/v6kaboo12M2I5zOn+PRdRzbkOYWbXPzmKmgHQorEXuoTiA/jKdHyPba
	 jPKUyZ+hmSUZRNmTO5K/6xBf+pXSh14F1R2yoAPANAMEhc7KzVU1slhbHA8LXU03jANDq
	 rPiwiGzA3bg5beTnVl6J2xPjykByT/mL14OhekEWofWxRffLWbNR3JOIB5Ye2gFAXCiZX
	 /lAAhNdfj81QzIiikjIlHTMkm4J6nw1/iS3gnqMMh4lfX01voZfcrC7hH4vX84l3jrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=fzRdxyNe;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C7E60A262D;
	Fri, 30 Oct 2026 15:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5C7E60A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=fzRdxyNe
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33D571682;
	Fri, 30 Oct 2026 08:13:36 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18A3D3F59E;
	Fri, 30 Oct 2026 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793373219; bh=Ir98YJCZTEZmvWLsHi0UjK0B8K30meN/k+Jc00XpUqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fzRdxyNeV60QRhcFw8FZqGL5kGhC59QctJKcNU+GycnG/YEh6IpMA4JxqFGlmZXO6
	 BKyOAypX+Qp7dl+UoEOJW32ONwPxFI/8AhOpJJt88DVaywyv6YcH+YpHOeonovyPFW
	 smiAQq5bgS+r3VIg3P3bcPp54dZd4Kf/QV/gL9uE=
From: Leo Yan <leo.yan@arm.com>
Date: Fri, 30 Oct 2026 15:13:13 +0000
Subject: [PATCH v3 06/14] perf cs-etm: Mark branches that were not taken
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
Message-Id: <20261030-perf_cs_etm_fix_non_taken-v3-6-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793373201; l=1932;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=Ir98YJCZTEZmvWLsHi0UjK0B8K30meN/k+Jc00XpUqU=;
 b=f+qzmd9pJ3zuO8A5Cr0MGhXVst6eEd4MCmRqaQL2S+bE5H88Sv1XYgqXMQvitbl89kd0R7sEz
 O3bkIRG7AdQAaskvhiTfTRhJYcUiRnzaDM8CDXuiJ8H7U4qVlTKvdgc
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

An exception can transfer execution to the kernel after any instruction.
When this creates a trace boundary, perf may attribute the trace-end
sample to the last instruction in the range. If that instruction is an
untaken branch, reporting only its branch type can make the transfer look
like a taken branch.

Set PERF_IP_FLAG_NOT_TAKEN for branch ranges when
last_instr_taken_branch is false. This records the decoded branch
outcome independently of exception entry.

For a discontinuity without an exception element, perf script previously
reported an untaken B.LS as:

  tr end  jcc             4000f8 => 0       b.ls #0x400118
  tr strt jmp                  0 => 4000fc

With the not-taken flag set:

  tr end  jcc/not_taken/  4000f8 => 0       b.ls #0x400118
  tr strt jmp                  0 => 4000fc

Here, 4000f8 remains the last traced instruction and 4000fc is the trace
restart address. These boundary samples do not establish an IRQ entry or
an exception return; the not_taken flag records only the branch outcome.

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 9126f6327e98b67852b6a55980d67abb24de17fe..7cb9f69ead2b134b62653f133da7bdec23aaf280 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2457,6 +2457,11 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
 			packet->flags = PERF_IP_FLAG_BRANCH |
 					PERF_IP_FLAG_RETURN;
 
+		/* Report branch that is not taken */
+		if ((packet->flags & PERF_IP_FLAG_BRANCH) &&
+		    !packet->last_instr_taken_branch)
+			packet->flags |= PERF_IP_FLAG_NOT_TAKEN;
+
 		/*
 		 * Decoder might insert a discontinuity in the middle of
 		 * instruction packets, fixup prev_packet with flag

-- 
2.34.1

