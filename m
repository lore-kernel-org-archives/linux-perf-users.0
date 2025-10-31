Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1CA243968;
	Fri, 31 Oct 2025 19:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761939043; cv=none; b=b/4SPPU8Mf/ua9LMGfJW4fWgNy92WAV+nEcS8V6n4DwKnRF8mmoU6FFwMbPJvciwxh5krLrUlUnS94qlcqSqtrIb+J9YFQYEzVamMW72UHOFt4UfbipWp+XSupj9Us3lMzHIVZJ4GpyeUhV+C1/TQptTLiRW6CkE9nAqOV778xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761939043; c=relaxed/simple;
	bh=+XgHrn9U650ljmHAEWvfOR9F+8NjatIr0SZFYNe2vAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtHUd5VI4/oDpMv17QjfWP66cD5t3DzC8j/o6z/tTxCkuf1AtdwOax/Xtreh9wb3yT/Atf8nGdLTB77INPc7YwbUh4DFntROMwo+5E75C+tA5JAMTRBPGEJQLTm5FyEp6dyjp6cRpRSPPZznJcBkCFb9YSdz2M4tc3W9bdh4iFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVw6UYJy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVw6UYJy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051DCC4CEE7;
	Fri, 31 Oct 2025 19:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761939042;
	bh=+XgHrn9U650ljmHAEWvfOR9F+8NjatIr0SZFYNe2vAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sVw6UYJyPWyG5b4wz8CTsf+W0ZXun4vQ+cV93rK5SRIJTsv+yhYgTdBgUSEW42PEv
	 g1K3x0oeLrEkX2ti6s5WcGhDxc83JNUOEP1XChJbjiPmVpP0G+5ZZwJnkDcDvnu3MA
	 Lp/SpVelUWE05LI3ZsDGAQb0MSsujdRqRQ8QV+yUXVOm0KM97Ex3Uc6HIKEnS/6kuP
	 B8RV2/ymk8ZAReYhAwRz0pL4KX0tx2dnlC2MB5OGAjLjYV4kyhPiqkC05eu3ycEXI9
	 JumSJgMN+WGgmCgxO0VRi62pFL6Hfi3lJXCV0Nri0JfvSUKR4Z7IkFijgEe4WZxEI7
	 bcBsUmaG1fFmw==
Date: Fri, 31 Oct 2025 12:30:40 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: Chu Guangqing <chuguangqing@inspur.com>, john.g.garry@oracle.com,
	will@kernel.org, james.clark@linaro.org, mike.leach@linaro.org,
	leo.yan@linux.dev, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: Fix typo error in json file
Message-ID: <aQUOYLDrxBGIvKaM@google.com>
References: <20251031031729.2304-1-chuguangqing@inspur.com>
 <0016eecf-e261-a16e-461e-5f7c40705060@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0016eecf-e261-a16e-461e-5f7c40705060@os.amperecomputing.com>

Hello,

On Fri, Oct 31, 2025 at 12:25:37PM -0700, Ilkka Koskinen wrote:
> 
> On Fri, 31 Oct 2025, Chu Guangqing wrote:
> > Correct instruction spelling errors.
> > 
> > Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> 
> 
> Thanks for the patch. Just one comment, would you mind changing the subject
> line slightly. Something like
> 
> "perf vendor events arm64: Fix typo in Ampere eMag json file"
> 
> 
> With that change
> 
> Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Thanks, I'll handle the both changes.
Namhyung

