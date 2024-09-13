Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525321DB551;
	Fri, 13 Sep 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234606; cv=none; b=G/dS5CFy6Pclu4yv0NcGd8WHIMeL7Qz/DfyN9wMl/Xgn2k44A2/RmT5+reeTPsTrrbrDziq+3rCMUyGHW/BfeSKtsjIdzRNiAYH/9ZSdi8zeo/Fxku7JWGay869q+tdZ5iqngTlZkAbiLi3FAe3sWLACKBl0rnMOGZ80ea34Bt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234606; c=relaxed/simple;
	bh=RNYwhca/1IF4NlElv6dep4EUbyqhfbgtdN2sniBVXg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbpEwkbEzqZvwek2A5oIORJsqB3a30jd8XSequ22F5hTHYr19nwzThUp5I+E1bL7xKjHDiqMKp9Lf1pE/zFB6UXa2tjjE30V1adCd4BNgEmet/NIPhRXxXd5uPc3XND3kOhgwn7aRRNpGVpdE3FZSUrUKMW0c7PgpzL7e48uGCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vUAI5zHN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vUAI5zHN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9AUzwboFNem3uz+L4LcwPI63t2xBnVL+Me61B1AirfE=; b=vUAI5zHNVqR9Sk7RxfAzHuLxPy
	FB/dLS6LShhX4YFcP2hR6w/xKlNbaJVqn9uwjAtaFl33PB/DqIBJu4ooxY/d3y8IQ28n0Qa/dsGuN
	Y43fgakjz4usJAq/suWiFL3EgUXWzF81vohXnhMJ6XKKbBNxvxQ2DO2lpMSiVESmFWnzp0Z6Y1ikx
	0tHNcussSJHPf3GFFwpslJz6vzSh936jnURUceFvrOP3L9MGtpbG9IGmY1o3mlSEhRZLZkRnEqFU1
	1f5g0Nz8YmMS/QSpe46wI62uMQTrSdFTxhG8KM4/HNDdPz1RUTdpD/4LQY42i4aVfxeKIAkg14ifq
	PnGW8CfA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sp6TO-0000000GcWl-1piu;
	Fri, 13 Sep 2024 13:36:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8AF913003E1; Fri, 13 Sep 2024 15:36:29 +0200 (CEST)
Date: Fri, 13 Sep 2024 15:36:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: Re: [PATCH RFC 04/10] perf: Introduce deferred user callchains
Message-ID: <20240913133629.GV4723@noisy.programming.kicks-ass.net>
References: <cover.1699487758.git.jpoimboe@kernel.org>
 <d5def69b0c88bcbe2a85d0e1fd6cfca62b472ed4.1699487758.git.jpoimboe@kernel.org>
 <CAM9d7chZcqR8WCEYtjpP4KzUOeNdJ=kSvae0UrjsO8OgsepjDw@mail.gmail.com>
 <20231111184908.ym4l6cwzwnkl7e6m@treble>
 <CAM9d7chgoiwc3ZfQ8SzO7gV0oQOKMK3bJAdxa63Pzgcqo4i7tQ@mail.gmail.com>
 <ZVTuK5VRQfY1JOEY@google.com>
 <20231120140334.GW8262@noisy.programming.kicks-ass.net>
 <20240913130834.hq4gj27fcklakkzb@treble>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913130834.hq4gj27fcklakkzb@treble>

On Fri, Sep 13, 2024 at 06:08:34AM -0700, Josh Poimboeuf wrote:
> On Mon, Nov 20, 2023 at 03:03:34PM +0100, Peter Zijlstra wrote:
> > On Wed, Nov 15, 2023 at 08:13:31AM -0800, Namhyung Kim wrote:
> > 
> > > ---8<---
> > > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > > index 39c6a250dd1b..a3765ff59798 100644
> > > --- a/include/uapi/linux/perf_event.h
> > > +++ b/include/uapi/linux/perf_event.h
> > > @@ -456,7 +456,8 @@ struct perf_event_attr {
> > >  				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
> > >  				remove_on_exec :  1, /* event is removed from task on exec */
> > >  				sigtrap        :  1, /* send synchronous SIGTRAP on event */
> > > -				__reserved_1   : 26;
> > > +				defer_callchain:  1, /* generate DEFERRED_CALLCHAINS records for userspace */
> > > +				__reserved_1   : 25;
> > >  
> > >  	union {
> > >  		__u32		wakeup_events;	  /* wakeup every n events */
> > > @@ -1207,6 +1208,20 @@ enum perf_event_type {
> > >  	 */
> > >  	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
> > >  
> > > +	/*
> > > +	 * Deferred user stack callchains (for SFrame).  Previous samples would
> > 
> > Possibly also useful for ShadowStack based unwinders. And by virtue of
> > it possibly saving work when multiple consecutive samples hit
> > the same kernel section, for everything.
> 
> [ necroing old thread as I'm finally working on a v2 ]
> 
> Peter, can you elaborate?  What did you mean by "same kernel section"?
> 
> Like if there's a duplicate kernel callchain?  Or something else?

Yeah, multiple samples hitting the same syscall invocation will, by
necessity, have the same user callchain.
