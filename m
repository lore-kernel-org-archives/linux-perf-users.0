Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27584388396;
	Thu, 15 Oct 2026 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792079542; cv=none; b=bb1vXD1ePCdSRU4Ex48rkwYxnYWMvNPcVfAYYsmQ+TSdjfH32u0dbxmnoSUG9Rs1pTcLmeeRlxbgulhzT34oRTIk7dcCpWMyft5OtBUfkPS8gW2EVh43gSfwNo3VikXoEvCD4Aw1N1rbPLxBTcVvtVHjV1UW0oYGlViJ44PLnTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792079542; c=relaxed/simple;
	bh=gELyVh2LE6u3v6a4/bZ7gMH0X/a3oaoXrVoknaD9/jY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=af7vzZk9YRKqQZo9gCyhwTdgtVFuUDco3FMsAPJVhIi2JA+VLMtoIO6dfV4g1d9UAEK+Q4cef5s9xPTBTGFr57FeCW2fRwv8lHlZ/x7CMwKxaLpOMzRzGoQGxpo/hFpf9r8+RpD+JRII7b+nOmfqDvk2GciZulazWeA1LVOnAD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UfSD0Ojh; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UfSD0Ojh"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D92114BF;
	Thu, 15 Oct 2026 08:52:05 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 555B23F7B4;
	Thu, 15 Oct 2026 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792079528; bh=gELyVh2LE6u3v6a4/bZ7gMH0X/a3oaoXrVoknaD9/jY=;
	h=From:Subject:Date:To:Cc:From;
	b=UfSD0OjhjRzRc2nvK15zgz91Jm+uC+ECcRkkY79xc0leQKYg8a6TUZHBKMULiHsmW
	 VLHWQZMj/7DYFPLFfafrdZiCoh6YHnPcQMRbKTIlMsCscld8NYA93dVuLEFFOtxvab
	 zQ4s78YZ7SjKLLxfEHuzrLguJEkpQbVaXR3XpOGE=
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH 0/2] perf: Order SPE and TRBE padding before publishing AUX
 head
Date: Thu, 15 Oct 2026 16:51:57 +0100
Message-Id: <20261015-add_barriers_for_perf_aux_output_skip-v1-0-5847d0578859@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ320GoC/x2NQQrCMBAAv1L2bCCJpIpfEVkSs9FFaMJuI4XSv
 xs8zmFmdlASJoXbtIPQl5XrMsCdJni+4/Iiw3kweOtnZ10wMWdMUYYkiqUKNpKCsW9Y+9r6ivr
 hZi72HOarC8mnDKPVhApv/8/9cRw/459rzXcAAAA=
X-Change-ID: 20261015-add_barriers_for_perf_aux_output_skip-70356815b2bd
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
 James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792079527; l=1132;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=gELyVh2LE6u3v6a4/bZ7gMH0X/a3oaoXrVoknaD9/jY=;
 b=+IklPEIB+tA+LBpopP0HvZoM0sQgYLKmbHbrxALjQJUthC7b0AakzwraX3AkZqTt9OqxbdyTk
 uUASvDFpepLAAu76/doK6E0JEFmJ+v4rDqsvHpYKxJDbRLLmB4G6to6
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

SPE and TRBE write padding into their AUX buffers before advancing
aux_head. Add the missing write barriers so that a userspace reader on
another CPU cannot observe the new head before the padding stores
become visible.

AUX producers must make their data visible before publishing aux_head.
The required synchronization depends on the trace hardware and CPU
memory model, so the barriers belong in the drivers rather than in
perf_aux_output_skip() or perf_aux_output_end(). The TRBE change also
covers padding inserted by the overwrite erratum workaround before
perf_aux_output_end().

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Leo Yan (2):
      perf: arm_spe: Order padding before publishing AUX head
      coresight: trbe: Order padding before publishing AUX head

 drivers/hwtracing/coresight/coresight-trbe.c | 2 ++
 drivers/perf/arm_spe_pmu.c                   | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)
---
base-commit: 0fcb05b72344f40806cbe810de8872f1698bf053
change-id: 20261015-add_barriers_for_perf_aux_output_skip-70356815b2bd

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

