Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3002912EBDB;
	Fri, 24 Jan 2025 21:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737754315; cv=none; b=YJMJAd180ueW3AjHLkaH8s4sCoOCqsjY00281X0yllQul+Dud3I7/yspCGrwjW9jyapkF1USGHiWOMGexQB2wAhajuW0PR7fh+DmmDc7sLih1ltSRSrVZROeM0MXBc+P3I5NjM3GwZjech0AtxUgXHghQTQ0GT8aIyWNj3wbVzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737754315; c=relaxed/simple;
	bh=y3+tzdTCeITPXm5rMFBmL1j5tGgi6F/rV8K16ZmvxHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeX0t1kiadU0MJujxiBd9kdZu87zFP6SCQqLB15wA9lS/JdxiE4DKyiH49GYkfsXPIM/XduMBBoCn3sgT9RUTgvUKc+fZZeKxMzuKRuZ5elERDpiCUIxyR/QZtgqkzowmWogixXXu2f+hNVD3iA2HMBlYMlTs8eAj2uE74CUMCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPoFV/oI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPoFV/oI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E58C4CED2;
	Fri, 24 Jan 2025 21:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737754314;
	bh=y3+tzdTCeITPXm5rMFBmL1j5tGgi6F/rV8K16ZmvxHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPoFV/oIe5oDeYgRPzzXsB9IWESp0goS/sTSpLZ+eAubwCFwoFYMNqF0eS31wvEft
	 hAQtdfl+qHLOJDMkwAo5uiHg4wMm0jGzuPoLh7cTxqzilUlcE+YoBm3GnCbbJKTm9Z
	 7daJNKk87GpMfQdaRXtsJriwohJL/1SXUad0eD/BphgpkV4Kc0kbS3p7A/cgF1DYBM
	 CEb97qXGIqXXWcbi1ZeJTb0gUh37KOwC2ZCG6tnzk3WInmNIc4A41tdWPr7MXd2WrP
	 eg2NBYAitNVTY+7HXYoN9DfCWoGMAKsmfuT5k138B6VSRo3Z973gzCvY3geR3u3l8T
	 oHIS9DA6bv0jQ==
Date: Fri, 24 Jan 2025 13:31:52 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Changbin Du <changbin.du@huawei.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v1 4/5] perf capstone: Support for dlopen-ing
 libcapstone.so
Message-ID: <Z5QGyGQ9SfXiE3WH@google.com>
References: <20250120173208.344231-1-irogers@google.com>
 <20250120173208.344231-5-irogers@google.com>
 <Z5FwusFZ_bYlu6aK@google.com>
 <CAP-5=fX4vtKzMtrEbZhqH0dmKpXY3Ke+pVJ-ZbnHnAVuto7Z8g@mail.gmail.com>
 <CAP-5=fXx=q-LHcb9BtjE1AFZGmV55NBWy3HvfWQaABo-YO=4gA@mail.gmail.com>
 <CAP-5=fUhNuybCU-2_5EgcCwgwXnxvyFMvyhzKe=ZP1bssQwXHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUhNuybCU-2_5EgcCwgwXnxvyFMvyhzKe=ZP1bssQwXHw@mail.gmail.com>

On Thu, Jan 23, 2025 at 01:37:16PM -0800, Ian Rogers wrote:
> > > On Wed, Jan 22, 2025 at 2:27 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > I think reverse engineering the types is fragile.  Can we simply change
> > > > to dlopen if libcapstone is available?
> 
> To understand the scope of the problem, here is the LLVM code:
> https://github.com/googleprodkernel/linux-perf/blob/google_tools_master/tools/perf/util/llvm.c#L22
> 3 typedefs and 5 #defines on 13 lines of code.

It doesn't look that bad than I thought. :)

> 
> The capstone code is larger primarily due to needing to define cs_x86
> (and its dependencies) which are used for extra detail in printing:
> https://github.com/googleprodkernel/linux-perf/blob/google_tools_master/tools/perf/util/capstone.c#L23-L132
> We could opt out of providing the extra detail if capstone.h isn't
> present. I believe this can remove lines 49 to 123. This would mean
> there would be 37 lines of reverse engineered types - 2 structs and 5
> enums.

Probably, we don't need to carry the full details of instructions when
the library support was not built.

> 
> My feeling is that this isn't significant and better than returning
> errors for capstone/llvm, having #ifdefs/__maybe_unused for the cases
> we lack the types throughout the code and relying on people building
> noticing a warning to realize they need to install a dependency - the
> alternative of failing the build if the capstone/LLVM header files
> aren't present, and unless some NO_... build option isn't passed,
> likely won't fly with perf developers.

I don't think failing the build due to the optional dependencies is an
option.  I'm not against the idea of dlopen but my concern is to carry
those external definitions in the perf code base.  Maybe it'd be ok if
we could keep it minimally.

Thanks,
Namhyung

