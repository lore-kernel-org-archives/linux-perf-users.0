Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AC414277;
	Fri, 28 Jun 2024 03:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719544701; cv=none; b=uQu5gZJvAlGyLF+flwy8BYb8wo1nfZvZnEqstz8Q4q3uw+zX1XR7VXg2KBET8m/fDGs8MzwYSJtDped9TsLY6OpAHDLUp93EtOQrWoycVPM/0qsKh2sf/7S2dZ+ITI4VI7DRHRnvTnAQBbUxOfAsygPNTWwe1rDntUNILK6dcIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719544701; c=relaxed/simple;
	bh=h92E2HHI/sLLhO3tji/J6FcOrGgu6Iv3Rn34UKirp3s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GezI0PmvQ6d1j6UN4xLSB5Vawf55iQJLvkrhALky8vvTI2AjxWxeG2i/dlC5UiazbwqbVxMGdyNXdc5c4ERR1QRRBWKu29MDj1eoCAQlwcV5PdMn73G5WRR0uI2qTn3SyuEpPasbtqVvuHuZoc5eatQoySnyIvQKNCAI2gtFttI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bfw7UMQr; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bfw7UMQr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719544700; x=1751080700;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h92E2HHI/sLLhO3tji/J6FcOrGgu6Iv3Rn34UKirp3s=;
  b=Bfw7UMQrnURP8+kUKBRK8IkDBA+/UxlE1o9kcSlsR+YdnNH1JTmI6Z0s
   6a54sxm9kCSj8BxUTfMmGFrqcTCaF18u0JJTblT8sXlUc1BGj2flUmwii
   PG3JhTIRmx1lEcxybENOvOwk+k298Sn7ynzA5J285M0yDbAxf+Yy6IFfN
   qlG1x5RnUpP6l3mPvu33ftI/Xbk1MjksmWchgNO1rWLgs4t0GbGksH854
   nUIF6uILbojm+/CoDreIgVzNUz4ez5TgBhXJe4Rh1KcikSKB9mhpoqiV8
   WMN89S/q2Yzlzc9U+NIPuhZpmPbfCoHtX22gwjW/0/76K6M8pMsz1Gr81
   Q==;
X-CSE-ConnectionGUID: v3kpa4juQpujmLvBXFvvWQ==
X-CSE-MsgGUID: OOis4k6GQ6qvLNrV1VLdZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16669261"
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="16669261"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 20:18:20 -0700
X-CSE-ConnectionGUID: IeQ2OvYkSFmpE7lNL6HNag==
X-CSE-MsgGUID: WCMYJbTKSdeFBs340tLxNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,167,1716274800"; 
   d="scan'208";a="44656877"
Received: from lizhipe3-mobl1.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.249.171.174])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 20:18:08 -0700
From: Zhang Rui <rui.zhang@intel.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ak@linux.intel.com,
	kan.liang@linux.intel.com
Subject: [PATCH V2 0/3] perf/x86/intel/cstate: Update for latest client platforms
Date: Fri, 28 Jun 2024 11:17:55 +0800
Message-Id: <20240628031758.43103-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a couple of cstate changes on latest Intel client platforms.

Alderlake platform, followed by Raptorlake, Meteorlake and Arrowlake,
doesn't have PC7/PC9.
Lunarlake platform doesn't have PC7/PC8/PC9.

Fix current code and update support for new platforms.

Patch 1/3 fixes Alderlake/Raptorlake/Meteorlake by removing PC7/PC9
support.
Patch 2/3 adds Arrowlake support, which behaves the same as Alderlake.
Patch 3/3 adds Lunarlake support, which behaves similar to Alderlake,
but with PC8 removed.

Patch V1 has been posted at
   https://lore.kernel.org/all/20240419071019.1103953-1-rui.zhang@intel.com/

Changes since V1:
- Add Reviewed-by tag from Liang, Kan.
- Rebase on top of new CPU model macros from Tony.
- Improve changelog.

----------------------------------------------------------------
Zhang Rui (3):
      perf/x86/intel/cstate: Fix Alderlake/Raptorlake/Meteorlake
      perf/x86/intel/cstate: Add Arrowlake support
      perf/x86/intel/cstate: Add Lunarlake support

 arch/x86/events/intel/cstate.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

