Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281B0171E76
	for <linux-perf-users@vger.kernel.org>; Tue, 28 May 2024 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912544; cv=none; b=KJd7bR5QmtJPZRiWcmZccd9zXR/E/qT2HFiPhnr/0oMBe9jH6acdhy1il8LBJe3+drLrG+lDNrEmLIAXiAlPWNFHSK71WEPU3ExNk7BaCjf2oUel84fHNMdowZdbicIGv9nzwwxWqpdQw9K13D9rrDgZswuB133cMrncAlr+sfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912544; c=relaxed/simple;
	bh=sfPNJ0u2Rr9bEfcK5HdSOwEuyHpUO/mLTYK1FKKEPCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CwRsXdU9XU7sZ1LYCSGPwRmhY/J/yGRHV2eare91borwdiJQxGLd81qTJENfQ8xdahgNUZfj7ZDYIVFZO6ov+C5VE53UqDSWUR2QRCow06vDhAPF6FzzPYUfnIBkvZfD+bpFFwqLPWokY/XwdMZP9Nznisu2gyhAVax6d+cBIoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DC49339;
	Tue, 28 May 2024 09:09:25 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA3443F762;
	Tue, 28 May 2024 09:09:00 -0700 (PDT)
Message-ID: <0e2d8cc4-420b-4387-9b26-2f00cbbc1a83@arm.com>
Date: Tue, 28 May 2024 17:09:02 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why does libtracevent pkg-config detection wipe PKG_CONFIG_PATH?
To: Mateusz Kowalczyk <fuuzetsu@fuuzetsu.co.uk>,
 linux-perf-users <linux-perf-users@vger.kernel.org>
References: <cfcaf804-d7b1-4d55-8465-12e1d238aca1@app.fastmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <cfcaf804-d7b1-4d55-8465-12e1d238aca1@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/05/2024 01:56, Mateusz Kowalczyk wrote:
> Hi,
> 
> To build recent perf, I'm having to apply the below patch.
> 
> ```diff
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 7f1e016a9253..b70fef12a977 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -1181,7 +1181,7 @@ ifneq ($(NO_LIBTRACEEVENT),1)
>      CFLAGS += -DHAVE_LIBTRACEEVENT $(LIBTRACEEVENT_CFLAGS)
>      LDFLAGS += $(LIBTRACEEVENT_LDFLAGS)
>      EXTLIBS += ${TRACEEVENTLIBS}
> -    LIBTRACEEVENT_VERSION := $(shell PKG_CONFIG_PATH=$(LIBTRACEEVENT_DIR) $(PKG_CONFIG) --modversion libtraceevent)
> +    LIBTRACEEVENT_VERSION := $(shell $(PKG_CONFIG) --modversion libtraceevent)
>      LIBTRACEEVENT_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
>      LIBTRACEEVENT_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
>      LIBTRACEEVENT_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
> ```
> 
> I don't understand why `PKG_CONFIG_PATH` is overwritten this way. `grep`ing for PKG_CONFIG_PATH reveals that this isn't done anywhere else in the kernel tree. All other uses of `$(PKG_CONFIG)` in the file simply invoke the tool.
> 

Hi Mateusz,

If PKG_CONFIG_PATH being overwritten is an issue, I'm assuming that you
have it set in your shell already? Is there a reason you aren't using
the default? Or is it that your version of pkg-config doesn't like that
var being set to an empty value?

> Of course, I do actually have `libtraceevent.pc` available, it's just that `LIBTRACEVENT_DIR` is empty which stops it from finding it.
> 
> ```
> [shana@aya:~/programming/linux/tools/perf]$ pkg-config --modversion libtraceevent
> 1.8.2
> ```
> 
> If I do not apply the patch, I'm getting the below errors during build.
> 
> I'm not sure how others are getting it to build, maybe I'm doing something wrong? Please let me know. If the diff is fine, it'd be great if anyone could apply it.
> 

I think your diff needs a small change. I'm assuming it was done this
way to allow the custom libtraceevent path to be specified with
LIBTRACEEVENT_DIR. If you remove that then it can't be done anymore.

Isn't the right change to set PKG_CONFIG_PATH if LIBTRACEEVENT_DIR is
set, but otherwise leave it unset?

But yes the build is working fine for me.

James


> Thanks!
> 
> ```
> Perhaps you should add the directory containing `libtraceevent.pc'
> to the PKG_CONFIG_PATH environment variable
> No package 'libtraceevent' found
> expr: syntax error: unexpected argument ‘255’
> 
> Auto-detecting system features:
> ...                                   dwarf: [ on  ]
> ...                      dwarf_getlocations: [ on  ]
> ...                                   glibc: [ on  ]
> ...                                  libbfd: [ on  ]
> ...                          libbfd-buildid: [ on  ]
> ...                                  libcap: [ on  ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]
> ...                  numa_num_possible_cpus: [ on  ]
> ...                                 libperl: [ on  ]
> ...                               libpython: [ on  ]
> ...                               libcrypto: [ on  ]
> ...                               libunwind: [ on  ]
> ...                      libdw-dwarf-unwind: [ on  ]
> ...                             libcapstone: [ OFF ]
> ...                                    zlib: [ on  ]
> ...                                    lzma: [ on  ]
> ...                               get_cpuid: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ on  ]
> 
>   INSTALL libsubcmd_headers
>   PERF_VERSION = 6.10.rc1.g1613e604df0c
>   GEN     perf-archive
>   GEN     perf-iostat
>   INSTALL libsymbol_headers
>   INSTALL libapi_headers
>   INSTALL libperf_headers
>   INSTALL libbpf_headers
>   TEST    pmu-events/metric_test.log
>   CC      builtin-bench.o
>   CC      builtin-annotate.o
>   CC      builtin-config.o
>   CC      builtin-diff.o
>   CC      builtin-evlist.o
>   CC      builtin-ftrace.o
>   CC      builtin-help.o
>   CC      builtin-buildid-list.o
>   CC      builtin-buildid-cache.o
>   CC      builtin-kallsyms.o
>   CC      builtin-list.o
>   GEN     pmu-events/pmu-events.c
> In file included from util/session.h:5,
>                  from builtin-buildid-list.c:17:
> util/trace-event.h:152:62: error: operator '&&' has no right operand
>   152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>       |                                                              ^~
> In file included from util/session.h:5,
>                  from builtin-evlist.c:15:
> util/trace-event.h:152:62: error: operator '&&' has no right operand
>   152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>       |                                                              ^~
> In file included from util/session.h:5,
>                  from builtin-buildid-cache.c:24:
> util/trace-event.h:152:62: error: operator '&&' has no right operand
>   152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>       |                                                              ^~
>   CC      builtin-record.o
> In file included from util/session.h:5,
>                  from builtin-diff.c:15:
> util/trace-event.h:152:62: error: operator '&&' has no right operand
>   152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>       |                                                              ^~
>   CC      builtin-report.o
>   CC      builtin-stat.o
> make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.build:105: builtin-buildid-list.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.build:105: builtin-evlist.o] Error 1
> In file included from util/session.h:5,
>                  from builtin-annotate.c:32:
> util/trace-event.h:152:62: error: operator '&&' has no right operand
>   152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>       |                                                              ^~
> make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.build:105: builtin-buildid-cache.o] Error 1
> make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.build:105: builtin-annotate.o] Error 1
> make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.build:105: builtin-diff.o] Error 1
> In file included from util/session.h:5,
>                  from builtin-record.c:27:
> util/trace-event.h:152:62: error: operator '&&' has no right operand
>   152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>       |                                                              ^~
> In file included from util/session.h:5,
>                  from builtin-stat.c:60:
> util/trace-event.h:152:62: error: operator '&&' has no right operand
>   152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>       |                                                              ^~
> In file included from util/session.h:5,
>                  from builtin-report.c:35:
> util/trace-event.h:152:62: error: operator '&&' has no right operand
>   152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
>       |                                                              ^~
> make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.build:105: builtin-record.o] Error 1
> make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.build:105: builtin-report.o] Error 1
> make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.build:105: builtin-stat.o] Error 1
> make[2]: *** [Makefile.perf:727: perf-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   CC      pmu-events/pmu-events.o
>   LD      pmu-events/pmu-events-in.o
> make[1]: *** [Makefile.perf:264: sub-make] Error 2
> make: *** [Makefile:70: all] Error 2
> perf version 6.10.rc1.g5f00d82dec63
> 
> ```
> 
> --
> Mateusz K.
> 
> 
