Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA25347B4;
	Thu, 17 Apr 2025 02:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744855324; cv=none; b=P2Rrl4THLV6lWXS4R5AOkv7YBt9ytvtM2zgEZ0kMPn654Zw/YvCSCtxVMZIMnVpSXU7kKKVtYYUXpfzK664U1Ym0FDaXHGJ+f2BxgZYqKrTKoYgPe/7TSP58ExTUAA+zEOc1/nrEi19OOsAAR0epZH3yWIzTin1TLK69yEs7w1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744855324; c=relaxed/simple;
	bh=WPDDbhp8WAGufEsLxoMENfzkaZrNQ8xB3RaQ5758HIA=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=u4a0bjljegW8UnwDoZ5WcCDnoGIJ/U53ObmoWy3MhFXr5buucEG2FC32BpYLkqXSU1RC2B+fcXow6q4MOpmkZ0FeKoK8fwyX40qmeI82bv1DKinPxHT9yhZD6a5tvX3dbPre1rkvGa1ho4GMDFHguSsNHGxismDyEUlbBS/2yDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZdLjt0tXrz5B1J5;
	Thu, 17 Apr 2025 10:01:54 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZdLjb2flgz51Sc8;
	Thu, 17 Apr 2025 10:01:39 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 53H21H4T056359;
	Thu, 17 Apr 2025 10:01:17 +0800 (+08)
	(envelope-from jiang.peng9@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid31;
	Thu, 17 Apr 2025 10:01:18 +0800 (CST)
Date: Thu, 17 Apr 2025 10:01:18 +0800 (CST)
X-Zmail-TransId: 2afc680060ee14f-bf7c5
X-Mailer: Zmail v1.0
Message-ID: <20250417100118733FrbRcKrZFI5AZsN2G6nyr@zte.com.cn>
In-Reply-To: <40981d32-72f4-4935-a62c-444ad78ce336@linux.ibm.com>
References: 2c04b7ef-dc85-4a40-b0d8-6ae73c20b65d@linux.ibm.com,B34E8075-7F38-4E30-9E51-23E43DDDF06F@linux.ibm.com,1ec497ed-b98c-46aa-a9c2-5fa906790298@linux.ibm.com,99a06f56-08cf-42ce-a231-f9a38c6ece9a@linux.ibm.com,51BBBC12-9A42-4D72-BDBB-84879C940764@linux.ibm.com,40981d32-72f4-4935-a62c-444ad78ce336@linux.ibm.com
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.peng9@zte.com.cn>
To: <venkat88@linux.ibm.com>
Cc: <atrajeev@linux.ibm.com>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <maddy@linux.ibm.com>,
        <mingo@kernel.org>, <linux-kernel@vger.kernel.org>,
        <shao.mingyin@zte.com.cn>, <tglx@linutronix.de>
Subject: =?UTF-8?B?UmU6IFttYWlubGluZV10b29scy9wZXJmIGJ1aWxkIHdhcm5pbmdz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 53H21H4T056359
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68006112.000/4ZdLjt0tXrz5B1J5

> I verified with perf-tools-next repo on both branches namely
> tmp.perf-tools-next and perf-tools-next, and I think this warning got
> recently introduced.
>
> Git Bisect is pointing to acea9943271b62905033f2f8ca571cdd52d6ea7b as
> first bad commit.

Hi everyone,

I apologize for the oversight. My commit (acea9943271b62905033f2f8ca571cdd52d6ea7b) updated include/vdso/unaligned.h but I forgot to sync it with tools/include/vdso/unaligned.h. I'll be more careful in the future to avoid such mistakes.

Thanks for your patience!

Best Regards,
Peng Jiang
