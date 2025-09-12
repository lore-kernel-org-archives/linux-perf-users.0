Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E59B32F75A;
	Fri, 12 Sep 2025 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757702583; cv=none; b=aUrQYoEfg+FvEI76Zhuc5DmwZ1SAdW/pgLb5HUML/r2UC93y0zi1A505w/e2HzxxMqsx2qtmHzVK2TBOKPK1Z1IWPhUR3uyfuxKVp18wt6hY8q6SilIul/uSqerJp7xehy89nsdiq13ulgzmHzQK0wJdO3uH8YK4E7v1R17ubPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757702583; c=relaxed/simple;
	bh=D0clgkctfrZJnVUH+9vtHrUnzvfCM/OSdMFRW1vG2rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQmOjvd3cDxgdxFxbIxwpHhxfDV/eCGGDGKSbGKSbyn8Zq409fTfeQpDqC+VMDMxAc1ygYbiA22p3621MaXN6RI5sMICLPjFnTbo4FFYdZ9OCtdxgUNSujITK+napGpuDYFQ3cPQ3LezET1OYmedmlFi0XamOLUYXP52SuUxxxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McRagtrZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McRagtrZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B53C4CEF1;
	Fri, 12 Sep 2025 18:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757702582;
	bh=D0clgkctfrZJnVUH+9vtHrUnzvfCM/OSdMFRW1vG2rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=McRagtrZQRd5FD7uv3EnEXjG5XDsgaZSOXZudeFe0ogEhzMTYH4Cnd/sz/q0zPJV6
	 xNQ06XQTwjoeG/7GArEJRMfk/KHvDPBkBPQ2kix9FHvzU8UxkoTOR/2xt0bWvotLg2
	 hbphQMY5ZmfIn9fsK1FmVyLXJyg/bEBHO19C+pBYkXQEAEl5wu/iHDHe5s4N61ixiR
	 pdz/JZfEogXlSCONeUL3JI/RuG+eWrkJKjbt8KPq4NiiXZuqhGae8L95aPkG+7FWNN
	 r+MiK2WuWeZGi9meNx0MaveHrhULUc+CEXbqduHhZhK016P7rDSvvMPZ5YsxS+bps+
	 PDg33A4qWUW7Q==
Date: Fri, 12 Sep 2025 15:42:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Yunseong Kim <ysk@kzalloc.com>, Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf util: Fix compression checks returning -1 as bool
Message-ID: <aMRps1jV6VHPOnT-@x1>
References: <20250822162506.316844-3-ysk@kzalloc.com>
 <CAP-5=fUcsd--WrwEnRja2pX+-5Z6d4Qyf7t4Fybhixw+WYY-5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUcsd--WrwEnRja2pX+-5Z6d4Qyf7t4Fybhixw+WYY-5Q@mail.gmail.com>

On Fri, Aug 22, 2025 at 09:34:07AM -0700, Ian Rogers wrote:
> On Fri, Aug 22, 2025 at 9:28 AM Yunseong Kim <ysk@kzalloc.com> wrote:
> >
> > The lzma_is_compressed and gzip_is_compressed functions are declared
> > to return a "bool" type, but in case of an error (e.g., file open
> > failure), they incorrectly returned -1.
> >
> > A bool type is a boolean value that is either true or false.
> > Returning -1 for a bool return type can lead to unexpected behavior
> > and may violate strict type-checking in some compilers.
> >
> > Fix the return value to be false in error cases, ensuring the function
> > adheres to its declared return type improves for preventing potential
> > bugs related to type mismatch.
> >
> > Fixes: 4b57fd44b61b ("perf tools: Add lzma_is_compressed function")
> > Fixes: 88c74dc76a30 ("perf tools: Add gzip_is_compressed function")
> > Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
