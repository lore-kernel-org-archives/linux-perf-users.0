Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B338C12002
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 01:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4470E613CC
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 01:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhGOBXC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 21:23:02 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6819 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhGOBXC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jul 2021 21:23:02 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GQGcJ09KhzXtFy;
        Thu, 15 Jul 2021 09:14:24 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 09:20:01 +0800
Received: from [10.67.102.248] (10.67.102.248) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Jul 2021 09:20:01 +0800
Subject: Re: [PATCH] perf probe: Fix add event failed when 32-bit perf running
 in 64-bit kernel
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <fche@redhat.com>, <ravi.bangoria@linux.ibm.com>,
        <yao.jin@linux.intel.com>, <srikar@linux.vnet.ibm.com>,
        <Jianlin.Lv@arm.com>, <lihuafei1@huawei.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210714065432.188061-1-yangjihong1@huawei.com>
 <20210714173553.944cef13897dfe1bea7b8d78@kernel.org>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <9cb859df-f2ef-732b-756e-c8d2acefe85c@huawei.com>
Date:   Thu, 15 Jul 2021 09:20:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210714173553.944cef13897dfe1bea7b8d78@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.248]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm000003.china.huawei.com (7.185.36.128)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Hiramatsu,

On 2021/7/14 16:35, Masami Hiramatsu wrote:
> Hi Yang,
> 
> On Wed, 14 Jul 2021 14:54:32 +0800
> Yang Jihong <yangjihong1@huawei.com> wrote:
> 
>> The "address" member  of "struct probe_trace_point" uses long data type.
>> If kernel is 64-bit and perf program is 32-bit, size of "address" variable is
>> 32 bits. As a result, upper 32 bits of address read from kernel are truncated,
>> An error occurs during address comparison in kprobe_warn_out_range function.
> 
> Good catch!
> I didn't imagine that such a use case. But that is important because perf
> probe can be used for cross-arch probe definition too.
> 
>>
>> Before:
>>
>>    # perf probe -a schedule
>>    schedule is out of .text, skip it.
>>      Error: Failed to add events.
>>
>> Solution:
>>    Change data type of "address" variable to u64 and change corresponding
>> address printing and value assignment.
> 
> OK, as far as I can see, the other parts of the perf also uses u64 for
> "address" storing variables. (e.g. symbols, maps etc.)
> 
>>
>> After:
>>
>>    # perf.new.new probe -a schedule
>>    Added new event:
>>      probe:schedule       (on schedule)
>>
>>    You can now use it in all perf tools, such as:
>>
>>            perf record -e probe:schedule -aR sleep 1
>>
>>    # perf probe -l
>>      probe:schedule       (on schedule)
> 
> I think you missed one thing here.
> Usually, this shows the filename and line number of schedule().
Yes,  I tried the following diff and now it can show the filename (as is 
function entry, relative line number is 0), thank you very much :)

The test result in my environment is as follows:

# perf probe -a schedule
Added new event:
   probe:schedule       (on schedule)

You can now use it in all perf tools, such as:

         perf record -e probe:schedule -aR sleep 1

# perf probe -l schedule -k vmlinux.debug
   probe:schedule       (on schedule@kernel/sched/core.c)


Can I put the following diff together and submit a v2 patch?
> 
> Could you try below diff?
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 7d2ba8419b0c..609ca1671501 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -113,14 +113,14 @@ static Dwarf_Line *cu_getsrc_die(Dwarf_Die *cu_die, Dwarf_Addr addr)
>    *
>    * Find a line number and file name for @addr in @cu_die.
>    */
> -int cu_find_lineinfo(Dwarf_Die *cu_die, unsigned long addr,
> -		    const char **fname, int *lineno)
> +int cu_find_lineinfo(Dwarf_Die *cu_die, Dwarf_Addr addr,
> +		     const char **fname, int *lineno)
>   {
>   	Dwarf_Line *line;
>   	Dwarf_Die die_mem;
>   	Dwarf_Addr faddr;
>   
> -	if (die_find_realfunc(cu_die, (Dwarf_Addr)addr, &die_mem)
> +	if (die_find_realfunc(cu_die, addr, &die_mem)
>   	    && die_entrypc(&die_mem, &faddr) == 0 &&
>   	    faddr == addr) {
>   		*fname = dwarf_decl_file(&die_mem);
> @@ -128,7 +128,7 @@ int cu_find_lineinfo(Dwarf_Die *cu_die, unsigned long addr,
>   		goto out;
>   	}
>   
> -	line = cu_getsrc_die(cu_die, (Dwarf_Addr)addr);
> +	line = cu_getsrc_die(cu_die, addr);
>   	if (line && dwarf_lineno(line, lineno) == 0) {
>   		*fname = dwarf_linesrc(line, NULL, NULL);
>   		if (!*fname)
> diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
> index cb99646843a9..7ee0fa19b5c4 100644
> --- a/tools/perf/util/dwarf-aux.h
> +++ b/tools/perf/util/dwarf-aux.h
> @@ -19,7 +19,7 @@ const char *cu_find_realpath(Dwarf_Die *cu_die, const char *fname);
>   const char *cu_get_comp_dir(Dwarf_Die *cu_die);
>   
>   /* Get a line number and file name for given address */
> -int cu_find_lineinfo(Dwarf_Die *cudie, unsigned long addr,
> +int cu_find_lineinfo(Dwarf_Die *cudie, Dwarf_Addr addr,
>   		     const char **fname, int *lineno);
>   
>   /* Walk on functions at given address */
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 8ba01bbdf05c..50d861a80f57 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -1727,7 +1727,7 @@ int debuginfo__find_probe_point(struct debuginfo *dbg, u64 addr,
>   	}
>   
>   	/* Find a corresponding line (filename and lineno) */
> -	cu_find_lineinfo(&cudie, addr, &fname, &lineno);
> +	cu_find_lineinfo(&cudie, (Dwarf_Addr)addr, &fname, &lineno);
>   	/* Don't care whether it failed or not */
>   
>   	/* Find a corresponding function (name, baseline and baseaddr) */
> @@ -1828,8 +1828,7 @@ static int line_range_add_line(const char *src, unsigned int lineno,
>   }
>   
>   static int line_range_walk_cb(const char *fname, int lineno,
> -			      Dwarf_Addr addr __maybe_unused,
> -			      void *data)
> +			      Dwarf_Addr addr, void *data)
>   {
>   	struct line_finder *lf = data;
>   	const char *__fname;
> 
> 
