Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFF8C5479D
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Jan 2023 01:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjAJBc1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Jan 2023 20:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjAJBc1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Jan 2023 20:32:27 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F66395E3
        for <linux-perf-users@vger.kernel.org>; Mon,  9 Jan 2023 17:32:26 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id w1so10206545wrt.8
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Jan 2023 17:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p/irkPyPqsOvnRRDM/kAEyni1c1VXZytg7cWRDKGSqY=;
        b=lJ683lm9xtHxsYycpHd/y8kUD9K9bvznIJrKSlAkJoki6kr/lQfzbqA6bd3AqtErEj
         RLMCmtzqqa3ob2Nqlqr+6xL8XP+n+kx6Bg3tPCtIVeXLdAhgzcYjI6IsWJAiPtC5Jwkb
         eob6DrvEcYG7JKyfIGgEoAKgtROudlHeyMyU3hzbfxgrV1uIeTH+BlWMRK7f4KJ8WxJN
         H4w642SP7xqLSk25B4Xf2J9PfGfQavJeMnQ94G6AaMx1ehJsw+2TtZLaerrvclqqPw6V
         +OylBY8sUtRuEQSZJ3QlTxGYt9ewQ9rc8VGqvN57NGQVJJkucyyuO11SyC7JkUsUJMuZ
         a/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p/irkPyPqsOvnRRDM/kAEyni1c1VXZytg7cWRDKGSqY=;
        b=CeF6fJNgBr/P1Clg101TCypBmuJ4X1DVGhtWJGmJcjXJcKaXvv6f0tJjfy6StE6p5F
         r2fjH2S4JpHGMW8HY9ycFtsp4x0RDDZyj8K39dthqdnEb7UNwy34uXSM3mTergIa0IMy
         c0BG6Ox3HRPuRlHKcj7dyROtSgm+Efd3D4EFNcxSUfLREGdN55rAt5WzSkgkC3Fouy/B
         TIIC9qcH4uL8FAzzjhR6373WOxzGkSMXfPsLcO6dRzYzlLWcjv4Y4PtI1zVubmXNZTWJ
         fmjEoSodi1Xmy/JN8KVgAHZsB90Xd9xyeJ88Pycwm96Ia0IOpIgfPqyU4ACA18d+ugH0
         SzLg==
X-Gm-Message-State: AFqh2kqoC6x+ixZw9fQW7bjA3p22ZRK6Ip5gayfMjhZ0u/TZ/E33jRIV
        39qsbSSTqzyYZvXig5TwTAWH9ESH8Kg8EcRuBBfn6A==
X-Google-Smtp-Source: AMrXdXtvO3AMysChhPx+ZQJ9Yjf0H0UD94h+OTnvKo9Ty8ArSjFmCoZpj0fSjhKqYvreY7y/J3R7l7QGxxyWY484yt4=
X-Received: by 2002:a5d:45d0:0:b0:29c:52c7:3dce with SMTP id
 b16-20020a5d45d0000000b0029c52c73dcemr809166wrs.375.1673314344418; Mon, 09
 Jan 2023 17:32:24 -0800 (PST)
MIME-Version: 1.0
References: <CAP-5=fW7La9ZNv8Z6LHRRNXne4+dWK6dR1ye2P=zETFELtK=fg@mail.gmail.com>
 <YY58idSor+lJ84KF@kernel.org> <CAP-5=fUczsXmo4xk2Yi=H6zUhmpixFaz9An=ixKotx=z0GOp0w@mail.gmail.com>
 <f59da80e6b4d053246fec4ef263ae4ca7aa1277f.camel@decadent.org.uk>
 <Ydx+mtl1c7L/bbGJ@kernel.org> <CAP-5=fUzHV765DqcTZpqCKC1Ve1H91tUfoxQE7Z2KcK5yq021A@mail.gmail.com>
 <62af20e156e799350b0281b7769442c4f1d414a3.camel@decadent.org.uk>
In-Reply-To: <62af20e156e799350b0281b7769442c4f1d414a3.camel@decadent.org.uk>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 9 Jan 2023 17:32:11 -0800
Message-ID: <CAP-5=fUcc-SmxqgNCnqNAc=adGdzK31eQtv8XKQLt8v4EtLguQ@mail.gmail.com>
Subject: Re: Getting the latest and greatest Linux perf features on every
 Debian kernel
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     debian-kernel@lists.debian.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        waldi@debian.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Dec 26, 2022 at 11:15 AM Ben Hutchings <ben@decadent.org.uk> wrote:
>
> On Thu, 2022-12-22 at 17:43 -0800, Ian Rogers wrote:
> [...]
> > I had a few things to ask wrt this thread and getting the best
> > possible Debian experience:
> >  - in Linux 6.2 the libtraceevent will need to become an external
> > library dependency
>
> This shouldn't be a problem; it's already packaged separately in Debian
> and we can build-depend on that.
>
> >  - are there issues with debuginfod/zstd enablement? libbfd has
> > licensing issues. libcrypto is only used by the JIT support, but still
> > may be nice to enable.
>
> - debuginfod is licensed under GPLv3+, so has the same issue as libbfd
> - libzstd is licensed under GPLv2 (with most of its code also
> permissively licensed)
> - libcrypto is now licensed under Apache 2.0, which is not compatible
> with GPLv2
>
> So I think only libzstd can be enabled in official packages.
>
> [...]
> >  - are there some residual wrapper artifacts in the package, for example:
> > ```
> > $ dpkg -L linux-perf
> > /.
> > /usr
> > /usr/bin
> > /usr/bin/perf
> > package diverts others to: /usr/bin/perf.wrapper
> > ...
> > package diverts others to: /usr/share/bash-completion/completions/perf.wrapper
> > ...
> > package diverts others to: /usr/share/man/man1/perf.wrapper.1.gz
> > ...
> > ```
> [...]
>
> These diversions are present to avoid conflicts with the wrappers in
> older versions of linux-base.  We can remove them after the next stable
> release.
>
> Ben.

Thanks again Ben! With the releases, the plan is to follow the kernel
releases? We could potentially be more aggressive with the perf tool
given its backward compatibility. That would benefit people using
older kernels who want the latest perf tool bug fixes and features.

Ian

> --
> Ben Hutchings
> Klipstein's 4th Law of Prototyping and Production:
>                                A fail-safe circuit will destroy others.
