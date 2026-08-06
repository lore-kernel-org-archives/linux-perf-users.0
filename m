Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0603DD51A;
	Thu,  6 Aug 2026 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002030; cv=none; b=iBKYLVOo/UBmsQk3jKAVB53sJNelVU6s9HrYOTvvlshNktGuATyLleYnVBoMU4WEfuvxVw8PXQlkRQS0EW7Zo7kO9cJPm1zx/AlG2QVE9p6zO3OxFwriupGS/Q9EPGr9xcUdJ1Mhmj7GsOdbtoOlu1+4qyZR9XZndErZcBZVni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002030; c=relaxed/simple;
	bh=uYpRxxLsuoOgiXMcnlJoCbnfQDxqPjPcQg9S9weBlyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfrwtYke9YxDxrcSRmjrpQ72fEm8CVEtWXAObTS7Gnz8QLErPEiy3vOn2NObNEDQzGe40L/AdAqM4e4HpAXmhsNKTECHpDCbk/r57h6gr8AHNmJ5uVHYH8kuucpeCwGZa2LDA+58YxTvSU69fEoReipZfyAOWkPan9LH5intA4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AL4Jw2ly; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AL4Jw2ly"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786002029; x=1817538029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uYpRxxLsuoOgiXMcnlJoCbnfQDxqPjPcQg9S9weBlyE=;
  b=AL4Jw2ly57s000Gy1EuoQaZ2qk/6x6Il0oqxjDTR7mWvRyaAlOrJ8DK1
   1wzD/k5o8LsQIwBqNMlQgV54AS6FSmoMmwdSPLrPzi77+HM6jAHcou9md
   eIlxJc6qONxcI9hiivmq5UsvTyM024/4KIumaPuIGtvWPl2znqUtDnH6F
   G1AH4KVCySx/puG7n8dSpxbxjZ76tyirDdJHZ+kDOVE4PJh4eRtS56wGv
   niLMiA5Nsw1lbwf7Svt1LuY24dvA1TPkO1pFVPT+5M93hoxIuBNq+C1n3
   ZCAkUtsomY/1XUk7UrHiQqupHIDeIQW9APYT2Joz/cqQ7JzebmR0le87e
   A==;
X-CSE-ConnectionGUID: iHw+J4CmQkuwDsKXDDvSxA==
X-CSE-MsgGUID: foV6l3vvSKy9aMbk2fuvpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="74122642"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="74122642"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 00:40:27 -0700
X-CSE-ConnectionGUID: DYGb2ACeTWSp/Yw57ESSyA==
X-CSE-MsgGUID: nYKP2j4ASDeY/ibux4iOVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="264014953"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa004.fm.intel.com with ESMTP; 06 Aug 2026 00:40:24 -0700
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
Date: Thu,  6 Aug 2026 15:47:10 +0800
Message-ID: <20260806074710.2847155-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <anN-livkfPdXq7Uy@google.com>
References: <20260803035220.172022-1-jiebin.sun@intel.com> <anN-livkfPdXq7Uy@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namhyung,

Thanks for reporting this. I reproduced the Python import failure. Although
the loader reported c2c_fmt_free, checking with `ldd -r` showed four
unresolved symbols from c2c-function.o: c2c, c2c_fmt_equal, c2c_fmt_free,
and perf_c2c__browse_cacheline.

I considered moving the formatter callbacks to util/ as suggested. However,
that would still leave c2c, the command's global state, and
perf_c2c__browse_cacheline(), its existing TUI entry point, unresolved.

The issue comes from placing c2c-function.o in libperf-ui.a, which is linked
into python/perf.so under --whole-archive, while builtin-c2c.o is not part
of the Python module. Since the browser is specific to the c2c command, v7
links it directly into perf alongside builtin-c2c.o, under CONFIG_SLANG.

This is folded into the browser skeleton patch; the other eight patches are
unchanged. I clean-built every commit and ran `perf test -v 'import perf'`
at each step. I also verified the full series with and without SLANG.

The `--stdio` support and function-view test will follow on top of v7.

Thanks,
Jiebin
