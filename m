Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7A0FE1;
	Mon, 27 Nov 2023 21:29:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8BF6C15;
	Mon, 27 Nov 2023 21:30:41 -0800 (PST)
Received: from [10.163.33.60] (unknown [10.163.33.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E96FB3F5A1;
	Mon, 27 Nov 2023 21:29:51 -0800 (PST)
Message-ID: <a8362015-c6e6-4d59-ba2b-67dc12bd89c8@arm.com>
Date: Tue, 28 Nov 2023 10:59:49 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drivers: perf: arm_pmu: Drop 'pmu_lock' element from
 'struct pmu_hw_events'
Content-Language: en-US
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 Russell King <linux@armlinux.org.uk>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231115092805.737822-1-anshuman.khandual@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20231115092805.737822-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/15/23 14:58, Anshuman Khandual wrote:
> This series drops 'pmu_lock' usage from all arm platforms which had already
> been dropped from arm64 platforms earlier via the following commit.
> 
> commit 2a0e2a02e4b7 ("arm64: perf: Remove PMU locking"). 
> 
> Afterwards, drop unused 'pmu_lock' element from 'struct pmu_hw_events'. The
> series applies on 6.7-rc1 and has been tested on arm64. Although just build
> tested for arm platform.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> 
> Changes in V1:
> 
> - Added some build warning fixes

Hello Will/Mark,

Any updates or concerns on this series ?

- Anshuman
