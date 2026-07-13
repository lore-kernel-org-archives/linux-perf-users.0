Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F3534CFA7;
	Mon, 13 Jul 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965644; cv=none; b=f8faJ7uuwJrh9Dd5up3kdaD6RHUdErWOL66wsXHWYELrzNd5eOrJ4RoVUhLAorUJy+nKAxpq07FWjBS6yLZ6rVpdpvdbwCWp+m3ZkFXCDHxYAlRyNiL0YEWDSDPD4rTcSi6ABfj3iDdFaFR2zTVS0qmU7EtO75740c298ovWplU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965644; c=relaxed/simple;
	bh=DQJqFZ/U3vJ2efvZuDUzj8k/llaRRz76jNOdtayJQDQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R1FfgF8Nkkz4oJsGufF1D1pCRN6B5RuiHzBEq34TVe/6rdZhuEIq+D4vkoRVPWSZct9E2NbdcIg6SeGbZIHYwkEkK6SNpuzOiRpdbEWqrgjfjNd4E1NuIWnMqzYixVl6/WJMpmj4lY3uUfU/wXNaPW3WuKGcnYhnqJRfwFWWsh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vIG8dH3d; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vIG8dH3d"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C316D1595;
	Mon, 13 Jul 2026 11:00:36 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D73043F7D8;
	Mon, 13 Jul 2026 11:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783965641; bh=DQJqFZ/U3vJ2efvZuDUzj8k/llaRRz76jNOdtayJQDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vIG8dH3dZZdgsaXNcRQTd2biODr5v44c9cAOhvAxALnK++8idBV2ZjiOfGKtsZ4R7
	 wdHBSYYLIV0ufpghkdZ84nx8mV9M4IR6HwobSLAsYVh5mfR3EEpfdw15ckSLGnwiiv
	 VMSmsyBoEsDmEDwxuxHvTq/i5SjI3vFkkMCLgAJE=
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 13 Jul 2026 19:00:27 +0100
Subject: [PATCH 1/2] perf cs-etm: Avoid bogus branch samples before async
 exceptions
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-perf_cs_etm_fix_non_taken-v1-1-4561607fc69f@arm.com>
References: <20260713-perf_cs_etm_fix_non_taken-v1-0-4561607fc69f@arm.com>
In-Reply-To: <20260713-perf_cs_etm_fix_non_taken-v1-0-4561607fc69f@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783965636; l=4148;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=DQJqFZ/U3vJ2efvZuDUzj8k/llaRRz76jNOdtayJQDQ=;
 b=Qv476C6AvXcauqu2fkvTDwGafujl2HVaDhyaw+qGl34ElQafYMC+XrSvk4YtBItFJbsCLExQW
 XiZz8ou6T+jCOQb/h7IMoXfol1ds3ueYCMEpBxoztT2u+fTuqAMqJz7
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Consider the following code:

  00000000004000f4 <test_branch>:
  4000f4:       eb02003f        cmp     x1, x2
  4000f8:       54000109        b.ls    400118 <taken_path>

  00000000004000fc <fallthrough>:
  4000fc:       d282f2c2        mov     x2, #0x1796                     // #6038
  ...

  0000000000400118 <taken_path>:
  ...

When execution reaches 0x4000f8, the b.ls condition evaluates false, and
execution falls through to 0x4000fc. If an asynchronous exception (for
example, an interrupt) is taken before the next instruction executes,
cs_etm__exception() currently forces the previous range packet's
last_instr_taken_branch flag to true - in the case above, perf
incorrectly synthesizes a branch sample for the untaken branch, even
though execution actually falls through.

The trace log contains the following bogus branch sample at 0x4000f8:

 perf script --itrace=b -F comm,ip,insn,disasm,sym

 b_ls_not_taken_            400108 fallthrough insn: 61 ff ff 54                b.ne #0x4000f4
 b_ls_not_taken_            400108 fallthrough insn: 61 ff ff 54                b.ne #0x4000f4
 b_ls_not_taken_            4000f8 test_branch insn: 09 01 00 54                b.ls #0x400118
 b_ls_not_taken_  ffff800080010c80 vectors insn: 03 00 00 14            b #0xffff800080010c8c
 b_ls_not_taken_  ffff800080010ca4 vectors insn: 41 02 00 14            b #0xffff8000800115a8

The special fixup is only needed for SVC. For SVC exception entry,
cs_etm__set_sample_flags() has already identified the previous range as
a syscall branch, but last_instr_taken_branch is not set for the SVC
instruction. Restrict to force last_instr_taken_branch to true for a
system call only.

After:

 b_ls_not_taken_            400108 fallthrough insn: 61 ff ff 54                b.ne #0x4000f4
 b_ls_not_taken_            400108 fallthrough insn: 61 ff ff 54                b.ne #0x4000f4
 b_ls_not_taken_  ffff800080010c80 vectors insn: 03 00 00 14            b #0xffff800080010c8c
 b_ls_not_taken_  ffff800080010ca4 vectors insn: 41 02 00 14            b #0xffff8000800115a8

Fixes: 7100b12cf474 ("perf cs-etm: Generate branch sample for exception packet")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 95e3ec1171acc8442d8539a72a26a1a5a53a2f37..05e698f666bbe07af9caeda1a673f22d7196817a 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1999,17 +1999,20 @@ static int cs_etm__context(struct cs_etm_queue *etmq,
 static int cs_etm__exception(struct cs_etm_traceid_queue *tidq)
 {
 	/*
-	 * When the exception packet is inserted, whether the last instruction
-	 * in previous range packet is taken branch or not, we need to force
-	 * to set 'prev_packet->last_instr_taken_branch' to true.  This ensures
-	 * to generate branch sample for the instruction range before the
-	 * exception is trapped to kernel or before the exception returning.
+	 * cs_etm__set_sample_flags() has already copied exception flags to
+	 * the previous range packet. Do not mark every exception boundary as a
+	 * taken branch: an async exception can arrive after an untaken branch,
+	 * and forcing the flag would synthesize a bogus branch sample.
 	 *
-	 * The exception packet includes the dummy address values, so don't
-	 * swap PACKET with PREV_PACKET.  This keeps PREV_PACKET to be useful
-	 * for generating instruction and branch samples.
+	 * Keep the fixup only for SVC. The decoder reports the range ending in
+	 * SVC without last_instr_taken_branch set, but perf represents SVC
+	 * exception entry as a syscall branch and needs the flag to emit that
+	 * branch sample.
 	 */
-	if (tidq->prev_packet->sample_type == CS_ETM_RANGE)
+	if (tidq->prev_packet->sample_type == CS_ETM_RANGE &&
+	    tidq->prev_packet->flags == (PERF_IP_FLAG_BRANCH |
+					 PERF_IP_FLAG_CALL |
+					 PERF_IP_FLAG_SYSCALLRET))
 		tidq->prev_packet->last_instr_taken_branch = true;
 
 	return 0;

-- 
2.34.1

