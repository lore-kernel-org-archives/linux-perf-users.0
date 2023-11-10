Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A072032A
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC38118
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 14:46:58 -0800 (PST)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1cc3c51f830so22028605ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 14:46:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699656418; x=1700261218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQGPvpAIu6DtbvZcWUEjYeGsJQgajVNe80T0UcYtsAM=;
        b=jkPUoSj1/XygN5LR8J3BFyDo7GL4+8gz6nU7RquQEewGpic4ifwPcypSAaBsMjBuRV
         a4oLw4l6QpeGrHqeQHFWqFcjNdRwhmwR9AszSbZ4DlLVkVC6VPx4ES2jurOpQDPLOXkG
         xrbySJQNuk5rVipuaKE3vIk7tvJCRWgts9/sqwVBmmp4vyp6ASBJZjq/TnXF2W038tTb
         VttPXZuK3VtORnHHEPtoj9fGQibJSq9eMaQkDUhvej0Ea2Es44OlkJ4WuaqrlIWNn3uk
         VexhWoihb8wYAVjRhHm2JronhXQT/ZKyG8ZDsXjFMyC3hz5rKYlDtWF1cLeZYslccFMW
         YXkw==
X-Gm-Message-State: AOJu0YzPSJvZZhR2QS2lMlmK/CKlQLePwr7QI8isHCiSj6FcLEkbv37L
	ojcyWT5wgkpcvPrjRwqwjkGOuh3ryLDjFAUemJU=
X-Google-Smtp-Source: AGHT+IG4a0OuZBPJ870LHETRz7nEOCzMrXREufwJ1Q+yxPEw/bIjD+PqeW3FXSxNgQdglj1Y+5X1PZTgW72HhZbGY5s=
X-Received: by 2002:a17:90b:1e08:b0:27c:f8bd:9a98 with SMTP id
 pg8-20020a17090b1e0800b0027cf8bd9a98mr343211pjb.40.1699656418118; Fri, 10 Nov
 2023 14:46:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231021150526.2231803-1-adityag@linux.ibm.com>
 <20231021150526.2231803-2-adityag@linux.ibm.com> <ZU493oMRpGgNBrQV@kernel.org>
 <ZU4+3HxUMg7hW52e@kernel.org> <ZU5AcywaEAM1zUvG@kernel.org>
In-Reply-To: <ZU5AcywaEAM1zUvG@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 10 Nov 2023 14:46:46 -0800
Message-ID: <CAM9d7cjJckDtP8Xhw4fFc7gk98fQQbHQ2nBpoWcikUgASRHgUw@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] perf check: introduce check subcommand
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Aditya Gupta <adityag@linux.ibm.com>, jolsa@kernel.org, irogers@google.com, 
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com, 
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 6:38=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Nov 10, 2023 at 11:31:57AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Fri, Nov 10, 2023 at 11:27:42AM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > Em Sat, Oct 21, 2023 at 08:35:23PM +0530, Aditya Gupta escreveu:
> > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
>
> > > Right after applying this first patch:
>
> > > [acme@quaco perf-tools-next]$ m
> > > make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
> > > builtin-check.c:53:56: error: expected =E2=80=98}=E2=80=99 before =E2=
=80=98;=E2=80=99 token
> > >    53 |         FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL);
> > >       |                                                        ^
> > > builtin-check.c:29:47: note: to match this =E2=80=98{=E2=80=99
> > >    29 | struct feature_support supported_features[] =3D {
> > >       |                                               ^
> > > make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.bui=
ld:106: /tmp/build/perf-tools-next/builtin-check.o] Error 1
> > > make[3]: *** Waiting for unfinished jobs....
> > > make[2]: *** [Makefile.perf:669: /tmp/build/perf-tools-next/perf-in.o=
] Error 2
> > > make[1]: *** [Makefile.perf:242: sub-make] Error 2
> > > make: *** [Makefile:113: install-bin] Error 2
> > > make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
>
> > It was a simple error, please be more careful next time.
>
> > I'm testing the rest of the patchset now.
>
> Please resubmit when you address the problem fixed with this patch and:
>
> Mussing newline, why print the version again? What is that "perf check "
> prefix for?
>
> [acme@quaco perf-tools-next]$ perf check --feature traceevent
> perf check 6.6.rc1.g78fa196349bc
> Feature not known: traceevent[acme@quaco perf-tools-next]$
>
> Why should we require "--feature"? The following format is descriptive
> enough:

I thought we might want to extend the functionality of the check
command later.  Maybe we can check how many perf counters
are supported or which sysctl settings are affected and so on.

Maybe we need to make '--feature' option to a sub-command
like `perf check feature xxx`.  So it cannot be mixed with others
later.

>
> [acme@quaco perf-tools-next]$
> [acme@quaco perf-tools-next]$ perf check traceevent
> perf check 6.6.rc1.g78fa196349bc
> [acme@quaco perf-tools-next]$
>
> So I had to go back and use:
>
> [acme@quaco perf-tools-next]$ perf -vv
> perf version 6.6.rc1.g78fa196349bc
>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>          syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
>                 libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
>             debuginfod: [ on  ]  # HAVE_DEBUGINFOD_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
>                    aio: [ on  ]  # HAVE_AIO_SUPPORT
>                   zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
>                libpfm4: [ on  ]  # HAVE_LIBPFM
>          libtraceevent: [ on  ]  # HAVE_LIBTRACEEVENT
>          bpf_skeletons: [ on  ]  # HAVE_BPF_SKEL
> [acme@quaco perf-tools-next]$
>
> To see (some) of the features, please add a:
>
> # perf check --list-features
>
> So that we can get that features array printed.
>
> Some other feature requests:
>
> [acme@quaco perf-tools-next]$ perf check --feature libtraceevent,libbpf_s=
upport
> perf check 6.6.rc1.g78fa196349bc
> Feature not known: libtraceevent,libbpf_support[acme@quaco perf-tools-nex=
t]$
>
> This should return true if both are available.

Sounds good.

>
> Also, shouldn't be --quiet be the default since this is being designed
> for use in scripts?

I don't know.. users might want to see the result instead
of checking the return value.

     libtraceevent: [ on  ]
    libbpf_support: [ OFF ]

Thanks,
Namhyung
