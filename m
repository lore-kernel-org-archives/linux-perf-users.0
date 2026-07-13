Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3913273D77;
	Mon, 13 Jul 2026 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783966898; cv=none; b=CIKgwYbHtjuJBltT1Fn2U7R7xBfWkCLn7K/gskvh9Z8vUbuCQGPDXVfIMltbRPvSxhsptPgg4mVEfZ/g30Tof6MIZvV+thVbna7h8jWfH8YP9DxClTGKvmYOsGYya/qbxm7V76j3gjz6lBRgCmasbn26KgUwWEJOeDFqO/xu7Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783966898; c=relaxed/simple;
	bh=8lV+NEZ89l+JX8WOR2RO00HppOiR37/XZyfiDOC7TOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLDIAhjTdAeapViSv75wCbFv/27CNwL6VBANjPq5IH/jxFyr7Ou2CJDqj060eKUqTzv6AZyCHZRrNICxu+rKJFcjSDHqO0mSIXfob98V8IljGQZmPwTHG9Yp42QTMYSZF7shbrpn29EnCwag4MS2ck8M9piLmlW1h0QoilM0MEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ut7mmvLe; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ut7mmvLe"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF1D71570;
	Mon, 13 Jul 2026 11:21:31 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C2C33F7B4;
	Mon, 13 Jul 2026 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783966896; bh=8lV+NEZ89l+JX8WOR2RO00HppOiR37/XZyfiDOC7TOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ut7mmvLe7CsYhtUmFyLr0M2zu0QSt5Bi1McvwD2phBjAxM85fTvXfIaJr/S9KVdVs
	 VHE6YGqDH9DUP69M86KRm8dIK9JS7tplwozUCsrx2h39MMmerqvEM4CcNfuDlflfrW
	 8Jn8/eRUuQDGofTThqWjypmKf6Ifw1JSMsXSb4tE=
Date: Mon, 13 Jul 2026 19:21:33 +0100
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf capstone: Fix build with Capstone versions before 6
Message-ID: <20260713182133.GC512733@e132581.arm.com>
References: <20260713-perf_fix_capstone_build-v1-1-796ea08c04db@arm.com>
 <alUi7RgZkINlZOKP@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alUi7RgZkINlZOKP@google.com>

Hi Namhyung,

On Mon, Jul 13, 2026 at 10:39:57AM -0700, Namhyung Kim wrote:
> On Mon, Jul 13, 2026 at 12:08:35PM +0100, Leo Yan wrote:
> > The commit 12c4737f55f2 ("perf capstone: Determine architecture from
> > e_machine") added a RISC-V mapping for Capstone disassembly.
> > 
> > However, the RISC-V arch and mode definitions are only available from
> > Capstone 6.0.0. Older Capstone headers do not define CS_ARCH_RISCV,
> > CS_MODE_RISCV64 or CS_MODE_RISCV32, so perf fails to build.
> > 
> > Guard the RISC-V mapping with a Capstone major version check. Also use
> > CS_MODE_RISCV_C instead of CS_MODE_RISCVC, which is the mode name used
> > by Capstone 6.
> 
> Please see
> 
> https://lore.kernel.org/r/20260706234836.815254-1-namhyung@kernel.org

I am a bit concerned that defining the macros directly in perf is a good
idea, since the Capstone library doesn't actually support the arch/insn
and the macros merely work around the build.

Perhaps checking the Capstone version would be a safer approach?

I have no knowledge for capstone, I will leave this to you to decide which
is better. I tested your patch, which works well at my side.

Thanks,
Leo

> > Fixes: 12c4737f55f2 ("perf capstone: Determine architecture from e_machine")
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> > ---
> >  tools/perf/util/capstone.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> > index 9bba78ee0c5a2e6c86a97ffe69ca4db966bafd9b..99efeb40ed03621e781ef9b888321e28d237a0ca 100644
> > --- a/tools/perf/util/capstone.c
> > +++ b/tools/perf/util/capstone.c
> > @@ -182,10 +182,12 @@ static bool e_machine_to_capstone(uint16_t e_machine, bool is64, bool is_big_end
> >  		*arch = CS_ARCH_SPARC;
> >  		*mode |= CS_MODE_V9;
> >  		return true;
> > +#if defined(CS_VERSION_MAJOR) && CS_VERSION_MAJOR >= 6
> >  	case EM_RISCV:
> >  		*arch = CS_ARCH_RISCV;
> > -		*mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCVC;
> > +		*mode |= (is64 ? CS_MODE_RISCV64 : CS_MODE_RISCV32) | CS_MODE_RISCV_C;
> >  		return true;
> > +#endif
> >  	default:
> >  		return false;
> >  	}
> > 
> > ---
> > base-commit: ef3af1df4f3372bd8ad47619452a283048b3bc8d
> > change-id: 20260713-perf_fix_capstone_build-510dc3bfecfb
> > 
> > Best regards,
> > -- 
> > Leo Yan <leo.yan@arm.com>
> > 
