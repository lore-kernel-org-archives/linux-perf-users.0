Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC853264F7;
	Mon, 10 Aug 2026 05:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786339650; cv=none; b=BaQJxj3ntfjl39W6e0SxNb0UsHOX2f78Nu3CRmQIB8AurLvntBNqOS+Is9a5MN2WIi2w3F1wkECBWTv4lHtCGyUQrYgIqPzonP7JyUuHV1ll7SHi75Tg/oJzCUoL/0RBrAhYz28c1eFoXslLmHA/SjDQn+iJhjR2HAq6ZUjirM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786339650; c=relaxed/simple;
	bh=pK1ymIkZEVwFk8GRtKAsI9k5R19MbytvWuuWvsNJs0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQoL110cCAyalYnVna13h67+9Sxod4tG9a5iSRtpICdjPd+5fGlI6kMqnlNvXOh7inT/M/nfKxho3RcgFTnhoI5ZEEBSEozcp3FVc/ws90mr5OXf7hscV8Gi+fqDuH+jHaKc1DsT+UXqVoQ0NJKuXy661OzPAJZdF6pcTu8x2gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bO1RPdyt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bO1RPdyt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786339649; x=1817875649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pK1ymIkZEVwFk8GRtKAsI9k5R19MbytvWuuWvsNJs0c=;
  b=bO1RPdytbEFYVlFsshusqkarn7FphARnZ5VlZmZVfY9JRTiJZ7Jw8dd/
   xwak0a8ecAsZn+PaUKVjqIo8Ex9PqH2jPE4TQKYLP9A+aYGmGuHCYQV8B
   /9fP6A8bZ0KaHRYGqSY6Tl0+S+V7wtM0rdJZta8hKK/6BHDVFs/5bVCXO
   hT/DgHE/kmOEPEJ6wZ5yFYyxOfX4OHbzfa3gtilGG7vJyo01f6Kuf29j5
   96ph8kbeLJ7wxg81+VZHBTvYdZXeByY2B/PqmYhiIaEiwo6IJL2zipm/s
   Zzstw5A+jRKWuuC09VuBNCPlS51ejq52F7rzu8h5Z8ldBVrmfaNPHt7/h
   g==;
X-CSE-ConnectionGUID: Q98Q/3NaQwq/t203nYczsw==
X-CSE-MsgGUID: p9iDQttKSZSunXMau2ZDEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="86873839"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="86873839"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 22:27:28 -0700
X-CSE-ConnectionGUID: cp+QLbBBSECbGHMUsM0VQA==
X-CSE-MsgGUID: dvmrlgtnSRGJcm7ht+FS3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="261645875"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa010.jf.intel.com with ESMTP; 09 Aug 2026 22:27:25 -0700
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
Subject: Re: [PATCH v7 2/9] perf c2c: add function view browser skeleton
Date: Mon, 10 Aug 2026 13:34:00 +0800
Message-ID: <20260810053401.590185-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <anV3eQb6SzRnRksH@google.com>
References: <20260806074217.2846596-1-jiebin.sun@intel.com> <20260806074217.2846596-3-jiebin.sun@intel.com> <anV3eQb6SzRnRksH@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namhyung,

> I don't think it's a proper fix.  The c2c-function.o should belong to
> libperf-ui.a.  Perhabs we can split libperf-tui.a and not link it to the
> python module.  But still, it's better to move the common code into the
> util directory.

Thanks. I reworked this in v8 to keep c2c-function.o in libperf-ui.a and
removed the v7 tools/perf/Build change.

builtin-c2c.c now passes the cacheline histograms, the --coalesce field
list, symbol_full, and the cacheline detail callback through
struct c2c_function_view_args. The browser no longer references the
command-private c2c instance or perf_c2c__browse_cacheline().

The shared c2c types and formatter callbacks are now in util/c2c.h and
util/c2c.c. struct perf_c2c and the command state remain private to
builtin-c2c.c.

Thanks,
Jiebin
