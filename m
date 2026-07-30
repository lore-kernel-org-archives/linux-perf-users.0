Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811283EC807;
	Thu, 30 Jul 2026 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785402156; cv=none; b=tgnecLMmZZKuUD5IOLpp96ZkCQ6Li3wsVpzIRPYvt0IdrwuNYLlydR0N+Av0SmVjIcM5sBQfn07l1bik7Aeuj8nsj7m3kpiAxGgArgAyxKb68rj1xPVgrFKE6GbNdMR+2X4nOaFiKbeq6i/xSxMzE2t5s9Epbf+OtVrkr6OB26c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785402156; c=relaxed/simple;
	bh=S71o7Rt7M4VFp/iGHFtE5HX4qyLxwbkpTS5/lBniJ0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wk+u33UJixCW8ZMamFrtxcJOrUzwiJj2oysbu7bgtDfJyF/M4XIuhShE7MV3cUic7OhqwEXgnY6AAAekl6vE6HX26AqBUPe1Aeb0ZGZlSg+4MWqhZZU93ncHrksuiPnunViAqJd/7IOcBk/4XTvNEum0EkO1MtbzYc3+ZTeRoiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHDPPmtv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHDPPmtv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785402154; x=1816938154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S71o7Rt7M4VFp/iGHFtE5HX4qyLxwbkpTS5/lBniJ0c=;
  b=iHDPPmtvN0Z2NKVKSMukPU4bT/UBEsJgP0DTTLb2HRS+xRUa4DREpgHU
   eu7XRkdTyYkXHGFuWZQTdHe+74qRrxZryYD9HZlNu9j0gofB0DBBfDloc
   HY9K1wNhFxea3KS1pC5SSidCmdxvmcY0ua8LjrehJIDR4puE6TGdYulGb
   QmsIoS69SEULO9dlnBlo8YKR5G0CJybNZjN5D/K7Raz1Zbf8s59EYQxg4
   0CHZGfadbnUduFf6vFpgkLpql+iTwj9d81uN6PKR4QRgxVWqCA4QjYltt
   wGFaHtelPJPUXI1bW95sK1PhYjgpQHlTFIDUTUb3eVGr4Q2jKOxwG2P4R
   Q==;
X-CSE-ConnectionGUID: CKWhO3ZRTSWfYMTkQMaAng==
X-CSE-MsgGUID: PR+DE3PwREm0ZAUqUCyX7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="73551676"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="73551676"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 02:02:34 -0700
X-CSE-ConnectionGUID: EZr7GzRdRVifpfypZxYY3A==
X-CSE-MsgGUID: vkliy8njTS26LUbtaR2YtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="283596811"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa002.fm.intel.com with ESMTP; 30 Jul 2026 02:02:30 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
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
Subject: Re: [PATCH v4 0/9] perf c2c: add a function view
Date: Thu, 30 Jul 2026 17:09:01 +0800
Message-ID: <20260730090901.2216672-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <amjxS3hcWlvQHerx@google.com>
References: <amjxS3hcWlvQHerx@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jul 28, 2026 at 11:13:31AM -0700, Namhyung Kim wrote:
> Thanks for the update, I think it's almost ready to merge.  But can you
> please address some sashiko review comments?

Thanks for the review. I went through the sashiko comments and prepared
v5, rebased onto perf-tools-next at 0d40fedcd1b9. The full change list is
in the cover letter. The view layout is unchanged, and the changes address
correctness, robustness, and style, along with some adjustments to which
entries are retained.

A few comments did not require code changes:

  - The ms/thread reference handling is deliberate. Child entries borrow
    references from the cacheline-side entries, which outlive the function
    hierarchy. Their custom destructor does not put those references, so
    adding get() calls would leak them.

  - c2c.h directly includes <linux/types.h> and <stdbool.h>, while
    <linux/compiler.h> is provided through <asm/bug.h> and <linux/list.h>.

  - The level-3 cacheline address is not truncated. The symbol-column width
    is expanded to fit the deepest identity cell before the browser is
    created.

Tested with and without SLANG support; `perf test c2c` passes, and the
cacheline `--stdio` output is unchanged from the base commit.

Thanks,
Jiebin
