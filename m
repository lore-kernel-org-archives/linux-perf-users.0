Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE5CC433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 14 Nov 2021 16:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651E8610F9
	for <linux-perf-users@archiver.kernel.org>; Sun, 14 Nov 2021 16:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbhKNQop (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 14 Nov 2021 11:44:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26286 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236015AbhKNQoo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 14 Nov 2021 11:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636908109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l246sOTH7iiQoQiIK3jhTN4WlZOtFAyMpSUXHB76MgY=;
        b=X0yBvGe2qxmdCcnYhx+KxbaW7fRSr7dqgucrygytD1BgniTj1SfgjIdSk1GXyUxSmtw1PJ
        Y1iuQ/W6kMqOEthPCo3R5f+g0uh+zUJNC0JMkoDGDS5ySa0x4xsK8DuBDSCUZdXhMWj8xq
        1YTEPDxYLDF9lEHqTcxHqkEXDwUGbCc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-kebL5RGvOTqZWCYcEmmXZw-1; Sun, 14 Nov 2021 11:41:48 -0500
X-MC-Unique: kebL5RGvOTqZWCYcEmmXZw-1
Received: by mail-qv1-f70.google.com with SMTP id r13-20020a0562140c8d00b003bde7a2b8e2so13746634qvr.6
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Nov 2021 08:41:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l246sOTH7iiQoQiIK3jhTN4WlZOtFAyMpSUXHB76MgY=;
        b=4rUz4EtO9LN54GvO/Mnf7i53nStTC60tGRiGbOHH96+qYt3kZOpiRmvbvD8Gs7rT3n
         Ba4p80RI2VkES9y9Kp9Eln/KVBFplrxAArY18MI89FHg3vwOs6luy5SJdA3VsAcVcY6K
         1YcLmE+VnY2jBD/3nT4iaCSfpt4CQbHW+m3z3walC2PIpmuxsa4641CVP0NTUZecemhl
         XUWrbk0mEXK5gF6U3mxNKEjmhQDtm/49DCfkm0Q+zoho16Rw4tW5gq3ptw37SMRU0URL
         ZX5U4DtUWcShdLl2ouhzOpwYfZB4fZW8n4PTPZiQtYAvfr+U7kS+LeFwYziptqf6mVOY
         qGGQ==
X-Gm-Message-State: AOAM531Djjc7LumxR9aY5zpIDU2HJTqOty67RxZzGhv72P1SuURyyPaP
        wcyI2dIRgfNQig8bQRsc4VAkUDb2sBtaVRmCi7bSt2usrnia7OiuyizQA33uOdzHpWiGMOHaOpb
        oJ/idtVLM8S8U54kZTrkbyYVPKnj1ZA==
X-Received: by 2002:a0c:80e4:: with SMTP id 91mr30385197qvb.57.1636908108228;
        Sun, 14 Nov 2021 08:41:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIfbqlkOvhGlz3NvJbZQwC7EPe/hYzEoJMwWzPVCBGGxjaGNSWRhqOeL/afF5/0oomRBA+0A==
X-Received: by 2002:a0c:80e4:: with SMTP id 91mr30385162qvb.57.1636908107969;
        Sun, 14 Nov 2021 08:41:47 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id o5sm5383038qkl.50.2021.11.14.08.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 08:41:47 -0800 (PST)
Date:   Sun, 14 Nov 2021 17:41:44 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     acme@kernel.org, ravi.bangoria@amd.com, ananth.narayan@amd.com,
        kim.phillips@amd.com, rrichter@amd.com,
        linux-perf-users@vger.kernel.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com
Subject: Re: [RFC PATCH] tools/perf/x86: Use alternative format for AMD raw
 events
Message-ID: <YZE8SDkzq0OMcmhS@krava>
References: <20211111125646.581021-1-sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111125646.581021-1-sandipan.das@amd.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 11, 2021 at 06:26:46PM +0530, Sandipan Das wrote:

SNIP

> Before:
> 
>   $ sudo perf --debug perf-event-open stat -e ic_tag_hit_miss.all_instruction_cache_accesses sleep 1
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             4
>     size                             128
>     config                           0x100001f8e
>     sample_type                      IDENTIFIER
>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>     disabled                         1
>     inherit                          1
>     enable_on_exec                   1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   [...]
> 
>   $ sudo perf --debug perf-event-open stat -e r1f18e sleep 1
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             4
>     size                             128
>     config                           0x1f18e
>     sample_type                      IDENTIFIER
>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>     disabled                         1
>     inherit                          1
>     enable_on_exec                   1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   [...]
> 
>   $ sudo perf --debug perf-event-open stat -e r100001f8e sleep 1
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             4
>     size                             128
>     config                           0x100001f8e
>     sample_type                      IDENTIFIER
>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>     disabled                         1
>     inherit                          1
>     enable_on_exec                   1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   [...]
> 
> After:
> 
>   $ sudo perf --debug perf-event-open stat -e ic_tag_hit_miss.all_instruction_cache_accesses sleep 1
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             4
>     size                             128
>     config                           0x100001f8e
>     sample_type                      IDENTIFIER
>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>     disabled                         1
>     inherit                          1
>     enable_on_exec                   1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   [...]
> 
>   $ sudo perf --debug perf-event-open stat -e r1f18e sleep 1
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             4
>     size                             128
>     config                           0x100001f8e
>     sample_type                      IDENTIFIER
>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>     disabled                         1
>     inherit                          1
>     enable_on_exec                   1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   [...]
> 
>   $ sudo perf --debug perf-event-open stat -e r100001f8e sleep 1
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             4
>     size                             128
>     config                           0x100001f8e
>     sample_type                      IDENTIFIER
>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>     disabled                         1
>     inherit                          1
>     enable_on_exec                   1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   [...]
> 
> It is understandable that raw events must follow the native
> PERF_CTL register format but it is worthwhile to pursue such
> alternative formats for usability?

good question.. I see raw events as a way to put to config whatever
the user wants and IMO adding changes/quirks that silently changes
config could create confusion and angry users ;-)

I'd think that if user is composing/using raw events then using
directly r100001f8e is not such a big deal?

perhaps there was some some discussion about this that I missed?

thanks,
jirka

> 
> UUEEE is something that works for the core pmu events. Data
> fabric events have a 14-bit EventSelect field and will need
> more work.
> 
>   $ cat /sys/bus/event_source/devices/amd_df/format/event
>   config:0-7,32-35,59-60
> 
> More details on registers and events can be found in the
> AMD Processor Programming Reference (PPR). The one relevant
> to the EPYC 7713 processor used here can be found at:
> 
> https://bugzilla.kernel.org/attachment.cgi?id=296015
> 
> Infomration on PERF_CTL MSRs start at page 185 and PMU
> events start at page 445.
> 
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>

SNIP

