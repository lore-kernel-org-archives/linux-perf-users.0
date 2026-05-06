Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BC0C2FF;
	Wed,  6 May 2026 01:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778029321; cv=none; b=gw0Vwg36Ur2RnnhoTVS1KdhGoWZhkLGhKSGqvjNHF/yIbaOzEahMf5LSTaICGua7e1kVvlZOjNBLD164xG9iScvzOZYZdIAPNPzZVAr+uaLEqB9H5yVgQBduDfqccMHQOttYJXifvDU4/q15KEHxMJ52pVmVeDvuFdhkcVnNK/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778029321; c=relaxed/simple;
	bh=8G3e6QSF39eIKq52hOqD4lukC804POckI72mIHa2qtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BveXDZjjpVzEpbTQo6K/ShwOmxmGvDON1WOi6a2Ei1kDR1qgHhAszx/uUbrplUkQo7kzLx5ylelTCMysVAXacP/M4QRyqUSgzkyL1clNI9BSZN63x4DpBJydRp8j0As5uSotbJPv2ZkFSjNKHo1TlGtDD/CHTl87Rp2efx03Jqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BL8dEFMG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BL8dEFMG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 333C2C2BCB4;
	Wed,  6 May 2026 01:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778029320;
	bh=8G3e6QSF39eIKq52hOqD4lukC804POckI72mIHa2qtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BL8dEFMGn9Q1JU6HQcvYU8Q6lkCK+EnqFPtrVeZrph1s/R65OcqseP/Y8S5lw5Sdw
	 Vxqb7HWeNWV5CLPnVBVGFaMLuGzzHie34Vpgi3aUYPs95uCZ6k5aCduyq5Wx/yhKIx
	 l79dewiGWfOjXO5whXOD/gwXkgY7z6NcHpkVxlK618CeULarubQ4zgTiqkEQws8Fhg
	 1ZSwRn0RA+EVba9BBrc227vs0YkphJd3wh4wQNk6dz8R1WjUua82Ipxf/7h+kSK6VR
	 kmPrY4Nlc435JuOvdgwNUtrWVHlQ3KBpGR49G0pWOWUvO0BMPmHowADcUYYYOvfusf
	 Wx2kogXahiwPA==
Date: Tue, 5 May 2026 22:01:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko@lists.linux.dev
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 5/6] perf arm_spe: Decode Arm N1 IMPDEF events
Message-ID: <afqTBBXcPmobSCu1@x1>
References: <20260414-james-spe-impdef-decode-v4-5-1dd30783a33b@linaro.org>
 <20260414155203.0B24CC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414155203.0B24CC19425@smtp.kernel.org>

On Tue, Apr 14, 2026 at 03:52:02PM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Low] The relative include path `#include "../../arm64/include/asm/cputype.h"` is invalid and relies on accidental directory traversal through a compiler `-I` flag.
> --
> 
> commit 7fc153524fe60dc6d6f08fd73b7ea3f46e904e39
> Author: James Clark <james.clark@linaro.org>
> 
> perf arm_spe: Decode Arm N1 IMPDEF events
> 
> This commit adds a framework to decode the N1 IMPDEF event for Arm SPE, 
> which isn't covered by the common list. It also increases the packet 
> description buffer size to accommodate more strings without falling back 
> to a hex dump.
> 
> Link: https://developer.arm.com/documentation/100616/0401/Statistical-Profiling-Extension/implementation-defined-features-of-SPE
> 
> > diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/arm-spe-decoder/Build
> > index ab500e0efe244..97a298d1e2791 100644
> > --- a/tools/perf/util/arm-spe-decoder/Build
> > +++ b/tools/perf/util/arm-spe-decoder/Build
> > @@ -1 +1,3 @@
> >  perf-util-y += arm-spe-pkt-decoder.o arm-spe-decoder.o
> > +
> > +CFLAGS_arm-spe-pkt-decoder.o += -I$(srctree)/tools/arch/arm64/include/ -I$(OUTPUT)arch/arm64/include/generated/
> 
> [ ... ]
> 
> > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > index 67ca356100e53..b74f887a48f2a 100644
> > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > @@ -15,6 +15,8 @@
> >  
> >  #include "arm-spe-pkt-decoder.h"
> >  
> > +#include "../../arm64/include/asm/cputype.h"
> 
> Is this relative include path correct?
> 
> It looks like this file is located in tools/perf/util/arm-spe-decoder/, so
> the relative path resolves to tools/perf/arm64/include/asm/cputype.h,
> which doesn't exist.
> 
> It seems this only compiles because the newly added -I flag in the Build
> file causes the preprocessor to resolve the include relative to
> tools/arch/arm64/include/. The path then inadvertently evaluates back to the
> correct file by traversing backwards out of the include directory and diving
> back in.
> 
> Could this be made less brittle by relying directly on the include flag,
> using #include <asm/cputype.h> instead?

This is just a possible improvement and not strictly a problem as the -I
is structured today, so lets not postpone processing this patchset
because of this, this can be considered some other time.

- Arnaldo
