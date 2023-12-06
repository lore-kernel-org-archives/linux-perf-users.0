Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E23364B9
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6Dn1VAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A94C433C8;
	Wed,  6 Dec 2023 13:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701870642;
	bh=uCGoGVcttTSCzC+PBnMTHcee7rAJ4T550zU26XqPTWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O6Dn1VAZUcaGjyLS8uMDLSsxvn6GMyS4hF5jYFb3UG63O0CBODCMg+Q/Quw8jVuRv
	 X/quQU2pjg37pkXoxYijCug45FHtvFQYHxsnJ/5c8ZWus2Mzn9h4zt745mRKw4Rcn3
	 QGj71/nMYRtHrYElOkJozDPCYD3TSV5K9I7cUOGybKuydK/WHZF9+L6wquEJSinGVH
	 uXTRic/FupTI2m+PWmDkvty0RXnYfNLuOcjRLu4YB7RlaUVvBQVQbstiY+xrhZuGe2
	 9drup1MPnU6xgWnoUUMdzPbvoTdu4XP6xZyL+KCKwTPxESGDgBL/+68BODuJk0J8fW
	 4b8cPa/kaLmeA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 6FCFD403EF; Wed,  6 Dec 2023 10:50:39 -0300 (-03)
Date: Wed, 6 Dec 2023 10:50:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dmitrii Dolgov <9erthalion6@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Ming Wang <wangming01@loongson.cn>,
	James Clark <james.clark@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	Leo Yan <leo.yan@linaro.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
	German Gomez <german.gomez@arm.com>,
	Changbin Du <changbin.du@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
	Sandipan Das <sandipan.das@amd.com>,
	liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Guilherme Amadio <amadio@gentoo.org>
Subject: Re: [PATCH v5 13/50] perf maps: Move symbol maps functions to maps.c
Message-ID: <ZXB8L8xhGATtPJJ/@kernel.org>
References: <20231127220902.1315692-1-irogers@google.com>
 <20231127220902.1315692-14-irogers@google.com>
 <CAM9d7chEb_ij73ZhBr9EpT7HE34Hy0aqTOmSWp_-xTwc2=0Zjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chEb_ij73ZhBr9EpT7HE34Hy0aqTOmSWp_-xTwc2=0Zjg@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Mon, Dec 04, 2023 at 03:40:55PM -0800, Namhyung Kim escreveu:
> On Mon, Nov 27, 2023 at 2:09 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Move the find and certain other symbol maps__* functions to maps.c for
> > better abstraction.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next.

- Arnaldo

