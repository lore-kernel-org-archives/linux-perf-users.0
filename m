Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E5DC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 13:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D068611C9
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Sep 2021 13:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbhIJNsb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 09:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231963AbhIJNsb (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Sep 2021 09:48:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFC59611CC;
        Fri, 10 Sep 2021 13:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631281640;
        bh=3QyDRaCV9CAvwJPnWSiuVlmX8dhIt+DdBDA4L4zPqj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ly3dYUerrTLnrmnBMDJtNLxd8NKCRW8G3JGZmv98Ay1RhxAEPm0/djg4NoHgbSEQy
         roP93wNlDAhwVtdCC7la/efztKbLu5zdFISMmgOUhnyJSSHR5cdacW20VUqTqUYfpw
         j+JwpH4V0PrIZd7dipk4csFJAUoASoJOZjyQ0ocWEEl4rpEbG1TR50BLmQTDbAXyTH
         swD9vBnpE5mjPRYbxr3ZvAPSL4fInjcHOf8BC41/CSHJ3MO2ij0yvtR6hxYMo2ECpu
         tIeRTOrfCA0WHfT9gckxsZRsM697jRVPuTcSmZbaoLjI7oRkmtTg6lewryGWqM3a08
         HBTJgcw+ri4AQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 99E6A4038F; Fri, 10 Sep 2021 10:47:16 -0300 (-03)
Date:   Fri, 10 Sep 2021 10:47:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <robert.richter@amd.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/3] perf report: Add support to print a textual
 representation of IBS raw sample data
Message-ID: <YTth5DLWGbyAzxvQ@kernel.org>
References: <20210817221509.88391-1-kim.phillips@amd.com>
 <c4979e5c-13b8-0311-0660-355551ce45f2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4979e5c-13b8-0311-0660-355551ce45f2@amd.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Sep 09, 2021 at 04:58:12PM -0500, Kim Phillips escreveu:
> Hi Arnaldo,
> 
> Can you please take a look at applying this series?  Its kernel-side
> dependent series has already been applied and is in Linus' master.

Sure, I'm now trying to fix this:

  CC      /tmp/build/perf/util/amd-sample-raw.o
util/amd-sample-raw.c: In function ‘evlist__amd_sample_raw’:
util/amd-sample-raw.c:125:42: error: ‘ bytes’ directive output may be truncated writing 6 bytes into a region of size between 4 and 7 [-Werror=format-truncation=]
  125 |                          " OpMemWidth %2d bytes", 1 << (reg.op_mem_width - 1));
      |                                          ^~~~~~
In file included from /usr/include/stdio.h:866,
                 from util/amd-sample-raw.c:7:
/usr/include/bits/stdio2.h:71:10: note: ‘__builtin___snprintf_chk’ output between 21 and 24 bytes into a destination of size 21
   71 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   72 |                                    __glibc_objsize (__s), __fmt,
      |                                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   73 |                                    __va_arg_pack ());
      |                                    ~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:96: /tmp/build/perf/util/amd-sample-raw.o] Error 1
 
> Thanks,
> 
> Kim
> 
> On 8/17/21 5:15 PM, Kim Phillips wrote:
> > Hello Linux perf tools users and maintainers,
> > 
> > The first patch in this series prepares the perf tool to support
> > retrieving cpuid and pmu_mappings data when in report mode,
> > information that is needed to accurately decode IBS data.
> > 
> > The second patch adds a header file tools/arch/x86/include/asm/amd-ibs.h
> > from a separate kernel-side submittion [1].
> > 
> > The third patch allows the tool to print a textual representation
> > of the sample data recorded by IBS.
> > 
> > [1] https://lore.kernel.org/lkml/20210817221048.88063-9-kim.phillips@amd.com
> > 
> > Kim Phillips (3):
> >    perf env: Add perf_env__cpuid, perf_env__{nr_}pmu_mappings
> >    perf report: Add tools/arch/x86/include/asm/amd-ibs.h
> >    perf report: Add support to print a textual representation of IBS raw
> >      sample data
> > 
> >   tools/arch/x86/include/asm/amd-ibs.h | 132 ++++++++++++
> >   tools/perf/check-headers.sh          |   1 +
> >   tools/perf/util/Build                |   1 +
> >   tools/perf/util/amd-sample-raw.c     | 290 +++++++++++++++++++++++++++
> >   tools/perf/util/env.c                |  78 +++++++
> >   tools/perf/util/env.h                |   5 +
> >   tools/perf/util/sample-raw.c         |   8 +
> >   tools/perf/util/sample-raw.h         |   6 +-
> >   8 files changed, 520 insertions(+), 1 deletion(-)
> >   create mode 100644 tools/arch/x86/include/asm/amd-ibs.h
> >   create mode 100644 tools/perf/util/amd-sample-raw.c
> > 
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Joao Martins <joao.m.martins@oracle.com>
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Michael Petlan <mpetlan@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Robert Richter <robert.richter@amd.com>
> > Cc: Stephane Eranian <eranian@google.com>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-perf-users@vger.kernel.org
> > 

-- 

- Arnaldo
