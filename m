Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBDB19F430;
	Thu, 31 Oct 2024 23:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730415800; cv=none; b=Ni858ZVH5yfIdJQLp4F09hg83y4A5iHIbweJin6OCZUpRBOl8uvgw3+3cLT/NeGiNUq+BREcGwniXJAqa1WpRRYzsDgF//YlYePu+tKg9pUNR/Xo4DUNZKFfIMZfAU9FXiu9fwzn5UXJz2CLdYCdWnRPiD5Q9fRgkuWm9NNxRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730415800; c=relaxed/simple;
	bh=eUDN0rTSziBFn916MG2w3mYW5lFHgOs2UPSLKU5r+8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uuxHytk0TPb67+EEoKdUjpRu7IUgqfz5M58Xkm4SR3M+J+mGACcRpoCOsdVrdocWNZxrcenQ2jN27VQtcAA6uKh/NOBD8H5IRSxPptSKk+5Qzh5ESz0CThyg2NM48guNeMCJZcUA0xUKtgcffpXIllDFCiKQ6UKhJt4am85XHao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNZiWT5q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNZiWT5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44064C4CEC3;
	Thu, 31 Oct 2024 23:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730415800;
	bh=eUDN0rTSziBFn916MG2w3mYW5lFHgOs2UPSLKU5r+8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNZiWT5qI/dBzEr1U4csl2pjgm5yps5GX6lxUio9BCuWf2M/2Vq5ToALyadBC/CwC
	 E712bTQbeqPNAeh+FqpAYuRuz/xt+XO7WfgsaYI03YMhMBPiqE6zUDMmq9k8fbW0dq
	 nDlVnc6gkpAIYOIo0BNYftWXAhD6/BmMg+k8zgHpnFwUvBy+MOesyVf1oFAQICTAYl
	 KQP3MvFFbJ2Qedj9OpbY+5XK9d3GurWJGKYA4Q5WAw5LJ2wWtJjMpip6V64FgoY/+/
	 uq1K/1+ql6CT7qjn0kVbawIi7Ca3sJFqHX4onF9sRDx/u6aXmNGcpLw/tBH6XNtFYu
	 Mc4NNwT1ox/fA==
Date: Thu, 31 Oct 2024 16:03:13 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
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
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 09/19] unwind: Introduce sframe user space unwinding
Message-ID: <20241031230313.ubybve4r7mlbcbuu@jpoimboe>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <42c0a99236af65c09c8182e260af7bcf5aa1e158.1730150953.git.jpoimboe@kernel.org>
 <CAEf4BzY_rGszo9O9i3xhB2VFC-BOcqoZ3KGpKT+Hf4o-0W2BAQ@mail.gmail.com>
 <20241030055314.2vg55ychg5osleja@treble.attlocal.net>
 <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEf4BzYzDRHBpTX=ED3peeXyRB4QgOUDvYSA4p__gti6mVQVcw@mail.gmail.com>

On Thu, Oct 31, 2024 at 01:57:10PM -0700, Andrii Nakryiko wrote:
> > > what if ip_off is larger than 4GB? ELF section can be bigger than 4GB, right?
> >
> > That's baked into sframe v2.
> 
> I believe we do have large production binaries with more than 4GB of
> text, what are we going to do about them? It would be interesting to
> hear sframe people's opinion. Adding such a far-reaching new format in
> 2024 with these limitations is kind of sad. At the very least maybe we
> should allow some form of chaining sframe definitions to cover more
> than 4GB segments? Please CC relevant folks, I'm wondering what
> they're thinking about this.

Personally I find the idea of a single 4GB+ text segment pretty
surprising as I've never seen anything even close to that.

Anyway it's iterative development and not everybody's requirements are
clear from day 1.  Which is why we're discussing it now.  I think there
are already plans to do an sframe v3.

> > > > +                       if (text_vma) {
> > > > +                               pr_warn_once("%s[%d]: multiple EXEC segments unsupported\n",
> > > > +                                            current->comm, current->pid);
> > >
> > > is this just something that fundamentally can't be supported by SFrame
> > > format? Or just an implementation simplification?
> >
> > It's a simplification I suppose.
> 
> That's a rather random limitation, IMO... How hard would it be to not
> make that assumption?

It's definitely not random, there's no need to complicate the code if
this condition doesn't exist.

> > > It's not illegal to have an executable with multiple VM_EXEC segments,
> > > no? Should this be a pr_warn_once() then?
> >
> > I don't know, is it allowed?  I've never seen it in practice.  The
> 
> I'm pretty sure you can do that with a custom linker script, at the
> very least. Normally this probably won't happen, but I don't think
> Linux dictates how many executable VMAs an application can have.
> And it probably just naturally happens for JIT-ted applications (Java,
> Go, etc).

Actually I just double checked and even the kernel's ELF loader assumes
that each executable has only a single text start+end address pair.

> > pr_warn_once() is not reporting that it's illegal but rather that this
> > corner case actually exists and maybe needs to be looked at.
> 
> This warn() will be logged across millions of machines in the fleet,
> triggering alarms, people looking at this, making custom internal
> patches to disable the known-to-happen warn. Why do we need all this?
> This is an issue that is trivial to trigger by user process that's not
> doing anything illegal. Why?

There's no point in adding complexity to support some hypothetical.  I
can remove the printk though.

-- 
Josh
