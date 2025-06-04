Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB8813AD1C;
	Wed,  4 Jun 2025 12:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040659; cv=none; b=SJ5wliPd7sxtFFW69prdhuWI+mk+wSmmdYl5G4nHuRq28LDQDFb3+WECbaUxQmr7rnWx+GNOr5CXLvHOLi12uBU+tSP8eBRhFDrxWOXufBiaKarfE3Tc20uKprakad2+FvW2NIAGnG1GlOcSHij9/ksM7qEeiXBhwCOtFpcXoMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040659; c=relaxed/simple;
	bh=OdkD+MODyORjWGw/yjTomTLFd2F+IeytQ1n613BMIAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGrVLFjrRsmk7pqdUIgiRbcZKF0HMVFn/GGASeACy9oyBJCDfFr7Vgs8KCw3If1J4GW/wVN0S4208kentAngj8ZaVJyjpL0EETZVwxurYN8qVk6A1jIkcHlZSepuiA84JSp7rysVXhXlzTOsYoq5uHM6BIxZ7Sg4p2tOVmXhKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iryXm66a; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iryXm66a"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=egLrzXjNAUuKfQLdddD0K8slsgz2ryPJgQoyPWELHWI=; b=iryXm66aJPrn3fFNGyydYrr1z+
	Bf2iWSovX7QI361HrNo/XIL4dEvRJmGnF/Aovhp71kJ1zXQMbqxIMtfpBZo1LW6uHCwNxl3yI5nhN
	4naAUk8KFOBkI+v+1ovLaIorZ5g5NIGFuMh8H3YPlMJJ7yyn6gIm/R1oKUqUzDhlg4BHrAE1iuWu4
	imhLviXGBfjykkntSsd8pGhiPfwaWD6eyPJegIxhaM1fhRl6mD7iBCkdgQxWnWqGDI63QBGg9MgeF
	86DhkDNpWIpWOvCmwPdiazrrF49H1ZdCKiPcVdLBKSmCcYyl8FAgfsnhiOirKl1misILATB1eIkfo
	MgEI6HNA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMnN0-00000000ttB-0yu9;
	Wed, 04 Jun 2025 12:37:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1EA0230078B; Wed,  4 Jun 2025 14:37:25 +0200 (CEST)
Date: Wed, 4 Jun 2025 14:37:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Leo Yan <leo.yan@arm.com>, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <20250604123725.GJ38114@noisy.programming.kicks-ass.net>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
 <20250603140040.GB8020@e132581.arm.com>
 <20250603144414.GC38114@noisy.programming.kicks-ass.net>
 <20250604080339.GB35970@noisy.programming.kicks-ass.net>
 <aEAau+v4qBQSt13s@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEAau+v4qBQSt13s@e129823.arm.com>

On Wed, Jun 04, 2025 at 11:06:51AM +0100, Yeoreum Yun wrote:

> >  - EXIT means task that the even was assigned to died, but child events
> >    still live, and further children can still be created. But the event
> >    itself will never be active again. It can only transition to
> >    {REVOKED,DEAD};
> 
> I have a slight quetions. after parent event set EXIT,
> Does EXIT event should be inherited?
> 
> for example
> 
>    parent task(0, ...) -> parent_event(0, parent_event:NULL)
>      ` child_task(1, parent:0) -> child_event(1, parent_event:0)
>          ` child_task(2, parent:1) -> child_event(2, parent_event:0)
> 
> In this case when parent task(0) is exited,
> parent->event will be set as EXIT state.
> 
> But suppose the child_task(2) try to fork (child_task3) and
> inherit the event (create child_event(3, parent_event:0),
> and at the fork, forking can observe the parent event state as "EXIT".
> In thie situation why child_event(3, parent_event:0) should be created for
> child_task(3)?

Yes. You set out to monitor the whole hierarchy, so any child created
after the first task should be monitored, until such time that you close
the event.

Notably, a fair number of daemons go about their business by explicitly
closing their original task in order to detach from the tty.

Also, per the context switch optimization the original event doesn't
need to stay with the original parent, it can end up on a random child.

