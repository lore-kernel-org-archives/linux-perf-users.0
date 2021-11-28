Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC6AC433EF
	for <linux-perf-users@archiver.kernel.org>; Sun, 28 Nov 2021 16:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346254AbhK1Qnj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 28 Nov 2021 11:43:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358361AbhK1Qlj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 28 Nov 2021 11:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638117502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rh9OiEKNFzqLO0F+hIXDImjWnQoH3cBeCq9fHny1mzU=;
        b=RVa0XrmNEVKSkiF8w0dYq7XZQYE89IAs3eaFwiy/3JY5ScmbU6FTKZ4IYIrZTyK/pxJVzD
        fw3OYlPv5cVuwTl/CUC9cokhdWEHCqYcVmKKV1hGcipH2oQ9V0X7tt66T+BBtMYxkvULbW
        +3/wGs+6TFDZt2qEppws/1LiwHcgNOw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-375-A1mbjyR7OKykPuZYMQc3Vw-1; Sun, 28 Nov 2021 11:38:21 -0500
X-MC-Unique: A1mbjyR7OKykPuZYMQc3Vw-1
Received: by mail-wm1-f70.google.com with SMTP id n16-20020a05600c3b9000b003331973fdbbso9076512wms.0
        for <linux-perf-users@vger.kernel.org>; Sun, 28 Nov 2021 08:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rh9OiEKNFzqLO0F+hIXDImjWnQoH3cBeCq9fHny1mzU=;
        b=bgB2JEZEY6lh/EfWoaSPKSDOsyvB+aREOJxPTQArDuIu4WGZSLcvkg5HNSpPO7JEjd
         x+uZ404LyB4XRWKbUkkOdTJP4PUo7+eR/7MSHFD+WEgPvRx1jjpy2Y0nBWMMTyr7QTvz
         dScombBi22WDX62kEB6/ZJ65YPehLCCT61/SgV7lZckNnkPNI6eCUf/Nsue9EcBE5pqZ
         WzjJicH6wpSoPp5+MhUzUdvS/vUjbpOgoj73MHYLdm4Y9I3u9MIML52bNSBQFIRNqpsN
         QBmXJYVpNvOSFzyNI0KJW9IwtpKLkyjdonJrKfV2C/wYKGBXR9JwJSOdGNNfgCiVblAz
         9apg==
X-Gm-Message-State: AOAM533/g934Jns9DTHP0KeFnGAEu924YCFI1tjm2xyNm/mMCxM3Zn+g
        htl+41yLrvSdnz8y+8yGbgZ3peCnMEuEIzNIt31/rPOyN+Zf6uKH6h1VA2KYYhjm6uRDNAtZ7bj
        5mewi5y+4Cj2/eQuiU46Xb13Y1PTCDA==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr30193035wmi.139.1638117500047;
        Sun, 28 Nov 2021 08:38:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwJcaPa5Bre80fju80nFD08TGjwL99vV0Eg6fE547Hqd2vV9i/v9cS0GfiX9cupNDqtdquvw==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr30193001wmi.139.1638117499785;
        Sun, 28 Nov 2021 08:38:19 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id f13sm14503875wmq.29.2021.11.28.08.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 08:38:19 -0800 (PST)
Date:   Sun, 28 Nov 2021 17:38:17 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     acme@kernel.org, santosh.shukla@amd.com, ravi.bangoria@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com, rrichter@amd.com,
        linux-perf-users@vger.kernel.org, kjain@linux.ibm.com
Subject: Re: [PATCH v3 1/2] perf/docs: Add info on AMD raw event encoding
Message-ID: <YaOweUHKRlMpTOTf@krava>
References: <20211123084613.243792-1-sandipan.das@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211123084613.243792-1-sandipan.das@amd.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Nov 23, 2021 at 02:16:12PM +0530, Sandipan Das wrote:
> AMD processors have events with event select codes and unit
> masks larger than a byte. The core PMU, for example, uses
> 12-bit event select codes split between bits 0-7 and 32-35
> of the PERF_CTL MSRs as can be seen from
> /sys/bus/event_sources/devices/cpu/format/*.
> 
> The Processor Programming Reference (PPR) lists the event
> codes as unified 12-bit hexadecimal values instead and the
> split between the bits is not apparent to someone who is
> not aware of the layout of the PERF_CTL MSRs.
> 
> 8-bit event select codes continue to work as the layout
> matches that of the PERF_CTL MSRs i.e. bits 0-7 for event
> select and 8-15 for unit mask.
> 
> This adds more details in the perf man pages about using
> /sys/bus/event_sources/devices/*/format/* for determining
> the correct raw event encoding scheme.
> 
> E.g. the "op_cache_hit_miss.op_cache_hit" event with code
> 0x28f and umask 0x03 can be programmed using its symbolic
> name as:
> 
>   $ sudo perf --debug perf-event-open stat -e op_cache_hit_miss.op_cache_hit sleep 1
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             4
>     size                             128
>     config                           0x20000038f
>     sample_type                      IDENTIFIER
>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>     disabled                         1
>     inherit                          1
>     enable_on_exec                   1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   [...]
> 
> One might use a simple eventsel+umask combination based on
> what the current man pages say and incorrectly program the
> event as:
> 
>   $ sudo perf --debug perf-event-open stat -e r0328f sleep 1
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             4
>     size                             128
>     config                           0x328f
>     sample_type                      IDENTIFIER
>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>     disabled                         1
>     inherit                          1
>     enable_on_exec                   1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   [...]
> 
> When it should have been based on the format from sysfs:
> 
>   $ cat /sys/bus/event_source/devices/cpu/format/event
>   config:0-7,32-35
> 
>   $ sudo perf --debug perf-event-open stat -e r20000038f sleep 1
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             4
>     size                             128
>     config                           0x20000038f
>     sample_type                      IDENTIFIER
>     read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>     disabled                         1
>     inherit                          1
>     enable_on_exec                   1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   [...]
> 
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> ---
> v1: https://lore.kernel.org/linux-perf-users/20211119111234.170726-1-sandipan.das@amd.com/
> v2: https://lore.kernel.org/linux-perf-users/20211123065104.236717-1-sandipan.das@amd.com/
> 
> v3:
> - Mention why simple eventsel+umask combinations will not
>   work in the commit message.

for both patches:

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> ---
>  tools/perf/Documentation/perf-list.txt   | 34 +++++++++++++++++++++++-
>  tools/perf/Documentation/perf-record.txt |  6 +++--
>  tools/perf/Documentation/perf-stat.txt   |  6 +++--
>  tools/perf/Documentation/perf-top.txt    |  7 ++---
>  4 files changed, 45 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> index 4dc8d0af19df..a922a95289a9 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -94,7 +94,7 @@ RAW HARDWARE EVENT DESCRIPTOR
>  Even when an event is not available in a symbolic form within perf right now,
>  it can be encoded in a per processor specific way.
>  
> -For instance For x86 CPUs NNN represents the raw register encoding with the
> +For instance on x86 CPUs, N is a hexadecimal value that represents the raw register encoding with the
>  layout of IA32_PERFEVTSELx MSRs (see [Intel® 64 and IA-32 Architectures Software Developer's Manual Volume 3B: System Programming Guide] Figure 30-1 Layout
>  of IA32_PERFEVTSELx MSRs) or AMD's PerfEvtSeln (see [AMD64 Architecture Programmer’s Manual Volume 2: System Programming], Page 344,
>  Figure 13-7 Performance Event-Select Register (PerfEvtSeln)).
> @@ -126,6 +126,38 @@ It's also possible to use pmu syntax:
>   perf record -e cpu/r1a8/ ...
>   perf record -e cpu/r0x1a8/ ...
>  
> +Some processors, like those from AMD, support event codes and unit masks
> +larger than a byte. In such cases, the bits corresponding to the event
> +configuration parameters can be seen with:
> +
> +  cat /sys/bus/event_source/devices/<pmu>/format/<config>
> +
> +Example:
> +
> +If the AMD docs for an EPYC 7713 processor describe an event as:
> +
> +  Event  Umask  Event Mask
> +  Num.   Value  Mnemonic                        Description
> +
> +  28FH     03H  op_cache_hit_miss.op_cache_hit  Counts Op Cache micro-tag
> +                                                hit events.
> +
> +raw encoding of 0x0328F cannot be used since the upper nibble of the
> +EventSelect bits have to be specified via bits 32-35 as can be seen with:
> +
> +  cat /sys/bus/event_source/devices/cpu/format/event
> +
> +raw encoding of 0x20000038F should be used instead:
> +
> + perf stat -e r20000038f -a sleep 1
> + perf record -e r20000038f ...
> +
> +It's also possible to use pmu syntax:
> +
> + perf record -e r20000038f -a sleep 1
> + perf record -e cpu/r20000038f/ ...
> + perf record -e cpu/r0x20000038f/ ...
> +
>  You should refer to the processor specific documentation for getting these
>  details. Some of them are referenced in the SEE ALSO section below.
>  
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 3cf7bac67239..55df7b073a55 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -30,8 +30,10 @@ OPTIONS
>  
>          - a symbolic event name	(use 'perf list' to list all events)
>  
> -        - a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
> -	  hexadecimal event descriptor.
> +        - a raw PMU event in the form of rN where N is a hexadecimal value
> +          that represents the raw register encoding with the layout of the
> +          event control registers as described by entries in
> +          /sys/bus/event_sources/devices/cpu/format/*.
>  
>          - a symbolic or raw PMU event followed by an optional colon
>  	  and a list of event modifiers, e.g., cpu-cycles:p.  See the
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 7e6fb7cbc0f4..604e6f2301ea 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -36,8 +36,10 @@ report::
>  
>  	- a symbolic event name (use 'perf list' to list all events)
>  
> -	- a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
> -	  hexadecimal event descriptor.
> +	- a raw PMU event in the form of rN where N is a hexadecimal value
> +	  that represents the raw register encoding with the layout of the
> +	  event control registers as described by entries in
> +	  /sys/bus/event_sources/devices/cpu/format/*.
>  
>          - a symbolic or raw PMU event followed by an optional colon
>  	  and a list of event modifiers, e.g., cpu-cycles:p.  See the
> diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> index 9898a32b8d9c..cac3dfbee7d8 100644
> --- a/tools/perf/Documentation/perf-top.txt
> +++ b/tools/perf/Documentation/perf-top.txt
> @@ -38,9 +38,10 @@ Default is to monitor all CPUS.
>  -e <event>::
>  --event=<event>::
>  	Select the PMU event. Selection can be a symbolic event name
> -	(use 'perf list' to list all events) or a raw PMU
> -	event (eventsel+umask) in the form of rNNN where NNN is a
> -	hexadecimal event descriptor.
> +	(use 'perf list' to list all events) or a raw PMU event in the form
> +	of rN where N is a hexadecimal value that represents the raw register
> +	encoding with the layout of the event control registers as described
> +	by entries in /sys/bus/event_sources/devices/cpu/format/*.
>  
>  -E <entries>::
>  --entries=<entries>::
> -- 
> 2.30.2
> 

