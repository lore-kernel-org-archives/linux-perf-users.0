From: Paul Clarke <pc@us.ibm.com>
Subject: Re: [PATCH 08/27] perf record: Record the first and last sample time
 in the header
Date: Thu, 11 Jan 2018 07:29:46 -0600
Message-ID: <eea03d85-68ef-3902-fedf-8652a429f764@us.ibm.com>
References: <20180110212844.12441-1-acme@kernel.org>
 <20180110212844.12441-9-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933720AbeAKN3w (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Jan 2018 08:29:52 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0BDTUji087879
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jan 2018 08:29:52 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fe6xqnmy7-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Jan 2018 08:29:52 -0500
Received: from localhost
        by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <pc@us.ibm.com>;
        Thu, 11 Jan 2018 08:29:50 -0500
In-Reply-To: <20180110212844.12441-9-acme@kernel.org>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org

On 01/10/2018 03:28 PM, Arnaldo Carvalho de Melo wrote:
> From: Jin Yao <yao.jin@linux.intel.com>
> 
> In the default 'perf record' configuration, all samples are processed,
> to create the HEADER_BUILD_ID table. So it's very easy to get the
> first/last samples and save the time to perf file header via the
> function write_sample_time().
> 
> Later, at post processing time, perf report/script will fetch the time
> from perf file header.
> 
> Committer testing:
> 
>   # perf record -a sleep 1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 2.099 MB perf.data (1101 samples) ]
>   [root@jouet home]# perf report --header | grep "time of "
>   # time of first sample : 22947.909226
>   # time of last sample : 22948.910704
>   #
>   # perf report -D | grep PERF_RECORD_SAMPLE\(
>   0 22947909226101 0x20bb68 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4001): 0/0: 0xffffffffa21b1af3 period: 1 addr: 0
>   0 22947909229928 0x20bb98 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4001): 0/0: 0xffffffffa200d204 period: 1 addr: 0
>   <SNIP>
>   3 22948910397351 0x219360 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4001): 28251/28251: 0xffffffffa22071d8 period: 169518 addr: 0
>   0 22948910652380 0x20f120 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4001): 0/0: 0xffffffffa2856816 period: 198807 addr: 0
>   2 22948910704034 0x2172d0 [0x30]: PERF_RECORD_SAMPLE(IP, 0x4001): 0/0: 0xffffffffa2856816 period: 88111 addr: 0
>   #

This would be really useful to incorporate within "trace_begin" for perf script language support.  How difficult would that be?

Within perf scripts, it could be used to more efficiently compute deltas from the start of the trace within the functions.  For example, every time a function is invoked, like raw_syscalls__sys_enter, the only context one has is the current timestamp.  To determine the delta since the start of the trace, one has to know if this is the first event.  So, *every* event function needs something like:

def event_family__event(event_name, context, common_cpu, common_secs, common_nsecs, common_pid, common_comm, common_callchain, ..., perf_sample_dict):
        global start_timestamp
        current_timestamp = nsecs(common_secs, common_nsecs)
        if (start_timestamp == 0):
                start_timestamp = current_timestamp

If start_timestamp could be set in trace_begin, the conditional assignment of start_timestamp could be eliminated in *every* function.

(More generally, perhaps "trace_begin" could have access to the full set of information in the perf.data header?  Like, how many events are in the trace, so "% complete" tickers could be displayed during processing.)

Regards,
PC
