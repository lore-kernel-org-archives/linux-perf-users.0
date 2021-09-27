Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D42AC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 12:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B7A260FF2
	for <linux-perf-users@archiver.kernel.org>; Mon, 27 Sep 2021 12:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhI0Mf7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234380AbhI0Mf7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Sep 2021 08:35:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7ECEC60F41;
        Mon, 27 Sep 2021 12:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632746061;
        bh=D+5/8tHCQxdmWTOlYcOv1iIAUp7sdgYnP5xXPObXi1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jGl+I3enIxJKufmTuRxiGyGny5Uqc+2WEAxMwMZODl9SZo8AtZRCOPfW/e35tnmj5
         hTHi1XNUiltYTMu68VYxXYn8qMclPOOdp1iG4xJJZwYbO6xkiIx7qlD4F/PAvC0CO8
         APu+G76FVFw47Ib0IjAtuNX3esgJYZwbz8zgcITWfKtCmJKZjk3MmHXt26R+T1ENgv
         gAzGS7piBrm7zonQkndmC4xbrVQHtcLdhasoPaIxp4rEi1RgkohRN4fNFSJtL/Pq0H
         qE7zdmNFkibGYyIm8EGHShVTh1gyY7hD8qPncW2phGulMeBakllVOqj/e1J6QLbWrb
         UrlyawfD8W/pw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1027F410A1; Mon, 27 Sep 2021 09:34:19 -0300 (-03)
Date:   Mon, 27 Sep 2021 09:34:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     William Cohen <wcohen@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] perf annotate: Add riscv64 support
Message-ID: <YVG6S2CE4fQRgngo@kernel.org>
References: <20210927005115.610264-1-wcohen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210927005115.610264-1-wcohen@redhat.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Sep 26, 2021 at 08:51:15PM -0400, William Cohen escreveu:
> This patch adds basic arch initialization and instruction associate
> support for the riscv64 CPU architecture.
> 
> Example output:
> 
>   $ perf annotate --stdio2
>   Samples: 122K of event 'task-clock:u', 4000 Hz, Event count (approx.): 30637250000, [percent: local period]
>   strcmp() /usr/lib64/libc-2.32.so
>   Percent
> 
> 	      Disassembly of section .text:
> 
> 	      0000000000069a30 <strcmp>:
> 	      __GI_strcmp():
> 	      const unsigned char *s2 = (const unsigned char *) p2;
> 	      unsigned char c1, c2;
> 
> 	      do
> 	      {
> 	      c1 = (unsigned char) *s1++;
>    37.30        lbu  a5,0(a0)
> 	      c2 = (unsigned char) *s2++;
>     1.23        addi a1,a1,1
> 	      c1 = (unsigned char) *s1++;
>    18.68        addi a0,a0,1
> 	      c2 = (unsigned char) *s2++;
>     1.37        lbu  a4,-1(a1)
> 	      if (c1 == '\0')
>    18.71      ↓ beqz a5,18
> 	       return c1 - c2;
> 	       }

Thanks, applied.

- Arnaldo

 
> Signed-off-by: William Cohen <wcohen@redhat.com>
> ---
>  .../perf/arch/riscv64/annotate/instructions.c | 34 +++++++++++++++++++
>  tools/perf/util/annotate.c                    |  5 +++
>  2 files changed, 39 insertions(+)
>  create mode 100644 tools/perf/arch/riscv64/annotate/instructions.c
> 
> diff --git a/tools/perf/arch/riscv64/annotate/instructions.c b/tools/perf/arch/riscv64/annotate/instructions.c
> new file mode 100644
> index 000000000000..869a0eb28953
> --- /dev/null
> +++ b/tools/perf/arch/riscv64/annotate/instructions.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +static
> +struct ins_ops *riscv64__associate_ins_ops(struct arch *arch, const char *name)
> +{
> +	struct ins_ops *ops = NULL;
> +
> +	if (!strncmp(name, "jal", 3) ||
> +	    !strncmp(name, "jr", 2) ||
> +	    !strncmp(name, "call", 4))
> +		ops = &call_ops;
> +	else if (!strncmp(name, "ret", 3))
> +		ops = &ret_ops;
> +	else if (name[0] == 'j' || name[0] == 'b')
> +		ops = &jump_ops;
> +	else
> +		return NULL;
> +
> +	arch__associate_ins_ops(arch, name, ops);
> +
> +	return ops;
> +}
> +
> +static
> +int riscv64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
> +{
> +	if (!arch->initialized) {
> +		arch->associate_instruction_ops = riscv64__associate_ins_ops;
> +		arch->initialized = true;
> +		arch->objdump.comment_char = '#';
> +	}
> +
> +	return 0;
> +}
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 0bae061b2d6d..d919fa993872 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -151,6 +151,7 @@ static int arch__associate_ins_ops(struct arch* arch, const char *name, struct i
>  #include "arch/mips/annotate/instructions.c"
>  #include "arch/x86/annotate/instructions.c"
>  #include "arch/powerpc/annotate/instructions.c"
> +#include "arch/riscv64/annotate/instructions.c"
>  #include "arch/s390/annotate/instructions.c"
>  #include "arch/sparc/annotate/instructions.c"
>  
> @@ -192,6 +193,10 @@ static struct arch architectures[] = {
>  		.name = "powerpc",
>  		.init = powerpc__annotate_init,
>  	},
> +	{
> +		.name = "riscv64",
> +		.init = riscv64__annotate_init,
> +	},
>  	{
>  		.name = "s390",
>  		.init = s390__annotate_init,
> -- 
> 2.27.0

-- 

- Arnaldo
