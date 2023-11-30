Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8AB4A989
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 14:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKfxRLoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28012C433C8;
	Thu, 30 Nov 2023 14:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701353994;
	bh=VKxrswh9rBTc4rekSC5g2YrBfDsKwnq0c27wKsWH5gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PKfxRLoVYos/v32HejhfZ2yWYCfLL2A+z5mivOMxuCbeKEQiHGNBPwFnxFJ3PxXFK
	 WyyGXEi1o9l0kygc2EMP3b1UHGKwDxWG6mafJYWfnk1aG7Ht81DjvZA7+ChKd+O69n
	 HdE90CKZQAB6PiX/EdrgztI30CXh7HGe5k0wY3gE/YY06N/2uZkMYWuBswC0HdRLnA
	 MEgTbgYOZU9nExmSVW8QcU2O0vmaMhIc5p1JiSKRDy5d75g8s8avC4ccYLU82yUMRv
	 fv7KmIycyDVkESTilzF8pnmRR8Xi5p2ywXP4u80wlh2tRc8xaX0XcpNluijbqWq5gy
	 gITiAab4dW5QA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 99CEC40094; Thu, 30 Nov 2023 11:19:51 -0300 (-03)
Date: Thu, 30 Nov 2023 11:19:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Ming Wang <wangming01@loongson.cn>,
	James Clark <james.clark@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Leo Yan <leo.yan@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	German Gomez <german.gomez@arm.com>,
	Changbin Du <changbin.du@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
	Sandipan Das <sandipan.das@amd.com>,
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Guilherme Amadio <amadio@gentoo.org>
Subject: Re: [PATCH v5 02/50] libperf: Lazily allocate/size mmap event copy
Message-ID: <ZWiaB+ygpN+46JAm@kernel.org>
References: <20231127220902.1315692-1-irogers@google.com>
 <20231127220902.1315692-3-irogers@google.com>
 <ZWiK/9JJjOElTTq7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWiK/9JJjOElTTq7@kernel.org>
X-Url: http://acmel.wordpress.com

Em Thu, Nov 30, 2023 at 10:15:43AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Nov 27, 2023 at 02:08:14PM -0800, Ian Rogers escreveu:
> >  void perf_mmap__munmap(struct perf_mmap *map)
> >  {
> > -	if (map && map->base != NULL) {
> > +	if (!map)
> > +		return;
> > +
> > +	free(map->event_copy);
> > +	map->event_copy = NULL;
> 
> I´m converting this to:
> 
> 	zfree(&map->event_copy);
> 
> Hopefully we'll find some tool to flag these before submitting patches,
> does clang-tidy do these kinds of things?
> 
> Also, applied:
> 
>  b4 am -P2,4-7 -ctsl --cc-trailers 20231127220902.1315692-1-irogers@google.com
> 
> The ones that Namhyung acked and that applied cleanly in order.
> 
> The first one, as Namhyung noted, is already merged.

I'll fix this later:

[perfbuilder@five ~]$ export BUILD_TARBALL=http://192.168.86.5/perf/perf-6.6.0-rc1.tar.xz
[perfbuilder@five ~]$ time dm
   1    16.97 almalinux:8                   : FAIL gcc version 8.5.0 20210514 (Red Hat 8.5.0-20) (GCC)
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
     static inline int io__get_hex(struct io *io, __u64 *hex)
                                                  ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
     static inline int io__get_dec(struct io *io, __u64 *dec)
                                                  ^~~~~
      INSTALL libbpf_headers
      INSTALL libperf_headers
    make[4]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: fs] Error 2
      INSTALL /tmp/build/perf/libperf/include/perf/event.h
      CC      /tmp/build/perf/libperf/mmap.o
      INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_legacy.h
      INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_helpers.h
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
     static inline int io__get_hex(struct io *io, __u64 *hex)
                                                  ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
     static inline int io__get_dec(struct io *io, __u64 *dec)
                                                  ^~~~~
      INSTALL /tmp/build/perf/libperf/include/perf/mmap.h
      INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_tracing.h
      CC      /tmp/build/perf/libperf/zalloc.o
      INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_endian.h
   2    17.28 almalinux:9                   : FAIL gcc version 11.4.1 20230605 (Red Hat 11.4.1-2) (GCC)
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
       94 | static inline int io__get_hex(struct io *io, __u64 *hex)
          |                                              ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
      123 | static inline int io__get_dec(struct io *io, __u64 *dec)
          |                                              ^~~~~
      INSTALL libperf_headers
      INSTALL libbpf_headers
    make[4]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: fs] Error 2
      INSTALL /tmp/build/perf/libperf/include/perf/evlist.h
      INSTALL /tmp/build/perf/libperf/include/perf/evsel.h
      INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_legacy.h
      INSTALL /tmp/build/perf/libperf/include/perf/event.h
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
       94 | static inline int io__get_hex(struct io *io, __u64 *hex)
          |                                              ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
      123 | static inline int io__get_dec(struct io *io, __u64 *dec)
          |                                              ^~~~~
      INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_helpers.h
      INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_tracing.h
      INSTALL /tmp/build/perf/libperf/include/perf/mmap.h
      CC      /tmp/build/perf/libperf/evlist.o
   3    20.71 alpine:3.15                   : FAIL gcc version 10.3.1 20211027 (Alpine 10.3.1_git20211027)
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
       94 | static inline int io__get_hex(struct io *io, __u64 *hex)
          |                                              ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
      123 | static inline int io__get_dec(struct io *io, __u64 *dec)
          |                                              ^~~~~
    make[4]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: fs] Error 2
      CC      /tmp/build/perf/libperf/xyarray.o
      CC      /tmp/build/perf/libperf/lib.o
      LINK    /tmp/build/perf/dlfilters/dlfilter-test-api-v0.so
      LINK    /tmp/build/perf/dlfilters/dlfilter-test-api-v2.so
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
       94 | static inline int io__get_hex(struct io *io, __u64 *hex)
          |                                              ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
      123 | static inline int io__get_dec(struct io *io, __u64 *dec)
          |                                              ^~~~~
    make[5]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:106: /tmp/build/perf/libapi/fs/fs.o] Error 1
    make[5]: *** Waiting for unfinished jobs....
      LD      /tmp/build/perf/libapi/fd/libapi-in.o
    make[4]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: fs] Error 2
   4    20.52 alpine:3.16                   : FAIL gcc version 11.2.1 20220219 (Alpine 11.2.1_git20220219)
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
       94 | static inline int io__get_hex(struct io *io, __u64 *hex)
          |                                              ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
      123 | static inline int io__get_dec(struct io *io, __u64 *dec)
          |                                              ^~~~~
    make[4]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: fs] Error 2
      LINK    /tmp/build/perf/dlfilters/dlfilter-test-api-v2.so
      CC      /tmp/build/perf/libperf/xyarray.o
      INSTALL libperf_headers
      CC      /tmp/build/perf/libperf/lib.o
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
       94 | static inline int io__get_hex(struct io *io, __u64 *hex)
          |                                              ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
      123 | static inline int io__get_dec(struct io *io, __u64 *dec)
          |                                              ^~~~~
    make[5]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:106: /tmp/build/perf/libapi/fs/fs.o] Error 1
    make[5]: *** Waiting for unfinished jobs....
      LD      /tmp/build/perf/libapi/fd/libapi-in.o
    make[4]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: fs] Error 2
   5    19.77 alpine:3.17                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r4)
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
       94 | static inline int io__get_hex(struct io *io, __u64 *hex)
          |                                              ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
      123 | static inline int io__get_dec(struct io *io, __u64 *dec)
          |                                              ^~~~~
      INSTALL libperf_headers
    make[4]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: fs] Error 2
      INSTALL /tmp/build/perf/libperf/include/internal/threadmap.h
      CC      /tmp/build/perf/libperf/xyarray.o
      CC      /tmp/build/perf/libperf/lib.o
      LINK    /tmp/build/perf/dlfilters/dlfilter-test-api-v0.so
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
       94 | static inline int io__get_hex(struct io *io, __u64 *hex)
          |                                              ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
      123 | static inline int io__get_dec(struct io *io, __u64 *dec)
          |                                              ^~~~~
      LINK    /tmp/build/perf/dlfilters/dlfilter-test-api-v2.so
      INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_version.h
      INSTALL /tmp/build/perf/libperf/include/internal/xyarray.h
      INSTALL /tmp/build/perf/libbpf/include/bpf/usdt.bpf.h
   6    17.79 alpine:3.18                   : FAIL gcc version 12.2.1 20220924 (Alpine 12.2.1_git20220924-r10)
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
       94 | static inline int io__get_hex(struct io *io, __u64 *hex)
          |                                              ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
      123 | static inline int io__get_dec(struct io *io, __u64 *dec)
          |                                              ^~~~~
    make[4]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: fs] Error 2
      INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_core_read.h
      INSTALL /tmp/build/perf/libbpf/include/bpf/skel_internal.h
      INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_version.h
      INSTALL /tmp/build/perf/libbpf/include/bpf/usdt.bpf.h
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
       94 | static inline int io__get_hex(struct io *io, __u64 *hex)
          |                                              ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
      123 | static inline int io__get_dec(struct io *io, __u64 *dec)
          |                                              ^~~~~
    make[5]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:106: /tmp/build/perf/libapi/fs/fs.o] Error 1
    make[5]: *** Waiting for unfinished jobs....
      LD      /tmp/build/perf/libapi/fd/libapi-in.o
      LD      /tmp/build/perf/libsymbol/libsymbol-in.o
   7    19.74 alpine:edge                   : FAIL gcc version 13.1.1 20230722 (Alpine 13.1.1_git20230722)
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
       94 | static inline int io__get_hex(struct io *io, __u64 *hex)
          |                                              ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
      123 | static inline int io__get_dec(struct io *io, __u64 *dec)
          |                                              ^~~~~
    make[4]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: fs] Error 2
      CC      /tmp/build/perf/libperf/zalloc.o
      INSTALL /tmp/build/perf/libbpf/include/bpf/bpf.h
      CC      /tmp/build/perf/libperf/xyarray.o
      CC      /tmp/build/perf/libperf/lib.o
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
       94 | static inline int io__get_hex(struct io *io, __u64 *hex)
          |                                              ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
      123 | static inline int io__get_dec(struct io *io, __u64 *dec)
          |                                              ^~~~~
      LINK    /tmp/build/perf/dlfilters/dlfilter-show-cycles.so
      LINK    /tmp/build/perf/dlfilters/dlfilter-test-api-v0.so
      LINK    /tmp/build/perf/dlfilters/dlfilter-test-api-v2.so
      INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf.h
   8    11.61 amazonlinux:2                 : FAIL gcc version 7.3.1 20180712 (Red Hat 7.3.1-17) (GCC)
    In file included from fs/fs.c:19:0:
    fs/../io.h:94:46: error: unknown type name '__u64'; did you mean '_LP64'?
     static inline int io__get_hex(struct io *io, __u64 *hex)
                                                  ^~~~~
                                                  _LP64
    fs/../io.h:123:46: error: unknown type name '__u64'; did you mean '_LP64'?
     static inline int io__get_dec(struct io *io, __u64 *dec)
                                                  ^~~~~
                                                  _LP64
      INSTALL libapi_headers
      INSTALL libsymbol_headers
    make[4]: *** [fs] Error 2
      CC      /tmp/build/perf/libsubcmd/subcmd-config.o
      GEN     /tmp/build/perf/libbpf/bpf_helper_defs.h
      INSTALL /tmp/build/perf/libperf/include/perf/cpumap.h
      CC      /tmp/build/perf/libperf/cpumap.o
    In file included from fs/fs.c:19:0:
    fs/../io.h:94:46: error: unknown type name '__u64'; did you mean '_LP64'?
     static inline int io__get_hex(struct io *io, __u64 *hex)
                                                  ^~~~~
                                                  _LP64
      INSTALL /tmp/build/perf/libbpf/include/bpf/bpf.h
    fs/../io.h:123:46: error: unknown type name '__u64'; did you mean '_LP64'?
     static inline int io__get_dec(struct io *io, __u64 *dec)
                                                  ^~~~~
                                                  _LP64
      INSTALL /tmp/build/perf/libperf/include/perf/threadmap.h
   9    12.89 amazonlinux:2023              : FAIL gcc version 11.4.1 20230605 (Red Hat 11.4.1-2) (GCC)
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
       94 | static inline int io__get_hex(struct io *io, __u64 *hex)
          |                                              ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
      123 | static inline int io__get_dec(struct io *io, __u64 *dec)
          |                                              ^~~~~
    make[4]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: fs] Error 2
      INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_core_read.h
      INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_version.h
      INSTALL /tmp/build/perf/libbpf/include/bpf/skel_internal.h
      INSTALL /tmp/build/perf/libbpf/include/bpf/usdt.bpf.h
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
       94 | static inline int io__get_hex(struct io *io, __u64 *hex)
          |                                              ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
      123 | static inline int io__get_dec(struct io *io, __u64 *dec)
          |                                              ^~~~~
    make[5]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:106: /tmp/build/perf/libapi/fs/fs.o] Error 1
    make[5]: *** Waiting for unfinished jobs....
      LD      /tmp/build/perf/libapi/fd/libapi-in.o
    make[4]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: fs] Error 2
  10    12.84 amazonlinux:devel             : FAIL gcc version 11.3.1 20221121 (Red Hat 11.3.1-4) (GCC)
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
       94 | static inline int io__get_hex(struct io *io, __u64 *hex)
          |                                              ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
      123 | static inline int io__get_dec(struct io *io, __u64 *dec)
          |                                              ^~~~~
    make[4]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: fs] Error 2
      CC      /tmp/build/perf/libperf/lib.o
      INSTALL /tmp/build/perf/libbpf/include/bpf/skel_internal.h
      INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_version.h
      INSTALL /tmp/build/perf/libbpf/include/bpf/usdt.bpf.h
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
       94 | static inline int io__get_hex(struct io *io, __u64 *hex)
          |                                              ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
      123 | static inline int io__get_dec(struct io *io, __u64 *dec)
          |                                              ^~~~~
    make[5]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:106: /tmp/build/perf/libapi/fs/fs.o] Error 1
    make[5]: *** Waiting for unfinished jobs....
      LD      /tmp/build/perf/libapi/fd/libapi-in.o
    make[4]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: fs] Error 2
  11   147.52 archlinux:base                : Ok   gcc (GCC) 13.2.1 20230801 , clang version 16.0.6 flex 2.6.4
  12    13.41 centos:stream                 : FAIL gcc version 8.5.0 20210514 (Red Hat 8.5.0-21) (GCC)
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
     static inline int io__get_hex(struct io *io, __u64 *hex)
                                                  ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
     static inline int io__get_dec(struct io *io, __u64 *dec)
                                                  ^~~~~
    make[4]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: fs] Error 2
      INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_tracing.h
      CC      /tmp/build/perf/libperf/xyarray.o
      INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_endian.h
      CC      /tmp/build/perf/libperf/lib.o
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
     static inline int io__get_hex(struct io *io, __u64 *hex)
                                                  ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
     static inline int io__get_dec(struct io *io, __u64 *dec)
                                                  ^~~~~
      INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_core_read.h
      INSTALL /tmp/build/perf/libbpf/include/bpf/skel_internal.h
      INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_version.h
      INSTALL /tmp/build/perf/libbpf/include/bpf/usdt.bpf.h
  13   108.26 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 13.2.1 20231115 releases/gcc-13.2.0-463-g5d6f62c9b2 , clang version 16.0.6 flex 2.6.4
  14    10.87 debian:10                     : FAIL gcc version 8.3.0 (Debian 8.3.0-6)
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
     static inline int io__get_hex(struct io *io, __u64 *hex)
                                                  ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
     static inline int io__get_dec(struct io *io, __u64 *dec)
                                                  ^~~~~
      INSTALL libbpf_headers
    make[4]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: fs] Error 2
      INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_tracing.h
      CC      /tmp/build/perf/libapi/cpu.o
      INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_endian.h
      INSTALL /tmp/build/perf/libbpf/include/bpf/bpf_core_read.h
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
     static inline int io__get_hex(struct io *io, __u64 *hex)
                                                  ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
     static inline int io__get_dec(struct io *io, __u64 *dec)
                                                  ^~~~~
      INSTALL /tmp/build/perf/libbpf/include/bpf/skel_internal.h
      INSTALL /tmp/build/perf/libbpf/include/bpf/libbpf_version.h
      CC      /tmp/build/perf/libapi/debug.o
      CC      /tmp/build/perf/libapi/str_error_r.o
  15    12.70 debian:11                     : FAIL gcc version 10.2.1 20210110 (Debian 10.2.1-6)
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
       94 | static inline int io__get_hex(struct io *io, __u64 *hex)
          |                                              ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
      123 | static inline int io__get_dec(struct io *io, __u64 *dec)
          |                                              ^~~~~
      INSTALL libperf_headers
    make[4]: *** [/git/perf-6.6.0-rc1/tools/build/Makefile.build:158: fs] Error 2
      INSTALL /tmp/build/perf/libbpf/include/bpf/usdt.bpf.h
      INSTALL /tmp/build/perf/libperf/include/internal/cpumap.h
      INSTALL /tmp/build/perf/libperf/include/internal/evlist.h
      INSTALL /tmp/build/perf/libperf/include/internal/evsel.h
    In file included from fs/fs.c:19:
    fs/../io.h:94:46: error: unknown type name '__u64'
       94 | static inline int io__get_hex(struct io *io, __u64 *hex)
          |                                              ^~~~~
    fs/../io.h:123:46: error: unknown type name '__u64'
      123 | static inline int io__get_dec(struct io *io, __u64 *dec)
          |                                              ^~~~~
      CC      /tmp/build/perf/libperf/zalloc.o
      INSTALL /tmp/build/perf/libperf/include/internal/lib.h
      INSTALL /tmp/build/perf/libperf/include/internal/mmap.h
      CC      /tmp/build/perf/libperf/xyarray.o
  16    85.50 debian:12                     : Ok   gcc (Debian 12.2.0-14) 12.2.0 , Debian clang version 14.0.6 flex 2.6.4
  17: debian:experimental


