Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44042214231
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 16:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744045113; cv=none; b=R/LrxPZ/4scfzxKigMk/HNHKac/xwjtD6gG28rzssAshRdvDbw6c51ED89VZrGvGWuKHrSY9fyOIPneY1YI1LgcfPiSF8hAXSUA0N9M2qBjKkuy+5dv+JyCDVmd094vtLU/hBWWYnvtN7Zn3N0JiY5Rxg2UDx+riu6hMI/8hFEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744045113; c=relaxed/simple;
	bh=8uBl5xetO74otnGRIuab+Nmzbo2n6DcXQC8u8ewKATg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/ghvH+oUM+MCxytSHnAH0H1jUWTKoJ2M2CO/9QKxGFXocMtN+vkUpI3oJOY5TOC69nvCtua0KCb/z5J7kCHxDJZtE+OLoQ8ogrLZJ6meR4qzl1ZziG3F9k/yZ6LezAPbsiHf3+n7K3G6re3J4FNDM/tWEit2xp5gu8zplFt9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFN+RINO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFN+RINO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1871C4CEE9;
	Mon,  7 Apr 2025 16:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744045113;
	bh=8uBl5xetO74otnGRIuab+Nmzbo2n6DcXQC8u8ewKATg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XFN+RINOkkuzLO4Hw2un1BI07Psv85F8zbGLXQYFuoQMERtdGCizcK2wRgOqxfXIY
	 0zTrkLY/ddaDO14y0WouTib9psVoLyvdc8Q76iP6IDzXWjFZ0LD5g1hbwcx1Mj0DHE
	 f+lsCTNiQHrogyuj6cFs6JJG313Moqz4Cgh4ZnKlHiTTDyjmgPDwR87uHkXQExc/QK
	 ryXCs9KENUN1owpg1BM5cnifiPPndDqsUlRE1MtfL7QcaFkySTn4BYp7fWatnGJ6l0
	 4NT9esBfFxG230HuMo98wGedAdSlY7MHPfRDrvGhUWZw5kLlsO26hm+FFX0Hpsnzk2
	 au66BIC8feh/A==
Date: Mon, 7 Apr 2025 18:58:28 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [perf top] annotation doesn't work, libunwind doesn't seem to be
 working either
Message-ID: <Z_QEND63LoxP0h9H@gmail.com>
References: <20250307080829.354947-1-namhyung@kernel.org>
 <Z9tjKcKvjYgbR6hb@google.com>
 <Z9vgt1pjiNbDBDbM@gmail.com>
 <Z9w_aFlzOkoCTSqK@google.com>
 <Z-EJnye74la1triY@gmail.com>
 <Z--pWmTHGb62_83e@gmail.com>
 <CAH0uvoi3oaZesWKLtaJRm3AkJx9j-G_Xm66Z276xH5+k11zisQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH0uvoi3oaZesWKLtaJRm3AkJx9j-G_Xm66Z276xH5+k11zisQ@mail.gmail.com>


* Howard Chu <howardchu95@gmail.com> wrote:

> > I tried to install the libunwind-19-dev package, I tried to
> > uninstall/reinstall - no combination seems to work.
> 
>  $ apt list --installed | grep libunwind
> 
> WARNING: apt does not have a stable CLI interface. Use with caution in scripts.
> 
> libunwind-dev/oracular,now 1.6.2-3.1 amd64 [installed]
> libunwind8/oracular,now 1.6.2-3.1 amd64 [installed,automatic]
> 
> Built perf with make clean install, my libunwind is on.
> 
> ...                               libunwind: [ on  ]

I seem to have the exact same build environment:

  starship:~> apt list --installed | grep libunwind

  WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

  libunwind-dev/oracular,now 1.6.2-3.1 amd64 [installed]
  libunwind8/oracular,now 1.6.2-3.1 amd64 [installed]

Yet:

  Makefile.config:1142: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
  Makefile.config:1155: libpfm4 not found, disables libpfm4 support. Please install libpfm4-dev
  Makefile.config:1187: libtracefs is missing. Please install libtracefs-dev/libtracefs-devel

  Auto-detecting system features:
...                                   libdw: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ OFF ]
...                             libcapstone: [ on  ]
...                               llvm-perf: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]




> 
> But when I ran perf check,
> 
>  $ perf check feature libunwind
>              libunwind: [ OFF ]  # HAVE_LIBUNWIND_SUPPORT
> 
> libunwind is OFF.

Same here.

Thanks,

	Ingo
