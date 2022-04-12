Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9EDC433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Apr 2022 15:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiDLPdK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Apr 2022 11:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357106AbiDLPcp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Apr 2022 11:32:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04E5349F34;
        Tue, 12 Apr 2022 08:30:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1CCA13D5;
        Tue, 12 Apr 2022 08:30:25 -0700 (PDT)
Received: from [10.1.30.135] (e127744.cambridge.arm.com [10.1.30.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E63493F70D;
        Tue, 12 Apr 2022 08:30:23 -0700 (PDT)
Subject: Re: [PATCH 1/1] perf tools: Use Python devtools for version
 autodetection rather than runtime
To:     James Clark <james.clark@arm.com>, acme@kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220309194313.3350126-1-james.clark@arm.com>
 <20220309194313.3350126-2-james.clark@arm.com>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <1262ee1e-22dc-0cc6-3e60-257e17d9ed26@arm.com>
Date:   Tue, 12 Apr 2022 16:30:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220309194313.3350126-2-james.clark@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi James,

On 09/03/2022 19:43, James Clark wrote:
> This fixes the issue where the build will fail if only the Python2
> runtime is installed but the Python3 devtools are installed. Currently
> the workaround is 'make PYTHON=python3'.
>
> Fix it by autodetecting Python based on whether python[x]-config exists
> rather than just python[x] because both are needed for the build. Then
> -config is stripped to find the Python runtime.
>
> Testing
> =======
>
>  * Auto detect links with Python3 when the v3 devtools are installed
>    and only Python 2 runtime is installed
>  * Auto detect links with Python2 when both devtools are installed
>  * Sensible warning is printed if no Python devtools are installed
>  * 'make PYTHON=x' still automatically sets PYTHON_CONFIG=x-config
>  * 'make PYTHON=x' fails if x-config doesn't exist

If x is a valid python but no x-config is found in the system, the build
fails, instead of printing a warning like before. If we use this approach
I think [1] in the Makefile is never hit and needs to be cleaned up.

Thanks,
German

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/Makefile.config?h=perf/core#n826:

>  * 'make PYTHON=python3' overrides Python2 devtools
>  * 'make PYTHON=python2' overrides Python3 devtools
>  * 'make PYTHON_CONFIG=x-config' works
>  * 'make PYTHON=x PYTHON_CONFIG=x' works
>  * 'make PYTHON=missing' reports an error
>  * 'make PYTHON_CONFIG=missing' reports an error
>
> Fixes: 79373082fa9d ("perf python: Autodetect python3 binary")
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/Makefile.config | 39 ++++++++++++++++++++++++++------------
>  1 file changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 96ad944ca6a8..b3fbb746e7f0 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -239,18 +239,33 @@ ifdef PARSER_DEBUG
>  endif
>  
>  # Try different combinations to accommodate systems that only have
> -# python[2][-config] in weird combinations but always preferring
> -# python2 and python2-config as per pep-0394. If python2 or python
> -# aren't found, then python3 is used.
> -PYTHON_AUTO := python
> -PYTHON_AUTO := $(if $(call get-executable,python3),python3,$(PYTHON_AUTO))
> -PYTHON_AUTO := $(if $(call get-executable,python),python,$(PYTHON_AUTO))
> -PYTHON_AUTO := $(if $(call get-executable,python2),python2,$(PYTHON_AUTO))
> -override PYTHON := $(call get-executable-or-default,PYTHON,$(PYTHON_AUTO))
> -PYTHON_AUTO_CONFIG := \
> -  $(if $(call get-executable,$(PYTHON)-config),$(PYTHON)-config,python-config)
> -override PYTHON_CONFIG := \
> -  $(call get-executable-or-default,PYTHON_CONFIG,$(PYTHON_AUTO_CONFIG))
> +# python[2][3]-config in weird combinations in the following order of
> +# priority from lowest to highest:
> +#   * python3-config
> +#   * python-config
> +#   * python2-config as per pep-0394.
> +#   * $(PYTHON)-config (If PYTHON is user supplied but PYTHON_CONFIG isn't)
> +#
> +PYTHON_AUTO := python-config
> +PYTHON_AUTO := $(if $(call get-executable,python3-config),python3-config,$(PYTHON_AUTO))
> +PYTHON_AUTO := $(if $(call get-executable,python-config),python-config,$(PYTHON_AUTO))
> +PYTHON_AUTO := $(if $(call get-executable,python2-config),python2-config,$(PYTHON_AUTO))
> +
> +# If PYTHON is defined but PYTHON_CONFIG isn't, then take $(PYTHON)-config as if it was the user
> +# supplied value for PYTHON_CONFIG. Because it's "user supplied", error out if it doesn't exist.
> +ifdef PYTHON
> +  ifndef PYTHON_CONFIG
> +    PYTHON_CONFIG_AUTO := $(call get-executable,$(PYTHON)-config)
> +    PYTHON_CONFIG := $(if $(PYTHON_CONFIG_AUTO),$(PYTHON_CONFIG_AUTO),\
> +                          $(call $(error $(PYTHON)-config not found)))
> +  endif
> +endif
> +
> +# Select either auto detected python and python-config or use user supplied values if they are
> +# defined. get-executable-or-default fails with an error if the first argument is supplied but
> +# doesn't exist.
> +override PYTHON_CONFIG := $(call get-executable-or-default,PYTHON_CONFIG,$(PYTHON_AUTO))
> +override PYTHON := $(call get-executable-or-default,PYTHON,$(subst -config,,$(PYTHON_AUTO)))
>  
>  grep-libs  = $(filter -l%,$(1))
>  strip-libs  = $(filter-out -l%,$(1))
