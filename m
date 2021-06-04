Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE16C07E94
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 13:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B30613FE
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 13:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhFDNYr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Jun 2021 09:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhFDNYr (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Jun 2021 09:24:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAAF0613F8;
        Fri,  4 Jun 2021 13:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622812980;
        bh=CacgOeszuf1puG/c/mHimSF4x/m/bEXJkxl9WmnMoB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sj3BnbI4EHX+6bgxdlb42T5rgwP/tLppFWYMMS7hj/18OxdcgT18WYPpeMYY9n5Fo
         wC7Y1soIZ7c/HbuCQqqc5xKErAaBCMMHbxnySKrUN9LMOMB+pN85PGVDTZFLTyxqFt
         v7W8TKWrpw5gnFa9hZw/wVlODMSihA2Xq8THa1OG5ENq3wGqEUy6nB+Gf7NZouenjQ
         CQI2ci9FC2at/9hf5HO0Bwb8b/RuiRYYqMiblwqpkxrqGTuSyqxzmmvrS2olyhV6OG
         FfpHaTh3y5H4OZcYJxqZsoWVtc1DI3kFyhzQfMZimnbGR13ppG+oAhdqU1+/x/oh/l
         U3oGmKhATzvTQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8D4A840EFC; Fri,  4 Jun 2021 10:22:56 -0300 (-03)
Date:   Fri, 4 Jun 2021 10:22:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf ksymbol: fix memory leak: decrease refcount of map
 and dso
Message-ID: <YLopMBgLWysdJbkm@kernel.org>
References: <20210602231052.317048-1-rickyman7@gmail.com>
 <CAP-5=fVxHUnwGoRypMjCsPSh_yo5PB8Hzbkx5ArA5b0=7S-67g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVxHUnwGoRypMjCsPSh_yo5PB8Hzbkx5ArA5b0=7S-67g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jun 03, 2021 at 09:26:40PM -0700, Ian Rogers escreveu:
> On Wed, Jun 2, 2021 at 4:15 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > +++ b/tools/perf/util/machine.c
> > @@ -776,6 +776,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
> >                 if (dso) {
> >                         dso->kernel = DSO_SPACE__KERNEL;
> >                         map = map__new2(0, dso);
> > +                       dso__put(dso);

> Will this cause 2 puts if the map allocation fails? Perhaps this
> should be "if (map) dso__put(dso);".

I think its just a matter of removing the put in the error path, i.e.
the patch becomes what is at the end of this message.

I.e. if map__new2() fails, we want to drop the dso reference, and if it
works, we already have a reference to it, obtained in map__new2().

But looking at this code now I realize that maps__find() should grab a
refcount for the map it returns, because in this
machine__process_ksymbol_register() function we use reference that 'map'
after the if block, i.e. we use it if it came from maps__find() or if we
created it machine__process_ksymbol_register, so there is a possible
race where other thread removes it from the list and map__put()s it
ending up in map__delete() while we still use it in
machine__process_ksymbol_register(), right?

- Arnaldo

> >                 }

> >                 if (!dso || !map) {
> > @@ -792,6 +793,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
> >                 map->start = event->ksymbol.addr;
> >                 map->end = map->start + event->ksymbol.len;
> >                 maps__insert(&machine->kmaps, map);
> > +               map__put(map);
> >                 dso__set_loaded(dso);

> >                 if (is_bpf_image(event->ksymbol.name)) {

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3ff4936a15a42f74..da19be7da284c250 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -776,10 +776,10 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		if (dso) {
 			dso->kernel = DSO_SPACE__KERNEL;
 			map = map__new2(0, dso);
+			dso__put(dso);
 		}
 
 		if (!dso || !map) {
-			dso__put(dso);
 			return -ENOMEM;
 		}
 
@@ -792,6 +792,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
 		map->start = event->ksymbol.addr;
 		map->end = map->start + event->ksymbol.len;
 		maps__insert(&machine->kmaps, map);
+		map__put(map);
 		dso__set_loaded(dso);
 
 		if (is_bpf_image(event->ksymbol.name)) {
