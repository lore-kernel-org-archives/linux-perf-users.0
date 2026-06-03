Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCF93E1CF0;
	Wed,  3 Jun 2026 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780506508; cv=none; b=Ky9zGxubIemsiKwoMXIFfHZ9sScQlWantjRk3rPA52pMmeDtOPDv2ZiBcSMj0x5qwen/6w1PnGkEOA/z4JpyfAph8eTfZwYI6lGqK24MbVOoZPdPmSunEny8VUXDvA6Lil2rAfM3OHuYWkwEPQk7Isx2K9piL+6WE3xZ7gau7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780506508; c=relaxed/simple;
	bh=coDF+fPSybGXWIT0PI4La9M9bBJpTiUeLEadqpd9b6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWDwgXVhuqlHGHiUhYkMmdyiRmp50Tcr9HFlTz7JaOWM0T8h/aEnYi17e5mrWEtpA0MwfPwf6/aFaV9goLbo47zto1LX0BsxJajd4vCUcrk4O4awBlwQIs/aIClCb2TnSz+xGw/dhgcVhG53ZIZ8ezrWJsCeurWfLZdaV897Li0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hDQrq35u; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hDQrq35u"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EDED307A;
	Wed,  3 Jun 2026 10:08:21 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC1203F632;
	Wed,  3 Jun 2026 10:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780506506; bh=coDF+fPSybGXWIT0PI4La9M9bBJpTiUeLEadqpd9b6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDQrq35uqqxbId+KX0z9VeYR9TLqfT7Rd3YOedOki1/uGb3zXnGNmUzR/Nbg4dXmk
	 X10KT1FydA589o0IhbDBfMWVm90xE6/GvHuMlpEDNZLPbANQySa4y3GEYKcZ0l7Ugm
	 FMNmsOlkraV3tKyqFVnkFiJ8HKA6ptE8o8zIcfKM=
Date: Wed, 3 Jun 2026 18:08:23 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paschalis Mpeis <Paschalis.Mpeis@arm.com>,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 06/18] perf test cs-etm: Replace unroll loop thread
 with deterministic decode test
Message-ID: <20260603170823.GA101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-6-85b5ce6f55c6@linaro.org>
 <20260603140803.GV101133@e132581.arm.com>
 <2f1db2b3-93e8-4c32-b207-304e3a43ce77@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f1db2b3-93e8-4c32-b207-304e3a43ce77@linaro.org>

On Wed, Jun 03, 2026 at 05:01:02PM +0100, James Clark wrote:

[...]

> > > +# Remove open brace lines as they may not be hit depending on the compiler
> > > +sed -i \
> > > +  -e '/deterministic.c:8$/d' \
> > > +  -e '/deterministic.c:15$/d' \
> > > +  -e '/deterministic.c:23$/d' \
> > > +  "$tmpdir/script"
> > 
> > Is this related to the function definition?
> > 
> > I can see the brace lines with change below. It might be more reliable
> > if adding unused function argument, which can give chance for hit
> > function entry.
> > 
> >    static int function1(void)
> >    {
> >        ...
> > 
> >        return 0;
> >    }
> 
> Originally I included the brace lines in the test and it was working even
> without function arguments, but Sashiko mentioned that they may not always
> be hit.

I tried Clang to build the program and can see the brace lines are
missed for function1() / function2().

Does Sashiko mention any reasons causing the issue?

> I think its point was that there is no hard rule about debug symbols for
> open braces and the behavior might change from one version of the compiler
> to the next, or whether there is a function prologue or inlining or not etc.
> 
> I don't think it's important to the test at all though? So to err on the
> side of caution it makes sense to not test for them. Unless there's a reason
> you think testing for open braces is important? Surely just testing for
> actual lines of code appearing in a certain order is enough.

As the test program is named as "deterministic", wouldn't we expect the
test to hit every code line run in the program?

It is fine for me to skip some checks _if_ we know the reason. I dumped
the disassembly, it shows function entry is a distinguished position
from the first calculation sentence (same for both GCC and Clang). And
there have no difference for a function entry after I tweaked the
function return type from "void" to "int". I still have no clue why
brace lines are misses.

Thanks,
Leo
