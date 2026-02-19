Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87F628DC4;
	Thu, 19 Feb 2026 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771505874; cv=none; b=Z3EFtkIpxcne04Lu/pJozAi2wsptHETOvhTd2BlpjTDe55+DnQpOWarS3vp2pY64pGAb6YDPgORm6SQQ2KZo0KxG5TdAnZDgQ/J6hrep0VlsyZHqC2vnUYhrmdi/+hYtewvJzhTTLcFDGUC4cWMUjuo9urXc9LBq6SdGuEWOrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771505874; c=relaxed/simple;
	bh=jpZTDBxRqP3+2aDtWWPQ+jOqOlSnzz+w78qLLpTsI6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1AZUPPXK8Sg+hnzjvXNZeUlVLKGDwxMGfCdGHoRFQyjub2XjIx0Zamwdqmus/BtgiGXAaGkdWvMNm+s/kylQhp3fzqA630DkG+eD2IC0gky1nlogXSfViLH6nZ/enmVa7MU7KIqiTPUOTWxCvEGkpNvieSxlQptB+vbUkqj1zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2aEOl0F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2aEOl0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68F8C4CEF7;
	Thu, 19 Feb 2026 12:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771505873;
	bh=jpZTDBxRqP3+2aDtWWPQ+jOqOlSnzz+w78qLLpTsI6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2aEOl0FOR23XvFymiX0dandFEhCqzlrQyKXXOL9dWHJZiyWklKlI1R6nT3P1Q7AR
	 5c/ctxxOad7CgaYuB2Zh/4kGDtLnF5ufXabj7+tX61sqMlIEYMJFkOFMUbOlvlabWh
	 sxuh2wekeblkYTlRqKlkK0sIXB1qO98+sjFwkrT+a37SpHRiIhIOJsImPL/ILJ1+Zz
	 ncB2GM6h9atW+4sMo0OSbpqf3aYu3VE0t+S8hu0p4C7JbAz2U+deumrdCTkw5fqVBh
	 CzSDob5JTmZttbVTjvER4zxuOOc0kxadyztgHpAV45OR/cvduZX529IE2pam+RnjnG
	 SB6ytYoZWfRng==
Date: Thu, 19 Feb 2026 12:57:47 +0000
From: Will Deacon <will@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Michael Williams <Michael.Williams@arm.com>,
	Alexandru Elisei <Alexandru.Elisei@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <Anshuman.Khandual@arm.com>,
	Rob Herring <Rob.Herring@arm.com>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>,
	Robin Murphy <Robin.Murphy@arm.com>, Leo Yan <leo.yan@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_spe: Add barrier before enabling profiling
 buffer
Message-ID: <aZcIy1Or4c5-i7Tm@willie-the-truck>
References: <20260123-james-spe-relaxation-v1-1-4ccb88fa7bc5@linaro.org>
 <aYD08d42SewAAQCB@willie-the-truck>
 <aebe99ad-1189-4372-83e3-385f33829bd2@linaro.org>
 <aYHXCkFZcVm1L_25@willie-the-truck>
 <e7d53952-59f6-4990-83fb-1182641af29f@linaro.org>
 <705acb39-2eef-4e61-aec1-b9503e788299@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <705acb39-2eef-4e61-aec1-b9503e788299@linaro.org>

On Thu, Feb 19, 2026 at 12:08:27PM +0000, James Clark wrote:
> I'm back to drag this up again. So I think all of the above discussion
> relies on the ordering given by the indirect read needed for the "might
> ignore a direct write..." part. But it's _might_ ignore a direct write, it's
> possible for an implementation to not do that, so there are two possible
> implementations:
> 
> #1 Where there is an indirect read to give the write ignore outcome
> #2 Where there is no write ignore outcome so it doesn't require an
>    indirect read
> 
> For #2 there's nothing to force the ordering. We're writing to two different
> registers (PMBPTR_EL1 and PMBLIMITR_EL1) and we have to have the
> PMBLIMITR_EL1 write come second for the buffer to be considered configured
> correctly. For example if the old value of PMBPTR_EL1 is higher than the new
> PMBLIMITR_EL1 and the write to PMBLIMITR_EL1 happens first then it's
> misconfigured. That's why we think we need the isb() here.

I thought profiling was disabled in these cases, so why is it
misconfigured?

If it is misconfigured, what can go wrong given that we're either stopped
or pmscr is clear?

Will
