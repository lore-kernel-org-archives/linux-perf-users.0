Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7975D2248AF;
	Wed,  6 Aug 2025 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754521935; cv=none; b=X623D7dvA8k/DMtG77gIqmXbuxFh1xffw0fCz75IROXRWdd68/GAL13X7rHzshJo2npLWtMAHcpKR3tuWhCi/iC+DCG3emyyQoOjLFnWcshaaLZOPhabHB7a1VtGYBNHSOLTzmWw8NwODOcUuQxZn4iytchYiOyzVLemkuhwlbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754521935; c=relaxed/simple;
	bh=WxaXz4CFR5v/hKyP3MXIbbteEz8kR7GhwKubO3/GiGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMvrZlBAuAXhKC5lP27lyGMGigICBVhABO1FaPRzBgazM/UVssLJ92Q0ajGf2pjMSXIZP/5PhkOfxJVzUDGyWRwNIsJte7xH1QdqCPILdfKGuglEc39Tb7UMNBdohBA9JfKyFvkH/g8IhgxCamZVOM542i2wEgtLOPS7TjReTfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CLEjILqA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CLEjILqA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA145C4CEE7;
	Wed,  6 Aug 2025 23:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754521935;
	bh=WxaXz4CFR5v/hKyP3MXIbbteEz8kR7GhwKubO3/GiGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CLEjILqAm7JV+772uCIcHVp0BzUXyS48v/xXl4//2l4dh13W4WYy/0ZXZmiIw1Y4X
	 NQ9I1FM5iH30aOF9qEzm7N2Um/ppYnMD/oBCC8HpkMpzk5T0w3xpOhbubxQNBl8dmQ
	 uFaqaEgd9qznZ4sLjLvIYJXmur5SLnHsUzhRbdij6k3xduCi83zdwHCKmCQdRiBMlM
	 FHpZ2RcN9FZXAT3ubzRoWwlz0AwLC+A0KGtvt3pz53Np/1id2Hcpubin6rwVARD+Ny
	 8PhRrFl/iLXiShrhR8nFbRJMQsej40y5AkGBslDgvh4xrbzz34G3JDNt8mn0mxigJm
	 3IDp2fqheJBxw==
Date: Wed, 6 Aug 2025 16:12:13 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: David Binderman <dcb314@hotmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-6.16/tools/perf/util/tool_pmu.c:242: Pointless test ?
Message-ID: <aJPhTRz8B8jIjjov@google.com>
References: <AS8PR02MB10217286997CFA78F802121F39C2DA@AS8PR02MB10217.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AS8PR02MB10217286997CFA78F802121F39C2DA@AS8PR02MB10217.eurprd02.prod.outlook.com>

Hello,

On Wed, Aug 06, 2025 at 06:09:40AM +0000, David Binderman wrote:
> Hello there,
> 
> Static analyser cppcheck says:
> 
> linux-6.16/tools/perf/util/tool_pmu.c:242:15: warning: Opposite inner 'if' condition leads to a dead code block. [oppositeInnerCondition]
> 
> Source code is
> 
>         for (thread = 0; thread < nthreads; thread++) {
>             if (thread >= nthreads)
>                 break;
> 
> Suggest remove if test.

Thanks for the report.  Do you want us to remove or will you send a
patch?  It'd be great if you can send one.

Thanks,
Namhyung

