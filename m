Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38AD28E8;
	Wed, 25 Sep 2024 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295420; cv=none; b=MJX/A6KNSlWbWJ7sc61AT5nK+WXXVB7wiS6nIe256wFShPOjgUVoIRRKYdOldS6W+eEal61DKPPsvNVfcmUNfdtKoeBEeNZXJR+FBK6M15DT4i9X5aTTdq2CKnvjzvpVe0wNb+6zIolavPngJizOs3hDbkRrV49+Vb++pudHv7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295420; c=relaxed/simple;
	bh=fcCd/pAN7J1DNVaXaNGjD4NBFJWuo+jVlqAFYDeSXX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+hnzapOX2/7JG43072oxbKmTk6bfc8ZBjP+ogm1kme6AbyCwFqgJJEoYmJw3ojml4scRMwKkxwHwZGoE5hYBA1Ep6NzReLSuVcjBMAjynGpK6Vg5rfC6w5TRFVVrdb2tzET0Od5kSOsWaYeucseih+ocAspeRGokeB00aqn2Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DC6A150C;
	Wed, 25 Sep 2024 13:17:27 -0700 (PDT)
Received: from [10.57.21.248] (unknown [10.57.21.248])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E74E3F64C;
	Wed, 25 Sep 2024 13:16:55 -0700 (PDT)
Message-ID: <6d409278-988b-4c09-adfb-5e075c9b326e@arm.com>
Date: Wed, 25 Sep 2024 21:16:50 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf mem: Fix printing PERF_MEM_LVLNUM_{L2_MHB|MSC}
To: Thomas Falcon <thomas.falcon@intel.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240925183633.49653-1-thomas.falcon@intel.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240925183633.49653-1-thomas.falcon@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/2024 7:36 PM, Thomas Falcon wrote:
> 
> 
> With commit 8ec9497d3ef34 ("tools/include: Sync uapi/linux/perf.h
> with the kernel sources"), 'perf mem report' gives an incorrect memory
> access string.
> ...
> 0.02%   1       3644    L5 hit  [.] 0x0000000000009b0e  mlc     [.] 0x00007fce43f59480
> ...
> 
> This occurs because, if no entry exists in mem_lvlnum, perf_mem__lvl_scnprintf
> will default to 'L%d, lvl', which in this case for PERF_MEM_LVLNUM_L2_MHB is 0x05.
> Add entries for PERF_MEM_LVLNUM_L2_MHB and PERF_MEM_LVLNUM_MSC to mem_lvlnum,
> so that the correct strings are printed.
> ...
> 0.02%   1       3644    L2 MHB hit      [.] 0x0000000000009b0e  mlc     [.] 0x00007fce43f59480
> ...
> 
> Fixes: 8ec9497d3ef34 ("tools/include: Sync uapi/linux/perf.h with the kernel sources")
> Suggested-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

This change is fine for me. But for later avoid same issues, I would like to
improve a bit:

static const char * const mem_lvlnum[] = {
       [PERF_MEM_LVLNUM_L1] = "L1",
       [PERF_MEM_LVLNUM_L2] = "L2",
       [PERF_MEM_LVLNUM_L3] = "L3",
       [PERF_MEM_LVLNUM_L4] = "L4",
       [PERF_MEM_LVLNUM_L2_MHB] = "L2 MHB",
       [PERF_MEM_LVLNUM_MSC] = "Memory-side Cache",
       ...
};

Then in the function perf_mem__lvl_scnprintf() :

   if (mem_lvlnum[lvl])
       l += scnprintf(out + l, sz - l, mem_lvlnum[lvl]);
   else
       l += scnprintf(out + l, sz - l, "Unknown level %d", lvl);

This can help us easily to catch unexpected memory level.

Thanks,
Leo

> ---
>  tools/perf/util/mem-events.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 051feb93ed8d..c630aca5bd93 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -366,6 +366,8 @@ static const char * const mem_lvl[] = {
>  };
> 
>  static const char * const mem_lvlnum[] = {
> +       [PERF_MEM_LVLNUM_L2_MHB] = "L2 MHB",
> +       [PERF_MEM_LVLNUM_MSC] = "Memory-side Cache",
>         [PERF_MEM_LVLNUM_UNC] = "Uncached",
>         [PERF_MEM_LVLNUM_CXL] = "CXL",
>         [PERF_MEM_LVLNUM_IO] = "I/O",
> --
> 2.46.0
> 
> 
