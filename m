Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BD81096F;
	Fri,  6 Feb 2026 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770336609; cv=none; b=CRlv6gADkL35Hh8ekPKR0XGE2W/edGzajpAeeaZwMofvRGjjf9mzi6jgxOVq4CqbElOD8+6BiXy5CUa31J3lrdFNNK6ZQ+Zqf/4k8SkRvtUjfMz7ei8hp0wH6tA+nukgIGzeOBDxGdwdY5EdBKUjLKRLv4KRWG+gjKapoRFKQZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770336609; c=relaxed/simple;
	bh=+pFEML2PiraPiHHfFCqW+JhKEsvrbi51n+BJJjqPfRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GevgnCIHM0RQWhyu3VeqSm+CW0UKHIYdqVpBr1VPOLOS/FbMP3/9U6NeaOC6BJUhuWBcADtpsaGbwKo8n3xDr1EEuxdNDHYPZdLFeWc2tFzbMtcAZelAbSB8CmqLbv8UMJFsddCeX8vEDGvjVBP5Kd4ugDnqKHwMvkp2xgG7IYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+4fjSpy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+4fjSpy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770336609; x=1801872609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+pFEML2PiraPiHHfFCqW+JhKEsvrbi51n+BJJjqPfRg=;
  b=U+4fjSpyjQLiuOWBRf4hAXZeEyPLg7G6cGhcg4HgLEoWoZZmUZfilKfz
   OZRWJjvV/96VsoL/vU3hbZtua/vFYCLk6mLD91+srz9QUVCOUELk0icpb
   e+aW2lLOla7crWI2DBJtTF04xKqBtMn5gBFTnXYWfh4PoVzgAC0hGpDmj
   OI3GadFriDtbqKnDvHVI6tmJtK2HltgOAoiS7IYnDnRbTBJCwFgVxnzDD
   raPf1K+YX43isIAylI26KEXq+qvTbR6ONNdUzcPdItdEogDnXpFO8SdG8
   CWLFlaJisaeGqs60hvFb07aG8ZI03FwcRIN0f7xC53IKEgGoUgrQi2k6V
   g==;
X-CSE-ConnectionGUID: v/cQlYYbQq+SQtVbbaLg0A==
X-CSE-MsgGUID: BRWOVCCqS1+Vt0Uv/tDbLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="89127434"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="89127434"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 16:10:08 -0800
X-CSE-ConnectionGUID: goR9OZNKSdWlLCjOThLAKQ==
X-CSE-MsgGUID: NVOxrhNdThGByvoSFjUnwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; 
   d="scan'208";a="215681722"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 16:10:08 -0800
Date: Thu, 5 Feb 2026 16:10:03 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Weilin Wang <weilin.wang@intel.com>
Subject: Re: [PATCH v1 1/2] perf callchain lbr: Make the leaf IP that of the
 sample
Message-ID: <aYUxW9JngVyE74jr@tassilo>
References: <20260205205622.530825-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205205622.530825-1-irogers@google.com>

> Signed-off-by: Ian Rogers <irogers@google.com>

Makes sense.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
