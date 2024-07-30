Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBBF18CBE8;
	Tue, 30 Jul 2024 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368956; cv=none; b=tUzRzAtmso1Eyf+81574UzwVg2X95wACVtZ+K0n4/M9dyLvsDgALcd0XBIfJd7Appv7FxLY69+lrTz9+UhuBghJdJJarfoiFHr11rUAylXJtP8TyzBTmc6628Hm2IJxGvx0WkuI60IIip8HOrb9qtG4EJs7SQyz0eYjFuuJ45es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368956; c=relaxed/simple;
	bh=DNXKAdlGH90CNj2wbQ3t+yLzha/KVLlByir3qqXKas0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuHbdPZuM5td6hxTipzbUPoz4i2AcedOJj2BWvLRgfJCwEQ/qrYh5gmonqBOR+tb2LzRCJZgAIFYI8e0KYwh8ATDA4RHQYUuqNGGjVBNBL2Y66wKlkT7QlG4CU6DPMlt7Xhc4Xs43nGAW0lYjF8OBvD1cai5paR+1DLWvX8I+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNTypCIY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNTypCIY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5272C4AF10;
	Tue, 30 Jul 2024 19:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722368956;
	bh=DNXKAdlGH90CNj2wbQ3t+yLzha/KVLlByir3qqXKas0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNTypCIYpTdw+n/WyUUA8YY0oSVZkev1DteSYiM4mTn7PQBi/4g0xeMY/9pj5OanO
	 bu7sX5RYFr6tr8+PPcsyb96kJ/h6IKYtRcE0wZ//OlcKpQE7rPGao+OU7bB6hiqBi1
	 hyEvXXaB/arI1f5imud1DUjV5Z+pV19ktQdTOUF1eswtupoZo7v6lxYQg0Jr1NM5oS
	 rITaXUI3I7KtGvxsmC/9Jb5Q4e8wsj0otWtKGZ9cQR79NBEKvQKjy1rvG34DY9nVf8
	 3A5W4wBxPrtDdbOAqUUElCpZcp9zoQ9VEsJwIrrnMHLY7M5gH7cjiWHXnZHQDZ8VMU
	 d+2GYKm5UCOxg==
Date: Tue, 30 Jul 2024 16:49:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v9 1/3] perf report: Support LLVM for addr2line()
Message-ID: <ZqlDuIj_nMVXhYou@x1>
References: <20240719150051.520317-1-sesse@google.com>
 <ZqlCIJ4khe2_xyp9@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqlCIJ4khe2_xyp9@x1>

On Tue, Jul 30, 2024 at 04:42:28PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Jul 19, 2024 at 05:00:49PM +0200, Steinar H. Gunderson wrote:
> > In addition to the existing support for libbfd and calling out to
> > an external addr2line command, add support for using libllvm directly.
> > This is both faster than libbfd, and can be enabled in distro builds
> > (the LLVM license has an explicit provision for GPLv2 compatibility).
> > Thus, it is set as the primary choice if available.
> > 
> > As an example, running perf report on a medium-size profile with
> > DWARF-based backtraces took 58 seconds with LLVM, 78 seconds with
> > libbfd, 153 seconds with external llvm-addr2line, and I got tired
> > and aborted the test after waiting for 55 minutes with external
> > bfd addr2line (which is the default for perf as compiled by distributions
> > today). Evidently, for this case, the bfd addr2line process needs
> > 18 seconds (on a 5.2 GHz Zen 3) to load the .debug ELF in question,
> > hits the 1-second timeout and gets killed during initialization,
> > getting restarted anew every time. Having an in-process addr2line
> > makes this much more robust.
> > 
> > As future extensions, libllvm can be used in many other places where
> > we currently use libbfd or other libraries:
> > 
> >  - Symbol enumeration (in particular, for PE binaries).
> >  - Demangling (including non-Itanium demangling, e.g. Microsoft
> >    or Rust).
> >  - Disassembling (perf annotate).
> > 
> > However, these are much less pressing; most people don't profile
> > PE binaries, and perf has non-bfd paths for ELF. The same with
> > demangling; the default _cxa_demangle path works fine for most
> > users, and while bfd objdump can be slow on large binaries,
> > it is possible to use --objdump=llvm-objdump to get the speed benefits.
> > (It appears LLVM-based demangling is very simple, should we want
> > that.)
> > 
> > Tested with LLVM 14, 15, 16, 18 and 19. For some reason, LLVM 12 was not
> > correctly detected using feature_check, and thus was not tested.
> > 
> > Signed-off-by: Steinar H. Gunderson <sesse@google.com>
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> I'm testing this again, I thought Ian or Namhyung had made comments on
> previous versions of this patchset, no?

Unfortunately it clashed with recent patches in the capstone related
codebase, IIRC Athira's for powerpc data-type profiling.

Please take a look at what is in tmp.perf-tools-next at:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

I'll continue processing other patched and eventually try to fix this if
you're busy,

Thanks again for your continued work on this!

- Arnaldo
