Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82587314B6D
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 01:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784252612; cv=none; b=uOF6uY8jZQUgSqTxFeaWzf2PFeFfFRsr1inozztkXt3LLGw88lQ03Rqv6GTfpb/Fz4wShSmgs+vP2XwHPAgtqMv0q+p8TgN9IqK2veYoebBEuXTqkpU50OeXjHaIVSwWuGmKvD1TEm8eBqtoIqZyPdMra0JdZff2BPbT7hOqowA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784252612; c=relaxed/simple;
	bh=SJe6K4EVV88SB8cuhIEnZVflO/QAKz9EH1yeTdwJ3cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAaTEly+9+/oaugQRLLJuq9ASU+oYH5ct+qVA8Zyxs8S694n+qYMRFIp1MSeBvajAJ7DisFpSN9UsRbEt4GHKyMRFZjn1c7kO8bQb+9W0AHtrL4CW57AlebEn3VAv/p3U6HMqJC93UdgmxwRvvhDhmlLjnDJkYiyBQS2l4idyFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKCFvlG0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKCFvlG0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784252610; x=1815788610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SJe6K4EVV88SB8cuhIEnZVflO/QAKz9EH1yeTdwJ3cQ=;
  b=EKCFvlG0xqL5HbgYh9eSaUIOGtaQ6GyJ5lZJEMPiMT9xg5sJeEKMtybQ
   JjQXznlHIqQDPHkZxjdMEPLJ7RHhAQmvAAXDaOjEfHy5XYXv732lzmtcc
   2BrI4lcw6QxV64t0WuuNmOWGaIMtvIMzngJ+lCPFhj2MGgvIC1pyDfxqG
   pXznspZGrJjJeOPW4K2fSULhLC9fiN8bDqblgZctvezkgEXgIUz83EmOf
   CsICkACdkKfLdl7nwBuSfeTof2vZGl8GYy2IglODKP1Qz3UOeqNlaKUVS
   j9JwUdCUvjdHyz+mqRpNnL0bhrXubNNli+wVHVA1hrwi+dGRerJZCJ6Pr
   w==;
X-CSE-ConnectionGUID: zWIkLkMiR3e6OZAMEwlAiQ==
X-CSE-MsgGUID: bO/OEkrUS82KhlW7THPPmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="96435535"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="96435535"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 18:43:29 -0700
X-CSE-ConnectionGUID: luTSXsIUR2GyuWDn9Ik5rw==
X-CSE-MsgGUID: ndLaIka8S4WISw4eGwNQsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="254886712"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by orviesa006.jf.intel.com with ESMTP; 16 Jul 2026 18:43:28 -0700
From: Jiebin Sun <jiebin.sun@intel.com>
To: namhyung@kernel.org
Cc: sashiko-reviews@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	Jiebin Sun <jiebin.sun@intel.com>
Subject: Re: [PATCH 01/14] perf c2c: extract shared data structures into c2c.h
Date: Fri, 17 Jul 2026 09:43:33 +0800
Message-ID: <20260717014333.1614940-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <alkaBTSMVXPWMJW6@google.com>
References: <alkaBTSMVXPWMJW6@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Namhyung,

Thanks, agreed.

> On Fri, Jun 26, 2026 at 07:13:52AM +0000, sashiko-bot@kernel.org wrote:
> > > -static void fmt_free(struct perf_hpp_fmt *fmt)
> > > +void fmt_free(struct perf_hpp_fmt *fmt)
> > ...
> > > -static bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
> > > +bool fmt_equal(struct perf_hpp_fmt *a, struct perf_hpp_fmt *b)
> >
> > Since fmt_free() and fmt_equal() lack a subsystem prefix (like c2c_ or
> > perf_c2c_), exporting these generic names to the global namespace
> > increases the risk of collisions during static linking or Link-Time
> > Optimization with other perf tool objects.
>
> I think this is a meaningful.  Even without collisions, it'd be better
> to have a prefix for global functions.

I'll add a c2c_ prefix to the exported functions in the next revision:
fmt_free() -> c2c_fmt_free() and fmt_equal() -> c2c_fmt_equal().

Thanks,
Jiebin
