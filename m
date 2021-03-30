Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F773C433DB
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 Mar 2021 15:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E79C8619D2
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 Mar 2021 15:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhC3PnB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:43:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:40738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231650AbhC3Pmr (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 Mar 2021 11:42:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FD02619C7;
        Tue, 30 Mar 2021 15:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617118967;
        bh=14UiL5GZC31SE+EOYu3chUF7P/wJNPq78udsHoMIXcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IU1POTgvXcETm/RFMiUXuYXp8u5L+mfgZDlJ+kA173cIPhe8Z8xoZ35d445es9alp
         YguaHWwQAKxjoCkH6Av4l7CJjvK9dnbnpcyFi9woBO1++H++WEZ4eK0p1UWW9uHkiz
         yS2/ToPSwn3V7wd3dMLvDi7YMa/lMlm9Mh3lLHHTn+JMDPU4LEmF8n6GAx8iTnNhWi
         U1APK8NBUkI1euaE1bOGitBVQMY1CiUtL2Vm9FgSX8ZxrlRZVJdWXjbUKmc81kUdAi
         xHuikVqQIk4v/8+87+wJNo/Fsx1gRYJ2cINmi/8CZgRNzboMEM7apATs71pGk0mTCm
         dv8PuyTyX3ycQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F058A40647; Tue, 30 Mar 2021 12:42:44 -0300 (-03)
Date:   Tue, 30 Mar 2021 12:42:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf annotate: add --demangle and --demangle-kernel
Message-ID: <YGNG9PLKEniErXwy@kernel.org>
References: <deb2af9e-25dd-ac72-29f4-ab90c2b24237@suse.cz>
 <YDVcZJscuKIgShsm@kernel.org>
 <a2349b3e-b3e2-f979-6bc5-a2cffbdd2d6a@suse.cz>
 <cad07055-620e-f0ce-9af2-a8a794bc47aa@suse.cz>
 <71d26f15-f0e8-adca-1e7c-46effcba913a@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71d26f15-f0e8-adca-1e7c-46effcba913a@suse.cz>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Mar 30, 2021 at 09:41:33AM +0200, Martin Liška escreveu:
> PING^2
> 
> On 3/7/21 8:23 PM, Martin Liška wrote:
> > Hello.
> > 
> > May I please remind this patch. Apparently, you applied the perf-config
> > counterpart of the patch as 804fd30c6bd9aec7859a0503581312834fb197f1
> > (in tmp.perf/core branch), but we miss setting the same via options.
> > 
> > Thank you,
> > Martin
> > 
> > On 2/26/21 11:01 AM, Martin Liška wrote:
> > > On 2/23/21 8:49 PM, Arnaldo Carvalho de Melo wrote:
> > > > Em Mon, Feb 22, 2021 at 09:29:22AM +0100, Martin Liška escreveu:
> > > > > Perf annotate supports --symbol but it's impossible to filter
> > > > > a C++ symbol. With --no-demangle one can filter easily by
> > > > > mangled function name.
> > > > > 
> > > > > Signed-off-by: Martin Liška <mliska@suse.cz>
> > > > > ---
> > > > >   tools/perf/Documentation/perf-annotate.txt | 7 +++++++
> > > > >   tools/perf/builtin-annotate.c              | 4 ++++
> > > > >   2 files changed, 11 insertions(+)
> > > > > 
> > > > > diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
> > > > > index 1b5042f134a8..80c1be5d566c 100644
> > > > > --- a/tools/perf/Documentation/perf-annotate.txt
> > > > > +++ b/tools/perf/Documentation/perf-annotate.txt
> > > > > @@ -124,6 +124,13 @@ OPTIONS
> > > > >   --group::
> > > > >       Show event group information together
> > > > > +--demangle::
> > > > > +    Demangle symbol names to human readable form. It's enabled by default,
> > > > > +    disable with --no-demangle.
> > > > > +
> > > > > +--demangle-kernel::
> > > > > +    Demangle kernel symbol names to human readable form (for C++ kernels).
> > > > > +
> > > > >   --percent-type::
> > > > >       Set annotation percent type from following choices:
> > > > >         global-period, local-period, global-hits, local-hits
> > > > > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> > > > > index a23ba6bb99b6..ef70a17b9b5b 100644
> > > > > --- a/tools/perf/builtin-annotate.c
> > > > > +++ b/tools/perf/builtin-annotate.c
> > > > > @@ -538,6 +538,10 @@ int cmd_annotate(int argc, const char **argv)
> > > > >               "Strip first N entries of source file path name in programs (with --prefix)"),
> > > > >       OPT_STRING(0, "objdump", &annotate.opts.objdump_path, "path",
> > > > >              "objdump binary to use for disassembly and annotations"),
> > > > > +    OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
> > > > > +            "Disable symbol demangling"),
> > > > 
> > > > Nope, this _enables_ demangling, i.e.:
> > > > 
> > > >     perf annotate --demangle
> > > 
> > > Oh, yeah, you are right.
> > > 
> > > > 
> > > > Asks for symbol demangling, while:
> > > > 
> > > >     perf annotate --no-demangle
> > > > 
> > > > As you correctly wrote in your commit message and on the
> > > > --demangle-kernel case, enables demangling.
> > > 
> > > Fixed that in V2.

Trying to find V2

- Arnaldo
