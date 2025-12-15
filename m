Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD1B27702D
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2025 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765803909; cv=none; b=ZCSxSeqy8CvXby/WpKVktssJOc/T30F6XTV3ZA2kZBaYZhtW+L5JX2x8xeDNvMK7hNV1p28xxramGHl5fMQSFvwdPuHdthd91n6kHQTLxXt0o0F2E3bwzEchzBa8v/DbrPppuRmAALVLUP6/7J2o7kLkI/vf7p6yKTtE7ioAmNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765803909; c=relaxed/simple;
	bh=dQPtPA4YaykXPbNVoSex+hfFGB6UQmR3l4NgTEN/7bI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U5zBuM2mcalIufU1vjjssvYnp4KZIgsGO9wEoOtfoWj9LeYxF8nKLNmGr+QN6GsoTTl+22p4WI9FNzs6reTCTCfkr4IWeCAiChFBcLzdoSY6cTXf+JjXbrSgkMs+1+uUyQA81XGhZBtLfHimpJuuGzvc+DKG+2q5vgRhwesyg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A6B1497;
	Mon, 15 Dec 2025 05:05:00 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5AA2F3F73B;
	Mon, 15 Dec 2025 05:05:06 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	suzuki.poulose@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 0/3] perf/arm_dsu: Support newer DSUs
Date: Mon, 15 Dec 2025 13:04:57 +0000
Message-Id: <cover.1765802897.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

DSU-110 and 120 have been out for a while, and although they continue
to share the same basic system register interface, they have subtle
functional changes that require a little attention to support properly.
And while DSUs still aren't widely exposed in current systems, at least
some folks do apparently care.

Sanity-checked on DSU-120 in FPGA, and original DSU on Rockchip RK3566
with TF-A hacked to set ACTLR_EL3.CLUSTERPMUEN.

Cheers,
Robin.


Robin Murphy (3):
  perf/arm_dsu: Support DSU-110
  perf/arm_dsu: Support DSU-120
  perf/arm_dsu: Allow standard cycles events

 drivers/perf/arm_dsu_pmu.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

-- 
2.39.2.101.g768bb238c484.dirty

