Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28128314B82;
	Wed, 25 Feb 2026 13:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772024551; cv=none; b=m9IEwh6Jt9m7NiBLwGvHNwK9ltehZ48EUkZxFv43M1Tws7LfHe6w+cO5d1URZEOq/crIxjyoCB+Yd2eCgMVNN0ylehBKVcAe2POBzGUPGo6DA1PXZxjzxqW0ZuBPguF/4eU3mPbYq7VMqZNrxre195hDYUaEmRNlC31650iwDPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772024551; c=relaxed/simple;
	bh=YJj1lHGliwIqyEHK0hyaMnP3kjzEfyWeCbNjz14LxSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUVe0LibQeu7Sl3aCxRavy7MBSN1BOtYvxBILO2Lk0WlPwulGmyNJkzXz/9yXc9PYP9Chfyt54Ky9iioncD7Wa0j5v2c/Fgv+RS3O0ePOuFZQhjWkcp5+/26glu4lRUyOXZEOHQbJBF3dm7Xz4pcZv6rAxerIvFP2fZT67M7VZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aErGoTwx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aErGoTwx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f2mA0aJiVpE6kTHNxCrPWVYrPjqiEuT55t3DQcvdmp4=; b=aErGoTwxSK2aA4AM8GrKYfA7u0
	HBr4QTzemek8g5gGkJFBfND6OL+r3sYkUjVfAnvV+GNawGRiN/yNxuL5G8qWWxk8kMWf+6UI9LKri
	n+9XVqHxLHIL2wCZiLhP4N2+Cqv4EwsHdiJTROR/5JaoFF1+rj0IfOS8+trlSQpRZtR3PCk0Wqdwa
	zlJLjTldO/52y9WzjQMQCCn46+OK6K+jXeRRXrgOs2z+ImRozWPEQQEMGmRqT6j1KrkgT/F5VpsZk
	vw/hZnpOzLeXdSnvJxgr5drgnXXlmqy8SFV6SPE7IIIMWrja8ZQC7uvJhziYe8wBb7VawMrCpGh75
	Zn8zpakw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvEWw-000000091i8-3Qih;
	Wed, 25 Feb 2026 13:02:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6AF1F301BD5; Wed, 25 Feb 2026 14:02:12 +0100 (CET)
Date: Wed, 25 Feb 2026 14:02:12 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v6 08/22] x86/fpu: Ensure TIF_NEED_FPU_LOAD is set after
 saving FPU state
Message-ID: <20260225130212.GO3016024@noisy.programming.kicks-ass.net>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
 <20260209072047.2180332-9-dapeng1.mi@linux.intel.com>
 <5c3ea318-4543-42a4-9b81-7a1da0b8bed1@intel.com>
 <960918ce-f42f-464f-a887-c36d8d9e2937@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <960918ce-f42f-464f-a887-c36d8d9e2937@intel.com>

On Wed, Feb 11, 2026 at 11:55:10AM -0800, Dave Hansen wrote:

> This:
> 
> >  	/* Swap fpstate */
> >  	if (enter_guest) {
> > -		fpu->__task_fpstate = cur_fps;
> > +		WRITE_ONCE(fpu->__task_fpstate, cur_fps);
> > +		barrier();
> >  		fpu->fpstate = guest_fps;
> >  		guest_fps->in_use = true;
> >  	} else {
> >  		guest_fps->in_use = false;
> >  		fpu->fpstate = fpu->__task_fpstate;
> > -		fpu->__task_fpstate = NULL;
> > +		barrier();
> > +		WRITE_ONCE(fpu->__task_fpstate, NULL);
> >  	}
> 
> also urgently needs comments.
> 
> I also can't help but think that there might be a nicer way to do that
> without the barrier(). I _think_ two correctly-ordered WRITE_ONCE()'s
> would make the compiler do the same thing as the barrier().
> 
> But I'm not fully understanding what the barrier() is doing anyway, so
> take that with a grain of salt.

barrier() restricts load/store movement by the compiler. A load/store
cannot be moved across barrier().

