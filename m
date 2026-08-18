Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDD323ED5E
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787094158; cv=none; b=C+TluMypmFp4nVw2bgVDhQrI+MhjIjL63ugAFu6FG7df6hePWrSK8z7OmzNRbodUPBq84KW8eOvJMUYkcV4DHg42Wg9LBM2gpSm5eE/Hac4LaqHkQelu9JlvL7pDMAZllUv0SpdrJ7znyNLYT9pP0e/mNSxNliCigaHWLd6yfBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787094158; c=relaxed/simple;
	bh=nS/pQlTECt4LnPYP9KiqYE8rdj5wvXfGYY7bkhhrsoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kG7OKcy8ig6S/bacdAayr3hFsXDDUR7hd45uZdDjqPQz8Tdn8DlSxXns5s6hGAyTrdRvtXrEIxaWWe9RCdTzVg7MK7Yvj/YMS2eVverI9NvbsBypAuFrivrD5XPp5uzMnnUN9PPMP0WSbgBAs8/QU6dA+ZryhjsKLpJqcrZ8SoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m/ZaajA+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m/ZaajA+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787094155; x=1818630155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nS/pQlTECt4LnPYP9KiqYE8rdj5wvXfGYY7bkhhrsoM=;
  b=m/ZaajA+tWLq75jjrgum89Ujx42FuBiaICeo2Gsr3tOraGSFbxpQYkth
   eI4g0cgCvL6nY/Ww4DZBw02n63Uq0Y6ntnI8MHvKzZVMUtsopGm8eaW8F
   2dvR1+fdvibyfDchtNczBudV5ZevfEvbbDDPqS8qmvxCRNCt9u9gijPmP
   NhecsPKThfhcavuNyUQEhmMIO9R6toEfi26HIDTxAca+AyEKKDUEI0h/C
   k7swEIyjXKiEQ/37lDAukoD9ZhVYqGJ3SvkIkU5B3h0W17CxWOIjh2G9X
   WqV00ELYbmpKBqLwFIYzaIHu6UrQcCVvhuyn+6VEn1Fni465nODDUVZza
   g==;
X-CSE-ConnectionGUID: UxxGIYMdSAqQ8Iu2abbZ2g==
X-CSE-MsgGUID: 3xI9erCbS8m8JXxhgbow7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="91409642"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="91409642"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 16:02:34 -0700
X-CSE-ConnectionGUID: JROnBSxOSK+31WQ8IT6I4Q==
X-CSE-MsgGUID: modQzMgzSp6/53KkGdbACQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="264060584"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 16:02:34 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: v4 of perf weight annotation
Date: Tue, 18 Aug 2026 16:01:04 -0700
Message-ID: <20260818230229.1491871-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchkit display weights in perf annotate. 

Changes in v4:

Address review comments (except for some Sashiko nitpick)
Support no-weights for perf report too
Rename the symbol_conf flag
PPC and x86 now report correct field names (using ifdef)

