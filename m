Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD6330BF70;
	Fri, 13 Mar 2026 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413123; cv=none; b=TuBM+WWSOuozrZWC5VPvT9ESpdkNAVpHbzUT1Jh9ghKKxWXTqycKseoAOajP23pcv103I96kXbDUpvmo5ihL/TV9g0QoR3uKFcTLafyoOgKiRuljwNNmFDn5ghLMxOZ2poCxLwKG/ojuYaSYKbOkUmAWf4CGgnpEJPtANurmk4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413123; c=relaxed/simple;
	bh=XVpvNySNCJ7P6rS4KC6BqpYui1jlInKjWbqQ56AunFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0PZ5/UzGKIbYJips1IFyWmNoo4eTFfq0HUZUk6zzl9e8++KQWL7KtTBbU/pI12UvVPKCVCe50i5cy5ICnkj2BqceZ484I7OtKPWaqOO7oCzzpLFTqskMcUT+H2CQhcJkNO1SzMkQDLb0vLJ922i5ye3bWjiObWzrzdwr++7vTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 978991CC4;
	Fri, 13 Mar 2026 07:45:14 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F0063F7BD;
	Fri, 13 Mar 2026 07:45:20 -0700 (PDT)
Date: Fri, 13 Mar 2026 14:45:18 +0000
From: Leo Yan <leo.yan@arm.com>
To: Mike Leach <mike.leach@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
	acme@kernel.org, leo.yan@linaro.org, peterz@infradead.org,
	mingo@redhat.com, will@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@redhat.com,
	namhyung@kernel.org
Subject: Re: [PATCH 2/2] perf: tools: cs-etm: Enhance raw Coresight trace
 debug display
Message-ID: <20260313144518.GN4153946@e132581.arm.com>
References: <20260313132129.2743468-1-mike.leach@arm.com>
 <20260313132129.2743468-3-mike.leach@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313132129.2743468-3-mike.leach@arm.com>

On Fri, Mar 13, 2026 at 01:21:29PM +0000, Coresight ML wrote:

[...]

> ETE trace output changes from:
> 
> Idx:0; ID:14; I_ASYNC : Alignment Synchronisation.
> Idx:12; ID:14; I_TRACE_INFO : Trace Info.; INFO=0x0 { CC.0, TSTATE.0 };
>                Decoder Sync point TINFO
> Idx:15; ID:14; I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.;
>                Addr=0xFFFF80007CF7F56C;
> becoming:
> 
> Idx:0; ID:14;[0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x80];
>               I_ASYNC : Alignment Synchronisation.
> Idx:12; ID:14; [0x01 0x01 0x00 ]; I_TRACE_INFO : Trace Info.; INFO=0x0
>                { CC.0, TSTATE.0 }; Decoder Sync point TINFO
> Idx:15; ID:14; [0x9d 0x5b 0x7a 0xf7 0x7c 0x00 0x80 0xff 0xff ];
>                I_ADDR_L_64IS0 : Address, Long, 64 bit, IS0.;
> 	       Addr=0xFFFF80007CF7F56C;
> 
> Signed-off-by: Mike Leach <mike.leach@arm.com>

LGTM and I tested it:

Tested-by: Leo Yan <leo.yan@arm.com>
