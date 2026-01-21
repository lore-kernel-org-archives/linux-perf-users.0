Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292153A9D8F;
	Wed, 21 Jan 2026 20:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769026088; cv=none; b=glOMxFE406fRUMdfzKsbHHgHG7UQZ7rZU5gN2dJiNQ8cXzRJxvWYFh8LbP7gP0rNFBb3sIQfk3LZPtaRdvkl2gtmeC7oL+7sDnQpbJ02vwrcTKhA3ZoNSFFy1Tue06tFVDa37+HzZoVVbvDGf9C1eugaMIrX3zAEHcQ9DHBQiwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769026088; c=relaxed/simple;
	bh=OaCXhNLY+714b45sFlRGOUce1pgNelCmICycCWCZ7CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evU9QTrDEv03QbqWOOWiuFtRbAFlrxwUhP0sNOzn/5NiFzaOSgR1QN94cJDY8LuN9yislrBhRHUpsnDpKqzBcUaGdH2bxYotZQkko4T/y6Rt2NDDPfPU4ra2yKjlmA4saHvDsX/zL5Hn3BXjMo5kzGBT6fsJtx488P6bJxpS8EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSAch2kN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSAch2kN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E224C4CEF1;
	Wed, 21 Jan 2026 20:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769026087;
	bh=OaCXhNLY+714b45sFlRGOUce1pgNelCmICycCWCZ7CQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OSAch2kNVClSy8H3bi2yS6rhuULqaMosKVZ61+fHT0z7GSt+tQGzjVN3Rhj8yI5Es
	 AeF20EeuPMLn/DB78wk3UcZv6WWDatE7Z+Su/NSnS6oKHmUac2Tir1OQ4AJ89ptPc2
	 rWMAmeJN/816w1E4jgVdd8m6e6TlFqiSl4vapwg9lrhYx2CXhQBb+DNUx+AE/kDYnM
	 +1MIaXj1Mzj2KNvRUzws+oxRyNg6lY5v8nNTlyiGrbkf6eowKKJkCqTq+t0oThqzRI
	 CGADg/MHq/3FrlUr2ZlfagMIzNLknHqIhCv87Y02ux4P1itWZdiORu3Nmd8HQu44cU
	 OXcweyDrcKtyg==
Date: Wed, 21 Jan 2026 17:08:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ian Rogers <irogers@google.com>, "Chen, Yu C" <yu.c.chen@intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>, ravi.bangoria@amd.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, rostedt@goodmis.org, vincent.guittot@linaro.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
	tj@kernel.org, sshegde@linux.ibm.com, ctshao@google.com,
	quic_zhonhan@quicinc.com, thomas.falcon@intel.com,
	blakejones@google.com, ashelat@redhat.com, leo.yan@arm.com,
	dvyukov@google.com, ak@linux.intel.com, yujie.liu@intel.com,
	graham.woodward@arm.com, ben.gainey@arm.com, vineethr@linux.ibm.com,
	tim.c.chen@linux.intel.com, linux@treblig.org,
	santosh.shukla@amd.com, sandipan.das@amd.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, namhyung@kernel.org, james.clark@arm.com
Subject: Re: [PATCH v5 00/10] perf sched: Introduce stats tool
Message-ID: <aXEyJCSqlPPUS9YG@x1>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <6a434657-5b5b-41ec-a79a-c648c2829602@intel.com>
 <20260121163342.GI166857@noisy.programming.kicks-ass.net>
 <CAP-5=fX=QuRw8M4Xco=A8WbBfDSPmyjtQ-JdnBEM-VRdX65_1g@mail.gmail.com>
 <20260121195155.GP166857@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121195155.GP166857@noisy.programming.kicks-ass.net>

On Wed, Jan 21, 2026 at 08:51:55PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 21, 2026 at 09:12:20AM -0800, Ian Rogers wrote:
> 
> > I'm still wondering if we can make some of the /proc/schedstat data
> > appear as tool events similar to proposals for networking and memory
> > tool events in:
> > https://lore.kernel.org/lkml/20260104011738.475680-1-irogers@google.com/
> 
> Yeah, someone with a bit of spare time could make it happen:
> 
>   https://lkml.kernel.org/r/20250703141800.GX1613200@noisy.programming.kicks-ass.net
> 
> It would be:
> 
>  - convert all the accounting sites to tracepoints
>  - write modules that connect to relevant tracepoints to provide the
>    'legacy' interface
>  - convince world+dog to not auto-load above modules
>  - have beer and wait for people to complain about something :-)
> 
> I'm sure there's 'interesting' details glossed over, but I *think* it
> should be doable.

Until then, since you and Ian acked this one, I'm going over it and
tentatively merging it,

Thanks,

- Arnaldo
