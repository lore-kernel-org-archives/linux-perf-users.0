Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AC930CFB
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5qj96he"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32937C433C8;
	Mon,  4 Dec 2023 20:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701721249;
	bh=uXsMRf4AnW+3og18WFArHOjfvgwr0d9HHrwUo5jLANU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g5qj96heR++eP05eMOPtzh2J1eaVN2/JyLiV4ZXZ82Yqf5C9G33z4LX7yjo5Ir8oX
	 eOmY2GRCBA3yqc7qaZjJ+0HH6NDv82WVevvMQMmjTheqsgR+Wp2tmgqP/JLr3dt2XI
	 9Z4yLioayqw5sr2hBuyIbsvsVLkjuRTJIRvR5gnxPup8JATRnE21FLmN77bMHiQFZT
	 xknzhdaMwsmVwMcaGu5+QTnMhDQBgN9M+gsHal7rhBLIbeQBnf+ooBDxV7OSXU4kyS
	 7eR9yYfrsc7xXNuYwmZ+wvAsHlwFnAkLzpPd8qk1gBesN3W4MFVnrIeQY5ca3sgCPF
	 Q/RBC89PFZpTg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id DB72740094; Mon,  4 Dec 2023 17:20:46 -0300 (-03)
Date: Mon, 4 Dec 2023 17:20:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
	adrian.hunter@intel.com, james.clark@arm.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH] perf vendor events: Update datasource event name to fix
 duplicate events
Message-ID: <ZW40nstmGUeV9Fie@kernel.org>
References: <20231123160110.94090-1-atrajeev@linux.vnet.ibm.com>
 <CAP-5=fWtLHCyZh_6hBkCg16ekOXfwSGAVT9xvgKcUsMcu=Ou9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWtLHCyZh_6hBkCg16ekOXfwSGAVT9xvgKcUsMcu=Ou9w@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Mon, Dec 04, 2023 at 12:12:54PM -0800, Ian Rogers escreveu:
> On Thu, Nov 23, 2023 at 8:01 AM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
> >
> > Running "perf list" on powerpc fails with segfault
> > as below:
> >
> >    ./perf list
> >    Segmentation fault (core dumped)
> >
> > This happens because of duplicate events in the json list.
> > The powerpc Json event list contains some event with same
> > event name, but different event code. They are:
> > - PM_INST_FROM_L3MISS (Present in datasource and frontend)
> > - PM_MRK_DATA_FROM_L2MISS (Present in datasource and marked)
> > - PM_MRK_INST_FROM_L3MISS (Present in datasource and marked)
> > - PM_MRK_DATA_FROM_L3MISS (Present in datasource and marked)
> >
> > pmu_events_table__num_events uses the value from
> > table_pmu->num_entries which includes duplicate events as
> > well. This causes issue during "perf list" and results in
> > segmentation fault.
> >
> > Since both event codes are valid, append _DSRC to the Data
> > Source events (datasource.json), so that they would have a
> > unique name. Also add PM_DATA_FROM_L2MISS_DSRC and
> > PM_DATA_FROM_L3MISS_DSRC events. With the fix, perf list
> > works as expected.
> >
> > Fixes: fc1435807533 ("perf vendor events power10: Update JSON/events")
> > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> 
> Given duplicate events creates broken pmu-events.c we should capture
> that as an exception in jevents.py. That way a JEVENTS_ARCH=all build
> will fail if any vendor/architecture would break in this way. We
> should also add JEVENTS_ARCH=all to tools/perf/tests/make. Athira, do
> you want to look at doing this?

Should I go ahead and remove this patch till this is sorted out?

- Arnaldo
