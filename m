Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253CBC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 12:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04AC1611F2
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 12:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhJUMvI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 21 Oct 2021 08:51:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230190AbhJUMvI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Oct 2021 08:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634820532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yunc8pub8poBlXrF3I9GBufLMd8UU4ZQnUti6wOGfnc=;
        b=LfLymt8l51FYsVGQqd1uatgp7ICM7vU89+nxqOtR7wx7y8yudpMqnxL5pNOWOXfNfi5obE
        KrcrKGrteBxyyKZi8c903cUiRQHvu96ztG2vIbBFqQepJmyR3HYemucMJtXb7+B+tpL/6T
        1EaYtBwcV24jXgYdgqlCXhT6mrit0xQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-07YCw-4sPy-Ruo75lCWPqA-1; Thu, 21 Oct 2021 08:48:51 -0400
X-MC-Unique: 07YCw-4sPy-Ruo75lCWPqA-1
Received: by mail-ed1-f71.google.com with SMTP id z1-20020a05640235c100b003dcf0fbfbd8so220863edc.6
        for <linux-perf-users@vger.kernel.org>; Thu, 21 Oct 2021 05:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yunc8pub8poBlXrF3I9GBufLMd8UU4ZQnUti6wOGfnc=;
        b=U9j7HVAQSPMkWeeJODAfJz7NZHVuJWj4N+YxWDHVqioKn617+rtXAvSGKmHFzz1wmM
         QVFB4Qpx1WzoraJ2wbDvDknCzFQOgzoBL7K8s4d6Vy/zAGhQO4j5MOIYpVRPUyE87FkJ
         ymyaRLldVPP8VK2F6LSQJ0Eu2rZW37Rfi7yWOXyEChpuLHAgAioymL4jTsGJgvLlsozz
         BoQxm9qztiMEzPbKcfGZX8F5l353Bb9JmXwd2OHUnPueC1XK8lwrWI90fzCYUgWv5mjA
         6m1yBf9M3Va1U9Ul47T21cwM/srxo5foMIOsjwxrccpondyDczX4oaBCE6fL95gvnFj6
         MdkA==
X-Gm-Message-State: AOAM532PBImt1aWKivnHTUcNXrUSctRfJMwYjncLxMjuyCvc8+wh1wMC
        FFP9TcgKFXdNrBqik+SlfuNS7OUp5TBvOLs9VCXValdz6txs2ARbTp7xtgkCJHAks3o4ipMzN4A
        d7PdRc6oSbNiiGjil9CVsUz9CNNVEEQ==
X-Received: by 2002:a05:6402:50cd:: with SMTP id h13mr7704803edb.245.1634820529919;
        Thu, 21 Oct 2021 05:48:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLLIdsDZEMYktToTUmJjypunLcitHdoBbMikeliBpBpJFZr+BQdvQNp3OQ0UwVZyVEpQQzPw==
X-Received: by 2002:a05:6402:50cd:: with SMTP id h13mr7704778edb.245.1634820529691;
        Thu, 21 Oct 2021 05:48:49 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id g17sm2843902edv.72.2021.10.21.05.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 05:48:49 -0700 (PDT)
Date:   Thu, 21 Oct 2021 14:48:47 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        mingo@redhat.com, irogers@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjain@linux.ibm.com, james.clark@arm.com
Subject: Re: [PATCH v2 2/2] perf jevents: Enable warnings through HOSTCFLAGS
Message-ID: <YXFhr2YoVp9GPsDM@krava>
References: <1634807805-40093-1-git-send-email-john.garry@huawei.com>
 <1634807805-40093-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634807805-40093-3-git-send-email-john.garry@huawei.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 21, 2021 at 05:16:45PM +0800, John Garry wrote:
> Currently no compiler warnings at all are enabled for building jevents,
> so help catch bugs at compile time by enabling through HOSTCFLAGS.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  tools/perf/Makefile.config  | 5 +++++
>  tools/perf/Makefile.perf    | 2 +-
>  tools/perf/pmu-events/Build | 2 +-
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
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

so the the host cflags are made of:

host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(KBUILD_HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))

can't you use KBUILD_HOSTCFLAGS?

also perhaps we could rename KBUILD_HOSTCFLAGS to HOSTCFLAGS?
the name seems like leftover from kbuild move

jirka

>  pmu-events-y	+= pmu-events.o
>  JDIR		=  pmu-events/arch/$(SRCARCH)
>  JSON		=  $(shell [ -d $(JDIR) ] &&				\
> -- 
> 2.17.1
> 

