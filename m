Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C06C47080
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 23:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD700613F2
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 23:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbhFAXre (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Jun 2021 19:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235034AbhFAXrd (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Jun 2021 19:47:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42C7E613F0;
        Tue,  1 Jun 2021 23:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622591151;
        bh=547ziGklarlo+Osudojb8D43pdF92M2aOJKWeIfFN8A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VOMCXEkqK+OOooAHNWX53HXrUkacjvwNKfj9aStfvsIKOkYRDqAlRm4Fm8GIwZRFV
         lNu9nK2dCwxZQKMbhxhcd5rtk1IChHpyPwJ6ao+yv/XIyCPRTOLf2m7bjsZprz55jQ
         ymo6DA3I0BaleGVFq0UcmoVprZ3iac7zaMCJxqegLleClAOtbQH6lyFbh3OaqWPvma
         Ge991ZgUE6oRiGIGYE66k6/MjO9pDqV8NtiUVsYjNsuwQXND5jgddyOc5bsm+j9JjW
         uBEtbn2fgSK4/G4Cumq2mXmhaJtKFR1l019rKzJH0zcPkjLg2jEA2O2COMmR45I6Kh
         E7FFtZCtzZglA==
Date:   Wed, 2 Jun 2021 08:45:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     <acme@kernel.org>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <srikar@linux.vnet.ibm.com>, <fche@redhat.com>,
        <Jianlin.Lv@arm.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yangjihong1@huawei.com>,
        <zhangjinhao2@huawei.com>
Subject: Re: [PATCH] perf probe: Fix null pointer dereference in
 convert_variable_location()
Message-Id: <20210602084545.99e6d7d43e183ceaa603d247@kernel.org>
In-Reply-To: <20210601092750.169601-1-lihuafei1@huawei.com>
References: <20210601092750.169601-1-lihuafei1@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 1 Jun 2021 17:27:50 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> If we just check whether the variable can be converted, 'tvar' should be
> a null pointer. However, the null pointer check is missing in the
> 'Constant value' execution path.
> 
> The following cases can trigger this problem:
> 
> 	$ cat test.c
> 	#include <stdio.h>
> 
> 	void main(void)
> 	{
> 	        int a;
> 	        const int b = 1;
> 
> 	        asm volatile("mov %1, %0" : "=r"(a): "i"(b));
> 	        printf("a: %d\n", a);
> 	}
> 
> 	$ gcc test.c -o test -O -g
> 	$ sudo ./perf probe -x ./test -L "main"
> 	<main@/home/lhf/test.c:0>
> 	      0  void main(void)
> 	         {
> 	      2          int a;
> 	                 const int b = 1;
> 
> 	                 asm volatile("mov %1, %0" : "=r"(a): "i"(b));
> 	      6          printf("a: %d\n", a);
> 	         }
> 
> 	$ sudo ./perf probe -x ./test -V "main:6"
> 	Segmentation fault

Oops, thanks for fixing!

> 
> The check on 'tvar' is added. If 'tavr' is a null pointer, we return 0
> to indicate that the variable can be converted. Now, we can successfully
> show the variables that can be accessed.
> 
> 	$ sudo ./perf probe -x ./test -V "main:6"
> 	Available variables at main:6
> 	        @<main+13>
> 	                char*   __fmt
> 	                int     a
> 	                int     b
> 
> However, the variable 'b' cannot be tracked.
> 
> 	$ sudo ./perf probe -x ./test -D "main:6 b"
> 	Failed to find the location of the 'b' variable at this address.
> 	 Perhaps it has been optimized out.
> 	 Use -V with the --range option to show 'b' location range.
> 	  Error: Failed to add events.
> 
> This is because __die_find_variable_cb() did not successfully match
> variable 'b', which has the DW_AT_const_value attribute instead of
> DW_AT_location. We added support for DW_AT_const_value in
> __die_find_variable_cb(). With this modification, we can successfully
> track the variable 'b'.
> 
> 	$ sudo ./perf probe -x ./test -D "main:6 b"
> 	p:probe_test/main_L6 /home/lhf/test:0x1156 b=\1:s32

Great! This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Fixes: 66f69b219716 ("perf probe: Support DW_AT_const_value constant value")
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  tools/perf/util/dwarf-aux.c    | 8 ++++++--
>  tools/perf/util/probe-finder.c | 3 +++
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index b2f4920e19a6..7d2ba8419b0c 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -975,9 +975,13 @@ static int __die_find_variable_cb(Dwarf_Die *die_mem, void *data)
>  	if ((tag == DW_TAG_formal_parameter ||
>  	     tag == DW_TAG_variable) &&
>  	    die_compare_name(die_mem, fvp->name) &&
> -	/* Does the DIE have location information or external instance? */
> +	/*
> +	 * Does the DIE have location information or const value
> +	 * or external instance?
> +	 */
>  	    (dwarf_attr(die_mem, DW_AT_external, &attr) ||
> -	     dwarf_attr(die_mem, DW_AT_location, &attr)))
> +	     dwarf_attr(die_mem, DW_AT_location, &attr) ||
> +	     dwarf_attr(die_mem, DW_AT_const_value, &attr)))
>  		return DIE_FIND_CB_END;
>  	if (dwarf_haspc(die_mem, fvp->addr))
>  		return DIE_FIND_CB_CONTINUE;
> diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
> index 866f2d514d72..b029c29ce227 100644
> --- a/tools/perf/util/probe-finder.c
> +++ b/tools/perf/util/probe-finder.c
> @@ -190,6 +190,9 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
>  	    immediate_value_is_supported()) {
>  		Dwarf_Sword snum;
>  
> +		if (!tvar)
> +			return 0;
> +
>  		dwarf_formsdata(&attr, &snum);
>  		ret = asprintf(&tvar->value, "\\%ld", (long)snum);
>  
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
