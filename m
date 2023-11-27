Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130E51A725
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa3Y1nZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E111C433C7;
	Mon, 27 Nov 2023 13:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701091428;
	bh=C059we5gZtoUR2N+7x+pLdZMoDPDWRQZK42QQNzTTMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qa3Y1nZ2LSyfweJn3bmRdy3P72ve6qCyUCpIjMqMe4BCZ87sb+YWEAVdQe4MjfV9v
	 hp3PWBGYXsxKPcivJD59vQXLvrZjDOCe6EGFiqVNgflR76KWBr1SEAnjtEnes4NCsd
	 ZPwZHBfdAXsKWfLFlfrwPMuFZkQq+Mdn7HWtHbNW3zfOthj/r9cnFgncSgjVIzGUOs
	 ywCZv9BuP7ka2Sq1Ed7b6T+NgwrNYV1pZxt0il9gZks1GQ4YV1DbJESeNs3SF0xIvy
	 Inh5D0fDbpKD8ycujtlD6kiQrdLbE7c/g85QkCKQ8LJg/YPVqnfHynwBFaQ0H9I5sT
	 qi/sd+2PtBKDg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id D2A3040094; Mon, 27 Nov 2023 10:23:45 -0300 (-03)
Date: Mon, 27 Nov 2023 10:23:45 -0300
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
Message-ID: <ZWSYYeWGTMQ1OblG@kernel.org>
References: <20231123075848.9652-1-adrian.hunter@intel.com>
 <ZV9cgN3e7jWcRwlu@kernel.org>
 <5B01AC52-3A95-48E2-BBA8-EC499DFFDFC3@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5B01AC52-3A95-48E2-BBA8-EC499DFFDFC3@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com

Em Mon, Nov 27, 2023 at 12:49:13PM +0530, Athira Rajeev escreveu:
> 
> 
> > On 23-Nov-2023, at 7:36 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > Em Thu, Nov 23, 2023 at 09:58:40AM +0200, Adrian Hunter escreveu:
> >> Here are some small changes to help reduce inexplicable perf test failures.
> > 
> > Looks ok, applying to perf-tools-next, had to remove a patch adding a
> > new test, by Kan Liang, then reapply it on top of your series, git
> > managed to sort it out:
> 
> Hi Arnaldo,
> 
> I didn’t find this in either of these places:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf-tools-next
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-tools-next

I was still testing it on the containers setup, it is at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf-tools-next
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=tmp.perf-tools-next

And will move to the perf-tools-next branches soon, I just collected
some more acked-by for some patches in the tmp branch and will push the
updated branch.

- Arnaldo
 
> Sorry if I missed checking correct location. Can you please point to git link ?
> 
> Thanks
> Athira
> > 
> > https://lore.kernel.org/r/20231107184020.1497571-1-kan.liang@linux.intel.com
> > 
> > 
> > - Arnaldo
> 

-- 

- Arnaldo
