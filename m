Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69D066ABD;
	Thu, 14 Dec 2023 21:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1pKB0rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B10C433C7;
	Thu, 14 Dec 2023 21:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702590219;
	bh=dVr1opMNzahny809YaACJXD2nWH5MTKZJF752YtWN68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1pKB0rnHNPMqUYX+nQety9sEH6VUohSb0VNY+IKBndbMlEHgRluudAY8QRCABRVN
	 4EbI2Th5yP+jNEi/NTvAIcY6bklgvECAh+ds/a2xKgX0gISkh/5oCtA8QZKy1pnVFA
	 udQ9jjlZA87pdWrI7cug1yMvTlBwnqY+CVA7kDd6ZbCGO6JMqyIzOZiAom1n8uSgve
	 +g0tS6FPWAT54qppft8gjbwdAPXeYHU/LBnFEUe/uDHfobySbIIVCx+E8/VaAcnYIK
	 j4gKQRSeaFdTM01jzEP57bogMDJDOrCBK7j4MEAHOplodhQeZEDPjzYSQgEM9DOyxx
	 oJYNT+Swe3E1Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id F39B1403EF; Thu, 14 Dec 2023 18:43:35 -0300 (-03)
Date: Thu, 14 Dec 2023 18:43:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kaige Ye <ye@kaige.org>, James Clark <james.clark@arm.com>,
	Changbin Du <changbin.du@huawei.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	John Garry <john.g.garry@oracle.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf stat: Combine the -A/--no-aggr and --no-merge
 options
Message-ID: <ZXt3B_BoGj2LThiI@kernel.org>
References: <20231214060256.2094017-1-irogers@google.com>
 <cd3c9e63-1ae8-4106-b4ed-e1332b29a4ce@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd3c9e63-1ae8-4106-b4ed-e1332b29a4ce@linux.intel.com>
X-Url: http://acmel.wordpress.com

Em Thu, Dec 14, 2023 at 10:10:57AM -0500, Liang, Kan escreveu:
> On 2023-12-14 1:02 a.m., Ian Rogers wrote:
> > The -A or --no-aggr option disables aggregation of core events:
<SNIP>
> > The --no-merge option disables the aggregation of uncore events:
<SNIP>
> > Having two options confuses users who generally don't appreciate the
> > difference in PMUs. Keep all the options but make it so they all
> > disable aggregation both of core and uncore events:

> > Update the relevant perf-stat man page information.
 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applied to perf-tools-next.

- Arnaldo

