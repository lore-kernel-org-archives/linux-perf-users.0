Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A90193403;
	Wed, 13 Nov 2024 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731532414; cv=none; b=ZutC0CHVjAxDuncYwE+9E5DV540MjTeebp6mjkxU2pdzbuo2EqJX9t63JQdnkyouZjSC+WsePW/h4XHaeSY4ldsc7Itpxv3taGdK/qT7SchWi+CI8ywZIPNcZFCDcGhuDBweLRJsrY21AoFqQ8hgRfmQsQIZ4mw43nHK8dH6AIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731532414; c=relaxed/simple;
	bh=dG+PWrpTh9WN4IYnpLuD9zRtuskgLR0icJKXpnnEhY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibb0EGp2noi3DWUZgSggWPV5gujiNCP3Ys+rjZQhr+8bAQvZgwZOrkkC/rlsF+a81Ln9mbwE4kcEYBMuoFos45drzl+UZd1EpQbEW4/PyhsLmYVBZ0+FReXETAxegoJGRN423CB8q/afiYeOWR5Klbvtwzfm3ao43xv4l8U3x4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7Gzp2bK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7Gzp2bK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5BFC4CEC3;
	Wed, 13 Nov 2024 21:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731532413;
	bh=dG+PWrpTh9WN4IYnpLuD9zRtuskgLR0icJKXpnnEhY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E7Gzp2bKIK61ytzweNtCxVXe/37znZrYThr4tiAZn47QpSaFDZnKcdlDynCR1XfOh
	 X8WlpfgFxAUodaD1Y2PVW/xXCbX3YF21IxmbUfoIAPDdEAxYjEjSbfjyZK76XXMQH5
	 R2SQSrblMNgagk1ULT7KdZrwjdyRb4M0lwofYZt3eqJ+r9g/LzPi5eoJ02LNwo4GVM
	 86gMkHbUWmY61IbsrAsJYyqDCfeiQseUUAtjTBSSKARcl3ZAnHABnkQ66OH/jz7gql
	 /HqywYujV6RqkGAH58IvUeq4Stt06Fx37/Ewk8CVB61sYanZpNCJznfinEL8MYSkOd
	 SiTVc7Jlezm+Q==
Date: Wed, 13 Nov 2024 13:13:30 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jens Remus <jremus@linux.ibm.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241113211330.hd6y32gfy4hbwqfm@jpoimboe>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <23ff3782-c192-43eb-99c2-fe2746da7d4c@linux.ibm.com>
 <20241113155058.5b15ea58@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113155058.5b15ea58@gandalf.local.home>

On Wed, Nov 13, 2024 at 03:50:58PM -0500, Steven Rostedt wrote:
> On Wed, 13 Nov 2024 16:56:25 +0100
> Jens Remus <jremus@linux.ibm.com> wrote:
> 
> > On 28.10.2024 22:47, Josh Poimboeuf wrote:
> > 
> > > diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c  
> > 
> > > @@ -68,7 +83,12 @@ int unwind_user_start(struct unwind_user_state *state)
> > >   		return -EINVAL;
> > >   	}
> > >   
> > > -	state->type = UNWIND_USER_TYPE_FP;
> > > +	if (current_has_sframe())
> > > +		state->type = UNWIND_USER_TYPE_SFRAME;
> > > +	else if (IS_ENABLED(CONFIG_UNWIND_USER_FP))  
> > 
> > The test must be for CONFIG_HAVE_UNWIND_USER_FP. :-)
> 
> Yep, that too.

I also found this one, so that makes three of us!

It's too bad IS_ENABLED() doesn't catch typos.

-- 
Josh
