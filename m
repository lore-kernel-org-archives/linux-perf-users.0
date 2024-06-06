Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D839450;
	Thu,  6 Jun 2024 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717671413; cv=none; b=oUnIGlVnIdzFVH+0g2Fw/unbS7ai0m4HDhF81wRnHFPO5Hbl+vjEukF607VR4t6KW0sofDkKk7AAKJiC6HNcLU9SXX6Lgqh6kle+gjQG6tUQ/nRjYupsdf780n/I7wGYO96kHanblqv13jLoy9ywtYwvzRDn9yRCw3rbKDF3omM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717671413; c=relaxed/simple;
	bh=/vkBos92LXJ32FjgGFlGb6tlMPdz4UD7Ft2JSbxto3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=hZApwFlL6nqn/a+3k3x7Ct/dqCdJF3NJkdwrBCGhcDVn2eDYv3t7kOgiBTPhIuwthele6wTFqS198nsuUQmD3OZrSIOFzri3tAnbMBfRJZDhGkSLl5/25cagqRCDfz+5W6DS+SJ6frqfWGSGD0r7E3EHTrpKhXN8S40RXYpq0V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15BED2F4;
	Thu,  6 Jun 2024 03:57:15 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D20B3F762;
	Thu,  6 Jun 2024 03:56:48 -0700 (PDT)
Message-ID: <bc34d0aa-7152-4f0b-a3c4-11b1a63fba9b@arm.com>
Date: Thu, 6 Jun 2024 11:56:46 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] Fix and improve __maps__fixup_overlap_and_insert
To: Ian Rogers <irogers@google.com>
References: <20240521165109.708593-1-irogers@google.com>
Content-Language: en-US
Cc: "Steinar H . Gunderson" <sesse@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240521165109.708593-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/05/2024 17:51, Ian Rogers wrote:
> Fix latent unlikely bugs in __maps__fixup_overlap_and_insert.
> 
> Improve __maps__fixup_overlap_and_insert's performance 21x in the case
> of overlapping mmaps. sesse@google.com reported slowness opening
> perf.data files from chromium where the files contained a large number
> of overlapping mappings. Improve this case primarily by avoiding
> unnecessary sorting.
> 
> Unscientific timing data processing a perf.data file with overlapping
> mmap events from chromium:
> 
> Before:
> real    0m9.856s
> user    0m9.637s
> sys     0m0.204s
> 
> After:
> real    0m0.675s
> user    0m0.454s
> sys     0m0.196s
> 
> Tested with address/leak sanitizer, invariant checks and validating
> the before and after output are identical.
> 
> Ian Rogers (3):
>   perf maps: Fix use after free in __maps__fixup_overlap_and_insert
>   perf maps: Reduce sorting for overlapping mappings
>   perf maps: Add/use a sorted insert for fixup overlap and insert
> 
>  tools/perf/util/maps.c | 113 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 92 insertions(+), 21 deletions(-)
> 

Reviewed-by: James Clark <james.clark@arm.com>

I'm wondering if there is any point in the non sorted insert any more?

Maps could be always either sorted by name or sorted by address and
insert() is always a sorted/fixup-overlaps insert depending on the sort
style of the list.

