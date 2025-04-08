Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB8BC148
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Apr 2025 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744092968; cv=none; b=bAJ7iGoS2wl70Tne3BA/5SScf9J9GghuMd2OyTMwsAsj+tGMggFVrOWvf5nbNgZUR+YcB7MLb3oFVOiFrZjgMAaNV04etXxtbBOTqssZETlpIBAQZhqMDuwP7WgpjXEHG4zsk+0jsXUHmEOo6VsVotZstYBu6UaD4WaS8tbIjzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744092968; c=relaxed/simple;
	bh=64TwECKsUtChgLJrqxkHgGcoLC7b/cLXNHgp89Mf01k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7TjYiKFKWmiLLsgkrOWZw4YSTOne2Ay3zbd3YEi+Y3Hb/4zObS8dBfEo73FeLFiBu5ma6RwVCgVqmA1w76z1PU2jIYBUDfwyP09Q5UZ+Aw909uJlIgKqStUP+FIZN9jAfkwnm89DQrnDUGrAmirLGLLaR0qeHtw7kxSuXIG3R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahYm4bXs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahYm4bXs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A03AC4CEE5;
	Tue,  8 Apr 2025 06:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744092967;
	bh=64TwECKsUtChgLJrqxkHgGcoLC7b/cLXNHgp89Mf01k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ahYm4bXs5mT6Yv2JA/8Cac9e7tlckSjjGWBmDf+tO6phfx9Co9khjjKgIt+DOqQpY
	 VtsIQ65drBF4Aiudh9hY15J5J1FIez7il3d/8/JjIESdMe7Hq1bzGsJ8T7HasMSETD
	 mSa7O2KC6RP8g/LQlAmaPE5U8iCrOD8e+WqQUlW9aEW2IlapngrvzicDsheyYq9TFT
	 cTsavqPhej5VaaBdY5wvq/WYwl/c7gI2ShSykhbMZ94DQ8Tj3hb2ygmfb8Z4WUblob
	 1gwMRhWd5dOXz+IuZ1NImknA4XsMbrWP+/MvwO1OEv5zMjv3rqnxyxqwzaHuGew+Nf
	 JuEm5JBmP89YQ==
Date: Mon, 7 Apr 2025 23:16:04 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Howard Chu <howardchu95@gmail.com>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z_S_JB_L_t9viciV@google.com>
References: <20250307080829.354947-1-namhyung@kernel.org>
 <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
 <Z--pWmTHGb62_83e@gmail.com>
 <CAH0uvoi3oaZesWKLtaJRm3AkJx9j-G_Xm66Z276xH5+k11zisQ@mail.gmail.com>
 <Z_QEND63LoxP0h9H@gmail.com>
 <Z_Rz10stoLzBocIO@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_Rz10stoLzBocIO@x1>

On Mon, Apr 07, 2025 at 09:54:47PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Apr 07, 2025 at 06:58:28PM +0200, Ingo Molnar wrote:
> > * Howard Chu <howardchu95@gmail.com> wrote:
>  
> > > > I tried to install the libunwind-19-dev package, I tried to
> > > > uninstall/reinstall - no combination seems to work.
> > > 
> > >  $ apt list --installed | grep libunwind
> > > 
> > > WARNING: apt does not have a stable CLI interface. Use with caution in scripts.
> > > 
> > > libunwind-dev/oracular,now 1.6.2-3.1 amd64 [installed]
> > > libunwind8/oracular,now 1.6.2-3.1 amd64 [installed,automatic]
> > > 
> > > Built perf with make clean install, my libunwind is on.
> > > 
> > > ...                               libunwind: [ on  ]
> > 
> > I seem to have the exact same build environment:
> > 
> >   starship:~> apt list --installed | grep libunwind
> > 
> >   WARNING: apt does not have a stable CLI interface. Use with caution in scripts.
> > 
> >   libunwind-dev/oracular,now 1.6.2-3.1 amd64 [installed]
> >   libunwind8/oracular,now 1.6.2-3.1 amd64 [installed]
> > 
> > Yet:
> > 
> >   Makefile.config:1142: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
> >   Makefile.config:1155: libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev
> >   Makefile.config:1187: libtracefs is missing. Please install libtracefs-dev/libtracefs-devel
> > 
> >   Auto-detecting system features:
> > ...                                   libdw: [ on  ]
> > ...                                   glibc: [ on  ]
> > ...                                  libbfd: [ on  ]
> > ...                          libbfd-buildid: [ on  ]
> > ...                                  libelf: [ on  ]
> > ...                                 libnuma: [ on  ]
> > ...                  numa_num_possible_cpus: [ on  ]
> > ...                                 libperl: [ on  ]
> > ...                               libpython: [ on  ]
> > ...                               libcrypto: [ on  ]
> > ...                               libunwind: [ OFF ]
> > ...                             libcapstone: [ on  ]
> > ...                               llvm-perf: [ on  ]
> > ...                                    zlib: [ on  ]
> > ...                                    lzma: [ on  ]
> > ...                               get_cpuid: [ on  ]
> > ...                                     bpf: [ on  ]
> > ...                                  libaio: [ on  ]
> > ...                                 libzstd: [ on  ]
>  
> > > But when I ran perf check,
>  
> > >  $ perf check feature libunwind
> > >              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT
> 
> > > libunwind is OFF.
>  
> > Same here.
> 
> So, with a patch I have (attached) here this turns into:
> 
> ⬢ [acme@toolbox perf-tools-next]$ perf check feature libunwind
>              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT ( tip: Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to build with it )
> ⬢ [acme@toolbox perf-tools-next]$
> 
> Then I follow the suggestion and install libunwind-devel and build with
> LIBUNWIND=1:
> 
> $ make -k LIBUNWIND=1 O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin
> <SNIP>
> Auto-detecting system features:
> ...                                   libdw: [ on  ]
> ...                                   glibc: [ on  ]
> ...                                  libbfd: [ on  ]
> ...                          libbfd-buildid: [ on  ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]
> ...                  numa_num_possible_cpus: [ on  ]
> ...                                 libperl: [ on  ]
> ...                               libpython: [ on  ]
> ...                               libcrypto: [ on  ]
> ...                               libunwind: [ on  ]
> ...                             libcapstone: [ on  ]
> ...                               llvm-perf: [ on  ]
> ...                                    zlib: [ on  ]
> ...                                    lzma: [ on  ]
> ...                               get_cpuid: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ on  ]
> 
> ⬢ [acme@toolbox perf-tools-next]$ ldd ~/bin/perf | grep unwind
> 	libunwind-x86_64.so.8 => /lib64/libunwind-x86_64.so.8 (0x00007f434eaea000)
> 	libunwind.so.8 => /lib64/libunwind.so.8 (0x00007f434ead0000)
> ⬢ [acme@toolbox perf-tools-next]$
> 
> I need to have that hooked up to tools/build/Makefile.feature, where it
> would find that tip somewhere, i.e. that "Deprecated, use LIBUNWIND=1
> and install libunwind-dev[el] to build with it".
> 
> This all would not happen if when libunwind was turned into an opt-in
> the default output for it had been removed, so that OFF thing wouldn't
> appear on the screen.
> 
> The annotate case is unrelated from what I can see, the preference for
> the disassembler (libcapstone, libllvm or the old method of parsing
> objdump output) has to start with the most capable, and the source code
> part shows that the current order isn't the best, I'll continue the
> investigation/tests tomorrow and will come up with a series of patches
> for the problems reported.
> 
> For reference, from 'perf-config' man page:
> 
> annotate.*::
>         These are in control of addresses, jump function, source code
>         in lines of assembly code from a specific program.
> 
>         annotate.disassemblers::
>                 Choose the disassembler to use: "objdump", "llvm",  "capstone",
>                 if not specified it will first try, if available, the "llvm" one,
>                 then, if it fails, "capstone", and finally the original "objdump"
>                 based one.
> 
>                 Choosing a different one is useful when handling some feature that
>                 is known to be best support at some point by one of the options,
>                 to compare the output when in doubt about some bug, etc.
> 
>                 This can be a list, in order of preference, the first one that works
>                 finishes the process.
> 
> A quick test here with perf top without setting the above ends up with
> the behaviour that Ingo reported, no source code is shown and 's'
> doesn't work. Then if I set it to use objdump:
> 
> root@number:~# perf config annotate.disassemblers=objdump
> root@number:~# perf config annotate.disassemblers
> annotate.disassemblers=objdump
> root@number:~# cat ~/.perfconfig 
> # this file is auto-generated.
> [annotate]
> 	disassemblers = objdump
> root@number:~#
> 
> It takes longer to show the annotated output but there is source code
> and 's' works.

Thanks for chasing it down, we miss source line support in the disasm
using capstone and libllvm.  We can add that later but for now we may
refresh the result and force to objdump when source line is requested.

Thanks,
Namhyung

> 
> - Arnaldo

> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> index 61a11a9b4e7594bf..e2cfff18de299367 100644
> --- a/tools/perf/builtin-check.c
> +++ b/tools/perf/builtin-check.c
> @@ -43,7 +43,7 @@ struct feature_status supported_features[] = {
>  	FEATURE_STATUS("libpython", HAVE_LIBPYTHON_SUPPORT),
>  	FEATURE_STATUS("libslang", HAVE_SLANG_SUPPORT),
>  	FEATURE_STATUS("libtraceevent", HAVE_LIBTRACEEVENT),
> -	FEATURE_STATUS("libunwind", HAVE_LIBUNWIND_SUPPORT),
> +	FEATURE_STATUS_TIP("libunwind", HAVE_LIBUNWIND_SUPPORT, "Deprecated, use LIBUNWIND=1 and install libunwind-dev[el] to build with it"),
>  	FEATURE_STATUS("lzma", HAVE_LZMA_SUPPORT),
>  	FEATURE_STATUS("numa_num_possible_cpus", HAVE_LIBNUMA_SUPPORT),
>  	FEATURE_STATUS("zlib", HAVE_ZLIB_SUPPORT),
> @@ -65,22 +65,17 @@ static void on_off_print(const char *status)
>  	printf(" ]");
>  }
>  
> -/* Helper function to print status of a feature along with name/macro */
> -static void status_print(const char *name, const char *macro,
> -			 const char *status)
> +void feature_status__printf(const struct feature_status *feature)
>  {
> -	printf("%22s: ", name);
> -	on_off_print(status);
> -	printf("  # %s\n", macro);
> -}
> +	printf("%22s: ", feature->name);
> +	on_off_print(feature->is_builtin ? "on" : "OFF");
> +	printf("  # %s", feature->macro);
> +
> +	if (!feature->is_builtin && feature->tip)
> +		printf(" ( tip: %s )", feature->tip);
>  
> -#define STATUS(feature)                                           \
> -do {                                                              \
> -	if (feature.is_builtin)                                   \
> -		status_print(feature.name, feature.macro, "on");  \
> -	else                                                      \
> -		status_print(feature.name, feature.macro, "OFF"); \
> -} while (0)
> +	putchar('\n');
> +}
>  
>  /**
>   * check whether "feature" is built-in with perf
> @@ -95,7 +90,7 @@ static int has_support(const char *feature)
>  		if ((strcasecmp(feature, supported_features[i].name) == 0) ||
>  		    (strcasecmp(feature, supported_features[i].macro) == 0)) {
>  			if (!quiet)
> -				STATUS(supported_features[i]);
> +				feature_status__printf(&supported_features[i]);
>  			return supported_features[i].is_builtin;
>  		}
>  	}
> diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
> index e149d96c6dc57c22..10f25c6705b117a2 100644
> --- a/tools/perf/builtin-version.c
> +++ b/tools/perf/builtin-version.c
> @@ -26,38 +26,10 @@ static const char * const version_usage[] = {
>  	NULL
>  };
>  
> -static void on_off_print(const char *status)
> -{
> -	printf("[ ");
> -
> -	if (!strcmp(status, "OFF"))
> -		color_fprintf(stdout, PERF_COLOR_RED, "%-3s", status);
> -	else
> -		color_fprintf(stdout, PERF_COLOR_GREEN, "%-3s", status);
> -
> -	printf(" ]");
> -}
> -
> -static void status_print(const char *name, const char *macro,
> -			 const char *status)
> -{
> -	printf("%22s: ", name);
> -	on_off_print(status);
> -	printf("  # %s\n", macro);
> -}
> -
> -#define STATUS(feature)                                   \
> -do {                                                      \
> -	if (feature.is_builtin)                               \
> -		status_print(feature.name, feature.macro, "on");  \
> -	else                                                  \
> -		status_print(feature.name, feature.macro, "OFF"); \
> -} while (0)
> -
>  static void library_status(void)
>  {
>  	for (int i = 0; supported_features[i].name; ++i)
> -		STATUS(supported_features[i]);
> +		feature_status__printf(&supported_features[i]);
>  }
>  
>  int cmd_version(int argc, const char **argv)
> diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
> index a07e93c5384878d3..51f8f1f26813fb32 100644
> --- a/tools/perf/builtin.h
> +++ b/tools/perf/builtin.h
> @@ -5,6 +5,7 @@
>  struct feature_status {
>  	const char *name;
>  	const char *macro;
> +	const char *tip;
>  	int is_builtin;
>  };
>  
> @@ -13,7 +14,16 @@ struct feature_status {
>  	.macro = #macro_,                  \
>  	.is_builtin = IS_BUILTIN(macro_) }
>  
> +#define FEATURE_STATUS_TIP(name_, macro_, tip_) { \
> +	.name = name_,                     \
> +	.macro = #macro_,                  \
> +	.tip = tip_,			   \
> +	.is_builtin = IS_BUILTIN(macro_) }
> +
>  extern struct feature_status supported_features[];
> +
> +void feature_status__printf(const struct feature_status *feature);
> +
>  struct cmdnames;
>  
>  void list_common_cmds_help(void);

