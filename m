Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9382B376484
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Feb 2026 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771927682; cv=none; b=oHXbvNlnFDzMuCieqCV4omjoeY2WBuxvKo2fPX425XbvxCh3dcanxs+JGM+9WEj6vuZGnkut0gS9PM7AYcgB+zlY1yzmQvAoEP0WFQCSgLVNLjRwR6pJXsQiSiht75ZGqOhPaD4/TxPcH/kqjwfVyXAeXeSEGGTQxFFPyugYyJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771927682; c=relaxed/simple;
	bh=mR6HqRVWWpOs34CJA2DnC7eeEeBQcBTcuRFhy3FpjS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AemgjsRgzCyKCWSLMab3cM/XQNxTjRdVVd0JHd+PKwVLC5FNmOduT3vxBk7nPhf6w2jySsoq5cL1w4mvSkKDQz8ZXu1YEJXHwnrwsgwo5SDGOxwOc0zvh/jDdykzG/3eHYVl2BTO2P4vT2dGT3dYbZshnm+35cIBeTa2E1NXYlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F776339;
	Tue, 24 Feb 2026 02:07:53 -0800 (PST)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 628B03F62B;
	Tue, 24 Feb 2026 02:07:58 -0800 (PST)
Message-ID: <10f10659-448c-404e-87cd-0c110f895b11@arm.com>
Date: Tue, 24 Feb 2026 10:07:56 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm-cmn: Stop claiming entire iomem region
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-perf-users@vger.kernel.org, ilkka@os.amperecomputing.com,
 James Morse <james.morse@arm.com>
References: <b6275655818f5af7e5fb07a9e18d1451b08b7e05.1771522073.git.robin.murphy@arm.com>
From: Ben Horgan <ben.horgan@arm.com>
Content-Language: en-US
In-Reply-To: <b6275655818f5af7e5fb07a9e18d1451b08b7e05.1771522073.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Robin,

On 2/19/26 17:27, Robin Murphy wrote:
> So far, the PMU has been the only thing of interest in the vast mass
> of CMN registers, so we've gotten away with simply claiming the entire
> iomem region. However, now that we can support other features like MPAM
> controllers for the system caches, the PMU driver needs to stop being
> selfish and learn to share. Similarly to arm-ni, requesting just the
> DTC node(s) should suffice for staking our exclusive claim to the PMU>
features, as requesting hundreds of tiny regions for all the individual
> pmu_event_sel registers is definitely not worth the considerable bother.
> 
> As a consequence, we can also streamline the annoying CMN-600 special
> cases even more. The ACPI binding has in fact always specified a strict
> order for all resources, so we can reasonably drop the ancient pretence
> of swapping base and cfg, which IIRC was more just a moment of doubt on
> my part than anything else.
> 
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Without this patch applied and with mpam enabled cmn fails to probe:
dmesg | grep cmn
[   17.409588] arm-cmn ARMHC700:00: error -EBUSY: can't request region
for resource [mem 0x140000000-0x17fffffff]
[   17.409601] arm-cmn ARMHC700:00: probe with driver arm-cmn failed
with error -16

With the patch I don't see any cmn errors and it probes.

$ tree -L 1 /sys/devices/platform/ARMHC700\:00/
/sys/devices/platform/ARMHC700:00/
├── arm_cmn_0
├── driver -> ../../../bus/platform/drivers/arm-cmn
├── driver_override
├── firmware_node -> ../../LNXSYSTM:00/LNXSYBUS:00/ARMHC700:00
├── modalias
├── power
├── subsystem -> ../../../bus/platform
└── uevent

Tested-by: Ben Horgan <ben.horgan@arm.com>

Thanks,

Ben

