Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC66278F4A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 May 2025 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747905218; cv=none; b=n60Sf59rOg+K3fRrE7SWYLFW2RMDN+OFAZgQ47po0YErVZi3/fJtwEg/F2LqH0wwU2jVXXBWdVsekUlq4CpG4gJuMRjpD9+9Crt7YslOzNiQR/5sGsPq/TPZpp8GF4fkb6B5ZJuU8czUCtnrFwSLP+QX8xaFFX71GIwP2qlmNG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747905218; c=relaxed/simple;
	bh=ev/Am6ND0BI8bjII39cdu08kvLE3RLqkuXGKiIvUNx4=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=knE82LB320hn5ofzT6cnCKTCKYnsflcepwmsK6IX9kFVQQW65Ykf/gYuySECCqcYa+lAcmwkSkwf8yD7WHxOTNdkPel6a3aLkGH88eG69zvAlmYQ1F63I1vwJaX9rKCUbsvXDzi2/WdP80eFZ9j/HxvN2X090Drw4gyNjXHIim8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4b32fc2DcVz27hvX;
	Thu, 22 May 2025 17:14:16 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 7495F1A016C;
	Thu, 22 May 2025 17:13:27 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 May 2025 17:13:27 +0800
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 22 May 2025 17:13:26 +0800
CC: <acme@kernel.org>, <namhyung@kernel.org>, <peterz@infradead.org>,
	<mingo@redhat.com>, <mark.rutland@arm.com>, <jolsa@kernel.org>,
	<john.g.garry@oracle.com>, <james.clark@linaro.org>, <leo.yan@linux.dev>,
	<irogers@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <yangyicong@hisilicon.com>,
	<jonathan.cameron@huawei.com>, <hejunhao3@huawei.com>, <linuxarm@huawei.com>,
	<wangyushan12@huawei.com>, <caijingtao@huawei.com>, <xueshan2@huawei.com>,
	<prime.zeng@hisilicon.com>
Subject: Re: [PATCH v2 1/3] arm64: cputype: Add cputype definition for HIP12
To: <catalin.marinas@arm.com>, <will@kernel.org>
References: <20250425033845.57671-1-yangyicong@huawei.com>
 <20250425033845.57671-2-yangyicong@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <557c852c-3c21-130f-c096-2d09052e04ef@huawei.com>
Date: Thu, 22 May 2025 17:13:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250425033845.57671-2-yangyicong@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq200018.china.huawei.com (7.202.195.108)

Hi Catalin and Will,

would you mind taking this kernel change? we'll add this in the userspace tools' cputype.h and this
patch is aimed to synchronize the update in the kernel.

Thanks.

On 2025/4/25 11:38, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Add MIDR encoding for HiSilicon HIP12 which is used on HiSilicon
> HIP12 SoCs.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  arch/arm64/include/asm/cputype.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
> index d1cc0571798b..36c5bbfbb6e9 100644
> --- a/arch/arm64/include/asm/cputype.h
> +++ b/arch/arm64/include/asm/cputype.h
> @@ -133,6 +133,7 @@
>  
>  #define HISI_CPU_PART_TSV110		0xD01
>  #define HISI_CPU_PART_HIP09			0xD02
> +#define HISI_CPU_PART_HIP12		0xD06
>  
>  #define APPLE_CPU_PART_M1_ICESTORM	0x022
>  #define APPLE_CPU_PART_M1_FIRESTORM	0x023
> @@ -220,6 +221,7 @@
>  #define MIDR_FUJITSU_A64FX MIDR_CPU_MODEL(ARM_CPU_IMP_FUJITSU, FUJITSU_CPU_PART_A64FX)
>  #define MIDR_HISI_TSV110 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_TSV110)
>  #define MIDR_HISI_HIP09 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP09)
> +#define MIDR_HISI_HIP12 MIDR_CPU_MODEL(ARM_CPU_IMP_HISI, HISI_CPU_PART_HIP12)
>  #define MIDR_APPLE_M1_ICESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM)
>  #define MIDR_APPLE_M1_FIRESTORM MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_FIRESTORM)
>  #define MIDR_APPLE_M1_ICESTORM_PRO MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M1_ICESTORM_PRO)
> 
