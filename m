Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A00C4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Dec 2022 01:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiLWBoK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Dec 2022 20:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLWBoJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Dec 2022 20:44:09 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F7F2316C
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Dec 2022 17:44:08 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id a66so3353300vsa.6
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Dec 2022 17:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3pFpFEIgC/4IC5P+Ef9teMy5p6cTCuUcox13/wsQYC4=;
        b=Ob5QkdQBgkvxno5kOdrH+pvsfq9E74IxZVy56D6UCkwiSvtY9bF6mqWkCMqm1EwYUp
         qlk+ZYDEH3RwUvOr5leLagZBUkNpU7DTl1Iqxr0Gmu1O8Pf3IvCnWOkyOwMdm9LKE9O5
         EQcVfbjUt8Fvj1tjGSRwWKSUDfWmeESTvWlD4XjBoqOG/7+TC57p1uEl4glLVBMppg05
         6vCtho47QGLtEQStO2SyHIhH1JjpX3DWMPo5aNZt/IpwaeguU9U8A6Y7SSNl/d0FUUim
         u/tNeLb7lG151p/IW8N4JNsVhLQYKjYOo3sv2T7VKDU5mx+o6ISUOgm6jkC4V2vJHu9h
         PQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pFpFEIgC/4IC5P+Ef9teMy5p6cTCuUcox13/wsQYC4=;
        b=x9DcBVuc6EFhUamlbto3ligyuuqWaS+lp+HhWTyADX/nuSXxxhLdR2ZsAc/mKZCmRO
         M33h9iuJQzPib7lAjYnJfAocKKgUgKfx2/CqMxt1bWe96GQ2leXffSY/W2Z0w42nNvQC
         2bxpR+l9meh7qrA7TCppi54SR4Ma1CC556jWTgKEruHxwzUjv6/U8+hCN3tGo/+Zj8ny
         sET4+n1pErM8g65ciTKd0WNzKMfp3AMBndBryQ2+616kyG5ACl0H4zNnmShPv8NiscVq
         Tlzy0xMKnG6jjoyX2t5z+jKuJO+tXs7OzW9jTrdlD0IUuJafY6ki7tzHlqUlXlgbaNd1
         OKYQ==
X-Gm-Message-State: AFqh2kp5CMMo4QzSa1P/WNeAbwez4BfhEekiA6C4Tt4GNK9PEf9fN+Ar
        ye9Z/Vp+VOqZ7XxjmKIA9htmyGH72dP0QagHmBRYKw==
X-Google-Smtp-Source: AMrXdXtBimHkucACeEf/XWeBaGpjfACaXJ5R4wcw7T3RKHQMTGeaiYL3M6kJn3T0HmvQyp9enrybQp/1tCRq2sx4PoA=
X-Received: by 2002:a05:6102:2929:b0:3b0:7e4d:ab4a with SMTP id
 cz41-20020a056102292900b003b07e4dab4amr1041844vsb.36.1671759847428; Thu, 22
 Dec 2022 17:44:07 -0800 (PST)
MIME-Version: 1.0
References: <CAP-5=fW7La9ZNv8Z6LHRRNXne4+dWK6dR1ye2P=zETFELtK=fg@mail.gmail.com>
 <YY58idSor+lJ84KF@kernel.org> <CAP-5=fUczsXmo4xk2Yi=H6zUhmpixFaz9An=ixKotx=z0GOp0w@mail.gmail.com>
 <f59da80e6b4d053246fec4ef263ae4ca7aa1277f.camel@decadent.org.uk> <Ydx+mtl1c7L/bbGJ@kernel.org>
In-Reply-To: <Ydx+mtl1c7L/bbGJ@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Dec 2022 17:43:56 -0800
Message-ID: <CAP-5=fUzHV765DqcTZpqCKC1Ve1H91tUfoxQE7Z2KcK5yq021A@mail.gmail.com>
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

So I wanted to say a BIG thanks to Ben as I see in the 5.16 changelog
that the perf wrapper script for Debian is now gone!
https://metadata.ftp-master.debian.org/changelogs//main/l/linux/linux_6.1~rc8-1~exp1_changelog

```
linux (5.16.3-1~exp1) experimental; urgency=medium
...
  * linux-perf: Build a single unversioned package of perf, as it is no
    longer necessary to match the kernel version
```

I notice from trying the experimental version the features are:
```
perf version 6.1.0-rc8
                dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
   dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
        syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
               libbfd: [ OFF ]  # HAVE_LIBBFD_SUPPORT
           debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
               libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
              libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
              libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
            libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
             libslang: [ on  ]  # HAVE_SLANG_SUPPORT
            libcrypto: [ OFF ]  # HAVE_LIBCRYPTO_SUPPORT
            libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
   libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                 zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                 lzma: [ on  ]  # HAVE_LZMA_SUPPORT
            get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                  bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                  aio: [ on  ]  # HAVE_AIO_SUPPORT
                 zstd: [ OFF ]  # HAVE_ZSTD_SUPPORT
              libpfm4: [ OFF ]  # HAVE_LIBPFM
```
I believe this is a step up as previously libpython was disabled.

I had a few things to ask wrt this thread and getting the best
possible Debian experience:
 - in Linux 6.2 the libtraceevent will need to become an external
library dependency

 - are there issues with debuginfod/zstd enablement? libbfd has
licensing issues. libcrypto is only used by the JIT support, but still
may be nice to enable.

- wrt packaging, the kernel has a deb-pkg build target, should we move
the debian packaging to something like a perf-deb-pkg similar to the
perf-tar-src-pkg target? This thread was previously proposing using
the source releases Arnaldo makes, this would be possible for a
deb-pkg target if the logic were contained in the source tar ball. I
believe what is currently being built is from a kernel tree, but
perhaps a build target adds consistency with the kernel, allows
contributors to update the Debian related files and serves as an
example for similar packaging of other kernel tools, like bpftool.

 - are there some residual wrapper artifacts in the package, for example:
```
$ dpkg -L linux-perf
/.
/usr
/usr/bin
/usr/bin/perf
package diverts others to: /usr/bin/perf.wrapper
...
package diverts others to: /usr/share/bash-completion/completions/perf.wrapper
...
package diverts others to: /usr/share/man/man1/perf.wrapper.1.gz
...
```

Another BIG thank you to Ben!

Ian
