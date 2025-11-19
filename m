Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22005184E;
	Wed, 19 Nov 2025 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763575856; cv=none; b=Gc0FsBCpd+gtcRH5M3q21lF5f0QOJqnB6fHJwNady/2B1SPyrx7D6yaWz3voosqbtBTl5U72nyvSJ/hDHXp2TPZpw/qSo2iPadpvMaDECsQkaB2ncs2sRwV0KJ4QogE3r/E1Rbg4O8FQv3xt56HAn2srSyg31PaWUyC7VWvc6p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763575856; c=relaxed/simple;
	bh=thAoQXPWlRcAg2sv0bwCR2R0jc757B9rzQhplUIw8Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2bXVLNnAL4KmnavQI1jzFif87em6wRmyAugLlqv395Uul10eJG+F3jNxHpDxj51591viE6e6iVnZq2LI77Pl9Qe44yDWn1SDkHPl/IWN5DPKlK7zW01wqoYloaNLqhj3p1x/7Zynznqec+Zs2AVaTOMg4D0l5KJgMgAyDjA3x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VS+LHCwu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VS+LHCwu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628AFC4CEF5;
	Wed, 19 Nov 2025 18:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763575854;
	bh=thAoQXPWlRcAg2sv0bwCR2R0jc757B9rzQhplUIw8Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VS+LHCwuBlxvJ0bl2a6iCHFRRewgu2a4r+PWRbMJZlinQTrhfTClumsbE9uyGBjiK
	 b6QOk8qOW4ltpNpsbau/a0xlPwJvWdzLVlKkGwtVdukj0IyVFO3wOgFReRvMP5evXo
	 XNPCbC99TEuO0PHURm8ylXluT/t3hlJE0Eo9MHf3iwluRTIUSURlobaQf/JLPWFV8O
	 MucxSH/4ACDIB/6ppjxNhUsaFzEDQQXsE7kP5FzBM/qfoTl7sC+g7KIV2WdmryxYV3
	 4Tihct0P62hR+uytFK0ATZMu1dEnZazjzTzl98GDZVJTi19LLrER4dVRnMzCC8jInc
	 JjrU8/beWf6cQ==
Date: Wed, 19 Nov 2025 10:10:51 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/25] perf arm_spe: Extend operations
Message-ID: <aR4IK-3rcbdbv2Er@google.com>
References: <20251112-perf_support_arm_spev1-3-v3-0-e63c9829f9d9@arm.com>
 <CAP-5=fXiiWRDPzONNNZQZc4QOBQoz=kRnJq77on5r4w9aDx-XA@mail.gmail.com>
 <aRrM2y4O_3aaa2Ee@google.com>
 <ed4a5e23-f2f0-4f02-8b0a-e97329cb313f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed4a5e23-f2f0-4f02-8b0a-e97329cb313f@linaro.org>

On Tue, Nov 18, 2025 at 10:23:57AM +0000, James Clark wrote:
> 
> 
> On 17/11/2025 7:20 am, Namhyung Kim wrote:
> > Hello,
> > 
> > On Thu, Nov 13, 2025 at 09:01:47AM -0800, Ian Rogers wrote:
> > > On Wed, Nov 12, 2025 at 10:24 AM Leo Yan <leo.yan@arm.com> wrote:
> > > > 
> > > > This series enhances tooling to support new operations:
> > > > 
> > > >    - Support for MTE tag since Arm SPE v1.3;
> > > >    - Support for Advanced SIMD extension and SVE operations;
> > > >    - Support memcpy, memset and GCS operations;
> > > >    - Support extended operations for atomic, Acquire/Release and
> > > >      Exclusive instructions.
> > > >    - Enhance the data source for associated info, like floating-point,
> > > >      conditional, data processing, etc.
> > > > 
> > > > This series is divided into three parts:
> > > > 
> > > >    Patches 01 ~ 06: Support raw dump for new operations;
> > > >    Patches 07 ~ 17: Export the operation info into records, so that the
> > > >                     information can be later consumed by samples.
> > > >    Patches 18 ~ 25: Set the operation info into sample's data source and
> > > >                     SIMD flag, and updated the document.
> > > > 
> > > > This patch series is tested on FVP for native parsing and x86_64 for
> > > > cross parsing.
> > > > 
> > > > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > > 
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > 
> > Can I get some comments from ARM folks?  I think I can merge part 1 and
> > 2 before changing the kernel interface.
> > 
> > Thanks,
> > Namhyung
> > 
> 
> Reviewed-by: James Clark <james.clark@linaro.org>
 
Thanks, applied the patch up to 17 to perf-tools-next!

Best regards,
Namhyung

