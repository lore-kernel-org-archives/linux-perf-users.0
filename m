Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED00F3FD131;
	Thu, 26 Mar 2026 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539265; cv=none; b=FWl/xv+GFIm9WYrIGkNfEq3mtHY93wq3oGz5wZ524ydbIm/z8udaDU0QV6Tpnn9eUj1JYWWpR3nUkr5QuL4H+cBdOqUtyoeflBFsjojVzPtsG2KTocSTirZr4VvdTA0ykY/BvgUDrKMa9+EZYgHA/hx+mSEI9z4Ro5eLo/gGi64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539265; c=relaxed/simple;
	bh=IrSTSwtXxNH2DPkeoZs8kWgLSaGqE2Fv+K1G1lXYqZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UumUXLJ61E+hen6Lo6uE3CjPtPaszAwzbw956GR6jWZV9Ac3C2AqOn4sGPMtpb1RE2SGeScS/Dj4bQEvsoAnaMZ2Ify5+lG3V+QXO8WhzCDzUHZw1hMLiIp8QFIGdRI1IytzbRAweouYh1ET8hus/CRMv8KM3UVFvvNsluH3wxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2MdEmGY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2MdEmGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716CBC116C6;
	Thu, 26 Mar 2026 15:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774539264;
	bh=IrSTSwtXxNH2DPkeoZs8kWgLSaGqE2Fv+K1G1lXYqZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B2MdEmGY8wFKS/vnb738PuVKn1ppgaUqB/Fowhzi1yAkJtdQ4EI/KD/yAnR22VPqZ
	 jPpdm/OHprXI5Yy6qK+4AWsFdkUdQ2qBEDKHjz31UyAIuRKyFX17xysfedMzDNFO5O
	 b/5xslJ+M5SV+RApsfmQJHQcGrNQCSuxjKWGlgoBhslHUTVv+DjMe9oZHgiYXz0ar1
	 ZwxIWS5WogAwT3l+MqyS5qQ1x2e9yW/UBgA/UfV2eOpBgewnS9RLNvtW5ttuQP+aEi
	 ZcFyPwM7buM3LENBEjL/tKLorL/vEeOiifHd0t4ImyDDL/2oKpkXR+/4elcnb6/Bac
	 Pco1JxxeXJLcA==
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Nathan Chancellor <nathan@kernel.org>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Fix resource_size_t printk specifier in arm_cmn_init_dtc()
Date: Thu, 26 Mar 2026 15:34:15 +0000
Message-ID: <177453872199.567997.503753073728296417.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325-perf-arm-cmn-fix-resource_size_t-format-v1-1-e84d52ee3e81@kernel.org>
References: <20260325-perf-arm-cmn-fix-resource_size_t-format-v1-1-e84d52ee3e81@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 25 Mar 2026 19:19:26 -0700, Nathan Chancellor wrote:
> When building for 32-bit ARM, there is a warning when using the %llx
> specifier to print a resource_size_t variable:
> 
>   drivers/perf/arm-cmn.c: In function 'arm_cmn_init_dtc':
>   drivers/perf/arm-cmn.c:2149:73: error: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t' {aka 'unsigned int'} [-Werror=format=]
>    2149 |                                      "Failed to request DTC region 0x%llx\n", base);
>         |                                                                      ~~~^     ~~~~
>         |                                                                         |     |
>         |                                                                         |     resource_size_t {aka unsigned int}
>         |                                                                         long long unsigned int
>         |                                                                      %x
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Fix resource_size_t printk specifier in arm_cmn_init_dtc()
      https://git.kernel.org/will/c/47f06ebbe8da

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
