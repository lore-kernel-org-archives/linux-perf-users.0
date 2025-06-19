Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D08B11712;
	Thu, 19 Jun 2025 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750349186; cv=none; b=KKIkZKMIZLt4iHU5OibeBX725iPmmfgpfDLKGdMLZcn/rfiFpJ10c6NFiT7KtXU86NfDy7vC9Q7x760/fTmR+/QS729f0sIPeh/jNutogdYWO1wQlhtRC65YvTTAVIAyRthn/Ox2AJoPftnaMTb0o2Fy++mIwGPn5VlcGNknpmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750349186; c=relaxed/simple;
	bh=yMoHW1291rObVibHYCEvUaqI9hYmrFupGCvp1M5Z7t0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SsBP7tNfnSm8NYqbfcv6S397T+S05eVckF0HV2eZSG9KpYZ55Rb9GMbZZpDwLyV01zO/t9fET+yo6S5hGIofu8BuBUxSiTlL9syAVSfVMm3g3JWvgVJOVF2EOKYgbzniGEUztX/3z+kOjgHRBAoxEdWY4309mM2K9Pog1T7qekA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9NksbVx; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9NksbVx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750349184; x=1781885184;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yMoHW1291rObVibHYCEvUaqI9hYmrFupGCvp1M5Z7t0=;
  b=f9NksbVxOiKHcO62cPMMOjC0EjO78xscnFJcVp0Lv2eszZuml88IxoOd
   w78B3XaA+gaF4xzmim8WKn/Op5obIld8ovE4fk4tPJAV0D5yO4jrP2boY
   LszoDqUrtQZ+o3JLXnft9ZmJhEPjbagcwlW8wmOzBD3wdhbTOJiLZRdbz
   rpVw1xfbTNnePjPZjP0jKiAOZnyLZRv06HvKIkpFuObQhw7hfi4mW3Yin
   om01SXqA3QmxORDHmh8OECPdoS7V9omgtsllFH+CZuOcp2npw7r4w48e+
   y1+Ff/yH7bpqGgv22Cd81gFk05GQtR2PWlcbAK6QookMco8JsZU0aRD6Q
   g==;
X-CSE-ConnectionGUID: IvXPQayTRMGhCSSd2Xb1xA==
X-CSE-MsgGUID: 68zBWSv6QbGi/n+s2jbXCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52579308"
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; 
   d="scan'208";a="52579308"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 09:06:23 -0700
X-CSE-ConnectionGUID: eIP4FxqvS8mCM2acgDtxmg==
X-CSE-MsgGUID: AAki5dEzQaGPgEqI58hTCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; 
   d="scan'208";a="187906412"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 09:06:24 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id EADB820B5736;
	Thu, 19 Jun 2025 09:03:05 -0700 (PDT)
Message-ID: <9aee2b65-e43a-4fcd-a929-a98269621315@linux.intel.com>
Date: Thu, 19 Jun 2025 12:06:21 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [perf] unchecked MSR access error: WRMSR to 0x3f1
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <14d3167e-4dad-f68e-822f-21cd86eab873@maine.edu>
 <574b8701-9676-4aba-a85b-724c979b2efa@linux.intel.com>
 <7e8bb736-3955-c479-99de-e08efb494bdd@maine.edu>
 <8739c2c6-a27c-4ab6-ad74-8b95e258737e@linux.intel.com>
 <c04824b5-5697-1de5-0003-f2c5b73ed006@maine.edu>
 <52656281-ab73-baf7-0a80-ebcbe79dfca2@maine.edu>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <52656281-ab73-baf7-0a80-ebcbe79dfca2@maine.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-06-19 11:17 a.m., Vince Weaver wrote:
> On Wed, 18 Jun 2025, Vince Weaver wrote:
> 
>> On Wed, 18 Jun 2025, Liang, Kan wrote:
>>
>>> No, the error message doesn't say it. Just want to check if you have
>>> extra information. Because the Topdown perf metrics is only supported on
>>> p-core. I want to understand whether the code messes up with e-core.
>>
>> I can't easily tell from the fuzzer as it intentionally switches cores 
>> often.  I guess I could patch the kernel to report CPU when the WRMSR 
>> error triggers.
> 
> I've patched the kernel to get rid of the warn_once() and added a printk
> for smp_processor_id()  (is that what I want to print?)  In any case that 
> reports the warning is happening on CPU1 which is actually a P core, not 
> an atom core.

Thanks for the confirmation.
I've tried fuzzer in some newer machines (later than raptor-lake), but I
haven't reproduce it yet. I will try to find a raptor-lake for more tests.

Thanks,
Kan

