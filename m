Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B83F2940F;
	Sat, 17 May 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747470179; cv=none; b=s/JEKOKaF+CyT4pfIRs+79+yFd6P8Rb0GzKcmAdTIRYIzvy/tlNPZPZ9VgwCFTUsopVT1OjjQgg+vNFbUYWNUTwTIakNO72iDVkQlILBNn6lRCCeD8uQRYcczfOY7XuDo4IpBNs5qf8PAgXEq9vI/8ftEzNT2/SW99om1BcNa0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747470179; c=relaxed/simple;
	bh=rzXTvu62Z3aOeZFeAXo1t87ggAk+IPXBvmBKwn5LfFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVcX4uCEt8IvFN3kd3AWCiP6GNiX7R3u0dvWXm+Fa/zjoY0RFRIC3mnbJNYID30qd5ST2YGAUZUh1lZQBpwSq+GKhtiDV0SOWCPOx07WO/E0YGcGO0w34P9ox8+6YMv/dPmXz7pTuzotZDaYuNOGEXWEefeR1r3XFUy96KsqcIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhw9qIRm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhw9qIRm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D68C4CEE3;
	Sat, 17 May 2025 08:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747470179;
	bh=rzXTvu62Z3aOeZFeAXo1t87ggAk+IPXBvmBKwn5LfFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hhw9qIRmQWPN/aB3/mCv3ib3a3gFtNMkSWG4hCh9GxsL+xtYnLFvCMGQaR6dIzfma
	 QeXG3+hALhzksqd/ghHUFH3p6Yje4DrnUFROEzLc3EKvOxYT8aK0J6y/GFJMAVxrwC
	 WT4qJ6jmxRjKvR0PNwmPgYIfYWp9C2KscYW2Qe0HAitF8SVxp5EBvgZ5TJbFeYkduU
	 aZ/6reAFy0YOOpiBqPsIFpDk8uNwdPi3I+ecf+IonWCT2/Mz2OWCMkqVB4+2NVSypb
	 rZRABhW93cO0DVOLhxm6WKECcYLVJlLDdwr1GzTDV5bFA6wTpykYJIB/eUWpRuhC7G
	 j3TbSBh4u7i9Q==
Date: Sat, 17 May 2025 10:22:53 +0200
From: Ingo Molnar <mingo@kernel.org>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	irogers@google.com, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	eranian@google.com, ctshao@google.com, tmricht@linux.ibm.com,
	leo.yan@arm.com
Subject: Re: [PATCH V3 02/16] perf: Fix the throttle logic for a group
Message-ID: <aChHXShBhoDBgPX7@gmail.com>
References: <20250516182853.2610284-1-kan.liang@linux.intel.com>
 <20250516182853.2610284-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516182853.2610284-3-kan.liang@linux.intel.com>


* kan.liang@linux.intel.com <kan.liang@linux.intel.com> wrote:

> The throttle only happens when an event is overflowed. Stop the entire
> group when any event in the group triggers the throttle.
> The MAX_INTERRUPTS is set to all throttle events.

Since this is a relatively long series with a healthy dose of 
breakage-risk, I'm wondering about bisectability:

 - patch #2 auto-throttles groups, ie. stops the PMU

 - patches #3-#16 removes explicit PMU-stop calls.

In the interim commits, will the double PMU-stop in drivers not updated 
yet do anything noticeable, such as generate warnings, etc?

Thanks,

	Ingo
