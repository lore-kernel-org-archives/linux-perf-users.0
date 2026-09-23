Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20E4579834;
	Wed, 23 Sep 2026 15:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176933; cv=none; b=G1tWPmsVpWir0eC01ahQa7fs8vyrx9CyJK2dzdI+7UUqDQsyNxWqHkMXN40Z2BIC0ohT2/NLfnUeaMRIFGYNfXbnw8Va97WnsfR3f26ZG1GyCy9dKw50oKG4bp34LBunhItb+G17aRnbzJwQnmeHSCvH5qiA4qBtssFUsN+Rdfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176933; c=relaxed/simple;
	bh=SnVKOKvRTdz5QhlRrwDJN/1IPX5DokfIgkiOL4pojQY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J3qPEJgSMEQo/KyvVwa6enzpTo0n5CWD9ZJkzn9M/WbLzdb1nxsItXOTJ3TTBomUeaMxjLQ/SCfeDXJEI5k6KqPwfmQArAFRtySKzB8Pof5BpSYBzxuoIPZNkPesdAvE4zBVFQYzOj1mcGDeVld4LQXtycwHceOKTQn3REwbGmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=H/vxQG0O; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="H/vxQG0O"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9321B1CE2;
	Wed, 23 Sep 2026 08:22:07 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D99793F86F;
	Wed, 23 Sep 2026 08:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790176931; bh=SnVKOKvRTdz5QhlRrwDJN/1IPX5DokfIgkiOL4pojQY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H/vxQG0ONNOz61LdE1YH0bQ8RYYezfLsQZhTuSf1Bdq5/MgX8LMyp6YxmZMMYzYo6
	 47g7jV1Tfb4fPu5bmH1lRiAYKz071imoljTCA1IZK5XcXMC19P19307zrko2phXdzn
	 OHHYZhytjS5VNorhgiIgdv1f0hXkj1cBydqKofYk=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 23 Sep 2026 16:21:46 +0100
Subject: [PATCH v2 06/14] perf cs-etm: Mark branches that were not taken
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-perf_cs_etm_fix_non_taken-v2-6-6ab8c07a5455@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790176913; l=1907;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=SnVKOKvRTdz5QhlRrwDJN/1IPX5DokfIgkiOL4pojQY=;
 b=1yzQkRkAzFWtYer8yI+mq4vpBJ3bRr3SIBqwniIx2H8n/EskoPkDm6Ytax33rd2/0T4faCcus
 O9+tsnsiezNCadzV71HTR0n5jpz3+c/iAYu9EnjDYCkpj9hlGBZivkA
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

Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/cs-etm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0163d93ac2d537a2190536e77d24628b4d707751..c54218aeef53e8420447e9a2bee6e98d8225e335 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -2415,6 +2415,11 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq,
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

