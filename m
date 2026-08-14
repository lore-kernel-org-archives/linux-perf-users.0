Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E875B36308E;
	Fri, 14 Aug 2026 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689742; cv=none; b=g2mIF1fXl3+aU791valLSg1TOpI5IGxpX0/Igij8WBuZoy0UiVo52UMERrICW2/gA2IJKw10Xe6w7kUfJW2xAaj4BbO1MnvbK27C4ynbkW166UDJtCyTXrvpTidp5zSeVpPqaKL17CbehOVLleuKzEGD2AhHm3GNR4GG+4sWcgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689742; c=relaxed/simple;
	bh=HGOZSq74v3POOlBGUXj5VHK1MXqJzjooxdjJE4SS7jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaRk2Pwfl3fXSKY7UBs9bI5RNHfyWOCfgYJLhIvezX9s/4OHybXlwFs6f2P8o2Bd6NmnWpboMJr/dKLjJXuoT/akmJtK22/pOVmS0ibBqXgKttKVUvqIaSecSf6m/4QGv3xYoCEjyGyAtbukN5v0euasa8yIkKT+M5afa2t0OHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dngBOE2v; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dngBOE2v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786689739; x=1818225739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HGOZSq74v3POOlBGUXj5VHK1MXqJzjooxdjJE4SS7jg=;
  b=dngBOE2vqXW7InZtqANY047aFZmzLtT1d2JKBZH9hr7dqNRpEIoYT5bm
   ws3pjMGWqpLofPZ1fNpxss8j/zb9xYwrfpmcMa+72ZUxBkMzvt63JQbPU
   6JDxnxk06En+LiPo0fnqHwcpaHUXMqCYvTXPlqtcK2gGZbUswX8OL7BZC
   4CidjoDBGqtiT4p2Us90B3F5jZ2sMnQdix1/1D6J1iIIOdTM3PuiSc0S4
   4k9rI71Vjaz1fhPAg4MofBT2+y7YNWgr5xKW5ZiJgeVNyOpEpNHJqDB4L
   vYzNssjaMOy4oty9/G1tP8uQsVIIruc6T4ry+H7vTNQPChvKSqPD68KIR
   g==;
X-CSE-ConnectionGUID: XpSqXeZAS8+AuKLpUo3Jcg==
X-CSE-MsgGUID: fVBEcMRnSdWyEYjDRqmQFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87485941"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87485941"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 23:42:19 -0700
X-CSE-ConnectionGUID: IYNCjPwETWCPQHfXhmjtmg==
X-CSE-MsgGUID: ZIceL8xoS6OpD4QOTANiqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="263708143"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa008.jf.intel.com with ESMTP; 13 Aug 2026 23:42:16 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: namhyung@kernel.org
Cc: acme@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: Re: [PATCH v8 2/9] perf c2c: add function view browser skeleton
Date: Fri, 14 Aug 2026 14:48:43 +0800
Message-ID: <20260814064843.2233001-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <an6yJfWlWtBp49Nf@google.com>
References: <20260810052647.588867-1-jiebin.sun@intel.com> <20260810052647.588867-3-jiebin.sun@intel.com> <anwuHmiI7DCOCm4T@google.com> <20260814032306.2055624-1-jiebin.sun@intel.com> <an6yJfWlWtBp49Nf@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namhyung,

> Let's start with things very clearly separated.  It's up to you but I
> prefer having obviously common code in the common location.

That makes sense. I'll make the split in v9 to avoid a move-only change
later.

The new util/c2c-function.c will hold the hierarchy construction,
aggregation, sorting, HPP formatting, and original-cacheline lookup.
The ui/browsers/c2c-function.c file will retain the browser object, key
loop, and cacheline detail callback.

Thanks,
Jiebin
