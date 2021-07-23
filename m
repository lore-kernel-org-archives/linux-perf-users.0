Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D10EC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 18:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B4E60F22
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 18:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGWSMo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 14:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhGWSMn (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jul 2021 14:12:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A36A260E0C;
        Fri, 23 Jul 2021 18:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627066396;
        bh=QHkIrIRnxjWTA3h+EynjfSAJccmpjwl3AtQh9BqyX8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qXAiADvlC66ATN5zSR1n2GrfgEuHsvIxYZ052M4InPlEmeq72wYXWFcgES9Iq3iXR
         z+fbY+HSPzOZcYt0dk8XBhpSIsTrmUwiaVVBh9JVs8FHjarC/370VKJzu17r2+eZ3y
         NuAEk532zQI3O2JWFD5uVfuxHBZ14zU8JTH7Tq4+FLnjQovDIThSqyKA6SSzRrqbLH
         13sCOwX2g5vH9SUbaVi4qaBJjRDnSX0mENk4f7Y1qLLfwlLv2VxYrCLXSEyrlxez1Q
         DFI/DYvLwAL4KTTCs+8Z0ZCukEUSUmuuhClncxhy1NLbqkisPzLlq97cTvS4fLzLoq
         gCbfLNK2NFWGA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 09B99403F2; Fri, 23 Jul 2021 15:53:14 -0300 (-03)
Date:   Fri, 23 Jul 2021 15:53:13 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH 4/7] perf doc: Add info pages to all target.
Message-ID: <YPsQGZOXqoy7Tfe6@kernel.org>
References: <20210715013343.2286699-1-irogers@google.com>
 <20210715013343.2286699-5-irogers@google.com>
 <YPsKLa0Qe5/as4Jh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YPsKLa0Qe5/as4Jh@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jul 23, 2021 at 03:27:57PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Jul 14, 2021 at 06:33:40PM -0700, Ian Rogers escreveu:
> > Enabled to ensure that info pages build.
> 
> How did you test this? I tried installing texinfo, that is where
> makeinfo belongs:
> 
> ⬢[acme@toolbox perf]$ rpm -qf /usr/bin/makeinfo
> texinfo-6.7-10.fc34.x86_64
> ⬢[acme@toolbox perf]$ rpm -q texinfo
> texinfo-6.7-10.fc34.x86_64
> ⬢[acme@toolbox perf]$
> 
> And then:
> 
> ⬢[acme@toolbox perf]$ make -C tools/perf O=/tmp/build/perf install-doc
> make: Entering directory '/var/home/acme/git/perf/tools/perf'
>   BUILD:   Doing 'make -j24' parallel build
>   INSTALL Documentation-man
> make: Leaving directory '/var/home/acme/git/perf/tools/perf'
> ⬢[acme@toolbox perf]$

Also:

⬢[acme@toolbox perf]$ make -C tools/perf O=/tmp/build/perf install-info
make: Entering directory '/var/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j24' parallel build
make[3]: *** No rule to make target '/tmp/build/perf/perf.info', needed by 'info'.  Stop.
make[2]: *** [Makefile.perf:1009: install-info] Error 2
make[1]: *** [Makefile.perf:238: sub-make] Error 2
make: *** [Makefile:113: install-info] Error 2
make: Leaving directory '/var/home/acme/git/perf/tools/perf'
⬢[acme@toolbox perf]$ git diff
⬢[acme@toolbox perf]$ make -C tools/perf install-info
make: Entering directory '/var/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j24' parallel build

Auto-detecting system features:
...                         dwarf: [ on  ]
...            dwarf_getlocations: [ on  ]
...                         glibc: [ on  ]
...                        libbfd: [ on  ]
...                libbfd-buildid: [ on  ]
...                        libcap: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ on  ]
...        numa_num_possible_cpus: [ on  ]
...                       libperl: [ on  ]
...                     libpython: [ on  ]
...                     libcrypto: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ on  ]
...                          zlib: [ on  ]
...                          lzma: [ on  ]
...                     get_cpuid: [ on  ]
...                           bpf: [ on  ]
...                        libaio: [ on  ]
...                       libzstd: [ on  ]
...        disassembler-four-args: [ on  ]


  GEN      doc.dep
make[3]: *** No rule to make target 'perf.info', needed by 'info'.  Stop.
make[2]: *** [Makefile.perf:1009: install-info] Error 2
make[1]: *** [Makefile.perf:238: sub-make] Error 2
make: *** [Makefile:113: install-info] Error 2
make: Leaving directory '/var/home/acme/git/perf/tools/perf'
⬢[acme@toolbox perf]$
