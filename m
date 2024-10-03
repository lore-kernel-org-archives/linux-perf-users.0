Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8FF824BD;
	Thu,  3 Oct 2024 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993996; cv=none; b=nVj+lCggrfurXJ79/VEWgVMFk/WRSGEg8N5AlMrfi2noBasOVDRr4tEB+TUTnqV0HjgGd+aMxg42Zfk8TTrZ8udz+xVF8PZRdZU3RuXDB0bRi3rU49Nh7VmAZE0hoeZugalxvhASCjy/l90u23xd52V6UiIVkOjKWMIQ0S5lZII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993996; c=relaxed/simple;
	bh=efc9ccs5vCxpe9fgwkPHwWOxx1v/XDcQfdHlCRerUc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUFN+gYnbsX8pQEGM3d1hCt4M57ORg+jo4D2zdl+WcBxNGbb6+EK0KhX5NBpxvy80tZbzJSeA7LrPsts6HBDwOs0Cw3pIMxIVXP4JshQB5QqSReXUj1CmvQqQZcGe2qAzDRbntmPQDyvnQgaeTLcBUaU2v09BjbnahghqqwTrPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBXCnnzK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBXCnnzK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CE2C4CEC5;
	Thu,  3 Oct 2024 22:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727993996;
	bh=efc9ccs5vCxpe9fgwkPHwWOxx1v/XDcQfdHlCRerUc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBXCnnzKGOM9j4BP5QN7dLU8JJdZvUWj5hyhMMNedKNSf1F2d6LPw08ykjBexhX7G
	 6oH65HV49fIhPy7xRjfzyCJ0RUzljni+Oy59jOke+JM8KPktUAfkbENgmb+dv2o7eT
	 7r/XiCeQ/9n6BKyXchMSJ+SuPMqXWZgkmpXJTZlu40FG/VZzYvUP/JHxGW8FSgQvbn
	 jpdBhTkPCR1Ppy4IBtZ9QHFrsUY1lpBactiU2kdXWwaVA8v71YbT2+Q1h84w9umBte
	 KY14oBWfRmSc6slFVG/p6F/MErEoWaFq8IHGQYt5yNlWJdru2fQ5ejX7/bEn0SjUvK
	 QBjnSmv+OjRKA==
Date: Thu, 3 Oct 2024 15:19:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, acme@redhat.com,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] perf sched timehist: Add pre-migration wait time
 option
Message-ID: <Zv8YiooRdcT-x8iN@google.com>
References: <20241002163917.33781-1-vineethr@linux.ibm.com>
 <05c572743f8cefd0da65a56d9b110697eba5529e.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05c572743f8cefd0da65a56d9b110697eba5529e.camel@linux.intel.com>

On Thu, Oct 03, 2024 at 03:04:28PM -0700, Tim Chen wrote:
> On Wed, 2024-10-02 at 22:09 +0530, Madadi Vineeth Reddy wrote:
> > pre-migration wait time is the time that a task unnecessarily spends
> > on the runqueue of a CPU but doesn't get switched-in there. In terms
> > of tracepoints, it is the time between sched:sched_wakeup and
> > sched:sched_migrate_task.
> > 
> > Let's say a task woke up on CPU2, then it got migrated to CPU4 and
> > then it's switched-in to CPU4. So, here pre-migration wait time is
> > time that it was waiting on runqueue of CPU2 after it is woken up.
> > 
> > The general pattern for pre-migration to occur is:
> > sched:sched_wakeup
> > sched:sched_migrate_task
> > sched:sched_switch
> 
> If a task migrate from CPU A to CPU B, but is unlucky that
> someone took CPU B and it has to wait. Then it is yet again migrated to CPU C.
> Do you only compute pre-mig time as 
> t_sched_migrate_task_CPU_A - t_sched_migrate_task_CPU_A?
> 
> The task also spend some pre-mig time on CPU_B that probably
> should be included.  And that time is when it migrates to B
> till it is migrated away from B.  Do you take that into
> account?

Hmm.. right.  The current code updates the migrate time only if it's 0.
But I think it can just always update the time to get the latest one.

Thanks,
Namhyung
