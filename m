Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507241922DC;
	Sat, 19 Oct 2024 03:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729306930; cv=none; b=ehsJ94QHYUt9Drm+qju4rzPefGaYD4CjeX+IpMujxDW378JXQ44DKJhBijvsD/IoKjv8O2fu+9wEZIn+cShPRJiC2UculbTN4aVik9YapLifB4mQEF+Zg8Qtk2asKNvilIAvPNlgQ790v9NadPbbWlkNVot3TueWUAciHdSpaRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729306930; c=relaxed/simple;
	bh=EsaCZb9yNgCTwt8PrUwFKZZi9IhJEj77/RKWiw+6CO0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=r4xyICO+pBAocon0XNMdAO84WzmmbNBaQWtf7PHfw1i1+08wnSUxSzmQlt4stcfbol5a1btdpEMFHMajNv4hNf922enGHC0AmtRWPW2iUrneu9xTNtGNi2J2L5kGLtxM6sO8YPcR5/hQgx+IeDb10GrBKXmuRyQSPEr4uVe51zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XVm816B7Zz10Ncc;
	Sat, 19 Oct 2024 10:42:41 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 21D8E1400E3;
	Sat, 19 Oct 2024 10:44:38 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Oct 2024 10:44:37 +0800
Subject: Re: [PATCH 3/3] perf disasm: Fix not cleaning up disasm_line in
 symbol__disassemble_raw()
To: Namhyung Kim <namhyung@kernel.org>
CC: <atrajeev@linux.vnet.ibm.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<kjain@linux.ibm.com>, <sesse@google.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241014114248.212711-1-lihuafei1@huawei.com>
 <20241014114248.212711-3-lihuafei1@huawei.com> <ZxGNwWjlflH1azE7@google.com>
From: Li Huafei <lihuafei1@huawei.com>
Message-ID: <2f180ed6-9cea-615d-638a-844ea154e9e1@huawei.com>
Date: Sat, 19 Oct 2024 10:44:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZxGNwWjlflH1azE7@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf500004.china.huawei.com (7.202.181.242)



On 2024/10/18 6:20, Namhyung Kim wrote:
> On Mon, Oct 14, 2024 at 07:42:48PM +0800, Li Huafei wrote:
>> In symbol__disassemble_raw(), the created disasm_line should be
>> discarded before returning an error.
> 
> But other error paths don't need to free the disasm_line because they
> failed before creating one.  I think the simpler fix is to break the
> loop when it fails on disasm_line__new().
> 

Yes, we only need to consider whether to release the created lines when
the loop fails in the middle. I will send a v2 version later.

Thanks,
Huafei

> Thanks,
> Namhyung
> 
>>
>> Fixes: 0b971e6bf1c3 ("perf annotate: Add support to capture and parse raw instruction in powerpc using dso__data_read_offset utility")
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>> ---
>>  tools/perf/util/disasm.c | 26 ++++++++++++--------------
>>  1 file changed, 12 insertions(+), 14 deletions(-)
>>
>> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
>> index 40d99f4d5cc7..4e5becd5eca6 100644
>> --- a/tools/perf/util/disasm.c
>> +++ b/tools/perf/util/disasm.c
>> @@ -1774,25 +1774,23 @@ static int symbol__disassemble_raw(char *filename, struct symbol *sym,
>>  		offset += 4;
>>  	}
>>  
>> -	/* It failed in the middle */
>> -	if (offset != len) {
>> -		struct list_head *list = &notes->src->source;
>> -
>> -		/* Discard all lines and fallback to objdump */
>> -		while (!list_empty(list)) {
>> -			dl = list_first_entry(list, struct disasm_line, al.node);
>> -
>> -			list_del_init(&dl->al.node);
>> -			disasm_line__free(dl);
>> -		}
>> -		count = -1;
>> -	}
>> -
>>  out:
>>  	free(buf);
>>  	return count < 0 ? count : 0;
>>  
>>  err:
>> +	if (!list_empty(&notes->src->source)) {
>> +		struct disasm_line *tmp;
>> +
>> +		/*
>> +		 * It probably failed in the middle of the above loop.
>> +		 * Release any resources it might add.
>> +		 */
>> +		list_for_each_entry_safe(dl, tmp, &notes->src->source, al.node) {
>> +			list_del(&dl->al.node);
>> +			disasm_line__free(dl);
>> +		}
>> +	}
>>  	count = -1;
>>  	goto out;
>>  }
>> -- 
>> 2.25.1
>>
> .
> 
