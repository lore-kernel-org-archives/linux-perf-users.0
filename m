Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D911917F1;
	Wed,  4 Jun 2025 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749050284; cv=none; b=NYB6FLCzBhJ9lJKYBXd4NX02x8gCuXMfAAMJJ9gl9UUusHvasZ/RHJmSUjmGitBMd5d0/7cF2c96wAx8kwzLOTkF89m3Nl/x0JNlDzpUrhm+F9bdHjW2Xi4+pF+Si+qqYPR5SMB+vAZCMQS6HBMZy+4n3VmY32qFr+Mq+ETGltQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749050284; c=relaxed/simple;
	bh=s5zmxv3LU0w+4sopd0Re0HC/bbjNa73HY3q0HOETc+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qscfGIBr5oIVE0VSwq1OGnGPFJ7IBGYMAF4zP0/DCLgd0BIargl4QVn+Kf9pD2QQPdc3ZB+Djyb0h3vcyWXCF7TWCX15POY90TROWzRTeAUmFB9ceKf3oS5aQbnuSo1e1FaJixQqsT0gaH+U68Dm2k+c2ANZeYl5Rmedy4UHyxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D9601758;
	Wed,  4 Jun 2025 08:17:44 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAB493F59E;
	Wed,  4 Jun 2025 08:18:00 -0700 (PDT)
Date: Wed, 4 Jun 2025 16:17:56 +0100
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <20250604151756.GD8020@e132581.arm.com>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
 <20250603140040.GB8020@e132581.arm.com>
 <20250603144414.GC38114@noisy.programming.kicks-ass.net>
 <20250604080339.GB35970@noisy.programming.kicks-ass.net>
 <20250604101821.GC8020@e132581.arm.com>
 <20250604135801.GK38114@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604135801.GK38114@noisy.programming.kicks-ass.net>

On Wed, Jun 04, 2025 at 03:58:01PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 04, 2025 at 11:18:21AM +0100, Leo Yan wrote:
> 
> > Totally agree. The comment would be very useful!
> 
> I have the below. Let me go read your email in more than 2 seconds to
> see if I should amend things.
> 
> I'm not sure doing the INACTIVE->INACTIVE cycle in the ASCII art is
> going to make it clearer, might leave that off. But yeah, possible.
> 
> ---
> 
> Subject: perf: Add comment to enum perf_event_state
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Jun  4 10:21:38 CEST 2025
> 
> Better describe the event states.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/perf_event.h |   42 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -635,8 +635,46 @@ struct perf_addr_filter_range {
>  	unsigned long			size;
>  };
>  
> -/**
> - * enum perf_event_state - the states of an event:
> +/*
> + * The normal states are:
> + *
> + *            ACTIVE    --.
> + *               ^        |
> + *               |        |
> + *       sched_{in,out}() |
> + *               |        |
> + *               v        |
> + *      ,---> INACTIVE  --+ <-.
> + *      |                 |   |
> + *      |                {dis,en}able()
> + *   sched_in()           |   |
> + *      |       OFF    <--' --+
> + *      |                     |
> + *      `--->  ERROR    ------'
> + *
> + * That is:
> + *
> + * sched_in:       INACTIVE          -> {ACTIVE,ERROR}
> + * sched_out:      ACTIVE            -> INACTIVE
> + * disable:        {ACTIVE,INACTIVE} -> OFF
> + * enable:         {OFF,ERROR}       -> INACTIVE
> + *
> + * Where {OFF,ERROR} are disabled states.
> + *
> + * Then we have the {EXIT,REVOKED,DEAD} states which are various shades of
> + * defunct events:
> + *
> + *  - EXIT means task that the even was assigned to died, but child events
> + *    still live, and further children can still be created. But the event
> + *    itself will never be active again. It can only transition to
> + *    {REVOKED,DEAD};
> + *
> + *  - REVOKED means the PMU the event was associated with is gone; all
> + *    functionality is stopped but the event is still alive. Can only
> + *    transition to DEAD;
> + *
> + *  - DEAD event really is DYING tearing down state and freeing bits.
> + *

LGTM:

Reviewed-by: Leo Yan <leo.yan@arm.com>

>   */
>  enum perf_event_state {
>  	PERF_EVENT_STATE_DEAD		= -5,
