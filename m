Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE28EC433ED
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Apr 2021 21:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F38261445
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Apr 2021 21:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbhD2Vc4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Apr 2021 17:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237184AbhD2Vc4 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Apr 2021 17:32:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1799D613AD;
        Thu, 29 Apr 2021 21:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619731929;
        bh=k33BblzLXcEhwHXhnkR3kTkgLIccxbjvGRLQ0ZE5B5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MSvkhUVj/2YSAEDJhrz4em3iJ8ZGgdhGZzZcS/13pBc45UMH7zzi3l6QJvlj5ssZ7
         v41G6AdmkQrbQgf34nQJFpll2u1iK3MZLQJysXzpG8YCA1Je2gfXT4rZML0f8b4BwF
         ZHqa9gMSGZxeix8zpO7Bf0mt6hzu0bLKdz8Ig6VnCxBeHK9QgHl3Gd9y2RsbXXmslS
         8VLBktF1mxpu0OF686yTaBEwPxRB1kGKbQ5yY9oJ7XMYfDtWEnLSnjF1fulNdw3KEq
         5icvRNr3/lzXrB32NU7NEGc+btMOwPKusonrOV/GSgGgVpUGUKNPchb34+onjYHF/J
         irnV636ZmBhbA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6977B4034C; Thu, 29 Apr 2021 18:32:06 -0300 (-03)
Date:   Thu, 29 Apr 2021 18:32:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Muni Sekhar <munisekharrms@gmail.com>
Cc:     peter enderborg <peter.enderborg@sony.com>,
        Greg KH <greg@kroah.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: Scheduler benchmarks
Message-ID: <YIsl1o19AoQwgelk@kernel.org>
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
 <20200818143633.GA628293@kroah.com>
 <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
 <20200818171457.GA736234@kroah.com>
 <CAHhAz+ggd4DPFfWPB+h6Obkjebf5mv5cV6307oKEkEYMhAB3wQ@mail.gmail.com>
 <20200818173656.GA748290@kroah.com>
 <CAHhAz+hi9rh5w8hNyas0RkO4WwZXsSNh5g0nS710NSr6-ntioQ@mail.gmail.com>
 <84362b8b-971f-fb89-115d-41d2457c24fd@sony.com>
 <CAHhAz+iC_F5w5EoZP8-dBNm+DV0uNMva6Mr2uBdmZtejL1OH-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhAz+iC_F5w5EoZP8-dBNm+DV0uNMva6Mr2uBdmZtejL1OH-w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Aug 19, 2020 at 03:46:06PM +0530, Muni Sekhar escreveu:
> On Tue, Aug 18, 2020 at 11:45 PM peter enderborg <peter.enderborg@sony.com> wrote:
> > On 8/18/20 7:53 PM, Muni Sekhar wrote:
> > > On Tue, Aug 18, 2020 at 11:06 PM Greg KH <greg@kroah.com> wrote:
> > >> On Tue, Aug 18, 2020 at 11:01:35PM +0530, Muni Sekhar wrote:
> > >>> On Tue, Aug 18, 2020 at 10:44 PM Greg KH <greg@kroah.com> wrote:
> > >> Those are _very_ different kernel versions, with many years and tens of
> > >> thousands of different changes between them.
> > >>
> > >> Hopefully the newer kernel is faster, so just stick with that :)
> > > But unfortunately the newer kernel is very slow, that is the reason
> > > for starting this investigation :)
> > > Any type of help,  and guidelines to dive deeper will be highly appreciated.
> >
> > On the 4.4 kernel you dont have
> >
> > +CONFIG_RETPOLINE=y
> > +CONFIG_INTEL_RDT=y
> Thanks! That is helpful. Yes, I see 4.4 kernel don't have the above
> two config options.
> What analysis can be done to narrow down the root cause?
> Any example of reference could be helpful to understand.

This made me remember Lisbon:

http://vger.kernel.org/~acme/perf/bpf-is-eating-the-world-dont-you-see-lpc-lisbon-2019/#/8/2

Greg was there when this slide was first shown... ;-)

Look at the icache misses when the kernel is entered (syscall entry).

Then add this to the kernel command line: "nospectre_v1 nospectre_v2"

And see what happens:

http://vger.kernel.org/~acme/perf/bpf-is-eating-the-world-dont-you-see-lpc-lisbon-2019/#/8/3

So using these (and any new ones related to disabling hardware flaw
mitigation) maybe a way to analyse this, if you haven't figured this out
yet, sorry for the huge delay in replying 8-)

- Arnaldo
 
> >
> > And your base is very different two.
> >
> > Try to use mainline on both system and see.
> >
> > You can also use the same base kernel version from ubuntu and
> >
> > run your test.
> >
> >
> > >> greg k-h
> > >
> > >
> >
> 
> 
> -- 
> Thanks,
> Sekhar

-- 

- Arnaldo
