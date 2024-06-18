Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822B850246;
	Tue, 18 Jun 2024 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718732235; cv=none; b=j+4it1kf4qz4jkhAASGYS4Mn+bS+yFl4wYWnoK0hkyQ6cVBW6ofUaWrSRUh5ktzqGj1YodU1e09gKXUBCnXdplZPFj8NOlROYegpbV5raroJXnH+SHpdeOnv/1GLjyr8zpTIJRZP/k/ufwlMPF3gHCyN6Zni5jiTWe+T/y3bJp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718732235; c=relaxed/simple;
	bh=fxFisvuSx7/zVai6FHn67UpyuBt0aoU9yz7JGm5h694=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AE4z+644DLzFJKZNt8GDEb3z8/8M+o8NASLEFnEKL2+pasn60k4ItzeDauIAiKx1cBiHRV8uC3+S3840jYZXZwyzceHi5uC0GMa6F9mtG0bSZWBEuGEQutKmEZRHOFJGo1tqi9MHtGkJkwaDtxZvZKFPqpLIIm90632VX3IlInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hBrnK2zf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hBrnK2zf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718732233; x=1750268233;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fxFisvuSx7/zVai6FHn67UpyuBt0aoU9yz7JGm5h694=;
  b=hBrnK2zf54NbdtZFyzXceJR9tUl/tgqmug5AOY3FTyxacL4j+Exn4Rkr
   /yQXnoRaUOkhzOpv/ijhAB3aD05JZ9y6YEjqOKjSWlpBQZUW6xuahyrhw
   3jc3ngALptNIdYEAveB1qy9CL5xuhWpZzMT2IaME+qU1VoMzPyT06glSW
   6koui+oFWdWSsEA1zul0IbYsGhIrFUPNm/tQqZYVwrnOy2cURu5AIg1Xv
   XhGhjnKPx+GTou4GtE+gNlO6Y+czdRsqjC1XxWYIg55Wl+enFulD6KS3C
   EooaZjWJNWaFEv3kIGYcexon1+ecMxKcdU6/7VidHrNq3xUIoKIT9/01N
   A==;
X-CSE-ConnectionGUID: /eckuQY1Q0KhQBAE3GCIsQ==
X-CSE-MsgGUID: ZH5JvV7SQSyOXxaLF+ZCsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15467897"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15467897"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 10:37:13 -0700
X-CSE-ConnectionGUID: bytPX4mWTAC4rbxWmHjyRQ==
X-CSE-MsgGUID: YUSEM0WRQKaEAJCx+TZkZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="46757906"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.41.28])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 10:37:08 -0700
Message-ID: <c8f7d51b-9b60-4da0-bdea-b891c8a82d0c@intel.com>
Date: Tue, 18 Jun 2024 20:37:02 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel/pt: Update topa_entry base len to support
 52-bit physical addresses
To: Marco Cavenati <cavenati.marco@gmail.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 alexander.shishkin@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com, jolsa@kernel.org,
 irogers@google.com, kan.liang@linux.intel.com, tglx@linutronix.de,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
References: <20240618110617.22626-1-cavenati.marco@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240618110617.22626-1-cavenati.marco@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/24 14:06, Marco Cavenati wrote:
> Increase topa_entry base to 40 bits to accommodate page addresses in
> systems with 52-bit physical addresses.
> The Base Physical Address field (base) has a length of MAXPHYADDR - 12 as
> stated in Intel's SDM chapter 33.2.7.2.
> The maximum MAXPHYADDR is 52 as stated in SDM 4.1.4.
> Therefore, the maximum base bit length is 40.
> 
> Signed-off-by: Marco Cavenati <cavenati.marco@gmail.com>

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Getting 'base' physical address wrong would presumably
be bad, so:

Fixes: 52ca9ced3f70 ("perf/x86/intel/pt: Add Intel PT PMU driver")
Cc: stable@vger.kernel.org

> ---
>  arch/x86/events/intel/pt.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
> index 96906a62aacd..f5e46c04c145 100644
> --- a/arch/x86/events/intel/pt.h
> +++ b/arch/x86/events/intel/pt.h
> @@ -33,8 +33,8 @@ struct topa_entry {
>  	u64	rsvd2	: 1;
>  	u64	size	: 4;
>  	u64	rsvd3	: 2;
> -	u64	base	: 36;
> -	u64	rsvd4	: 16;
> +	u64	base	: 40;
> +	u64	rsvd4	: 12;
>  };
>  
>  /* TSC to Core Crystal Clock Ratio */

