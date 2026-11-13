Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567304;
	b=gH56ImbMyaJFGie2Zjs/7Lhzs6JMBgaXd+3EkVmyrowlJF0VoZ8rhxlA1MwJIL9IObKZ
	 4dS2y/oXL8IecKODgwWW1LVIzEVBmN/JdfHpXhQ0wgfuBreCqlmT/agegYBF2u4R7lxlY
	 Ue/PHBqvA3+43rV9I+PLSYwYcNV/RsTtADPuiZeQDxFLwYQrQGinNFc8LP4EJbITy0pKV
	 8WPCXPW06nKrX/2lSVC9ssVba6tcsmpSJbI5gJMiMLf58K9buKE1r77kEbwXcl3fkeWHo
	 WBob2CeqSakoTh8lG/Vmi26deXP7YqRidIjJe5dvxD1OW3zwNWVYdN8uOFKH17h7VKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567304;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=0Xoy/+JkhOVy2zZs+D9jW0FH/gOoj/AzGHpxhSOnZug=;
	b=FhUFmkqAzEXeUtjGvIr4HmNKX0wOOe4CjW0fIJ1Xas4EkZ9ha0s9QoWf0iCC3BmeVwAA
	 iUVcV7rpeff5z1Br8wkBCqywBS3Ji4sEHcLb/WcDL/H5k0rwUWYT6a2LTIUqAZKXb4502
	 p+c05M4eTGG5tWaUVq0yZznjIYW/tp+n29A1YdfHkzJhHGiCYKMZExS7BLUm06FNcnN1I
	 TX+cvAXRiiTrQTJuq/HPdr6ZPa17IKW37DarRh3xzR5R7Jz6LNVnVqEHSuXkVdkmWH7NU
	 /igTtM2pVDoaYoade5bOGkSPdyaUgzQ0J+H3hJvuqm+qhZwaMhknjPVW3b8J1bmGl5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NxGoUR8C;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0D0606B25A;
	Fri, 13 Nov 2026 10:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C0D0606B25A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NxGoUR8C
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F7681AED;
	Fri, 13 Nov 2026 02:55:00 -0800 (PST)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E53863F673;
	Fri, 13 Nov 2026 02:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794567303; bh=7GXvv174N+KlDiwy/lVoFVjQ8KSC6/JT940zg1WRQlA=;
	h=From:Subject:Date:To:Cc:From;
	b=NxGoUR8CRNO5Ua1FLCH/1EWsTUJaVPRzNnls7Ex1WmUbH60nflWMtCGvBWPMrPKKy
	 zKmUQPkMRIQWP/zpy7U5fVLLPVFFrCH5YXQgUNUNypvJcfBWlLo7b94NqOXT0xgD78
	 R7+RQbSFSruF48C4ICk9RD0lnltK9fCn4DyDqEMQ=
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH 0/3] perf cs-etm: Fix GCC 15 build failure
Date: Fri, 13 Nov 2026 10:54:51 +0000
Message-Id: <20261113-perf_fix_gcc15_failure-v1-0-eae592c5ff64@arm.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHvs9moC/x2MUQqEMBDFriLzvQWnRRGvsixF66sOiMqUFUF6d
 4ufgSQ3JaggUV/dpDglyb4V4E9FYRm2GUamwmRr2zKzMwc0+iiXn0PgxsdB1r/CMBxb50Z0taU
 SH4oivePvL+cH3zaWDmgAAAA=
X-Change-ID: 20261113-perf_fix_gcc15_failure-1e31233be802
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, James Clark <james.clark@linaro.org>, 
 Mike Leach <mike.leach@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Robert Walker <robert.walker@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794567301; l=951;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=7GXvv174N+KlDiwy/lVoFVjQ8KSC6/JT940zg1WRQlA=;
 b=dtRlrnLklDGuAhcLzDRmbJ0gy2YDYiFMthhgs9oxG/teWg6IiuSw9z/2GdTSzlcXqewr88LKC
 B3F5bFKWu+2CWJunZveop7XTidTy8NGIlaoa1kMkVVLJtHzXyNzr9cL
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

This series fixes the GCC 15 build failure reported by Ian Rogers [1]
(thanks, Ian!).

Two follow-up refactoring patches use the packet’s recorded instruction
size for stack events and centralize error checking for frontend
instruction reads.

[1] https://lore.kernel.org/linux-perf-users/20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com/T/#m64fb81c665214b79883d9be815b40ac5f6669628

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Leo Yan (3):
      perf cs-etm: Initialize the Thumb instruction buffer
      perf cs-etm: Use the packet instruction size for stack events
      perf cs-etm: Check frontend instruction reads

 tools/perf/util/cs-etm.c | 83 +++++++++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 32 deletions(-)
---
base-commit: 4af65363b11fc4fe65fcb497f68bbe4f3e3a4d2c
change-id: 20261113-perf_fix_gcc15_failure-1e31233be802

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

