Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625D5EB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 13 Jul 2023 03:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjGMDbs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Jul 2023 23:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjGMDbs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2023 23:31:48 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4CC1FF0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 20:31:46 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-403b622101bso108581cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 20:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689219106; x=1691811106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdLcrKgC6rNFN4OiDdifwDnpg2YdHPn+NMLq6CKi0ZQ=;
        b=mfr8QLm/+EdrKJkJ2zvJTZQxBi6TXCM/hPZJ5TS9i5KswTOhIogy8J6ZQhXDAYB+lX
         KP1d+ANZtRNfKgzTEj9PhfuOMRorCWkmcoksD+dnVhB3LuPzZHFpxviYvlSOiyl0qjWq
         4bj+TVln3PYSxbTOvkMmRiRhpGGEoNRkZqzDuenM3Qpgx4oAvIREq1LliGY80taROy3r
         aP+qugf6tB6/J6xNDfxCzXapY7ZlOyMKbMbFh1DcPHCulAzSmM9XDGeMe25OhDyp4Soc
         Xd20k3MxUgJEbJrKGm283rOc4rTy/u6h/cTPR6VjMNy3GsQQYWtXYvbqKEpRnxICqD2e
         lwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689219106; x=1691811106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdLcrKgC6rNFN4OiDdifwDnpg2YdHPn+NMLq6CKi0ZQ=;
        b=bs6MghoilxBe9b6hq37ijiTASSHVhDeH2oubR50L5bpYy7lHGnizmG+MjS+UpfrXcG
         9EHwXfd8bvmNEkoa3696Coo20tT0sCL6hkDhuagtgAOMgZciDfkVDbhaWNPWan6kOSR2
         0jB7ZfOUBEGnBWtk4Km36Tq0SktaXjTR41oSC1M+jYDSCSC99wmMBzMqS+zMBRCA1VkF
         nbcgc3lQge2u7nAXxEoWJ2z4jx5O+4ALOwCdDXtlc21lMsdxdsyGhNqiv8Gw1cFh9z/G
         cmbnx2W5ltVZkRcnq6Ysukv8ZzvheCSbHFe+YmHeiYvjfnRzDbKkb01R0GExYF8sUL6O
         mw2w==
X-Gm-Message-State: ABy/qLbfU1HgtVqCRZ+iK811zHuwQVSjqH6cxzjGdV1KOrmXgqFgBB8M
        1cpHM1Q5S8h90gYRqQNSNq/xs1gDrql9EWCtnS+GTQ==
X-Google-Smtp-Source: APBJJlFyVUVDswankhPrdICZLfP2btEq1ZhB1Yv1qzaxAx0tGn9/2eBxCMBKXhDAQSks8LWvaf3qijIpHTr5iUEkO7s=
X-Received: by 2002:ac8:59ce:0:b0:3f8:8c06:c53b with SMTP id
 f14-20020ac859ce000000b003f88c06c53bmr524431qtf.0.1689219105689; Wed, 12 Jul
 2023 20:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230712100626.221994-1-tmricht@linux.ibm.com>
In-Reply-To: <20230712100626.221994-1-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 20:31:33 -0700
Message-ID: <CAP-5=fXNLEFB0GVJwzMmpXyUKVDN74f8Np7FygSL9AnHYJ=aww@mail.gmail.com>
Subject: Re: [PATCH] perf build: Support llvm and clang support compiled in
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, wangnan0@huawei.com, jolsa@kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 12, 2023 at 3:07=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Perf build suports llvm and clang support compiled in.
> Test case 56 builtin clang support provides a test case
> which is always skipped.
>
> Link perf with the latest llvm and clang libraries and
> enable this test case.
>
> Use 'make LIBCLANGLLVM=3D1' to include this support.
>
> Output before:
>  # ./perf test 56
>  56: builtin clang support                  :
>  56.1: builtin clang compile C source to IR : Skip (not compiled in)
>  56.2: builtin clang compile C source to ELF object: \
>                                         Skip (not compiled in)
>
> Output after:
>  # ./perf test 56
>  56: builtin clang support                          :
>  56.1: builtin clang compile C source to IR         : Ok
>  56.2: builtin clang compile C source to ELF object : Ok
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Wang Nan <wangnan0@huawei.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Makefile.config | 2 +-
>  tools/perf/Makefile.perf   | 5 +----
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 0609c19caabd..a90af438261c 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -325,7 +325,7 @@ CORE_CFLAGS +=3D -Wall
>  CORE_CFLAGS +=3D -Wextra
>  CORE_CFLAGS +=3D -std=3Dgnu11
>
> -CXXFLAGS +=3D -std=3Dgnu++14 -fno-exceptions -fno-rtti
> +CXXFLAGS +=3D -std=3Dgnu++17 -fno-exceptions -fno-rtti
>  CXXFLAGS +=3D -Wall
>  CXXFLAGS +=3D -fno-omit-frame-pointer
>  CXXFLAGS +=3D -ggdb3
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 097316ef38e6..d417d3fea818 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -426,10 +426,7 @@ EXTLIBS :=3D $(call filter-out,$(EXCLUDE_EXTLIBS),$(=
EXTLIBS))
>  LIBS =3D -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whol=
e-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
>
>  ifeq ($(USE_CLANG), 1)
> -  CLANGLIBS_LIST =3D AST Basic CodeGen Driver Frontend Lex Tooling Edit =
Sema Analysis Parse Serialization
> -  CLANGLIBS_NOEXT_LIST =3D $(foreach l,$(CLANGLIBS_LIST),$(shell $(LLVM_=
CONFIG) --libdir)/libclang$(l))
> -  LIBCLANG =3D $(foreach l,$(CLANGLIBS_NOEXT_LIST),$(wildcard $(l).a $(l=
).so))
> -  LIBS +=3D -Wl,--start-group $(LIBCLANG) -Wl,--end-group
> +  LIBS +=3D -lclang-cpp

This failed for:
```
  LINK    /tmp/perf/perf
/usr/bin/ld: cannot find -lclang-cpp: No such file or directory
collect2: error: ld returned 1 exit status
```

but adding the library directory fixed it:
```
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -426,7 +426,7 @@ EXTLIBS :=3D $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXT=
LIBS))
LIBS =3D -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS)
-Wl,--no-whole-archive -Wl,--start-group $
(EXTLIBS) -Wl,--end-group

ifeq ($(USE_CLANG), 1)
-  LIBS +=3D -lclang-cpp
+  LIBS +=3D -L/usr/lib/llvm-15/lib -lclang-cpp
endif

ifeq ($(USE_LLVM), 1)
```

This is on a Debian installation:
```
$ dpkg -L libclang-cpp15
/.
/usr
/usr/lib
/usr/lib/llvm-15
/usr/lib/llvm-15/lib
/usr/lib/llvm-15/lib/libclang-cpp.so.15
/usr/lib/x86_64-linux-gnu
/usr/share
/usr/share/doc
/usr/share/doc/libclang-cpp15
/usr/share/doc/libclang-cpp15/NEWS.Debian.gz
/usr/share/doc/libclang-cpp15/changelog.Debian.gz
/usr/share/doc/libclang-cpp15/copyright
/usr/lib/x86_64-linux-gnu/libclang-cpp.so.15
```

Thanks,
Ian

>  endif
>
>  ifeq ($(USE_LLVM), 1)
> --
> 2.41.0
>
