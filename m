Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F39481CD;
	Thu, 27 Jun 2024 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472502; cv=none; b=pz2JhAw1FFUxuA+7uyWdY6p9NU37RYr3jhiLvWE8Zz7CaJw2sumle2kxMfWrRkE+rXu5ySifxuejxkO3MLl8ThIjozYrmrQp39SJZzk5wMwwVAdO2ZoYq90zt3pn7N7gN4hU2MbAsAXqkllUIFR6xMmaFji0XuT/T7kVq/MOIcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472502; c=relaxed/simple;
	bh=jFnL01/BRn6CifS5s+AzxpVexhapTe3xGYsLLz7MEbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CwlgtM3SKGSoxnM0+dlKZotyngPCoPxnnkph0gYFWtzDvUnu7IqROPVJrugCowiOAgH9K4MpZSScQXdqbCc9H2VZZN+9UHwjjCqY5xAgawuANt/5N5EjDcdlJPh/UkBQTk4gbHn+nyubAlNtZAJw99Fblq1ClPTcLHCB5qi89BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4W8qX75YQzz1HDJP;
	Thu, 27 Jun 2024 15:12:39 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 1BD4518001B;
	Thu, 27 Jun 2024 15:14:51 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 15:14:50 +0800
Message-ID: <8b4353dc-f2bb-2c79-83ae-dc9a95572700@huawei.com>
Date: Thu, 27 Jun 2024 15:14:49 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/2] ARM: 9258/1: Fix callchain_trace() return value
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>
CC: <linux@armlinux.org.uk>, <will@kernel.org>, <mark.rutland@arm.com>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <rmk+kernel@armlinux.org.uk>,
	<eric.devolder@oracle.com>, <robh@kernel.org>, <ardb@kernel.org>,
	<broonie@kernel.org>, <lihuafei1@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>
References: <20240618032620.2445395-1-ruanjinjie@huawei.com>
 <20240618032620.2445395-2-ruanjinjie@huawei.com>
 <CACRpkdYAjKMSGmR4pc+LEfZ4NQArvgCEwy=ujzjOQus0K9j40w@mail.gmail.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <CACRpkdYAjKMSGmR4pc+LEfZ4NQArvgCEwy=ujzjOQus0K9j40w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/6/26 17:50, Linus Walleij wrote:
> On Tue, Jun 18, 2024 at 5:23 AM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> perf_callchain_store() return 0 on success, -1 otherwise, fix
>> callchain_trace() to return correct bool value. So walk_stackframe() can
>> have a chance to stop walking the stack ahead.
>>
>> Fixes: 70ccc7c0667b ("ARM: 9258/1: stacktrace: Make stack walk callback consistent with generic code")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Please put this into Russell's patch tracker.

Thank you, I'll put it, and could you please help to review another patch?

> 
> Yours,
> Linus Walleij
