Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1481E5714;
	Mon, 13 Jul 2026 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783976038; cv=none; b=GFTG5ciwjyXVf38ywyLXb/QhQOE9/UMF54AE76itvGEQQQm/8B3KDdRX51b/35xodbDF44VlZMAQDu7ZfUDRzihJ1ShRa268GrbEDvW8Ic3f/sxjzkJeHV6zba0W8MKjSxV0JlFeH5KfGG0jmuRT7dFTTANGs6l4Z4AEWHXx6sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783976038; c=relaxed/simple;
	bh=46oSs5ihVV4VRMLthpcoU82y/3Pluii6a69gC3JJe3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rasSk5h9nlxyy1t0Xt5YIHfLHt/Bwolm++dU/vHqVjV0bFai6o7XtTO3bTp1wMLlO2ODlXY9JFMIFRtC3jk9chJ40Y4ompfPEqB6PAEtSYD7FRWr4P9X3eB1Ix2Qkz+/N39Vvbjn0Ka4U76FyixHvPc8hMSeIaihrjQzFzGVwKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGN7+n8b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGN7+n8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF901F000E9;
	Mon, 13 Jul 2026 20:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783976036;
	bh=+1uK5r0kVlDHc1W8N05h7ZXVoSvHcd9K/33wkMxp/Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VGN7+n8bNf20tFNToe5LBnLJl1Vw1rGmIIwYhQt1gDIzuuoz2etzGefzpV5mMMYh2
	 X5PcIoAwDStZkC0sWFboO8WZIb0hfIGqFy3nvPKmveWITxTZI8i0W+LuDw/viaML/N
	 ONRAPLO0msPrmPlIRhAnERZdU6ljxFof9swFofvdqcs0uw4obuzGTv0k3dUoNPgqZf
	 2SJXEnJflF7E3niEOR37X4Zh3tu/SCE+2msnjJuhyoPDb3zhQZrT4yShtT36O/xIuF
	 dTYOTpoLSvPI7iwmj7tuDtyPs6FWs7DNRGihxeZ2gHx5T/aRpSQx/wpWNxiE8VOVe7
	 DvD8Fut8rp8lg==
Date: Mon, 13 Jul 2026 13:53:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf capstone: Fix build with Capstone versions before 6
Message-ID: <alVQY7uJzapcfDCr@google.com>
References: <20260713-perf_fix_capstone_build-v1-1-796ea08c04db@arm.com>
 <alUi7RgZkINlZOKP@google.com>
 <20260713182133.GC512733@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713182133.GC512733@e132581.arm.com>

On Mon, Jul 13, 2026 at 07:21:33PM +0100, Leo Yan wrote:
> Hi Namhyung,
> 
> On Mon, Jul 13, 2026 at 10:39:57AM -0700, Namhyung Kim wrote:
> > On Mon, Jul 13, 2026 at 12:08:35PM +0100, Leo Yan wrote:
> > > The commit 12c4737f55f2 ("perf capstone: Determine architecture from
> > > e_machine") added a RISC-V mapping for Capstone disassembly.
> > > 
> > > However, the RISC-V arch and mode definitions are only available from
> > > Capstone 6.0.0. Older Capstone headers do not define CS_ARCH_RISCV,
> > > CS_MODE_RISCV64 or CS_MODE_RISCV32, so perf fails to build.
> > > 
> > > Guard the RISC-V mapping with a Capstone major version check. Also use
> > > CS_MODE_RISCV_C instead of CS_MODE_RISCVC, which is the mode name used
> > > by Capstone 6.
> > 
> > Please see
> > 
> > https://lore.kernel.org/r/20260706234836.815254-1-namhyung@kernel.org
> 
> I am a bit concerned that defining the macros directly in perf is a good
> idea, since the Capstone library doesn't actually support the arch/insn
> and the macros merely work around the build.

Yep, the goal is to avoid build errors.  Actually it'll fail at runtime
and fallback to other libraries when it tries to use on RISC-V.  But I
think it should continue to support old capstones on supported archs.

> 
> Perhaps checking the Capstone version would be a safer approach?

I'm not sure.  IIUC RISC-V support was added to v5.0 and CS_MODE_RISCV_C
was changed before v6.0 is out.  Do you build capstone from source or
use a packaged version?

> 
> I have no knowledge for capstone, I will leave this to you to decide which
> is better. I tested your patch, which works well at my side.

Thanks for the test!

Namhyung

