Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D2A1E517
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719584697; cv=none; b=MHGKUeIhtpM7JvX75F9ECktUl+b/fBr23/I8lbk5xZepQLb9Fjif8gRdOrjBh33RrCF/OLWc+e8k04kXutdlUpuGj8MMKHkLTkekFpQBiF8uMuXNe7HjgxLPTWZewvGUiQg6DRfJqIbsYZGqaxVYYhowfKXbEbRLdcPKaasL8vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719584697; c=relaxed/simple;
	bh=X1810e2Oe/GIjZAP2/QW/UpIBWH4S5qikBGkP9IRpVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNyQC+l42UOGxkdjeBM3z3WYGArN+nQV3cjCZQGBvM27kEMkB9fIruBw4lW/uXkag2jSfWYBrgOnpV+hvCGPMLv4MLYKq6i7qjnu6nd4NjKHw7YEOP/ZY1o//jnS12tFAgsMbFeshahZ6VvJAbke0WSPOWZKxBAaU6G2nuIHKeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMOb2KfG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMOb2KfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C379C116B1;
	Fri, 28 Jun 2024 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719584697;
	bh=X1810e2Oe/GIjZAP2/QW/UpIBWH4S5qikBGkP9IRpVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMOb2KfGizOe4OfhoF89F2KNuKokqlai7DeBGGYJ9qqCJUpx2U/ZRTe6jt5GBfV5b
	 8JHpcDd7XjA0r/hTkRONliomBIhdZ0mqphIfXDWojkaNaf/LHn/Ywu3BrUdWB6OmNR
	 M64H8nE6O9BGFQm6kESktdlr3OxfC9WaD/e8/mYlyMN/IMi/EDSTwtP+06ISobSLMe
	 HQ77HCbwPxVxWiMpqdtkwUI4kYb1uErnFItyUhk1HwCElrmgb305MOb23E4Er39FM6
	 LUYgwsApxVG8gSraC1dH0eddWvwb6KklaAxAcVCqTMIFFXbdYLAWzujdeVaptal7Gh
	 Ar61gTKB8SXtA==
Date: Fri, 28 Jun 2024 11:24:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v11 1/4] perf check: introduce check subcommand
Message-ID: <Zn7HtaJb3NL2k5YG@x1>
References: <20240627100644.772219-1-adityag@linux.ibm.com>
 <20240627100644.772219-2-adityag@linux.ibm.com>
 <Zn7EvDbsnlbLXj4g@x1>
 <Zn7FmltYgUzi6YvV@x1>
 <Zn7GsEKwLxn5bMyN@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zn7GsEKwLxn5bMyN@x1>

On Fri, Jun 28, 2024 at 11:20:35AM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Jun 28, 2024 at 11:15:57AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Jun 28, 2024 at 11:12:16AM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Thu, Jun 27, 2024 at 03:36:41PM +0530, Aditya Gupta wrote:
> > > > Currently the presence of a feature is checked with a combination of
> > > > perf version --build-options and greps, such as:
> > > > 
> > > >     perf version --build-options | grep " on .* HAVE_FEATURE"
> > > > 
> > > > Instead of this, introduce a subcommand "perf check feature", with which
> > > > scripts can test for presence of a feature, such as:
> > > > 
> > > >     perf check feature HAVE_FEATURE
> > > > 
> > > > 'perf check feature' command is expected to have exit status of 0 if
> > > > feature is built-in, and 1 if it's not built-in or if feature is not known.
> > > > 
> > > > Multiple features can also be passed as a comma-separated list, in which
> > > > case the exit status will be 1 only if all of the passed features are
> > > > built-in. For example, with below command, it will have exit status of 0
> > > > only if both libtraceevent and bpf are enabled, else 1 in all other cases
> > > > 
> > > >     perf check feature libtraceevent,bpf
> > > > 
> > > > The arguments are case-insensitive.
> > > > An array 'supported_features' has also been introduced that can be used by
> > > > other commands like 'perf version --build-options', so that new features
> > > > can be added in one place, with the array
> > 
> > Now testing it with just this first patch applied:
> > 
> > ⬢[acme@toolbox perf-tools-next]$ perf check feature bpf
> >                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> > ⬢[acme@toolbox perf-tools-next]$ echo $?
> > 0
> > ⬢[acme@toolbox perf-tools-next]$ perf check bpf,libtrafs
> > 
> >  Usage: perf check [<subcommand>] [<options>]
> > 
> >     -q, --quiet           do not show any warnings or messages
> > 
> > ⬢[acme@toolbox perf-tools-next]$
> > 
> > 
> > I don't see a way to list what features can be tested against, would be
> > great to have.
> > 
> > Also it just says that the usage is wrong, no indication as to why, I
> > think this would be more informative:
> > 
> > 
> > ⬢[acme@toolbox perf-tools-next]$ perf check bpf,libtrafs
> > Unkown feature 'libtrafs', please use 'perf check feature --list' to see which ones are available.

Or:

⬢[acme@toolbox perf-tools-next]$ perf version --build-options
perf version 6.10.rc1.g25cd7047ff7b
                 dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
    dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
         syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
            debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
                libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
               libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
             libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
              libslang: [ on  ]  # HAVE_SLANG_SUPPORT
             libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
             libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
    libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
           libcapstone: [ on  ]  # HAVE_LIBCAPSTONE_SUPPORT
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
               libpfm4: [ on  ]  # HAVE_LIBPFM
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
  dwarf-unwind-support: [ on  ]  # HAVE_DWARF_UNWIND_SUPPORT
            libopencsd: [ on  ]  # HAVE_CSTRACE_SUPPORT
⬢[acme@toolbox perf-tools-next]$

I.e.:

Unkown feature 'libtrafs', please use 'perf version --build-options' to see which ones are available.

And while looking at it:

             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT

This looks wrong, no? Or at least confusing, have to check the source
code...

Also:

               libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT

- Arnaldo

> > ⬢[acme@toolbox perf-tools-next]$
> 
> Ah, to clarify, these comments are for the v12 series even being replies
> to the v11 thread, I'll move to the v12 e-mail thread. Using b4 I got
> the latest version, v12:
> 
> Cover: ./v12_20240628_adityag_introduce_perf_check_subcommand.cover
>  Link: https://lore.kernel.org/r/20240628064236.1123851-1-adityag@linux.ibm.com
>  Base: applies clean to current tree
>        git checkout -b v12_20240628_adityag_linux_ibm_com HEAD
>        git am ./v12_20240628_adityag_introduce_perf_check_subcommand.mbx
> ⬢[acme@toolbox perf-tools-next]$        git am ./v12_20240628_adityag_introduce_perf_check_subcommand.mbx
> Applying: perf check: introduce check subcommand
> Applying: perf version: update --build-options to use 'supported_features' array
> Applying: perf tests task_analyzer: use perf check for libtraceevent support
> Applying: tools/perf/tests: Update probe_vfs_getname.sh script to use perf check feature
> ⬢[acme@toolbox perf-tools-next]$
