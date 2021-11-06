Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CBCC433EF
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 19:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58EB4610E9
	for <linux-perf-users@archiver.kernel.org>; Sat,  6 Nov 2021 19:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbhKFTaa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 6 Nov 2021 15:30:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232626AbhKFTa3 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 6 Nov 2021 15:30:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F06E761051;
        Sat,  6 Nov 2021 19:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636226868;
        bh=xHbbKopAcL+R4RbxmrJnPw4G1mPEiz0DA4CRQStuUXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S8vVadJnlRaB2/11cvIr3Vq8S6vx4LmgODuJo0nLPkyDGzUu+JyHyzTlrLsSLkC00
         I8VTOr6rSml6sxip3DI+NNyr7wV4szmP4vTfCpLU8pY7ZugotN+Kd8chVZHqfvOn+5
         GL2HRCPJq3CGrHCXeOUIvVH0p3YHf5lzqkqQIT0In94FwsC53ThAfHz/Qm92jwzPiD
         l8KdA590CPVang5r4OaYRpx2Sqd0XHTXODfPwX03/jaHe13TSFXXlcMF5tQXpfydMu
         aY+WTeZvILFLdHn6rsDDzuSQl640v0l9wH3C43K6UmC9ttCxEevnR2rTr5+HYYrfXd
         FuvwpiJEmdhYg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 96D47410A1; Sat,  6 Nov 2021 16:27:45 -0300 (-03)
Date:   Sat, 6 Nov 2021 16:27:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, masahiroy@kernel.org,
        Laura Abbott <labbott@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com
Subject: Re: [PATCH] perf tools: Enable warnings through HOSTCFLAGS
Message-ID: <YYbXMd3N4+aXYLTJ@kernel.org>
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
> --
> Using HOSTCFLAGS, as opposed to KBUILD_HOSTCFLAGS, is going opposite
> direction to commit 96f14fe738b6 ("kbuild: Rename HOSTCFLAGS to
> KBUILD_HOSTCFLAGS"), so would like further opinion from Laura and
> Masahiro.

Laura's redhat e-mail bouncedm updated it to her kernel.org one, Laura,
Masahiro, would you please comment? Jiri?

- Arnaldo
 
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
