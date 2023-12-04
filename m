Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9935930CFB
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 20:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZVcGy0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A61C433B8;
	Mon,  4 Dec 2023 20:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701721323;
	bh=PjUxLEuMpPT3Gh8kqwZ43jGuO0j2CLzhXvjSFTof8dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZVcGy0mxpw2Hn/hgqHSUccNQ84SY5TwbiJWA+Ur8xUSVXOz7/rZCD1x1JH6UACTZ
	 GXmnmMk9Dpd/l2QwukdMYt+NLR3W8Ojnizf3NluhSPtKM9xZEBuXoyvcfA3elST5pL
	 xpLsk3T1FrHcv0dfrkY75YnIDe63vnnh3XR1POfmo83iLKfQ/KpBav4P8vpWRpbigI
	 FW402qW8qWj/BWAp8JabZOahUgiTpqGKminukOguSg4HVKosSXwQB0XWsSm0mbBfBe
	 uN5mhs1Ctq3ctowQ7wzSCswRNebKaZcCk1PedAHx5L1WlGOHHxmq5xuI5048zOdcev
	 fGkhtPwDSJTbQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id BC96C40094; Mon,  4 Dec 2023 17:22:00 -0300 (-03)
Date: Mon, 4 Dec 2023 17:22:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
	adrian.hunter@intel.com, james.clark@arm.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH] perf vendor events: Update datasource event name to fix
 duplicate events
Message-ID: <ZW406O38z3DmVwOX@kernel.org>
References: <20231123160110.94090-1-atrajeev@linux.vnet.ibm.com>
 <CAP-5=fWtLHCyZh_6hBkCg16ekOXfwSGAVT9xvgKcUsMcu=Ou9w@mail.gmail.com>
 <ZW40nstmGUeV9Fie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZW40nstmGUeV9Fie@kernel.org>
X-Url: http://acmel.wordpress.com

Em Mon, Dec 04, 2023 at 05:20:46PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Dec 04, 2023 at 12:12:54PM -0800, Ian Rogers escreveu:
> > On Thu, Nov 23, 2023 at 8:01 AM Athira Rajeev
> > <atrajeev@linux.vnet.ibm.com> wrote:
> > >
> > > Running "perf list" on powerpc fails with segfault
> > > as below:
> > >
> > >    ./perf list
> > >    Segmentation fault (core dumped)
> > >
> > > This happens because of duplicate events in the json list.
> > > The powerpc Json event list contains some event with same
> > > event name, but different event code. They are:
> > > - PM_INST_FROM_L3MISS (Present in datasource and frontend)
> > > - PM_MRK_DATA_FROM_L2MISS (Present in datasource and marked)
> > > - PM_MRK_INST_FROM_L3MISS (Present in datasource and marked)
> > > - PM_MRK_DATA_FROM_L3MISS (Present in datasource and marked)
> > >
> > > pmu_events_table__num_events uses the value from
> > > table_pmu->num_entries which includes duplicate events as
> > > well. This causes issue during "perf list" and results in
> > > segmentation fault.
> > >
> > > Since both event codes are valid, append _DSRC to the Data
> > > Source events (datasource.json), so that they would have a
> > > unique name. Also add PM_DATA_FROM_L2MISS_DSRC and
> > > PM_DATA_FROM_L3MISS_DSRC events. With the fix, perf list
> > > works as expected.
> > >
> > > Fixes: fc1435807533 ("perf vendor events power10: Update JSON/events")
> > > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > 
> > Given duplicate events creates broken pmu-events.c we should capture
> > that as an exception in jevents.py. That way a JEVENTS_ARCH=all build
> > will fail if any vendor/architecture would break in this way. We
> > should also add JEVENTS_ARCH=all to tools/perf/tests/make. Athira, do
> > you want to look at doing this?
> 
> Should I go ahead and remove this patch till this is sorted out?

I'll keep it, its already in tmp.perf-tools-next, we can go from there
and improve this with follow up patches,

- Arnaldo
