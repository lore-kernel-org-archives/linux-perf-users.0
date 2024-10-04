Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B6F28F3;
	Fri,  4 Oct 2024 05:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728018750; cv=none; b=FDN27YVeFPgQ2Qe81Hh0EnFbW1yrKa/uqUe058K15XXi3qRmOi6M0MIMaA0oyRGo8ndHgynVkgK2/3qHGJvD3uEnJKTuGAuk5aI1zDKtBSvdRYB1r1R/GGkUiNbxCrMSBtz0pcGQcepBLQzm8PSHFqEkZWHp4cKew0WTnZHTxsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728018750; c=relaxed/simple;
	bh=lKC4CT6hi77mEOE4mS3V8G1ntrJn4suIUj1QOU4NVZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrWtSjvBtFv6ZsOSeBz4M5LwkPsq7niG84cwNaTAugMpY89vKJ0J957QpiUDAkICBeIMl0uK3L3gtJNYmI0HTIVY/65VgmhaWNyR4VKgCKvBxu19FssWcTwpSovnxCBJTkIRGr6K1gayH4Qcu511S0NWiDnJrKs9QvNM0AkOafU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5ce8n0U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5ce8n0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CCBC4CEC6;
	Fri,  4 Oct 2024 05:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728018749;
	bh=lKC4CT6hi77mEOE4mS3V8G1ntrJn4suIUj1QOU4NVZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h5ce8n0Uqka8z8oMc67Uz3ZzQyQQ5THvUSD0+ZruFonTxfmcEwzDuDTYVR/ZzNdIo
	 m/o8dI4vnIqq/Jk2Lm1EB04OZObt6afI4oPpOjzQ9dZIhhCZxirurCPTexiQIki9Mr
	 XMR8XbcF1TShUZB4KyzAlCgvqRIOKlaEVw4ta369ynVLukZ8r4YRkG0wFXbAy3jju8
	 oXI9N9/VwAZVpoNbovjHngtU5o8hCkHIWK/DF3n9IzwOjHW2xl65bZ4U2YCc+etgqp
	 ouKomM4rhsgfr0mQa26WoijObBqbjlZXADzeV1GkTJdmtQIUot9AmJs90sJXdLdHVb
	 y8SnBTjfV8kmw==
Date: Thu, 3 Oct 2024 22:12:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Changbin Du <changbin.du@huawei.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>,
	Kajol Jain <kjain@linux.ibm.com>, Anup Patel <anup@brainfault.org>,
	Shenlin Liang <liangshenlin@eswincomputing.com>,
	Atish Patra <atishp@rivosinc.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Dima Kogan <dima@secretsauce.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Yang Jihong <yangjihong@bytedance.com>
Subject: Re: [PATCH v1 11/11] perf build: Rename PERF_HAVE_DWARF_REGS to
 PERF_HAVE_LIBDW_REGS
Message-ID: <Zv95OTflePPTMi7I@google.com>
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
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVvzNMDPUpAvK0itjG0ZptrSg-_BN3t6UwB4XAvSsDt8w@mail.gmail.com>

On Thu, Oct 03, 2024 at 05:58:13PM -0700, Ian Rogers wrote:
> On Thu, Oct 3, 2024 at 3:48 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > I agree renaming libdw-specific parts.  But the register is for DWARF,
> > not libdw even if it's currently used by libdw only.   So I don't want
> > to rename it.
> 
> So your objection is that we have files called:
> tools/perf/arch/*/util/dwarf-regs.c
> and PERF_HAVE_DRWARF_REGS is an indication that this file exists. This
> file declares a single get_arch_regnum function. The building of the
> file after this series is:
> perf-util-$(CONFIG_LIBDW)     += dwarf-regs.o

Well.. I think we can even make it

perf-util-y += dwarf-regs.o

since it doesn't have any dependency on libdw.  But it'd be inefficent
to ship the dead code and data.  Anyway we may remove the condition to
define the PERF_HAVE_DWARF_REGS like below.

diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index 67b4969a673836eb..f1eb1ee1ea25ca53 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -1,7 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_DWARF
 PERF_HAVE_DWARF_REGS := 1
-endif
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
 PERF_HAVE_JITDUMP := 1

> 
> My objection is that PERF_HAVE_DWARF_REGS is controlling the #define
> HAVE_LIBDW_SUPPORT, so dwarf (that can mean libunwind, libdw, etc.) is
> guarding having libdw which is backward and part of what this series
> has been trying to clean up.

Why not?  If the arch doesn't define DWARF registers, it can refuse
libdw support because it won't work well.

> 
> If we rename tools/perf/arch/*/util/dwarf-regs.c to
> tools/perf/arch/*/util/libdw-helpers.c the PERF_HAVE_DWARF_REGS can be
> renamed to PERF_HAVE_LIBDW_HELPERS to align. Then
> PERF_HAVE_LIBDW_HELPERS guarding the #define PERF_HAVE_LIBDW makes
> sense to me and I think we achieve the filename alignment you are
> looking for.

I don't think it's a good idea.  The logic is not specific to libdw.

> 
> Yes get_arch_regnum could make sense out of libdw and needn't just be
> a helper for it, but let's worry about that when there's a need.
> What's confusing at the moment is does libdw provide dwarf support,
> which I'd say is expected, or does dwarf provide libdw support?

As I said, it's about refusing libdw.

  ifndef NO_LIBDW
    ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
      $(warning DWARF register mappings have not been defined for architecture $(SRCARCH), DWARF support disabled)
      NO_LIBDW := 1
    else
      CFLAGS += -DHAVE_DWARF_SUPPORT $(LIBDW_CFLAGS)
      LDFLAGS += $(LIBDW_LDFLAGS)
      EXTLIBS += ${DWARFLIBS}
      $(call detected,CONFIG_DWARF)
    endif # PERF_HAVE_DWARF_REGS
  endif # NO_LIBDW

Thanks,
Namhyung

