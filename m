Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC29192D6B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Dec 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733300959; cv=none; b=sNRvXifCOU23UhYEu9VGxX76C+KmchCTZdawFL9SJzrvIoRccyGDNAEXk11PJpaNrr4agw+yAaIvTE2qmdssXYvuyyOHmnh7Ff8UjZkMR0LTENc878V9PcFTcVvsNmwbJJh7Qnq20rpIeFcJBjRC1GcW5nhq1sOBsOkSKUWgyjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733300959; c=relaxed/simple;
	bh=TwY4nk/icnPo5syvDmlSy9YNyfE46kU0gZdmNxEOv8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSDfByHhdsGHXgICnJ4EevEhVjW7wc0LtW8BulfopPiqj5HhE5YLB+A5k+dbrKkTi3mM6SSliHpBGiXflxMwCLSNdVJcG4+3TNU123wmoQEnZgy2HeqUHaASbuGrE2hjxGDR8WQIJWuOdGjc9DCNIKI3ERjxmC0Z6MXHORovBr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fKsLc0jm; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fKsLc0jm"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so5206209a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Dec 2024 00:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733300956; x=1733905756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TLZSORcwDNCNRYfWTU+SMc0cTgQxpYSn4AIBkHM7H/Y=;
        b=fKsLc0jmrg4jovcOe13gTNq8gObfMT75mYsbjOHelZhi7mdoHw00T3DMqtDLdCO4Oj
         iOjNki18B4IPSNvSV9w2CnKHsQpIdYQZlhSNfITCiFigcz/ys/9TyAJdYdON1oERVcQK
         Ur4RyN2pHzGWBiznb32cJeamf0o+pe41Fb2GWfA+TUL+H6tkbj/NiTQ+cAnu2u4+zsAs
         piR9Jh8xkhy8dL5wASKroHohucMXvP/iKyHW6KdbKXNQofsQxAgoUId5b7uw2HPWgC5B
         GRBw3tFF2i/wB0JoxwCzGvY1r/MetztyFha1YVVZVfDnRQ3ckVZ20ydSb0IsKIyITzka
         xj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733300956; x=1733905756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TLZSORcwDNCNRYfWTU+SMc0cTgQxpYSn4AIBkHM7H/Y=;
        b=qur6Mr5Tyy3/LjHWzXm5iUT7yjdOk5bKLN7IIQQiEkNJvZr8vre14+T9oqUI+RJUuw
         QlcTaYNe8gluJvd0y4gDmnrAtpqZccVMeuveXl/wm3KS8FIdqnRhZjK8Ku8Nq/5G2P8g
         SVaAJch6ZKixqs9GMJ+6YAU2kfPpYr+fhPUQ4S/A1L0qIELo27JwgXUrwO313uzs0k16
         2MfUH4ksKQIRNZNvzAZ7ulmpcQ65xefcvimjt8BDcAzy95AswE0+a1AikK+mBSlWNYF3
         cHgUGjzkkODFqosuIXqkUytwMfz9P2NqsrElRkU1haWlXG+wiHG54Yl1WVy41tOUwfVE
         CPGA==
X-Forwarded-Encrypted: i=1; AJvYcCXKUs/a1cGvzJ/Cg9gvQYK7OezDP6Vww37Y2TEjABu+507fN+mmZ+lPwAHZBuoskcUzIZ2cwIB/3irNKfyBGFIN@vger.kernel.org
X-Gm-Message-State: AOJu0YxhWpWJ7zB6KgzoaERv7Mhm0HCZPch9pyjiZUDLWVs5/c68Lk2m
	rlufVmLcb/1RWuMmtW3OkXaMOUF/zGceVMYuCVX3sWnCm0uFmEd41aPEm0MrKOs=
X-Gm-Gg: ASbGncuHiLnHugpN6xqrkrFAyVnurhqnTvROmDdNNDSzueuQIB/lkAXzC32TBd78rX5
	8AkuAnh+Uofy7+zlcwAcczqkiQRB/2l3Ub1nDZ5FPe2tzPlfDtocHZNTx3pd02d0o5H7lxh8iP0
	zbgoAwx45Mazmj1L+T9RJfPAAqIEEoQhbq50kGblEcx3IJ6R99DbGYToian5uFUbJDZcr9PHZpq
	0c3TFQ171Y/zW8cAD7YcKDiMkX9ag76nZPjUGegqmrWz9Nw3o/6KynhLst8/2o=
X-Google-Smtp-Source: AGHT+IFfgyaV96mN6xSeoeVIL1qafBJc5PoZjODqeGEj7WEjbfKFLPUhTR9DWnVpffrfk4EUWg3uig==
X-Received: by 2002:a05:6a20:cfa9:b0:1e0:c9a9:a950 with SMTP id adf61e73a8af0-1e1654110a3mr8712061637.39.1733300956545;
        Wed, 04 Dec 2024 00:29:16 -0800 (PST)
Received: from [10.255.194.25] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fc9c2f7802sm10853498a12.27.2024.12.04.00.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 00:29:15 -0800 (PST)
Message-ID: <bbeba4c6-6c46-4708-9ce9-ff6037fe6449@bytedance.com>
Date: Wed, 4 Dec 2024 16:29:08 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [RFC 02/12] perf event action: Add parsing const
 expr support
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 james.clark@arm.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241128133553.823722-1-yangjihong@bytedance.com>
 <20241128133553.823722-3-yangjihong@bytedance.com> <Z0jROJ7JPTjmeZly@x1>
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <Z0jROJ7JPTjmeZly@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 11/29/24 04:23, Arnaldo Carvalho de Melo wrote:
> On Thu, Nov 28, 2024 at 09:35:43PM +0800, Yang Jihong wrote:
>> Event action requires constant expression parsing support,
>> which include constant integer and constant string.
>>
>> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
>> ---
>>   tools/perf/util/parse-action.c | 27 +++++++++++++++++++++++++++
>>   tools/perf/util/parse-action.h |  5 +++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/tools/perf/util/parse-action.c b/tools/perf/util/parse-action.c
>> index 01c8c7fdea59..391546bf3d73 100644
>> --- a/tools/perf/util/parse-action.c
>> +++ b/tools/perf/util/parse-action.c
>> @@ -4,6 +4,9 @@
>>    * Actions are the programs that run when the sampling event is triggered.
>>    * The action is a list of expressions separated by semicolons (;).
>>    * Each action is an expression, added to actions_head node as list_head node.
>> + *
>> + * Supported expressions:
>> + *   - constant:
> 
> This seems incomplete, what should come after the :?
> 
> the patch description, at the beginning of this message has more details
> than here.
This patch only implements a general constant expression category. The 
next patch will support parsing of specific string constant expressions 
and integer constant expressions.


> 
>>    */
>>   
>>   #include "util/debug.h"
>> @@ -115,7 +118,31 @@ void event_actions__free(void)
>>   	(void)event_actions__for_each_expr_safe(do_action_free, NULL, false);
>>   }
>>   
>> +static struct evtact_expr_ops *expr_const_ops_list[EVTACT_EXPR_CONST_TYPE_MAX] = {
>> +};
>> +
>> +static int expr_const_set_ops(struct evtact_expr *expr, u32 opcode)
>> +{
>> +	if (opcode >= EVTACT_EXPR_CONST_TYPE_MAX) {
>> +		pr_err("expr_const opcode invalid: %u\n", opcode);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (expr_const_ops_list[opcode] == NULL) {
>> +		pr_err("expr_const opcode not supported: %u\n", opcode);
>> +		return -ENOTSUP;
>> +	}
> 
> Since expr_const_ops_list[EVTACT_EXPR_TYPE_CONST] is NULL, this will
> always fail?
> 
Yes, this patch does not support specific constant expressions, so it is 
empty.

Thanks,
Yang.
