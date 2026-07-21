Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B47426405;
	Tue, 21 Jul 2026 07:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617406; cv=none; b=aLJ9OArZ0jDD5UFogeLztVS2uk0thDzrinTZNuelz3YvE196Dp4h2T2HQwBzTTvghuO527NNwP9XRoJxcPOtMTFEiv47y4NCfOAUmLtxVRLjBY8TcHIfDRKHsZ5lhigHvX2mY5inly49sbq7Z6HroQzSAAQs5ud6HeT7HRJUG8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617406; c=relaxed/simple;
	bh=hW9voRyRswgcbOo8h71JDY0MlvjsgfyhzTwjhQRvSa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ia3sbCUgsaoHjvleQpSCdiVfjxJ28QKyNofXoFLUP3LPNhJZK4UHtfxo9sUIM58MPTyH++91rR6X5i+Zzof+baRENRTVHeOYOyuOxsTH1Ir75A6rBeKVbFnLYs3RWNhj2uKgGbEphVaLIaExoR1mouUmOxYmSoP49gxdpiUazb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdjcXs+M; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdjcXs+M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784617404; x=1816153404;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hW9voRyRswgcbOo8h71JDY0MlvjsgfyhzTwjhQRvSa0=;
  b=UdjcXs+MiQPyUym49zwrBiirv3Bro6PL5TZqlv49sRuyA/ucupHCHOUc
   dbpW4TWuE1nImHsJRloBMJ85FJMCiaNV2xTDASZl7j4Rcm+O4UfYp+LEJ
   Vv9JHnSh0dap8wJsgy19Ckng6zD9mMCoIgo21EjC3rd/Ae+Dzn6u7Nd4y
   eCDVAnjSRrfSTdansGHVV/CsYrbPJaz+Xh+NaStucaQC5oeZuz6ocCNQU
   yYI8K+4Ms6FIFWDJWyW1eHPUg/LYZUXdFNqNAKtSzK6Jqis62vdzkmwU5
   maAzRbmw34iNnexSbj1CeK7jaqpb8rGhrIOKXQAxDPb8hhJGUZq1A0GIA
   Q==;
X-CSE-ConnectionGUID: cPfIsAHNRZSmDeVhA2ouEg==
X-CSE-MsgGUID: PxYtC5yHRtu8CY22U20wXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="96717551"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="96717551"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 00:03:18 -0700
X-CSE-ConnectionGUID: lssb6bu7SNmkAvbLp8qA9g==
X-CSE-MsgGUID: DgFL//qMQwywZYMLtiDRbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="255036532"
Received: from abityuts-desk.ger.corp.intel.com (HELO ahunter6-desk) ([10.245.245.17])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 00:03:04 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 0/3] perf/x86/intel/pt: Fix stop/start with no update
Date: Tue, 21 Jul 2026 10:02:51 +0300
Message-ID: <20260721070254.13557-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Hi

Here is a fix for Intel PT.

There are 2 preparatory patches with no functional change intended.

The fix is to prevent nesting of perf_aux_output_begin() which
triggers the WARNING in perf_aux_output_begin():

	nest = READ_ONCE(rb->aux_nest);
	/*
	 * Nesting is not supported for AUX area, make sure nested
	 * writers are caught early
	 */
	if (WARN_ON_ONCE(nest))
		goto err_put;

The nesting happens when Intel PT gets throttled.  See the patch for more
details.


Adrian Hunter (3):
      perf/x86/intel/pt: Factor out pt_config_enable()
      perf/x86/intel/pt: Use bitwise access for PERF_HES_STOPPED
      perf/x86/intel/pt: Fix stop/start with no update

 arch/x86/events/intel/pt.c | 96 +++++++++++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 31 deletions(-)


Regards
Adrian
