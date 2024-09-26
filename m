Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B90513777E;
	Thu, 26 Sep 2024 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376051; cv=none; b=dQaOqIWOFk0H4Vw4P91Nz+yow/b5PGg8yKuaeovBiWRm7RSJl7G2+MQcyT4jLc3iy+viPTQ1aVon8XS7f/XaIDDUaoc6r5012bgHvvFF0uJjpJaS9v+1aYK9Wj+QyZdHd/lr/b6nmxybAS2kvJ2sKsHk+u9wLmAuTiQWGf5aZN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376051; c=relaxed/simple;
	bh=epz6jRXFedkq8RZkzym6M6z9oDDMZfQ2lvyT+uetk40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aficHS6r7gzCka2NqfIHrtHvsPrV7E1Gjp/ty6DKCFnM9RDtmKNpMx7t4kvO9IJaB47CYK7e0jfQzu1mApdD6JRPr1m75ZJDHP6o5YXcmpfK1OudxB7XhtLeaqUOr3+ucz9hykmn0l4RqZx++oQYRRav7ePuX0AhCeLsbrbHWis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2B5F14BF;
	Thu, 26 Sep 2024 11:41:17 -0700 (PDT)
Received: from [10.57.20.191] (unknown [10.57.20.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E38A3F6A8;
	Thu, 26 Sep 2024 11:40:46 -0700 (PDT)
Message-ID: <221f3995-34e4-42a9-a18d-faaa7cf542d1@arm.com>
Date: Thu, 26 Sep 2024 19:40:31 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf mem: Fix printing PERF_MEM_LVLNUM_{L2_MHB|MSC}
To: Thomas Falcon <thomas.falcon@intel.com>, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240926144040.77897-1-thomas.falcon@intel.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20240926144040.77897-1-thomas.falcon@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/2024 3:40 PM, Thomas Falcon wrote:
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

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
> v2: Leo Yan suggested adding PERF_MEM_LVLNUM_L{1-4} to mem_lvlnum
>     and printing a clearer message in the case of an unknown level
>     to more easily catch similar issues in the future
> ---
>  tools/perf/util/mem-events.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index 051feb93ed8d..bf5090f5220b 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -366,6 +366,12 @@ static const char * const mem_lvl[] = {
>  };
> 
>  static const char * const mem_lvlnum[] = {
> +       [PERF_MEM_LVLNUM_L1] = "L1",
> +       [PERF_MEM_LVLNUM_L2] = "L2",
> +       [PERF_MEM_LVLNUM_L3] = "L3",
> +       [PERF_MEM_LVLNUM_L4] = "L4",
> +       [PERF_MEM_LVLNUM_L2_MHB] = "L2 MHB",
> +       [PERF_MEM_LVLNUM_MSC] = "Memory-side Cache",
>         [PERF_MEM_LVLNUM_UNC] = "Uncached",
>         [PERF_MEM_LVLNUM_CXL] = "CXL",
>         [PERF_MEM_LVLNUM_IO] = "I/O",
> @@ -448,7 +454,7 @@ int perf_mem__lvl_scnprintf(char *out, size_t sz, const struct mem_info *mem_inf
>                 if (mem_lvlnum[lvl])
>                         l += scnprintf(out + l, sz - l, mem_lvlnum[lvl]);
>                 else
> -                       l += scnprintf(out + l, sz - l, "L%d", lvl);
> +                       l += scnprintf(out + l, sz - l, "Unknown level %d", lvl);
> 
>                 l += scnprintf(out + l, sz - l, " %s", hit_miss);
>                 return l;
> --
> 2.46.0
> 
