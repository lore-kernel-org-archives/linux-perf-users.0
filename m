Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667923A0E8D
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Jul 2026 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258979; cv=none; b=pjB5TWggkeZuEAm05xRUvzff28pvYzey6eZg9hBxAFC4V1Xj+hAuRvYP752//UrmrcD28Tr+5BAspt64wfNeutSUJ3sZhDJsgqLZbb20jjU83aQiFSxbwuNPuVSBt0Dsh0R6I59E7iIvYi78Mn8CTtHRs0bN7GFw3w4s2vjb5Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258979; c=relaxed/simple;
	bh=46ScApkIrDTtWkBCjlYJLkYvszohTk3t/IW3MVAcULE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZuhVLsVjR0SIvq9ooSnY2NJLxnYza99w7pqEkSH/2v7pl71zZ0MYlqsUHscTCbsoTrO3VHHbOJ+yPoey55vL5ZLwNjZJSm7QW1CFU3IpKAncENw7OTj4q3i4DBN3rfV+u2ewKStefamjxkjCF+0SRqNws6L3qvDIffCdD0FJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Ds4p05cm; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Ds4p05cm"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82AEA169E;
	Tue, 28 Jul 2026 10:16:11 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28F393F763;
	Tue, 28 Jul 2026 10:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785258975; bh=46ScApkIrDTtWkBCjlYJLkYvszohTk3t/IW3MVAcULE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ds4p05cmxAUMGd0qH8xkhFzgl/z0v3Whviz+LjKwqVFBB+moXzZ1xDGJbiU2Ebe9U
	 jGzKaQgab/q/G1CEQPfTQ2stD44X51ootCply1fzqBPKk2VLCVJ6yxQrU80qJW/Cke
	 bndOkWpjOzBmwP8PH68ZilqJz5tvh6zjx8p4qgP8=
Message-ID: <fe126e13-440b-4c0b-8e38-4dbcfd3f7846@arm.com>
Date: Tue, 28 Jul 2026 18:16:13 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] perf/arm-cmn: Support CMN S3 r2
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1785252273.git.robin.murphy@arm.com>
 <86b7093bc5de0f2aedc63fc4826ce911cb22d16f.1785252273.git.robin.murphy@arm.com>
 <20260728165737.0B5DA1F000E9@smtp.kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260728165737.0B5DA1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/07/2026 5:57 pm, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] The virtual channel count fields (rsp_vc_num, dat_vc_num, snp_vc_num, req_vc_num) in struct arm_cmn are defined as 2-bit bitfields. The patch adds support for CMN-S3 R2, which uses 3-bit values for these counts in the hardware registers. When extracting these 3-bit values and assigning them to the 2-bit bitfields, values of 4 or higher are silently truncated. Consequently, in arm_cmn_event_attr_is_visible(), the truncated value incorrectly evaluates as < 2 (e.g., 4 truncates to 0), falsely hiding valid PMU performance events from userspace.

Anyone who has a beef with the ID register field being 3 bits when the 
relevant control register field is only 2 can take it up with the CMN 
design team. After previous lessons learned I'm choosing to leave room 
in the UAPI just in case...

> Pre-existing issues:
> - [High] In arm_cmn_discover(), the 16-bit field cmn->num_dns accumulates the number of child nodes across all XP nodes using MMIO values (CMN_CI_CHILD_COUNT). Since CMN_CI_CHILD_COUNT is a 16-bit field, accumulating multiple of these can overflow the 16-bit num_dns field. This wrapped value is used to calculate the size of the kernel heap allocation for the dn array (devm_kcalloc). During the second pass, the driver re-reads the un-wrapped hardware child counts and linearly writes to the dn array inside the loop, severely overflowing the undersized heap allocation.

But what if it was a 64-bit field and the child counts still overflowed 
that? WHAT THEN? Oh noes we are doomed! Quick we must reimplement Linux 
in multi-precision arithmetic forthwith!

Robin.
