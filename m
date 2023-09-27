Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D451FD1
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Sep 2023 08:37:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D4EFCFD;
	Wed, 27 Sep 2023 01:37:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C8E41FB;
	Wed, 27 Sep 2023 01:37:46 -0700 (PDT)
Received: from [10.162.41.8] (a077893.blr.arm.com [10.162.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 082A83F59C;
	Wed, 27 Sep 2023 01:37:03 -0700 (PDT)
Message-ID: <240f888a-1394-8624-7315-8d4a198d20dd@arm.com>
Date: Wed, 27 Sep 2023 14:07:00 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V13 - RESEND 00/10] arm64/perf: Enable branch stack
 sampling
Content-Language: en-US
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc: Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
 Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Suzuki Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230711082455.215983-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 7/11/23 13:54, Anshuman Khandual wrote:
> This series enables perf branch stack sampling support on arm64 platform
> via a new arch feature called Branch Record Buffer Extension (BRBE). All
> relevant register definitions could be accessed here.
> 
> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
> 
> This series applies on 6.5-rc1.
> 
> Changes in V13:
> 
> https://lore.kernel.org/all/20230622065351.1092893-1-anshuman.khandual@arm.com/
> 
> - Added branch callback stubs for aarch32 pmuv3 based platforms
> - Updated the comments for capture_brbe_regset()
> - Deleted the comments in __read_brbe_regset()
> - Reversed the arguments order in capture_brbe_regset() and brbe_branch_save()
> - Fixed BRBE_BANK[0|1]_IDX_MAX indices comparison in armv8pmu_branch_read()
> - Fixed BRBE_BANK[0|1]_IDX_MAX indices comparison in capture_brbe_regset()

Hello All,

Upcoming V14 series is still being worked out, and might take some more time. But
meanwhile please find its corresponding development branch for experimentation
purpose, if required. Thank you.

https://git.gitlab.arm.com/linux-arm/linux-anshuman.git (brbe_v14_rc3)

- Anshuman
