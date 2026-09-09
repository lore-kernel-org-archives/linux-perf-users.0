Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C3A33F58D
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Sep 2026 02:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788922506; cv=none; b=HnavJygM98ZP55s/c+js4E0TJL/FKmgNeTPVzWeWImYQ1+ZMEwZpMxxiXcu79nnzuh2Te352Tidc4cRMUH5r96Ae4PV4zHoV5WrkqW3Tn7u6zMWMQ94HqTjxTV/lZUkq+/t+3xulyRo0Xl3DBIR4s+HlfZEfciBi2qF7BdYkr3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788922506; c=relaxed/simple;
	bh=ILlGEZWS4zWhWLicBHsWUrwrSlTUZxVI5xN7x10oX4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxcME9oTPP0jP9jOPqw+v4mQSci3eY19JKNNST/m9jbYRg6Sz7W0Vxfc5xHLjZYWcg71Az1eH1jxTlcnB+td5q5qjaNgzRGHSwzHvki6aV8ArGU1XOWIaA+srNU5k+E327gPM/QMPfbuXJTeqcLo67y3k5+PltCwpof2GAD3G6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eXMEf3La; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXMEf3La"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788922503; x=1820458503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ILlGEZWS4zWhWLicBHsWUrwrSlTUZxVI5xN7x10oX4g=;
  b=eXMEf3Lak3RNO7YQu6/JGVEDeHduXa2PlQWfKxEy8Hkzzg1H9NsomDPU
   soGpaNI0aiVjb02RJjK4i1LJoJGLLRdswNsktEKgsmN9tBFBCGqqRfZ/A
   Cg1WwJ0I2PpxkCTLTzfYSiUxDDuFUujUDzz1h27anKtvMcXcZ/KZVgglD
   FhxwB+54Nzy/y5EVha+frkZHFWKsnZfYagg1Sj7Q1UXi6O0LQFt36y58M
   nhKdUAClHO7r1SxVeY3zirTy3vD7l4g8kdTlx24eatUi641yYzR62bVLa
   u4mU2s4kBPYV27tO5b88ulQcVYt+iX24+HAhtVqfoT9apc7dWUkClRZv4
   A==;
X-CSE-ConnectionGUID: aM6xzcG9QbuooU0RYCdgsg==
X-CSE-MsgGUID: NTULsFKTQvqCHvxOCeyWcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89369050"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="89369050"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 19:55:01 -0700
X-CSE-ConnectionGUID: EgQXaGZrTJaDYzGs48x3cQ==
X-CSE-MsgGUID: cVocuo3RTqCSeKui2fER+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="275317418"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa005.jf.intel.com with ESMTP; 08 Sep 2026 19:54:59 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiebin Sun <jiebin.sun@intel.com>,
	sashiko-reviews@lists.linux.dev,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/4] perf tests c2c: Add function view stdio coverage
Date: Wed,  9 Sep 2026 11:01:52 +0800
Message-ID: <20260909030156.1771188-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aqB8eNXwAvKoiMMR@x2>
References: <cover.1787283281.git.jiebin.sun@intel.com> <9bd7a313c9c1d71058e857c320c6d5c30cf4cbfa.1787283281.git.jiebin.sun@intel.com> <20260821055803.74B191F00A3A@smtp.kernel.org> <aqB8eNXwAvKoiMMR@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Arnaldo,

Thanks for checking this.

Patch 2/4 covers this case:

  perf tests c2c: Report skip when the workload fails

It sets err=2 before returning when the workload fails, while patch 4 calls
test_c2c_function_report() only when err remains 0.

I also verified this by forcing the workload command to fail. The script
printed the skip message, did not run the function test, and exited with
status 2, which the perf test harness treats as a skip.

So I don't think any change is needed here.

Thanks,
Jiebin
