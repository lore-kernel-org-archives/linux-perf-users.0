Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9606036215E;
	Thu, 20 Aug 2026 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237024; cv=none; b=F/XqPZbeVIPxSs8FqIMvO/rpRin3GQoBYx2XKx507WwU3JhC/lORr/tJZ0Axqc4aBzfqpseZIY8zUNe6o097emJoQoMHqIIFJKDkCAVo1r4WiEP7tZYuAO804ZbtPBKccPel8CbpJF5ClwtPF0Ac81maGSj6yWfXiQ+AmOVHO2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237024; c=relaxed/simple;
	bh=Or0fP+yZmJshI71hcpIhcuLYAoAKGeNOEYymUdU8YdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G3V0FIdAq/Hslb8xVxDgzhAHSSNFJc+RfixKaKR9DqbmV3hN5pnMZNcB104Vi9xsisdAKTAJCZ4xtCAH/Ula6bBFEvi17TaqlU4YRvQzsk7xyjjwFz6E7W5w1Wx+XHRmXZMEHRSePuo7+LEmd7/z/zSh5YEeq30V+7k7ElsmNcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=r9O/FUqL; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="r9O/FUqL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787237019; x=1787841819; i=markus.elfring@web.de;
	bh=Or0fP+yZmJshI71hcpIhcuLYAoAKGeNOEYymUdU8YdA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=r9O/FUqLM7HSCa8uaQP9Jz8/1EmxASq89B+69GdjX7AzjxSWlenYsFp3s5uhehRU
	 rNwxoeCqCdOLRmxZNvOObbRl90v+0Nrqi1Zo4s/odVaegx+vRgrXutrsO4rPhNVUb
	 0kNQOTK9MrRdnSMpkzIqP/NtoNUrlfsGo1nLkhYleEEdrT2WqHAJhYejYiEirKktm
	 k9mtzDa/ar67ho5LwXToVsXkkT9bH1yRhMVo+MzZQmtYcVVZvlyFexM5tXdfuYGZL
	 AR/6Y+FMOSMRi1Sd5NLQZhKDkZ9fvPdV2YVeW84ZrafczpSzF3EyLhPra0jMTUmHI
	 Mpb80C3ujtJBtMF/bA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mq182-1wafPN26uQ-00b9D3; Thu, 20
 Aug 2026 16:43:39 +0200
Message-ID: <2f6036e6-4dbe-44ae-8d59-f1f577516759@web.de>
Date: Thu, 20 Aug 2026 16:43:37 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] perf/dwc_pcie: Fix PCI device reference leak in probe
To: Ruoyu Wang <ruoyuw560@gmail.com>, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Jing Zhang <renyu.zj@linux.alibaba.com>,
 Mark Rutland <mark.rutland@arm.com>, Shuai Xue <xueshuai@linux.alibaba.com>,
 Will Deacon <will@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20260820135611.3901886-1-ruoyuw560@gmail.com>
 <87126df0-d332-48e7-b128-a96d6a8330d8@web.de>
 <CAK_7xqwRdXEe63YoMNE5KtLKA3+Nx=qVYj_mqfJmTVjb2-f-cQ@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAK_7xqwRdXEe63YoMNE5KtLKA3+Nx=qVYj_mqfJmTVjb2-f-cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:XS9DepS75hhWKiVJ29UJMV65SQ72Qe+eBcQ6TdAPzbGDHAJLfhZ
 qf2VwLvwEeypzsKTzOxUywObBCueHRgMsJX1ZFhCRFsnE0HD1kTFFUOltccEGFmYHepO40Q
 Ddj2t0xBZjZSq/3pI2NG0TomLRPoU79guVckrkZSssCiRlR9g+024M4zfqeljZQPVbEl6k8
 MsRgM1Ou7KoB4JfSJHeHA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QMwLQUTTFW0=;EC9W0t67vJkjWDdTf8K/CSozrWx
 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

> I think keeping the function scope is clearer here :)

I got an other impression because a pci_dev_put(pdev) call was applied
before a devm_kasprintf() call.
https://elixir.bootlin.com/linux/v7.2/source/drivers/perf/dwc_pcie_pmu.c#L695-L717

Regards,
Markus
