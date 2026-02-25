Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379702236F7;
	Wed, 25 Feb 2026 00:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771979753; cv=none; b=WMtqA/TH2HmQk0BeBNeyTBohNsnu7pCwC2VVHvCkCUJ8v6eqVkmcak8yegX3h7b2eFF01RpeMQ+iV46lqdtWxY1uEAbdtP3N0XKBLiT1DsK+jYBPK8aomtKykcnKj9tvulvSzlyfrRPKpQkx1wdMYd6RSKmnC7VyWWFaZHuze44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771979753; c=relaxed/simple;
	bh=dRUVKpKFtP+4Ei0ETEVYyWVzHp31NhGbwyGgfBDuzJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMJTkgozJTyyJBo+UxgRPBiEhAbZ2CpdkO3K6t8Y81/eSy2uBeaI5+mKzl47kIX3jKFMkSoe97MYcGj2Cmt3PmvfXtGdzVZ/xH4iotnx2pmn90GtAMBAt2c7FfGdxEwhP5Z9OHDjq6DxoxRMETObTSDPo8tZ09ZtJdE1la+kXPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dR34uLJl; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dR34uLJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771979752; x=1803515752;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dRUVKpKFtP+4Ei0ETEVYyWVzHp31NhGbwyGgfBDuzJw=;
  b=dR34uLJlu2NvEQplhZp5hImwWarkDruzSuDpeohie3phl5QEzVlNuiP7
   WRwMQ9tq/u2POmt/k9u8SxB5ESt0fxggo61hrHislV1JKzL2Jh1Wh9yRw
   JGH2KzY4+EhG5oHzC51IAibVZPwMTlwAyWwwB11GWI6LRqxaGbjq8LcQU
   2PIVvuOzAc2VJ2tAPRpuxom2+3bTALKLxiZVvjVH1iMNPSofeBUcKFy0n
   cNgyPTV1N9hlcER0F7ILn4QP2l21osaYThyPQfvUCPm7yTgEcdRVKVeI/
   g3vdUBcX0IhmDqIPdYVE5xhtSuF0Yr93MJlic/JCDNNKUua7X5crEUO0S
   Q==;
X-CSE-ConnectionGUID: L4kZdxWTTHu0la/jQyBe6w==
X-CSE-MsgGUID: Rs0wYvKKRNW5zPrMEJAjhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72220237"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="72220237"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 16:35:51 -0800
X-CSE-ConnectionGUID: BnzbCsm1RNOviryznc5vEw==
X-CSE-MsgGUID: 76aoQmYKTI2pwPevj5JCww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="216208675"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 16:35:47 -0800
Message-ID: <6d8c255c-8477-4dd0-bece-48eadca41d30@linux.intel.com>
Date: Wed, 25 Feb 2026 08:35:43 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 08/22] x86/fpu: Ensure TIF_NEED_FPU_LOAD is set after
 saving FPU state
To: "Chang S. Bae" <chang.seok.bae@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
 <20260209072047.2180332-9-dapeng1.mi@linux.intel.com>
 <5c3ea318-4543-42a4-9b81-7a1da0b8bed1@intel.com>
 <57ef5e60-505e-4ae8-944d-fd630e168af1@linux.intel.com>
 <4748c787-0eb9-4b44-a8f2-0fa18395a78f@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <4748c787-0eb9-4b44-a8f2-0fa18395a78f@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/25/2026 3:13 AM, Chang S. Bae wrote:
> On 2/23/2026 9:35 PM, Mi, Dapeng wrote:
>> Thanks for the reminding. I would add a "Closes" tag here.
> But Closes is for a bug fix:
>
> Another tag is used for linking web pages with additional backgrounds or 
> details, for example an earlier discussion which leads to the patch or a 
> document with a specification implemented by the patch:
>
> Link: https://example.com/somewhere.html  optional-other-stuff
>
> As per guidance from the Chief Penguin, a Link: tag should only be added 
> to a commit if it leads to useful information that is not found in the 
> commit itself.
>
> If the URL points to a public bug report being fixed by the patch, use 
> the “Closes:” tag instead:
>
> Closes: https://example.com/issues/1234  optional-other-stuff

Ok, thanks for pointing out this.


