Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473E2C47083
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 04:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E4A46140C
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 04:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhFDE3y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Jun 2021 00:29:54 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:38865 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhFDE3y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Jun 2021 00:29:54 -0400
Received: by mail-wr1-f51.google.com with SMTP id j14so7890377wrq.5
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Jun 2021 21:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7UWd9c23gbJeqKN+x05xqP4SMfjB2/ClR1agz1P2O+o=;
        b=TiAICjH6rsZIbGZ0XdCOAiZXNFUhWsTiGyyMuob+l8IGv9uNIN+jjSUy2wya5b37kH
         8Lhl3dCFLzyC7SUYg1zjfdUrvJAI/mNDqguToa/NpRNQJMI4RNs1CQ/rWwXGeuXyDVuM
         bnV8VaIKZX0l6jxDyxlSiis1p/SqkDDAhXdFsadWl/iiw/AvvSWBMv0+MjTkO69rL8hS
         +cuN2Q3ULZWR3j02VXRXEh9N36nKVI69dkNYKY4qT0Vo91S6QDwXe9ZoRLI0LQHQZUQl
         rTFbUgivH8wU6CECRAVmwg8JdygB/aBXkIrTukFKkqYcM3uiqolcaQ6wQhVVWDh9z7At
         dM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7UWd9c23gbJeqKN+x05xqP4SMfjB2/ClR1agz1P2O+o=;
        b=l08OS0R/mZUbU/QHyMWjRc5ILvLCU07u6E+NsuxFpe3qu5wNLJ+fTPOYzV9h7sd77f
         lU5IIrJNzdDsy4m8EH+OmaW5Ss5PVWVx/2KXahRYIu9l7HXd6IJX4MMEwuvJTQawQ/5A
         IRuFvBSMpvbnD+XqUI4BiORGx3PMP47JQxAMpC9w0KlBl8FBwX7LXYiZn1KGwQCAClpS
         xDnKZDSB2MB6eLl6pJxn4Ye7eEKG1dYUtP4t3Ow2XXy91GugmxbxMSfALddcEEbGf3t2
         0SBwAxHiiYB8Ab7PpWepCJI4v2+r7qcDOQYxLyR/upYtNCesW5j+YH7EcGCrHQt/JbzF
         D6xA==
X-Gm-Message-State: AOAM531xLPJPbOYWUzc9d5GVIHKf3hf8LKtf8G4o2cibpTlqQEoSxoZP
        bfjr9EDkPXztDgOUNzY2DXzpC4tdDILC6w5BJnOasXEiyhmU2rf8
X-Google-Smtp-Source: ABdhPJxpoHQxaUxpi3FcOjDlpn8+51W8yCO8DE/Kx7g9qyHOmNa1n7quM25+dXoWEvHIBzJ3zdEYP/LPDc0Ffk5e1A8=
X-Received: by 2002:a5d:4903:: with SMTP id x3mr1531894wrq.376.1622780812951;
 Thu, 03 Jun 2021 21:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210602231052.317048-1-rickyman7@gmail.com>
In-Reply-To: <20210602231052.317048-1-rickyman7@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 3 Jun 2021 21:26:40 -0700
Message-ID: <CAP-5=fVxHUnwGoRypMjCsPSh_yo5PB8Hzbkx5ArA5b0=7S-67g@mail.gmail.com>
Subject: Re: [PATCH] perf ksymbol: fix memory leak: decrease refcount of map
 and dso
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 2, 2021 at 4:15 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> ASan reported a memory leak of BPF-related ksymbols map and dso.
> The leak is caused by refcount never reaching 0, due to missing
> __put calls in the function machine__process_ksymbol_register.
> Once the dso is inserted in map, dso__put should be called,
> since map__new2 has increased its refcount to 2.
> The same thing applies for the map when it's inserted into the
> rb-tree in maps (maps__insert increases the refcount to 2).
>
> $ sudo ./perf record -- sleep 5
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.025 MB perf.data (8 samples) ]
>
> =================================================================
> ==297735==ERROR: LeakSanitizer: detected memory leaks
>
> Direct leak of 6992 byte(s) in 19 object(s) allocated from:
>     #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
>     #1 0x8e4e53 in map__new2 /home/user/linux/tools/perf/util/map.c:216:20
>     #2 0x8cf68c in machine__process_ksymbol_register /home/user/linux/tools/perf/util/machine.c:778:10
>     [...]
>
> Indirect leak of 8702 byte(s) in 19 object(s) allocated from:
>     #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
>     #1 0x8728d7 in dso__new_id /home/user/linux/tools/perf/util/dso.c:1256:20
>     #2 0x872015 in dso__new /home/user/linux/tools/perf/util/dso.c:1295:9
>     #3 0x8cf623 in machine__process_ksymbol_register /home/user/linux/tools/perf/util/machine.c:774:21
>     [...]
>
> Indirect leak of 1520 byte(s) in 19 object(s) allocated from:
>     #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
>     #1 0x87b3da in symbol__new /home/user/linux/tools/perf/util/symbol.c:269:23
>     #2 0x888954 in map__process_kallsym_symbol /home/user/linux/tools/perf/util/symbol.c:710:8
>     [...]
>
> Indirect leak of 1406 byte(s) in 19 object(s) allocated from:
>     #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
>     #1 0x87b3da in symbol__new /home/user/linux/tools/perf/util/symbol.c:269:23
>     #2 0x8cfbd8 in machine__process_ksymbol_register /home/user/linux/tools/perf/util/machine.c:803:8
>     [...]
>
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/machine.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 3ff4936a15a42..d5937778875e1 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -776,6 +776,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
>                 if (dso) {
>                         dso->kernel = DSO_SPACE__KERNEL;
>                         map = map__new2(0, dso);
> +                       dso__put(dso);

Will this cause 2 puts if the map allocation fails? Perhaps this
should be "if (map) dso__put(dso);".

Thanks,
Ian

>                 }
>
>                 if (!dso || !map) {
> @@ -792,6 +793,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
>                 map->start = event->ksymbol.addr;
>                 map->end = map->start + event->ksymbol.len;
>                 maps__insert(&machine->kmaps, map);
> +               map__put(map);
>                 dso__set_loaded(dso);
>
>                 if (is_bpf_image(event->ksymbol.name)) {
> --
> 2.31.1
>
