Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAE5C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Feb 2022 21:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiBNVXc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Feb 2022 16:23:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiBNVXB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Feb 2022 16:23:01 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532E81342E7
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Feb 2022 13:22:45 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id t21so764229edd.3
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Feb 2022 13:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XB8nX4qqeYPSQCXZaBRzgOjasSxQu6pww/aZUYeNEnI=;
        b=qXehU1OMoh1YJQFkMMA9oZEdZsz3o7KBjve159mRbf/KZ+pq8N8DQ0F+BSQRfdBi/a
         xbvKZtS8ofpo0GpL9qpDM1PUXHWZ4HLedBw92mXMGZEcxzS+zZAINmRsnsQ7AwYn0Xff
         +jgQqNkKIqQ6UDM4F+j42H8F6cXuXvaNA8GH7wev1XLPWcOmH3ikNtDg5jHNwGtDZUin
         12j3QwTQS3AIlj5La5dXJvvxTglUAGGsZrT3gsld5VrMzegoXsTlKNec/A4akoj1vBEq
         8IfElal99c+HAEbqVXPZdToM8ciN8aNXRwkDY4hYuTft6Kl4YOM0kE4eLXltNScwUTCz
         vPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XB8nX4qqeYPSQCXZaBRzgOjasSxQu6pww/aZUYeNEnI=;
        b=FSYa0IsOY7BOI9xnZNdR174L/5XvkiCfa4yTNWTEuvCR1rXEa+bEmZaf8c6Zq5SIYF
         Qthj6JyzkYo2tT7gAVbqbug6mFT4WsQ3Td60lPMsh93IClUOTxwmhVAu4CNIXN8rWwsf
         ZIR5+xGlv1MAdWpMZZTi6RCSU9WRHRwlcY7CGx3bki7rRkBPo1waIWy7REGvP2RO/XZY
         TlyJtuquj0W+40AT+ONjjkNefK1/fSymdEJLlAKfmIBF5oeyg7yZ53AWWHU1KqV6qGCE
         I2TLOfK82au5dbTbReOE6SSP6cZAJtbLEJ/SeOAS/NK3TDxiuiju0q0HZRuIYoA1KStB
         d2AQ==
X-Gm-Message-State: AOAM531Kbs0uN8MzVTDycWTmDAlH9xDaJdgFYmGT8sfw6fMGqOyJf6WF
        2bxSeSLXafIcz/AERxfHxqIApjZPpOnf6Q==
X-Google-Smtp-Source: ABdhPJzm+t1m/9jYRAfRpnScd8Vbuj+e2AZ+M7VMDlY1v+myFLFZw+y/REjxrzik+kFknGzEdi47RQ==
X-Received: by 2002:a50:fb19:: with SMTP id d25mr810968edq.12.1644873763828;
        Mon, 14 Feb 2022 13:22:43 -0800 (PST)
Received: from krava ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id q12sm15694522edv.99.2022.02.14.13.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:22:43 -0800 (PST)
Date:   Mon, 14 Feb 2022 22:22:41 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: libperf: CPU map question
Message-ID: <YgrIId0p9KoE9zPI@krava>
References: <CAPpZLN6+BPu=Y_iCXBV_Uqg_mcY2LEBtg+_7r+oJqWkG8pNSGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpZLN6+BPu=Y_iCXBV_Uqg_mcY2LEBtg+_7r+oJqWkG8pNSGA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Feb 14, 2022 at 06:54:38PM +0200, Tzvetomir Stoyanov wrote:
> Hello,
> I'm trying to use libperf as an interface to perf from an application,
> but I face some difficulties.  I cannot understand how perf_cpu_map_
> APIs should be used. My use case is:
>  I want to iterate over the CPUs from the map. I'm using
> perf_evsel__cpus() API to get the map and perf_cpu_map__for_each_cpu()
> macros to iterate over the map. However, using that logic I get a
> struct perf_cpu for each CPU from the map. That structure seems to be
> private and I cannot access the actual .cpu id. Am I missing something
> ?
> Will be glad for any help and clarification.

yea it's a bug ;-) there was a change recently that wrapped cpu
in struct perf_cpu to distinguish it from cpu indexes

  6d18804b963b perf cpumap: Give CPUs their own type

not sure there's workaround for that.. but I think change below should fix it

Ian, would this be ok? we need to add some test for this

jirka


---
diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
index 581f9ffb4237..1973a18c096b 100644
--- a/tools/lib/perf/include/internal/cpumap.h
+++ b/tools/lib/perf/include/internal/cpumap.h
@@ -3,11 +3,7 @@
 #define __LIBPERF_INTERNAL_CPUMAP_H
 
 #include <linux/refcount.h>
-
-/** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
-struct perf_cpu {
-	int cpu;
-};
+#include <perf/cpumap.h>
 
 /**
  * A sized, reference counted, sorted array of integers representing CPU
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 15b8faafd615..4a2edbdb5e2b 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -7,6 +7,11 @@
 #include <stdio.h>
 #include <stdbool.h>
 
+/** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
+struct perf_cpu {
+	int cpu;
+};
+
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__default_new(void);
 LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);
