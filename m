Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CD1757EA;
	Fri, 11 Sep 2026 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789091287; cv=none; b=MYwdD8ttqHftB0XTtGrAPYd15zhrjPWcn00lBc8No5BIIc/SEiOLrlm9FEmdVLzG8UJ1NHrFaa3Xsmr3zEP3vms3O4/1OqRMzZfCKbezPPkKB7lMBIS8sBTYSPj2WnmIHZBYgbsL/f8rvC9b5vkYdKlZUgFP1v0GBFZm8fOxtjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789091287; c=relaxed/simple;
	bh=FuyTQKEtPmp5jrLLptMG5DhO0TqlDaiofz9cGAeYc30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3T9zdBlNb1U86VcoUyIDYIFnQazIETvHrdi2pZW5gkYUH1LxC/vkAmAF6aTuAf9nyeDbZJQuA1DWrGFb84UPLE/gH1jyPY7qKeT+Y5t5qTU6gGNvI+Edyw3ckYW3C0VP8E1VFx90afFKgWvX2OYb/09MAqf4GFZ8cssr3Jah/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hgy9P3ypMzKHMR9;
	Fri, 11 Sep 2026 09:47:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 09E574056B;
	Fri, 11 Sep 2026 09:47:59 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDnTEnOXaNqMeMgBg--.29875S2;
	Fri, 11 Sep 2026 09:47:58 +0800 (CST)
Message-ID: <0ef7dbfd-3bd6-40bb-b42a-a81edd2ba468@huaweicloud.com>
Date: Fri, 11 Sep 2026 09:47:58 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/26] perf dwarf-regs: Adapt get_dwarf_regnum() for
 arm64
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, james.clark@linaro.org,
 xueshuai@linux.alibaba.com, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Kim Phillips <kim.phillips@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20260908130122.633500-1-wutengda@huaweicloud.com>
 <20260908130122.633500-8-wutengda@huaweicloud.com>
 <CAP-5=fUAtw6-waqmF4RJFGZ__J=DSzbNLNsOfWekj378_PnrdQ@mail.gmail.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <CAP-5=fUAtw6-waqmF4RJFGZ__J=DSzbNLNsOfWekj378_PnrdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDnTEnOXaNqMeMgBg--.29875S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1kJw1fuw4rJr43GFWkXrb_yoWrXF1DpF
	srC3W7Jr4DGa4akwnxXF1fWFyfXw4rXr40yryjyw47CrsruF12qw4xKr1j9F48ZrWDJw10
	kayjgr1rWrn5JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6x
	kF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0bAw3UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/9 2:08, Ian Rogers wrote:
> On Tue, Sep 8, 2026 at 6:01 AM Tengda Wu <wutengda@huaweicloud.com> wrote:
>>
>> The current arm64 DWARF register lookup relies on 'aarch64_regstr_tbl',
>> a static string table. While this works for kprobe-tracer where register
>> names start with '%', it is insufficient for parsing register numbers
>> directly from raw instructions (e.g., extracting '6' from 'x6' or 'w6')
>> during annotation.
>>
>> Since get_dwarf_regnum() is currently used only by 'perf annotate' and
>> does not affect kprobe-tracer, replace the limited table-based lookup
>> with a programmatic implementation in __get_dwarf_regnum_arm64(). This
>> allows resolving arm64 register names (x0-x30, w0-w30, sp, etc.) directly
>> into their corresponding DWARF register numbers.
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  .../util/dwarf-regs-arch/dwarf-regs-arm64.c   | 22 +++++++++++++++++++
>>  tools/perf/util/dwarf-regs.c                  |  2 +-
>>  tools/perf/util/include/dwarf-regs.h          |  1 +
>>  3 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
>> index 593ca7d4fccc..720c863d1869 100644
>> --- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
>> +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
>> @@ -1,5 +1,8 @@
>>  // SPDX-License-Identifier: GPL-2.0
>>  #include <errno.h>
>> +#include <ctype.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>>  #include <dwarf-regs.h>
>>  #include "../../../arch/arm64/include/uapi/asm/perf_regs.h"
>>
>> @@ -10,3 +13,22 @@ int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_regnum)
>>
>>         return perf_regnum;
>>  }
>> +
>> +int __get_dwarf_regnum_arm64(const char *name)
>> +{
>> +       int reg;
>> +
>> +       if (!strcmp(name, "sp"))
>> +               return 31;
>> +
>> +       if (*name != 'x' && *name != 'w')
>> +               return -ENOENT;
>> +
>> +       name++;
>> +       if (!isdigit(*name))
>> +               return -ENOENT;
>> +
>> +       reg = strtol(name, NULL, 10);
> 
> Nit: perhaps this can be a little faster and ensure correct string termination?
> ```
> if (!isdigit(name[0])) {
>     return -ENOENT;
> } else if (isdigit(name[1]) && name[2] == '\0') {
>      reg = (name[1] - ' 0') * 10 + name[2] - '0';
> } else if (name[1] == '\0) {
>    reg = name[1] - '0';
> } else {
>    return -ENOENT;
> }
> ```
> Everything else looks good to me.
> 
> Thanks,
> Ian
> 

Sure, Ian. Thanks for the review. I'll make the change in v6.

Thanks,
Tengda

>> +
>> +       reg = strtol(name, NULL, 10);
>> +
>> +       return reg >= 0 && reg <= 30 ? reg : -ENOENT;
>> +}
>> diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
>> index 797f455eba0d..bacf5c13c3bc 100644
>> --- a/tools/perf/util/dwarf-regs.c
>> +++ b/tools/perf/util/dwarf-regs.c
>> @@ -114,7 +114,7 @@ int get_dwarf_regnum(const char *name, unsigned int machine, unsigned int flags)
>>                 reg = _get_dwarf_regnum(arm_regstr_tbl, name);
>>                 break;
>>         case EM_AARCH64:
>> -               reg = _get_dwarf_regnum(aarch64_regstr_tbl, name);
>> +               reg = __get_dwarf_regnum_arm64(name);
>>                 break;
>>         case EM_CSKY:
>>                 reg = __get_csky_regnum(name, flags);
>> diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
>> index 46a764cf322f..a25f038bbff2 100644
>> --- a/tools/perf/util/include/dwarf-regs.h
>> +++ b/tools/perf/util/include/dwarf-regs.h
>> @@ -105,6 +105,7 @@ int __get_dwarf_regnum_x86_64(const char *name);
>>  int __get_dwarf_regnum_for_perf_regnum_i386(int perf_regnum);
>>  int __get_dwarf_regnum_for_perf_regnum_x86_64(int perf_regnum);
>>
>> +int __get_dwarf_regnum_arm64(const char *name);
>>  int __get_dwarf_regnum_for_perf_regnum_arm(int perf_regnum);
>>  int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_regnum);
>>
>> --
>> 2.34.1
>>

