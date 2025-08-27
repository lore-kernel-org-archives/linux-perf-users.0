Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C02345736;
	Wed, 27 Aug 2025 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756287441; cv=none; b=S9441KaIviwodksAn3vdCov27QiriUI09TMu+GpeWvXCgCRSaxk3+xboqQyBCJmlhY13FVNOrXIrMolCJXaeTXB483YFMpPUwaMHAAJgm9D0UzuVHoHIfYdbcF+ibqkgsB66UQC9u9DfL5qV8MS6FTd7RfBqikyBN9j5Qla1cqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756287441; c=relaxed/simple;
	bh=QGIvsupPmz63Jm1MiaO7dnT5D6m3u6cvtDy8Q+9Fn10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLhIXvXowV2ODqM950rgoqLKawB82/N/nHwasW+JqZa6ySVLePGiU0HYnuB6XlT4MBEhntBvub60xIysB9oPFrtB+ooT1IRh3Ghz6YfEAZKjUvw6Ks+FmixdSwjjprfylkWCoMGhVwU8w223SQMbPOwCNSBI9XdsjN8FRKg43x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NeMj9Zfd; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NeMj9Zfd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=rNblryP2zTorqEMMoVezsZPEN3D9lsa1QGERpk6A280=;
	b=NeMj9ZfdluaOilp6YmACoE3X75z+W6AoeQpAG8X6NBlNtiGnFPlaQX3bFrAQHr
	Br+6nLMfY9p2+TCJqyNVz3HcGN7XuUtzDTLQVa13VAK/9yvV0Gk7WUGH/EH7pUxo
	0szywf8wfZkc7chpuYY3MvVTxaYshbFsYSjjFGWnx/C5k=
Received: from [10.42.20.57] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3n_en0a5oet1EEw--.20983S2;
	Wed, 27 Aug 2025 17:36:39 +0800 (CST)
Message-ID: <692c463d-69e4-4044-b13b-3538bd695283@163.com>
Date: Wed, 27 Aug 2025 17:36:39 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] perf/x86/zhaoxin: Fix instructions error by missing
 fixedctr member
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kan Liang <kan.liang@linux.intel.com>
References: <20250814093309.1580835-1-tanze0x01@163.com>
From: tanze <tanze0x01@163.com>
In-Reply-To: <20250814093309.1580835-1-tanze0x01@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3n_en0a5oet1EEw--.20983S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF1rXrWUAw1xtryUtw1kZrb_yoWkKrb_uF
	yvkryfurW5Ka1rtr1Ik3W2vrZ3KrZ8W34kAryjyrnav3W5Jan8uFs5Ar9a9a1UWws7KrZ5
	t3Z5XF9xCw12vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeWa0PUUUUU==
X-CM-SenderInfo: xwdq6vkq0qiqqrwthudrp/1tbioA+1qmitC+JGAQABsa



在 2025/8/14 17:33, tanze0x01@163.com 写道:
> From: tanze <tanze0x01@163.com>
> 
> Perf's instructions event tests on Zhaoxin CPUs may exhibit:
> 
>    $perf stat -e instructions,cycles ls -l
> 
>    ......
>    Performance counter stats for 'ls -l':
> 
>                   0      instructions                     #    0.00  insn per cycle
>           9,488,278      cycles
> 
>         0.004365407 seconds time elapsed
> 
>         0.003303000 seconds user
>         0.001099000 seconds sys
> 
> The absence of the fixedctr member leads to an incorrect hwc->event_base
> value on Zhaoxin CPUs, causing a discrepancy in the instruction count
> reported by perf stat. This commit resolves the instruction count issue
> by properly initializing the fixedctr member.
> 
> Fixes: 149fd4712bcd ("perf/x86/intel: Support Perfmon MSRs aliasing")
> Signed-off-by: tanze <tanze0x01@163.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> 
> ---
> v1-v3:https://lore.kernel.org/all/20250620023757.1429898-1-tanze@kylinos.cn/
> 
> This patch does not modify the previous code,
> Do you have any other suggestions?
> 
Hi peterz,

This is a friendly ping on this patch.

It has been reviewed by Kan Liang a couple of months ago. Is there 
anything I can do to help get it merged?

Thanks,

