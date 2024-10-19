Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F913C8E2;
	Sat, 19 Oct 2024 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729324061; cv=none; b=tVO5bDrKYd8XARNLHNuEQweocjLpg5MqTaQrG3YGX48TXOVIUPe53JueAsAwKcoiplUfrBu4E+/r+83DaUF+h64XIelaSX0xnm5faIohPF7RcyXeC405LA8D7fwCYljLXYd3gINqDfbZpXAybZmhJu65yT6tXXegciB/2Py8ZXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729324061; c=relaxed/simple;
	bh=3eKqbFRjrTaTftUK+Mv8Ceo4ilGkL75mxj0ffCJ6lQA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Y5S6fdYP9iEPktuJ0Df6b6TNMbjk/Wcw+fEwPev99IM4AAEl+pJL3OXr5e1FSXNHuHRyqUXWJIs54YQXhhdA4IPq8WZ96NFTaE+EijjS1/ZM6rt+qe6umSbfdRt16QqYIHgmpM31KmSRG4+rMogENTYpRIaqRo70uazJAhg11R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XVttK1LDvz1SCVZ;
	Sat, 19 Oct 2024 15:46:17 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id A36C5140114;
	Sat, 19 Oct 2024 15:47:35 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 19 Oct 2024 15:47:34 +0800
Subject: Re: [PATCH 2/3] perf disasm: Use disasm_line__free() to properly free
 disasm_line
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
CC: <namhyung@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<kjain@linux.ibm.com>, <sesse@google.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241014114248.212711-1-lihuafei1@huawei.com>
 <20241014114248.212711-2-lihuafei1@huawei.com>
 <90BD7422-B738-4A35-8D45-51212E17716C@linux.vnet.ibm.com>
From: Li Huafei <lihuafei1@huawei.com>
Message-ID: <268c5c53-10c9-2c01-20d6-327e19184fed@huawei.com>
Date: Sat, 19 Oct 2024 15:47:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <90BD7422-B738-4A35-8D45-51212E17716C@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf500004.china.huawei.com (7.202.181.242)



On 2024/10/15 21:55, Athira Rajeev wrote:
> 
> 
>> On 14 Oct 2024, at 5:12 PM, Li Huafei <lihuafei1@huawei.com> wrote:
>>
>> The structure disasm_line contains members that require dynamically
>> allocated memory and need to be freed correctly using
>> disasm_line__free().
>>
>> This patch fixes the incorrect freeing in
>> symbol__disassemble_capstone_powerpc().  Also, since cs_disasm is not
>> enabled, it does not need to handle the situation described in
>> symbol__disassemble_capstone() where "offset != len" may occur due to
>> unknown instructions.
>>
>> Fixes: c5d60de1813a ("perf annotate: Add support to use libcapstone in powerpc")
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> 
> For the patches
> 
> Tested-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com <mailto:atrajeev@linux.vnet.ibm.com>>
> 

Thank you for the testing. As suggested by Namhyung in patch 3, the
patches need some modifications. I have sent v2, and if there are any
issues with v2, please let me know.

Thanks,
Huafei

> Thanks
> Athira
>> ---
>> tools/perf/util/disasm.c | 16 +---------------
>> 1 file changed, 1 insertion(+), 15 deletions(-)
>>
>> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
>> index 42222d61ceb5..40d99f4d5cc7 100644
>> --- a/tools/perf/util/disasm.c
>> +++ b/tools/perf/util/disasm.c
>> @@ -1580,20 +1580,6 @@ static int symbol__disassemble_capstone_powerpc(char *filename, struct symbol *s
>> offset += 4;
>> }
>>
>> - /* It failed in the middle */
>> - if (offset != len) {
>> - struct list_head *list = &notes->src->source;
>> -
>> - /* Discard all lines and fallback to objdump */
>> - while (!list_empty(list)) {
>> - dl = list_first_entry(list, struct disasm_line, al.node);
>> -
>> - list_del_init(&dl->al.node);
>> - disasm_line__free(dl);
>> - }
>> - count = -1;
>> - }
>> -
>> out:
>> if (needs_cs_close)
>> cs_close(&handle);
>> @@ -1612,7 +1598,7 @@ static int symbol__disassemble_capstone_powerpc(char *filename, struct symbol *s
>> */
>> list_for_each_entry_safe(dl, tmp, &notes->src->source, al.node) {
>> list_del(&dl->al.node);
>> - free(dl);
>> + disasm_line__free(dl);
>> }
>> }
>> count = -1;
>> -- 
>> 2.25.1
>>
> 
> 
> .
> 
