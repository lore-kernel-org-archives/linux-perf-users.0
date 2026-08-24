Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C962433C518;
	Mon, 24 Aug 2026 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787607581; cv=none; b=aU5SRGn1e9Y4DR88QryHN2ZngWBsfHjzhpOzFgx5nAfwOcZGfvQhXofNRXbDICtNJlROyXnx8mrN9n/0KNOVsfl1ClQs9pXVdX1bD0nPB++Y+9RsCr+wZ+wOknVznY5RSqEFoj2Lvma1fWGKdlTrSuwloxTkrNZIG6wpgTwI8xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787607581; c=relaxed/simple;
	bh=eUF4h0dx4yVCthlz1mAi5mYbA2DCVTrnzxxoEqM+2j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btMF+iGwvSWAr/7W0GuFN9rmlLyrV9LlGY1ALBf1wfRqJFhzAN3kT253qG9g0HbhW23F8M9kHMtkYOSgBeZkSiYN8sWS7acLmK8pKy0pZ7fRsdmF5chLq+7BefiQIs9jH0MWFNKgvWhg3pNupLxm1c+QOT9jPv4TVmU1PM3C5H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fycqZnQ0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fycqZnQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C532C1F000E9;
	Mon, 24 Aug 2026 21:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787607579;
	bh=dWaMn60Gql9bgp/SKadsbK5UbroM1nQIZZi1EaCUrmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fycqZnQ019qE0V3reneCoqGm8k85yZloOf9VMw2dOscdV8PpverNBPygSowMgg+5R
	 B3ZoJyG8OpqeVWYk3k90YnPaLiaN20FzQX8+fL5gBj9EkI9ls8C+anLoekjzQUF9Bi
	 LG6Hp3i0oRh9e0XZdtLL51avJ2oIvi3JiSUdPXfDZqcnd9MPw7FafavU9mqH1d4OV4
	 4EbC/PPmyUDNZfYKlo3KANrk4rFBtiAHx78kvUhdPrMtBQNm789uupKd6cftTJlo9t
	 RQ/O52jh7cpR5KHZbCiNwfCTVhWXgCTlNWwQqxnX0gPZodPveSE4png8GYxFlYeSuY
	 9kkzR75Wami8Q==
Date: Mon, 24 Aug 2026 14:39:37 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, james.clark@linaro.org,
	Li Huafei <lihuafei1@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 06/23] perf annotate: Adapt arch__dwarf_regnum() for
 arm64
Message-ID: <aoy6GTeMkeQcPUD2@google.com>
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-7-wutengda@huaweicloud.com>
 <1d2e807f-5ced-4af5-86c8-9cd3e89a7ba2@linux.alibaba.com>
 <923626e1-28db-42aa-a6ac-f1d1012cea82@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <923626e1-28db-42aa-a6ac-f1d1012cea82@huaweicloud.com>

On Tue, Aug 11, 2026 at 04:16:59PM +0800, Tengda Wu wrote:
> 
> 
> On 2026/8/11 14:33, Shuai Xue wrote:
> > 
> > 
> > On 8/8/26 8:23 PM, Tengda Wu wrote:
> >> Currently, arch__dwarf_regnum() assumes that all architectures use a
> >> register prefix character (e.g., '%' for x86) defined by
> >> arch->objdump.register_char, and uses it to match register names in
> >> objdump output. However, this assumption does not hold for arm64,
> >> where assembly syntax uses bare register names like 'x0', 'w1'
> >> without any prefix.
> >>
> >> As a result, arm64 builds may fail to correctly recognize register
> >> names from objdump disassembly, leading to incomplete or incorrect
> >> annotation output.
> >>
> >> To address this:
> >>
> >> - Make the register prefix check optional, allowing architectures
> >>    without a prefix character to be parsed correctly.
> >>
> >> - Extend the delimiter set in strpbrk() to include the closing square
> >>    bracket ']'. In arm64 assembly, memory operands often use bracketed
> >>    syntax such as '[x1, #16]' or '[x2]'. Adding ']' ensures clean
> >>    extraction of register names like 'x2' without trailing characters.
> >>
> >> - Remove the 'static' qualifier from arch__dwarf_regnum() so that it
> >>    can be reused by other architecture-specific profiling components
> >>    in future changes.
> >>
> >> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> >> ---
> >>   tools/perf/util/annotate.c | 14 ++++++++------
> >>   tools/perf/util/annotate.h |  2 ++
> >>   2 files changed, 10 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> >> index df70e95a8470..9d8b4d6b859b 100644
> >> --- a/tools/perf/util/annotate.c
> >> +++ b/tools/perf/util/annotate.c
> >> @@ -2472,21 +2472,23 @@ int annotate_check_args(void)
> >>       return 0;
> >>   }
> >>   -static int arch__dwarf_regnum(const struct arch *arch, const char *str)
> >> +int arch__dwarf_regnum(const struct arch *arch, const char *str)
> >>   {
> >> -    const char *p;
> >> +    const char *p = str;
> >>       char *regname, *q;
> >>       int reg;
> >>   -    p = strchr(str, arch->objdump.register_char);
> >> -    if (p == NULL)
> >> -        return -1;
> >> +    if (arch->objdump.register_char) {
> >> +        p = strchr(str, arch->objdump.register_char);
> >> +        if (p == NULL)
> >> +            return -1;
> >> +    }
> >>         regname = strdup(p);
> >>       if (regname == NULL)
> >>           return -1;
> > 
> > 
> > Keeping the early -1 return here is correct, but it exposes an
> > inconsistency in this function's failure values. This is the only path
> > that returns -1; when the lookup itself fails the tail returns whatever
> > get_dwarf_regnum() produced (-ENOENT on arm64, -EINVAL/-ENOENT on x86).
> > The callers only check
> > 
> >     if (op_loc->reg1 == -1)
> > 
> > so the early return is caught while a real parse failure slips through
> > with a negative reg1. Today that is harmless because every consumer
> > guards with has_reg_type(), whose unsigned compare rejects negative
> > values, but the error propagation is effectively broken and arm64 adds
> > more inputs that fail parsing (prfm ops, PC-relative addresses).
> > 
> > Could you normalise the tail to keep the "success or -1" contract?
> > 
> >     reg = get_dwarf_regnum(regname, arch->id.e_machine,
> >                    arch->id.e_flags);
> >     free(regname);
> >     return reg < 0 ? -1 : reg;
> > 
> > Thanks.
> > Shuai
> 
> Sure. I'm also thinking about whether this change should be done as a
> standalone patch, since it appears to be a pre-existing issue.

Right, please send it as a separate patch.

Thanks,
Namhyung

