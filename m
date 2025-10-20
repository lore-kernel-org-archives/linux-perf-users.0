Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35A91CAA4;
	Mon, 20 Oct 2025 01:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760922991; cv=none; b=bME5Or8e0Nzy6PQF9dFUGuRzF4eIrOOC3QSDhuNjWGhHsdV+a55BPqwnFzm0PF9IelZRrUesJNeNrO0fVl9ZLjfeW8+jJBV469LvGyG9KwbCSgSYr5MhsgjXs72Wg5VsgIaoXSNJAyaD5pivNPLV3MV1WNqBRUSCcx6QU33oRQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760922991; c=relaxed/simple;
	bh=398WOaVPLyCRzHWXfwnxDvL/IwRFQ32YxB/rTo0FKQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1soyy4fzdustw6Ckf17vKOSeQOlBh6IfiNqEgboZfWtDDbw1oEuoElPUHjkLXkRUtAq7XUDl6Du/uxmGe1c0lW+NNhP04BWXzp+HnP10chijfIC90REKm94tnuQy779x03PP4ECSispb9LLS0Mu2IS003hN+cQ4MggxzsZIIl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtsgVtgF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtsgVtgF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0481DC116D0;
	Mon, 20 Oct 2025 01:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760922991;
	bh=398WOaVPLyCRzHWXfwnxDvL/IwRFQ32YxB/rTo0FKQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtsgVtgFbEsRatpRXFc4vMlGFyN7nR0lfEf0ItIF57+WuyuqdJPlxUdo4f/Y3xggV
	 Z9UIzKrRTYl1BV+h6eGZbqFk9cjHJjf/Uv+eTUCD6ooFtHtJEwYX5wxiJeIHaqFkG4
	 tKe2jvlQWcmRrtG0Q+mUtiyhzG0H+rjfCHHG2EZk6+AkelhaSKWDlkpq4e5lTg6LWE
	 FZXIydN0GrV/GubgUYxLezagdkejz2PxXoEAxNL/TIif19z1V6W71YjKQav/PPLXeb
	 XawlTrt3A+Y9iBaKZ9DsxyjEBOfV1R/4EAtgM6JgeOdsMdqjnmTDDgDNel+AvjEhyC
	 Hgy1Mcagui//g==
Date: Mon, 20 Oct 2025 10:16:24 +0900
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
Message-ID: <aPWNaOqocEPgAJcq@google.com>
References: <20251013080609.2070555-1-hupu.gm@gmail.com>
 <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
 <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com>
 <20251013161429.GE77665@e132581.arm.com>
 <CADHxFxQg2ZKwLEOa6wic_KP49PRBp=hF=cY16aVmR0O0pa8ZkA@mail.gmail.com>
 <20251015093037.GA109737@e132581.arm.com>
 <CADHxFxQyOBurB0LB9qRdc3DEDNU+vatqOybNdcizPnWZngiPZg@mail.gmail.com>
 <CADHxFxS3kDeSM7NvZHbdoOyqxzzcKeAc1xzr=q_f+T96G9preA@mail.gmail.com>
 <aPRNSgunb8K9boWx@google.com>
 <CADHxFxQ5ph5P+ihVw2Qm-f1T-OFUQziyc8fi-k+q3-YgL-XCMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADHxFxQ5ph5P+ihVw2Qm-f1T-OFUQziyc8fi-k+q3-YgL-XCMw@mail.gmail.com>

On Sun, Oct 19, 2025 at 03:57:27PM +0800, hupu wrote:
> Hi Namhyung,
> Thanks for your reply.
> 
> On Sun, Oct 19, 2025 at 10:30 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > On Sat, Oct 18, 2025 at 06:05:03PM +0800, hupu wrote:
> > > Hi Leo, Ian, and fellow maintainers.
> > >
> > > On Wed, Oct 15, 2025 at 7:47 PM hupu <hupu.gm@gmail.com> wrote:
> > > >
> > > > Hi Leo,
> > > > Thank you for your reply.
> > > >
> > > > On Wed, Oct 15, 2025 at 5:30 PM Leo Yan <leo.yan@arm.com> wrote:
> > > > >
> > > > > Have you installed the GCC cross packages ?
> > > > >
> > > > >  $ sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
> > > > >  $ sudo apt-get install libc6-dev-aarch64-cross linux-libc-dev-aarch64-cross
> > > > >  $ sudo apt-get install libc6-dev-arm64-cross linux-libc-dev-arm64-cross
> > > > >
> > > > > My understanding is arm64 cross compilation tries to find headers in the
> > > > > path /usr/aarch64-linux-gnu/include/ (I confirmed this on Ubuntu/Debian
> > > > > distros).  After install GCC cross packages, the headers should appear
> > > > > in the folder.
> > > > >
> > > >
> > > > I hadn’t installed the packages you mentioned earlier, but after
> > > > running the installation commands you provided, I was indeed able to
> > > > successfully build perf.
> > > >
> > > > In fact, I’m currently working on creating an SDK package, which
> > > > includes a cross-toolchain that I built myself using crosstool-NG. My
> > > > initial idea was to install certain third-party libraries (such as the
> > > > packages you mentioned) into the cross-toolchain’s sysroot directory.
> > > > With this approach, even when developing on different host machines,
> > > > we could simply specify the header search path (pointing to the
> > > > cross-toolchain’s sysroot directory) during compilation, and the build
> > > > should succeed without requiring any additional package installation
> > > > on the system.
> > > >
> > > > Based on this, I think allowing users to extend some options via
> > > > EXTRA_CLANG_FLAGS could be a flexible way to handle such cases.
> > > > However, this is just my personal thought and might not be entirely
> > > > correct, so I’d like to hear your advice.
> > > >
> > >
> > >
> > > Although installing the GCC cross packages allows me to build perf
> > > successfully, I still prefer to be able to pass additional Clang flags
> > > via EXTRA_CLANG_FLAGS, as this approach feels more flexible to me.
> > >
> > > I look forward to continuing the discussion on this topic.
> >
> > Doesn't EXTRA_CFLAGS work for you?
> >
> 
> 
> I’ve tried using EXTRA_CFLAGS and confirm that it doesn’t work. When I
> build perf with the following command, it still reports errors:
>   make perf ARCH=$ARCH CROSS_COMPILE=$CROSS_COMPILE
> EXTRA_CFLAGS="--sysroot=$SYSROOT"

Thanks for checking this.

> 
> In fact, by checking the code in tools/perf/Makefile.perf, we can see
> that the EXTRA_CFLAGS variable is not passed to Clang at all:
> 
> $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h
> $(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \
>   $(CLANG_OPTIONS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
>   -include $(OUTPUT)PERF-VERSION-FILE -include util/bpf_skel/perf_version.h \
>   -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
> 
> 
> As shown above, EXTRA_CFLAGS only affects the GCC cross-compilation
> process and has no impact on the Clang build process.
> That’s why I proposed introducing an EXTRA_CLANG_FLAGS variable to
> provide a way to control Clang’s compilation behavior more flexibly.

One thing I care is that we can set clang as a default compiler using CC
variable then meaning of EXTRA_CFLAGS and EXTRA_CLANG_FLAGS may be
confusing.  I guess EXTRA_BPF_FLAGS is clearer that we want to pass
something when it builds BPF programs.

Thanks,
Namhyung

