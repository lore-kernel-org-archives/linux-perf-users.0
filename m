Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793654069;
	b=fzKf1au2fE7ZiEk5vXW+hsYKPgFwlszFqKg5J9zBttKiF/wDaATsp2TFXmu4kfO68Sfb
	 ByG8PmhpJY86RrvlE8PHJa6dzLjKm6mAKrxxHGaHw+1O0RsTNXkJmw/EH0q9GL/Vdn0Zl
	 lIC8ATTt981iAiYzpsObtADg9R3s/cRMOo7ZWgmE6IsU93saSmFP3fGFwByDGNKJ7r3Zu
	 At4c8PgF/S1Df+UvuPV2xsHUWs2yfZ9zl7WJoO6FdlkxYkP6H9YMgDevHbeBmIqdDFSq0
	 0HCT2PKZImszFvhB7ynFEr4MeUEHBV3a9FbkDSc1Q6g4TNhrtqA9K34FJrZBi1TegFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654069;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=1XA5MeCaMsUqWbdpicYXd8VCvuZhBeV7/2rs2YRa3XA=;
	b=I5rfMvCWMBKH7ynUraQ93eOPqmhxmBJKf9UZ5474BdkSFfw/o49Ab1kU6QWGIJq9DO+x
	 r32vyuBhvxe+DpTuAgkcFmKMIX9pyLagrTwlZJwZbWd5f+ns1OLf5XtSGBKjchgRU1xa2
	 JwyhgcN570uYerrm4lFW8d1iMjAVY7M3h6XVRwBEpS0yWOUxL01n/VcplrISCwToK1aAr
	 1wsAZwX5tw7h7GY3f9ULQ9Rr5esCxq/+ER1mGE6Lyox4aTItmBoHeZwpBNchM10CH/ZRS
	 VkfvxekxElSiMqbky51FqST8EFvyV5dK7Al2jmHUjxf2m+0cvtOKiVbvTgV+5jonAAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7nYXuly;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2CF606A329;
	Mon,  2 Nov 2026 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7nYXuly
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793654069;
	b=bx02enzseSDwVj+BVTcZM1y4aTImF/kVJf4mRPYXImg4MYbUiETXuVVmiAaL5TcxNgDG
	 PT0SovoliBekw8yMYcaesL1iydXfqaySxL+QscJNUnQofwzdZFbTlBpbQ5l0m9OjX1D1f
	 kXpkt5T+rVVRbvTbMQVKrM/uRKW7ESbi/3Da0xlkw6Bq9BpJpaNfORbOTHaQtp7VPXX0T
	 GSJzNJop94RAs6uaVru0rXksSVvtmOkR5GgAMtoVnD0TGtR2NqLPJDdur2gtPfcXtK1W5
	 cPmaVTFIFlwTBODL29Oahxl5p95X5MNtTdN4udqhC8YMgwKQwUHaCM94UjXH+8vcF/g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793654069;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=1XA5MeCaMsUqWbdpicYXd8VCvuZhBeV7/2rs2YRa3XA=;
	b=IU5OpS34kNPgiExf488Sj/YJ6SMUMhqzENQbAivHWU1mhQYboAjHF8N509LjCHU8S2uM
	 whlHRyr3ou06qfakdpc0KlvnnVIXdoLFNATajuVbNO1Hb+7HOxqjsR3dj1P0pi93cgszG
	 LFtFPwLlKOJysV4onYW+dubUD2oPI+2JenTaAaOnDfJ9UqDBL9v1FjQYqHgj1jxGEd8Eg
	 w/iK52MVQLvMMQFF35Z8ntnUzUbo3K0yObG5CeAMGpX7Y4GnbTWOlYdOs3UkG3KW+5gId
	 umLI30P8OU1cmoR1wNWJ38TaCwb6/hX3tf6PzYfhPOnGWfGrZPhchhQauH2XcPfwiGQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7E22B1F00A16;
	Mon,  2 Nov 2026 21:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793654069;
	bh=1XA5MeCaMsUqWbdpicYXd8VCvuZhBeV7/2rs2YRa3XA=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=L7nYXuly3o+uV7OEls+jNm/H/ETvrnw93JvkeyQnD6xIWr1LKz9yHZV64vdkQ1AGZ
	 DyZ/vCzs57kSYJ0vvXGVkHtfE19zqG+clZNf1E+iKwB9r+A1TMGUjU8uMMidTfs/mM
	 aIkqHI+vLHseREE8fPmqoPHK8kW5tkdFmqPs3fuKQlS1dBtcIVedF8X1Skda7ZowwS
	 hFLpzMOxSlWxVzY0exKcUVcwAZ87MkyWQp6YYNU7g4RHTXWDNG3+SlJKLtljPkxB7f
	 yDgrbK2kOkXV1RhVXtlcYK0X45mArE3bIcEpYjqy11aUQ7sO3mT3RL+enN+9pK9dAu
	 NErC+eB+1YMDg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F23294667F;
	Mon,  2 Nov 2026 21:14:27 +0000 (UTC)
From: Jacob Lefkowitz via B4 Relay <devnull+jlefkowi.akamai.com@kernel.org>
Subject: [PATCH v2 0/2] perf jevents: Add IOMMU PTW & device entry metrics
Date: Mon, 02 Nov 2026 21:14:15 +0000
Message-Id: <20261102-perf-tools-next-v2-0-4d237f886710@akamai.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNyw6CMBBFf4XM2jG0PERX/odhMcIgE6UlbdNgC
 P9uJXHl8pzknruCZyfs4ZKt4DiKF2sS6EMG3UjmwSh9YtC5rlWuG5zZDRisfXk0vARshl71ZVE
 UqiZIq9nxIMtevLWJR/HBuvd+ENXX/lrnv1ZUmCOdKtL3uiRV8ZWeNJEcOztBu23bB+KDHySvA
 AAA
X-Change-ID: 20261028-perf-tools-next-8fd1d433316a
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ben Chaney <bchaney@akamai.com>, Matt Pelland <mpelland@akamai.com>, 
 Jacob Lefkowitz <jlefkowi@akamai.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932;
 i=jlefkowi@akamai.com; h=from:subject:message-id;
 bh=d66B5JAoBXgjBVfpcoxVXE9rM8vAjKvyKdmOxdyzjJs=;
 b=owEBbQKS/ZANAwAKAdLKfgzjwTS1AcsmYgBq6P0rROw5wdqaVhUI1FzlhV0u8sWTxMPI3V5w4
 73IVmoN9leJAjMEAAEKAB0WIQQKFmVpIhg7hFI7scTSyn4M48E0tQUCauj9KwAKCRDSyn4M48E0
 tTv8D/46cbO7uCat3xnsVx99k3cPiDz4YBgdQxmUZORhslhy04HrNpTqLj8Rv1UWowXhmW2bIBh
 KQvqwJYspXh/7idcZtxE6udAYhVAWFVUmNjY+6o8yFztleoME63wtUHVsYix+6PDVXDvnyVS1xz
 uM6+PiMiyXg2HF04A8yavRLbPNu4ZeF6oiL0FZ5qc2NKEBlTT11qqW2UI4S9Yxxn/vYIGmkRzxu
 ApErMtCnesZdk8gatxg0DJ0g5VL5CMlVndVDWRfIy19B+GJfrtuIFZDPSSe9ELogvWZtay/JCAe
 C+Au+N5IDz7Pk0C7AiaIACz23POrYYoTXukRSEvDmWP6zRB/0FlOjDZlA3ZCSlJPCnm2RLeCn/h
 xL6hooCg4XweLs7qdfg8WwIYgxiMD+v15tCWtDaiJxOzVONBU8zt3zYZw9UhQwQmmFTnMDAQQv5
 NXloMm9AQhTnQhOfHJIAelDy4LlMyMHidksVmY1Z7xADHzOuke26+m5lrNge8RDQPDmFILl5a1k
 Pzu/YuXzvki7mdGzA3kx4i8uV+deZiRIhHUc+MrzP4Xp5SbO4kQzLPaI/IOhh75xHlZz7pnI9Ls
 nuSSQBsxYWU/MBHgV3VFFf8VM/dj4z1f4Dr5HxGhuJzD9LwZTGfRHFOqfXlCmmwraQ6DHjlSWrJ
 +lx8orRLVDZTaMw==
X-Developer-Key: i=jlefkowi@akamai.com; a=openpgp;
 fpr=0A16656922183B84523BB1C4D2CA7E0CE3C134B5
X-Endpoint-Received: by B4 Relay for jlefkowi@akamai.com/default with
 auth_id=1357
X-Original-From: Jacob Lefkowitz <jlefkowi@akamai.com>
Reply-To: jlefkowi@akamai.com

Adds AMD specific metrics for the IOMMU with respect to page table
walks and device table entires. The metrics cover ratios, rates, and
percentages with respect to any event which might be triggered during
a page table walk or device table entry lookup.

The metrics target Zen 2+ processors and use the standard amd_iommu
PMU events. All metrics are tested with 'sleep 10' and behave as
expected. An example output of sleep 10 is provided within each
individual change. 

The changes are split into two patches:
1. perf jevents: add iommu page table walk metrics
2. perf jevents: add amd specific device table entry metrics

The specific metris added are:
- lpm_iommu_dte_miss_rate
- lpm_iommu_dte_lookups
- lpm_iommu_ptw_reads_per_tlb_miss
- lpm_iommu_ptw_nested_read_ratio
- lpm_iommu_ptw_guest_read_ratio
- lpm_iommu_trans_per_sec

Signed-off-by: Jacob Lefkowitz <jlefkowi@akamai.com>
---
Changes in v2:
- Drop min() wrappers d_ratio() for the IOMMU ratio metrics: min(NaN, 1)
  evaluated to 1, reporting a false 100% on sockets with no amd_counts
- Did not test with previously mentioned custom workload and did not add
  to the workloads collection. The workload stressed the CPU TLB,
  but the IOMMU only translates device DMA, so the load never reaches
  the IOMMU.
- Remove unused min import
- Remove global declaration of '_zen_model' within each function
- Link to v1: https://lore.kernel.org/r/20261029-perf-tools-next-v1-0-a75a2b64a15e@akamai.com

---
Jacob Lefkowitz (2):
      perf jevents: add iommu page table walk metrics
      perf jevents: add amd specific device table entry metrics

 tools/perf/pmu-events/amd_metrics.py | 75 ++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
---
base-commit: 1c90f0a3c8a1c4e38f9edd97af9e20848805a7fb
change-id: 20261028-perf-tools-next-8fd1d433316a

Best regards,
-- 
Jacob Lefkowitz <jlefkowi@akamai.com>


