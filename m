Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3113E0247
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935180; cv=none; b=HbyjoRLheMWkUftH/WUFkuoz6AWJQYltWdKqvOZU5l3c54nn910gnWIq+DN/arcAOQcsQ7Hkz6bBOoI7F7zgdgz1sTPZTvuP10ivqhiKGn1D5Cyn3/IgV9zwzOLVJDtR36eSMcEarp81/UqsjJrGuWnMQ3IR+eRHscEwF5NmZA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935180; c=relaxed/simple;
	bh=Vf1R+yppKEzBQbnfv9nkce2qdQA1SU29FndglGF4ckQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F5YyN7nFLnd+o2obA18HwyjWraBY4QMspvTaxdPSAGAcGZ4c9NK7zmA9tiyd06rOx1kLMEL/i6yg+yEmDJhuvadoq9Ml+GvwtuBI50R9M/ALNabGibwGk8eJZvdLdlr3u8WlzPOT7ww7KFbyf8WHyhB2Alyn3haf81Jz8HzoNo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yld7gZy2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hmZB4iML; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yld7gZy2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hmZB4iML"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JEJJlr4155694
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 15:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DvNqP241qE8dFBqHq5L6qVz4
	ghSD7knOgVJYfSQ1B58=; b=Yld7gZy2Vwg7aTwn9M0NrrFrVWWy2GG/gLK7dKB6
	3Xxqr/TDd+CZGMnsnJPz/K3Qa/xinQn4bBim6e/SIY2lxHC59LsOg3Ir/Bzop+FN
	nXALqgBdEtgGwTx4hrDwAIgi3E++GbgchA/Tb9JqtNNJE0lGCxQFp70ZN7dnnhpb
	gA2H4CjR3pEBLlK1y3IKFMLVtPdf3IqARQSJUG53twBLZifGbwlK4ijMhGb9hsol
	oPtOLe3EiflHII4K6ErRMacybeKHiy5UDD1BRgXKQBSo5+2t7g6sdf7GTIUnXg7/
	1fuSHqndq50QugXJHsDKcZ6CqP2RsEPQJBrTEF2i7yH6vg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0jt90aax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 15:46:18 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-94ea5c0985fso1523748241.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Mar 2026 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773935177; x=1774539977; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DvNqP241qE8dFBqHq5L6qVz4ghSD7knOgVJYfSQ1B58=;
        b=hmZB4iMLgb1rCmaGPrYpXX3ziT+z664Nsg/VTPmt9oKrDjAD7BP0UuqU5KA3iUK/hz
         fPo5LeNwCASfr4n9/dvOLfISt5Xo0g+XpCjVr8Dd2HtfBmBkaYL+W4Axpf6f/SZ6cD+q
         pnwETaWQciLPYMyAUSF8EeroDHGDB762r+WIvEuKDEo2faUXvYx9kLxG68vre1Wcbxih
         hW5fKg9Gw0vONL8WCNrVhtONZR6HikszTCwyx+5YWK1tLisF6HueEu6ms2UXowVlJHJh
         urwHcdf5qjXU6n/az0vSG69EhoPMojSHPPpRyuCULJltu53eKghK3Iz5cssST9F6m9of
         KaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773935177; x=1774539977;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DvNqP241qE8dFBqHq5L6qVz4ghSD7knOgVJYfSQ1B58=;
        b=eOd+u5v1Y0NR8eT8FWZdr0zlNEpP62mN8usJm6ELa+Ksr34tmkUX1U7fMSeemG1gd5
         cGD9FSxcm7EE5Zb8BscCjmVJT2ic+XKFt4Igp95AlfLRq+DyqYbBGaYLPWtAcJO8d+Z4
         jA9rQ+Wk+0DqKTUswl6m7rcJmhLxJPic8uoHrgx/R6wNe9oYRvnL1dN1CdDW/ZDc9Rfn
         pJRD/5WR/vkzgQx8JvqmJrJBRYuarZnRmrBeUA8YLzx7qQXB3lX7b1miFmoS08onXXlc
         VVsFYEENFuFA20AL1clyHneuS/c1qutX60WwCxz1XXVEFZPooZ/rpQfgmBXA7eyixqLT
         blGw==
X-Forwarded-Encrypted: i=1; AJvYcCW2QJsajVYcyRaYTSiIG5XY66Uonx21oLbvarM+ZGXsbTpTn8q/ge4e2mjmuW1IKqQdWuouAYl3vJuCyyU3HJw7@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfx3a2pdMEvrwQ7DhLDifOxCQglH35Khwu7ULszfhD5u/Kt0uk
	/KQ9ZHSfqjPaTci+wkUu81AveviKWxObLgJtOQyk4JRjBhudf9Z5LmrwEU6LzHbVJVzuzv7tbTf
	aHCfxZqNJkSA/kfOzQzK+ZEdA7TXZrx9czT9dMLj6Yaa2eCTuNGCx9pR2KYPtUWPRuGbQdzr1
X-Gm-Gg: ATEYQzwfbRnui3YTD3opicWo+ZOGhh47tSzcEe2bN/GpLx8Q/oRmLMEnpsmnw5CR/hQ
	j0GL4PuljaYdMAbKYOtwAFbh+JUCplFKxNRq8QKjg3ACRzXPtuAPijztiqF5muxzjwbuvFNRkfv
	kGAX0wrUwQh+IX7Op/d+/Yo/5SfciDx2F8hsu/d81wibLo24EDn4XHqU9mrekwymc+2ZIncMbaX
	XsYmhVQMLontXeGu+sSmoksx+4qQB5UGxtbgTr9fFHe0052TUOlqShkMYoT8pUiIO0/vt8d6riW
	h4KQ4ymBfoxdPlJL9EQ6W9EuVopzLJ1KVq/gKnDv7cUVRo4oA7O75CHBWh5GM8SapXuxnmHGk3O
	bai3iriE4S0PQOvZInkNlApc2GsoGBmcsKVnXDA==
X-Received: by 2002:a05:6102:d89:b0:5ff:9d74:967b with SMTP id ada2fe7eead31-6027d330b13mr3043014137.20.1773935176978;
        Thu, 19 Mar 2026 08:46:16 -0700 (PDT)
X-Received: by 2002:a05:6102:d89:b0:5ff:9d74:967b with SMTP id ada2fe7eead31-6027d330b13mr3042963137.20.1773935176396;
        Thu, 19 Mar 2026 08:46:16 -0700 (PDT)
Received: from localhost ([2a01:4b00:b703:c200:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c40ccbsm129162465e9.9.2026.03.19.08.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 08:46:15 -0700 (PDT)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: Chengwen Feng <fengchengwen@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas
 <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J .
 Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah
 Khan <skhan@linuxfoundation.org>,
        Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Paul Walmsley <pjw@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave
 Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H . Peter
 Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky
 <boris.ostrovsky@oracle.com>,
        Len Brown <lenb@kernel.org>, Sunil V L
 <sunilvl@ventanamicro.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Kees Cook
 <kees@kernel.org>, Yanteng Si <si.yanteng@linux.dev>,
        Sean
 Christopherson <seanjc@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Tom
 Lendacky <thomas.lendacky@amd.com>,
        Thomas Huth <thuth@redhat.com>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Kevin Loughlin
 <kevinloughlin@google.com>,
        Zheyun Shen <szy0127@sjtu.edu.cn>,
        Peter
 Zijlstra <peterz@infradead.org>,
        Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>,
        Xin Li <xin@zytor.com>, "Ahmed S .
 Darwish" <darwi@linutronix.de>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Robin Murphy
 <robin.murphy@arm.com>,
        James Clark <james.clark@linaro.org>,
        Besar
 Wicaksono <bwicaksono@nvidia.com>, Ma Ke <make24@iscas.ac.cn>,
        Wei Huang
 <wei.huang2@amd.com>,
        Andy Gospodarek <andrew.gospodarek@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        <punit.agrawal@oss.qualcomm.com>, <guohanjun@huawei.com>,
        <suzuki.poulose@arm.com>, <ryan.roberts@arm.com>,
        <chenl311@chinatelecom.cn>, <masahiroy@kernel.org>,
        <wangyuquan1236@phytium.com.cn>, <anshuman.khandual@arm.com>,
        <heinrich.schuchardt@canonical.com>, <Eric.VanTassell@amd.com>,
        <wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
        <liuyonglong@huawei.com>, <linux-pci@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
        <linux-riscv@lists.infradead.org>, <xen-devel@lists.xenproject.org>,
        <linux-acpi@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH v9 1/7] arm64/acpi: Add acpi_get_cpu_uid() and switch
 arm_cspmu to use it
In-Reply-To: <20260319065735.45954-2-fengchengwen@huawei.com> (Chengwen Feng's
	message of "Thu, 19 Mar 2026 14:57:29 +0800")
References: <20260319065735.45954-1-fengchengwen@huawei.com>
	<20260319065735.45954-2-fengchengwen@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 19 Mar 2026 15:46:14 +0000
Message-ID: <87341vq0u1.fsf@stealth>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: z4-E-fDJwHPRorOgY8eXktzMa66OwZKB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDEyNCBTYWx0ZWRfX+I94DvesxkJN
 ds0MlscwOd//o4p3XpzNGhhzJJMiH9wdBbqbrF08B92Qshz6BTGJjIBgWE5QrCxn1xaIeP1WosQ
 vEEqtj5HDl2LWz9QsUQq9yxUHaV+9WYjKk4iEWeA5H652J0tPZ8z1HRcRdJMpWC7pObL7K0mvmw
 IricRLPifhI7g74SDjA9uCx63I4FYnlztjUk3OsLd8j8jxwKCWDWW3nQVP2cG91POSKmGLAtGzq
 GScIWwE+AVvTnwUIVF6uIi8XSPt9yeivxzy+Hd/NvpV/uZTz/XXPuLxf0FQ2aSA0+kiPb+CjTbg
 PV6mq/TkZL8/Lvow/txoYDRe/mRpbl+PwzNFAZvm3uMMn8jNQzMaqIedTsod3jrN+Hn5gPKtlxx
 NvU+Kk6a3uRAbNjcBfqQKAhMbAhC33uLsOeCerYDBGjHAie/iRo9nFeZdpyYGYxcQa0goNH5Ghe
 dO6Bio5LhsoMEyuXWZg==
X-Proofpoint-ORIG-GUID: z4-E-fDJwHPRorOgY8eXktzMa66OwZKB
X-Authority-Analysis: v=2.4 cv=FKMWBuos c=1 sm=1 tr=0 ts=69bc1a4a cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=i0EeH86SAAAA:8 a=VwQbUJbxAAAA:8
 a=Gl9ZV0r3yxOOH3mhj0oA:9 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_02,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190124

Chengwen Feng <fengchengwen@huawei.com> writes:

> Add arch-specific acpi_get_cpu_uid() for arm64, and update dependent
> code:
> - Declare acpi_get_cpu_uid() in arch/arm64/include/asm/acpi.h
> - Implement acpi_get_cpu_uid() with input parameter validation
> - Replace get_acpi_id_for_cpu() with acpi_get_cpu_uid() in
>   drivers/perf/arm_cspmu/arm_cspmu.c
> - Reimplement get_cpu_for_acpi_id() based on acpi_get_cpu_uid() (to
>   align with new interface) and move its implementation next to
>   acpi_get_cpu_uid()

There is no benefit in describing the code changes like this in the
commit log. It makes it hard to follow the intent of the patch.

> This is the first step towards unifying ACPI CPU UID retrieval interface
> across architectures, while adding input validation for robustness.

I would simplify the commit log to something along the lines of -

    As a step towards unifying the interface for retrieving ACPI CPU uid
    across architectures, introduce a new function
    acpi_get_cpu_uid(). While at it, also add input validation to make
    the code more robust.

Just my 2c.

The code changes looks fine.

> Cc: stable@vger.kernel.org
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> ---
>  arch/arm64/include/asm/acpi.h      | 14 ++------------
>  arch/arm64/kernel/acpi.c           | 30 ++++++++++++++++++++++++++++++
>  drivers/perf/arm_cspmu/arm_cspmu.c |  6 ++++--
>  3 files changed, 36 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index c07a58b96329..2219a3301e72 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -118,18 +118,8 @@ static inline u32 get_acpi_id_for_cpu(unsigned int cpu)
>  {
>  	return	acpi_cpu_get_madt_gicc(cpu)->uid;
>  }
> -
> -static inline int get_cpu_for_acpi_id(u32 uid)
> -{
> -	int cpu;
> -
> -	for (cpu = 0; cpu < nr_cpu_ids; cpu++)
> -		if (acpi_cpu_get_madt_gicc(cpu) &&
> -		    uid == get_acpi_id_for_cpu(cpu))
> -			return cpu;
> -
> -	return -EINVAL;
> -}
> +int acpi_get_cpu_uid(unsigned int cpu, u32 *uid);
> +int get_cpu_for_acpi_id(u32 uid);
>  
>  static inline void arch_fix_phys_package_id(int num, u32 slot) { }
>  void __init acpi_init_cpus(void);
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index af90128cfed5..24b9d934be54 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -458,3 +458,33 @@ int acpi_unmap_cpu(int cpu)
>  }
>  EXPORT_SYMBOL(acpi_unmap_cpu);
>  #endif /* CONFIG_ACPI_HOTPLUG_CPU */
> +
> +int acpi_get_cpu_uid(unsigned int cpu, u32 *uid)
> +{
> +	struct acpi_madt_generic_interrupt *gicc;
> +
> +	if (cpu >= nr_cpu_ids)
> +		return -EINVAL;
> +
> +	gicc = acpi_cpu_get_madt_gicc(cpu);
> +	if (!gicc)
> +		return -ENODEV;
> +
> +	*uid = gicc->uid;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(acpi_get_cpu_uid);
> +
> +int get_cpu_for_acpi_id(u32 uid)
> +{
> +	u32 cpu_uid;
> +	int ret;
> +
> +	for (int cpu = 0; cpu < nr_cpu_ids; cpu++) {
> +		ret = acpi_get_cpu_uid(cpu, &cpu_uid);
> +		if (ret == 0 && uid == cpu_uid)
> +			return cpu;
> +	}
> +
> +	return -EINVAL;
> +}
> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
> index 34430b68f602..ed72c3d1f796 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
> @@ -1107,15 +1107,17 @@ static int arm_cspmu_acpi_get_cpus(struct arm_cspmu *cspmu)
>  {
>  	struct acpi_apmt_node *apmt_node;
>  	int affinity_flag;
> +	u32 cpu_uid;
>  	int cpu;
> +	int ret;
>  
>  	apmt_node = arm_cspmu_apmt_node(cspmu->dev);
>  	affinity_flag = apmt_node->flags & ACPI_APMT_FLAGS_AFFINITY;
>  
>  	if (affinity_flag == ACPI_APMT_FLAGS_AFFINITY_PROC) {
>  		for_each_possible_cpu(cpu) {
> -			if (apmt_node->proc_affinity ==
> -			    get_acpi_id_for_cpu(cpu)) {
> +			ret = acpi_get_cpu_uid(cpu, &cpu_uid);
> +			if (ret == 0 && apmt_node->proc_affinity == cpu_uid) {
>  				cpumask_set_cpu(cpu, &cspmu->associated_cpus);
>  				break;
>  			}

I think cspmu changes go via a separate pull request. You might have to
split this change into a separate commit.
