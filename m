Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35868C83F14
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Aug 2023 21:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240997AbjH3VPm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Aug 2023 17:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240966AbjH3VPl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Aug 2023 17:15:41 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD07185
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Aug 2023 14:15:10 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-40c72caec5cso93941cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Aug 2023 14:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693429979; x=1694034779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDyEAkj4X8lyPE0FXDJBz2Vf111jV2n3SpJzSYcTvbU=;
        b=5LX0cRX1qAYkVD5hbYA9f73QVkXLD5HsyrXG6+52kMtyb73QuxL0Wfq7Jh5i1k3x/d
         PQnUDZIEYCt7ZQaJh6EK+XjV9igHgaA5Tj6nzZ0RTtAuHpvdiFzBSKkNRaopr2rSDIcA
         b1KiSgvldZAgaUiRU5JUe6RbeJG/PXvd80E0oh2pA4b5Et/rVHbrzo6h36PrPnKuLP0q
         Wsrx4UeNfBfO0Z7NPy95qMmBjjiNEB56AXCPsVZUyIFhLibCOAWGvOJ491G5Lp7cYkx2
         T/t3UP66EbRMhj69Wk0wTwkUyCkJ0kUuQNuIJvrA4/Ra/GDizSCK5jtFOCnyX+lDEYwO
         2B9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693429979; x=1694034779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDyEAkj4X8lyPE0FXDJBz2Vf111jV2n3SpJzSYcTvbU=;
        b=a0sg9W3uABKkmvg/K6c118Z9DIWJWeRcXUZ79pCSFvd3+HXIDqtELDLuz6gObFavMa
         vk2Ge2iJiOHp50jS5HBNwfdcZZzhX+7FmVUFm/qZeNSh5jLr2B3pkNU0xGw8r6cxe/Yg
         ko08ST3ETWtNENV9CeB+/BhovRr/B5sOtR4RXhqAdtFIIEaxBuABytem+yU6QqPWAnH+
         1uNgNtFqPUIxuS2PS703GCFLJd/7Q02R9lMXZvkeqNKJfzFfSgSQXRNjtX+SRziLUmJH
         LDvND38MDIuybD8LhpRTADvUbRgiMfC4QKi86CobYVk+h8IkdAk++fVMwtypcl0SQU1u
         lkoA==
X-Gm-Message-State: AOJu0YztK85Hb5PcDVU64VN/A5sAuWbOqY+vJUskkljXIqx2C6RbTrMV
        11PyYPBzPs5FOGivKFt6ODN1o+v5Zcr2TY51n1dpaY29CkAlD16chV9VRQ==
X-Google-Smtp-Source: AGHT+IElbYhhvOUi4NfPIKAhxIaRgsTl7PbbvXzQjUMQp1ZbV5tkfal7yheNpzAwaKYnnkhkBjrfsLZUTHF/Gn0CZZ8=
X-Received: by 2002:ac8:5941:0:b0:3f8:5b2:aef0 with SMTP id
 1-20020ac85941000000b003f805b2aef0mr84679qtz.24.1693429979372; Wed, 30 Aug
 2023 14:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230830070753.1821629-1-irogers@google.com> <20230830070753.1821629-2-irogers@google.com>
 <4de84370-29f3-75ed-9c91-330636cdd790@linux.intel.com> <CAP-5=fXMgeER2FkAF2jZOAP0c=sxqhU8scxew6jXQrEYjN_S=Q@mail.gmail.com>
 <CAP-5=fUXG9tfN2nahiVpBDiggkhmhFiBZYubCSN6vG4voJ_X2A@mail.gmail.com>
 <b976ef43-25ea-f24a-2c22-0976fafcf0f0@linux.intel.com> <127766c6-033c-dedb-2c56-7e1e7f8bd01b@linux.intel.com>
In-Reply-To: <127766c6-033c-dedb-2c56-7e1e7f8bd01b@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Aug 2023 14:12:47 -0700
Message-ID: <CAP-5=fVhEe7N+BQ+8MngjqxRXDBoo6xy065zTn_hdO1CRDTtLw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] perf parse-events: Make common term list to strbuf helper
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 30, 2023 at 12:35=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2023-08-30 2:29 p.m., Liang, Kan wrote:
> >> The problem
> >> is how we encode terms of an event name, it is indistinguishable when
> >> the of the user field is 1. I'll probably add something to fix this
> >> later, but it only impacts debug output and perf list, so I'm not
> >> overly worried.
> > It should be OK for the debug output.
> >
>
> Not just the debug output. It also impacts the perf list --detail.
>
> With the patch,
> perf list --detail | grep uops_retired.heavy -A 2
>   uops_retired.heavy
>        [Retired uops except the last uop of each instruction. Unit:
> cpu_core]
>         cpu_core/event=3D0xc2,period=3D0x1e8483,umask/
>
> Without the patch,
> perf list --detail | grep uops_retired.heavy -A 2
>   uops_retired.heavy
>        [Retired uops except the last uop of each instruction. Unit:
> cpu_core]
>         cpu_core/event=3D0xc2,period=3D0x1e8483,umask=3D0x1/

Right, nobody uses --detail ;-) I'll write the fix.

Thanks,
Ian

> Thanks,
> Kan
>
>
>
