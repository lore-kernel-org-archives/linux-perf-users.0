Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D07C1D5CDE;
	Thu,  5 Feb 2026 03:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770261839; cv=none; b=Kcif4NNFLGNJqCF+4hezUrqZHU12go4RKU27eg2i0v8qcwIDp8nhidXNxQWs0uaXaUPzozgPbAeP3ZwcqJ1dWit93Fj6r+sbWznxWYLzwTmtWMk6zkDSUmcq8gXcSkca/hjhMx9zhCcjc2VFYBSQfQTpSqbUHihSj9j0LVIog0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770261839; c=relaxed/simple;
	bh=lP6vUPvaC7n+bL/kzUUxt16XPQCNrighTye0kh1NSoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yh9LkiZsnusZ+ce/hNqJJuldf0N0jvnsmDFooGgYcwm6WQEJFvRt8bRH00tt+TkrOQTaNKpbP9DuaC38ySVYvdtZ5mI5LZCvcZTDbtUPBH8Qe7xdITN4iKEy5tOGHVQPz4c/ciMQux4Hg37XV82zSRMqKlRgGmkZENcXARre8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=fhpBLNkJ; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="fhpBLNkJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770261772;
	bh=e6LAP3y2u6y/GSxehatoplSX8NDiUfKiCIBNkGgZb+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=fhpBLNkJcWB8U4aBisSqdOE8iGi7uhcNAI6JpEf2DGROc5pam9IpAMzhT4nyy4+/X
	 29A8c+HKnHDFYe24vJPeRqZzI1wCZ0d1VPSpkQNp0OYQ4EPBK7EKkhuFrwn6yvadJX
	 2Asz0k22Sp2+cZG6c9h0cu2pinAZCKauRp2L/CKQ=
X-QQ-mid: esmtpgz15t1770261765t648cf4b6
X-QQ-Originating-IP: GvdC4zEqTwY6YV9h3jx3LpcHUbj/eh9ffzRYUjbqzc8=
Received: from [10.3.91.191] ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 05 Feb 2026 11:22:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3001482229687617696
Message-ID: <80DCD2AE8E6A9007+7def6e64-dbfc-4867-9e21-edbc441a057c@linux.spacemit.com>
Date: Thu, 5 Feb 2026 11:22:42 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] perf vendor events riscv:: Add support for
 spacemit,riscv-iommu HPM aliasing
To: Conor Dooley <conor@kernel.org>
Cc: Tomasz Jeznach <tjeznach@rivosinc.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>,
 iommu@lists.linux.dev, linux-perf-users@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 devicetree@vger.kernel.org
References: <cover.1769562575.git.lv.zheng@spacemit.com>
 <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <5242DDF0A783AF08+e141f1898581018f8dd0723cb5c870c23ec679d6.1770195980.git.lv.zheng@linux.spacemit.com>
 <20260204-suds-shush-d85872589cb3@spud>
Content-Language: en-US
From: Lv Zheng <lv.zheng@linux.spacemit.com>
In-Reply-To: <20260204-suds-shush-d85872589cb3@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Oa8re6cv0BNkRrQBWXcdsvKlprj+plMQhYpWDTetiw1l2v1qIyh+9rR/
	wpRKmvB3/VOZxd7UgNCjGNQZybcq0Iz3l1795rkplItP2y1ar63hY1WfMb8a6+C2ZYkjrZl
	JlNlEtFieabzZMfGSdCK5zTP8GhCT5lhAYKWjsZUxG1eLOfImUY8e9kXXKVKmyZ7GWZK30x
	OkCELWj0YOlYT08GyoOM8VbTUnIQ64wpghe4/4cv+3bGfERgX94013+h9sbTLTm/agfS3W4
	HU3u0SsknHkzs+sj+bqJhIUJLXV4Hjh0BPop7oSSfjmIZK0MMSL+ItoxYyd33Q9Gt0HL9B2
	5iCCAdlArgYqL0B2ADe1qapiJ8zppNqMO7Xodf0s3FUGEC+ixDGZDBijeBoFPBeAohlRDUG
	xU3FSV5VIEnDu3YE0KaYcNJtI0Y/+XAaYbUhognUsngZk+4y7sKOAUnPClBHE+U4BzscyHd
	IVAKi8/FNKc5/Qv+6YCMIfOEHzgn8Gzemrbsuqz+u5C+EBzJrnRw2mJabuvKP8gnvNsGGBH
	2L0t5p875g0+eBUP+UN3VLm9xPr0qeTKZRzbazB0XOZfWP0xBtPpXJvr9UgP98b3/tyyxqe
	7ZpccjbCPrXencz2FYgkPVote2mN5PHNRrrz8rrHmTsjnncn0M0cilqjORWx1ruNjr7S05h
	8h3GzKrKAVzzhaJO5qKiyLWhUAecmIsxwdrOpl6xubTsHXeXeh0UWwWcE8bEQcAtsKcidk7
	Ctd/Kpg3ZXU9SsiRt/QqsfhselZv1RkvsCW0NoHMG8Z1C+tVhSqAmwjhXLcn4dMtCaoL+D+
	eTARLNhlaFk7NNVI7pEchkdl9Bm+SVUXOqleSbxagDlu+czf2/by+w//Mvxw92MAlJpIvk0
	LmD7ghYZl98pM0h5aKX83g7ogHQrB5x4lQmnmHxTNakiVHq6/yCBLRSDxdN3gcoLsOVozkg
	OtkoYFdwLjlSI8VXbS6B4WtChyONCkt6zfl/ybN4n/AtkEsfqnZ5QqHSjlqzPcYOM5kzBIS
	PnZI6C6ZneytLAI3taDpEiq17rBYsYv/vxFHexL4prTE7C2s+mk7dR7YZDLu+dfUQOlQTcb
	L5CCynOqyGGEvx9p1SWVn2b3MXaguD6X4UUB5t92y77
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

On 2/5/2026 1:38 AM, Conor Dooley wrote:
> On Wed, Feb 04, 2026 at 05:09:52PM +0800, Lv Zheng wrote:
>> Add JSON HPM event aliases for SpacemiT distributed IOMMU (T100) which is
>> general and compatible for all SpacemiT RISC-V SoCs.
>>
>> Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
>> Signed-off-by: Jingyu Li <joey.li@spacemit.com>
>> ---
>>   MAINTAINERS                                   |   3 +
>>   .../arch/riscv/spacemit/iommu/sys/ioatc.json  |  30 ++++
>>   .../arch/riscv/spacemit/iommu/sys/ioats.json  | 163 ++++++++++++++++++
>>   3 files changed, 196 insertions(+)
>>   create mode 100644 tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioatc.json
>>   create mode 100644 tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioats.json
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7c50701b6001..4d91f99aa742 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -22459,12 +22459,15 @@ K:	riscv
>>   
>>   RISC-V IOMMU
>>   M:	Tomasz Jeznach <tjeznach@rivosinc.com>
>> +M:	Lv Zheng <lv.zheng@linux.spacemit.com>
>> +M:	Jingyu Li <joey.li@spacemit.com>
> 
> To be frank, this looks misguided, or at least premature, to me, given the
> state of the patchset.

Should this be a big deal?
I've been working as kernel maintainers for 5 years (you can find me in 
git log using Lv Zheng <lv.zheng@intel.com>) and given the fact that I'm 
also the silicon designer of SpacemiT T100, played an active role in 
IOMMU spec community, I'm ready to help the community by reviewing 
RISC-V IOMMU related changes.
Joey is responsible for SpacemiT RISC-V linux kernel support. We have 
chances to test RISC-V linux kernel supports very early using 
pre-silicon real hardware here in a silicon team to help the community.
Any suggestions?

> 
>>   L:	iommu@lists.linux.dev
>>   L:	linux-riscv@lists.infradead.org
>>   S:	Maintained
>>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
>>   F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
>>   F:	drivers/iommu/riscv/
>> +F:	tools/perf/pmu-events/arch/riscv/spacemit/iommu/

checkpatch.pl complains missing files and given the reason above, I 
didn't create a "Supported" part of RISC-V IOMMU HPM.

Best regards,
Lv


