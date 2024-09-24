Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6461AC433;
	Tue, 24 Sep 2024 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727202332; cv=none; b=Vjhs+Gc2o4OoTu4Zz5oyJC1ly4nQYi21c3lUzjqAAx2Qr6cR/F0shJ/dcifbO+LGQRmWaBnAfy6/yxgov6+rKUnLAGEXl0PpE1McMMMQhFoZzsEq7DyFmuBggRGTPOUNSc2T8pGOBhkYibvdcbQD5eAdPteQ25X5e8I9GO6dkdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727202332; c=relaxed/simple;
	bh=y/m8XbD9fsa6X/SrLt/Xwc5xcmo/U88a+EAvRh4A4mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPH0MsgAae69qrv+rBSZFHP73if+O5rcBPBkUzzJAG11GM0RUEVr/kollbNLiEajgI0NVTF0oSD4j6sr12Z0St9oR3y5uLy4tvts3FjkrTKpUKMT/hc3MQHO+FQPAwiruNzB6m7igbdRnpD2vdkC2sMLlGG75ZZC9y2lCv8Sa9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh1bZEKZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh1bZEKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7241AC4CEC4;
	Tue, 24 Sep 2024 18:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727202332;
	bh=y/m8XbD9fsa6X/SrLt/Xwc5xcmo/U88a+EAvRh4A4mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vh1bZEKZnJRo77KBEed+UCQ9aay21hk3PPolCzuveTf440CikQVXlOFguQDyBHdrO
	 Pe5FA6nLsx1pPm3ZUmvN9+jE67FIHkoFaguYs2ucgb0D5UhZ4n23OR5IMj4YeN0XAW
	 7QOZ2fx6Qoh48Rsf1bOj9qxXCqIcstgsu4sS7pDblugwoszKcm4uHNVk+vyPC9/r4E
	 ZNcrO5QPnwaJ2cUYTwEoJwb1wPK64Bd/e1BG2VwdUJS3FBcaT8ahC5dL4Q32P1lrUO
	 V4JUIoNNze3JLAvnZfeO+H4UWxxf8D0KWHZWyudxfsbDHP3zDbz67G5ZJQ6dMsrXt3
	 Xa3WbnF8NsPZg==
Date: Tue, 24 Sep 2024 11:25:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Hemant Kumar <hemant@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yang Jihong <yangjihong@bytedance.com>, leo.yan@arm.com
Subject: Re: [PATCH v1 0/3] 2 memory fixes and a build fix
Message-ID: <ZvMEGn5RIWMZNvFc@google.com>
References: <20240924003720.617258-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924003720.617258-1-irogers@google.com>

On Mon, Sep 23, 2024 at 05:37:17PM -0700, Ian Rogers wrote:
> I was looking into some lsan regressions and a latent issue with
> libdw, creating these fixes.
> 
> A thought, we should probably simplify the libdw logic but rather than
> do it here I'll do it as a separate series on top of these. The issues
> I see are:
> 
> 1) dwfl_thread_getframes is used to test for the presence of
>    libdw-dwarf-unwind. The blame date on this function is
>    2013-05-30. As the function is 10 years old I think having libdw
>    implies having dwfl_thread_getframes and so we can just merge the
>    two pieces of logic instead of having different feature tests and
>    ifdefs.
> 
> 2) similarly, dwarf_getlocations has a blame date of 2013-08-23 so
>    let's just make libdw tests test for this and make having libdw
>    imply dwarf_getlocations support.
> 
> 3) similarly, dwarf_getcfi has a blame date of 2009-06-24 so let's
>    just make libdw tests test for this and make having libdw imply
>    dwarf_getcfi support.
> 
> 4) in Makefie.config feature-dwarf is a synonym for libdw support. I
>    think using the name libdw is more intention revealing as dwarf can
>    mean multiple things. Let's change HAVE_DWARF_SUPPORT to
>    HAVE_LIBDW_SUPPORT and all similar dwarf vs libdw names.
> 
> 5) We have "#if _ELFUTILS_PREREQ(0, 142)" testing for elfutils version
>    0.142. Elfutils 0.142 was released around 2009-06-13 (via git blame
>    on the NEWS file). Let's remove the #if and ensure elfutils feature
>    tests for at least 0.142. If someone were using an incredibly old
>    version then they'd lose some elfutils support, but given the 15
>    year old age of the library I find it unlikely anyone is doing
>    this. They can also just move to a newer version.

Looking at the map file in libdw, the latest addition was 0.158 for
dwfl_thread_getframes().  Probably we can add the version check to the
feature test to make sure if it has all the required APIs.

https://sourceware.org/git/?p=elfutils.git;a=blob;f=libdw/libdw.map;h=552588a94c0c1a1f2fd5b973553c784026e6de14;hb=HEAD#l274

> 
> From the mailing list I notice also overlap with the last patch and
> this series:
> https://lore.kernel.org/lkml/20240919013513.118527-1-yangjihong@bytedance.com/
> Simplifying the libdw support will address some of those issues too.

Yeah I noticed that too and feel like it should go to perf-tools tree.
Probably it doesn't clash with this so I think it's ok to have this in
perf-tools-next.

Thanks,
Namhyung

> 
> Ian Rogers (3):
>   perf disasm: Fix capstone memory leak
>   perf probe: Fix libdw memory leak
>   perf build: Fix !HAVE_DWARF_GETLOCATIONS_SUPPORT
> 
>  tools/perf/Makefile.config     |  6 ++++++
>  tools/perf/util/disasm.c       | 11 +++++++----
>  tools/perf/util/dwarf-aux.h    |  1 +
>  tools/perf/util/probe-finder.c |  5 +++++
>  4 files changed, 19 insertions(+), 4 deletions(-)
> 
> -- 
> 2.46.0.792.g87dc391469-goog
> 
