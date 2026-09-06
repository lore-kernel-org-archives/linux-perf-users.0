Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A745B38330C;
	Sun,  6 Sep 2026 06:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788676008; cv=none; b=Q56kQSEC4XLWoRJ2LKqbmtUEklbFcNAohyTXGXj8rgnfJHjSP8NegLP6lwTAApyxWudByB6k2ZrJke9xFWHF8UPOBt1PSjRuCXEbQmj5Htc4RsANKmC2QmDIJHSExAcIe/vBGPnfsUTerGPMTr5+EuKbbuPbRNdCJ5DNfbwEofk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788676008; c=relaxed/simple;
	bh=jFC158bFI4pnWt+E7OuCn5C6s2SK6YF457AC9MhK6Oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0OmAOqj5QNCbXqlpWWnNCP5diNDXKbjOzNauKJPQsK0MPZybCDPshaOGwYRdh65iBp9bgf0W6J6tbcPgPDSqw48WTF2dIjDbO+bkrYylHm4xjhsnEXMC2VMVN/HwY0noIGse58Q4viG03om1d5SaNG6Q3XUujxDQJmj0G7RdGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Pl996pWE; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Pl996pWE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788676000; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0Wz5Z6umuTpfHzEWQwcRpdbEj4l7TnAg8LFKGkSkVxQ=;
	b=Pl996pWEYXaniWNkWm0Ztf3eL9SkZVcMNGZQmuK+bp7A4q8OUL01DzylLf9eA/1yCk6bUtp8c8YhZTYfkjsjtMW75A3dJxlVc0O83bQ3CHDHCZlAVVFMD3CKDZamCjk+RXnyBFRTMsbodz3HFCCUXUPEfVkRqzPfZYPiFk4Zqd8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0XAMUagL_1788675998;
Received: from 30.100.134.114(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XAMUagL_1788675998 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 06 Sep 2026 14:26:39 +0800
Message-ID: <8cd50103-6e7c-4389-b29a-da159b7e62fb@linux.alibaba.com>
Date: Sun, 6 Sep 2026 14:26:38 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf: fix typo "binded" in comment
To: Hemanth Selam <hemanth.selam@gmail.com>,
 Jing Zhang <renyu.zj@linux.alibaba.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org
References: <20260904123541.38602-1-hemanth.selam@gmail.com>
 <20260904123541.38602-3-hemanth.selam@gmail.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260904123541.38602-3-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/4/26 8:35 PM, Hemanth Selam wrote:
> Correct "binded" to "bound", reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>   drivers/perf/dwc_pcie_pmu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 6b9ed59de26e..e2435ccc04ca 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -639,7 +639,7 @@ static void dwc_pcie_pmu_remove_cpuhp_instance(void *hotplug_node)
>   }
>   
>   /*
> - * Find the binded DES capability device info of a PCI device.
> + * Find the bound DES capability device info of a PCI device.
>    * @pdev: The PCI device.
>    */
>   static struct dwc_pcie_dev_info *dwc_pcie_find_dev_info(struct pci_dev *pdev)

LGTM.

Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
