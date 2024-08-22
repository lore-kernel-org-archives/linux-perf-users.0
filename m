Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C451CB147;
	Thu, 22 Aug 2024 15:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340871; cv=none; b=CrfvxpVt5m4cDOBJSg29c2phyTbJoFgE6euEn48ArJC3wYdKrb2Ab2Ml/cItoBRnADuQmPH4zYXmasgEJOgHr5XPxnvnaAcKYX6mx/oe+iZ4w1J5Y89vVmsx9FZEuHm6go51FpkqLKIDw9WrPWB1B9+PSNGtwLOq31g5F89BQko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340871; c=relaxed/simple;
	bh=5MVYlNkiaPPAnsyr3ZlSbPRbp2R38tq8YVu6j+aJAR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3ONMp7yNP429GTToc9xhyQVEMX5SFNJAMDBi1sNPaH6/A6WtpnbrXaSu6Vw7y7bgNvcdEJwNHWmaYNNBS1JCHXNHkwLP75+91FiTk7tJnt1CTR4iGYXQaeOlWot/XLsco9q94GRxb+IXLmRhZODUnIxbbxYrGX+wuZSVKcC554=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1C1ytT3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1C1ytT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70728C32782;
	Thu, 22 Aug 2024 15:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724340870;
	bh=5MVYlNkiaPPAnsyr3ZlSbPRbp2R38tq8YVu6j+aJAR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1C1ytT3dd3LB2hG6TyKrAVcx09Mh7UVc9kHFCoQi6zg71RNmMwuSqkexUnuXOv9t
	 47x4ZIz9yuvCYJQmX4vH6Dmw0LWXW37TCYu+uQbwpIbFcIFQ+tekTfKkgy4+lCkV63
	 l7NF4FqdPGO7atiyF+GFly5YQlWhBbPTTEnyQhqXeoa4CRs9v+E+aW4jY1YG7ZaQAQ
	 SniylBKxLZsKmhoCwsoSVr/vAI9hMdkQ3BHRBek0bY+F7NLwxaZ5c7mFXaCJu7rTdR
	 1CWHuyK6U+j/cW6S56KaXdkgZLgoHJ38iefNEzTyAL0xWxCCIWpBOOvt5ZHqhas/ta
	 2mMmOWR+K8F+Q==
Date: Thu, 22 Aug 2024 12:34:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: sedat.dilek@gmail.com, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [Linux-6.11-rc4] perf BROKEN with LLVM/Clang 19.1.0-rc3
Message-ID: <ZsdaglSCDdFoBcjQ@x1>
References: <CA+icZUXoJ6BS3GMhJHV3aZWyb5Cz2haFneX0C5pUMUUhG-UVKQ@mail.gmail.com>
 <CA+icZUXpB4KMiRek3MkgCapwoW5TC31L4-TffrV=jdhM1k8=Sg@mail.gmail.com>
 <CAM9d7cgHCJgJb10zaNt7b1Dy=4raiv+a1C1GwrVptNz5Uh+SNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgHCJgJb10zaNt7b1Dy=4raiv+a1C1GwrVptNz5Uh+SNg@mail.gmail.com>

On Wed, Aug 21, 2024 at 01:37:25PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Aug 21, 2024 at 12:37 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > As a workaround:
> >
> > dileks@iniza:~/src/linux/git$ git diff
> > diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> > index 142e9d447ce7..db45e6fe7a21 100644
> > --- a/tools/perf/util/setup.py
> > +++ b/tools/perf/util/setup.py
> > @@ -63,6 +63,8 @@ cflags = getenv('CFLAGS', '').split()
> > cflags += ['-fno-strict-aliasing', '-Wno-write-strings',
> > '-Wno-unused-parameter', '-Wno-redundant-decls' ]
> > if cc_is_clang:
> >     cflags += ["-Wno-unused-command-line-argument" ]
> > +    cflags += ["-Wno-cast-function-type-mismatch" ]
> > +
> > else:
> >     cflags += ['-Wno-cast-function-type' ]
> >
> 
> Thanks for the fix.  I wasn't aware of the issue and the fix
> looks good to me.  I'll add it to perf-tools if nobody objects.

It doesn't work, please see the alternative patch I sent, if you try
that in a clang that doesn't have that warning option, it will fail,
i.e. clang 18 fails with the above patch.

- Arnaldo
 
> Thanks,
> Namhyung
> 
> 
> > dileks@iniza:~/src/linux/git$ ~/bin/perf -vv
> > perf version 6.11.0-rc4
> >                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
> >    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
> >         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
> >                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
> >            debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
> >                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
> >               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> > numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> >               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
> >             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
> >              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
> >             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
> >             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
> >    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
> >           libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
> >                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
> >                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
> >             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> >                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> >                   aio: [ on  ]  # HAVE_AIO_SUPPORT
> >                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
> >               libpfm4: [ on  ]  # HAVE_LIBPFM
> >         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
> >         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
> >  dwarf-unwind-support: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
> >            libopencsd: [ OFF ]  # HAVE_CSTRACE_SUPPORT
> >
> > -Sedat-
