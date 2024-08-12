Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAA9142624;
	Mon, 12 Aug 2024 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723492497; cv=none; b=NPbr3Ss1lJc6rFD69NQ8B5MsxkNZV/Q+DEJtylSkYYxdqWL/I6pFDzBby6iAC1duF/aXmfaARcCF8iOHv24RHv9huY7bZkDb+0j08oV2F81QosRlk15efVzqafDoMTfv/uahltClCl6W9vxYMB2REXBV1LCLbEyzEzL5KpukxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723492497; c=relaxed/simple;
	bh=reJhsp5omuXIkWsSZ3Ffxm81fgceHgX1Zq7uRLpnYpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLSOagJia/VRoXJ6kpZvFFMI8RBs4OSANUwrsXhaLywuIGmlPh29iP+NdFQPv+qcy57mS3EjQo+WiBq2kHCK6dE4drIu1W0BITOpZpd6w02OCTEp/gttxwOJPzDN5eEkVSRlY/qwR4zEtgFQyaLBVYMgAGb2v0uOcb90/mNVNHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tdvy1WpI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tdvy1WpI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96A8C32782;
	Mon, 12 Aug 2024 19:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723492496;
	bh=reJhsp5omuXIkWsSZ3Ffxm81fgceHgX1Zq7uRLpnYpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tdvy1WpI1h0G71UnEXCip6KinAyNU3eY/UIg2uLAWEvOQJGnmgEFwLAvyAhzg1nMA
	 tBL8+Zaf7ULTAR7eNEC8n0WyRvS2qOxZv1ZxxgDZa+AbZVYrmvsDqqlmxcRhG4Ngm+
	 WERuvBYOgiuY9zPl43kvGoRUDNgfdIJrOnnEQSVlUgxEt8Pk4WsPuxvXRnPOmUvukj
	 uED8q2loidgp04xsk1l2TlrcvLnnYQ8wejnKwpBdOF69jLOHqZKaDEcwQxwXA/BxUo
	 /pax1lp3FlZJII/k2rP0zz2UhU4Cunw8M2rwCAipF0R3t0+qTYwet7KmYqFypJdK6I
	 LrxY5l0sM4lVQ==
Date: Mon, 12 Aug 2024 16:54:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Nick Terrell <terrelln@fb.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Song Liu <song@kernel.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <siyanteng@loongson.cn>,
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 00/27] Constify tool pointers
Message-ID: <ZrpojZqZHnvJhNWS@x1>
References: <20240718010023.1495687-1-irogers@google.com>
 <738b5c89-acb2-46a5-92a1-c36bd90abc30@intel.com>
 <CAP-5=fU=5LxF0SKuAqVP+xtmdERCCgxh_mdpw5okMi1fmvpE+Q@mail.gmail.com>
 <ZroT3Xut5omFg7ud@x1>
 <CAP-5=fWyEX6+HX5tJNzhzNp81GLjZCDdHZu1vAMN15SVz1Qfiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWyEX6+HX5tJNzhzNp81GLjZCDdHZu1vAMN15SVz1Qfiw@mail.gmail.com>

On Mon, Aug 12, 2024 at 11:10:02AM -0700, Ian Rogers wrote:
> On Mon, Aug 12, 2024 at 6:53 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Fri, Jul 19, 2024 at 09:26:57AM -0700, Ian Rogers wrote:
> > > On Fri, Jul 19, 2024 at 1:51 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > > >
> > > > On 18/07/24 03:59, Ian Rogers wrote:
> > > > > struct perf_tool provides a set of function pointers that are called
> > > > > through when processing perf data. To make filling the pointers less
> > > > > cumbersome, if they are NULL perf_tools__fill_defaults will add
> > > > > default do nothing implementations.
> > > > >
> > > > > This change refactors struct perf_tool to have an init function that
> > > > > provides the default implementation. The special use of NULL and
> > > > > perf_tools__fill_defaults are removed. As a consequence the tool
> > > > > pointers can then all be made const, which better reflects the
> > > > > behavior a particular perf command would expect of the tool and to
> > > > > some extent can reduce the cognitive load on someone working on a
> > > > > command.
> > > > >
> > > > > v6: Rebase adding Adrian's reviewed-by/tested-by and Leo's tested-by.
> > > >
> > > > The tags were really meant only for patch 1, the email that was replied to.
> > > >
> > > > But now for patches 2 and 3:
> > > >
> > > > Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> >
> > Applied 1-3, 4 is not applying, I'll look at it later.
> 
> I have a rebase and can resend. I haven't addressed Adrian's feedback

Please resend then.

- Arnaldo

> as I prefer callers of the tool function pointers not to have to do
> NULL tests, I'm trying to minimize spaghetti. Not sure if you're
> applying the whole series here or just the beginning.
> 
> Thanks,
> Ian
