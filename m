Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6CB3126BC
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Nov 2025 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764183891; cv=none; b=BQ8BzipTsjpl/MQazgrKTK5/EGtn/v+PtiA7XbJnEFvYFOwr5p/nLUL4djl/IaHmCzp+yBn9fo10J6VfVEvRkp8sT2oodegGXV9wpUcc0wGJgRNJrIwxpe+3ozcbByxj7b1uIkrrR7w4+3z7kG2RUtbIDP6DfjHW4tN6oLBaxbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764183891; c=relaxed/simple;
	bh=y77rHH/FFpexWCoXa/I+QlKQxciFJQJ0i0r9l0Qh5KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFiglJ8PcGM21tCYu9kUP1W/URE8IQx1agvXbGhv75rnEQcYRQ0Kxi4NfZKHDOkzs0ywUmgnDJhGysgqQQmWK0f5z4ep8LxpkWklxjgAiuXQTRgD2xiEtZPYlQPjkO8S9YoYLUT3OmZT0lU20NDN0FKTsWCpzlDWR+7Nt4l1zTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdywvWg1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdywvWg1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87616C4CEF7;
	Wed, 26 Nov 2025 19:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764183891;
	bh=y77rHH/FFpexWCoXa/I+QlKQxciFJQJ0i0r9l0Qh5KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OdywvWg1LpePICfHr7jFR9uz6iFtv7NRWZC9rvsGNrDMpLr+hc2vmoy59mWcWiHQC
	 Vv+OTlD9TihaGN68VwBDapoCkAPiDYx8r5XQvaBeCEv6X1l0HMAh+kyyBo+1tKjUXR
	 zNyrxun/dOA4MhAVkjAxXPaAcmYilQqBZdXeYidqtnQjUmxcNdrxaIcGjgF537nkl4
	 CJEBZrlx85X6iygde4ngPH4zBn5i8UT2MC9Fgz5fBvV+vGAGqPJLrpDxoTMercwN9K
	 UyMhyzePn18DJNdkIDI8R51KyA3OskqpldYY3cm11sjiTCJWLCxRghP29eDbJXVZ65
	 a17f3STxuK4mA==
Date: Wed, 26 Nov 2025 11:04:48 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Shimin Guo <shimin.guo@skydio.com>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [BUG] perf: libdw not working for data collected on a different
 arch than host
Message-ID: <aSdPUOz6gqInzJdR@google.com>
References: <CAK3u-5gjxsFbnimP0mMFM6GRki7TAfNe6YmY6KtJhApV45nSNw@mail.gmail.com>
 <CAP-5=fVndu7gOVSzH=jKtsNLQk=Asv_OZNaEQ8nPXoUKWE8izg@mail.gmail.com>
 <CAK3u-5gfzAR5RDicyqaUi9ddZSbD=JkYN-K--iD4wCMCqFKF=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK3u-5gfzAR5RDicyqaUi9ddZSbD=JkYN-K--iD4wCMCqFKF=w@mail.gmail.com>

Hello,

On Tue, Nov 25, 2025 at 06:55:54PM -0800, Shimin Guo wrote:
> On Tue, Nov 25, 2025 at 5:43 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Mon, Nov 24, 2025 at 10:39 AM Shimin Guo <shimin.guo@skydio.com> wrote:
> > >
> > > Hi,
> > >
> > > I see there have been patches aimed at enabling perf to unwind stacks
> > > collected on a different arch than the host perf itself is running on,
> > > for example, https://lore.kernel.org/all/20230606014559.21783-4-leo.yan@linaro.org/.
> > >
> > > I believe there is still one issue that prevents me from doing
> > > unwinding on arm64 stacks on a x86 host. As of v6.18-rc6, I still see
> > > the following in tools/perf/util/unwind-libdw.c:
> > >
> > > static const Dwfl_Thread_Callbacks callbacks = {
> > >     .next_thread = next_thread,
> > >     .memory_read = memory_read,
> > >     .set_initial_registers = libdw__arch_set_initial_registers,
> > > };
> > >
> > > libdw__arch_set_initial_registers is defined for each architecture,
> > > and the version is chosen at compile time, not for the arch the data
> > > is collected on. After fixing this issue, I was able to get the call
> > > chains. Is my analysis correct?
> >
> > Hi Shimin,
> >
> > I think your analysis is correct. I've been trying to clean up other
> > cases of this, such as with dwarf_regs:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/tools/perf/util/include/dwarf-regs.h?h=perf-tools-next
> > Or with syscalltbl:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/tools/perf/util/syscalltbl.c?h=perf-tools-next&id=1470eaa574870da3f78942927b15e0b75da3ffbe
> >
> > My belief is the arch directory is a code smell where we've most
> > likely broken cross-architecture support. Were you in the process of
> > putting together a patch series to fix this? My hope is to move away
> > from the CPUID feature strings for things like this and just use ELF
> > values like EM_X86_64.
> 
> I don't have immediate plans to put together a patch series. I'm not
> familiar with the Linux development process, coding standards, and
> common practices. Conceptually it's not that complicated, but whatever
> I come up with is likely not the best way to do it.

That's fine, we can find the best way during the review process if
you're willing to. :)

Thanks,
Namhyung

