Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF8CC00144
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Jul 2022 11:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiG2Lmr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Jul 2022 07:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiG2Lmq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Jul 2022 07:42:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCAA87364;
        Fri, 29 Jul 2022 04:42:45 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v3so4738913wrp.0;
        Fri, 29 Jul 2022 04:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=pkTQ5JuXFCwrWZpU8RMLir4nDIl4hKrN0Onyl52HcBo=;
        b=BBEP6KsTx01PhzpK5c+O4TXHNWFczgDIuOFBjj4L45wVUxTEpMIVH6mK9qBBUIXrT4
         3cc5hL5jvO+TuxSdgEzn55LgvYPfu1V/wNJ5wgw8bBf9Z+VbaI0K2B/A2Qn3yp03CpTC
         0YQGOFAp8+2tc2dYMxO7IFA6T4T85JGtEOmAsInIgqx8/VmsQHw9Xac4dNBaQnXUHXg0
         uH3OW+r/G93/4xy6b83C8lHk+tHG1rU604EoVR/roTPos5BkiN3vRlgOIaQALCf9azgn
         f058MIbI0hRoku9tcim/SaznAXvrnCmpzHypD5HTaTQNlbYxVJblJ/6Qdxx97AXbl70M
         kePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=pkTQ5JuXFCwrWZpU8RMLir4nDIl4hKrN0Onyl52HcBo=;
        b=E9/Zb13CdxiD622G9sUVsDfmS+K9jL2qaHfX3GOMXiQpWJ4SaAlD7re4B7d9SnPQLB
         GJNBVOBdm23KQ3BC9vkE49zlYqoz+snuTbZKHv3xyT7EZQvSnm3ZN3TrMXMJ/5duuQao
         4Bv2bZSE+WD0MGFkXqNVkMHyB/bGaR3rN5RA55DFWxqD6VVTZhy09CsNy/zBzFigC6d+
         sjABiV+TTauVY28SDFkNh0f3MmhO078PpL7efF4+SIfrkKAjKAaWZ+0muh8SzEPuquiq
         BswfCLnfBGakTByNIQODArbhWs/74W9PTKN/wCT1TVI5n5j11rslDlzL9tEdFwO5pkS1
         EYFg==
X-Gm-Message-State: ACgBeo3G6JStL3A3a4qmMoWS6unEXy3CIvbONQvejsf6kavAW9Wl7ETK
        R8VSajpX5JevvDXDvtL2PmY=
X-Google-Smtp-Source: AA6agR5aZYxBqpmizsBOiH0rohEwDTz2tdsSJ7fyYkKQuzK9lQCoIRNd6WDmlpo86+WrfFfvmDvjxg==
X-Received: by 2002:adf:cd05:0:b0:21d:df26:8db with SMTP id w5-20020adfcd05000000b0021ddf2608dbmr2148513wrm.220.1659094963643;
        Fri, 29 Jul 2022 04:42:43 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c191100b003a342933727sm10727819wmq.3.2022.07.29.04.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 04:42:43 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 29 Jul 2022 13:42:40 +0200
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf parse-events: Break out tracepoint and printing.
Message-ID: <YuPHsIjGe5T8wVLw@krava>
References: <20220707191209.273065-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707191209.273065-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 07, 2022 at 12:12:09PM -0700, Ian Rogers wrote:

SNIP

> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 7ed235740431..206c76623c06 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -5,18 +5,12 @@
>  #include <dirent.h>
>  #include <errno.h>
>  #include <sys/ioctl.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
>  #include <sys/param.h>
>  #include "term.h"
> -#include "build-id.h"
>  #include "evlist.h"
>  #include "evsel.h"
> -#include <subcmd/pager.h>
>  #include <subcmd/parse-options.h>
>  #include "parse-events.h"
> -#include <subcmd/exec-cmd.h>
>  #include "string2.h"
>  #include "strlist.h"
>  #include "bpf-loader.h"
> @@ -24,23 +18,24 @@
>  #include <api/fs/tracing_path.h>
>  #include <perf/cpumap.h>
>  #include "parse-events-bison.h"
> -#define YY_EXTRA_TYPE void*
>  #include "parse-events-flex.h"

hum, why is this not needed anymore?

>  #include "pmu.h"
> -#include "thread_map.h"
> -#include "probe-file.h"
>  #include "asm/bug.h"
>  #include "util/parse-branch-options.h"
> -#include "metricgroup.h"
>  #include "util/evsel_config.h"
>  #include "util/event.h"
> -#include "util/pfm.h"
> +#include "perf.h"
>  #include "util/parse-events-hybrid.h"
>  #include "util/pmu-hybrid.h"
> -#include "perf.h"
> +#include "tracepoint.h"
>  
>  #define MAX_NAME_LEN 100
>  

SNIP
