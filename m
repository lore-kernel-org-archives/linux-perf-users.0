Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7751C3BEA;
	Thu, 17 Apr 2025 03:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744859663; cv=none; b=BO+/r1MVuLLAp9WhRHJzZAOqldQuYI4Ioalcq1oT3ZYZhU/ujR4SP9Iug2JwmZMZ6b9dNqc+2R9NkKenXzHe5VtxHeDFWt+WNBgB14B53l/k+r/8KYx15p2GEPA3sDOrzu3a5S+DL0k/2SkX/rGDH1n4OkoT+lHKq8BKpnGb26g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744859663; c=relaxed/simple;
	bh=78bibA9WspYjyoZFCpnvOqZTjA07ifbiwONYfmSl8Hw=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=newpzB2/jFiDBhESuIolPusK+HQoHf9Wz6BX5CivNSRAQxTbKRaJ2qyRKciGX1q8s2nZxBFgNMstdU3Zi4jzsyy76as9kaapyO1C9L1lXu9Mn348ByF7QeO1C/+nQlKEt4hUZ1RBwQXfu2rkLLzbr5GjwaoA6l7WpN9IeSNI2VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZdNKJ5nL4z51SYH;
	Thu, 17 Apr 2025 11:14:12 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 53H3DeUf046182;
	Thu, 17 Apr 2025 11:13:40 +0800 (+08)
	(envelope-from jiang.peng9@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid31;
	Thu, 17 Apr 2025 11:13:41 +0800 (CST)
Date: Thu, 17 Apr 2025 11:13:41 +0800 (CST)
X-Zmail-TransId: 2afa680071e5ffffffffbac-125fa
X-Mailer: Zmail v1.0
Message-ID: <20250417111341972ZbivQxD5vcH60fSMbGYbQ@zte.com.cn>
In-Reply-To: <aABrSclgXsyzGo_g@x1>
References: 40981d32-72f4-4935-a62c-444ad78ce336@linux.ibm.com,20250417100118733FrbRcKrZFI5AZsN2G6nyr@zte.com.cn,aABrSclgXsyzGo_g@x1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.peng9@zte.com.cn>
To: <acme@kernel.org>
Cc: <venkat88@linux.ibm.com>, <atrajeev@linux.ibm.com>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <maddy@linux.ibm.com>,
        <mingo@kernel.org>, <linux-kernel@vger.kernel.org>,
        <shao.mingyin@zte.com.cn>, <tglx@linutronix.de>
Subject: =?UTF-8?B?UmU6IFttYWlubGluZV10b29scy9wZXJmIGJ1aWxkIHdhcm5pbmdz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 53H3DeUf046182
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 68007204.004/4ZdNKJ5nL4z51SYH

> Hey, please take a look at:
>
> tools/include/uapi/README
>
> More importantly this paragraph:
>
> "So its important not to touch the copies in tools/ when doing changes in
> the original kernel headers, that will be done later, when
> check-headers.sh inform about the change to the perf tools hackers."

Hi Arnaldo,

Thanks for pointing that out. I'll make sure to follow the instructions in tools/include/uapi/README and avoid modifying the copies in tools/ directly. 

Appreciate your guidance!

Best Regards,
Peng Jiang
