Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6056A2BB1D;
	Sat, 23 May 2026 00:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779496465; cv=none; b=O89t7627SO0ywkWpxD1ldMDUNX8GJAoHDxFBqRO3wbqjdhpcnGBK+yrvE/t2C+mz26POTPS3sMqUl+2WG+SJSnYykMZc/QWmuRExiblt6G7eEW7xw1YX/7Hjc2fEueeHx6NKyCrYONegPMYD4bsw7B3uQMtJIlCj8kHqu9l4wnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779496465; c=relaxed/simple;
	bh=ntSl5IU76GACRRUM1sAkWMFAuoKIhS2vF8FEafhecSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9lU6WuNcaKGtpnETWHseRSHMxI/6XS+kWnBJnNhxztYcdBFGG2B5+D3aMEth8GxF/vG5+51oH0gyp54G7Vo+6FbxQVUvvFLmdqo8lA44YjliLyZUDSzTzbm9IrTBvy1Xic8oGY4yr8aFds78M3deDLg3EHMtkadqF33DXq0ubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNeyET/I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNeyET/I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E10B1F000E9;
	Sat, 23 May 2026 00:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779496464;
	bh=MZa0FJnwFZestBXXn2qMGSh9RE19TAiiEdYB968NsTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kNeyET/IesSwuK2wCCJ+aqgUI5D9jMY9kTPPWnONiojgktpNFpOwY/Fy+6MFnlS1+
	 BryXiiF9XJtZdoQOpPtrc12M5rcpwRVQpTVUP5HwK9sT/GYb9SxB2iviQ6NTiGMgFn
	 /zN9wDY5ViIsaMu9M4Y1rPXLJwe8y/Bil74grKTXXi5zkv+rn4kmuebQFlvcACWKHr
	 NqFylpVvi1Ns/2uA5EPltpSzVMCYJs8dPvvjA7rNGLmZ7iWnD4d40imzaRlO4S4ABl
	 x3JEr2JlUa5puY4URgqCxjKakAUixgoHPdTphVG4x/66UXUY3IVVBomlGjRy1Mg6iM
	 rmYpBgkDYdLBQ==
Date: Fri, 22 May 2026 21:34:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	James Clark <james.clark@linaro.org>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v3 0/8] perf tools amd ibs: Fixes + Zen6 enhancements
Message-ID: <ahD2DCMTqRSOyjyo@x1>
References: <20260508060004.2575-1-ravi.bangoria@amd.com>
 <agAok_vgqBrZzMhA@google.com>
 <299d7023-fbb1-4e17-8931-5bd73ffd947a@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <299d7023-fbb1-4e17-8931-5bd73ffd947a@amd.com>

On Thu, May 21, 2026 at 08:22:23AM +0530, Ravi Bangoria wrote:
> >> o Fix kernel version check in perf IBS unit test.
> >> o On Zen6 and newer platforms, skip perf unit test that assumes IBS don't
> >>   have hardware-assisted privilege filter.
> >> o Starting with Zen4, the validity of several IBS fields changes. Add
> >>   the required dependency checks when decoding IBS MSRs.
> >> o Zen6 and future platforms extends IBS OP with Streaming-Store and
> >>   Remote-Socket indicators for load/store instructions. Add decoding
> >>   support for these new bits.
> >> o Document new IBS features in perf-amd-ibs man page 
> >>
> >> IBS Zen6 enhancements doc:
> >>   AMD64 Zen6 Instruction Based Sampling (IBS) Extensions and Features,
> >>   Pub. 69205 Rev. 1.00 March 2026 
> >>   https://bugzilla.kernel.org/attachment.cgi?id=310002
> >>
> >> Patches are prepared on perf-tools-next/perf-tools-next (53bc03289278).
> >>
> >> v2: https://lore.kernel.org/r/20260430061115.10266-1-ravi.bangoria@amd.com  
> >> v2->v3:
> >>  - Instead of removing the priv modifier unit test completely, skip
> >>    it on platforms that supports hardware privilege filtering. (Namhyung)
> >>  - Rebased the series on latest perf-tools-next/perf-tools-next.
> >>
> >> Ravi Bangoria (8):
> >>   perf test amd ibs: Fix incorrect kernel version check
> >>   perf tool ibs: Sync AMD IBS header file
> >>   perf test ibs: Skip privilege test on Zen6 and newer platforms
> >>   perf amd ibs: Suppress bogus TlbRefillLat and DCPhysAd on Zen4+
> >>   perf amd ibs: Make Fetch status bits dependent on PhyAddrValid for
> >>     newer platforms
> >>   perf amd ibs: Decode Remote-Socket flag in IBS OP raw dump
> >>   perf amd ibs: Decode Streaming-store flag in IBS OP raw dump
> >>   perf doc: Document new IBS capabilities in man page
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> Thanks Namhyung.
> 
> Arnaldo, mind picking this up?

Sure, thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
