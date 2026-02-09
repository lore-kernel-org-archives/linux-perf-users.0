Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB0A257855;
	Mon,  9 Feb 2026 01:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770601316; cv=none; b=qIrFhRiu5x5Jzvmat54aJz+mViGFd80ZvFtS+1wqhySG7iJWkRWLF8H4HoPQMV4jLH9285MffaPBAI8mKAUlHRvIHAUMyq8dE87A6D91aa6epHDpjDlJEnVidFYZH7yfTFictYU4nBEXhn+pXhmt/IL+5mqf6N3E7LS6OptV9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770601316; c=relaxed/simple;
	bh=fq0+sgLvoHAmySSuL1KwqA52RlDiwWzflVq1Wzg1Ueo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f7me3NLHCnbhmU4Zua73qKYDeo/g6uZ8GhM9+CpuuNlCWRlQlsiw7Vgp9DyV93SEAYi5CoBK+kFGSeOreG/y/L+4/NScr9dEe7WX4Fs+yQCcopL612m5hsnpFeeZCbocHkObHrjknbm5a68foyra+6BnpNCHEjYIUt/TOs1nq6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=ZZJp0z2y; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="ZZJp0z2y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770601229;
	bh=gnfNs4/9cLlWmPGt8Fa1E39h7Z4Yp+IEQtuArbh/oqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ZZJp0z2yzDEeEdOXnqdxjTD3iMToP9mi8dRcb7hck3kQ7PzyTqssDx/3+5iGK4PTN
	 7LOSRxdPDeZV+jjUjyCjOeESD5oge0tVOEDXyilSjAjXfcYU51oc45aSn6FrLcprtO
	 K0Tx/9ugHJjcX7nCHBvUDuBvkXCKJKcaeppGWy7I=
X-QQ-mid: zesmtpip2t1770601227t5789b7a5
X-QQ-Originating-IP: Fgum11MpPBfMD+2TeTN+QJgyfNJ/OPyr9gudRkHI6cU=
Received: from [IPV6:2409:8a1e:3015:50f0:24fb: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 09 Feb 2026 09:40:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10450036312532359646
Message-ID: <D8C71AE40393A6FD+89365591-f896-4609-8b0f-8dffe85b5828@linux.spacemit.com>
Date: Mon, 9 Feb 2026 09:40:24 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] RISC-V IOMMU HPM support
To: Zong Li <zong.li@sifive.com>, tjeznach@rivosinc.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, robh@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 mark.rutland@arm.com, conor+dt@kernel.org, krzk@kernel.org,
 guoyaxing@bosc.ac.cn, luxu.kernel@bytedance.com,
 andrew.jones@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-perf-users@vger.kernel.org
References: <20260208063848.3547817-1-zong.li@sifive.com>
Content-Language: en-US
From: Lv Zheng <lv.zheng@linux.spacemit.com>
In-Reply-To: <20260208063848.3547817-1-zong.li@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NhdiEwnVOUqE7/ZiXFyay4uZd7dt6upjd5Apw3lr1qC2Vb9gX2pHLkpw
	xM87noh5AaVuyCoreKbC5uZPjCv5dRV/gVNnE0dOSP0WX2mfLjdkDnMZMa/DRT7n3SBEk6r
	0wz5/uKyVVIsvuX1bfFPd2POVL9CRaxO1qrep2hrrv7go/48boEgODmVs+TbJ/8PqJFpxwx
	bzH3oAtq7T26N/bE5wLRFhGfpW1bgnjxo4pTrku8TKCEQjyT//4t6ftJ4A1YOB4lbbkJW+5
	du6ZghNw7c/DdkR3LmoP+Wjp8bETue5bi+8mdleV1Ui/6f3iamG8nNgJVQSWLaKkPizdc3W
	YxKMoiXeWMTJk9eZHqdiJiFJPvaB7PElR08MVZjIhzmPhXmiH8HYnH6mmHmstLAfcTcjRj6
	NvwxA+zEj5jHxfx0vERa9CqrXjOrpEF7Sdt6+z6nFS+hLaA3QgU2H0L1kXIRlaKhiPEYhAJ
	a52NToUFyQqomifL88sUoZ8SC4QhSIo6wdEOlifpUeGLbs6++zQtqW85sKfcqQlzIvQ1ay2
	ZLUoqh4n/tMmwtvR7GWYz1qRxnY1tQRfkseroiBorgKjWjxgR5vQAfFt8Vp7D3uisHTTpYK
	zOKdwGLIbfpVXtzQALiVrf/3vv0t9OLTcK1e00P3N3ytaWXqXxdVfwd4z6GDgOo3qtgB40O
	XAuwwJyP8g7XjgaBYJEzBMRnc7zNY2bQPo6NIeUyexHREqN6Ow9xdUNPq/FOkpRNkL7lD5u
	k5fltsaZBIexczPepCesBP0BoYHIo3AF3fIi262E9Z4OicWcGGOO6RUERD+nRcD5QAkZN8k
	u8fELiS4SrSap7/7hVOJGIt4LNHWQtn0CaT1wF9LBIOSRy5eWEAAXjXG9XJXShm2Fuc4qS3
	rEA/RzyKgnZKSTZ3NmB18jbJVD9Tojrh9pEZzVZPAHiKSXdk92PunPhdExltAOM6h0aEL2F
	/V7nDYQ/S+o7iZNh7d4u1ZBoQu1lz1M5agXHSDIFxG3X6DJjNr7rYzb5FlkSg7+69Nz9l4L
	aFwDnS52aih+GdnUeK6CFfclHX2xF2ST9UPJYuEw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

On 2/8/2026 2:38 PM, Zong Li wrote:
> This series implements support for the RISC-V IOMMU hardware performance
> monitor.
> 
> The RISC-V IOMMU PMU driver is implemented as an auxiliary device driver
> created by the parent RISC-V IOMMU driver. The child driver can obtain
> resources and information from the parent device, such as the MMIO base
> address and IRQ number.
> 
> Custom event support is not included in this series and will be submitted
> as a separate series. The idea is that custom events will be defined
> through the driver data of the auxiliary driver. When the parent IOMMU
> driver creates the auxiliary device, it should pass a vendor-specific
> name as the device name in order to match the corresponding auxiliary
> device ID.
> 
> After my initial RFC and the v1 patch series were posted, similar patch
> series also appeared on the mailing list.
> 
> One was from Yaxing Guo:
> https://lore.kernel.org/all/20250915020911.1313-1-guoyaxing@bosc.ac.cn/
> 
> and another from Lv Zheng:
> https://lore.kernel.org/all/30C7AD351DB55276+a8b03dac-c5af-4034-8631-ac1c352a469f@linux.spacemit.com/

Please do not forget to Cc:
Jingyu Li <joey.li@spacemit.com>
I only provided T100 specific support in the posted series, and the
new approach of the HPM driver in the same series is composed by her.

> 
> Yaxing has agreed to pause his series, as discussed here:
> https://lore.kernel.org/linux-iommu/2ce9d8be-10b3-48dd-b99e-7358347fc171@bosc.ac.cn/
> 
> The motivation for sending this v2 version is not only to address the
> feedback and suggestions from the previous round, but also to introduce
> a major structural change: the PMU driver has been moved under
> drivers/perf/, which has been mentioned repeatedly by several people.
> This results in a different driver structure compared to my earlier
> version and the other two series, and I'd like to gather feedback and
> suggestions from the community on this approach. If the community would
> prefer to go with Lv Zheng’s version instead, I am perfectly fine with
> that as well.

We'd like to know if there's any comments related to putting IOMMU HPM
driver into drivers/perf folder and want to know if this is necessary.
We also hesitated if riscv iommu hpm should be put into drivers/perf,
and according to the followings, we finally decided to keep it in
drivers/iommu:
1. drivers/iommu has already a folder maintaining all IOMMU stuffs.
2. drivers/iommu has already defined HPM related registers.
3. Unlike PMCG of SMMU which is located in a separate namespace, RISC-V
    IOMMU only defines 5 registers in the same address space as its
    translation schemes.
4. For HPM schemes that is not a standalone device, Intel has put its
    perf driver under drivers/iommu/intel/perfmon.c.

Cheers,
Lv


