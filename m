Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4298955198C;
	Wed, 23 Sep 2026 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176930; cv=none; b=PuU29hW1TeCntY1ZWcWQtwxG+nO5C+JMBX60p85qvzZ41rm9COOSrpyOrXZ0PJQ7bZzqmb7Jbl6TO9JqkLN3H4SdwLCgU8bROO241fBxe6A6K2ktvza1mMDka9LuggW1WabMBzZ79eroCT1Qt1TXHTeOlA9mODCWMlceYGiLWZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176930; c=relaxed/simple;
	bh=sDZ3zCmdsg/NDDnz3ZYjdtSiVUMhALulqSJXMlTIm4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eo5A1B2qmKQiNJDq5k9SeeGUrPa9Ytv1v4NP6JzhSoqKUfeqVNtJuczvVYnP+2SFtn1Am8a6kQyuDoyq9Z/bF4XF5EiYlsm/pzPaOne0Skqoi5u0TkuWKSdgeFfTmbSxuqaGCMPioiM8e/OmN600+dPF+mCJgclrNaZAqrAfD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lo/9NyxK; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lo/9NyxK"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B0FD1CE0;
	Wed, 23 Sep 2026 08:22:05 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FE953F86F;
	Wed, 23 Sep 2026 08:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790176928; bh=sDZ3zCmdsg/NDDnz3ZYjdtSiVUMhALulqSJXMlTIm4k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lo/9NyxKyHnGlMV3zrAqgx2HIQcW8WAKeqNcS3QPYlRNALJ5SC7hfrg8NDvGn2sle
	 mFYzLSScIAjANPdgcjaCSeTonMNB3NsFTDk2kSWHmCJng98fWbjesJOuy0jfFcfcdx
	 5aAe/3lPNnWQQlP4JksM1gK7iEutmDNF4DVKlZ/Y=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 23 Sep 2026 16:21:45 +0100
Subject: [PATCH v2 05/14] perf cs-etm: Use the recorded instruction size
 for A32 and A64
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-perf_cs_etm_fix_non_taken-v2-5-6ab8c07a5455@arm.com>
References: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
In-Reply-To: <20260923-perf_cs_etm_fix_non_taken-v2-0-6ab8c07a5455@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790176913; l=1132;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=sDZ3zCmdsg/NDDnz3ZYjdtSiVUMhALulqSJXMlTIm4k=;
 b=aXxBtmOiw7igZ8rNNHw3nOoekoZ794ac+lyLnnnKlVfrKJwvH3th/RqpxkBY1MLhOgPY3npEe
 pU6YBbVUmJ6Bb43A1u2myH1E8pUGLyJmTDmMyx6AHAprPbzTrYvpmX+
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Use packet->last_instr_size in cs_etm__instr_size() instead of a
hard-coded value, allowing the decoder to supply the instruction size.

Keep per-address decoding for T32. A range can mix 16-bit and 32-bit
instructions, so last_instr_size describes only the final instruction
and cannot determine the size at an arbitrary address in the range.

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 2d1ab34f7b6b5a6331005c16c6a418d123c815eb..0163d93ac2d537a2190536e77d24628b4d707751 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1358,8 +1358,7 @@ static inline int cs_etm__instr_size(struct cs_etm_queue *etmq,
 	if (packet->isa == CS_ETM_ISA_T32)
 		return cs_etm__t32_instr_size(etmq, tidq, packet, addr);
 
-	/* Otherwise, 4-byte instruction size for A32/A64 */
-	return 4;
+	return packet->last_instr_size;
 }
 
 static inline u64 cs_etm__first_executed_instr(struct cs_etm_packet *packet)

-- 
2.34.1

