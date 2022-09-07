Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5808C54EE9
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Sep 2022 17:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiIGRvn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Sep 2022 13:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiIGRvk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Sep 2022 13:51:40 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3218C71726;
        Wed,  7 Sep 2022 10:51:39 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1279948d93dso18096307fac.10;
        Wed, 07 Sep 2022 10:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ATQFV9UxDijnVCKvjh8wgAiSEZcUIEydhgrlvOLLULw=;
        b=IPPnEI6ako2KxEoPezfb6EpSdHRThfPVTNFafi0v7VP7ENGEn3YOWHFxl9ZN2+aLDQ
         V5SvjdKhizUpk+OO8q/5VJfr/wHpwY1FAW1iNvtcWYjuukw9YL8mUeNdpbzAEWUmP4sI
         vuT8NfC28SzHexZnkl0iFSjku1jOiZ34tAiNWCVoypT/TVGKeS1Vf54cYLkpQdYV5MaI
         xnqK/vmiA+vE9FIyhGuXVHlD8IT6Lylx2CaNc8tivzJsnvjZsKCLgmL85AGF0p6nFcyo
         IYyEe7oFhG2A6Gars/09jz/WsDmr+nwxu93pBXr4LCE3JeK5N1NPU6KnQcB9kbZ7VQIj
         Tt5w==
X-Gm-Message-State: ACgBeo2QVgWNy2IfMhGrp6UCX5InuKsYTHYNhxzsLlmY5w5ULb45ogRb
        yuocNvtWRpyTS8KTMXNpUAO8V+j5XoRRXoaGrrY=
X-Google-Smtp-Source: AA6agR7bzc4ly6e0V8xYN8ae6VkT7YfN/xsK5oXoZN+zl19bnzwzuKJgxyngYxaWXTCJhq3nJThtKLHdjHN2YhNMpVI=
X-Received: by 2002:a05:6808:302a:b0:345:ec04:8f11 with SMTP id
 ay42-20020a056808302a00b00345ec048f11mr12709479oib.5.1662573098429; Wed, 07
 Sep 2022 10:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220907071203.2729746-1-namhyung@kernel.org> <CAP-5=fXyY_aGYW4R-PZvzG3FiTtHvLfS+s9bp_oCQUaRCGrcwg@mail.gmail.com>
In-Reply-To: <CAP-5=fXyY_aGYW4R-PZvzG3FiTtHvLfS+s9bp_oCQUaRCGrcwg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 7 Sep 2022 10:51:27 -0700
Message-ID: <CAM9d7chEOJJTX3F-5Nzy+BBpr5dBnayHDx9MOSmkC0axrttzJQ@mail.gmail.com>
Subject: Re: [PATCH v3] perf test: Skip sigtrap test on old kernels
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Marco Elver <elver@google.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian,

On Wed, Sep 7, 2022 at 8:48 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Sep 7, 2022 at 12:12 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > If it runs on an old kernel, perf_event_open would fail because of the
> > new fields sigtrap and sig_data.  Just skipping the test could miss an
> > actual bug in the kernel.
> >
> > Let's check BTF if it has the perf_event_attr.sigtrap field.
> >
> > Cc: Marco Elver <elver@google.com>
> > Acked-by: Song Liu <song@kernel.org>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > * move #include under #ifdef
> > * return true when BPF is not supported
> > * update comment
> >
> >  tools/perf/tests/sigtrap.c | 50 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 49 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/sigtrap.c b/tools/perf/tests/sigtrap.c
> > index e32ece90e164..cdf75eab6a8a 100644
> > --- a/tools/perf/tests/sigtrap.c
> > +++ b/tools/perf/tests/sigtrap.c
> > @@ -54,6 +54,48 @@ static struct perf_event_attr make_event_attr(void)
> >         return attr;
> >  }
> >
> > +#ifdef HAVE_BPF_SKEL
> > +#include <bpf/btf.h>
> > +
> > +static bool attr_has_sigtrap(void)
> > +{
> > +       bool ret = false;
> > +       struct btf *btf;
> > +       const struct btf_type *t;
> > +       const struct btf_member *m;
> > +       const char *name;
> > +       int i, id;
> > +
> > +       btf = btf__load_vmlinux_btf();
> > +       if (btf == NULL) {
> > +               /* should be an old kernel */
> > +               return false;
> > +       }
> > +
> > +       id = btf__find_by_name_kind(btf, "perf_event_attr", BTF_KIND_STRUCT);
> > +       if (id < 0)
> > +               goto out;
> > +
> > +       t = btf__type_by_id(btf, id);
> > +       for (i = 0, m = btf_members(t); i < btf_vlen(t); i++, m++) {
> > +               name = btf__name_by_offset(btf, m->name_off);
> > +               if (!strcmp(name, "sigtrap")) {
> > +                       ret = true;
> > +                       break;
> > +               }
> > +       }
> > +out:
> > +       btf__free(btf);
> > +       return ret;
> > +}
> > +#else  /* !HAVE_BPF_SKEL */
> > +static bool attr_has_sigtrap(void)
> > +{
> > +       /* to maintain current behavior */
>
> nit: I don't think this comment will age well and the behavior of the
> function is a bit counterintuitive. Perhaps:
>
> /* If we don't have libbpf then guess we're on a newer kernel with
> sigtrap support. This will mean the test will fail on older kernels.
> */

Thanks for the clarification, will update!

Namhyung
