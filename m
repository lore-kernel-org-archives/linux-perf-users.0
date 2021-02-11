Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D0AC433E0
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Feb 2021 13:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351F564E95
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Feb 2021 13:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhBKNCV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Feb 2021 08:02:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230453AbhBKM7u (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Feb 2021 07:59:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4332264E08;
        Thu, 11 Feb 2021 12:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613048349;
        bh=NrNjVTzbQbg25JOcwBhG9G7HSG/+XeGbt5od0uAVhL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OyhFQL0ny14252flO7QagJJJL/d/7G7MPZ3kiXnlBxJDB3YxSn9NfAop+hyzgwiTh
         FRxLaJ5GV8Wp+MhALPTlHk6QVIPVK9QcDb63irL9nBLaO6FxHN6LaYsZAm15ppgmTY
         dJNt+mficSKrVEcJYu5tvwTzNDUnt8xEw5QzWC+8fIbrky803PanGEr0Fmc+3+XIzU
         UmM8n3DvhL2p2Ypt2ozuQaZsOqplS83QDlau3pUT8rdp38oADz1Z6y681SbLcz48Vp
         mT/YdxgLgf/a18d2rzLi09uLyYbF5Qwa45iPT/ilTTMFmdYqa7YCIGHWyfLdnBiDaE
         DZUt7uMBbiqBg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4239F40513; Thu, 11 Feb 2021 09:59:06 -0300 (-03)
Date:   Thu, 11 Feb 2021 09:59:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] Fix jump parsing for C++ code.
Message-ID: <20210211125906.GC1131885@kernel.org>
References: <13e1a405-edf9-e4c2-4327-a9b454353730@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13e1a405-edf9-e4c2-4327-a9b454353730@suse.cz>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Feb 11, 2021 at 01:37:55PM +0100, Martin Liška escreveu:
> Considering the following testcase:

Cool, applied, next time please use a Summary like:

  Subject: Re: [PATCH] perf annotate: Fix jump parsing for C++ code.

So that it stands out more clearly in my inbox, this time I saw your
name as a previous perf contributor and figured it should be for perf
:-)

Thanks!

- Arnaldo
 
> int
> foo(int a, int b)
> {
>   for (unsigned i = 0; i < 1000000000; i++)
>     a += b;
>   return a;
> }
> 
> int main()
> {
>   foo (3, 4);
>   return 0;
> }
> 
> perf annotate displays:
>  86.52 │40055e: → ja   40056c <foo(int, int)+0x26>
>  13.37 │400560:   mov  -0x18(%rbp),%eax
>        │400563:   add  %eax,-0x14(%rbp)
>        │400566:   addl $0x1,-0x4(%rbp)
>   0.11 │40056a: → jmp  400557 <foo(int, int)+0x11>
>        │40056c:   mov  -0x14(%rbp),%eax
>        │40056f:   pop  %rbp
> 
> and the 'ja 40056c' does not link to the location in the function.
> It's caused by fact that comma is wrongly parsed, it's part
> of function signature.
> 
> With my patch I see:
> 
>  86.52 │   ┌──ja   26
>  13.37 │   │  mov  -0x18(%rbp),%eax
>        │   │  add  %eax,-0x14(%rbp)
>        │   │  addl $0x1,-0x4(%rbp)
>   0.11 │   │↑ jmp  11
>        │26:└─→mov  -0x14(%rbp),%eax
> 
> and 'o' output prints:
>  86.52 │4005┌── ↓ ja   40056c <foo(int, int)+0x26>
>  13.37 │4005│0:   mov  -0x18(%rbp),%eax
>        │4005│3:   add  %eax,-0x14(%rbp)
>        │4005│6:   addl $0x1,-0x4(%rbp)
>   0.11 │4005│a: ↑ jmp  400557 <foo(int, int)+0x11>
>        │4005└─→   mov  -0x14(%rbp),%eax
> 
> On the contrary, compiling the very same file with gcc -x c, the parsing
> is fine because function arguments are not displyed:
> 
> jmp  400543 <foo+0x1d>
> 
> Signed-off-by: Martin Liška <mliska@suse.cz>
> ---
>  tools/perf/util/annotate.c | 6 ++++++
>  tools/perf/util/annotate.h | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index ce8c07bc8c56..e3eae646be3e 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -321,11 +321,16 @@ bool ins__is_call(const struct ins *ins)
>  /*
>   * Prevents from matching commas in the comment section, e.g.:
>   * ffff200008446e70:       b.cs    ffff2000084470f4 <generic_exec_single+0x314>  // b.hs, b.nlast
> + *
> + * and skip comma as part of function arguments, e.g.:
> + * 1d8b4ac <linemap_lookup(line_maps const*, unsigned int)+0xcc>
>   */
>  static inline const char *validate_comma(const char *c, struct ins_operands *ops)
>  {
>  	if (ops->raw_comment && c > ops->raw_comment)
>  		return NULL;
> +	else if (ops->raw_func_start && c > ops->raw_func_start)
> +		return NULL;
>  	return c;
>  }
> @@ -341,6 +346,7 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
>  	u64 start, end;
>  	ops->raw_comment = strchr(ops->raw, arch->objdump.comment_char);
> +	ops->raw_func_start = strchr(ops->raw, '<');
>  	c = validate_comma(c, ops);
>  	/*
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 0a0cd4f32175..096cdaf21b01 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -32,6 +32,7 @@ struct ins {
>  struct ins_operands {
>  	char	*raw;
>  	char	*raw_comment;
> +	char	*raw_func_start;
>  	struct {
>  		char	*raw;
>  		char	*name;
> -- 
> 2.30.0
> 

-- 

- Arnaldo
