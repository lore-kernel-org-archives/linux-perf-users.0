Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A9329B8FE;
	Fri,  6 Feb 2026 03:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770349536; cv=none; b=KjwHYSHSB5jb81X9bQ3lZ8DRpjd54itqv+Yi+9/8hoMauNvWJPcgSrnvFUHYF05NBgp3Tdcmnt1HQRcnS4jl1iElxXvi7i8gPK2lTaG+4IAQEX5DzXnQWePLdSxRHRWKuAXWQ64zrpdiiXuHgodUx0csBF4PqrKOOaDZKEn43IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770349536; c=relaxed/simple;
	bh=8QaIt52NdvFuErUCHtvnmmLagd++MM0S9WAKEKHGAHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/Efk5vVygyjUQe+CkHyxFo2j1ocoF8R/r+PX0qSjflfFPG1PPfot8VSjnfzlrNibnx687DU8Jf+LbT77TKIg5FgpzBOqZzR3GM45P7wWXjm8bxAZ3w/cZgAzjnOECb7MJUuuVQqQy0rKdGo2Zof4s9V5s5n5A8kiLkY1WmXL/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=kWNfDtDV; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="kWNfDtDV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770349479;
	bh=I3g42yJH0JWKICHWbMZxYhHhJBEDjcyHd4q+GXqrC5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=kWNfDtDVpRh1Z4iPqAGXTZTRl0Sv8lQc4KYpySBId31LsUFlNWHCZMh+O0GLeQ9m9
	 dVSmn9P2exs+fQ/hzbZfUmUxBr6CRvY8bc4ItS+s9rXbPZS/0Oi84o9XDCZ6E3WCbJ
	 N7eTETKxnv5zi30r2znlo79ijHFAswdIJpkP1xFY=
X-QQ-mid: zesmtpsz4t1770349470tb06b5594
X-QQ-Originating-IP: GNClnZ5B0uToiIZaeP+3CrWjtBWwxgmqPCTChay5LDo=
Received: from [10.3.91.191] ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Feb 2026 11:44:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13007171727628371130
Message-ID: <049320517C0CBAC7+22eb4b3a-821c-4ae0-8bf8-be7455289929@linux.spacemit.com>
Date: Fri, 6 Feb 2026 11:44:27 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] dt-bindings: iommu: Add spacemit/t100 features
To: Conor Dooley <conor@kernel.org>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>,
 Zhijian Chen <zhijian@spacemit.com>, iommu@lists.linux.dev,
 linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, devicetree@vger.kernel.org
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770281596.git.lv.zheng@linux.spacemit.com>
 <B1AEE717CF03B1BB+22fe4be0d3c8d2c6b4c5d3c19736c937cbed3c0d.1770281596.git.lv.zheng@linux.spacemit.com>
 <20260205-presoak-reshape-9465d18bca4a@spud>
Content-Language: en-US
From: Lv Zheng <lv.zheng@linux.spacemit.com>
In-Reply-To: <20260205-presoak-reshape-9465d18bca4a@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NOIkHYnr7Vzd/QBa0AWyODA7TWoJiYyxcdouM/QFsngOoMMS8QhO7hoR
	2RVY2ZSFpqbIEvpo0Udmo2zGonRo1pkXxoelsvMm13DWpcKYIk4Mh85CQ0MNBV6Mw8F5iO/
	I626Vbj5KGT0STSvbDTPvom4JIcE8cGZiohau9eMBrpxAH8RyM9Mfes8TJ40ljsJZ/vQ/S5
	Saeeq8/80JLVG7ajEoFF+TvGIQNps5Hhtf7lHptYJCtFaoC7dVmq7qi2hAaGsm6pR2SglIE
	pU1rfKuufJKBISCYrQ5uqKCK0wiKqVgDS6C3PNdzBUa34zbcEjjeYcl0WqDrpUS/WAziw4w
	RW2yVrxPh+xEQhkIBFhfmTzqAr1PFrlDn/lWa0fq4Lj7IGDXaDBB/mEyzo5OpeOrzhH66pz
	Df1xuS2Qr7iLWTsKny3ZqbEJRI41yHOaghhJjS8X+j4zFY0d2aeAGtc74QodB1b9eiyo6N/
	Nxwh6ek7P6xQGa/9X/RRz92ZNxE5Al2HxsFHHEf4nF6eKq28GQpEAm7b7qGmHy/uI1IS0OU
	K8+/eGk1F9gn2zRBzPQsMAvCXI8bYPnfF7jKfoNtsqAyJNwxxw//EgRli7gcZBbQFCOWNhL
	zrmj41PQ0aLYE84NZ2ZtRmabDIVpRucPJGJes5I8TZ6UDOtxzzbQPGLhFvD6cQQk10cFT62
	dgh7cNEtU+1pg6lq5xZIHoX0u5vyV1PCrubfrI4bR9fI+HztxqyYK5zCCFdpGS1W5lM1nV1
	S3BCUWF2uiCX0ORcJDd7ZCpmGTqm+Pj2li2RnMmFYfHTCbTAlG5mPrRvdMsim5iz2hRgUpJ
	Kg7k+JQagM1Wod3sXsnPF+5ttgof2nOIRJEPyDdBt3jG62c+q/kloDHAAXmXI3iRTZ0TWDN
	OJ6ISUPTUo5I6omZ/kXeCsszPJsYyhY2fpOyf24kSBRHdJ+7aozUH+8bdwis324HAQq7hDb
	WJjUMzfr60PGQS00pxUa6tmoK6KiddBnhItL6o8Kqg3MNVzIEvwcJBX31QY+Ah4DTZ8yDA6
	41g8F0LgXXBfJ5LiTXT4lSEm00Qy2HxNnj5Ap3Vw==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

On 2/6/2026 2:26 AM, Conor Dooley wrote:
> On Thu, Feb 05, 2026 at 05:10:43PM +0800, Lv Zheng wrote:
>> Adds device tree bindings for SpacemiT T100 specific features by
>> introducing spacemit,100 compatible. T100 contains distributed IOATCs,
>> each of which exposes pmiv interrupt.
>>
>> Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
>> Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> 
> Please wait until discussion has finished on prior versions before
> sending more. The merge window opens next week, so there's absolutely no
> rush with this series, there's weeks before anything could happen with
> it.

Sure, thanks for the help.

Cheers,
Lv

