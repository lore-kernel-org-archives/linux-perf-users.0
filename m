Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917F11FECCD;
	Thu, 20 Aug 2026 02:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787191404; cv=none; b=XycuL3t5AEcK2d7YlxUm6LZogPU1ZZW/3dxW76xTbMIebya80N8E0zCn/VOiChh5ddOegv7DT5WRGDsQkHxVgxDgQsYnJX60d/ujXM47ak1EumTTECATC7yGiaGV/GsHu+9qyPcducdqYVuxu9mds3I1LRJWDQQgSj2XBp+tShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787191404; c=relaxed/simple;
	bh=uye3Jti2C9W8t3LYD0ExUgdSxqjLCBbWJSQzsfU+4II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgMSTkUNwm9nvwnPHSzBW3SvNvpj3M2p0n/8xS8EmOKaxtThm23tHfcIs1aVjYN25v6X41oirdj2AcfDU3ZbKq2EIKwgK3SN8Y57XJKF8YzMrl68M71HP3xRbhLPp/MpB+9Q2njs1mEfgYCjcOxZ1kC2q3UVBQRfAUKXromVynE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVFgQNRB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVFgQNRB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787191404; x=1818727404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uye3Jti2C9W8t3LYD0ExUgdSxqjLCBbWJSQzsfU+4II=;
  b=TVFgQNRBMAaem40l87Uwrw4e9gfIaJuA1Sd9qi1l+/FZPiTPzCRwXlJc
   JwjFoQnv5jix8WuUDmRL/+oFEdYvZIrwsa0XjTQleLlkpM84aBT/Rc8Wo
   gTDuvqlnu2SfRQUXnMJ+5i6QktfsAI0LPXk0AT++vCcPGOKNJrJHzJbzc
   gCV40msIy3e6NOCsCiz2tICNiAnbqBLIKPYEQ2JLgLouy0L8zKatFgBum
   LSASKrnBt9vuxH/qAoKHd3fcPvRN8b5jHePZ1L+57/dhe/TtGZ6qmq6nB
   z0I5mHmeygdWdochmxbvHm25IQ3VdwIFjjhw2jjk+XP0OcW/PdgJ/osbH
   A==;
X-CSE-ConnectionGUID: L8nhUmrjQ72KYUvjX3Jd4g==
X-CSE-MsgGUID: k392Vp3WTfyVlWzPjrk5Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="105252692"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="105252692"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 19:03:23 -0700
X-CSE-ConnectionGUID: xdvQ/DxgR9eZOV2I7yKfyg==
X-CSE-MsgGUID: QuRIf6J1S9+zbKnu8esApA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="303967164"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa001.jf.intel.com with ESMTP; 19 Aug 2026 19:03:19 -0700
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
	jiebin.sun@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/9] perf c2c: add a function view
Date: Thu, 20 Aug 2026 10:10:13 +0800
Message-ID: <20260820021013.238577-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <178708820285.2068376.4445054053733143306.b4-ty@kernel.org>
References: <20260817094623.3288456-1-jiebin.sun@intel.com> <178708820285.2068376.4445054053733143306.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namhyung,

Thanks for applying the series.

I will prepare a follow-up for stdio support and automated function-view
coverage on top of perf-tools-next and send it as a separate series.

Best regards,
Jiebin
