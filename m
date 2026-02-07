Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA32F49F4;
	Sat,  7 Feb 2026 03:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770435745; cv=none; b=KqGLszk33Tt9IMW+1OtSTcMDs8ZEJHPbOWnQP47WDQlFw0UtaFVeKEMli21KSct/Bg80fF1I51awAqn0UpTwdoqt4xjmXErB6VEgd5LtdLPAyAFJsZfFzHITgzGKmpiLDSpXhhCZstln35TgyiMVbYMK4uiMA/snT7JTlpHz9fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770435745; c=relaxed/simple;
	bh=VXdlcgSmpo+0XD53VNWiyFRYAZWjRAe0d0crCSg/xKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAdQQqqQ4yltxoWt5Thgt4Y4q6LQP68t6SZHDqm4upxetV9AG0mOnPVT5zdH8plai1+nvhFCKn0X0Rnf7Q8cLuVAfGB5ibAbNrIT5fqGvYruOLvXYZcAbTx5fyIo2uYaoHQcCpdtdpQuf7JwJyscnBebFSGuup3VW1z0zii/Y98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=ilx+NB2C; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="ilx+NB2C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770435672;
	bh=iGGdXTkXE6iLSkpjLauckmQd6kdrYyp6XyWgqtLiuXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ilx+NB2Ctd64IhEkBmabs9vCn7jxR/2yB4dG49Kp0t6l1uHqeWBUDCFEsUg5oND1q
	 Pt0WX21N4lcaz3eMe9Pn71y9sKbnZwdLv/+2g3jgsstd6pOrInMPCa0BqBD3NlRJlB
	 fUcB1xbqempE8Bt6XwUixk+Z+aPN8z4M5j1XlI88=
X-QQ-mid: zesmtpip4t1770435665td6aedc24
X-QQ-Originating-IP: nptEyNvWLFJDvHVJLzL8/o3VAW+0403HpSPcPAlvcls=
Received: from [IPV6:2409:8a1e:3015:50f0:29fb: ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 07 Feb 2026 11:41:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3470539334872340848
Message-ID: <605D8D5AE96AEF8F+31d65ad3-3956-49ae-8d9f-589747a5086c@linux.spacemit.com>
Date: Sat, 7 Feb 2026 11:41:01 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] iommu/riscv: Add HPM support for RISC-V IOMMU
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Jingyu Li <joey.li@spacemit.com>, Zhijian Chen <zhijian@spacemit.com>,
 iommu@lists.linux.dev, linux-perf-users@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 devicetree@vger.kernel.org
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <F9748E3984D2A6F9+cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <a9d9f43a-edf3-419b-bdf7-dbd6bf9e978f@kernel.org>
Content-Language: en-US
From: Lv Zheng <lv.zheng@linux.spacemit.com>
In-Reply-To: <a9d9f43a-edf3-419b-bdf7-dbd6bf9e978f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NUTz4BkILuKLi/q/CGWmd+WuVu2I1QFgAtIGv0spdb41cjP4s86/8ggY
	zTzLtoGTtLMbLcCH+vdEe5ym6la2GVy5ayXqbJUVAO0+0nfB358xwXVezNWmyf6ijuvdpax
	h/mQFwFQuRMgMaFDUQGkTs+t3u0D478M+mLmfF9I4IZH6EdhSEuAsZkk/6Jbw77o35rR10c
	5ah+JzQvz+6iPI9u7fOXSy1PLtxARJCXbQ96U2ia5kmQgtfdhsAlwqJfwtKodr+GnvY18xK
	Pq2nrkTMtyLL3DP0VnDaEpUyI9tegZextVD6i1AFYUd7y6kyfQ5L3dlGFfp/EV4rsx93w01
	y7rR1/gjKYa879PaA+57BfllYl1G4R+TwO2s4UAbD1gD/eCYufkjBoXI92zlSSRtGtgkJhS
	HSrwwK1XOl2agtGzTrc32LXRdWfiKJBmPAgH77any61Qht9YvneWZ0PwKv8JQcf9msm6Cye
	WE36J6ShrtcICgyQ850v7cgxwElHREx3lXooIf7fr/oszB3D67+1OPKWWt0l/l4YzKXVQ/8
	9lomUl81CsXfsmjiT809l+FjNfGPNdxxrsdyNqYA6aKUCmFJEaKiSYj/bbG7cD+gOAthsqj
	C1C4BSWW+JG11L67D9ZsREYnetl7Z/z+/N4YsnDzdCqV4OnW7kCzp+lPJBf4U/KkiAr1GmH
	A2JfVhmMP4jg2aP987V2xL/JV6LMFNZNxiPzcQSKD5pTnk8sHLD4M4e7rwvcU0464+95dgY
	LS8MMPeyEM+9KGsZE3qUe9ji4dsoqqKpTJYJnC2uttzxXMP6H7la6fSrApGLrUd299Xkz0b
	U0jT0Nvt+2Dn0Yi6hv0i+ye2T1JFgSO+qyIBCKlJpSUC4/6kKZO2a8YGD7Hj+HQPZ4BadyX
	04VaIGmjQ0eF10s9bYl+KEd6uVER6Rpqu5e9I505RSd4U+nBwYw34JNkt3XBafMs2+7gXv3
	W0NZssOcpwhwCvq6yisJIcTD1CIHCaJwYcrc2oacyl0wwxp0fRmwS8eLRgfTRjnAocHw60b
	xx+GxOwoLHkHRkF9/nAT4tiRggS1M1SBBwoiLkiWMB4/LfzwpA
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

On 2/6/2026 6:44 PM, Krzysztof Kozlowski wrote:
> On 04/02/2026 10:08, Lv Zheng wrote:
>> Includes HPM support for RISC-V IOMMU. The HPM hardware mechanism can be
>> found in the recent announced SpacemiT SoCs (K3, V100), where T100
>> (SpacemiT distributed IOMMU) is shipped.
>>
>> Revisions:
>> v1
>>   Initial release.
>> v2 (sent as v1.1)
>>   Split and cleanup DT-bindings.
>> v3
>>   Refactor using vendor specific compatible.
>>
> 
> 
> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets. See also:
> https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830

Got it.
I'm still using an old fashioned upstream way to collect all revisions
into one thread. Will align to the preferred style.

Thanks,
Lv

> 
> Best regards,
> Krzysztof
> 


