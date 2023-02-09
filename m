Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9748CC05027
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Feb 2023 07:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjBIHMu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Feb 2023 02:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBIHMr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Feb 2023 02:12:47 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E9A41B61
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Feb 2023 23:12:46 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id j1so1327895pjd.0
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Feb 2023 23:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4WVs22Kg7Btgcs7NcU/V4V2lSD7tkAUiSfve9Y1LNwY=;
        b=AoYrrJJs6k9GtmQ4jMGk0yXnsurRdiogv4N9KaUtAvk7czZiKUvynb//Bfa2EC5y3x
         bThSbc2PuWdlSa6zqhkSM3mNpiJHJPK8QHZP0bb0ANnmBRq9y6M6tosCkqa0HtjZEr7m
         pdZWvIjuSCgtmifIjb6P+QJwoD6nwQX/OA31bMpYqq3qigQS8QSqGSlSiq47cdl+XVQx
         2JCuvOxpC3CK/kIQhAqtz+Zi7zTcsXfsqIKsjnrCzTvJoB5FP4M6IVUUoVQ4vN1tGuCr
         X41zK9YDiG7cBtw8BW3R1Jb/SbukYgAhUI7qDCI7mUA4yRA0v5Gq7Ipcnhb/YmqWIm3T
         qicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WVs22Kg7Btgcs7NcU/V4V2lSD7tkAUiSfve9Y1LNwY=;
        b=ISJX0f6OdzHt50WGkrCwS72VuaJKUFe7nPbs/mD8PrNpEAjbw+SuJguv1dtz69C02h
         zExJsRS6mcyIf7AEdArn3kGQJ/dF0TUJ8wOXPSG7SP3XhHcxDOqeSg6vCbN08T98ht8t
         TRiVRBkUfzqXy5HnuEkCryhtG64+qj0fet0BZkajkYfUZ1hDzJ+IDVsWYEF+WAxH2ac3
         BtELAhxHWJAPYoVPu7RK2HHOB15k++ckcmIAk9YRhb+bjHj7MTaGaExL2UBR2cakhqop
         snARTkpF/Wp9M908Z3c69nP0LQhdXGTO3i/ccNBfjYPfYIAxWpr1Xx5KGpVQR7vzAJSD
         veYQ==
X-Gm-Message-State: AO0yUKW4DOU1hSberF1FMFX5gWQzqjJt/fNwKpPgR3NcxYKa+4iVEV8i
        iACNoQzyCVBiobmJ9rmvAS7fVehGo4hAqNQBsihfPQ==
X-Google-Smtp-Source: AK7set/JAGjMaYyKUc3wik1Zpc3z1fF27fTbmID4hmKb+mM1VoQt/VnzqKCHgPPcXP/4CDxya8Ss+VkiNAm6JDV2cqw=
X-Received: by 2002:a17:902:b78a:b0:199:26df:77b6 with SMTP id
 e10-20020a170902b78a00b0019926df77b6mr2518442pls.3.1675926766145; Wed, 08 Feb
 2023 23:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20230201135737.800527-1-jolsa@kernel.org> <Y9vSZhBBCbshI3eM@casper.infradead.org>
 <Y9vX49CtDzyg3B/8@krava>
In-Reply-To: <Y9vX49CtDzyg3B/8@krava>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 8 Feb 2023 23:12:34 -0800
Message-ID: <CA+khW7juLEcrTOd7iKG3C_WY8L265XKNo0iLzV1fE=o-cyeHcQ@mail.gmail.com>
Subject: Re: [RFC 0/5] mm/bpf/perf: Store build id in file object
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Feb 2, 2023 at 7:33 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Feb 02, 2023 at 03:10:30PM +0000, Matthew Wilcox wrote:
> > On Wed, Feb 01, 2023 at 02:57:32PM +0100, Jiri Olsa wrote:
> > > hi,
> > > we have a use cases for bpf programs to use binary file's build id.
> >
> > What is your use case?  Is it some hobbyist thing or is it something
> > that distro kernels are all going to enable?
> >
>
> our use case is for hubble/tetragon [1] and we are asked to report
> buildid of executed binary.. but the monitoring process is running
> in its own pod and can't access the the binaries outside of it, so
> we need to be able to read it in kernel
>
> I understand Hao Luo has also use case for that [2]
>

Sorry for the late reply.

We use BPF to profile stacktraces and build id is more useful than
instruction addresses. However, sometimes we need to record
stacktraces from an atomic context. In that case, if the page that
contains the build id string is not in the page cache, we would fail
to get build id. Storing the build id in file object solves this
problem and helps us get build id more reliably.

> jirka
>
>
> [1] https://github.com/cilium/tetragon/
> [2] https://lore.kernel.org/bpf/CA+khW7gAYHmoUkq0UqTiZjdOqARLG256USj3uFwi6z_FyZf31w@mail.gmail.com/
