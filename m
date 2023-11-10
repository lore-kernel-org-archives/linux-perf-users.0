Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347219BA1
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRK34Gl+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9323C433C8;
	Fri, 10 Nov 2023 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699626464;
	bh=vABqTUG15/TCLxIJzBw2LkjGUi14nnOi5/UWq1cwKsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gRK34Gl+5vehG9JwGPv5MzDp2sUC/zPg8NQ3DFsSpE3YjNGT37u6sZwhSu/tiPjgx
	 YK9onBbD3DUvBHfduxfiwJ/By/UJZY7DtifCAuiYNJf+cq9r38GZxl6K4Z63J2RTXy
	 EnXi2qbwR7R66UHe8znyzBqPsNkwzmGzdWW9gwL2RDsi8hZoY7tZ7EVh/l6Bh7ymI2
	 e7pxXzY79Ekjmhl6OnSZNscHyBoCmoiSByCeI5MOhYsiYUJGPpkpTqdHJauRHDRyDZ
	 vwjYJNTvAb5upDPzig7ls4x8RxQ8quegek/E4Fp/HGgt6ZlJvlVXi4J0cYv2+UvuwW
	 +8SDBzzX8rmTw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 29C0940094; Fri, 10 Nov 2023 11:27:42 -0300 (-03)
Date: Fri, 10 Nov 2023 11:27:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: jolsa@kernel.org, irogers@google.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
	atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v6 1/4] perf check: introduce check subcommand
Message-ID: <ZU493oMRpGgNBrQV@kernel.org>
References: <20231021150526.2231803-1-adityag@linux.ibm.com>
 <20231021150526.2231803-2-adityag@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231021150526.2231803-2-adityag@linux.ibm.com>
X-Url: http://acmel.wordpress.com

Em Sat, Oct 21, 2023 at 08:35:23PM +0530, Aditya Gupta escreveu:
> Currently the presence of a feature is checked with a combination of
> perf version --build-options and greps, such as:
> 
>     perf version --build-options | grep " on .* HAVE_FEATURE"
> 
> Instead of this, introduce a subcommand "perf check --feature", with which
> scripts can test for presence of a feature, such as:
> 
>     perf check --feature HAVE_FEATURE
> 
> 'perf check --feature' command is expected to have exit status of 0 if
> feature is built-in, and 1 if it's not built-in or if feature is not known.
> 
> An array 'supported_features' has also been introduced that can be used by
> other commands like 'perf version --build-options', so that new features
> can be added in one place, with the array
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

Right after applying this first patch:

[acme@quaco perf-tools-next]$ m
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
  BUILD:   Doing 'make -j8' parallel build
Warning: Kernel ABI header differences:
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
  diff -u tools/include/uapi/linux/mount.h include/uapi/linux/mount.h
  diff -u tools/include/uapi/linux/perf_event.h include/uapi/linux/perf_event.h
  diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/asm/disabled-features.h
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
  diff -u tools/arch/x86/include/uapi/asm/prctl.h arch/x86/include/uapi/asm/prctl.h
  diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/uapi/asm/perf_regs.h
  diff -u tools/arch/s390/include/uapi/asm/kvm.h arch/s390/include/uapi/asm/kvm.h
Makefile.config:1145: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel

  INSTALL libsubcmd_headers
  INSTALL libperf_headers
  INSTALL libsymbol_headers
  INSTALL libapi_headers
  INSTALL libbpf_headers
  CC      /tmp/build/perf-tools-next/builtin-check.o
  CC      /tmp/build/perf-tools-next/builtin-buildid-list.o
  CC      /tmp/build/perf-tools-next/builtin-buildid-cache.o
  CC      /tmp/build/perf-tools-next/builtin-kallsyms.o
  CC      /tmp/build/perf-tools-next/builtin-list.o
  CC      /tmp/build/perf-tools-next/builtin-record.o
  CC      /tmp/build/perf-tools-next/builtin-report.o
  CC      /tmp/build/perf-tools-next/builtin-stat.o
builtin-check.c:53:56: error: expected ‘}’ before ‘;’ token
   53 |         FEATURE_SUPPORT("bpf_skeletons", HAVE_BPF_SKEL);
      |                                                        ^
builtin-check.c:29:47: note: to match this ‘{’
   29 | struct feature_support supported_features[] = {
      |                                               ^
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:106: /tmp/build/perf-tools-next/builtin-check.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [Makefile.perf:669: /tmp/build/perf-tools-next/perf-in.o] Error 2
make[1]: *** [Makefile.perf:242: sub-make] Error 2
make: *** [Makefile:113: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'

 Performance counter stats for 'make -k EXTRA_CFLAGS=-fsanitize=address BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf-tools-next -C tools/perf install-bin':

    26,249,850,723      cycles:u
    34,380,184,715      instructions:u                   #    1.31  insn per cycle

       4.021721145 seconds time elapsed

       7.780017000 seconds user
       1.793663000 seconds sys


[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.002 MB perf.data (9 samples) ]

 Performance counter stats for 'sleep 0.01':

       0.012377637 seconds time elapsed

       0.000000000 seconds user
       0.002203000 seconds sys


[acme@quaco perf-tools-next]$
