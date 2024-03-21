Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E2412C529;
	Thu, 21 Mar 2024 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037809; cv=none; b=X0XeDhMKb/E7zzKBe90S9XKbfN2p6Ztp+Z3t7pBqb5D91LGoq1+1Uie+8CEHqYofeDHbb2arRohrEWWkX38QwRaoKYuuJUyHcUhLZ39iqkuMZsAd/KI92syz07sHJMGj9jsxxblnVprrvXN5HJE0r336w11WKuXYavpmEGtXWNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037809; c=relaxed/simple;
	bh=j8WX7qh9sNSJEWTBsEjY35UwYY6dcP+XPto7bX2itzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GO8W8EMp1xzWgJMoj3k2D1pMvDu8R9cAsHXzniO14LVseG2vIMD+hUtH+Xem4g2i/AuOP9cNXQ1m4RnOTaylicxJi20QE8M2uUrUxB1AP1jXTpmiKrh4yzqMzn2mQjY1cFyu7gOFENDGdFM0z3dOQ7sFw0UQxNezNH+fpvRJ+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXXwi/WB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXXwi/WB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5940EC433C7;
	Thu, 21 Mar 2024 16:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711037808;
	bh=j8WX7qh9sNSJEWTBsEjY35UwYY6dcP+XPto7bX2itzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OXXwi/WBHhevMiC3fy622w4L6FLDA5BZuv85JQ7ar434vFbXaqJxxOsp9mE2Ufhcj
	 DOXWtOb54JqxHgWmmfcxu1VUwtllkYB0kykceCBJcCnWgK4kvuzw6Pt2Q6ZCh1FI25
	 YPVtPjefV31clls19v9GgOzKgKh9aE5oJtMP+dw1J01SVoYwDoW69wy4vDKWv4+HgE
	 trFc4iZcrbwamW41bDzke04+XcnyIzYhE+8uw6ZKg3WQPbEwawN5/BWX7FzJD9ImEa
	 hx7YzHYvjZcFCxrvTvpOm9I29U9CLkRcKPFpoi8K8Chd/sLzKSlDG5EKTXM10VGC8T
	 k5SrgKGqSLIiw==
Date: Thu, 21 Mar 2024 13:16:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] libbpf: Define MFD_CLOEXEC if not available
Message-ID: <ZfxdbbDzIcmEngQA@x1>
References: <ZfxZ9nCyKvwmpKkE@x1>
 <CAEf4Bzb+tctGAzSfNunJT259-toJ3nL7p0X4CemuUa=6iH82NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb+tctGAzSfNunJT259-toJ3nL7p0X4CemuUa=6iH82NQ@mail.gmail.com>

On Thu, Mar 21, 2024 at 09:13:35AM -0700, Andrii Nakryiko wrote:
> On Thu, Mar 21, 2024 at 9:02 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Since its going directly to the syscall to avoid not having
> > memfd_create() available in some systems, do the same for its
> > MFD_CLOEXEC flags, defining it if not available.
> >
> > This fixes the build in those systems, noticed while building perf on a
> > set of build containers.
> >
> > Fixes: 9fa5e1a180aa639f ("libbpf: Call memfd_create() syscall directly")
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index efab29b8935bd9f7..635a38c6f947a34d 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -1650,6 +1650,10 @@ static int sys_memfd_create(const char *name, unsigned flags)
> >         return syscall(__NR_memfd_create, name, flags);
> >  }
> >
> > +#ifndef MFD_CLOEXEC
> > +#define MFD_CLOEXEC 0x0001U
> > +#endif
> > +
> 
> makes sense, and lgtm. Do you need it in the bpf or bpf-next tree the
> most? your patch header doesn't specify this

Modern distros don't have this problem, so its not urgent, if bpf-next
is more convenient for you, so be it.

- Arnaldo
 
> 
> >  static int create_placeholder_fd(void)
> >  {
> >         int fd;
> > --
> > 2.44.0
> >
