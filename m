Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246B0C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 Nov 2021 08:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhKWIyL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 Nov 2021 03:54:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24908 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229993AbhKWIyJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Nov 2021 03:54:09 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AN71pbN013996;
        Tue, 23 Nov 2021 08:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=sGGhNEygcp/NsL48gd8/fYu1O7XXL0QBG1mlOBcyPWI=;
 b=tPDLwgkI1EuYIIyaJsJFA3iy/6ac3qj5nIjwHhNpc4AvooOAvIwZGRjpM0LkmwSGjyTG
 /IQCI3GIrpY9wFUDzH1kbz5mhsHcfjs/GTw8MCczkImAKYeE+Btcqe+PwEOJi1hww5qo
 YjJQgbypB0aGW4sYSufdqSjA4X5ZRrNWsPQ8ogdf+7yDCClg4d9bjqQLaulLhQKVtYTd
 ZM4sB4vd4OSv5BtJ3y/Uf+tyQJidQ4ZRASK2jTpXNRw8GWg6BNbVNxhlpDWdMLTjPcAs
 +GH17L6cMIu6KhQX3RWnkxcBHfP4r1goJkASH5QGTgHHGbKt8EXXK0gX35pGJk61OBtq 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cgqccws3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Nov 2021 08:50:58 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AN8mmuF040927;
        Tue, 23 Nov 2021 08:50:58 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cgqccws2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Nov 2021 08:50:57 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AN8nIZq001895;
        Tue, 23 Nov 2021 08:50:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3cernanh3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Nov 2021 08:50:55 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AN8orrF41746738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Nov 2021 08:50:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58797A405B;
        Tue, 23 Nov 2021 08:50:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8E7EA4054;
        Tue, 23 Nov 2021 08:50:50 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com (unknown [9.43.21.81])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Nov 2021 08:50:50 +0000 (GMT)
Subject: Re: [PATCH v3 1/2] perf/docs: Add info on AMD raw event encoding
To:     Sandipan Das <sandipan.das@amd.com>, acme@kernel.org
Cc:     santosh.shukla@amd.com, ravi.bangoria@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com, rrichter@amd.com,
        linux-perf-users@vger.kernel.org, jolsa@redhat.com
References: <20211123084613.243792-1-sandipan.das@amd.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <ad3aa395-c26c-a1ff-f8ed-c0ca51cfb14a@linux.ibm.com>
Date:   Tue, 23 Nov 2021 14:20:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211123084613.243792-1-sandipan.das@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HN1QudBQ30KWn99OdqVrsQipJlLWqZYP
X-Proofpoint-ORIG-GUID: xmfo6m326Siz_Iwo2gwj3a2w3tcnDM3W
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_02,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230044
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 11/23/21 2:16 PM, Sandipan Das wrote:
> AMD processors have events with event select codes and unit
> masks larger than a byte. The core PMU, for example, uses
> 12-bit event select codes split between bits 0-7 and 32-35
> of the PERF_CTL MSRs as can be seen from
> /sys/bus/event_sources/devices/cpu/format/*.

Patch looks good to me.

Reviewed-by: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

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
> 
