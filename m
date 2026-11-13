Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577952;
	b=yrjqyqsJCDzF3yYu/r8HokLL/W8h9C1bPvob/8wtm8hNzjrafaZmBOxPXS2ybg+ZA3si
	 2WXuFJzdvFm/wKPJJrN4jv38hXipgg+Sv7Q4z7e51Skhlamvtc0ipuHsh/R6g4GttvURl
	 hW61bdBImJ4u18v9ttrK4EXlDkOXoL8+U1QoQmg125r7iToKPt9ESGn3m9XTx3azw+/hr
	 vBvpHVRlKhjP8/laZRvURdahMGSeWupkDW7KRScKZTUtaTROS3TTKjgDQxibjiB3xhK2L
	 HaUDFDUhow6bIJFz3vgznXnwyp2IvhJtIWY+uMWYyyQSNlBTQv6k3pT9tD7DM5J0f0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577952;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=VX6NivkNDw4hja3NGJ+ZXqNLDCvbS+Hd4oeNtpdmzk4=;
	b=VFp8zDD+wE4OVJYdkiatr2tBkDFz5aQ0uOs1o6vm2b59py9uvNznlBky3rVRlu8+HOr4
	 s++62yi4sz9uBGApsxhsYIg1IgB4gHfc3PIIJe+D1dY26kRy9RIC5tjpZC3T/o7Cox1WG
	 mZ/ZBYOmfBpV5cCFvdzBZQW07dJ/v8V7cpxrU1tNByVdnBuAyGS79oa1iMwyEfKTJTWKp
	 psqwRTL1TgDzvQ+1FuVs283R84mYmSFysevXGwIcILEsv1PC2EjPx4/99gF+qrtDWigvQ
	 8SGwFYzcR38WsSN/SWvrTX7A9p2CYNsR62Y7lyAJifuB3vkspPVFbd0HrndrCRgfsWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="c/f2xVxE";
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B429660A6F7D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B429660A6F7D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=c/f2xVxE
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 900C61476;
	Fri, 13 Nov 2026 05:52:27 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E58C3F85F;
	Fri, 13 Nov 2026 05:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794577950; bh=6FQ9aA/l2unkEdVSFcw7txZ/ISl0sJr+mEELSjhAS+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/f2xVxEs5Jbp3BtbMnkqEsqpdtqRNFdGnH5ipXKthqRuXwFPrLubVnR2IGJ0latd
	 PSerjsmTSC0/Drel5RnVRwkVZvp4SLo9Kcpmk4K6YxTGn2o20uXIkHR4wvxb6pbyHU
	 w8t2xJl3+Kj7fWDVf94drDH+xQ33jKwYD4o3l2NU=
Date: Fri, 13 Nov 2026 13:52:28 +0000
From: Leo Yan <leo.yan@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/3] perf cs-etm: Check frontend instruction reads
Message-ID: <20261113135228.GP9176@e132581.arm.com>
References: <20261113-perf_fix_gcc15_failure-v1-0-eae592c5ff64@arm.com>
 <20261113-perf_fix_gcc15_failure-v1-3-eae592c5ff64@arm.com>
 <sashiko-outbox-212661@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-212661@kernel.org>

On Fri, Nov 13, 2026 at 11:03:02AM +0000, sashiko-bot@kernel.org wrote:

> [Severity: Medium]
> This problem wasn't introduced by this patch, but can
> cs_etm__synth_instruction_sample() and cs_etm__synth_branch_sample() leak
> sample resources when event injection fails [1]?
> 
> Both functions initialize sample with perf_sample__init(&sample, true),
> which allocates sub-structures, and then return early before
> perf_sample__exit(&sample) if cs_etm__inject_event() returns an error:
> 
> tools/perf/util/cs-etm.c:cs_etm__synth_instruction_sample() {
> 	...
> 	perf_sample__init(&sample, /*all=*/true);
> 	...
> 	if (etm->synth_opts.inject) {
> 		ret = cs_etm__inject_event(etm, event, &sample,
> 					   etm->instructions_sample_type);
> 		if (ret)
> 			return ret;
> 	}
> 	...
> 	perf_sample__exit(&sample);
> 	return ret;
> }

Seems this comment is not valid on perf-tools-next. perf_sample__init()
does not allocate sub-structures.

> [Severity: Medium]
> This problem wasn't introduced by this patch, but can cs_etm__sample() spin
> forever when the user specifies an instruction sample period of 0 (for
> example, --itrace=i0i) [2]?
> 
> The loop condition is:
> 
> tools/perf/util/cs-etm.c:cs_etm__sample() {
> 	...
> 		while (tidq->period_instructions >=
> 				etm->instructions_sample_period) {
> 			...
> 			offset += etm->instructions_sample_period;
> 			tidq->period_instructions -=
> 				etm->instructions_sample_period;
> 		}
> }
> 
> Because both operands are unsigned, tidq->period_instructions >= 0 is
> always true and subtracting 0 never reduces tidq->period_instructions.

It will infinitely loop with "--itrace=i0i", but this is a usage
problem. We can reject it in common code with a separate patch.
This is no matter with current change.

> [1] https://sashiko.dev/#/bug/linux-313ce3d0-12d6-4671-8007-6e3925af60fc
> [2] https://sashiko.dev/#/bug/linux-88c200a9-e322-487b-904a-28d581ccee8b
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261113-perf_fix_gcc15_failure-v1-0-eae592c5ff64@arm.com?part=3
