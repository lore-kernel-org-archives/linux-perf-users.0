Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C4E2F99B8;
	Fri, 23 Jan 2026 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186239; cv=none; b=CwqmV1gJhU8XAjUyLjoVBSHZ+8dyB7b3+UCL+XePQFM9QG0wsV4W6exkKGrScYovDvzFssvc/Ddqy1AjdpjuCm8GRAEE0GwKBVouGT9kXDLbAmfQuIrc7vwvM+C4XHFytCy8Vd8iDBnunn5T+rk/+WVei7oMW1uzkQAtvvF4xzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186239; c=relaxed/simple;
	bh=m3XyhwaDi9apAcPOqLG018Qte9/OKhoe7UOIbU9AoFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxxrZb+tJgcBFN+K15GAuUOlAK/MX9tjC7+o8pFggKZKM6oRcg9ZOOyyvQxAh/Qeo9LTV8Vw8kLelaJREv/TJJf8kT2z6w3yxJCWU1YFGZU9ZDV30KgaU5g1387NsmzyE8bmHdQXlER4cJTTvgn5TVLPsOqQUi7GNDGZBPPp2j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqAus04y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqAus04y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E591C19421;
	Fri, 23 Jan 2026 16:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769186239;
	bh=m3XyhwaDi9apAcPOqLG018Qte9/OKhoe7UOIbU9AoFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YqAus04yKYIou8/xilDK+unjxU9pwhxGdz+vok1aD86fjuW2K58bekczkukbkpTg1
	 CdvpPBjCJ+GIuuAn39rCN/4A7ZGkvKs+uLMs1DhtoaMZCVL5HJyBb0j+6KzGmcbQ62
	 yAMEl92LNGsqaX+r8VqMxiA/APeEbUMcMZIYBBKPpyHlKxS2nd0MAD/n9UX6mi24rP
	 zxTQzYi0tcZmBvTYRuPoiUdEJq8atDw/4aJC/dvpbHHiEEDRyZ4mYxXHEgGow90nBp
	 6jWAcsOgLq16bPMSPBqcStBJECAVUCm6GK0UzeoulPZUa45+p2lUWsCMhfkt/dlBWO
	 KXYOFbSHc5nOw==
Date: Fri, 23 Jan 2026 13:37:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ian Rogers <irogers@google.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>, ravi.bangoria@amd.com,
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
Message-ID: <aXOju9cYoX6nMPA5@x1>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <6a434657-5b5b-41ec-a79a-c648c2829602@intel.com>
 <20260121163342.GI166857@noisy.programming.kicks-ass.net>
 <CAP-5=fX=QuRw8M4Xco=A8WbBfDSPmyjtQ-JdnBEM-VRdX65_1g@mail.gmail.com>
 <20260121195155.GP166857@noisy.programming.kicks-ass.net>
 <aXEyJCSqlPPUS9YG@x1>
 <20260121201034.GC171111@noisy.programming.kicks-ass.net>
 <aXJJirXQ9jsnewn9@x1>
 <f735d3c7-d3b9-4056-ba76-e0b4e8366356@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f735d3c7-d3b9-4056-ba76-e0b4e8366356@amd.com>

On Fri, Jan 23, 2026 at 10:02:11PM +0530, Swapnil Sapkal wrote:
> Hello Arnaldo,
> 
> On 22-01-2026 21:30, Arnaldo Carvalho de Melo wrote:
> > On Wed, Jan 21, 2026 at 09:10:34PM +0100, Peter Zijlstra wrote:
> > > On Wed, Jan 21, 2026 at 05:08:04PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Until then, since you and Ian acked this one, I'm going over it and
> > > > tentatively merging it,
> > > Thanks!
> > 
> > It is on
 
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next
 
> > Has the two minor fixes to overcome that 'sv' maybe used uninitialized
> > on the error path + 32-bit build, I will move to perf-tools-next after
> > it gets built on all the test containers, later today.
 
> Thank you for the two fixes.
 
> I have a fix for the man page, do you want me to send a separate fix patch
> or will you please consider it with this series?

I pulled it already into perf-tools-next, so you can now go on working
from there, with patches fixing things like the NR_CPUS case, etc,
please add Fixes: tags pointing to the csets where the problems were
introduced.

- Arnaldo
