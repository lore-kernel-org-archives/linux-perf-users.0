Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871616F2E6;
	Thu, 30 May 2024 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717063392; cv=none; b=gpxsuFhN3VNKNxwno0XDzVoZnn0HfK1IH1Ha3IfI+5RqRq8YekFTI+/MO3Aji/Hao+qWPls52Z6eTRDtuAZD2d0RZY7qel615WqwglfyD3fZo+2vU3i0PK6MriE2IyKNezqjR3w9J15lk4SaO/hjyO4eK+AFZj6mpvYbfpfn7Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717063392; c=relaxed/simple;
	bh=OUn7iuxuw7dEQyjT1Zqqm9Q0bZLJ5YwLkhbMQ3hWXmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1suG7CdT506IGKMWThNElPFffCMMTGuL81AoDFLkYmQZIPREeLVFWdRUmrYfLe8z4V0chN9grZYAlCL77lbjbvLUH+msB9yeg3Dk/1H5jAjULe8DF4ibLTVwSk6DVA/s0s10Pzq8nooG9Ak6RBaKGqUYKy/0syDmHfULDKWecY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2826E339;
	Thu, 30 May 2024 03:03:34 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 317CE3F792;
	Thu, 30 May 2024 03:03:08 -0700 (PDT)
Message-ID: <5f8fdfd2-a4f9-4fde-ad24-3b76231e61c8@arm.com>
Date: Thu, 30 May 2024 11:03:10 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V17 0/9] arm64/perf: Enable branch stack sampling
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Suzuki Poulose <suzuki.poulose@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com,
 mark.rutland@arm.com
References: <20240405024639.1179064-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240405024639.1179064-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/04/2024 03:46, Anshuman Khandual wrote:
> This series enables perf branch stack sampling support on arm64 platform
> via a new arch feature called Branch Record Buffer Extension (BRBE). All
> the relevant register definitions could be accessed here.
> 
> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
> 
> This series applies on 6.9-rc2.
> 
> Also this series is being hosted below for quick access, review and test.
> 
> https://git.gitlab.arm.com/linux-arm/linux-anshuman.git (brbe_v17)
> 
> There are still some open questions regarding handling multiple perf events
> with different privilege branch filters getting on the same PMU, supporting
> guest branch stack tracing from the host etc. Finally also looking for some
> suggestions regarding supporting BRBE inside the guest. The series has been
> re-organized completely as suggested earlier.

For guest support I'm still of this opinion:

  * No support for the host looking into guests (the addresses don't
    make sense anyway without also running Perf record in the guest)
  * Save and restore the host buffer and registers on guest switch (if
    it was ever used by either host or guest)
  * Let the guest do whatever it wants with BRBE without any
    virtualisation

Merging this with the current PMU virtualistion stuff seems like a lot
of work for no use case (host looking into guests). Having said that, it
might not even be worth discussing on this patchset apart from "no guest
support", and we can do it later to avoid confusion that it's being
proposed for this version.

James
