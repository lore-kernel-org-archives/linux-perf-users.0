Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED32C3A59F
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 23:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiKWXdv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 18:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiKWXd1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 18:33:27 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C60D2E9C5
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:33:21 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e11so12923wru.8
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHoRgpOG6UpCcnIIsuTyJxogKtWmFxCYDNS8zi8IZTs=;
        b=oOxEUTEV2rQYcyAWRViOgUP1YjGR23vTdliv2xGucKD9hYZRcIiUjXrSKj64yZ31dx
         Ccecejw4Fv0DbOROOvxJQ2EM2OtF/TUfKFYMi13a32DHsUIus3ga8sDfgp/SadxN0Vhj
         st5y0tq4Y/KD2z33LVayRyoXJn8GalSTKlpoPAgY6azT41EY75DPEoBNm3WFyLZsLcQG
         bUJ8b024VTCFh2RkVToxso5QoX/UaSMdx5DHLRy5U8PP85EeZZ1v8rR7dPW5nmE0c6as
         sBFhX2o1afvUcjfNDHp85J6bGhNVafhDdc08ix49jljBc6ZDrxXXxChJNl6cWjMOQA+M
         bRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHoRgpOG6UpCcnIIsuTyJxogKtWmFxCYDNS8zi8IZTs=;
        b=lXInuQWom7aG8yPX8n68roiv+fmFpwMKGFaoaiH7bPbitzzq0D1yAjGPUSYrcsO0Oz
         +61iclK/dBhqMeSsTRTymNnknCUq71Ci1qksj/ocPX36q1xMrPMYCLx5rYXErRbsRizl
         Etthgqxkm2Wp6UXxMczfGZKTRR6wzIEkxwiJnXRaaWXiw3+TD4hVbWsPM24jWxZI5VJe
         yZyi1FwGwoybxTe4+SGduApLuO5Y/5jmXuvqmjmbrA9mChB1b6pkHRX9IF1z+RCozXp1
         DHk2tZw6RYJu3qKPN58VgihMAkXKEeuqEK+fjU7DhJgVzg1h++EqT04nLW0u9gl7Fmjq
         RrWg==
X-Gm-Message-State: ANoB5pk/2SgvmC9rE2SMhsP/PJpdrMLQw0sWXFGo7b2v0fAgTcHh1R+o
        Mk1so0N8Qyba2qI6nh2DPg3h9CF8EQ1HNIMj+kqxCg==
X-Google-Smtp-Source: AA0mqf6tExX+WCBUu5RurGHj+X+lH4iRxhppCl5GJHP2l9kF7dw5kLx3kD42hkHcK3wH/kosbRZe0PzWVhQvSkLIPqU=
X-Received: by 2002:adf:f6cc:0:b0:228:dd1d:8a42 with SMTP id
 y12-20020adff6cc000000b00228dd1d8a42mr7222047wrp.375.1669246399414; Wed, 23
 Nov 2022 15:33:19 -0800 (PST)
MIME-Version: 1.0
References: <20221121082058.64578-1-zhengjun.xing@linux.intel.com>
 <CAP-5=fUQUe0UvLhaSBnm-dAPHc3_k8vZWNxhZajg8mg6R8og0g@mail.gmail.com>
 <Y34iAVLGAGhVH/ta@kernel.org> <Y34irx0jffj8NXRY@kernel.org>
In-Reply-To: <Y34irx0jffj8NXRY@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:33:06 -0800
Message-ID: <CAP-5=fVKXRcswFAMkTTBHTnvnEErhr0HExJ-HFKLHgZO71cbTw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] perf vendor events intel: Add core event list for Alderlake-N
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     zhengjun.xing@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 23, 2022 at 5:40 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Nov 23, 2022 at 10:37:05AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Mon, Nov 21, 2022 at 01:17:12PM -0800, Ian Rogers escreveu:
> > > On Mon, Nov 21, 2022 at 12:19 AM <zhengjun.xing@linux.intel.com> wrot=
e:
> > > >
> > > > From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> > > >
> > > > Alderlake-N only has E-core, it has been moved to non-hybrid code p=
ath on
> > > > the kernel side. Add core event list for Alderlake-N, it is based o=
n the
> > > > ADL gracemont v1.16 JSON file.
> > > >
> > > > https://github.com/intel/perfmon/tree/main/ADL/events/
> > > >
> > > > Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> > > > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> > >
> > > Acked-by: Ian Rogers <irogers@google.com>
> >
> > Is this just for 1/5? Or can I stick it to the whole series?
>
> But, after applying 1/5 I get:
>
>   CC      /tmp/build/perf/util/data-convert-bt.o
>   CC      /tmp/build/perf/util/data-convert-json.o
> /tmp/build/perf/pmu-events/pmu-events.c:55354:39: error: =E2=80=98pme_ald=
erlaken=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
> 55354 | static const struct compact_pmu_event pme_alderlaken[] =3D {
>       |                                       ^~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:97: /tmp=
/build/perf/pmu-events/pmu-events.o] Error 1
> make[2]: *** [Makefile.perf:711: /tmp/build/perf/pmu-events/pmu-events-in=
.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   CC      /tmp/build/perf/util/lzma.o
>   CC      /tmp/build/perf/util/zlib.o
>   CC      /tmp/build/perf/util/jitdump.o
>   CC      /tmp/build/perf/util/bpf-event.o
>   LD      /tmp/build/perf/util/perf-in.o
>   LD      /tmp/build/perf/perf-in.o
> make[1]: *** [Makefile.perf:240: sub-make] Error 2
> make: *** [Makefile:113: install-bin] Error 2
> make: Leaving directory '/var/home/acme/git/perf/tools/perf'
>
>  Performance counter stats for 'make -k BUILD_BPF_SKEL=3D1 CORESIGHT=3D1 =
O=3D/tmp/build/perf -C tools/perf install-bin':
>
>     26,049,918,108      cycles:u
>     47,580,273,158      instructions:u                   #    1.83  insn =
per cycle
>
>        4.655423698 seconds time elapsed
>
>        6.211852000 seconds user
>        5.060661000 seconds sys
>
>
> =E2=AC=A2[acme@toolbox perf]$
>
> Please fix it and send a v2.
>
> - Arnaldo

Thanks Arnaldo, my acked-by was for the whole series (missing cover
letter in v2). The mapfile.csv change was reordered in v2, I asked for
this. I think that change needs squashing into this one to avoid the
unused case.

Thanks,
Ian
