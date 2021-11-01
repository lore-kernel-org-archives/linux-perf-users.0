Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED77EC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  1 Nov 2021 21:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDDEA60ED3
	for <linux-perf-users@archiver.kernel.org>; Mon,  1 Nov 2021 21:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhKAVNI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 1 Nov 2021 17:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhKAVNI (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 1 Nov 2021 17:13:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3942360E78;
        Mon,  1 Nov 2021 21:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635801034;
        bh=P1NF/lFoNB/+jYgMl0xZfzYLEkGo904XzG49NcwbE1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AR7HVZSbGbIz/+8iQw0hdxmN2wiYCpEADAa5l7GbWBhSS8B0SIMkbxkGe+VBLeoXw
         GUKwNIRlVhaYo+03ZD976mgb8d6cO+8ErNsxyn59xzQm18H7J7t8hbNzN98KKQwJT8
         PPXvAv7IuA8mI+8HH4fnX2ds6BDScmbdLlfPacm9mrCcsAAyJS10dIyUqrCNrjisGx
         tBRPl77/gFFSWYwkGchDhdKoD1TF07yW3bG3gWC0o03BsCt47zfeGty7KH0nkvrCvJ
         Uxi+rfHDPhFxaMTsU+aOCbRSQvMgODjQKPFMH8hWYyMLnxDDbTtboEa455hSDrgW2R
         8Vw/xGfxwNkJw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 50DA8410A1; Mon,  1 Nov 2021 18:10:32 -0300 (-03)
Date:   Mon, 1 Nov 2021 18:10:32 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, masahiroy@kernel.org, labbott@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com
Subject: Re: [PATCH] perf tools: Enable warnings through HOSTCFLAGS
Message-ID: <YYBXyGKfM2CAjghy@kernel.org>
References: <1635525041-151876-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635525041-151876-1-git-send-email-john.garry@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Oct 30, 2021 at 12:30:41AM +0800, John Garry escreveu:
> The tools build system uses KBUILD_HOSTCFLAGS symbol for obvious purposes.
> 
> However this is not set for anything under tools/
> 
> As such, host tools apps built have no compiler warnings enabled.
> 
> Declare HOSTCFLAGS for perf tools build, and also use that symbol in
> declaration of host_c_flags. HOSTCFLAGS comes from EXTRA_WARNINGS, which
> is independent of target platform/arch warning flags.
> 
> Suggested-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: John Garry <john.garry@huawei.com>

Jiri, does this implements your suggestion?

- Arnaldo

> --
> Using HOSTCFLAGS, as opposed to KBUILD_HOSTCFLAGS, is going opposite
> direction to commit 96f14fe738b6 ("kbuild: Rename HOSTCFLAGS to
> KBUILD_HOSTCFLAGS"), so would like further opinion from Laura and
> Masahiro.
> 
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
> index 4a9baed28f2e..9b95ba09657f 100644
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
> index a3966f290297..8ca656aa8b06 100644
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
> -- 
> 2.17.1

-- 

- Arnaldo
