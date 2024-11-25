Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62F918872F;
	Mon, 25 Nov 2024 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542096; cv=none; b=Q8JGkBpVFk9idxWRZvZIu4QCIHe+vf1rXl0bNr+xf8U6uAgnMyJh78/Zh83Jexoz7wu2yXCf3IkpWVyJHOB2P30PsT8HmXrH0pUIFasM07oCAdccgWGmiaGbykkwGjDqelp6g+f/tzT1FDOGMTIND0u5Xs2Stax+auxxSUvH7mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542096; c=relaxed/simple;
	bh=gmh8u5fmTOhVEwnQk+QVm4d4/vdvrfXAcKp9kKoQHJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9AKrMjGIlzS6jFsF6qjaDmkOSj0ZQd8iQvrF5KVDWNVhiLxwo5iU7glzTksvs/Lmxqj6EOSDSnI6tvVI1xjpgUKH8PCyPlz4F27TEHk9zrXRBzAaA6bRNAcQUIi3JzuBkO566LWXmmTdBKTZjfe4Tj11g+GL6QSea70/xFRzbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DIGJmEUB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DIGJmEUB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NUza1fQdfVZ8WT0a3jXWk6XdwOIL6+LMHU1LXuCQ2E8=; b=DIGJmEUBW9wfo3TGgFrwNniyDc
	YxCoxwxp/98UxAgbPSDVZ4m9tVxkSmJ6fvkEOEPQWEktlc5hoj4EAM50mW2ytEoEN0bg7kLpCKJBh
	QNhhIZ/Jb3M+WcXkROyK/DH895TIhf+3LY/tvcPTH9jTShOiPOFWcMJsgvye1koC2MKQ6zuhYVq9T
	viF/N9+dyE9dc0xf5Zr3y4As4IHEF8f2lfxl2n4uZ+IDQnhu0sgzfRvY5aOxf/xTYiP8PdWzr2+RU
	R3S4dWB9FQS6jkHlyEVOLO99VpAR3yYH8krG75NGIWd1nAf1GXGEyr7p0jSCC0jyhMmOcnQVVbCVW
	aLnMhiHQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tFZL0-0000000BvUW-24RM;
	Mon, 25 Nov 2024 13:41:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1B76430026A; Mon, 25 Nov 2024 14:41:15 +0100 (CET)
Date: Mon, 25 Nov 2024 14:41:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Sapkal, Swapnil" <swapnil.sapkal@amd.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, james.clark@arm.com, ravi.bangoria@amd.com,
	yu.c.chen@intel.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
	tj@kernel.org, vineethr@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, santosh.shukla@amd.com,
	ananth.narayan@amd.com, sandipan.das@amd.com,
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v2 1/6] sched/stats: Print domain name in /proc/schedstat
Message-ID: <20241125134115.GB38837@noisy.programming.kicks-ass.net>
References: <20241122084452.1064968-1-swapnil.sapkal@amd.com>
 <20241122084452.1064968-2-swapnil.sapkal@amd.com>
 <20241122111253.GR24774@noisy.programming.kicks-ass.net>
 <fcefeb4d-3acb-462d-9c9b-3df8d927e522@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcefeb4d-3acb-462d-9c9b-3df8d927e522@amd.com>

On Mon, Nov 25, 2024 at 06:01:16PM +0530, Sapkal, Swapnil wrote:
> Hello Peter,
> 
> On 11/22/2024 4:42 PM, Peter Zijlstra wrote:
> > On Fri, Nov 22, 2024 at 08:44:47AM +0000, Swapnil Sapkal wrote:
> > 
> > > schedstat version has not been updated since this change merely adds
> > > additional information to the domain name field and does not add a new
> > > field altogether.
> > 
> > So I don't care much either way, but if an existing tool is trying to
> > parse the domain number, it might now get confused by the extra
> > characters. I know of no such tool, just being pedantic.
> 
> I will change the schedstat version so that it will not break any existing
> tools.
> 
> However the domain name is under CONFIG_SCHED_DEBUG and thus incrementing
> the schedstats version is not sufficient when this config option is
> disabled. Is it okay for you to move domain name out of CONFIG_SCHED_DEBUG?

I suppose so..

> Previously, I sent couple of patches to change the schedstat layout for
> * Correctly accounting the different types of imbalances [1]
> * Accurately computing the task hot migrations [2] (This was your patch)
> I would like to include these two patches that better helps justify the
> version change. Is that okay by you?

Yeah, sure.
