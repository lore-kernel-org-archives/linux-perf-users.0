Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7128C25B08
	for <linux-perf-users@archiver.kernel.org>; Wed, 17 Aug 2022 06:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiHQGBk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 17 Aug 2022 02:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiHQGBi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Aug 2022 02:01:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D999C72ED4
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Aug 2022 23:01:36 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j7so15005362wrh.3
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Aug 2022 23:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=pEfAVAxWJXoJIXxB3VHZJ8vG43/WOXk9aDnpoOjZ6lw=;
        b=qYQJj0a6LSPI8R8WeCajCBaR8m4rSdefImsfMUzcX98F2vNNFlc6g+QfHWWKWfhbxk
         n22CowZron62myVfRI5h2tqwAkoGv1byPpArT+r60qu7xbVJA1e84DLEe6J2lAJ9d3in
         ZWaMk7OLEmrnsO6riof8EH0bX+Frjsu8VnAdD5hb3aB/ArGNQYMIOOiFQypJNFHpYp05
         z4y6ucZ8SKcoCmKs15tA+El7ymlwheKgrXXGCew/xohw2oaHpwFxbuvPZeT3ionEPl7h
         vQwAMcIoGPBT/Tqa8s4QHnpcw1JIywT88yxbxFmwiYW/TB9HzC+izh0VAx6MBD8Ashwc
         wtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=pEfAVAxWJXoJIXxB3VHZJ8vG43/WOXk9aDnpoOjZ6lw=;
        b=RVux/Y+PD0jHPuI8KfGolyzL+nCyrS4RQW5CFrFjx6+MfBrEMq9Re3E/G2jghUO7Sz
         E/WamSNMN8y4FI0EtscixB3bQ9zevIDOTXD3dpJtY7wmLqdjBiCTxe0Y2PWfl6h9OJ4F
         nhBZnBca2SfITvuoAlnozSs5tc2eKMCiTVz964aYSLZ0PDVAUMvi9OGokn/PwrqarNqn
         n1RbksMvDZuYeHNkXqXXcjnlLzx+pEMeGMvup2BvG5qydmX4gwlEyUKjPNOq1UWmy1SO
         79M7WFqxr7B8UY65usbZCmp2zVbxg4/vK32m63Qj4EjcahnqFh8bP+SHd89ZXPzTnDpP
         iVQQ==
X-Gm-Message-State: ACgBeo14PZon9lIOKaZ74DE1XZN76isxL5IGkYt6lqOItqINg9vwPtJW
        cXPEIziL2kmXgsocWhk3HLmjt8oVycxgxR8os++emg==
X-Google-Smtp-Source: AA6agR7R9xBXecwSit10SZQcOcWDoqrGP/tX7H+/4sAvHqw+sxH/OVFj7urKO4y0Jgre/AC4aPgUljiZneAjvzw6gd0=
X-Received: by 2002:a05:6000:1ac9:b0:220:7f40:49e3 with SMTP id
 i9-20020a0560001ac900b002207f4049e3mr13085130wry.40.1660716095206; Tue, 16
 Aug 2022 23:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <cecae74c-6bb2-d7da-bce3-35772b6e3f8c@intel.com>
 <CAP-5=fXJtRVKuPA_xpa=jBzq66y5JMv+jmr1GFNzh-zQ-7j5QA@mail.gmail.com>
 <CAM9d7cgWXP2s25XUM90=b5Eaojutxi=LobkqrUkRoF5gek4DPQ@mail.gmail.com>
 <edd637d1-e85c-bc18-a8a2-8aa63d02146f@intel.com> <CAP-5=fWRNO+dmrnq_3a-L6Vdfd2i3oEB8y2+7F2ik7Lc35s5Pg@mail.gmail.com>
 <53428314-9dfc-288d-d109-79240fba82ac@intel.com>
In-Reply-To: <53428314-9dfc-288d-d109-79240fba82ac@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 16 Aug 2022 23:01:22 -0700
Message-ID: <CAP-5=fXEE9pvz_maO3BGAAWyaHjBpxcW0uPmvACZBovAqXC6ug@mail.gmail.com>
Subject: Re: perf tools man pages on the web
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Aug 16, 2022 at 10:24 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 16/08/22 16:25, Ian Rogers wrote:
> > On Mon, Aug 15, 2022 at 11:05 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 16/08/22 08:07, Namhyung Kim wrote:
> >>> Hi Ian and Adrian,
> >>>
> >>> On Mon, Aug 15, 2022 at 7:56 AM Ian Rogers <irogers@google.com> wrote:
> >>>>
> >>>> On Mon, Aug 15, 2022 at 5:05 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>>>>
> >>>>> Hi
> >>>>>
> >>>>> I notice man pages on man7.org e.g.
> >>>>>
> >>>>>         https://www.man7.org/linux/man-pages/man1/perf.1.html
> >>>>>
> >>>>> do not get updated every release, and I wondered if the perf tools
> >>>>> man pages should also be under:
> >>>>>
> >>>>>         https://docs.kernel.org/tools/index.html
> >>>>>
> >>>>> Thoughts?
> >>>>
> >>>> Sounds good to me. I'm assuming it would be some kind of build step
> >>>> that would take the man pages and add them to what linux-doc needs?
> >>>
> >>> I guess it's the RST format.  I'm not sure if there's a converter
> >>> from asciidoc to RST.
> >>
> >> Could use the html files that are already generated by:
> >>
> >>         make -C perf/tools html
> >
> > A lot of the man page makefile code comes from git and wasn't in great
> > shape the last I looked [1]. I believe that would be true for the HTML
> > output. As there are existing dependencies on rst2man for BPF [2], I
> > think it'd be cleaner to migrate all the man pages to rst format with
> > new man page build rules using rst2man. Wdyt?
>
> That seems like a larger job.  For now, I am just suggesting copying the
> html files onto kernel.org.

So I'm not sure the HTML is in any kind of shape. The build rules and
configuration files are remnants of what git had many many years ago.
I did a quick experiment going via docbook (which we do currently in
the man page generation) and using pandoc to write out rst:

$ cd tools/perf/Documentation
$ asciidoc -o - -b docbook -d manpage -f asciidoc.conf perf.txt|pandoc
-f docbook -t rst > perf.rst
$ man2rst perf.rst perf.man
$ man ./perf.man

and got something functional but with these warnings:

perf.rst:7: (ERROR/3) Unexpected indentation.
perf.rst:11: (WARNING/2) malformed hyperlink target.
perf.rst:66: (WARNING/2) malformed hyperlink target.
perf.rst:76: (WARNING/2) malformed hyperlink target.

So we might be able to convert somewhat automatically but have to fix
up hyperlinks.

Thanks,
Ian

> + Mauro
>
> Mauro, do you know if that is feasible?
>
> >
> > Thanks,
> > Ian
> >
> > [1] https://lore.kernel.org/all/20210715013343.2286699-1-irogers@google.com/
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/linux/bpf.h#n1538
> >
> >>>                        Anyway having the perf man pages in the
> >>> tools section looks good.
> >>>
> >>>>
> >>>> Fwiw, there has been some effort to try to improve the wiki:
> >>>> https://perf.wiki.kernel.org/index.php/Main_Page
> >>>> For example, the useful links are now broken apart and have more
> >>>> links, there is a work-in-progress glossary. Perhaps there can be some
> >>>> guidance on what to capture and where.
> >>>
> >>> Thanks for working on this.  I really need to take a look...
> >>>
> >>> Thanks,
> >>> Namhyung
> >>
>
