Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301053F39F1;
	Fri,  9 Oct 2026 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535764; cv=none; b=qyv1rUn2vsRNp8w/cbIpQNNf65w1t3Twx2rM6VZBFL0q+vbS/F0//8SJ0DMMCGgxJUVZeQyj9B9HLOudUf3YnZqmyRKAlAuhYiCUtOmrKcKupXXfYhRGetbKAY7fWF17DSW/L39i3Wp4mvUIr8a0qdVk4YsHb4Y09I594QuGGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535764; c=relaxed/simple;
	bh=1XGz+osF98bJ65rLePu/ISyhWyU41/o9flRX04pLmm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBZDmFSP3dsk+ogt4zN+okRQm2NcbVkdnSt01QlQFhjMgx1BvLkLtRhH7Y0N3SMD5vQGEbSlMIeoE8MgleVykLGnt6WK9i/bhNjsHFGgUtbb/p9TSliXgBIHWtGbmv0UAo+EqEi6me9EmwtyTT1B/DESYQa8LxBO2Io1xKh7iMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00448550d0471e54ea.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:4485:50d0:471e:54ea])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0F1B41C77A4;
	Fri,  9 Oct 2026 10:49:20 +0200 (CEST)
Date: Fri, 9 Oct 2026 10:49:18 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Zong Li <zong.li@sifive.com>
Cc: tomasz.jeznach@linux.dev, will@kernel.org, robin.murphy@arm.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	mark.rutland@arm.com, andrew.jones@oss.qualcomm.com, guoren@kernel.org, 
	david.laight.linux@gmail.com, zhangzhanpeng.jasper@bytedance.com, yang.yicong@picoheart.com, 
	nutty.liu@hotmail.com, iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Chen Pei <cp0613@linux.alibaba.com>, Fangyu Yu <fangyu.yu@linux.alibaba.com>, 
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH v15 2/2] iommu/riscv: create a auxiliary device for HPM
Message-ID: <asiqePAyXAWkaeMq@8bytes.org>
References: <20261002063315.1535817-1-zong.li@sifive.com>
 <20261002063315.1535817-3-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002063315.1535817-3-zong.li@sifive.com>

On Thu, Oct 01, 2026 at 11:33:12PM -0700, Zong Li wrote:
> Create an auxiliary device for HPM when the IOMMU supports a
> hardware performance monitor.
> 
> Tested-by: Chen Pei <cp0613@linux.alibaba.com>
> Tested-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Yicong Yang <yang.yicong@picoheart.com>
> Suggested-by: Samuel Holland <samuel.holland@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/iommu/riscv/Kconfig |  1 +
>  drivers/iommu/riscv/iommu.c | 58 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/riscv/iommu.h |  4 +++
>  3 files changed, 63 insertions(+)

Acked-by: Joerg Roedel <joerg.roedel@amd.com>

