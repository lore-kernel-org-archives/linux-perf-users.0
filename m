Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579485F1EE
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Dec 2023 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6KocxkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A3DC433C8;
	Tue,  5 Dec 2023 15:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701791474;
	bh=Qg5ESRd5FBfKW+n1IMVwA9nXFoeDUKVN3mRCnzAwGNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n6KocxkDs7zs6xJqEs1RwbNasZrkNYn/OOPqK2h6Zar0nQQ/ZiGIKcsRNdxFHOi/s
	 mMmf4IV0SNrfOEQ54GRoNeA5i1oS1sMqNRp3TcKHV6h2tD5A3Go4hqvdxmuKRqokXw
	 6GOtJWx/JqcrTepMgWkn4TmYYGs0Xs/VqACqr6j3zri8JcycBlrsu6XPd/1ZpZ1UVA
	 l8BKBp1zNmuNfRIqa/QUDNg0oFjLI96mWjuOYINVQ+PIdGi0ZgXl/k+4ufq5mc3V1s
	 hPli+d7MB8sVLC8RKvdyu/ah+9ps2K3yDZkX8Kyq5Q3V5rYa+emDnK10N/Z0V2XDv6
	 bFh5MNrkk2I2A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 1882540094; Tue,  5 Dec 2023 12:51:12 -0300 (-03)
Date: Tue, 5 Dec 2023 12:51:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ian Rogers <irogers@google.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf metrics: Avoid segv if default metricgroup
 isn't set
Message-ID: <ZW9G8Clxwl6bd0H6@kernel.org>
References: <20231204182330.654255-1-irogers@google.com>
 <bea4ad79-297e-9737-8af1-2286192d26f4@os.amperecomputing.com>
 <CAM9d7ci=Tk845H3x3KMDu-hTdP-u0O6a8D3iAa8EnFLLjOO6OQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ci=Tk845H3x3KMDu-hTdP-u0O6a8D3iAa8EnFLLjOO6OQ@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Mon, Dec 04, 2023 at 07:33:18PM -0800, Namhyung Kim escreveu:
> On Mon, Dec 4, 2023 at 2:45 PM Ilkka Koskinen <ilkka@os.amperecomputing.com> wrote:
> > On Mon, 4 Dec 2023, Ian Rogers wrote:
> > > A metric is default by having "Default" within its groups. The default
> > > metricgroup name needn't be set and this can result in segv in
> > > default_metricgroup_cmp and perf_stat__print_shadow_stats_metricgroup
> > > that assume it has a value when there is a Default metric group. To
> > > avoid the segv initialize the value to "".

> > > Fixes: 1c0e47956a8e ("perf metrics: Sort the Default metricgroup")
> > > Signed-off-by: Ian Rogers <irogers@google.com>

> > Thanks! I was going to look for the bug but got pulled to other
> > tasks. The patch looks good to me and I tested it successfully on
> > AmpereOne.

> >    Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
 
> Looks like it needs to go through perf-tools for v6.7.
> Ian, do you think this one is enough?

So I had this on my local perf-tools-next, removed now, I also have some
other fixes by Ian on the tmp.perf-tools-next, please let me know what
you guys decide to have in perf-tools for v6.7 so that I can remove it
from there.

- Arnaldo
