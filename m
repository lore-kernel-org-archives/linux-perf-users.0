Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F021C392C48;
	Wed,  5 Aug 2026 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785909970; cv=none; b=O9hkB0WbzJuETQoFPcTkxu7w2g9s54dQp04EF/ybl7z1QI8/yDN8EC9AZyYe+nOEr4wEjdPi2zYCbqzGQUSAJ7zwcT9E/lemZxoL/owhphg3DuxZ5jtRlGA2h611lp/qZuqfc5H1fhtv2ROIWFdfdyCl6XUx3rv8NukYgxQ0Omo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785909970; c=relaxed/simple;
	bh=5oFi6vDgDlDW79e3iQla5VdnXVrIW/ZY2sHtpIEfOyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaqRw6o2ombfs+tIUHI+PFdpUjSctBMlYO3p1PhmbUhRMbiQ5ztovfIdV/mP6M40JNg/3PGErdso0ZqAFm+IlIoNl4B/8ilT4Be1fcXtUoXwqe00cjjGzqtv/7AoeO5pmM+Bp+9KA+HN+OxWl5vL/YsAbcLv8IMYiXKd6maUyRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hwKt9IFf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hwKt9IFf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785909970; x=1817445970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5oFi6vDgDlDW79e3iQla5VdnXVrIW/ZY2sHtpIEfOyc=;
  b=hwKt9IFfoK1ff3UwetCF7Fh+ZINA2Ja/jZWqQLRMKzweYQbrFd0ji3fT
   n1LVZv765O6QpeOy+De32Hyrf0uxcZTUdW9oXvdzRYXgexczErEGjFh8x
   RjqIfpeLGCyoXnHbLOgt3W3TkjEAwpExdhqwP2DdvZNEmGwjlbGA0LrWr
   sa3t0m+wxs3gt7DtZA1ntEAJdwqa9I96LTsHQwZ09OKdZe2V4Fzg4Ycf3
   F3CLBWMaMzVyja1Ey8mAaGNudxbUzGM2oQOetwkuZEFy/qiNVhjl3KTuc
   kkzAzD9iNfesaMhmZ2SO9EmEb80+XKoDlFSz02XDgvvyg0ZdO1/1sGbZm
   Q==;
X-CSE-ConnectionGUID: DRONm+j1RyW/4L5FFOeg2A==
X-CSE-MsgGUID: PKnL+hxTR220Omx0xOkDhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97635542"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="97635542"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 23:06:09 -0700
X-CSE-ConnectionGUID: 903ZxHqZTF2kQ1OJsQerxw==
X-CSE-MsgGUID: 5esFQqGvQlCnkl5JvryLwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="265546853"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa004.jf.intel.com with ESMTP; 04 Aug 2026 23:06:03 -0700
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/9] perf c2c: add a function view
Date: Wed,  5 Aug 2026 14:12:50 +0800
Message-ID: <20260805061250.2006831-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <anIeT4yBy6WX2ky5@google.com>
References: <20260803035220.172022-1-jiebin.sun@intel.com> <anIeT4yBy6WX2ky5@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 04, 2026 at 10:15:59AM -0700, Namhyung Kim wrote:
> I'm about to merge the series.  But please consider a follow-up work to
> add support for --stdio and add a test case.

Thanks for reviewing the series.

I am working on a follow-up patch to add --stdio support for the function
view and cover it in the shell tests. Since it depends on the current
function-view series, I will send it for your review once this series is
merged.

Thanks,
Jiebin
