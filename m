Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D87CC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Oct 2021 10:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5816C60FED
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Oct 2021 10:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhJRKoO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Oct 2021 06:44:14 -0400
Received: from foss.arm.com ([217.140.110.172]:35266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhJRKoN (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Oct 2021 06:44:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74D5FED1;
        Mon, 18 Oct 2021 03:42:02 -0700 (PDT)
Received: from [10.57.27.116] (unknown [10.57.27.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CED793F70D;
        Mon, 18 Oct 2021 03:42:00 -0700 (PDT)
Subject: Re: [PATCH 2/2] perf jevents: Enable warnings through HOSTCFLAGS
To:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mingo@redhat.com
Cc:     irogers@google.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, kjain@linux.ibm.com
References: <1634316507-227751-1-git-send-email-john.garry@huawei.com>
 <1634316507-227751-3-git-send-email-john.garry@huawei.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <1804d7f3-c3bb-a90f-c86d-d96bff4235d2@arm.com>
Date:   Mon, 18 Oct 2021 11:41:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1634316507-227751-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 15/10/2021 17:48, John Garry wrote:
> Currently no compiler warnings at all are enabled for building jevents,
> so help catch bugs at compile time by enabling through HOSTCFLAGS.

Is there any reason to not enable -Wall and -Werror so that it builds like
the main project? Or if HOSTCFLAGS ends up being the same as CORE_CFLAGS
then why not use CORE_CFLAGS instead?

I added them like this and only one unused function needs to be removed to
make it build successfully:


diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 65934984f032..b2edcedf01db 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -18,6 +18,8 @@ detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
 
 CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
 HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
+HOSTCFLAGS += -Wall
+HOSTCFLAGS += -Wextra
 
 include $(srctree)/tools/scripts/Makefile.arch
 
@@ -212,6 +214,7 @@ endif
 ifneq ($(WERROR),0)
   CORE_CFLAGS += -Werror
   CXXFLAGS += -Werror
+  HOSTCFLAGS += -Werror
 endif
 
 ifndef DEBUG




> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/Makefile.config  | 1 +
>  tools/perf/Makefile.perf    | 2 +-
>  tools/perf/pmu-events/Build | 2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 0ae2e3d8b832..65934984f032 100644
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
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index a055dee6a46a..d5c287f069a2 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -1,7 +1,7 @@
>  hostprogs := jevents
>  
>  jevents-y	+= json.o jsmn.o jevents.o
> -HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include
> +HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include $(HOSTCFLAGS)
>  pmu-events-y	+= pmu-events.o
>  JDIR		=  pmu-events/arch/$(SRCARCH)
>  JSON		=  $(shell [ -d $(JDIR) ] &&				\
> 
