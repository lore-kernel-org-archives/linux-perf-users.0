Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FD62F8E98;
	Thu, 24 Sep 2026 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251645; cv=none; b=amcJpXfm/O2/M9f1cg3qz+xwJ+/RZdS11XcV/67BgVBch551+CvAygf4t4IRYLIBLPh8p4p2dLyhnjgxTLHSJ5NsfDVn+YhseSijyf8p2AXjD69XKqNtJc2YdF9PtdELjDDVC733hc8kH2xKGQ5QFLXs3rScKR1KC15MSa5I1wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251645; c=relaxed/simple;
	bh=l072ByEYlR0iBw9JPDkxPn6SxCDk5R6m2eIoPBvCiN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nffCg6mcUgMolCMfpPeW6NJtFEx2xQxy7kcVdugy8rJ1q19RU9YrW6282MyP1BQmYh7k8M2NMnxB0U+wwrl9vZekUnXbQRVe0ewmxkHg4ZyeX5z1TmH7qn3EPkjVhKlYZ6MW06Z0xM/JXKu2DaslTzxCKnmwVLGfMg4B88se6Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1E6AE1C7465;
	Thu, 24 Sep 2026 14:07:21 +0200 (CEST)
Date: Thu, 24 Sep 2026 14:07:19 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Zong Li <zong.li@sifive.com>
Cc: tomasz.jeznach@linux.dev, will@kernel.org, robin.murphy@arm.com, 
	pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	mark.rutland@arm.com, andrew.jones@oss.qualcomm.com, guoren@kernel.org, 
	david.laight.linux@gmail.com, zhangzhanpeng.jasper@bytedance.com, yang.yicong@picoheart.com, 
	nutty.liu@hotmail.com, iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v14 0/2] RISC-V IOMMU HPM support
Message-ID: <arUSRcgzWurL-YrL@8bytes.org>
References: <20260924100106.2054127-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924100106.2054127-1-zong.li@sifive.com>

On Thu, Sep 24, 2026 at 03:01:03AM -0700, Zong Li wrote:
> This series implements support for the RISC-V IOMMU hardware performance
> monitor.

Do you have a link to the specification of the HPM (and additionally the IOMMU
itself)?

