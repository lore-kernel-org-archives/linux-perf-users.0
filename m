Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB8954F9A
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Dec 2023 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpfnzWkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DB4C433C8;
	Mon, 11 Dec 2023 21:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702330379;
	bh=SOhK9Lq2M03sHZRGNtRe2gM1uwO43Dw3Vsd4hkpKqeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QpfnzWkI9kltgIjchkhkVBWL5Ymd8PEmkFsAPYhKAONsoVGCqAkGBM/z97al55l+o
	 jUeuKhRn8eefNEYz9ol+IKkYG1hFgVSzrCMLzVLu9h1omUt2/Ji3uVOoyEvzuYF+SZ
	 VD4v87Pzhr3uMwltGLzV8YWTBqQm72f8A6eON+nGWpuD1qBPfqCRlLiB7M7nU8roVQ
	 JJAFCATWC/ppt9Q1p1C+JlAPYGxM8lzmSbOtgPsJ6zekHBVr3DHmi5GPnpeCotGOxa
	 PWloC1wSyDfMsruZxObMUMxaTWLsGalnuEylqXOH6rzRF2yFV5s6U+0LoJfrSHpnug
	 kgeDwlpRvY59Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id C30FD403EF; Mon, 11 Dec 2023 18:32:56 -0300 (-03)
Date: Mon, 11 Dec 2023 18:32:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1] perf stat: Fix help message for --metric-no-threshold
 option
Message-ID: <ZXeACPegTbAHqkHh@kernel.org>
References: <20231129223540.2247030-1-irogers@google.com>
 <CAP-5=fXeZpOg7cHDZmTLvQh=FTamvpdw+=q9vcqrUBd9v7ifLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXeZpOg7cHDZmTLvQh=FTamvpdw+=q9vcqrUBd9v7ifLQ@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Mon, Dec 11, 2023 at 11:39:02AM -0800, Ian Rogers escreveu:
> On Wed, Nov 29, 2023 at 2:36 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Copy-paste error led to help message for metric-no-threshold repeating
> > that of metric-no-merge.
> >
> > Reported-by: Stephane Eranian <eranian@google.com>
> > Fixes: 1fd09e299bdd ("perf metric: Add --metric-no-threshold option")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping. Thanks,

Thanks, applied to perf-tools-next.

- Arnaldo

