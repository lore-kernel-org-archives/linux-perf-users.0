Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1139A14A087;
	Mon,  5 Aug 2024 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889116; cv=none; b=dxYxfXAI5gx4ymZ3OQF5fJrrJxwfU9uLq5RZ7QKog/6OcxTw6w2zX5C/nG6tupjExhRjbF0MctQag7bNt89xGrGCUxRsGqU02WshFDQHbDz1o5TgcsSr8xfs3YlphIGNWbYSfl+JnL8O1ydSrJ1Us+K8pb0r7KHMjmPbylOWqAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889116; c=relaxed/simple;
	bh=71HpcIkqMphJdYmkaI3pVI7vOf/CK+5FbTmC0UwH1Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPLuf4QqHEEY8a5BLdrkOBue5Q8vutGhTwyzVMPxLSsCwfSha22u9I7ATL6CTZX59CA7Vo9mFnh5y2+R5byqhYf+Koaug1GRgnDcic1QUJikzg+5jE/9fju6cejj6RKXQIRtElRMczF0QcFftBs0igB3kQgCEbal/OOOPVVl63w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWD7vmGN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWD7vmGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39A9C32782;
	Mon,  5 Aug 2024 20:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722889115;
	bh=71HpcIkqMphJdYmkaI3pVI7vOf/CK+5FbTmC0UwH1Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWD7vmGNnAXtOrVq+KC2Ap08IoSuY/I2bQiXUCYDsbwRxon1TliKrzT7i+yTlgsz7
	 MXX1bf8msfmPHnU5tPdL2//Uh6PtSW+TPeIT/gvzDjYe31BavRV/c66B9DS3e8P40c
	 fEUnWmDJqBscQR8Ex7T/6Hljq7Q+y7g+NWORrZBuJfQkEEIeb40zXjQiK8FgsPkoza
	 +L82x3Hp1WwDvIg8PNOGfKzNukE9fjtBVS+K2nISWZ/2+c/0pL85+Qwf4oErEqeN/6
	 Jki222D8EEGHb56K92Q12bE/Fqb84QSuPZPhrOPELPHL6JdmZ3VRnniNYB0ndl/24N
	 DQGfvHkYcEldw==
Date: Mon, 5 Aug 2024 17:18:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Eric Lin <eric.lin@sifive.com>, Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, vincent.chen@sifive.com,
	greentime.hu@sifive.com, Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH] perf pmus: Fix duplicate events caused segfault
Message-ID: <ZrEzl-QftBU2cNK0@x1>
References: <20240719081651.24853-1-eric.lin@sifive.com>
 <2C7FF61F-2165-47D4-83A4-B0230D50844D@linux.vnet.ibm.com>
 <CAPqJEFrkurD9B9smy908Y-z-f6ckv+ZFJzo6ptwXmxD0ru5=CA@mail.gmail.com>
 <CAPqJEFqCXd1FWCgB0919r+J0XW7KVX_OWZNdocva-bxcscjTrw@mail.gmail.com>
 <BB8E0B26-4E5F-416F-B8D1-AC745F141383@linux.vnet.ibm.com>
 <CAP-5=fVttTnWV7KpiaxNjyiDXt9Uf5zZEm4v5V4mGXMyRr6nSg@mail.gmail.com>
 <CAP-5=fU13UYkXZVOcJP+xiRLhDDRycJn=P1wnJi4KnB9KGdpkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU13UYkXZVOcJP+xiRLhDDRycJn=P1wnJi4KnB9KGdpkQ@mail.gmail.com>

On Mon, Aug 05, 2024 at 12:48:23PM -0700, Ian Rogers wrote:
> On Mon, Aug 5, 2024 at 10:02 AM Ian Rogers <irogers@google.com> wrote:
> > On Mon, Aug 5, 2024 at 7:24 AM Athira Rajeev <atrajeev@linux.vnet.ibm.com> wrote:
> > > > On 4 Aug 2024, at 8:36 PM, Eric Lin <eric.lin@sifive.com> wrote:
> > > > On Sun, Jul 21, 2024 at 11:44 PM Eric Lin <eric.lin@sifive.com> wrote:
> > > > Kindly ping.

> > > > Can I ask, are there any more comments about this patch? Thanks.

> > > The functions there says alias and to skip duplicate alias. I am not sure if that is for events

> > Fwiw, I'm trying to get rid of the term alias it should mean event.
> > For some reason the code always referred to events as aliases as
> > exemplified by:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=tmp.perf-tools-next#n55
> > But it is possible to have an "alias" (different) name for a PMU and
> > I'm sure for other things too. So the term alias is ambiguous and
> > these things are events, so let's just call them events to be most
> > intention revealing.

> > > Namhyung, Ian, Arnaldo
> > > Any comments here ?

> > I'll take a look.
> 
> The problematic events all come from copy pasting ArchStdEvent. It
> feels better to have an invariant that events appear once so I sent
> out a series to clean this up:
> https://lore.kernel.org/linux-perf-users/20240805194424.597244-1-irogers@google.com/
> If you could test and add a tested-by tag that'd be great!

I have the series in tmp.perf-tools-next, will collect
Tested-by/Reviewed-by if they are provided, before moving it to
perf-tools-next.

- Arnaldo
