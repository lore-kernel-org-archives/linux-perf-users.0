Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44DD67E9C
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Dec 2023 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBjvUUsE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54631C433C8;
	Tue,  5 Dec 2023 15:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701789596;
	bh=ESDuP7NVVlvgAJpmS9L3L4ji0KgGi7hT55Q57KBxzu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBjvUUsE0hmw9JI2Ft9sn5J2xziqoli8xPJp2mIjjibv4EGtM8TNNevzF/QZDuHwa
	 MK5XVsaRAnGzogU77hYHgf64XoL5NwjdCYWf5J/akr+8Kw0rcaQ44+wGy8Y9Is47ef
	 QTOjutmydzGoGsTwdwR6w5UF0MafyFAdUb/2qRsLEtZ6fNlwGebfdzhChV/aOdppGx
	 t9hHxD+OS+FEux5L6ZVKXL++0XBUfoMvb64etlUWp/RwCqeelUnxYKwYXY7dahKlMP
	 Uvy3lzFLIANxKb7/+naCjER9wYcDAVPUt0g24vUAvaL8oy9CyIXB9d33iaboFJJxaB
	 oKvwb5gpw1zZw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id B953740094; Tue,  5 Dec 2023 12:19:53 -0300 (-03)
Date: Tue, 5 Dec 2023 12:19:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: Ian Rogers <irogers@google.com>, John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf metrics: Avoid segv if default metricgroup
 isn't set
Message-ID: <ZW8/mWUuctdg/8fE@kernel.org>
References: <20231204182330.654255-1-irogers@google.com>
 <bea4ad79-297e-9737-8af1-2286192d26f4@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bea4ad79-297e-9737-8af1-2286192d26f4@os.amperecomputing.com>
X-Url: http://acmel.wordpress.com

Em Mon, Dec 04, 2023 at 02:44:54PM -0800, Ilkka Koskinen escreveu:
> 
> 
> On Mon, 4 Dec 2023, Ian Rogers wrote:
> > A metric is default by having "Default" within its groups. The default
> > metricgroup name needn't be set and this can result in segv in
> > default_metricgroup_cmp and perf_stat__print_shadow_stats_metricgroup
> > that assume it has a value when there is a Default metric group. To
> > avoid the segv initialize the value to "".
> > 
> > Fixes: 1c0e47956a8e ("perf metrics: Sort the Default metricgroup")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Thanks! I was going to look for the bug but got pulled to other tasks. The
> patch looks good to me and I tested it successfully on AmpereOne.
> 
>   Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Thanks, applied to perf-tools-next.

- Arnaldo

