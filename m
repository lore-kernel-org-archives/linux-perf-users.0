Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D729BC43217
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Nov 2022 17:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiKPRDK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Nov 2022 12:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbiKPRDJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Nov 2022 12:03:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C380BC76F
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Nov 2022 09:03:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62AE761F01
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Nov 2022 17:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A628AC433C1;
        Wed, 16 Nov 2022 17:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668618187;
        bh=L/T9WJx7u1ms4JxcSRasCyvP612/Qgh5EpzbRDmHw2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ryCK21LC3p3tLWTRDkcNGdsUleG1hw51J8N6Z7KangFFzLTYkOOlz788Ctudqwsor
         MJY+eLjKx/ItUv+CZNf0Zm8eYOVyS0SAj47BQrQLhH4cnbND/l7/DVtwGiuCd9/p4E
         G7gO+cC9uYE7LLotH2q9ahf7TSzX2mfF6IIrkezvuxgo6xAIdCx/+aWQvbCn284y1R
         nP/J7RMf+ORRGMxBb6/OptPYmwFAoBSGYy2x27s+Hy56RCshsyNIVGLxSkGUzolMcN
         WuT+nwQ3BPXDfe3dBg17l1CNjNhiB9PYiHXXOJSteIt3BEjZfbGrrhs7EgXnd+1cky
         Y9HriV6U0bDRg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2FC1B4034E; Wed, 16 Nov 2022 14:03:05 -0300 (-03)
Date:   Wed, 16 Nov 2022 14:03:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf lzma: Quieten lzma warning
Message-ID: <Y3UXySfyfzj49Pai@kernel.org>
References: <20221004190615.998656-1-ak@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004190615.998656-1-ak@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Oct 04, 2022 at 12:06:15PM -0700, Andi Kleen escreveu:
> On my Fedora system which is missing some modules I always get a long flood
> of
> 
> lzma: fopen failed on /usr/lib/modules/5.3.9-300.fc31.x86_64/kernel/sound/pci/hda/snd-hda-codec.ko.xz: 'No such file or directory'
> lzma: fopen failed on /usr/lib/modules/5.16.7-200.fc35.x86_64/kernel/sound/pci/hda/snd-hda-intel.ko.xz: 'No such file or directory'
> lzma: fopen failed on /usr/lib/modules/5.1.11-200.fc29.x86_64/kernel/drivers/vhost/vhost_net.ko.xz: 'No such file or directory'
> 
> for each use of "perf list".
> 
> Disable the message.
> 
> Also I'm not sure why it's looking at the modules of each kernel, not
> just the running one, but that's a different problem.

So using:

[root@five ~]# perf probe -x ~/bin/perf -L lzma_decompress_to_file | head -20
<lzma_decompress_to_file@/var/home/acme/git/perf/tools/perf/util/lzma.c:0>
      0  int lzma_decompress_to_file(const char *input, int output_fd)
         {
      2  	lzma_action action = LZMA_RUN;
         	lzma_stream strm   = LZMA_STREAM_INIT;
      4  	lzma_ret ret;
         	int err = -1;
         
         	u8 buf_in[BUFSIZE];
         	u8 buf_out[BUFSIZE];
         	FILE *infile;
         
         	infile = fopen(input, "rb");
     12  	if (!infile) {
     13  		pr_err("lzma: fopen failed on %s: '%s'\n",
         		       input, strerror(errno));
     15  		return -1;
         	}
         
     18  	ret = lzma_stream_decoder(&strm, UINT64_MAX, LZMA_CONCATENATED);
[root@five ~]#

And:

[root@five ~]# perf probe -x ~/bin/perf lzma_decompress_to_file
Added new event:
  probe_perf:lzma_decompress_to_file (on lzma_decompress_to_file in /var/home/acme/bin/perf)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:lzma_decompress_to_file -aR sleep 1

[root@five ~]#
[root@five ~]# perf record -e probe_perf:lzma_decompress_to_file/max-stack=16/ perf list syscalls:sys_enter_open*
[ perf record: Woken up 1 times to write data ]

[ perf record: Captured and wrote 0.119 MB perf.data (625 samples) ]

[root@five ~]#
[root@five ~]#
[root@five ~]# perf report --stdio
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 625  of event 'probe_perf:lzma_decompress_to_file'
# Event count (approx.): 625
#
# Children      Self  Trace output
# ........  ........  ............
#
   100.00%   100.00%  (5c53b0)
            |
            ---__libc_start_call_main
               main
               run_builtin
               cmd_list
               print_sdt_events
               build_id_cache__list_all
               filename__read_build_id
               lzma_decompress_to_file



#
# (Tip: Limit to show entries above 5% only: perf report --percent-limit 5)
#
[root@five ~]#


Seems like it is trying to find SDT events in everything that is in
~/.debug :-\ I'll try to continue this later, sidetracked now.

- Arnaldo
 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/util/lzma.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/lzma.c b/tools/perf/util/lzma.c
> index 51424cdc3b68..ef0520c82245 100644
> --- a/tools/perf/util/lzma.c
> +++ b/tools/perf/util/lzma.c
> @@ -44,11 +44,8 @@ int lzma_decompress_to_file(const char *input, int output_fd)
>  	FILE *infile;
>  
>  	infile = fopen(input, "rb");
> -	if (!infile) {
> -		pr_err("lzma: fopen failed on %s: '%s'\n",
> -		       input, strerror(errno));
> +	if (!infile)
>  		return -1;
> -	}
>  
>  	ret = lzma_stream_decoder(&strm, UINT64_MAX, LZMA_CONCATENATED);
>  	if (ret != LZMA_OK) {
> -- 
> 2.37.2

-- 

- Arnaldo
