Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DBE192B75
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Aug 2026 19:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788118511; cv=none; b=unCZmxmq78ndRI4YgJLKsj8rOlsulSqCn6nu+ZzRG9AE8GkKH+nxX/CapVTtHsxwweJ4/YebD+BM04uGeHHX7iAc9R/bkJeZgZIK7saaDgbSLYMQsjWlaFQUXN2cLqgD/kUjYPqsYc8rICoiT6VrxWdnms95Jd1i8kS942njW5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788118511; c=relaxed/simple;
	bh=Guvz11pdtBMT1JUnTyIE641a9FG1ldmOkAC1dB47c04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nt0DtGsnQezacaVz13mxGcQwJzY3Rc95wRjCyJgkz8pHzz9CNCrvVa7fk77Qy/S+vC3rDJgWBVz/SgQ2SwRN6PeAyCqYnlj3Mc3i7iGTWYDGVl2ZSir1CVuP+4iQlnN+CW/vYmJDUwUNtUCamRLXOk72xG2DLx/RnpqxH8sffzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnQuF9Md; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnQuF9Md"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788118510; x=1819654510;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Guvz11pdtBMT1JUnTyIE641a9FG1ldmOkAC1dB47c04=;
  b=LnQuF9Md4qNgR+EkPN/xyeqM4yyvyOmYYtvhp+i9KXkD/E0o7XpikO1Y
   nrybbvuIwCg8XMQXLsxFKufqXqgW5J9XIxFv3BYJISJDrXxT/2Qd0TaVW
   1zj89G/B9Q6yShix/M7S7LrxuQNUoXdBo7DHKS+jnnyhMiKQ4Ht+thPGW
   CrnHrfsGiLgpzlXdXemqg/CCssRTYLiX9m4vWHZblEJCzaAQmUuZnkykF
   ckleVkc7UIA7xQBus84g2bvjv5aYVKeLoms6chTJD3vKi3HY0P+6srCNs
   RNXmh80ROltPOhQDNLYzfOBx/EcM0sX7bEtNTx33rA/Dm+SgAmjDpfwcn
   g==;
X-CSE-ConnectionGUID: ji6HK3pGTvWBrfbgNHzxxA==
X-CSE-MsgGUID: ja0TLB3uTTWQkynUiaQHXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="87667332"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="87667332"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 12:35:08 -0700
X-CSE-ConnectionGUID: zIK70A6IT165AocTEVaqXA==
X-CSE-MsgGUID: M3Fu8JdOQl2gChdqQI+Azw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="292118653"
Received: from tassilo.jf.intel.com ([10.54.38.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 12:35:07 -0700
From: Andi Kleen <ak@linux.intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org
Subject: v5 of the perf weight annotation patchkit
Date: Sun, 30 Aug 2026 12:34:36 -0700
Message-ID: <20260830193459.2840519-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the latest sashiko issues

