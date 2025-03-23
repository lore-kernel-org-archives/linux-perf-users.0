Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79A72E337B;
	Sun, 23 Mar 2025 04:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742703751; cv=none; b=IuUDpbbD8VACYkcGRINeMagibb6w1D8XPMFIyPc7Ay0pZNAENxwRGdgXDixdU3Pdf2BJsMSKtHRE9t0+wJTHNmxHnibHE3GkcvNKCasijNXY1fuG4bPiOhnZ2gGSxoXazFT4AHT3SgQM55cqrmrhz/EQqxaBsHQKphvjiV2eKoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742703751; c=relaxed/simple;
	bh=Ujwf6dD1lwDF/XI8IOuEWxxFZqbpGszotfHhzMDjxXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTexhTB5lko4fyruJoJY3Y4C/LWtqzuBk0lFrszis0EwUTep/xBjXt31o7ZEpFwD64eyQNq82XF8cf2yEftq+yzerImnu+hhbAV/38QweWy5by+Qzgxd1b0wORDMqYwx3rpmhK8/vGp7OZhPV+vqcGzXILqHWoyX0q6GQ36cTpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ev/lUVGh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ev/lUVGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C827BC4CEE2;
	Sun, 23 Mar 2025 04:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742703750;
	bh=Ujwf6dD1lwDF/XI8IOuEWxxFZqbpGszotfHhzMDjxXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ev/lUVGha0FmtgZDGn8UH8vTk224UxzjxaeILLTO2x1NESrXxoqFARCFAwoPsNFXn
	 AHGHpXqiZ32HJ4a+Z3+fPrkQw+aZYmC4oBy6Vp9Tkn7X6Tg/fVeU/enBZme+CejerB
	 kbnMgOHXmBr4vnHx+bO47zMFpIrlw2RliQ8S9c41AoJDHWCSoHs7bHm+TYRZnMGnpO
	 tcglL1rttzwFrukBOnrfQUz37U1X4LGpeqOIn8jG4p+0KxPFb65J5bZG+13J9R++vI
	 lW/vmET3LIgZNC9WM0l2YJweIIM0ajUsbYdm9xVstCdBduFviVQugQhLDKOwsXQ2RY
	 KeBWjOstyukjQ==
Date: Sat, 22 Mar 2025 21:22:28 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, kan.liang@linux.intel.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	matteorizzo@google.com, linux-perf-users@vger.kernel.org,
	santosh.shukla@amd.com, ananth.narayan@amd.com,
	sandipan.das@amd.com
Subject: Re: [PATCH v3 tip:perf/core] perf/amd/ibs: Prevent leaking sensitive
 data to userspace
Message-ID: <Z9-MhBC27UAS6JkC@google.com>
References: <20250321161251.1033-1-ravi.bangoria@amd.com>
 <Z95lo6J37emCRvme@gmail.com>
 <7c9a00c3-b2a0-4f8a-945b-cc90e492988a@amd.com>
 <Z96qQm6qqRRcSL9j@gmail.com>
 <e54ecf69-9b44-4a15-93e9-4cf294b85584@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e54ecf69-9b44-4a15-93e9-4cf294b85584@amd.com>

Hello,

On Sat, Mar 22, 2025 at 09:09:13PM +0530, Ravi Bangoria wrote:
> >>> How well was this tested? v6.14 will be released tomorrow most 
> >>> likely, so it's a bit risky to apply such a large patch so late. 
> >>> Applying the -v1 fix was a bit risky already.
> >>
> >> I understand. Although I've done a fair bit of testing and ran perf- 
> >> fuzzer for few hours before posting,
> > 
> > That's reassuring!
> > 
> >> I'm also not in favor of rushing. I think it's safe to defer it to 
> >> 6.15.
> > 
> > I'm leaning towards sending the fix to Linus later today, because the 
> > leak has been introduced in this merge window AFAICS, via d29e744c7167, 
> > and I'd prefer us not releasing a buggy kernel ...
> 
> Sure. Fingers crossed. :)

Thanks for updating this.  As it's on top of my patch, I think the
author should be Ravi but it seems too late to fix it.

Anyway the patch looks good to me.

Thanks,
Namhyung

