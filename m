Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B371921C187;
	Fri,  4 Oct 2024 14:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053155; cv=none; b=OC6TRA8nVrxlSb9oYMiqLWUjH1DmNfJ6T3VVikYC2hcdzoKyW6ZUx9I7hFUMR+oPy2B9ZPQJsyT1tqqnGRLwo4/Zwp8XR+iiEc/s80HXsqy6xPPglbpcvrE8nqfomHhxJO8oI9ZbIXEqCG2wrc95ggUyP7i1OG7Tlksjs4ZQRZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053155; c=relaxed/simple;
	bh=Bq/bcqNVzcNrlJ5fpYFIOx2C4lca7RpAEH7LWWRyrKc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XHQe74xaJ7A3OJcichFbo0rXac8Cwzb1UpyD6UPmGR9Z4NJB+lEZKvRaYCYoRFUoKjyGEBZskYAcx7ZqdrQiqGF3AJodNQ+8gkgT1iWx5GWTJTfDSXIt0W+6WEbZZYsj2QgJOZqTvhuR2w679HNp4wd0kB/t2Qo0lxBbgpM6wjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfJ6rB9P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfJ6rB9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1BFC4CEC6;
	Fri,  4 Oct 2024 14:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728053155;
	bh=Bq/bcqNVzcNrlJ5fpYFIOx2C4lca7RpAEH7LWWRyrKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WfJ6rB9P6Ayn4oRMcw6+zDim5Vn7N0rgujQjIWwqlIBMcz3rL86X8MRgncUhdTqtS
	 wQoukU7Ae9dmk8tmvi5BpwqSNZAbBa2oCtbpgxqXJVB0gwjYNj+8p1zDABjN2gep8Q
	 BCapDWaZYfUpGmwd3TI49RvlD6s1AZNa2nDUEGG7pL/qzNNczlhQiaYb4LikkQeCiJ
	 85eAddS9/8/xRvEKFZPIVBT4SBpIdfD+0EWFS3HV7+0bhQMie8P9b+fGL1qYUCjAUy
	 597NmxAq3wbx2pkR3I/hQ7MPXt30QCT92xyuLJ30aoXGEwZL9XJEXyW45xdVInpnXH
	 QA2oT1hBynVWg==
Date: Fri, 4 Oct 2024 23:45:44 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Adrian
 Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, James
 Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan
 <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, Guilherme Amadio
 <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>,
 "Steinar H. Gunderson" <sesse@google.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, Kajol Jain
 <kjain@linux.ibm.com>, Anup Patel <anup@brainfault.org>, Shenlin Liang
 <liangshenlin@eswincomputing.com>, Atish Patra <atishp@rivosinc.com>,
 Oliver Upton <oliver.upton@linux.dev>, Chen Pei <cp0613@linux.alibaba.com>,
 Dima Kogan <dima@secretsauce.net>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Yang Jihong
 <yangjihong@bytedance.com>
Subject: Re: [PATCH v1 11/11] perf build: Rename PERF_HAVE_DWARF_REGS to
 PERF_HAVE_LIBDW_REGS
Message-Id: <20241004234544.76317dc8c7027bcd4b70fda3@kernel.org>
In-Reply-To: <Zv95OTflePPTMi7I@google.com>
References: <20240929113521.9b7e8fd67af154520e2c9d8e@kernel.org>
	<CAP-5=fV8vZoieMrRxCrF5EkUBP0HWd=ZLHXEHTq1X_mni0wMsA@mail.gmail.com>
	<ZvyBQ6xgGE4gZdoo@google.com>
	<CAP-5=fX7=EuZgnaG2-cXDU9eVqLyncdMTQF7=Nso__D1H0vMmw@mail.gmail.com>
	<20241002082859.8821e441024fe873a4301afc@kernel.org>
	<CAP-5=fWcOpF4+mgnkHOG=ntGMafJ7JSks_4j1JWVvgccApn+Ng@mail.gmail.com>
	<20241002225614.774bdd0742a826557f142d0e@kernel.org>
	<CAP-5=fWoiD=7XbB3FbE++1RSo3BZKeOOyNg81t4GQ7Ve6ejpSg@mail.gmail.com>
	<Zv8fIh4jaY7QbeDZ@google.com>
	<CAP-5=fVvzNMDPUpAvK0itjG0ZptrSg-_BN3t6UwB4XAvSsDt8w@mail.gmail.com>
	<Zv95OTflePPTMi7I@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 3 Oct 2024 22:12:25 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> On Thu, Oct 03, 2024 at 05:58:13PM -0700, Ian Rogers wrote:
> > On Thu, Oct 3, 2024 at 3:48 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > I agree renaming libdw-specific parts.  But the register is for DWARF,
> > > not libdw even if it's currently used by libdw only.   So I don't want
> > > to rename it.
> > 
> > So your objection is that we have files called:
> > tools/perf/arch/*/util/dwarf-regs.c
> > and PERF_HAVE_DRWARF_REGS is an indication that this file exists. This
> > file declares a single get_arch_regnum function. The building of the
> > file after this series is:
> > perf-util-$(CONFIG_LIBDW)     += dwarf-regs.o
> 
> Well.. I think we can even make it
> 
> perf-util-y += dwarf-regs.o
> 
> since it doesn't have any dependency on libdw.  But it'd be inefficent
> to ship the dead code and data.  Anyway we may remove the condition to
> define the PERF_HAVE_DWARF_REGS like below.
> 
> diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
> index 67b4969a673836eb..f1eb1ee1ea25ca53 100644
> --- a/tools/perf/arch/x86/Makefile
> +++ b/tools/perf/arch/x86/Makefile
> @@ -1,7 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -ifndef NO_DWARF
>  PERF_HAVE_DWARF_REGS := 1
> -endif
>  HAVE_KVM_STAT_SUPPORT := 1
>  PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
>  PERF_HAVE_JITDUMP := 1
> 
> > 
> > My objection is that PERF_HAVE_DWARF_REGS is controlling the #define
> > HAVE_LIBDW_SUPPORT, so dwarf (that can mean libunwind, libdw, etc.) is
> > guarding having libdw which is backward and part of what this series
> > has been trying to clean up.
> 
> Why not?  If the arch doesn't define DWARF registers, it can refuse
> libdw support because it won't work well.

It actually does not DWARF registers, but just "dwarf-regs.c" file
since arch should define DWARF registers if the compiler generates
the DWARF.
Here the flag means only "we implemented dwarf-regs.c file for this
arch." So if it is called as "libdw-helper.c" then we can rename the
flag as PERF_HAVE_ARCH_LIBDW_HELPER simply.

> > If we rename tools/perf/arch/*/util/dwarf-regs.c to
> > tools/perf/arch/*/util/libdw-helpers.c the PERF_HAVE_DWARF_REGS can be
> > renamed to PERF_HAVE_LIBDW_HELPERS to align. Then
> > PERF_HAVE_LIBDW_HELPERS guarding the #define PERF_HAVE_LIBDW makes
> > sense to me and I think we achieve the filename alignment you are
> > looking for.
> 
> I don't think it's a good idea.  The logic is not specific to libdw.

Yes, the logic (DWARF register mapping to the ISA register name) is
not libdw. But I think we can also implement it in "libdw-helper.c".
(In fact, this implementation does not depend only on Dwarf, but 
 rather on the convenience of ftrace.)

> > 
> > Yes get_arch_regnum could make sense out of libdw and needn't just be
> > a helper for it, but let's worry about that when there's a need.
> > What's confusing at the moment is does libdw provide dwarf support,
> > which I'd say is expected, or does dwarf provide libdw support?
> 
> As I said, it's about refusing libdw.

I think Ian pointed this part, even if libdw is available, dwarf-regs.c
controls its usage, but libunwind is not.

> 
>   ifndef NO_LIBDW
>     ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
>       $(warning DWARF register mappings have not been defined for architecture $(SRCARCH), DWARF support disabled)

I think *this message* is the root cause of this discussion. It should be
changed to 

"DWARF register mappings have not been defined for architecture $(SRCARCH), libdw support disabled."

or (if changed to libdw-helper)

"libdw-helper.c is not implemented for architecture $(SRCARCH), libdw support disabled."

Thank you,

>       NO_LIBDW := 1
>     else
>       CFLAGS += -DHAVE_DWARF_SUPPORT $(LIBDW_CFLAGS)
>       LDFLAGS += $(LIBDW_LDFLAGS)
>       EXTLIBS += ${DWARFLIBS}
>       $(call detected,CONFIG_DWARF)
>     endif # PERF_HAVE_DWARF_REGS
>   endif # NO_LIBDW
> 
> Thanks,
> Namhyung
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
