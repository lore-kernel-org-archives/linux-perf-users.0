Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890500;
	b=0h5+UsiAlAeFiuWgH9Xw3Igi0IlZ6QdodL7ixcWeQvWqJVeXDeCdniEo+bQPBDs/MMLx
	 KBoKvfNhjECJMuq6CrIJZFGvRS58Mbc9bjAw34izErDqOGa9ZLjGSOCjq6DeL7ZVe+Y+F
	 Bpt6LC9qB7Tkgc+orgjVTpgX/9aJxp5c31/kbOWzdWw8SNIsOUmWC+bJFMgCIYi+QC/Vm
	 RDUfvL5vPxFj4yXKs3hjHsplMW0tfOGSG7slW2A1b6uQEV4a2ZxraM/RHme3G1VMqdqvR
	 5+AJD2m05AUg5ojQSUq9eCv9G9Ec+iZmTILtiA/Ium6fKpoOHRgH/cZKbxw5vyhEGDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890500;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=lMUN+xrYwfUilVGUkr08RcCdBhNpdwdDbuRbBKh66bI=;
	b=ku6rMktMlfyHGJFv29uTSij7ZIC0o/9r1sze0wQIV9nIrw6hx6jnhh8r/jXe3VR/ywnD
	 FpzxDgE0ZrOQadWvVu2ArvRdRFYFMR+QxSxTbTMxuveay2enI3WnnrDklHlMUAApWmD5V
	 TDIXgVeZVDkG0GwYYZbAzF+RQSO5nDLDnkPJfEQG0b8zpzIWRt/TDgJ9EODQwd/9s/mFA
	 iAQHFnxofEEDUKvIDgwDh/eqodtDwHLRVhDrD0lokSgfZ+8rYuQ/dAqv+aZrS0p9zONT7
	 GBb/RKikjos0jLN/89aBqdlw1yNXIgtGNBYwH5F4NdwIz0qODwax68t8W/nigs6v9RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="cfoa0iQ/";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA132606A31B;
	Thu,  5 Nov 2026 14:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA132606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=cfoa0iQ/
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33039168F;
	Thu,  5 Nov 2026 06:54:56 -0800 (PST)
Received: from [10.2.197.99] (ewhatever.cambridge.arm.com [10.2.197.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0DBE3F632;
	Thu,  5 Nov 2026 06:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793890499; bh=BHV2xnfEREO1PuiaY/msWQZl+g5su3hEZwIcHuKszOE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cfoa0iQ/wLbaM/wUFNF6yhe0347tlMbx+10T4E3cFVvKkbcECt68p2+g3KvnuS1L1
	 TUbxpPXPqrpdZ3WrgfpBlir0EXoT9q32sIUqUAMRFb90dLbvNIgUVbL+Hq+QEyfTYL
	 FjNFds86xP7/OanwfWPmYNF1BOp1/YxJO9lc8o1A=
Message-ID: <a876b77b-c4e4-4019-868a-af12c93f441f@arm.com>
Date: Thu, 5 Nov 2026 14:54:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] perf: arm_pmuv3: Add pmuv3_event_implemented()
To: Amir Ayupov <aaupov@fb.com>, James Clark <james.clark@linaro.org>,
 Leo Yan <leo.yan@arm.com>, Mike Leach <mike.leach@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Daniel Pereira <danielmaraboo@gmail.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1792907332.git.aaupov@fb.com>
 <cover.1792989860.git.aaupov@fb.com>
 <23ffe461b8d7b04f78118154dfc9ea1d2a14978a.1792989860.git.aaupov@fb.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <23ffe461b8d7b04f78118154dfc9ea1d2a14978a.1792989860.git.aaupov@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/10/2026 05:48, Amir Ayupov wrote:
> Drivers outside the PMU driver may need to know whether the local CPU's
> PMU implements a common event before relying on it, for example a trace
> unit driver checking that the PMU counts its external outputs as
> TRCEXTOUTn.
> 
> Add pmuv3_event_implemented() to the arm64 asm/arm_pmuv3.h, next to
> read_pmceid0() and read_pmceid1(). It reads PMCEID0/1 on the calling CPU:
> events 0x0000-0x003f are reported in bits [31:0], and the common events
> from ARMV8_PMUV3_EXT_COMMON_EVENT_BASE in bits [63:32] from PMUv3p1. Move
> ARMV8_PMUV3_EXT_COMMON_EVENT_BASE next to the event numbers in
> linux/perf/arm_pmuv3.h so it is available without CONFIG_ARM_PMU.
> 
> Suggested-by: James Clark <james.clark@linaro.org>
> Assisted-by: Devmate:Opus-5.5
> Signed-off-by: Amir Ayupov <aaupov@fb.com>
> ---
>   arch/arm64/include/asm/arm_pmuv3.h | 19 +++++++++++++++++++
>   include/linux/perf/arm_pmu.h       |  1 -
>   include/linux/perf/arm_pmuv3.h     |  3 +++
>   3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
> index 8a777dec8d88a..acd62c4f16743 100644
> --- a/arch/arm64/include/asm/arm_pmuv3.h
> +++ b/arch/arm64/include/asm/arm_pmuv3.h
> @@ -173,6 +173,25 @@ static inline bool pmuv3_implemented(int pmuver)
>   		 pmuver == ID_AA64DFR0_EL1_PMUVer_NI);
>   }
>   
> +/*
> + * Whether this CPU's PMU implements a common event, as reported by
> + * PMCEID{0,1}: events 0x0000-0x003f in bits [31:0], and from PMUv3p1 events
> + * 0x4000-0x403f in bits [63:32], which read as zero before PMUv3p1.
> + * Must run on the CPU whose PMU is queried.
> + */
> +static inline bool pmuv3_event_implemented(u16 event)
> +{
> +	bool ext = event >= ARMV8_PMUV3_EXT_COMMON_EVENT_BASE;
> +	u16 id = ext ? event - ARMV8_PMUV3_EXT_COMMON_EVENT_BASE : event;
> +	u64 pmceid;
> +
> +	if (id >= 64 || !pmuv3_implemented(read_pmuver()))
> +		return false;
> +
> +	pmceid = id < 32 ? :() : read_pmceid1();
> +	return pmceid & BIT_ULL(id % 32 + (ext ? 32 : 0));
> +}
> +
>   static inline bool is_pmuv3p4(int pmuver)
>   {
>   	return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P4;
> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index 02d2c7f45b527..792283d29d7b5 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -124,7 +124,6 @@ struct arm_pmu {
>   	u64		reg_brbidr;
>   #define ARMV8_PMUV3_MAX_COMMON_EVENTS		0x40
>   	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
> -#define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE	0x4000
>   	DECLARE_BITMAP(pmceid_ext_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);

Could we not avoid this change ? Or why not move both of the definitions ?


Also, I would need an ACK from the arm_pmu maintainers to accept this
change via coresight tree.

Cheers
Suzuki


>   
>   	/* Only to be used by ACPI probing code */
> diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
> index d698efba28a27..c21f185a283d6 100644
> --- a/include/linux/perf/arm_pmuv3.h
> +++ b/include/linux/perf/arm_pmuv3.h
> @@ -78,6 +78,9 @@
>   #define ARMV8_PMUV3_PERFCTR_STALL_SLOT_FRONTEND			0x003E
>   #define ARMV8_PMUV3_PERFCTR_STALL_SLOT				0x003F
>   
> +/* Base of the common events reported in PMCEID{0,1}[63:32] from PMUv3p1 */
> +#define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE			0x4000
> +
>   /* Statistical profiling extension microarchitectural events */
>   #define ARMV8_SPE_PERFCTR_SAMPLE_POP				0x4000
>   #define ARMV8_SPE_PERFCTR_SAMPLE_FEED				0x4001

