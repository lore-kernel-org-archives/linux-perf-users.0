Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753422475E3
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 05:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789363024; cv=none; b=YNbQTZUOcIUFvfj96D434I0Vqe6J/rz2+Six0HzK2qHnuUSmJ9As1Yi6umjmfnsRqSGiYUwTUW2u77TFNBn9X0JIkt3VsKXclaN99xVWyPvOcHolcWRzlbuf7fA81/bYTw5eEPldO7cQ016d/2srQNPW+wVYQi+5+MzC1tZQqM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789363024; c=relaxed/simple;
	bh=4/QX3crcaPDGHJVZaKuH7tEh4lEewHCYlPfrwJkbScg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGQI+yvgJ5G/m0AgLGuop9IekxmqJ7niPNqGXI8uhWjE3GDOKCRqL/G1zhrsNNU9oh5SlMJFq4Am3f6pykHQ/L0NEivqLg+DNlMSU2RVg/fdnt9jGS8Gx9p7PrUrY6GRConwsILQbx9Cc8XekOx2H92v4xpRT/PIbNvNeelD0v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9o8ANm8; arc=none smtp.client-ip=192.198.163.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9o8ANm8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789363024; x=1820899024;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4/QX3crcaPDGHJVZaKuH7tEh4lEewHCYlPfrwJkbScg=;
  b=H9o8ANm878meOM8jsYhOM2S53I2YTc95BmZcbm3eb4O096GP7wa8pV2R
   ihzEeTcO1lVz4PMeuS9f6gD76x+iGOW24Y1dok6ePo8d7uuiqWCVRr//4
   Zo5fIa3+3sm8SMClaPUUHzZS1BXTJ+ahvMP99Uv6CXRAlYWEgogd4w8YG
   PhvTsOPL4Ty7SUUTvBQUiZXaU63e0bbZBGH8FY3Z+O98SfzWNAfcxckKk
   7vNGrZGtEXWdGIwUAWd8x3h3TUhxr7WlJv22iSGUviU1SX7DgAZ8xp4xV
   G58lYfr40Lz0MtS6bBuLH74YZOvb+m2MvDi3NmceDvXTLl8Nnfqfv/o2t
   w==;
X-CSE-ConnectionGUID: 6VDbNTG3QDazNSwNX6idhA==
X-CSE-MsgGUID: kKN5zGuaQrqeZy/X7nKUOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="220238"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="220238"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa115.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 22:17:03 -0700
X-CSE-ConnectionGUID: gbMDYU16RAe38/pNbbZAsw==
X-CSE-MsgGUID: tO2ma6nzRTuXGFjYjRi3KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="310813790"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 22:17:03 -0700
Message-ID: <1870044f-ab4c-4906-8f8b-c3216fb28211@linux.intel.com>
Date: Mon, 14 Sep 2026 13:17:00 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v11 07/10] perf regs: Enable dumping of SIMD registers
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260914014049.2061519-1-dapeng1.mi@linux.intel.com>
 <20260914014049.2061519-8-dapeng1.mi@linux.intel.com>
 <20260914020418.97E881F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260914020418.97E881F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/14/2026 10:04 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Missing explicit `<stdio.h>` inclusion for `printf` usage, which can cause musl build failures.
> --
>
> commit a307c3e7165562ef96094cdee1fc722a99865e02
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf regs: Enable dumping of SIMD registers
>
> This commit adds support for dumping SIMD registers with the new
> PERF_SAMPLE_REGS_ABI_SIMD ABI. It currently supports XMM, YMM, ZMM,
> OPMASK, eGPRs, and SSP registers on x86 platforms.
>
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index 90d4e45f09f08..a5b596cd14be6 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -1446,6 +1446,86 @@ static void regs_dump__printf(u64 mask, struct regs_dump *regs,
>>  	}
>>  }
>>  
>> +static void simd_regs_dump__printf(uint16_t e_machine, struct regs_dump *regs, bool intr)
>> +{
>> +	const char *name = "unknown";
>> +	const char *simd_header;
>> +	u32 i, j, idx, pred_base;
>> +	uint16_t qwords;
>> +	int reg_c;
>> +
>> +	if (!(regs->abi & PERF_SAMPLE_REGS_ABI_SIMD))
>> +		return;
>> +
>> +	if (!regs->nr_vectors && !regs->nr_pred)
>> +		return;
>> +
>> +	simd_header = "... SIMD ABI nr_vectors %" PRIu64 " vector_qwords %" PRIu64 \
>> +		      " nr_pred %" PRIu64 "  pred_qwords %" PRIu64 "\n";
>> +	printf(simd_header, regs->nr_vectors, regs->vector_qwords,
>> +	       regs->nr_pred, regs->pred_qwords);
> [Severity: Low]
> Does this file need an explicit inclusion of <stdio.h>?
>
> The perf tool can be compiled with musl libc, which enforces strict POSIX
> namespace separation and does not implicitly include headers. Relying on
> implicit header inclusion for printf() can cause build failures under musl.

Ok, this can be fixed in a separate patch later.

Thanks.


>
