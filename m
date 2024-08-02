Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBCB23BE;
	Fri,  2 Aug 2024 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562691; cv=none; b=QAaP3KjP76rK0yynVS7ftxELFTGK9FagyzonGM8jnY5moUrpzVor129N7BC4JndAyhrEGrqg3iaLe/PH5YIzpgEPL0HhEONoko1+jHjMIkwUXsqEMWd5UxQatGaWLNI2gdgG5Uzi/m7FkMDejryevXS0g2EA/h8Mc9aDw7/+yxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562691; c=relaxed/simple;
	bh=mIpy2kd8VdwIWeSn1wpqNNhPbAFJkACF1nbu/Ftpb9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hkLJo6k1ZrhPYHL2QJbw1fWz/45JOFXKYSotJ2HT4HlLC2N5rlpexv//4Sofd5FrwH+xz73iL8KgEq+6c77NUL86IaNYmP/VerNB1O47FuQef7Sh8HAnrNbj9nuCskbX9pF9lbnAkD7R9OxCtfh7IyEkJ7FoseKb22UXtKd2ZRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WZpLC4L2yz1HFgL;
	Fri,  2 Aug 2024 09:35:15 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 54E6D1402E0;
	Fri,  2 Aug 2024 09:38:06 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 2 Aug 2024 09:38:05 +0800
Message-ID: <51a756b7-3c2f-9aeb-1418-b38b74108ee6@huawei.com>
Date: Fri, 2 Aug 2024 09:38:04 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] uprobes: Improve scalability by reducing the contention
 on siglock
To: Oleg Nesterov <oleg@redhat.com>
CC: <mhiramat@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
References: <20240801082407.1618451-1-liaochang1@huawei.com>
 <20240801140639.GE4038@redhat.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240801140639.GE4038@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/8/1 22:06, Oleg Nesterov 写道:
> On 08/01, Liao Chang wrote:
>>
>> @@ -2276,22 +2277,25 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
>>  	int err = 0;
>>  
>>  	uprobe = utask->active_uprobe;
>> -	if (utask->state == UTASK_SSTEP_ACK)
>> +	switch (utask->state) {
>> +	case UTASK_SSTEP_ACK:
>>  		err = arch_uprobe_post_xol(&uprobe->arch, regs);
>> -	else if (utask->state == UTASK_SSTEP_TRAPPED)
>> +		break;
>> +	case UTASK_SSTEP_TRAPPED:
>>  		arch_uprobe_abort_xol(&uprobe->arch, regs);
>> -	else
>> +		fallthrough;
>> +	case UTASK_SSTEP_DENY_SIGNAL:
>> +		set_tsk_thread_flag(current, TIF_SIGPENDING);
>> +		break;
>> +	default:
>>  		WARN_ON_ONCE(1);
>> +	}
> 
> Liao, at first glance this change looks "obviously wrong" to me.

Oleg. Did i overlook some thing obvious here?

> 
> But let me read this patch more carefully and reply on weekend,
> I am a bit busy right now.

Sure, thanks.

> 
> Thanks,
> 
> Oleg.
> 
> 

-- 
BR
Liao, Chang
