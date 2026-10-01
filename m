Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6E84B3364;
	Thu,  1 Oct 2026 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845679; cv=none; b=hHXEE3CplVDMiD3yX6rMuRBlsSFJdswz35ntqiIf0sRqcectswSxs3SqVyC9eC/xNz8Ssg0UuPY21YKGIRMF/lKq9SdFoZn9L2WpgRFe2JiFYF5YC8YvbEFoVRDCG+x+MjOn/Tuy9YcOqjswhDhDvDdXPT1qXZJwiTKv9RdL+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845679; c=relaxed/simple;
	bh=XvTMpybO+WOzwbI98cMXmmajG8gO3+MlP30jCMDWzs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/cdK7GROSjrBxM/OP70mItX4pFNBfQeoLUJWprP192fzyrBF4VBeVE7FMiEubvGs/hxtkyZohOYc6M4Z2qTJRGH1QkuZMCG9Yxua4XA8wnYaruUkkapk5nM9DVXuxaLuW5+7p/HNSl/csb4rGekRWeXh68krx3spFlnArdY8jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gydCYrF5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gydCYrF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F7F1F00898;
	Thu,  1 Oct 2026 09:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790845677;
	bh=AGeOzc2J2CJA3EucDE3nsXvuQmNGvxeq51RiJtRUX+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gydCYrF5kG7oMjom7YbfHFXxPryxRGM01JTWvIRvR6Gpiu1lyUhcK1mwoQx8DX3L0
	 uJrNn8m/Kl30fGi4NQff0OTo46hFazezOIddZoxC7T9AHKhwr15HTu59X4xPcq3gKO
	 aJv4vzpFmusCkJl04BruKfDdAPVH3UV6jLgPG2o10HY/qO8/AfAxQAKHp7PNfeJQOP
	 3/uCCRnwBKvtih7ETlY+5oCQZFktkl8NwJNbmb9CAwC3sqOPt/0V1ckd1M9sP5+gN1
	 qrJUOGG2CwZS9NdCCLDJsSAcCWugcVa7uPn+4mlRkZQSz49mQPsyqt3GUjIPruoCig
	 09AhUPM43yuGg==
Date: Thu, 1 Oct 2026 11:07:53 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
	Howard Chu <howardchu95@gmail.com>, Jakub Brnak <jbrnak@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 06/26] perf trace: Copy sockaddr arguments by their
 length
Message-ID: <ar4i6X8g9H4dfiah@x2>
References: <cover.1790145937.git.irogers@google.com>
 <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-7-irogers@google.com>
 <ar1fon_Z4uT3Cd22@x2>
 <ar2WYemXnrbDx-Il@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar2WYemXnrbDx-Il@google.com>

On Wed, Sep 30, 2026 at 04:08:17PM -0700, Namhyung Kim wrote:
> On Wed, Sep 30, 2026 at 09:14:42PM +0200, Arnaldo Carvalho de Melo wrote:
> > On Mon, Sep 28, 2026 at 11:25:45AM -0700, Ian Rogers wrote:
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -4159,7 +4159,12 @@ static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, i
> > >  				continue;

> > >  			bt = sc->arg_fmt[i].type;
> > > -			beauty_array[i] = bt->size;
> > > +			/* Copy a sockaddr as a buffer sized by the next argument, e.g. addrlen. */
> > > +			if (strcmp(name, "sockaddr") == 0 && field->next &&
> > > +			    strstr(field->next->name, "len"))
> > > +				beauty_array[i] = -((i + 1) + 1);
> > > +			else
> > > +				beauty_array[i] = bt->size;

> > And it knows how many bytes to read by looking at socklen
> > (args->args[2]), i.e. not use the generic BPF handler that uses this
> > beauty_array, because knowing how many bytes to read in this case is
> > dynamic, varies with each syscall, according to one of its arguments :-\

> > What am I missing?
 
> I think Ian's patch update the beauty map which is used by
> augment_sys_enter() before tail-calling syscall-specific functions.
 
> It'd be great if we cover all syscalls in the BPF skeleton and switch
> to the beauty-map and discard the functions.

I was missing the convention that a negative size means read some
other argument with a cap, as Ian explained in his response.

So checking if a syscall arg is of type sockaddr (or if the name is
always sockaddr as Ian did above) and the next arg has name "len", then
we can set the beauty_array[index_of_sockaddr_arg] = -index_of_len_arg,
that extra + 1 looks odd, but must be part of the convention too.

Since we have it there already and we may not have BTF and BTF isn't yet
a hard requirement, we leave the fallbacks in place for the time being?

- Arnaldo
