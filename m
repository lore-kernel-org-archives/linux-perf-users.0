Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CF22EAE6;
	Fri,  6 Sep 2024 02:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725589937; cv=none; b=spbUlBlb+htq/FnJcRFH74h+Np4EiG97Wew4xP3sLzny3tluP6gZDS2aNsGTRiQAAoOmL+5xuy2VPWNkkx+YbBeTNUY/eQFL8AD8wEDMNqMjhMECb4eSoZo+oMpoVBJ7YpaheLniiYTY+6xLuPMa4GPQVBRPUnCv5rK5GK3XQFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725589937; c=relaxed/simple;
	bh=fSWYi7Mu27hncJezLTGKPTGSTSS6RuU0aSynLmzcZtk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bwH+H0/0iIALMgtjKiDlJwPBBdb7io/RRXarC26ybRz0dDqsdlw0D57950F7p9Hb3HX4WWr9IeJp5yj8W/L7lBJBcSLTipuBDwoVfxucegKq3mlJMFnw8ORUJl62oNDLJPe+/68z1fH2RtIAa/yJy1VGDfIHj6/HBGP6+61T3+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X0KvJ3dRBzfbnb;
	Fri,  6 Sep 2024 10:30:04 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 83880140452;
	Fri,  6 Sep 2024 10:32:12 +0800 (CST)
Received: from [10.174.179.79] (10.174.179.79) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Sep 2024 10:32:11 +0800
Subject: Re: [PATCH] mm: move mm flags to mm_types.h
To: Matthew Wilcox <willy@infradead.org>
CC: <akpm@linux-foundation.org>, <mhiramat@kernel.org>, <oleg@redhat.com>,
	<peterz@infradead.org>, <wangkefeng.wang@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <20240905152622.1205046-1-sunnanyong@huawei.com>
 <ZtoD9tXJjWaS4liX@casper.infradead.org>
From: Nanyong Sun <sunnanyong@huawei.com>
Message-ID: <c207e483-c9f0-1277-8731-7a1d5463061a@huawei.com>
Date: Fri, 6 Sep 2024 10:32:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZtoD9tXJjWaS4liX@casper.infradead.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600003.china.huawei.com (7.193.23.202)

On 2024/9/6 3:18, Matthew Wilcox wrote:
> On Thu, Sep 05, 2024 at 11:26:22PM +0800, Nanyong Sun wrote:
>> +++ b/include/linux/mm_types.h
>> @@ -1485,4 +1485,85 @@ enum {
>>   	/* See also internal only FOLL flags in mm/internal.h */
>>   };
>>   
>> +/* mm flags */
>> +
>> +/* for SUID_DUMP_* above */
> But SUID_DUMP aren't above.  They're in a different file.
>
>
> .
Sorry, I forgot to modify this comment.
Plan to change it to:

/* core dumpable occupy bit0 and bit1 */

Do you think this is OK?
Thanks.
