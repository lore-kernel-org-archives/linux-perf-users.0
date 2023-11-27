Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6D831728
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sP2j4SMQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150DDC433C7;
	Mon, 27 Nov 2023 14:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701095465;
	bh=PbhIFUrBhOvnfv4NDx5a77aTGBoap14K6Uj6Djcsix4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sP2j4SMQRM0RqzTchLsoyEHreiBoofKTOODh2t08XfmwSlVy6Z4tjOoKFqb6eYahW
	 3mmPO7VA+2aeKI5BqKFd/0BYER+Auje4bUgyCfVBPJCgFd2ijS2fUoAx9FLX8IFlNl
	 wO2XguiKU7rIPj2cwaEW1JKUuK6Q0mH6no0a8rPO9W2keDW6ggGIEqnt3u9d99QJJZ
	 pEzCRN9+7naXwB1hyanofuxQ6xlnmMuB6SMumbmZQi6i7HjIIRkIraH1UYspjkZpum
	 VQ7bGmQpOgf/afSmbJ61fjsYW9YmYut0U0IqzsevO1cejRAtZWgBnwoCiQvULBCyb6
	 iHO2/D0SnCxpA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id BF84040094; Mon, 27 Nov 2023 11:31:02 -0300 (-03)
Date: Mon, 27 Nov 2023 11:31:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Tinghao Zhang <tinghao.zhang@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>, James Clark <james.clark@arm.com>,
	German Gomez <german.gomez@arm.com>, Leo Yan <leo.yan@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/8] perf tests: Reduce inexplicable test failures
Message-ID: <ZWSoJnUWnp5Os9zZ@kernel.org>
References: <20231123075848.9652-1-adrian.hunter@intel.com>
 <ZV9cgN3e7jWcRwlu@kernel.org>
 <5B01AC52-3A95-48E2-BBA8-EC499DFFDFC3@linux.vnet.ibm.com>
 <ZWSYYeWGTMQ1OblG@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWSYYeWGTMQ1OblG@kernel.org>
X-Url: http://acmel.wordpress.com

Em Mon, Nov 27, 2023 at 10:23:45AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Nov 27, 2023 at 12:49:13PM +0530, Athira Rajeev escreveu:
> > > On 23-Nov-2023, at 7:36 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > I didn’t find this in either of these places:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf-tools-next
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-tools-next
> 
> I was still testing it on the containers setup, it is at:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf-tools-next
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=tmp.perf-tools-next
> 
> And will move to the perf-tools-next branches soon, I just collected
> some more acked-by for some patches in the tmp branch and will push the
> updated branch.

Done.

- Arnaldo
