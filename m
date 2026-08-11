Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6BE394496;
	Tue, 11 Aug 2026 03:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786418730; cv=none; b=Y5b9Z4o/ViKw3smppKvIamGYUIVe/4ZkqbYXidlheWuQnMw6ISBc/nLpfJvWAw/3S28L5XrKAD45AkMdfJmU4n7JqXnNZCXb1zxhCTyxmTLHuKtUs+DQtGYNWk/hCvixygMtw8bWRn7KK1hnS2b1YmT3m0zQa/uVSnvJlFSP3p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786418730; c=relaxed/simple;
	bh=9y76cQD391WO8DvvOjTCpBOH37O/MNrEfgM9DmhmTgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYrpgBAZHwWsmDiFzfdTSnioqfLNj+o0C+qELgoQF/x5GVPvRKeGa56MehBEOrq/kxUyZ4CrN5E8XnBIfi+9drOuODC/4IRmJ0T7cMnRTiZDZ+ZnbCOG3EqJ6I5/nSOQc6mS4Dog7lCXGt4WPNz80xAhwY+EmrUmLEFPthnItP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QYnArfTu; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QYnArfTu"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786418719; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4XgK3imMB3NoBFeFmcCzz78TwjTfNSTHshu8BTdmpeA=;
	b=QYnArfTuIzGxpVyqizkD6TZV8OjZ5t4ak+Xib6UuhRvmB34/iuQpDbltueFE7sCdbi+CpZYS0jGcetSaX0yYqzqJM1UwhpP09ScrXUQ3OzioT9h7RdqNWk88WNrSudIy2qGCVqusXUAXIjq5kg4weR8NB9LMXSwWJPRrdWidMyg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X8mliJT_1786418717;
Received: from 30.246.162.187(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8mliJT_1786418717 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 11:25:18 +0800
Message-ID: <19df2aa0-4c8d-424d-a833-0c17d35a9502@linux.alibaba.com>
Date: Tue, 11 Aug 2026 11:25:16 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/23] perf capstone: Fix arm64 jump/adrp disassembly
 mismatch with objdump
To: Tengda Wu <wutengda@huaweicloud.com>, Namhyung Kim <namhyung@kernel.org>,
 james.clark@linaro.org, Li Huafei <lihuafei1@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Ian Rogers <irogers@google.com>, Kim Phillips <kim.phillips@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-2-wutengda@huaweicloud.com>
 <1b7e48ec-66a0-4727-b533-ff87f54df057@linux.alibaba.com>
 <244d8775-5318-4678-a392-b1416acc78af@huaweicloud.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <244d8775-5318-4678-a392-b1416acc78af@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/11/26 10:27 AM, Tengda Wu wrote:
> Hi Shuai, thank you for your time.
> 
> On 2026/8/10 21:08, Shuai Xue wrote:
>>
>>
>> On 8/8/26 8:23 PM, Tengda Wu wrote:
>>> The jump and adrp instructions parsed by libcapstone currently lack
>>> symbolic representation and use a '#' prefix for addresses. This
>>> format is inconsistent with objdump's output, which causes subsequent
>>> parsing in jump__parse() and arm64_mov__parse() to fail.
>>>
>>> Example mismatch:
>>>     Current: b #0xffff8000800114c8
>>>     Fix:     b ffff8000800114c8 <el0t_64_sync+0x108>
>>>
>>>     Current: adrp x18, #0xffff800081f5f000
>>>     Fix:     adrp x18, ffff800081f5f000 <this_cpu_vector>
>>>
>>> Fix this by implementing extended formatting for these arm64
>>> instructions during symbol__disassemble_capstone(). This ensures
>>> the output matches objdump's expected style, including the raw
>>> address and the associated <symbol+offset> suffix.
>>>
>>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>>> ---
>>>    tools/perf/util/capstone.c | 136 +++++++++++++++++++++++++++++++++----
>>>    tools/perf/util/disasm.c   |   5 ++
>>>    tools/perf/util/disasm.h   |   1 +
>>>    3 files changed, 130 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
>>> index 74213daf8786..fb8a2bc5558f 100644
>>> --- a/tools/perf/util/capstone.c
>>> +++ b/tools/perf/util/capstone.c
>>> @@ -3,6 +3,7 @@
>>>      #include <errno.h>
>>>    #include <inttypes.h>
>>> +#include <stdlib.h>
>>>    #include <string.h>
>>>      #include <dlfcn.h>
>>> @@ -31,6 +32,10 @@
>>>    #define CS_MODE_RISCVC   4
>>>    #endif
>>>    +#if CS_VERSION_MAJOR < 4
>>> +#define ARM64_GRP_BRANCH_RELATIVE  7
>>
>> Please add a comment explaining where '7' comes from
>> (CS_GRP_BRANCH_RELATIVE in capstone v3), otherwise it reads like an
>> arbitrary magic number.
>>
> 
> Um, this was done following Namhyung's approach. That said, adding a
> comment would certainly make this definition clearer -- will add it.
> 
> Also, I couldn't find CS_GRP_BRANCH_RELATIVE in v3. From what I can see,
> it was originally introduced in v4, together with ARM64_GRP_BRANCH_RELATIVE
> (see https://github.com/capstone-engine/capstone/commit/a09a81813c83).
> So the comment might look something like this:
> 
>    #define ARM64_GRP_BRANCH_RELATIVE  7  /* = CS_GRP_BRANCH_RELATIVE */
> 
> Is this acceptable?
> 

LGTM.

Thanks.
Shuai

