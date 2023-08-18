Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6A2C05052
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Aug 2023 07:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358130AbjHRHQX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Aug 2023 03:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358095AbjHRHP4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Aug 2023 03:15:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD9430D6
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Aug 2023 00:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692342954; x=1723878954;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xb+sScC9CG+Wcg8gmAQfZwVhPDsFYdn1wwo2UBGqVP0=;
  b=dAcE3B2KzUfQK2lJ0m8sXeVUuMhXlIMhRDKX0XZyIjPA8BF0Qz79J3HU
   3w1GDdbgW826H4+Z16BF4uM1ruG1Pv6VhRfhtvIJFzKWKhPY1c3Z7fSVo
   3bk83PDPLVmX6pZuJoOtr0sibtcOds/3CtMgirV1hV3MfQFY5jHxiaoHM
   8QWFLCYkl3UBR0Dmt500/Tuf8ROJRW6T9TVGMebmSvEzZfu3gPKOnISw+
   XvR5uicqQp2XQ81fdtUhfESATws2ATjU5fwKsh7vi/knb0p3GRJs2LVM/
   yaq9YLw805jiByUOP+ixQQdcNtxbCDxF5Ej4AR7mRF5gRIkP1dy/ebM8V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="404017309"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="404017309"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 00:15:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="800379388"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="800379388"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.212.27])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 00:15:51 -0700
Message-ID: <da3492ac-5473-f25b-f229-f213242321b1@intel.com>
Date:   Fri, 18 Aug 2023 10:15:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH V2 2/2] tools/perf/tests: Fix object code reading to skip
 address that falls out of text section
Content-Language: en-US
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
        jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, Disha Goel <disgoel@linux.ibm.com>
References: <20230817171852.55629-1-atrajeev@linux.vnet.ibm.com>
 <20230817171852.55629-2-atrajeev@linux.vnet.ibm.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230817171852.55629-2-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 17/08/23 20:18, Athira Rajeev wrote:
> The testcase "Object code reading" fails in somecases
> for "fs_something" sub test as below:
> 
>     Reading object code for memory address: 0xc008000007f0142c
>     File is: /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko
>     On file address is: 0x1114cc
>     Objdump command is: objdump -z -d --start-address=0x11142c --stop-address=0x1114ac /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko
>     objdump read too few bytes: 128
>     test child finished with -1
> 
> This can alo be reproduced when running perf record with
> workload that exercises fs_something() code. In the test
> setup, this is exercising xfs code since root is xfs.
> 
>     # perf record ./a.out
>     # perf report -v |grep "xfs.ko"
>       0.76% a.out /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko  0xc008000007de5efc B [k] xlog_cil_commit
>       0.74% a.out  /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko  0xc008000007d5ae18 B [k] xfs_btree_key_offset
>       0.74% a.out  /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko  0xc008000007e11fd4 B [k] 0x0000000000112074
> 
> Here addr "0xc008000007e11fd4" is not resolved. since this is a
> kernel module, its offset is from the DSO. Xfs module is loaded
> at 0xc008000007d00000
> 
>    # cat /proc/modules | grep xfs
>     xfs 2228224 3 - Live 0xc008000007d00000
> 
> And size is 0x220000. So its loaded between  0xc008000007d00000
> and 0xc008000007f20000. From objdump, text section is:
>     text 0010f7bc  0000000000000000 0000000000000000 000000a0 2**4
> 
> Hence perf captured ip maps to 0x112074 which is:
> ( ip - start of module ) + a0
> 
> This offset 0x112074 falls out .text section which is up to 0x10f7bc
> In this case for module, the address 0xc008000007e11fd4 is pointing
> to stub instructions. This address range represents the module stubs
> which is allocated on module load and hence is not part of DSO offset.
> 
> To address this issue in "object code reading", skip the sample if
> address falls out of text section and is within the module end.
> Use the "text_end" member of "struct dso" to do this check.
> 
> To address this issue in "perf report", exploring an option of
> having stubs range as part of the /proc/kallsyms, so that perf
> report can resolve addresses in stubs range
> 
> However this patch uses text_end to skip the stub range for
> Object code reading testcase.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/code-reading.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
> index ed3815163d1b..911f8fa13677 100644
> --- a/tools/perf/tests/code-reading.c
> +++ b/tools/perf/tests/code-reading.c
> @@ -269,6 +269,14 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
>  	if (addr + len > map__end(al.map))
>  		len = map__end(al.map) - addr;
>  
> +	/* Check if the ip offset falls in stubs sections for kernel modules */

What arches have stubs - maybe expand the comment a bit e.g.
"Some architectures (such as blah blah) have stubs (trampolines) in kernel modules to manage long jumps"

> +	if (strstr(dso->long_name, ".ko")) {
> +		if ((al.addr < map__end(al.map)) && (al.addr > dso->text_end)) {

Why check al.addr < map__end(al.map) ?  addr must be on the map mustn't it?

Also please remove redundant parentheses.

> +			pr_debug(" - skipping\n");

"skipping" but why.  Maybe "skipping module address after text end"

> +			goto out;
> +		}
> +	}
> +
>  	/* Read the object code using perf */
>  	ret_len = dso__data_read_offset(dso, maps__machine(thread__maps(thread)),
>  					al.addr, buf1, len);

