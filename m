Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E00C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 14:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F11861075
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Nov 2021 14:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhKLOtE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 09:49:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232403AbhKLOtC (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Nov 2021 09:49:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C419561039;
        Fri, 12 Nov 2021 14:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636728371;
        bh=FtxtfwPqOIwsbQD7uHzaZmEXMWTRq5bNtKNI9Y3lgs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZOr/ZmF78IiY1zE9t+ggdr6eqLjXltRRN2OoCdINZufTKKBrkBtDX7Tbd33BI/Aos
         AT3ZCVHckwFOSbFXgYKAE78Va2jzBnxXpXf/UHM4ZT7GWAOu+C4+dYO9riTlfmSKp0
         /sQG2IXa3NCjXcDipWb+8ov4PN8yxWn1LF1xcz7jnfVIMvSMkbtsmbd7RtL8f9qo3S
         SDeAohe9cEFXk5Q0x1+tXosVmKlY03QB4Sv02g+0B+MC88DWaIzjpoofqUoCzsY+l8
         7M3pKY1YBtNOThKFMgZRqMZa/gSWShzHbmGoF5KuoNOwdd6F4df12MiQBPNjTBODup
         xszft8JoQbhMQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 50FA8410A1; Fri, 12 Nov 2021 11:46:07 -0300 (-03)
Date:   Fri, 12 Nov 2021 11:46:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/3] perf symbols: Add documentation to struct symbol.
Message-ID: <YY5+L3RBCbR+Mly1@kernel.org>
References: <20211112035124.94327-1-irogers@google.com>
 <CAM9d7cji1Mtqap+TbMRn6ZeBb1v4ykKv4uBQxKtCQ3Zv9vY_jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cji1Mtqap+TbMRn6ZeBb1v4ykKv4uBQxKtCQ3Zv9vY_jg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Nov 11, 2021 at 08:04:35PM -0800, Namhyung Kim escreveu:
> Hi Ian,
> 
> On Thu, Nov 11, 2021 at 7:51 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Refactor some existing comments and then infer the rest.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> For all 3 patches,
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

b4 doesn't catch these Acked-by for the whole series when sent to one of
the patches, please consider to send your Acked-by/etc to the [PATCH
0/N] message in that case.

Thanks, applied!

- Arnaldo

 
> Thanks,
> Namhyung
> 
> 
> > ---
> >  tools/perf/util/symbol.h | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
> > index 166196686f2e..3586fa549f44 100644
> > --- a/tools/perf/util/symbol.h
> > +++ b/tools/perf/util/symbol.h
> > @@ -40,22 +40,33 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
> >                              GElf_Shdr *shp, const char *name, size_t *idx);
> >  #endif
> >
> > -/** struct symbol - symtab entry
> > - *
> > - * @ignore - resolvable but tools ignore it (e.g. idle routines)
> > +/**
> > + * A symtab entry. When allocated this may be preceded by an annotation (see
> > + * symbol__annotation), a browser_index (see symbol__browser_index) and rb_node
> > + * to sort by name (see struct symbol_name_rb_node).
> >   */
> >  struct symbol {
> >         struct rb_node  rb_node;
> > +       /** Range of symbol [start, end). */
> >         u64             start;
> >         u64             end;
> > +       /** Length of the string name. */
> >         u16             namelen;
> > +       /** ELF symbol type as defined for st_info. E.g STT_OBJECT or STT_FUNC. */
> >         u8              type:4;
> > +       /** ELF binding type as defined for st_info. E.g. STB_WEAK or STB_GLOBAL. */
> >         u8              binding:4;
> > +       /** Set true for kernel symbols of idle routines. */
> >         u8              idle:1;
> > +       /** Resolvable but tools ignore it (e.g. idle routines). */
> >         u8              ignore:1;
> > +       /** Symbol for an inlined function. */
> >         u8              inlined:1;
> > +       /** Architecture specific. Unused except on PPC where it holds st_other. */
> >         u8              arch_sym;
> > +       /** Has symbol__annotate2 been performed. */
> >         bool            annotate2;
> > +       /** The name of length namelen associated with the symbol. */
> >         char            name[];
> >  };
> >
> > --
> > 2.34.0.rc1.387.gb447b232ab-goog
> >

-- 

- Arnaldo
