Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FCC38757B;
	Thu,  6 Aug 2026 07:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786000674; cv=none; b=jjsDL08C+LyMEg9rBRXuWBGHWlRyci0+zL5hqgDO19Q6gai3+GKW4VNKNT9b/0CTsbmLy8y0dg+RQFv6os2d5C4qod9yLTUyOPoLIYMVriFsub99vjDekWv9YlDXJ6NbhxgZTwX1yL2URGczL4M8X+tVx0pzo+KN1q96JFlGgiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786000674; c=relaxed/simple;
	bh=XCW04prNOvJN3+WT8RIPp80KBAK3kRC1ePK5xixfsD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5BVcx1A+yGGN/0p+5OLUvYLNbLDvAjUjzng2h8MsI2FvfMiJBzQQtYZEnS4Wv1FFSObbBlfL3iZgC3LPWkcGsowQv/RBy61lYGTy3dBYsjG3YPPBJfQ0hPl1EaE8HgZ66dCwqECDw9/Hr92YH+4tXXiShpbqoE5J9uPsZZsyNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GFuzdmqs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GFuzdmqs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vNP/V7rEoAsXhxstFtyLYmMxzfVTus4oyN4R/xdFQOI=; b=GFuzdmqsHa/BzPqNxfLbruF4VA
	gkWQxjN3p0wE0LGc8VyaHJh/fGrj8h14hYxJdnChJzAMwTanm49h+CO1OWKyrlnPvBG2o0X91pAxo
	yAaUOVbf6AdDocXmFPoSPsrvGVIzvmpPvYSciuG7KBYh46KkuoKgFGg6umT4qJGxbdmFdZCvQG2Np
	GPb34VL4/Cp+IEl1ADCGq6ovG4pTfAW8BDAxmzqyoUO+dWEBd+t5/3UqQSND+NY78G0TebL9EhtFn
	ARUeaYCGYglrZ6LkNqb2RClHXdo/Xi3m4b+4HsohCpXU6HS2HxlQMbjjPUe//HydkqtMeWXqrvHKc
	5OQ7U7LA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrsME-00000008f74-2Zmd;
	Thu, 06 Aug 2026 07:17:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6AC46301519; Thu, 06 Aug 2026 09:17:37 +0200 (CEST)
Date: Thu, 6 Aug 2026 09:17:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v11 04/11] tracing: wprobe: Add watchpoint probe event
 based on hardware breakpoint
Message-ID: <20260806071737.GK49951@noisy.programming.kicks-ass.net>
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
 <178565875046.714490.17724442147958346980.stgit@devnote2>
 <20260803070356.GV49951@noisy.programming.kicks-ass.net>
 <20260805153404.793691b8@gandalf.local.home>
 <20260805193909.GP776954@noisy.programming.kicks-ass.net>
 <20260805210629.138f6197@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805210629.138f6197@gandalf.local.home>

On Wed, Aug 05, 2026 at 09:06:29PM -0400, Steven Rostedt wrote:
> On Wed, 5 Aug 2026 21:39:09 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > > This seems limited to kernel addresses only? Should not also userspace
> > > > addresses be supported?  
> > > 
> > > Hmm, how would that work? The address is global for all tasks, so if you
> > > add a user space address, what task would that be for? The one writing the
> > > probe?  
> > 
> > Schedule the watchpoint along with the task of course. Given there is
> > breakpoint/perf integration this should be trivial.
> 
> I meant, what task is it attached to? Usually the way a probe works is to
> create the probe and then enable it.
> 
>  # cd /sys/kernel/tracing
>  # echo 'w:my_jiffies w@jiffies:8 value=+0($addr)' >> dynamic_events
>  # echo 1 > events/wprobes/my_jiffies/enable
> 
> If the address is in user space, which task would that address be for?
> 
> What would the API look like? Should we add a pid to that for a specific task?

Same as uprobes?

