Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EB61E492A;
	Sun, 19 Oct 2025 02:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760841041; cv=none; b=aVrOdGgWfe5Ld6qKPQc/n5LmgMnq0N5c+zfeEvY57sIkKhd2CQVeXHaftwYqhr4FANZeBxb/AANuBNps2OnY/3e5YUgjenvIU7uIafBflBUnZuNwGNiuUuVV1fWgXsO6+50URp7NH9kAMaBMhmi2/PPGDkN7Ew4dnUbBJVOZ8pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760841041; c=relaxed/simple;
	bh=ljwOH8bw9vDLCgJ0tLC/SZkVGwzd5vMvvBEpIPMtamc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQCEKeC8Lp8XDpEtVgLaqo7i22Nr2XKiNuejwBk5iNyjXw7+gnRe3ZMgut6g0ac4elKKlQpCKcvPfgp82OabKl0AgEwGLAQ9e9Aau83uuo0zM8xZzlLmE51RyScy+MAtPO1R9xh7Pd8EBi9MPM9Q/5LKEr9FnKFgIEfQqHB+t6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVaSgUga; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVaSgUga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D39AC116C6;
	Sun, 19 Oct 2025 02:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760841040;
	bh=ljwOH8bw9vDLCgJ0tLC/SZkVGwzd5vMvvBEpIPMtamc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVaSgUganfDxsd+8KG7fKBjFWA3STLMvQSlff/ouNrRgzt68rLQoBXcqdzB3m3OHj
	 hqpPoY6hv6iC4A9JRN93lNSm/371VZG44xpcnD0L0O0CKFFPvXn21U5a5nzF7TyQxK
	 Uwv7BesJqy1HUcHhbX2PywOruXYTvpNDLlbMeASdiK1Q4Gk7R1nu2NFYrCuv3uun1X
	 fO+46rKaDlaJC2wuFZcKwhOjLFw7l7u+sw5T+UdiAets3jQdKHrDN4Njj3nMZ29VQE
	 Z3U1J5RNk0FD/5SraU8HQtk/E3ixsT305zCcMTlbmZCWhlY1GFyoCfX68FvCcH3EZC
	 YCR6ogu84G4yA==
Date: Sun, 19 Oct 2025 11:30:34 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: hupu <hupu.gm@gmail.com>
Cc: Leo Yan <leo.yan@arm.com>, Ian Rogers <irogers@google.com>,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com, nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com, morbo@google.com,
	justinstitt@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC] perf build: Allow passing extra Clang flags via
 EXTRA_CLANG_FLAGS
Message-ID: <aPRNSgunb8K9boWx@google.com>
References: <20251013080609.2070555-1-hupu.gm@gmail.com>
 <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
 <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com>
 <20251013161429.GE77665@e132581.arm.com>
 <CADHxFxQg2ZKwLEOa6wic_KP49PRBp=hF=cY16aVmR0O0pa8ZkA@mail.gmail.com>
 <20251015093037.GA109737@e132581.arm.com>
 <CADHxFxQyOBurB0LB9qRdc3DEDNU+vatqOybNdcizPnWZngiPZg@mail.gmail.com>
 <CADHxFxS3kDeSM7NvZHbdoOyqxzzcKeAc1xzr=q_f+T96G9preA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADHxFxS3kDeSM7NvZHbdoOyqxzzcKeAc1xzr=q_f+T96G9preA@mail.gmail.com>

Hello,

On Sat, Oct 18, 2025 at 06:05:03PM +0800, hupu wrote:
> Hi Leo, Ian, and fellow maintainers.
> 
> On Wed, Oct 15, 2025 at 7:47 PM hupu <hupu.gm@gmail.com> wrote:
> >
> > Hi Leo,
> > Thank you for your reply.
> >
> > On Wed, Oct 15, 2025 at 5:30 PM Leo Yan <leo.yan@arm.com> wrote:
> > >
> > > Have you installed the GCC cross packages ?
> > >
> > >  $ sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
> > >  $ sudo apt-get install libc6-dev-aarch64-cross linux-libc-dev-aarch64-cross
> > >  $ sudo apt-get install libc6-dev-arm64-cross linux-libc-dev-arm64-cross
> > >
> > > My understanding is arm64 cross compilation tries to find headers in the
> > > path /usr/aarch64-linux-gnu/include/ (I confirmed this on Ubuntu/Debian
> > > distros).  After install GCC cross packages, the headers should appear
> > > in the folder.
> > >
> >
> > I hadn’t installed the packages you mentioned earlier, but after
> > running the installation commands you provided, I was indeed able to
> > successfully build perf.
> >
> > In fact, I’m currently working on creating an SDK package, which
> > includes a cross-toolchain that I built myself using crosstool-NG. My
> > initial idea was to install certain third-party libraries (such as the
> > packages you mentioned) into the cross-toolchain’s sysroot directory.
> > With this approach, even when developing on different host machines,
> > we could simply specify the header search path (pointing to the
> > cross-toolchain’s sysroot directory) during compilation, and the build
> > should succeed without requiring any additional package installation
> > on the system.
> >
> > Based on this, I think allowing users to extend some options via
> > EXTRA_CLANG_FLAGS could be a flexible way to handle such cases.
> > However, this is just my personal thought and might not be entirely
> > correct, so I’d like to hear your advice.
> >
> 
> 
> Although installing the GCC cross packages allows me to build perf
> successfully, I still prefer to be able to pass additional Clang flags
> via EXTRA_CLANG_FLAGS, as this approach feels more flexible to me.
> 
> I look forward to continuing the discussion on this topic.

Doesn't EXTRA_CFLAGS work for you?

Thanks,
Namhyung

