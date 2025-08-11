Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6CA1DC9A3;
	Mon, 11 Aug 2025 07:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895848; cv=none; b=jUFdTgqTIOsswXibO9BFU4ymwC1qNjAugLY7BVPvtSrZNNKHO22tlbzqWc9yzjtCJt3PVEMcdRIyMDRc9TbsrUCBJHKVrCmVa+goXoZBOIdApjp9FVp2TwcTJz8Xwk0jNB173uSDrzVvVPSbzuXg7FOotCf/ZzEf3wtDzMotB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895848; c=relaxed/simple;
	bh=vCEBXrNx+bdpoywjDJ7l8+vHF1DheN62Ie3ApUw8EtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3XjvNUZdUzRPkX5GXHvxkrcEHUxX+CsYD6j6wz+vZrOjX6PU6c6fEOEfPk5xMuorI6FExNgR93KvqWz9Jgotbkr9U/tNjWLdIVueFgVMypvRQETdCsGRBE9Y4bpmvPkykHZtp2tuUPuB7Kmp5pJxujpa+ODnKwNdvCqfBBzTx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EACF5152B;
	Mon, 11 Aug 2025 00:03:57 -0700 (PDT)
Received: from [10.164.146.16] (J09HK2D2RT.blr.arm.com [10.164.146.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA69C3F5A1;
	Mon, 11 Aug 2025 00:04:01 -0700 (PDT)
Message-ID: <17bdc644-329a-42fb-aba2-d7f80f2a1037@arm.com>
Date: Mon, 11 Aug 2025 12:33:58 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf branch: Fix heap out-of-bounds write in
 branch_type_count()
To: Yujun Dong <yujundong@pascal-lab.net>, linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20250809093812.308027-1-yujundong@pascal-lab.net>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250809093812.308027-1-yujundong@pascal-lab.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/08/25 3:08 PM, Yujun Dong wrote:
> The branch_type_count() function writes to st->new_counts[flags->new_type]
> when flags->type is PERF_BR_EXTEND_ABI. However, while the array
> st->new_counts is sized for PERF_BR_NEW_MAX (8) entries, the field
> flags->new_type is a 4-bit unsigned value and may hold values up to 15.
> 
> This mismatch allows crafted perf data to trigger a heap out-of-bounds
> write when flags->new_type >= 8, leading to memory corruption.

Crafted ? How could flags->new_type >= 8 when PERF_BR_NEW_MAX is capped at 8.
Is this a real scenario that happened on a system ?

> 
> Add a bounds check to ensure flags->new_type is less than
> PERF_BR_NEW_MAX before accessing the new_counts array.

But it might make sense to add this check just to be on the safer side.

> 
> Fixes: 0ddea8e2a0c2 ("perf branch: Extend branch type classification")
> Signed-off-by: Yujun Dong <yujundong@pascal-lab.net>
> ---
>  tools/perf/util/branch.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
> index 3712be067464..8ea6628c7735 100644
> --- a/tools/perf/util/branch.c
> +++ b/tools/perf/util/branch.c
> @@ -21,10 +21,12 @@ void branch_type_count(struct branch_type_stat *st, struct branch_flags *flags,
>  	if (flags->type == PERF_BR_UNKNOWN || from == 0)
>  		return;
>  
> -	if (flags->type == PERF_BR_EXTEND_ABI)
> -		st->new_counts[flags->new_type]++;
> -	else
> +	if (flags->type == PERF_BR_EXTEND_ABI) {
> +		if (flags->new_type < PERF_BR_NEW_MAX)
> +			st->new_counts[flags->new_type]++;
> +	} else {
>  		st->counts[flags->type]++;
> +	}
>  
>  	if (flags->type == PERF_BR_COND) {
>  		if (to > from)


