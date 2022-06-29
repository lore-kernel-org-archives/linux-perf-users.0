Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F479C43334
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Jun 2022 21:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiF2Vg1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 17:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiF2VgU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Jun 2022 17:36:20 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDA03916D
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 14:36:16 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x3so30351136lfd.2
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jun 2022 14:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F8h16dBw6sz8iObiMOofBZlkMu51Vyu4qakRzQ8vggs=;
        b=Tvr3GdABTsiC5R8mfH5IZtdYKQmmgaMIZYsMfGKep9A6ApnT7WLJDwSwDCVW5aWxCE
         X3O3hcZnI8IOH4A8bD7+QWwafb6FCfOhp7iIqoi8qVrUPi0k2m96OuJDHJpiOLD7SYa5
         3bPjHWASkQJAzIZxoKEP6LWvCVsjwj7rVGpCXDj6cVPlGFDgpDhsy2qgOE7QU9DQdq9/
         aG0Yqj7jtoUvDZgvWreHL4uU5kpa4FncAiXWGYILJf16GBprjmBe4EEyi2wG525DNaGU
         M9rVcjcHeuPUQJOuIWi9gSyfgQBNs9Db1S/DqBhn8Id1Z/PWpV/SkZoC//IxYMyr+A6h
         WaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F8h16dBw6sz8iObiMOofBZlkMu51Vyu4qakRzQ8vggs=;
        b=AhdG69qTOpOiu6pNevaTrramocHym1o5v5zyNdFOqE1fGO0eFpR09RtX8pgCwW01pZ
         Gtx5u+2KYjktarCn3UpcZoG/hWq/dJhX71fRaKV4i9fd0kcN6+Zs+OjSz3f4upLGRIo1
         50PSWOO+KZVxjNm+7XD7vnQXHdzUivrtMutjpJBCeoVA566HvJYaW0kuFsmy/6yqIB4E
         SOW07Zz+/AeX9NCsrFIQob77oXoZ6qJIKSSU4RWHvw9IwGn4wvN95suYuHA9gp1Uu1ZU
         VkdqY0V8sJWdUnheokwbdS2GzvyzsMKK7CIIViTfwlGCcSR99R9ksN99Q5WbwUS40dtH
         E5hA==
X-Gm-Message-State: AJIora8lxTRdie/v/eo4ft/pd9ZbFeFC6+vM0oUWTjqDsziWXcCdYn6K
        YTr2PP53pdcjf7nfrV/cwcriR2/kU3kfK/0fIdBbRA==
X-Google-Smtp-Source: AGRyM1uSGPXGmFzglZU8sKDUqFQIIDNk10ImQ8Rh1d6LMvbsyslpO+AbuQTaEXGas+kuCXcld3gau0EoS71B6+4mgi8=
X-Received: by 2002:a05:6512:ac6:b0:47f:6f70:16e5 with SMTP id
 n6-20020a0565120ac600b0047f6f7016e5mr3477754lfu.170.1656538574425; Wed, 29
 Jun 2022 14:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220627224116.3015376-1-blakejones@google.com> <Yrwdm4eW+lFtByiZ@krava>
In-Reply-To: <Yrwdm4eW+lFtByiZ@krava>
From:   Blake Jones <blakejones@google.com>
Date:   Wed, 29 Jun 2022 14:36:03 -0700
Message-ID: <CAP_z_Cg4ZjfjYuCVZeCsReJZQnHrLZKvAk_Txb1OoiNojT3L6w@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] Add a "-m" option to "perf buildid-list".
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Thanks for taking a look at this!

On Wed, Jun 29, 2022 at 2:38 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > +static int buildid__map_cb(struct map *map, void *arg __maybe_unused)
> > +{
> > +     const struct dso *dso = map->dso;
> > +     char bid_buf[SBUILD_ID_SIZE];
> > +
> > +     memset(bid_buf, 0, sizeof(bid_buf));
> > +     if (dso->has_build_id)
> > +             build_id__sprintf(&dso->bid, bid_buf);
> > +     printf("%s %16lx %16lx", bid_buf, map->start, map->end);
> > +     if (dso->long_name != NULL)
> > +             printf(" %s", dso->long_name);
>
> nit, should we display short_name in case long_name is missing?

I can do that.

> > +int machine__for_each_kernel_map(struct machine *machine, machine__map_t fn, void *priv)
> > +{
> > +     struct maps *maps = machine__kernel_maps(machine);
> > +     struct map *map;
> > +     int err = 0;
> > +
> > +     for (map = maps__first(maps); map != NULL; map = map__next(map)) {
> > +             if (fn(map, priv))
> > +                     err = -1;
>
> I think we should rather break in here and return user's error

I'd structured it this way to be analogous to machine_for_each_dso(),
immediately above it, but I'm happy to make this change.

> other than that, the patch looks good to me

Great, thanks! Updated patch coming shortly.

Blake
