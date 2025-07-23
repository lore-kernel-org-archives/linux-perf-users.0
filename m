Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81E4335BA;
	Wed, 23 Jul 2025 01:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753233191; cv=none; b=tPc7C9DumCafcJmUUZF0MU8/W6fQsDN4j32vYU6iYgQuBt6tWWgSocBb26nWyCF4XLGymh+MxWwG9HnaJS3qiSvHm1JUm4L657dk0Hyxi6ygT/zXF7DiuIzxl+ZkG3AUCVRoXN+/m1/i0HwPqaA9PRrlbakaPPWWKSOzm3Lyo00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753233191; c=relaxed/simple;
	bh=1/95MvPMbuTsd0UVAgsSIcwQjNv3V2i2sZ+7lHodDxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beFLEjCOqrPg70K5bLB7NLkU8M8g67DZjMHjBlaJ/Yz5R/km4tmHB+FkyvLjFRTbp/U7kBZl+lDaUlBXSK8Z6S8mt/f1bxjLfdChHZLt1sF92GPzJ5y2n+Q6nMr6AnprngqLi5oqwlOU172F8g5Vn/B5cKVqDSj4KpjnGnq5JFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pss0V7b+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pss0V7b+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDEFC4CEEB;
	Wed, 23 Jul 2025 01:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753233191;
	bh=1/95MvPMbuTsd0UVAgsSIcwQjNv3V2i2sZ+7lHodDxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pss0V7b+w1vmxjgW2N0SpuW4xPC1ePxKYUeDpVlbPP7Ab3mFRYYX7/bvPEVVntl4M
	 EF3l+2VYVjubX+j4DUcA8+fcqLl0hutE4rWwn01/L6w6lGeQyjkngJs2wlfdaS6FMU
	 5zuV21X/DnK5a6iQku/nd+wFJQj+6TCL2bs9RC+gnMfWvUanJaPvzgxoWmkMG5aVji
	 wI6SN9nx+yFexX8k3MMO/tXav4cEcxG44auePe2k/wpKL5HhNV07NM8QoON9vbPumh
	 /sG4U5Q3YAMj5wYJL39NM8k8+TzeOLGRr7wHQ9U/Krgn9hIPUMkPqJ0fM50Vic2RjP
	 6Pu4YLbYcbE3Q==
Date: Tue, 22 Jul 2025 18:13:09 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Suchit K <suchitkarunakaran@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	sesse@google.com, charlie@rivosinc.com,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] perf tests: Fix lib path detection for non-x86
 architectures
Message-ID: <aIA3JQWNs-0Jsla4@google.com>
References: <20250720085905.192652-1-suchitkarunakaran@gmail.com>
 <aH20-KEurjw5qJq0@google.com>
 <CAO9wTFhdgHEFQDVt2715qP6-6bsE9+AeAAPYe4C8N1mqpy7g=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO9wTFhdgHEFQDVt2715qP6-6bsE9+AeAAPYe4C8N1mqpy7g=Q@mail.gmail.com>

On Mon, Jul 21, 2025 at 11:10:18AM +0530, Suchit K wrote:
> >
> > A dummy question: Does all other architectures have lib64 vs lib
> > separation?
> >
> 
> I had assumed there would always be symlinks, but thanks for pointing
> that out. After your question, I checked various architectures like
> x86, ARM, SPARC, s390x, etc and only x86 had both lib and lib64 (with
> symlinks). On the others, even for 64-bit systems, only a lib
> directory existed. I also realized this behavior seems to depend on
> the distro. For example, multiarch distros like Debian use separate
> directories for lib32 and lib64, and a lib symlink pointing to
> /usr/lib. On the other hand, Arch Linux has both lib and lib64 as
> symlinks to /usr/lib. Would it be reasonable if we create a symlink
> named lib64 for non-x86 architectures? I'd appreciate your thoughts on
> this. Thanks!

I'd be intrusive if we create a new symlink.  Probably we need to check
if there's lib64 directory first and use it for 64 bit build.  But I
feel like this needs more testing.

Can you share what's the problem exactly?

Thanks,
Namhyung

