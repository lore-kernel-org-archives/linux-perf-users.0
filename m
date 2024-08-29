Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B39189B9C
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Aug 2024 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724918121; cv=none; b=IBYL3/7/5gU40hhhTBIjUq2hEHCQNWJm6UvGnw5h8NRX7nHqNJjKwdRZaqdF2WDpDMRMbkX0Nyy/wteaI1/C2l2Zvsj/jbbdY4C+WnDFQ0b3o3z59piIN1aBnxigoZZr0gFCHcJT+gnLJn/dqrg0IP9lDvriL86hpfLndPErq9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724918121; c=relaxed/simple;
	bh=K0o02O8DVvv91hN1WB6kKOwfSjpr+oxaVI/9Fwl54mI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDaqpOZ4HDN20M/itpUQU30e9E6l2OFhhkcyA1LjB1lR8i+E7oV/fuT+yhBM8aeJ7wXcb8jSKo3yOeWVvfWM126SroZw0+Hq5HIwJEuLa/ejYF1WsCNphUwSdExLGLHxGqvoWnbmjzSHQvtH98g5bMbO0gO6hpVVRUrfPsz1Y0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBB7ADA7;
	Thu, 29 Aug 2024 00:55:44 -0700 (PDT)
Received: from [10.57.87.105] (unknown [10.57.87.105])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BCA73F73B;
	Thu, 29 Aug 2024 00:55:17 -0700 (PDT)
Message-ID: <35c19a0f-580a-4d97-b0d4-b8708a4dbdb4@arm.com>
Date: Thu, 29 Aug 2024 08:55:07 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 0/4] arm-cs-trace-disasm.py/perf must accommodate
 non-zero DSO text offset
To: Steve Clevenger <scclevenger@os.amperecomputing.com>,
 james.clark@linaro.org, mike.leach@linaro.org
Cc: suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
 coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1724879699.git.scclevenger@os.amperecomputing.com>
 <cover.1724879699.git.scclevenger@os.amperecomputing.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <cover.1724879699.git.scclevenger@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/2024 12:17 AM, Steve Clevenger wrote:
> 
> Changes in V5:
>   - In symbol-elf.c, branch to exit_close label if open file.
>   - In trace_event_python.c, correct indentation. set_sym_in_dict
>     call parameter "map_pgoff" renamed as "addr_map_pgoff" to
>     match local naming.

For the series:

Reviewed-by: Leo Yan <leo.yan@arm.com>

Hi Steve,

Later when you respin a new version patches, it is better to amend the review
and ACK tags you have received. (Just remind, b4 is your friend for helping do
these things).

Thanks,
Leo
