Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CE51B581F
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651020; cv=none; b=lXfK1J1+GKm72g3VAzAcAP29hqH+AbHW8R23cLIXoC7aHhY75a9tuwZpSmTPY3RAnzgLzT6y54Qf9uVxuCBNsNg0SkQ7C/MNSKRWLCU3OvlSe4DRUpOYXUzh7C06A5pelurvl1u3FjKWrtuoCCC3OI/XBpgIOc02Za9+dNfqwfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651020; c=relaxed/simple;
	bh=Yb9BPn+dmI2shHmtTZU3YY9Gy46k7gYN5T4z3//PU5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efoIfBxjPnfhh7SgGhROf6gKpGxwZrC6NS8lL8AbTrHn6HniYRO6P55sgikchZyRBri8JNYTaWDypMjtUpw26gvuJBuxMUVjO4S7gKmgv1kcp9DCv68qYz/NggSUMMIAuMoLp6kPWU90+DyLvPrUEBHp7CDGgMCiJGZPXFpLO7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMxU8bYw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMxU8bYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CEBC116B1;
	Wed, 14 Aug 2024 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723651020;
	bh=Yb9BPn+dmI2shHmtTZU3YY9Gy46k7gYN5T4z3//PU5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HMxU8bYwMW19q7n0jCqr3w2eSPL3ebFV2s2/zsJqj9UNWIACfIQ5IhNZZ5cO0U6Uu
	 ymaZbOFvkTtmN2Fn/kx70M97Cfvgy0LyteAIkhSZ4iIN/sdESSn+MnqeMGLntM7fua
	 CZUlfyBJAwlbTaqYZBnVscoxPoUmbJWh7rdEPyv6evTQf9mljoKVEMPAlRhOb7MjSf
	 sg6B1jumkAwcYURa99nq0RYdFKjEUymT2tcDI9wftHcPqpKgV/0KXZjUVF23hlbn6e
	 CBOb3qPHgRfK7+9AhEU1zPNuraRd3jZNV1H1ahPZJuko7HwfzuVXStO9Da7R6xDVMK
	 jddwM5nlUhWtg==
Date: Wed, 14 Aug 2024 12:56:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Veronika Molnarova <vmolnaro@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com,
	adrian.hunter@intel.com, atrajeev@linux.vnet.ibm.com,
	irogers@google.com, jolsa@kernel.org, kjain@linux.ibm.com,
	mpetlan@redhat.com, rstoyano@redhat.com
Subject: Re: [PATCH v3] perf test record.sh: Raise limit of open file
 descriptors
Message-ID: <ZrzTyVLQCQPiV_D3@x1>
References: <20240814151734.15409-1-vmolnaro@redhat.com>
 <ZrzOFDmwl9Z8F8NP@x1>
 <ZrzO2T1s_tIpqizG@x1>
 <d847f760-896e-4bdf-9f8c-933f52a5aed8@redhat.com>
 <ZrzTS46l3Ct_I0Oj@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrzTS46l3Ct_I0Oj@x1>

On Wed, Aug 14, 2024 at 12:54:51PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Aug 14, 2024 at 05:42:01PM +0200, Veronika Molnarova wrote:
> > 
> > 
> > On 8/14/24 17:35, Arnaldo Carvalho de Melo wrote:
> > > On Wed, Aug 14, 2024 at 12:32:39PM -0300, Arnaldo Carvalho de Melo wrote:
> > >> On Wed, Aug 14, 2024 at 05:17:34PM +0200, vmolnaro@redhat.com wrote:
> > >>> From: Veronika Molnarova <vmolnaro@redhat.com>
> > >>
> > >> Ok? I'm applying it with this change. Thanks,
> > > 
> > > So I added this to the log message:
> > > 
> > > Committer notes:
> > > 
> > > Instead of disabling ShellCheck warnings all the uses of 'uname -n',
> > > i.e. those:
> > > 
> > >   In tests/shell/record.sh line 35:
> > >   default_fd_limit=$(ulimit -Sn)
> > >                             ^-^ SC3045 (warning): In POSIX sh, ulimit -S is undefined.
> > > 
> > > We can just switch from using '/bin/sh' to '/bin/bash' for this test, as
> > > bash _has_ 'ulimit -n', so ShellCheck will not emit that warning.
> > > 
> > > There are dozens of 'perf test' shell tests that do just that,
> > > '/bin/bash' is a reasonable expectation for those tests.
> > > 
> > > ----------------------------------------------------------
> > > 
> > > Please let me know if you find any issues with this course of action,
> > > 
> > > Thanks,
> > > 
> > > - Arnaldo
> > > 
> > If so then the check whether the ulimit is supported doesn't need to be done
> > as bash is given as a requirement. Thought that it should be supporting all
> > possible shells, even though couldn't find shell not supporting 'ulimit -Sn'.
> > 
> > Can I send a quick fix that just changes to the '/bin/bash' so that the code
> > won't have unnecessary code?
> 
> See my last message, I went with your v2 + switch from /bin/sh to
> /bin/bash, as you suggest above.

And added the '-S' to ulimit, since you changed that from v2, are you
sure that is better than using just -n? Why?

- Arnaldo
