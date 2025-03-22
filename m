Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3FD136E3F;
	Sat, 22 Mar 2025 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742645833; cv=none; b=iY70kXI4G/G4NiPBLAn2QmvZOYpteKFFfGvLPTLjQI3F9TEJ5cVzA2Bkc3x0Nu57PByEHhvt2PgT/XtoRjclpSY4txr+hQzPFGBS2JZcFfRygc4RAi5O4x+blJwQpz3voEI+/Fv7MEMRuAIZk1NBSc4L0V21ndFDVz597uj024g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742645833; c=relaxed/simple;
	bh=1oO5rlBVFMsYCFEmqfoXNtEYzWNub3FK0fEk9oA8Mms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSo+OI5Kfi9qebPExX2T4aEs30xgvysiPWQibeJazKTERxHLaT6TAy+G9e1b/UGAesoOrbRZtBZ3O60tbQFPfYI8DuJmUrTCcfQ3lqH4wnvUR4z7vYG4mpOe1PwlkJuokG7TG97tq2McjgkWcb5KWuGM6nLC1n/jpPKVIs5Lnyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFTXYrit; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFTXYrit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42562C4CEDD;
	Sat, 22 Mar 2025 12:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742645832;
	bh=1oO5rlBVFMsYCFEmqfoXNtEYzWNub3FK0fEk9oA8Mms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nFTXYritjAj9oVgrj8HLluaal4GpohOr++fEWEvseEaMSX+JEIxXcNFNcir7RiXz6
	 PVCWqYY3Hx9G47sNjb0Cf/bUH2/6/mUGM0vT0T2/uYkxiK9vo0jppBHMvKWrl1ZzrB
	 hsU/xIIJclgoqa8OsRSHbnoyx+Pt7Qhm5oVmgXy0HzEI5ecye6LyebqSOXR8dxkObE
	 OfxwgVXw5OWLCohwJmhX3uNVVRx8avSPBo1xdk7APAFjuxwl99ai+Wv5LQq51PGhOQ
	 VAZLN95rhXtZTaKaPf5oe/5JD8eJVenGbZsEr/20lc9q+WaxI6k5B2Tg/PMm+y6C5l
	 bz4JUq/7JrX0A==
Date: Sat, 22 Mar 2025 13:17:06 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: peterz@infradead.org, namhyung@kernel.org, mingo@redhat.com,
	acme@kernel.org, kan.liang@linux.intel.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	matteorizzo@google.com, linux-perf-users@vger.kernel.org,
	santosh.shukla@amd.com, ananth.narayan@amd.com,
	sandipan.das@amd.com
Subject: Re: [PATCH v3 tip:perf/core] perf/amd/ibs: Prevent leaking sensitive
 data to userspace
Message-ID: <Z96qQm6qqRRcSL9j@gmail.com>
References: <20250321161251.1033-1-ravi.bangoria@amd.com>
 <Z95lo6J37emCRvme@gmail.com>
 <7c9a00c3-b2a0-4f8a-945b-cc90e492988a@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c9a00c3-b2a0-4f8a-945b-cc90e492988a@amd.com>


* Ravi Bangoria <ravi.bangoria@amd.com> wrote:

> > How well was this tested? v6.14 will be released tomorrow most 
> > likely, so it's a bit risky to apply such a large patch so late. 
> > Applying the -v1 fix was a bit risky already.
> 
> I understand. Although I've done a fair bit of testing and ran perf- 
> fuzzer for few hours before posting,

That's reassuring!

> I'm also not in favor of rushing. I think it's safe to defer it to 
> 6.15.

I'm leaning towards sending the fix to Linus later today, because the 
leak has been introduced in this merge window AFAICS, via d29e744c7167, 
and I'd prefer us not releasing a buggy kernel ...

Thanks,

	Ingo
