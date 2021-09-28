Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116E3C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 20:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E948A6108E
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 20:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242727AbhI1UtM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:49:12 -0400
Received: from wildebeest.demon.nl ([212.238.236.112]:60770 "EHLO
        gnu.wildebeest.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242572AbhI1UtL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 16:49:11 -0400
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2021 16:49:11 EDT
Received: from reform (deer0x0a.wildebeest.org [172.31.17.140])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gnu.wildebeest.org (Postfix) with ESMTPSA id 5332F3000A0A;
        Tue, 28 Sep 2021 22:39:06 +0200 (CEST)
Received: by reform (Postfix, from userid 1000)
        id D69F92E80D92; Tue, 28 Sep 2021 22:39:05 +0200 (CEST)
Date:   Tue, 28 Sep 2021 22:39:05 +0200
From:   Mark Wielaard <mark@klomp.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix compilation on powerpc
Message-ID: <YVN9aZsIRYrhT1mU@wildebeest.org>
References: <20210928195253.1267023-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210928195253.1267023-1-jolsa@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Tue, Sep 28, 2021 at 09:52:53PM +0200, Jiri Olsa wrote:
> Got following build fail on powerpc:
> 
>     CC      arch/powerpc/util/skip-callchain-idx.o
>   In function ‘check_return_reg’,
>       inlined from ‘check_return_addr’ at arch/powerpc/util/skip-callchain-idx.c:213:7,
>       inlined from ‘arch_skip_callchain_idx’ at arch/powerpc/util/skip-callchain-idx.c:265:7:
>   arch/powerpc/util/skip-callchain-idx.c:54:18: error: ‘dwarf_frame_register’ accessing 96 bytes \
>   in a region of size 64 [-Werror=stringop-overflow=]
>      54 |         result = dwarf_frame_register(frame, ra_regno, ops_mem, &ops, &nops);
>         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   arch/powerpc/util/skip-callchain-idx.c: In function ‘arch_skip_callchain_idx’:
>   arch/powerpc/util/skip-callchain-idx.c:54:18: note: referencing argument 3 of type ‘Dwarf_Op *’
>   In file included from /usr/include/elfutils/libdwfl.h:32,
>                    from arch/powerpc/util/skip-callchain-idx.c:10:
>   /usr/include/elfutils/libdw.h:1069:12: note: in a call to function ‘dwarf_frame_register’
>    1069 | extern int dwarf_frame_register (Dwarf_Frame *frame, int regno,
>         |            ^~~~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors
> 
> The dwarf_frame_register args changed with [1],
> Updating ops_mem accordingly.
> 
> [1] https://sourceware.org/git/?p=elfutils.git;a=commit;h=5621fe5443da23112170235dd5cac161e5c75e65

The warning (new with GCC11) and the fix are correct.

The code probably worked fine before because the next var on the stack
was the dummy Dwarf_Op which would have been as if the ops_mem[2] was
actually ops_mem[3] already. You don't need the dummy var now and
Dwarf_Op *ops doesn't need to be initialized (the dwarf_frame_register
will initialize it).

Note that [1] didn't change the args of the dwarf_frame_register, but
did fix a similar bug in one of the elfutils own tests (and updated
the comment on the function to hopefully be more clear).

Cheers,

Mark

> Cc: Mark Wielaard <mjw@redhat.com>
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Signed-off-by: Jiri Olsa <jolsa@redhat.com>
> ---
>  tools/perf/arch/powerpc/util/skip-callchain-idx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> index 3018a054526a..20cd6244863b 100644
> --- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> +++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
> @@ -45,7 +45,7 @@ static const Dwfl_Callbacks offline_callbacks = {
>   */
>  static int check_return_reg(int ra_regno, Dwarf_Frame *frame)
>  {
> -	Dwarf_Op ops_mem[2];
> +	Dwarf_Op ops_mem[3];
>  	Dwarf_Op dummy;
>  	Dwarf_Op *ops = &dummy;
>  	size_t nops;
> -- 
> 2.31.1
> 
