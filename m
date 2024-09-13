Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09761C2DBA;
	Fri, 13 Sep 2024 13:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726232922; cv=none; b=ILkY5n/3q8aGGG5DULQKqnikDaTXBYwpGNb5j6jFtAk4Ma7U7UVbInJVYKsh6U3HrX0+oF5rk5JetwNv9qPfGg6+WbPQUm+QsYeiBFD1SkM3pqmWo6M1LKBvtfD4DXe5C6UL/1/tKD41GyaM1lqUWkMdkvBv6f1AK3vGOmBB9YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726232922; c=relaxed/simple;
	bh=Nd55sVt9Eitas7IcfqEpQNm4sndKdb0PdGWZOByFSIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dtvkbkqu21XCgB0wX3/CaFJ8TDOhtHYx1TlES0Kv4pqD0SRa6PtSfSvgCZjQkhSjmYyAhMDtaCV38RTl8AosPyLD/rEi05K69TxQFiMP8OOl7Wqr1pEuq+FJXyb1+3mpNo7wBJ9beCwR/Iztj1pMhauQPKaPA2m2g+IyvvgHZ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMtW1gUd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMtW1gUd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62572C4CEC0;
	Fri, 13 Sep 2024 13:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726232922;
	bh=Nd55sVt9Eitas7IcfqEpQNm4sndKdb0PdGWZOByFSIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMtW1gUdJSuPBUOm5Omc8zioFRBhwlVJDXJZanCOTH2s8PFnRmCFyw+fiKD8DciOx
	 z3CtDaeNweZujFWVOWxy71mXIBnmcOjkl+kZr/EjuJbFthys9c6bFgHp+CyPenB9TF
	 mZORFEmDXEYy/+7gFAwf8O7uwqPMQlYsFERoaMx2kzLix9WnkgFbGy4mQ42ddtRQZx
	 8OIcRWoaydDKkFzJbwWke6Kq2GqeaDUUe2bBr6RF0VS4tD0Gwu/cCz2cxeI3smwW4r
	 0RUsZb6kvyuvW1EUhG1K7IbjwFdmH2A6F/fXS08dp6wOwuGLo16Ub+DrRgkgdCI24Y
	 bGYbwXQLb90fA==
Date: Fri, 13 Sep 2024 06:08:34 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20240913130834.hq4gj27fcklakkzb@treble>
References: <cover.1699487758.git.jpoimboe@kernel.org>
 <d5def69b0c88bcbe2a85d0e1fd6cfca62b472ed4.1699487758.git.jpoimboe@kernel.org>
 <CAM9d7chZcqR8WCEYtjpP4KzUOeNdJ=kSvae0UrjsO8OgsepjDw@mail.gmail.com>
 <20231111184908.ym4l6cwzwnkl7e6m@treble>
 <CAM9d7chgoiwc3ZfQ8SzO7gV0oQOKMK3bJAdxa63Pzgcqo4i7tQ@mail.gmail.com>
 <ZVTuK5VRQfY1JOEY@google.com>
 <20231120140334.GW8262@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231120140334.GW8262@noisy.programming.kicks-ass.net>

On Mon, Nov 20, 2023 at 03:03:34PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 15, 2023 at 08:13:31AM -0800, Namhyung Kim wrote:
> 
> > ---8<---
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index 39c6a250dd1b..a3765ff59798 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -456,7 +456,8 @@ struct perf_event_attr {
> >  				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
> >  				remove_on_exec :  1, /* event is removed from task on exec */
> >  				sigtrap        :  1, /* send synchronous SIGTRAP on event */
> > -				__reserved_1   : 26;
> > +				defer_callchain:  1, /* generate DEFERRED_CALLCHAINS records for userspace */
> > +				__reserved_1   : 25;
> >  
> >  	union {
> >  		__u32		wakeup_events;	  /* wakeup every n events */
> > @@ -1207,6 +1208,20 @@ enum perf_event_type {
> >  	 */
> >  	PERF_RECORD_AUX_OUTPUT_HW_ID		= 21,
> >  
> > +	/*
> > +	 * Deferred user stack callchains (for SFrame).  Previous samples would
> 
> Possibly also useful for ShadowStack based unwinders. And by virtue of
> it possibly saving work when multiple consecutive samples hit
> the same kernel section, for everything.

[ necroing old thread as I'm finally working on a v2 ]

Peter, can you elaborate?  What did you mean by "same kernel section"?

Like if there's a duplicate kernel callchain?  Or something else?

-- 
Josh
