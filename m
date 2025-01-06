Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178958632D;
	Mon,  6 Jan 2025 02:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736129809; cv=none; b=Qh3EaPXEfO1SQ4PhsOg9Jf/Z3jY7W+Xky43hdLX5abyFkJFImD3mn/oTZJQjs89RVptA9MGsIP0ovlNeVlm72dus+tPq1wLccP0JJchfWxHzohF3HI4+8Fw9HKleYXslJ/MD8VIRANTckz4jlz1e0ENNgC4QcU8cq+nyBwWjA/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736129809; c=relaxed/simple;
	bh=wQs5xHQATXqeFETShg0xGXGS8irysaRgUHCxYxNlxQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLyZvEzccd4JeeNMPAq89OIBcRSpsOR6hEgWbhEGurc4lFo6hxGkVQSFi2RwTDZ9gLYgOdS885h09CgEaldPuTDa3byBLPz9szBGbc3La0Ck8hGsmZB6mQtCVGfUiqCivh3NgRc2kdOyu1aVlOu2fvjoh/Cc0HgK3mKzULNWvww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=V5ClR37f; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="V5ClR37f"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736129798; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=2t7wT64nZSxGkh3kLB0GS/20dZAugyGd+MYVrVrOZv4=;
	b=V5ClR37fTPg8qKzD7M9H3gtm+363IHHvAnzn6njwkFk6MhFvYSr97yCELN9iUUh1yKM+jUt7Ofs4KKAXcQ20tQGCerdA0Vj7g3AZFyFc+jx7OpXW1YH9qFo2jyRw3LAfXss8UTt3HY1y/M1pSPz8cAN64tTjwdAT3WNWunpjnro=
Received: from 30.221.145.122(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0WMzmDQ._1736129796 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 06 Jan 2025 10:16:37 +0800
Message-ID: <9f233d6e-ee4b-4ea3-96ee-397bba1b73b0@linux.alibaba.com>
Date: Mon, 6 Jan 2025 10:16:34 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/uncore: Fix the lack of ch_mask format for
 SPR
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1735542672-113067-1-git-send-email-renyu.zj@linux.alibaba.com>
 <7e5376f1-ee87-458b-b55e-759125d251a2@linux.intel.com>
From: Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <7e5376f1-ee87-458b-b55e-759125d251a2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2025/1/3 上午3:02, Liang, Kan 写道:
> 
> 
> On 2024-12-30 2:11 a.m., Jing Zhang wrote:
>> perf stat errors out with UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL event
>> because of lack of ch_mask format in drivers, and perf test "104: perf
>> all PMU test (exclusive)" failed.
>>
>> $perf stat -e perf stat -e UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL
>> sleep 1
>>
>> Initial error:
>> event syntax error: 'UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL'
>>                                 \___ unknown term 'ch_mask' for pmu 'uncore_cha_0'
>>
>> 104: perf all PMU test (exclusive)                                   : FAILED!
>>
>> Add ch_mask format for SPR to fix it.
>>
> 
> I don't think there is a ch_mask. It should be extended umask.
> The issue of the CHA extended umask should has been fixed by
> https://lore.kernel.org/lkml/172052531679.2215.16140288595428337453.tip-bot2@tip-bot2/
> 

I think it is not the same issue. I have this patch but still error.

in "tools/perf/pmu-events/arch/x86/sapphirerapids/uncore-cache.json",
the event "UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL" is described as:
{
        "BriefDescription": "UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL",
        "Counter": "0,1,2,3",
        "EventCode": "0x35",
        "EventName": "UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL",
        "Experimental": "1",
        "PerPkg": "1",
        "PortMask": "0x000",
        "UMask": "0x10c0008101",
        "Unit": "CHA"
},

the PortMask is ch_mask, but driver not output ch_mask on SPR, it causes error.

Thanks,
Jing

> Thanks,
> Kan




>> Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server CHA support")
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> ---
>>  arch/x86/events/intel/uncore_snbep.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
>> index ca98744..e537623 100644
>> --- a/arch/x86/events/intel/uncore_snbep.c
>> +++ b/arch/x86/events/intel/uncore_snbep.c
>> @@ -5967,6 +5967,7 @@ static int spr_cha_hw_config(struct intel_uncore_box *box, struct perf_event *ev
>>  	&format_attr_inv.attr,
>>  	&format_attr_thresh8.attr,
>>  	&format_attr_filter_tid5.attr,
>> +	&format_attr_ch_mask.attr,
>>  	NULL,
>>  };
>>  static const struct attribute_group spr_uncore_chabox_format_group = {
