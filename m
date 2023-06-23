Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D60EEB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 15:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjFWPBO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 11:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjFWPBN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 11:01:13 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9571E7E
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 08:01:11 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4007b5bafceso212851cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687532471; x=1690124471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ysjtw7MftghqiOOZ9k8ZcsNuaQW46BHux5Pd6NiW1k=;
        b=xAgNy8DSAzSx6kGscqr7Jm6rTsYhhHZMh9z2IJPplEPogVnL6DUQU+YKo7/riS93hl
         oynjyZYf3aKltl4i3CzOoWSWIDKOCuLg7GOI25w1McU05fbNzXpqnj0Z2XPNzmRzS/V7
         rOl0nseQs9kt8b1ru6oVdIMIEG61t19AKnTxnUP3pWZo39JCIOeYiehSuZ0UgiS+xYW1
         Vs+JLwxa1pw8p5rGz7aba0sbhryIATB75fdBcU0M1ZAO+wWS6Oeynlr4YOe+HhC6dxLM
         jCe0VJWN/XLnRnnP8RPQeut5gE22z+WSPiBSmIheUK9AbeXBDj9RrmtuqCmDvIxRf2HX
         GPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687532471; x=1690124471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ysjtw7MftghqiOOZ9k8ZcsNuaQW46BHux5Pd6NiW1k=;
        b=BRMqqET2dEzxfsbdVGOw+NKJ+KWuHkF1wV3iiVTxMqls9EnNdbnk5fDEoTvSNnBJL7
         kEEBCTBIwvu7JOKCqkT4ySy5DkbcpM7xT5nT9hkLSfTDbq/cnDOOfH+lHHbAvTUVVXpQ
         RKE+kftKhZkI0bI46wxctuygQ8xOs2EL9FNuZ7aLmyYBNCMnjn/Y3tLt7YrLY/nWjY+n
         DmluGg31yRFYJNOAtdpVf2mNAD84WXXXAx5T0lVDqs9qLF9xuNBnw/0XYnkQ7Lgz8rjH
         pt4KpQnJT3kqns49h1BZ6AtV+9+HNRRhRsu/bKe3iufMqBLoVuifWuxPyigQdsbXa2Nr
         Ilkg==
X-Gm-Message-State: AC+VfDytOgHW9GH9DtLDbBU3ZsLad7jOQ4UiTQGtCndMVY2MWta4fykn
        ykrRaOxE7QYqrBIkJ1tWPNUwONeoCBCN65a33ZJsUFvsGM+BiawDS1k=
X-Google-Smtp-Source: ACHHUZ5oNiq6MkiW0Rl1r1XcCFROf+szbbc99jKyOqbagb1QMKpBUyV4FLsB3oslDtd7KglqzJS8fxgWo+T2ItgapHE=
X-Received: by 2002:a05:622a:40c:b0:3f9:a73b:57bb with SMTP id
 n12-20020a05622a040c00b003f9a73b57bbmr167426qtx.4.1687532470729; Fri, 23 Jun
 2023 08:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230623003312.3981075-1-irogers@google.com> <20230623003312.3981075-2-irogers@google.com>
 <3c5aac54-a986-c163-a048-77e364725f3c@oracle.com>
In-Reply-To: <3c5aac54-a986-c163-a048-77e364725f3c@oracle.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 23 Jun 2023 08:00:59 -0700
Message-ID: <CAP-5=fWEgiF0Gg9B3UqyDDvcSR6z=xJUoX7ZiBWeV6+qd+AtfA@mail.gmail.com>
Subject: Re: [PATCH v1 01/12] perf expr: Add has_event function
To:     John Garry <john.g.garry@oracle.com>
Cc:     eter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 23, 2023 at 7:40=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 23/06/2023 01:33, Ian Rogers wrote:
> > +     if (!compute_ids)
> > +             return 0.0;
> > +
> > +     tmp =3D evlist__new();
>
> tmp may be NULL, and parse_event() is not NULL safe, so I assume that we
> need to handle tmp =3D=3D NULL

I'm not sure there's much sensible we can do with this, so I'll turn
it into a NAN for v2 - the normal error case.

Thanks,
Ian

> > +     ret =3D parse_event(tmp, id) ? 0 : 1;
> > +     evlist__delete(tmp);
> > +     return ret;
>
