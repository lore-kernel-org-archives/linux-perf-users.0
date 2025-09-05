Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C282F7AC1
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Sep 2025 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757095506; cv=none; b=YgHfaAZ8/qfaPYhubS0zSPLP0Y+IRVeB/oBq33NUfRVQvdMjRc919tcWhz7ULfgKpSoZaNJHVAAoAmw19aMO7bOnDTMltfNdATWaO7IXqFYv+6QpgxHbSen8By8v3xOAJqn9BUa/jZN03HV74JkwqV3vBpxv5wC6YvAh9NuvZj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757095506; c=relaxed/simple;
	bh=iLt4euP0A/8A3AKBgvWn92zIhvpTNMJ1mgotIHM6Bf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JyctQRCyRwC+RglGaTV2zzjZ43bZoxr/Z0o1bteVVmdg7V+4rQJzWG4VmWFTm2RM5qXdmas74XyKd26kYQnrlrnG//If5Ufl9uPeWbmM1XVVoZnxU/SYUPH65148LK1erbcLXdRAxcPA7BLGcdIHiB17wyLTdhH3xKhfFyLh7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dfTqhICY; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dfTqhICY"
Message-ID: <3e113599-2d99-4585-af14-a93cafe11d33@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757095500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LSXdQvhjLqn/cnLmBxmZ8XUh4olkXbYzp0sAqc3/Ow4=;
	b=dfTqhICYs5bofpSfYNxjoM/fGywq3OzgNiQFG5yvYF11d9CeT3Vr10t4WSBJ0QFkHWxCX+
	xtx8N7PkiYSt1x6cDmZo5fRgu9Ab7wTZ0C/m1nJZEJ/OleEqCkOlIQC2A2mqiX0dbDBwqy
	HNi1WtovwHMzIWb4Vjc8YqoPllsRUcc=
Date: Fri, 5 Sep 2025 11:04:55 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drivers/perf: riscv: Remove redundant ternary operators
To: Liao Yuanhong <liaoyuanhong@vivo.com>, Anup Patel <anup@brainfault.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>,
 "open list:RISC-V PMU DRIVERS" <linux-riscv@lists.infradead.org>,
 "moderated list:ARM PMU PROFILING AND DEBUGGING"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM PMU PROFILING AND DEBUGGING"
 <linux-perf-users@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20250828122510.30843-1-liaoyuanhong@vivo.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
Content-Language: en-US
In-Reply-To: <20250828122510.30843-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 8/28/25 5:25 AM, Liao Yuanhong wrote:
> For ternary operators in the form of "a ? true : false", if 'a' itself
> returns a boolean result, the ternary operator can be omitted. Remove
> redundant ternary operators to clean up the code.
>
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>   drivers/perf/riscv_pmu_sbi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 698de8ddf895..c18dbffa9834 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -339,7 +339,7 @@ static bool pmu_sbi_ctr_is_fw(int cidx)
>   	if (!info)
>   		return false;
>   
> -	return (info->type == SBI_PMU_CTR_TYPE_FW) ? true : false;
> +	return info->type == SBI_PMU_CTR_TYPE_FW;
>   }
>   
>   /*

Reviewed-by: Atish Patra <atishp@rivosinc.com>

