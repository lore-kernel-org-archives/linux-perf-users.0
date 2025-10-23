Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E07928000C;
	Thu, 23 Oct 2025 22:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761259460; cv=none; b=u2ZBOzLXW6IFbCXeMMRsJy7CADsuKzdbSfGXnnMxIcse6knw8aiNfJTBv/S2eb7EW8MbjYJ8Qdd5GQqissjZoXOF+Ad7Sp1UFlHD/gKRjU47NZ/PnFgvqHZd3P7H4nFJvjIvkQ6R8nkXUuvxPgvd2bB2UfaSX96xCuZ9ofMbWBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761259460; c=relaxed/simple;
	bh=GYwNKfgcA9It+6gC4gie6H+mQVHu09bWLEkvqoiKQXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BtMCGqK/YsODS7Ub0GyiSNUB9LKjiNhkBWtywJgtQAf+X/MjkYgaeKz85b5qGziSQixF3gChT4PXJO2XMpcsE9n9md1LRj+Ee1qCbE3Y2kWzry4OgkDsvem0sPmuNsLMxgHjhl0WDtna351TvaAUfz/gho9l7lxH/9+VWS7ruHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e5u+7RyG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e5u+7RyG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761259459; x=1792795459;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GYwNKfgcA9It+6gC4gie6H+mQVHu09bWLEkvqoiKQXk=;
  b=e5u+7RyGK0wrFc5oM/NfBiLzW21yp2JveuVhQQEvAgSn4ElfXV30OQi+
   dnSnm1vujjJ8jQoq/C1Y5o3SeUBUUHbA3m1l6TH98pFFHGFNTfCaBxN3A
   YVqHQzzXGFRWF2usbaDJFXziVrIvcZ11jFvgSDb0mfKagjI5MNTjmMH62
   3EwdqDTv+fAa/mD8jW4VV8wnUyC4rFk+SgDzr2N1pOCiyRiQf92OgWjSE
   7P9tW4HoC97zlm/3+hkvyFrPQ1UTrefFdFGfllzs0j/DI0XPEIxYmTbvV
   FaX3jf97ivDGmi+d0pAQ4pdFakBY9fZuRqAqKAo0zIJYyq3lbOyVlPIHc
   Q==;
X-CSE-ConnectionGUID: lTp6O5oZT32i/MljOtMNYg==
X-CSE-MsgGUID: ICIRNb0gSkm2b62eRopujQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63333506"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="63333506"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 15:44:18 -0700
X-CSE-ConnectionGUID: t+sln/ltSZGmBgHt84bqcg==
X-CSE-MsgGUID: YQYxjifKRbazYvBHIIAHzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="183885472"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 15:44:18 -0700
From: Zide Chen <zide.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>
Subject: [PATCH RESEND 0/3] cstate support for CWF, LNL and PTL 
Date: Thu, 23 Oct 2025 15:37:50 -0700
Message-ID: <20251023223754.1743928-1-zide.chen@intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series resends three c-state patches that have been posted for a
few months but have not yet received feedback.

On behalf of Rui, I’ve included his two patches here, so that all
outstanding Intel c-state related patches can be reviewed together.

There are no code changes in this resend. Only the changelog in
[PATCH 1/3] has been updated to note that the C1E counter can only
be read via PMT.

Zhang Rui (2):
  perf/x86/intel/cstate: Remove PC3 support from LunarLake
  perf/x86/intel/cstate: Add Pantherlake support

Zide Chen (1):
  perf/x86/intel/cstate: Add Clearwater Forest support

 arch/x86/events/intel/cstate.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.51.1

