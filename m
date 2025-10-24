Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DD72F1FE6;
	Fri, 24 Oct 2025 07:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291815; cv=none; b=kraM/SrEwkTidm42WsF+lr78AWe3M+rCk/o4UK4PElU3VRlqmVbJxmqNx7jOxE2qX/eCpNdpbtKtC0FxyCGds1TVnhQw4O9eZDoM/Gpmnb6vk0bBTtARquGA4DQBVJXuOXY1HxZPHu//Vb3BlJYfQcGjCb+61/Y3DhTpxNtmYIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291815; c=relaxed/simple;
	bh=TDKLk7ury7RzxFqK59JRhpHgNK8TI1jgXu2IzIXiwuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XaVsxh84wA3ZIvlI46L6fs0r84DJCi7BFZMZMHLJkNe9eDZQArroAWNqH71bKfex7OP32POUmOu5gun1eptKi/T1NWfIaMqw7kaRHxkK9MixnQImD1LqiKEasvyG6Vvjl7tSWBMtH8mF/o6Nz7dKUZLFLLNMzWR9O7NFmm3Y0R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c9wwdjZM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9wwdjZM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761291814; x=1792827814;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TDKLk7ury7RzxFqK59JRhpHgNK8TI1jgXu2IzIXiwuE=;
  b=c9wwdjZMvdBxOUooltqKGLZaP5Ssm+A/FKcr3YH1vcQXXEKOZyQanXMd
   0iuL6xsJvpq0+mH+N+TRBGFfAPY2xikRdmWP2VuBaQP2QqrY5XpYQFf8A
   WFtjZdfbBtk6WsVwRTx56cq1Ev7JO1wjb+oQmeeu8re2LRN+yydrjtphK
   q485t5zMxBIQevAMBw/1Hdv+kozp8UQ//+qvpxKD5xv7MTAX3ZLsBHtEu
   VrYhfidFJ6lSiGVzkL52/UtgrHrsYeFhTBTce9T6dVXg/yrjLARX1X7hU
   Ae0St+JH8Gv4zXR6UZONFGxan9WhXLH70dHgRhfzFLeiAUfUYuSa3QoN4
   w==;
X-CSE-ConnectionGUID: H3yd0Wq8RfujMgek8ZhKBQ==
X-CSE-MsgGUID: +duEPUVkSceXKNyPTe6Xtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74590566"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="74590566"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 00:43:33 -0700
X-CSE-ConnectionGUID: icw+zRzxSLuAIknhFlHHvw==
X-CSE-MsgGUID: C/3Yh2FfQMCbPH1zlRVCFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; 
   d="scan'208";a="188425512"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.233.250]) ([10.124.233.250])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 00:43:30 -0700
Message-ID: <8f9a1e0f-10eb-47b1-b543-48045c8747d3@linux.intel.com>
Date: Fri, 24 Oct 2025 15:43:27 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/3] cstate support for CWF, LNL and PTL
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Xudong Hao <xudong.hao@intel.com>, Falcon Thomas <thomas.falcon@intel.com>
References: <20251023223754.1743928-1-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251023223754.1743928-1-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/24/2025 6:37 AM, Zide Chen wrote:
> This series resends three c-state patches that have been posted for a
> few months but have not yet received feedback.
>
> On behalf of Rui, I’ve included his two patches here, so that all
> outstanding Intel c-state related patches can be reviewed together.
>
> There are no code changes in this resend. Only the changelog in
> [PATCH 1/3] has been updated to note that the C1E counter can only
> be read via PMT.
>
> Zhang Rui (2):
>   perf/x86/intel/cstate: Remove PC3 support from LunarLake
>   perf/x86/intel/cstate: Add Pantherlake support
>
> Zide Chen (1):
>   perf/x86/intel/cstate: Add Clearwater Forest support
>
>  arch/x86/events/intel/cstate.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)

The whole patch series looks good to me.

Reviewed-by:  Dapeng Mi <dapeng1.mi@linux.intel.com>


