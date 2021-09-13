Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66930C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Sep 2021 19:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46747610D1
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Sep 2021 19:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242134AbhIMT0P (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240264AbhIMT0P (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Sep 2021 15:26:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D049E610CE;
        Mon, 13 Sep 2021 19:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631561099;
        bh=fuaKDvVAdX8JJK/kmv1HD2KrOMdsK0/f1EDonGzUoQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TaafJSlSrVh51ckSolLgnHFZjBdhNPxrTi9rsDe8Praik1ijV4XDPiTeWou17Hhma
         Ln0FkKfYaKVUm2vWOp4K6pu6hm/KsJEx/oYhJsjdsLc8LbiZ5Q0W+RiSBdC9NFpJOo
         9YG4lh4Vs87d/uVgs103D9fMKqWcmreHVTBD1zX6rhz87mVpwmUctTKE8P3ShqGoW0
         lqmLlOIoabUqZDvifisD9x8jLswby6nP8j+2mEQ21M5Bia6Jvz0JIRsS5iMzF3dEdE
         +YSGPdtsp1wAsm6vc5PVan84IJAFaykHA7UuyKaYG8/9nEXQsaA5supwyFP8dHoGxQ
         CSfh66lXtlzaw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CBF754038F; Mon, 13 Sep 2021 16:24:52 -0300 (-03)
Date:   Mon, 13 Sep 2021 16:24:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     =?iso-8859-1?Q?R=E9mi?= Bernon <rbernon@codeweavers.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf symbol: Look for ImageBase in PE file to compute
 .text offset
Message-ID: <YT+lhAhBGprnMT7P@kernel.org>
References: <20210909192637.4139125-1-rbernon@codeweavers.com>
 <YTpuTiYzkTKbUM/l@kernel.org>
 <e8ae2882-12cd-0fe1-b5e6-da9fc286b821@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8ae2882-12cd-0fe1-b5e6-da9fc286b821@codeweavers.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sun, Sep 12, 2021 at 10:25:26AM +0200, Rémi Bernon escreveu:
> On 9/9/21 10:27 PM, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Sep 09, 2021 at 09:26:36PM +0200, Remi Bernon escreveu:
> > > Instead of using the file offset in the debug file.
> > > 
> > > This fixes a regression from 00a3423492bc90be99e529a64f13fdd80a0e8c0a,
> > > causing incorrect symbol resolution when debug file have been stripped
> > > from non-debug sections (in which case its .text section is empty and
> > > doesn't have any file position).
> > > 
> > > The debug files could also be created with a different file alignment,
> > > and have different file positions from the mmap-ed binary, or have the
> > > section reordered.
> > > 
> > > This instead looks for the file image base, using the corresponding bfd
> > > *ABS* symbols. As PE symbols only have 4 bytes, it also needs to keep
> > > .text section vma high bits.
> > 
> > I added a:
> > 
> > Fixes: 00a3423492bc90be ("perf symbols: Make dso__load_bfd_symbols() load PE files from debug cache only")
> > 
> > To help stable@kernel.org to pick it, its on my local tree now.
> > 
> > It would be great to get a:
> > 
> > Reviewed-by: Nicholas Fraser <nfraser@codeweavers.com>
> > 
> > Can we have it, please?
> > 
> 
> Well, Nicholas doesn't work with us anymore. I've reached them separately
> but didn't get any answer so I'm thinking they may not be interested.

No problem, its already upstream now.

Thanks,

- Arnaldo
