Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B7C368E03;
	Thu, 20 Nov 2025 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666580; cv=none; b=SJmn3mvj8VSplMCB+POT2tTgQUlcEm7q5KbI2Tlj45NxcYHsgscumFzcYC35S4kVcn3SX+vdjcenFUC+d4TLKxe2cpXsrfP83lrORcoH289oIXWVZQ+a1WjHbNgWVGgQpoH3a9+If7aSYXH9S+dZLcQGHBPc0RIlODpyVlhEr0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666580; c=relaxed/simple;
	bh=YPGubKINGZqJbiLeSuPo53PeN2/J0YT4+7G2RbocRrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d67HrGhXKeCdip/stV6lB9Ybsi94TEjZ3jEgBPnco4G3JBbkedxuWUozZepDtx5qsmdIkfg+eF34ElUOgKm+MXhfmW0ce3gKo3CYljKlR3uz0JNWH8PavX31xBKYhRrg7WMf4i5pS1YR1CYVBv4vFL+VSWu0rcxUHRcGZwquVXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWDGve6v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWDGve6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95E6C19423;
	Thu, 20 Nov 2025 19:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763666579;
	bh=YPGubKINGZqJbiLeSuPo53PeN2/J0YT4+7G2RbocRrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWDGve6v4Vt608RstA/o1Ut996nY5D5yCOY0rTq8ugnIwKK1qHZvUf6yqXI4HqzxS
	 QKqINfH6kmahWvTmLrtYxGr8+VhWDCshe4Id5xvjyurPcKTdPQIBghxDQ7/ADvdeKr
	 oOEmKfJhhRYuEHYAI0WyVMynn6AqrnbM5B68VkG9zQ/zrlZ77FVY1hhs3w3hqcix/F
	 wNr7adKO8xAlPlV0SUSqyQIRdfzkLekwXmk3zvF4t46nFdk/VMzKStbIfu2S00eKEB
	 tVfbq1uHpT2T04vGUETsLDSNewLkpT5yXX3Cwb4gGa6HpdQcJhOn+W+N6qUvEMFY0B
	 mucYmEPAFNi1Q==
Date: Thu, 20 Nov 2025 11:22:56 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: hupu <hupu.gm@gmail.com>
Cc: Leo Yan <leo.yan@arm.com>, acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	jolsa@kernel.org, justinstitt@google.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, morbo@google.com,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	peterz@infradead.org
Subject: Re: [PATCH] perf build: Support passing extra Clang options via
 EXTRA_BPF_FLAGS
Message-ID: <aR9qkB_XY-elMxSh@google.com>
References: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
 <20251020024049.6877-1-hupu.gm@gmail.com>
 <aPW3rilb8DtFDIMC@google.com>
 <20251020101523.GE281971@e132581.arm.com>
 <CADHxFxQjMy9n7G1dUX=HLi3b5VFjMd8YpBP7DOQyOdaQp443mA@mail.gmail.com>
 <CADHxFxTHYwjqAjURTbkZ=6-4Ti0GGc7uKsrjthL9s78rAgv5EA@mail.gmail.com>
 <CADHxFxT9fXfKVDXWxoFs0KeG+gssNhZE3y6TGKGtS=AhKPdGAg@mail.gmail.com>
 <CADHxFxR2t4jMmjm3hMdhsxoRjUw+k3CtrG6ZzG39b_BhVzyzsQ@mail.gmail.com>
 <CADHxFxROMe++VB17J3UgOxSoEhJ7bNagBHO6gRQQPpAELc1ocw@mail.gmail.com>
 <CADHxFxTHHT0bWf__dwnZXk6E8Qb2sxL5=L5KDh_Xmzq-hNYs6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADHxFxTHHT0bWf__dwnZXk6E8Qb2sxL5=L5KDh_Xmzq-hNYs6g@mail.gmail.com>

Hello,

On Wed, Nov 19, 2025 at 05:43:41PM +0800, hupu wrote:
> RESEND
> 
> On Tue, Nov 18, 2025 at 3:28 PM hupu <hupu.gm@gmail.com> wrote:
> >
> > Hi Leo and Namhyung,
> >
> > On Tue, Nov 18, 2025 at 3:18 PM hupu <hupu.gm@gmail.com> wrote:
> > >
> > > I then added KHDR_INCLUDES to BPF_INCLUDE, pointing it to the kernel’s
> > > self-contained header directory so that the build prefers headers
> > > provided by the kernel.
> > >
> > >
> > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > index 47c906b807ef..65c6e871988b 100644
> > > --- a/tools/perf/Makefile.perf
> > > +++ b/tools/perf/Makefile.perf
> > > @@ -1202,7 +1202,8 @@ endif
> > >
> > >  CLANG_OPTIONS = -Wall
> > >  CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
> > > -BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES)
> > > +KHDR_INCLUDES := $(abspath $(OUTPUT)/../../usr/include)
> > > +BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE)
> > > -I$(KHDR_INCLUDES) $(CLANG_SYS_INCLUDES)

I think your patch was wrapped around.

> > >  TOOLS_UAPI_INCLUDE := -I$(srctree)/tools/include/uapi
> > >
> > >  ifneq ($(WERROR),0)
> > >
> > >
> > > With this change verified, perf compiles successfully even without
> > > explicitly specifying the cross-toolchain sysroot in the compile
> > > command.

I'm not familiar with the usr directory in the kernel source.  Will it
contain some generated headers?

> > >
> >
> > As an additional suggestion, I’d prefer to keep both the above patch
> > and the previously discussed PATCH v3, which would mean submitting two
> > PRs. From my perspective, allowing users to pass custom compilation
> > options via EXTRA_BPF_FLAGS is more flexible than only configuring
> > headers, so I’d like to hear your thoughts.

Yep, I'm ok with the extra flag variable.

Thanks,
Namhyung

