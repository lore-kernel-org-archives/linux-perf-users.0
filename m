Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E37C77B6E
	for <linux-perf-users@archiver.kernel.org>; Fri, 14 Apr 2023 00:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjDNAff (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 13 Apr 2023 20:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDNAff (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Apr 2023 20:35:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5F9E4
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 17:35:32 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id rp27so4685439ejb.12
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Apr 2023 17:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681432531; x=1684024531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zlmFVugnU65/zhL8tn3LzJOUJcKg2eSx3ENwKcL4ng=;
        b=gSpdxnl39+MoOBmh+26J9R0lMYAURsxdgyLp6IcFKgZHWGFLePXZuNcPNu1jZj8Nl+
         X2263A4asvnIQyauWu5/Oxnt7NecfbB9oRMOXjAd7AhugNOUlvj8HVPCUCUdvSCaw2iL
         DHeqgk56Hew3oDfdC+SXMRMDBiMr1mE/zhCUOVk8xoiNN8KNjSArGJ41OhCc9aYXv3VA
         9t0rwSj6x49R0UEAklkONSBYl/4qfIGKph7R30mZ18VlU1Y+zDjYYWAFzH9l6ZBiO3Gn
         0i8D1bL487DMBzqJFvNWzApFkRvAl8GjyKVtFD6sip0bi2b35zhpacmudQ1/2VY89mWJ
         QRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681432531; x=1684024531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zlmFVugnU65/zhL8tn3LzJOUJcKg2eSx3ENwKcL4ng=;
        b=gltTqovgrZsAp1n5YeBgz2T1R4RminRB9h5QMfFe/blLbYdPfBSL5TSKKIFdhEyvHz
         MWyD5toen3jTCk5IkN8UjZ7dD29p6YPRXv692i4gYPq9LEwBK+zIDhFpNpKXusxO962X
         CHNYQbjLHktxnjc4c2998qVR0fFn5flP7RPHQc9DjDatxv/tn4gQYbOLKWV7Pl0xm+d1
         cjb6sRV99IBXA67ukV/VInJFRrE1+bBKlXajMyR40P7Pri8VvccP01xRANfBSMYgZTgR
         IDrKswxOw7MpE/QEC1DqY/fvFetOn/mFn8dp1WC/PDSAEr/6LC8SstPn+BJ4oYY6SlsU
         9Z7w==
X-Gm-Message-State: AAQBX9cgnirNDtpmNsXUWms5zbeDHB0nNWdCeINZZD3MsHYPBvCy2kCi
        HaHPEIZfufYofS86OXgpfn6IQ0PDu6DtUKAibHW3MA==
X-Google-Smtp-Source: AKy350Y3F1LS3wyEWzeS2FrvbcMwTarHydpWBl55Xl1+fnhr8PMjX34SeJnuFHiAmMm23yrJ49d2r8uWktJA0G0NAk8=
X-Received: by 2002:a17:906:80c:b0:92e:a234:110a with SMTP id
 e12-20020a170906080c00b0092ea234110amr2155080ejd.3.1681432531367; Thu, 13 Apr
 2023 17:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <ZDfKBPXDQxH8HeX9@syu-laptop>
In-Reply-To: <ZDfKBPXDQxH8HeX9@syu-laptop>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Fri, 14 Apr 2023 01:35:20 +0100
Message-ID: <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        Michal Suchanek <msuchanek@suse.de>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>,
        Mahe Tardy <mahe.tardy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Shung-Hsi,

On Thu, 13 Apr 2023 at 10:23, Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
>
> Hi,
>
> I'm considering switch to bpftool's mirror on GitHub for packaging (inste=
ad
> of using the source found in kernel), but realize that it should goes
> hand-in-hand with how libbpf is packaged, which eventually leads these
> questions:
>
>   What is the suggested approach for packaging bpftool and libbpf?
>   Which source is preferred, GitHub or kernel?

As you can see from the previous discussions, the suggested approach
would be to package from the GitHub mirror, with libbpf and bpftool in
sync.

My main argument for the mirror is that it keeps things simpler, and
there's no need to deal with the rest of the kernel sources for these
packages. Download from the mirrors, build, ship. But then I have
limited experience at packaging for distros, and I can understand
Toke's point of view, too. So ultimately, the call is yours.

>   Does bpftool work on older kernel?

It should, although it's not perfect. Most features from current
bpftool should work as expected on older kernels. However, if I
remember correctly you would have trouble loading programs on pre-BTF
kernels, because bpftool relies on libbpf >=3D 1.0 and only accepts map
definitions with BTF info, and attempts to create these maps with BTF,
which fails and blocks the load process.

But we're trying to keep backward-compatibility, so if we're only
talking of kernels recent enough to support BTF, then I'd expect
bpftool to work. If this is not the case, please report on this list.

>
> Our current approach is that we (openSUSE/SLES) essentially have two vers=
ion
> of libbpf: a public shared library that uses GitHub mirror as source, whi=
ch
> the general userspace sees and links to; and a private static library bui=
lt
> from kernel source used by bpftool, perf, resolve_btfids, selftests, etc.
> A survey of other distros (Arch, Debian, Fedora, Ubuntu) suggest that the=
y
> took similar approach.

I would like them to reconsider this choice eventually. Sounds like
for RHEL, this will be a tough sell :). At least, I'd love Ubuntu to
have a real bpftool package instead of having to install
linux-tools-common + linux-tools-generic, or to have distros in
general (Ubuntu/Debian at least) stop compiling out the JIT
disassembler, although this is not strictly related to the location of
the sources. I've not found the time to reach out to package
maintainers yet.

>
> This approach means that the version of bpftool and libbpf are _not_ alwa=
ys
> in sync[1], which I read may causes problem since libbpf and bpftool depe=
nds
> on specific version of each other[2].

Whatever source you use, I would strongly recommend finding a way to
keep both in sync. Libbpf has stabilised its API when reaching 1.0,
but bpftool taps into some of the internals of the library. Features
or new definitions are usually added at the same time to libbpf and
bpftool, and if you get a mismatch between the two, you're taking
risks to get build issues.

>
> Using the GitHub mirror of bpftool to package both libbpf and bpftool wou=
ld
> kept their version in sync, and was suggested[3]. Although the same could=
 be
> said if we switch back to packaging libbpf from kernel source, an additio=
nal
> appeal for using GitHub mirrors is that it decouples bpftool from kernel,
> making it easily upgradable and with a clearer changelog (the latter is
> quite important for enterprise users) like libbpf.

Happy to read these changelogs I write are useful to someone :). Yes,
this is my point.

>
> The main concern with using GitHub mirror is that bpftool may be updated =
far
> beyond the version that comes with the runtime kernel. AFAIK bpftool shou=
ld
> work on older kernel since CO-RE is used for built-in BPF iterators and t=
he
> underlying libbpf work on older kernel itself. Nonetheless, it would be n=
ice
> to get a confirmation from the maintainers.

As explained above - Mostly, it should work. Otherwise, we can look
into fixing it.

As a side note, I'm open to suggestions/contributions to make life
easier for packaging for the mirror. For example, Mah=C3=A9 and I recently
added GitHub workflows to ship statically-built binaries for amd64 and
arm64 on releases, as well as tarballs with both bpftool+libbpf
sources. If there's something else to make packaging easier, I'm happy
to talk about it.

>
> Are there any other downsides to switching to GitHub mirror for bpftool?

Nothing else comes to mind, but again I'm not packaging for distros.
See Toke's message.

I hope this helps,
Quentin
