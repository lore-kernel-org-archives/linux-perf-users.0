Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89186C4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 17 Oct 2022 12:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJQMgd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 17 Oct 2022 08:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiJQMg0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 17 Oct 2022 08:36:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B2C3C8D9
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Oct 2022 05:36:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1E8261128
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Oct 2022 12:36:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16320C433C1;
        Mon, 17 Oct 2022 12:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666010182;
        bh=rYanYlvUUtBEd43N3beSv0PQVyXjNIlwLpxCQzc4LCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ovVr3tx5vgz+hOqEns+i8ciPwjp8dvSnUR8lZyW7KrIkB/wsM5HPeVxR+ndaKxZOw
         NJYhhAxleHVLlW18rjTyATpDii20HsiYbIuaGuAZ5aeP63j8r/2kgbpgcnJGglPtOz
         yIIHWiLMBmszahleYPdtA/xfJD1bOXsSUWLZubSOk+JxRCpRlWPQwFWJsVVR5tribl
         +i9F+8hiL2IgVsnwkmXLfPTYAFxTLgH3BeP5Ul/kk+SD9f0eMjaaI2TLX8kuMkFOnk
         ftCyf4V57fIraCfKy/nssQA4oyplc1wqlJ/bE2KCjipsXWM64xn2DoqT+FyRujKUf7
         E8S0HOApyRL7g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DF77C403B6; Mon, 17 Oct 2022 09:36:19 -0300 (-03)
Date:   Mon, 17 Oct 2022 09:36:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf lzma: Quieten lzma warning
Message-ID: <Y01MQ631C5EwIFz5@kernel.org>
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

Yeah, I see this from time to time, would be interesting to find the
root cause for looking at te modules for each kernel :-\

I'll try to take a look if Jiri doesn't have any idea about this.

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
