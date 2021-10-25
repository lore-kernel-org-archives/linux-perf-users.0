Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCB1C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 16:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35CF060EFF
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Oct 2021 16:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbhJYQX0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Oct 2021 12:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232362AbhJYQX0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Oct 2021 12:23:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B513D60E73;
        Mon, 25 Oct 2021 16:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635178863;
        bh=X4ETBzqUq9GQhIVyEU4rY4PDblTlGSrm/7xeH0+9BHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCrnS8vGSY+m24/jpzaK1SNgmJ1dhKMGmMgiH6VzzyVjGnfk2oLhAkZopibBnyu4E
         Nja6Y5RrGxVlH5QkIUY0llnKnlr3tilEXm4BIr734ji1vDYUniwKzkV88FWQrVkc7g
         OnqgaHm1Le9kWweUkUf9bi0+oqT2ojgC9hugAUDJnb2aBvTQbbK2/yJDuajUPEvyfx
         ezloaPkrlsiT+BKsXeW+NMIEIIQ9Re/8vGmr9EQOwzcwyFqx3X/JDp77TenY/uh3ax
         ClKo2/O0Y/6skQn2w9Jqr6vqjr0I+qDQNaB+uobg4OJ9SfkVEpn4UywtdXpNZf52jd
         kS15acixFmKwA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D274B410A1; Mon, 25 Oct 2021 13:20:59 -0300 (-03)
Date:   Mon, 25 Oct 2021 13:20:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, mingo@redhat.com, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjain@linux.ibm.com, james.clark@arm.com
Subject: Re: [PATCH v2 2/2] perf jevents: Enable warnings through HOSTCFLAGS
Message-ID: <YXbZa8SaQta9pzHS@kernel.org>
References: <1634807805-40093-1-git-send-email-john.garry@huawei.com>
 <1634807805-40093-3-git-send-email-john.garry@huawei.com>
 <YXFhr2YoVp9GPsDM@krava>
 <86aee893-0b6b-bce3-d1aa-3b66365592d1@huawei.com>
 <YXaXvGgvs4gr8Cgi@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXaXvGgvs4gr8Cgi@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Oct 25, 2021 at 01:40:44PM +0200, Jiri Olsa escreveu:
> On Fri, Oct 22, 2021 at 10:42:11AM +0100, John Garry wrote:
> > On 21/10/2021 13:48, Jiri Olsa wrote:
> > > > +HOSTCFLAGS += -Wall
> > > > +HOSTCFLAGS += -Wextra
> > > > +
> > > >   # Enforce a non-executable stack, as we may regress (again) in the future by
> > > >   # adding assembler files missing the .GNU-stack linker note.
> > > >   LDFLAGS += -Wl,-z,noexecstack
> > > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > > index 7df13e74450c..118bcdc70bb4 100644
> > > > --- a/tools/perf/Makefile.perf
> > > > +++ b/tools/perf/Makefile.perf
> > > > @@ -226,7 +226,7 @@ else
> > > >   endif
> > > >   export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
> > > > -export HOSTCC HOSTLD HOSTAR
> > > > +export HOSTCC HOSTLD HOSTAR HOSTCFLAGS
> > > >   include $(srctree)/tools/build/Makefile.include
> > > > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> > > > index a055dee6a46a..d5c287f069a2 100644
> > > > --- a/tools/perf/pmu-events/Build
> > > > +++ b/tools/perf/pmu-events/Build
> > > > @@ -1,7 +1,7 @@
> > > >   hostprogs := jevents
> > > >   jevents-y	+= json.o jsmn.o jevents.o
> > > > -HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include
> > > > +HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include $(HOSTCFLAGS)
> > > so the the host cflags are made of:
> > > 
> > > host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(KBUILD_HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
> > > 
> > 
> > ok, so IIRC, then the rule for building .o from .c in
> > tools/build/Makefile.build will pick up HOSTCFLAGS through this variable, so
> > we then don't need to explicitly mention it in the per-target rule, so can
> > have this as before in pmu-events/Build
> > 
> > HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include
> > 
> > right?
> > 
> > (Indeed I guess that we can get rid of -I$(srctree)/tools/include as well)
> 
> hm, the -I.. should stay no? I don't see that
> it's being added soem other way
> 
> jirka
> 

Probably this change from KBUILD_HOSTCFLAGS back to HOSTCFLAGS should
come with this;

Cc: Laura Abbott <labbott@redhat.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Fixes: 96f14fe738b69dd9 ("kbuild: Rename HOSTCFLAGS to KBUILD_HOSTCFLAGS")

Right?

- Arnaldo
 
> ---
> diff --git a/tools/build/Build.include b/tools/build/Build.include
> index 2cf3b1bde86e..c2a95ab47379 100644
> --- a/tools/build/Build.include
> +++ b/tools/build/Build.include
> @@ -99,7 +99,7 @@ cxx_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CXXFLAGS) -D"BUILD_STR(s)=\#s" $(CXX
>  ###
>  ## HOSTCC C flags
>  
> -host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(KBUILD_HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
> +host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
>  
>  # output directory for tests below
>  TMPOUT = .tmp_$$$$
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 0ae2e3d8b832..374f65b52157 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -17,6 +17,7 @@ detected     = $(shell echo "$(1)=y"       >> $(OUTPUT).config-detected)
>  detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
>  
>  CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
> +HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
>  
>  include $(srctree)/tools/scripts/Makefile.arch
>  
> @@ -211,6 +212,7 @@ endif
>  ifneq ($(WERROR),0)
>    CORE_CFLAGS += -Werror
>    CXXFLAGS += -Werror
> +  HOSTCFLAGS += -Werror
>  endif
>  
>  ifndef DEBUG
> @@ -292,6 +294,9 @@ CXXFLAGS += -ggdb3
>  CXXFLAGS += -funwind-tables
>  CXXFLAGS += -Wno-strict-aliasing
>  
> +HOSTCFLAGS += -Wall
> +HOSTCFLAGS += -Wextra
> +
>  # Enforce a non-executable stack, as we may regress (again) in the future by
>  # adding assembler files missing the .GNU-stack linker note.
>  LDFLAGS += -Wl,-z,noexecstack
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 7df13e74450c..118bcdc70bb4 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -226,7 +226,7 @@ else
>  endif
>  
>  export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
> -export HOSTCC HOSTLD HOSTAR
> +export HOSTCC HOSTLD HOSTAR HOSTCFLAGS
>  
>  include $(srctree)/tools/build/Makefile.include
>  

-- 

- Arnaldo
