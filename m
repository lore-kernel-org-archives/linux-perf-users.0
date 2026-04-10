Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405AFEAC7;
	Fri, 10 Apr 2026 04:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775796692; cv=none; b=QV3BT3pOh5MQfV8EKA/u/LG5ENyyLH0tbZ6mGrCZ0G47NysiJA6GkKOEevfMND235suUR+tkLpE0hNOMHesTY1uCY5ETarUXTLa5q1CIvYzZkkDHHur1dnN96dFfN6d2b6j42pqNs6Ds4XxFei+6AKKAWVdcenvHEhNea7oLdMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775796692; c=relaxed/simple;
	bh=yII+i41CzfVGjm3uvoDYmcW+SIjbAZXbT7PnXwlXS20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VY/ixxW87NlSYmcalxWmD1kuE7XZZy5BxQv6t3fJIJdncF9Mx0AmG+XkZCf/E1DkKHTooH/vuVov8p/yDQt2ZYOLe75URwlreJzwGt4CUtOxBrexR0ZKGbxtodkY5sE5i6ny5sfihe4Ue6HxIiWPD3fDpOEs0RxG0u1y47YyZxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2BmVzf4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2BmVzf4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A17DC19421;
	Fri, 10 Apr 2026 04:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775796691;
	bh=yII+i41CzfVGjm3uvoDYmcW+SIjbAZXbT7PnXwlXS20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B2BmVzf4WDck7N54Rn6ZYZw2ZbE7hIzQ+wa6wIps5j+QnQsBDTB6k3P7R/1JXdSS0
	 /bXxgMV8gN35OQ1F1H5Z8M9Hdos2kz3htOcsl3XBnT8TWNFrb9UMHrxGRqB7v8cBos
	 EwuqjXcfCjojt1wNbGaCbkPBphyDw3tbxpzl0hf5DcugIoGfLD/mHt7aR3GnVD3TRL
	 zanQn/ozGIOJapBUxv4UD4aZlLV/vyZGjxLq0SAQgngzyjYtQayPUn7XKYJ4ZL2TsF
	 mSJhlG2DagofGPEOdSCAaju6fhFqLIU1lwtz8CEmg/b2k9XJtWSwPlPHovH0gQMLbF
	 vF962SUmVT80Q==
Date: Thu, 9 Apr 2026 21:51:29 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] perf arm_spe: Decode Arm N1 IMPDEF events
Message-ID: <adiB0V6Unmo0-AkC@google.com>
References: <20260401-james-spe-impdef-decode-v1-0-ad0d372c220c@linaro.org>
 <20260401-james-spe-impdef-decode-v1-3-ad0d372c220c@linaro.org>
 <CAP-5=fVcYOJ_3TWd6won5FVaH2MH6QwLhCoCRnNzzeE-9PgO1Q@mail.gmail.com>
 <ee012f48-5d08-4004-b9d0-bcac825cb50c@linaro.org>
 <CAP-5=fXNb50wXT3YH0i=-U8bXwizzH4bv8EL8mC9BMQE0Anp9Q@mail.gmail.com>
 <1b40ec9a-a003-4acc-9399-1a8d96fc4e42@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b40ec9a-a003-4acc-9399-1a8d96fc4e42@linaro.org>

On Wed, Apr 08, 2026 at 09:47:41AM +0100, James Clark wrote:
> 
> 
> On 07/04/2026 7:26 pm, Ian Rogers wrote:
> > On Tue, Apr 7, 2026 at 5:35 AM James Clark <james.clark@linaro.org> wrote:
> > > 
> > > 
> > > 
> > > On 02/04/2026 4:26 pm, Ian Rogers wrote:
> > > > On Wed, Apr 1, 2026 at 7:26 AM James Clark <james.clark@linaro.org> wrote:
> > > > > 
> > > > >   From the TRM [1], N1 has one IMPDEF event which isn't covered by the
> > > > > common list. Add a framework so that more cores can be added in the
> > > > > future and that the N1 IMPDEF event can be decoded. Also increase the
> > > > > size of the buffer because we're adding more strings and if it gets
> > > > > truncated it falls back to a hex dump only.
> > > > > 
> > > > > [1]: https://developer.arm.com/documentation/100616/0401/Statistical-Profiling-Extension/implementation-defined-features-of-SPE
> > > > > Suggested-by: Al Grant <al.grant@arm.com>
> > > > > Signed-off-by: James Clark <james.clark@linaro.org>
> > > > > ---
> > > > >    tools/perf/util/arm-spe-decoder/Build              |  2 +
> > > > >    .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 45 ++++++++++++++++++++--
> > > > >    .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |  5 ++-
> > > > >    tools/perf/util/arm-spe.c                          | 13 ++++---
> > > > >    4 files changed, 54 insertions(+), 11 deletions(-)
> > > > > 
> > > > > diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/arm-spe-decoder/Build
> > > > > index ab500e0efe24..97a298d1e279 100644
> > > > > --- a/tools/perf/util/arm-spe-decoder/Build
> > > > > +++ b/tools/perf/util/arm-spe-decoder/Build
> > > > > @@ -1 +1,3 @@
> > > > >    perf-util-y += arm-spe-pkt-decoder.o arm-spe-decoder.o
> > > > > +
> > > > > +CFLAGS_arm-spe-pkt-decoder.o += -I$(srctree)/tools/arch/arm64/include/ -I$(OUTPUT)arch/arm64/include/generated/
> > > > > diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > > > index c880b0dec3a1..42a7501d4dfe 100644
> > > > > --- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > > > +++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
> > > > > @@ -15,6 +15,8 @@
> > > > > 
> > > > >    #include "arm-spe-pkt-decoder.h"
> > > > > 
> > > > > +#include "../../arm64/include/asm/cputype.h"
> > > > 
> > > > Sashiko spotted:
> > > > https://sashiko.dev/#/patchset/20260401-james-spe-impdef-decode-v1-0-ad0d372c220c%40linaro.org
> > > > """
> > > > This isn't a bug, but does this include directive rely on accidental
> > > > path normalization?
> > > > 
> > > > The relative path ../../arm64/include/asm/cputype.h does not exist relative
> > > > to arm-spe-pkt-decoder.c. It only compiles because the Build file adds
> > > > -I$(srctree)/tools/arch/arm64/include/ to CFLAGS.
> > > > 
> > > > Would it be cleaner to use #include <asm/cputype.h> to explicitly rely on
> > > > the include path?
> > > > [ ... ]
> > > > """
> > > > I wouldn't use <asm/cputype.h> due to cross-compilation and the like,
> > > > instead just add the extra "../" into the include path.
> > > > 
> > > 
> > > Do you mean change the #include to this?
> > > 
> > >     #include "../../../arm64/include/asm/cputype.h"
> > > 
> > > I still need to add:
> > > 
> > >     CFLAGS_arm-spe-pkt-decoder.o += -I$(srctree)/tools/arch/arm64/include/
> > > 
> > > To make the this include in cputype.h work:
> > > 
> > >     #include <asm/sysreg.h>
> > > 
> > > Which probably only works because there isn't a sysreg.h on other
> > > architectures. But I'm not sure what the significance of ../../ vs
> > > ../../../ is if either compile? arm-spe.c already does it with ../../
> > > which is what I copied.
> > 
> > Hmm.. maybe the path should be
> > "../../../arch/arm64/include/asm/cputype.h". The include preference is
> > for a path relative to the source file and
> > ../../arm64/include/asm/cputype.h doesn't exist. It is kind of horrid
> 
> Up 3 dirs from arm-spe-pkt-decoder.c would be
> "tools/arm64/include/asm/cputype.h" which doesn't exist either unless I'm
> missing something?
> 
> If get the compiler to print the path it uses with 3 then it would use the
> x86 uapi include path which doesn't seem any less weird to me:
> 
>  ...
>  In file included from util/arm-spe-decoder/arm-spe-pkt-decoder.c:19:
> 
>  linux/tools/arch/x86/include/uapi/../../../arm64/include/asm/cputype.h:254:10:
> 
> 
> > to add an include path and then use a relative path to escape into a
> > higher-level directory. arm-spe.c is a little different as it is one
> > directory higher in the directory layout.
> > 
> 
> It is one folder higher, but arm-spe.c still relies on adding a special
> include path to CFLAGS_arm-spe.o to make it work. It's not including a real
> path relative to the source either.
> 
> Yeah it's a bit horrible but I don't think the asm/ thing combined with
> copying headers from the kernel to tools expected to handle the case where
> we would want to use asm/ stuff for a different arch than the compile one.
> It might not be normal to use relative include paths to escape to higher
> directories, but it's not a normal situation either. I think it's a special
> case for a special scenario. I'm not sure of a better way, but this is
> working for now.

I hope we can cleanup the header inclusion path someday.  My idea is
that it always starts from the root of the perf directory.  So it'd
include "util/xxx.h" even if the source file is already in util/.

Thanks,
Namhyung

