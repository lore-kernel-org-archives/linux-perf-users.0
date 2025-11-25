Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377E6226D18;
	Tue, 25 Nov 2025 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764056676; cv=none; b=qWcyiglVxZpa6pL8VE59kVqRcGkefhFrJckPs6e73B2LLYlv/l8jqKOdAc+m2E3EZE+r/vLW2yBYinghtdssZJ7ynBws1qpo6jxXosNXndj1VPDKBVvLSDFD1lqEwhYfvdZ60PYH6JwfDcy5vuVWb3uaM9PaE34R5XCLpaFNESk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764056676; c=relaxed/simple;
	bh=Wm90iqCzTdbklOvC6Gk9dh3F9gBpqBFcbxEfjY+YBwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WaRlvIdUkKQGAnAGmN7l/VjEnMX4tK/5qX8hsajQonHMW5MREWgQEulvWqJOH4qVmcsw1GQ7uuwihAdMUdVJc1xoY4TmErppFv80VjgTg4kaQa3VboOSy/QewrULYBFznTHFn1BBYX6secQmqVj0DxFvTpCckdXggszu4pLjc10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xs/PEYbl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xs/PEYbl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764056675; x=1795592675;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wm90iqCzTdbklOvC6Gk9dh3F9gBpqBFcbxEfjY+YBwg=;
  b=Xs/PEYblM2QHkI3FTmYQWWKFm0Jjb1OktFgfzvKZUNfOLmpGlnpUCzz3
   SZkvUjgLBlbmSJcdK34r8zwoPChVN+cV1j0mC7SzEAFxOV/jFFbqCrqr7
   i2LxLvn5x3SXmgxyc3+QnLc5wKPKvdwhV4JznclygAQJFp6ORLjK92Cxz
   G0/p0Ab4gNjeO5ra5l1QzHGZrV3690y+W7shUswLt2AxAzuBeBWTIXS9G
   nvnt1SdC1lAuywQ6cqatCxJddMktPkUS7ohm/UEv2uLBA3QJhz7c2gP4J
   HJKT4bnlxDysbrbmd+XZfcPcccGV2r/D1nYm+EmDRncp8B4LQgn77YPyc
   w==;
X-CSE-ConnectionGUID: U9EG5HTmRK64ISuJ1j4cXA==
X-CSE-MsgGUID: hqJHeZPfSX6qxJCSK9emnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="77178445"
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="77178445"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 23:44:34 -0800
X-CSE-ConnectionGUID: SI73HCNlRMy34c0SIjxYtg==
X-CSE-MsgGUID: xSOymkxFTg6qhsGY7ffvCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,224,1758610800"; 
   d="scan'208";a="229845163"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.213]) ([10.124.240.213])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 23:44:28 -0800
Message-ID: <e224b118-6595-4f03-8aad-862e47fde5fa@linux.intel.com>
Date: Tue, 25 Nov 2025 15:44:25 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] perf/x86: Add Airmont NP
To: Martin Schiller <ms@dev.tdt.de>, tony.luck@intel.com,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, fe@dev.tdt.de
References: <20251124074846.9653-1-ms@dev.tdt.de>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251124074846.9653-1-ms@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/24/2025 3:48 PM, Martin Schiller wrote:
> From the perspective of Intel cstate, PMU and MSR the Airmont NP
> (aka Lightning Mountain) is identical to Airmont.
>
> This changes are taken from patched kernel sources of the MaxLinear SDK
> which can be found at https://github.com/maxlinear/linux
>
> Martin Schiller (3):
>   perf/x86/msr: Add Airmont NP
>   perf/x86/intel: Add Airmont NP
>   perf/x86/cstate: Add Airmont NP
>
>  arch/x86/events/intel/core.c   | 1 +
>  arch/x86/events/intel/cstate.c | 1 +
>  arch/x86/events/msr.c          | 1 +
>  3 files changed, 3 insertions(+)

The whole patch-set looks good to me.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>


