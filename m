Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF353403F8;
	Fri, 21 Aug 2026 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787295664; cv=none; b=tKXuTCezgR4+vvWbWZ/QoysH1JYulJ6IfsHAzLzeY6miFDQCagBULgAsgPitPlKSJ8pRrzmkWzDzJR12A4fI1tVppI1aW51qVlNcHWqqc16Ouk3SJGw8AiuU8ZDEft176Uzoeyb1AfUya5CzIpiwmoShNfNwIgOg9Nnuqagj4W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787295664; c=relaxed/simple;
	bh=5cYvjE/42x+6hdxmdIb3aJBi31Y9LFsN37WCWxDUwVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FiZI138qiMJ+s6jcOfMajQsOGPDDPwgHbHKKNCD2obn2ZM6M319tuLB9wfTANBtu7wNY2o20wimdAKpQ7SRgUcS8DlxC7tQvFlpEBFnurc0mK8356qpyasGLXisfjg3RnkzTlxl1xPjRXM/BXB4Z2yRdao+9XmznQQ43H40/Lnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=OkG2Js2X; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="OkG2Js2X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787295649; x=1787900449; i=markus.elfring@web.de;
	bh=5cYvjE/42x+6hdxmdIb3aJBi31Y9LFsN37WCWxDUwVI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OkG2Js2X7tBXmRjGU4TWZon/NM2dcBqmXu1Cjndj6PB3DZqDfgdhYnrFtaOjkRVM
	 W4Wyl+P57cekOVjxpuOEBONjuwvRCQGenEEBvQYoeqsVu3X1a/jCCua3+d50IVOZK
	 4dgBEP/E2WQe+gf+ZGd+abPH0AbysbWRtqjJDCv4zTjU+KZZT1KYgmTy1Y2eB5cML
	 81vvc2S6JvTlrOn4Iy9w3isjC7Dc79jENLU/uhRBCT4q7k9rbVRlB/JS0lulSqPmE
	 UVErH+nGQqxB0QJX2B06yBeK85XlnGwWF4QSytO5SgiSd6FFoKRMDyWqQgREKtwPn
	 BbiAkIAj2meI4Vm81A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1My6pZ-1wkA9O0RUl-00tr0p; Fri, 21
 Aug 2026 09:00:49 +0200
Message-ID: <3b071e20-d360-4f93-9570-8339d1916ee1@web.de>
Date: Fri, 21 Aug 2026 09:00:38 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/dwc_pcie: Fix PCI device reference leak in probe
To: Ruoyu Wang <ruoyuw560@gmail.com>, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jing Zhang
 <renyu.zj@linux.alibaba.com>, Mark Rutland <mark.rutland@arm.com>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Will Deacon <will@kernel.org>,
 Yunhui Cui <cuiyunhui@bytedance.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20260820135611.3901886-1-ruoyuw560@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260820135611.3901886-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k1RPvCPuyjQMjYRbvxdEnIsCE4rNQpn9FeLduZnIsu/mk2vc96t
 EcT4/q6Kv62j0dtsD+YJuKa4QsSDvfkcV6dupDxc3B4JcTXX5YwbufwWPu/ByiJ9OTT9lcF
 tluVvQrATQBsjGyA/JGZ3MaKBfBjfShCr8RFYx1tJYg2wjAWbWXietiXtQtHe9lfVXw+B9S
 y8rhrQ/GRFj4WPB/taouA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tbhmjbKIJbE=;56rc5WQO1vQCA5I2E+NOZ4reYSd
 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

> This issue was found by a static analysis checker and confirmed by manua=
l
> source review.

Can such a source code analysis approach point any related development con=
cerns out
also according to a pci_dev_put(pdev) call in the =E2=80=9Cmiddle=E2=80=9D=
 of the discussed control flow?
https://elixir.bootlin.com/linux/v7.2/source/drivers/perf/dwc_pcie_pmu.c#L=
695-L770

Regards,
Markus
