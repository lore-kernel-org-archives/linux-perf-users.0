Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F09621767B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Jun 2025 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240897; cv=none; b=SDcgMbeQjxf4tH5bokYXWAIdT5cA2yK1ntZ0Siz7NTasZczgOLX/4J1DP3WpbjOkiFXg/6y9pqjD4ZPLkFLXwWLf0mBWXIFJeVv9flZV7itF+cEKAvRGQbt1dphBafvKbg8ukxx1nq1lvTDJGMIegMUKUn6hpDfMjS+MOlTSXR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240897; c=relaxed/simple;
	bh=9LunLNuGggAnNzn7ujPb1mBvep5RA3NO5j5nTad8B8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1fSbPzpci8Kav70YKzw76D/l6UtWc33SfuqVoHuPbiDHWgwcWwokPCQQAgrZKWKowUwjCu0fhvQY4Gcsl8fE7BLdcya8rLQHwqSUBUNjhaiDXTUYt0UH4lngVi1Zk1EsgZdOD0aNW6cIws7NrLmnaOXm7fIQyST/o4W1VIQGI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7UxRDoI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7UxRDoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4893C4CEEE;
	Fri,  6 Jun 2025 20:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749240897;
	bh=9LunLNuGggAnNzn7ujPb1mBvep5RA3NO5j5nTad8B8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7UxRDoIylzNHCtNztY5yWI+jxKiZrn2ZrMaFy2luVhSEb5tnAYBXlNTVhakfBPCy
	 Q+ikLQaIScBmoFsXVtEEc8P/OhM0uVnee3zKL67BWP3MOirCbXEybOy2sviTz2cBbb
	 AMr9TaTJORLNCjQ4OAvRPMkZieNCikBGs0NfxF+ObsSjYpeCQO8b1iZWkJ5/30qumG
	 +eZtOM7XW6v7/EfcmSbZbj+wlVrG90Y1JWMLtPsDnf4/kgckc7+rkV9+hZDjzWbToq
	 fuCD4sIQ5u4puc5Cut/Rd/bdsqGGKi9hhBy5ggBLKJHM5niBWH9wlD/VKN6Kf8cwau
	 V3rj0gZQEyV8w==
Date: Fri, 6 Jun 2025 17:14:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michel Lind <michel@michel-slm.name>
Cc: linux-perf-users@vger.kernel.org, James Clark <james.clark@linaro.org>
Subject: Re: perf-tools v6.15 tarball not uploaded?
Message-ID: <aENMPp9SZdABPkic@x1>
References: <c5ac84be0a119d3dd432edf36196d07ad562b34c.camel@michel-slm.name>
 <aEHylyR4hGaqZ6C8@x1>
 <a4ac0d06699b0d69262953ce49c740d66590e05b.camel@michel-slm.name>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4ac0d06699b0d69262953ce49c740d66590e05b.camel@michel-slm.name>

On Fri, Jun 06, 2025 at 02:59:27PM -0500, Michel Lind wrote:
> On Thu, 2025-06-05 at 16:40 -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Jun 05, 2025 at 11:24:50AM -0500, Michel Lind wrote:
> > > I noticed the kernel.org mirrors don't have perf tarballs newer
> > > than
> > > 6.14.0 -
> > > https://mirrors.edge.kernel.org/pub/linux/kernel/tools/perf/

> > > Will they be uploaded soon? Presumably I can just generate the
> > > tarball
> > > myself for now from the Git tag.

> > Its there now:

> > https://www.kernel.org/pub/linux/kernel/tools/perf/v6.15.0/perf-6.15.0.tar.xz

> Thanks! This works great on x86_64, on arm64 it's failing because some
> files that are needed to generate unistd_64.h per James' commits
> starting Apr 29 are not there.
 
> (I tried copying the files that show up in the error log, but
> eventually hit a wall - for the Hyperscale build I'm going to get
> around it for now by just generating the file on CentOS Stream 9 and
> Stream 10 VMs, but I'll try soldiering on a bit to get this fixed
> properly next week)

Yeah, reproduced:

  CC      /tmp/build/perf-6.15.0/libapi/fd/array.o
  MKDIR   /tmp/build/perf-6.15.0/libapi/fs/
  CC      /tmp/build/perf-6.15.0/libapi/fs/fs.o
make[4]: /tmp/perf-6.15.0/scripts/Makefile.asm-headers: No such file or directory
make[4]: *** No rule to make target '/tmp/perf-6.15.0/scripts/Makefile.asm-headers'.  Stop.
make[3]: *** [Makefile:108: uapi-asm-generic] Error 2
make[2]: *** [Makefile.perf:973: /tmp/build/perf-6.15.0/libperf/libperf.a] Error 2
make[2]: *** Waiting for unfinished jobs....
  INSTALL /tmp/build/perf-6.15.0/libapi/include/api/cpu.h


We shouldn't be ever using anything outside tools, but over time we
ended up doing that :-(

And its just arm64 that is getting things from outside tools/

⬢ [acme@toolbx perf-tools]$ head tools/perf/MANIFEST 
COPYING
LICENSES/preferred/GPL-2.0
arch/arm64/tools/gen-sysreg.awk
arch/arm64/tools/syscall_64.tbl
arch/arm64/tools/sysreg
arch/*/include/uapi/asm/bpf_perf_event.h
include/uapi/asm-generic/Kbuild
tools/perf
tools/arch
tools/scripts
⬢ [acme@toolbx perf-tools]$

James, has this appeared on your radar before?

- Arnaldo
 
> These are the files I had to add so far for those curious
> 
> # needed to build uapi-asm-generic on arm64, see
> tools/lib/perf/Makefile
> Source1:       
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/Makefile.asm-headers?h=v%{tag_version}#/Makefile.asm-headers
> Source2:       
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/Kbuild.include?h=v%{tag_version}#/Kbuild.include
> Source3:       
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/include/uapi/asm-generic/Kbuild?h=v%{tag_version}#/uapi-asm-generic-Kbuild
> 
> ...
> 
> %ifarch aarch64
> cp -p %{SOURCE1} scripts/
> cp -p %{SOURCE2} scripts/
> mkdir -p include/uapi/asm-generic/
> cp -p %{SOURCE3} include/uapi/asm-generic/Kbuild
> %endif
> 
> Best regards,
> 
> -- 
>  _o) Michel Lind
> _( ) identities:
> https://keyoxide.org/5dce2e7e9c3b1cffd335c1d78b229d2f7ccc04f2
>      README:     https://fedoraproject.org/wiki/User:Salimma#README


