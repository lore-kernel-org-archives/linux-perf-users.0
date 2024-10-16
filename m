Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E82156225;
	Wed, 16 Oct 2024 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729089648; cv=none; b=qWxYxmIZOWfWqKb05u1uQqUgQ7NepwnIRkO4ieuu2tJUg3MKM+PvwLFkzEpmCKsdBiEvkfDbglKdg9RE0IsgVhUSgCQltmI3vYUunSFe3WNtoGmq2VpscAet/aX9EqjYcEvpF3q2u/73HPnsmqM8GM4a9xhcjCisWu+hj19i+9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729089648; c=relaxed/simple;
	bh=ul8TFX6/qO2uhWK1XiYqRn/NjGuEyHYIevcEye9EmYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oc2uMr6L2BcROUCIG27XQI2ZYFG5rRIgU3+DNgkyNSg+JAPbeG8uMl8bqzOe0RYMdeknRp1YzAurmNg3pVb5zCGR+l8q/xoMW82XtiAl9JZYfRBau5d+vqw553rc+F/oYn+q/00Y9vSRB9nMQAz1kMMJVcsrfqcLMXRB3haGS5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 758AFFEC;
	Wed, 16 Oct 2024 07:41:16 -0700 (PDT)
Received: from [10.1.28.177] (XHFQ2J9959.cambridge.arm.com [10.1.28.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 848913F71E;
	Wed, 16 Oct 2024 07:40:43 -0700 (PDT)
Message-ID: <c997e5c6-ba45-4492-95ce-28747643bd39@arm.com>
Date: Wed, 16 Oct 2024 15:40:41 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 16/57] perf: Remove PAGE_SIZE compile-time constant
 assumption
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-perf-users@vger.kernel.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-16-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241014105912.3207374-16-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

+ Arnaldo Carvalho de Melo, Ingo Molnar, Namhyung Kim, Peter Zijlstra

This was a rather tricky series to get the recipients correct for and my script
did not realize that "supporter" was a pseudonym for "maintainer" so you were
missed off the original post. Appologies!

More context in cover letter:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/


On 14/10/2024 11:58, Ryan Roberts wrote:
> To prepare for supporting boot-time page size selection, refactor code
> to remove assumptions about PAGE_SIZE being compile-time constant. Code
> intended to be equivalent when compile-time page size is active.
> 
> Refactor a BUILD_BUG_ON() so that we test against the limit; _format is
> invariant to page size so testing it is no bigger than the minimum
> supported size is sufficient.
> 
> Wrap global variables that are initialized with PAGE_SIZE derived values
> using DEFINE_GLOBAL_PAGE_SIZE_VAR() so their initialization can be
> deferred for boot-time page size builds.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> ***NOTE***
> Any confused maintainers may want to read the cover note here for context:
> https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/
> 
>  include/linux/perf_event.h | 2 +-
>  kernel/events/core.c       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 1a8942277ddad..b7972155f93eb 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1872,7 +1872,7 @@ _name##_show(struct device *dev,					\
>  			       struct device_attribute *attr,		\
>  			       char *page)				\
>  {									\
> -	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE);			\
> +	BUILD_BUG_ON(sizeof(_format) >= PAGE_SIZE_MIN);			\
>  	return sprintf(page, _format "\n");				\
>  }									\
>  
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8a6c6bbcd658a..81149663ab7d8 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -419,7 +419,7 @@ static struct kmem_cache *perf_event_cache;
>  int sysctl_perf_event_paranoid __read_mostly = 2;
>  
>  /* Minimum for 512 kiB + 1 user control page */
> -int sysctl_perf_event_mlock __read_mostly = 512 + (PAGE_SIZE / 1024); /* 'free' kiB per user */
> +__DEFINE_GLOBAL_PAGE_SIZE_VAR(int, sysctl_perf_event_mlock, __read_mostly, 512 + (PAGE_SIZE / 1024)); /* 'free' kiB per user */
>  
>  /*
>   * max perf event sample rate

