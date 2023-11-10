Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A44414266
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 14:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCdZ7RWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99427C433C7;
	Fri, 10 Nov 2023 14:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699627126;
	bh=C+KPcPJ0xiOfYBsNQBcq0ow25SMTBmVUSpm+S3wSS/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCdZ7RWrAoSZ07s9RUBgyYrXYKd0/a8XkPQQifmwPQ41xlbx97m4Y+H2CIk+M1joS
	 r5dItCygdZdaVxErhsx3lGV1SQ3V326RstrvYEHjauQLD3iKR00wua0VzCjCyojCu7
	 KZBTD0zw69SlhShYb/YXrkzBM/4AVQYt/dwON6DW82tWOWXXWWi+kkA9P/V55jOmWl
	 PwN90CFFZIUrOAIiOczfE9TbGp1PepS7iqNYHab7F1u6hQ/Gu+xHcQtYD88tkv7d9X
	 c9hKLCo6/6FUEOGsTPge4CULet5+9DzXLc91SFZrB7i6m8GEK/004YGkK36PnWxhOR
	 u630AzAMD/aHA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 48E7F40094; Fri, 10 Nov 2023 11:38:43 -0300 (-03)
Date: Fri, 10 Nov 2023 11:38:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v6 1/4] perf check: introduce check subcommand
Message-ID: <ZU5AcywaEAM1zUvG@kernel.org>
References: <20231021150526.2231803-1-adityag@linux.ibm.com>
 <20231021150526.2231803-2-adityag@linux.ibm.com>
 <ZU493oMRpGgNBrQV@kernel.org>
 <ZU4+3HxUMg7hW52e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZU4+3HxUMg7hW52e@kernel.org>
X-Url: http://acmel.wordpress.com

Em Fri, Nov 10, 2023 at 11:31:57AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Nov 10, 2023 at 11:27:42AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Sat, Oct 21, 2023 at 08:35:23PM +0530, Aditya Gupta escreveu:
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
  
> > Right after applying this first patch:
  
> > [acme@quaco perf-tools-next]$ m
> > make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
> > builtin-check.c:53:56: error: expected ‘}’ before ‘;’ token
> >    53 |         FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL);
> >       |                                                        ^
> > builtin-check.c:29:47: note: to match this ‘{’
> >    29 | struct feature_support supported_features[] = {
> >       |                                               ^
> > make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:106: /tmp/build/perf-tools-next/builtin-check.o] Error 1
> > make[3]: *** Waiting for unfinished jobs....
> > make[2]: *** [Makefile.perf:669: /tmp/build/perf-tools-next/perf-in.o] Error 2
> > make[1]: *** [Makefile.perf:242: sub-make] Error 2
> > make: *** [Makefile:113: install-bin] Error 2
> > make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
 
> It was a simple error, please be more careful next time.
 
> I'm testing the rest of the patchset now.

Please resubmit when you address the problem fixed with this patch and:

Mussing newline, why print the version again? What is that "perf check "
prefix for?

[acme@quaco perf-tools-next]$ perf check --feature traceevent
perf check 6.6.rc1.g78fa196349bc
Feature not known: traceevent[acme@quaco perf-tools-next]$

Why should we require "--feature"? The following format is descriptive
enough:

[acme@quaco perf-tools-next]$
[acme@quaco perf-tools-next]$ perf check traceevent
perf check 6.6.rc1.g78fa196349bc
[acme@quaco perf-tools-next]$

So I had to go back and use:

[acme@quaco perf-tools-next]$ perf -vv
perf version 6.6.rc1.g78fa196349bc
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
                  zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                  lzma: [ on  ]  # HAVE_LZMA_SUPPORT
             get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                   bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                   aio: [ on  ]  # HAVE_AIO_SUPPORT
                  zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
               libpfm4: [ on  ]  # HAVE_LIBPFM
         libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
         bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
[acme@quaco perf-tools-next]$

To see (some) of the features, please add a:

# perf check --list-features

So that we can get that features array printed.

Some other feature requests:

[acme@quaco perf-tools-next]$ perf check --feature libtraceevent,libbpf_support
perf check 6.6.rc1.g78fa196349bc
Feature not known: libtraceevent,libbpf_support[acme@quaco perf-tools-next]$

This should return true if both are available.

Also, shouldn't be --quiet be the default since this is being designed
for use in scripts?

- Arnaldo
 
> - Arnaldo
> 
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> index 1183983e4352798d..1502804780507b5d 100644
> --- a/tools/perf/builtin-check.c
> +++ b/tools/perf/builtin-check.c
> @@ -50,7 +50,7 @@ struct feature_support supported_features[] = {
>  	FEATURE_SUPPORT("zstd", HAVE_ZSTD_SUPPORT),
>  	FEATURE_SUPPORT("libpfm4", HAVE_LIBPFM),
>  	FEATURE_SUPPORT("libtraceevent", HAVE_LIBTRACEEVENT),
> -	FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL);
> +	FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL),
>  
>  	/* this should remain at end, to know the array end */
>  	FEATURE_SUPPORT(NULL, _)

-- 

- Arnaldo
