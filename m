Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B461230F92
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMc5oSRX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E507FC433C8;
	Mon,  4 Dec 2023 20:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701721455;
	bh=t6guQdtuvsHBXGA9XvBw3/0jpl3bZJRV5CbnFCzgr8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WMc5oSRXoiHioGPOtY1GE/dQzL6bQNubzpwIBn8FdTOx62Zdn0JK4Pbjxw50QBPaI
	 0pk4xr8RFQfnHsNwxu7DKHDlRUEvOglimx3Q6XhlLrd57IA2ESTbAjfGjyaz5CN39/
	 K8Ge0PXIsBTJBM3Stqb6D163QI3ug/rVcdXScMQkQuR9CN1k48hpdnBsbE3WGvuL5S
	 BmNsgqx/EFaAP5FHyVSUYq3spfSfJJFWi5tSv8J9wUvTTIVMDV9peFKtqvBQdp1XuD
	 CtSMWerMrtNxo19B3lzLcFyPx++fSj9jPdgoN9wMBn3G6+jldf27MCQliXQ1hNGqyP
	 GOkh6hsdv3+IA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 49F2440094; Mon,  4 Dec 2023 17:24:12 -0300 (-03)
Date: Mon, 4 Dec 2023 17:24:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	atrajeev@linux.vnet.ibm.com
Subject: Re: [PATCH v1] perf test: Add basic perf diff test
Message-ID: <ZW41bFSyg/xQLcEg@kernel.org>
References: <20231120190408.281826-1-irogers@google.com>
 <CAP-5=fWvADeeHVQObwk-eVNeOSC=eTTv2q8Rz4j3UtL5-6Getw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWvADeeHVQObwk-eVNeOSC=eTTv2q8Rz4j3UtL5-6Getw@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Mon, Dec 04, 2023 at 08:00:35AM -0800, Ian Rogers escreveu:
> On Mon, Nov 20, 2023 at 11:04 AM Ian Rogers <irogers@google.com> wrote:
> >
> > There are some old bug reports on perf diff crashing:
> > https://rhaas.blogspot.com/2012/06/perf-good-bad-ugly.html
> >
> > Happening across them I was prompted to add two very basic tests that
> > will give some perf diff coverage.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping.

Thanks, applied to perf-tools-next.

- Arnaldo

