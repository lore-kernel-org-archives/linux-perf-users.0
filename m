Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1F0C07E99
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 17:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2424B61956
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jul 2021 17:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhGERtr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Jul 2021 13:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229686AbhGERtr (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Jul 2021 13:49:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC9EF61946;
        Mon,  5 Jul 2021 17:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625507230;
        bh=O85WJvVbPh+zxTWxPfLPmLw5JuXuUcRQ8xrIqn8SHSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HXieEPbXG5zDh5AbincKiUh3934HCwJLOqFQW/KdRE8Ru6qxXJIfQ6rG4oaLIyGEG
         A7xpw3ZaaRKjS7JCLeo8ViEDkms83SfSuhaaooHlgvv0WwBbtG7hKhwDIr3R5fsN1T
         TE0fZz7DBo+F99XCplVgTquJUEADjhqL2QDCooCx1mYKPJI42u04Sf0CTqXmSbrKxk
         ArIAXZhmJF7ecsbI8CaEZGfZg6Eqqu7yOW3Yuj6U55/5c5E3xNRbsNnZMzCcRgnWum
         mwKJOlwZq+sOVL0+OkCSw0AtmquyRaNsZQrqu/sdtCw6FjTXt+nFXvy0beRbHPtzmk
         IFg3HoGCbllbQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2461D40B1A; Mon,  5 Jul 2021 14:47:06 -0300 (-03)
Date:   Mon, 5 Jul 2021 14:47:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Stefan Liebler <stli@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf probe: Do not show @plt function by default
Message-ID: <YONFmpWBdqGX7VZJ@kernel.org>
References: <162532651032.393143.4602033845482295575.stgit@devnote2>
 <162532653450.393143.12621329879630677469.stgit@devnote2>
 <9824bd00-3291-3a65-73f1-553410b8eb68@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9824bd00-3291-3a65-73f1-553410b8eb68@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jul 05, 2021 at 02:11:11PM +0200, Thomas Richter escreveu:
> On 7/3/21 5:35 PM, Masami Hiramatsu wrote:
> > +++ b/tools/perf/builtin-probe.c
> > @@ -31,7 +31,7 @@
> >  #include <linux/zalloc.h>

> >  #define DEFAULT_VAR_FILTER "!__k???tab_* & !__crc_*"
> > -#define DEFAULT_FUNC_FILTER "!_*"
> > +#define DEFAULT_FUNC_FILTER "!_* & !*@plt"
> >  #define DEFAULT_LIST_FILTER "*"

> Thanks, works again ...

I took this as an Acked-by.

Thanks, applied.

- Arnaldo
