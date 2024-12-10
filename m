Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EF721420D;
	Tue, 10 Dec 2024 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733860699; cv=none; b=HxmBQSNO46RnR5O+dlXU+EcbMzND7ZeYTmhU6V0YnKZvZclyA1ToG8Kg7QSRFwgOGC5wzQqCF6qjNrsilTNTYpPwUXvjWqK79cBzJps2RyqPVHLn5uSRmPigQLuNCRPUPRG/SNrqsTsaaLAtIhxpofqlD0FZSE+DTzQ6TWDpjoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733860699; c=relaxed/simple;
	bh=Q48D6eSle1Giur4AHocHTxFby2pB1oK2B5FQSLMLK+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AM4cwESN+7WQqLykaeujAAaaJuicF4zu2NL06XnbfXERqoRr60YGqb0pJz6xTka1buKAHeXtruDvNcxBz+fXpASwJBl38UIFvbmcFWfviVMOzfyMuRRJVm40m6jkSAcEw+7RE9lRhZQheJE37ypdkW4z7cx9zMpKdeg+Ge9gs+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaNvVX2X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaNvVX2X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E06C4CED6;
	Tue, 10 Dec 2024 19:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733860699;
	bh=Q48D6eSle1Giur4AHocHTxFby2pB1oK2B5FQSLMLK+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GaNvVX2XXyXQh2hugOvG4J5qDqMbWlcXUA/g7bsTeoIyDc57Q62GLDmP4gSTuDRC5
	 OpdpYPrBEQpJQJMFke6tn4GR/x9MbWlMGF/6Niv/ExzenRhowHHsGtiDPSXx5eKDUu
	 AoVO0kGEnNyrSqmjCFtie57P+FmLOrjJUyhCj0hbz1y8GWVrGP2ZQGi1btA16Y/5yu
	 eXHnbq3PcxA+M1k/OAy+lhrqkNr10NZ9OqsoWTpefbcEhYUkedmEtwLoC8GWitveEb
	 Ct5dOiKF95AxqQOPZaqYz7E1asNQzcB2R4NhTOdjCG6JlX5mLN/yKEXc/Wd0yQ1b3B
	 BuKm7gMfOOoXA==
Date: Tue, 10 Dec 2024 16:58:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Sandipan Das <sandipan.das@amd.com>, Xu Yang <xu.yang_2@nxp.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf jevents: Fix build issue in '*/' in event
 descriptions
Message-ID: <Z1idV3K4RxLdMhT_@x1>
References: <20241113165558.628856-1-irogers@google.com>
 <CAP-5=fWK-eeDEvE4+LeeScbHFecmc5+H8WB_5fepfrJJLZsF0Q@mail.gmail.com>
 <Z1dS6HrfkVS4OeZz@x1>
 <CAP-5=fUze9j8etq-17L0dWVoYfE-bA+61wrEAXN9vJSCj9dCbw@mail.gmail.com>
 <Z1g-8ggHQ8MoVNhx@x1>
 <Z1iTtJcMMsuwI0JX@x1>
 <CAP-5=fXN-KaVnyciw-YBauS=QSWfi36Aan9eGu1xFV57MDcnNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXN-KaVnyciw-YBauS=QSWfi36Aan9eGu1xFV57MDcnNA@mail.gmail.com>

On Tue, Dec 10, 2024 at 11:24:28AM -0800, Ian Rogers wrote:
> On Tue, Dec 10, 2024 at 11:17 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Tue, Dec 10, 2024 at 10:15:30AM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Mon, Dec 09, 2024 at 01:29:15PM -0800, Ian Rogers wrote:
> > > > On Mon, Dec 9, 2024 at 12:28 PM Arnaldo Carvalho de Melo
> > > > <acme@kernel.org> wrote:
> > > > >
> > > > > On Mon, Dec 09, 2024 at 10:35:34AM -0800, Ian Rogers wrote:
> > > > > > On Wed, Nov 13, 2024 at 8:56 AM Ian Rogers <irogers@google.com> wrote:
> > > > > > >
> > > > > > > For big string offsets we output comments for what string the offset
> > > > > > > is for. If the string contains a '*/' as seen in Intel Arrowlake event
> > > > > > > descriptions, then this causes C parsing issues for the generated
> > > > > > > pmu-events.c. Catch such '*/' values and escape to avoid this.
> > > > > > >
> > > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > >
> > > > > > Ping.
> > > > >
> > > > > A fixes: is missing, probably this should go via perf-tools, i.e. for
> > > > > this merge window?
> > > >
> > > > We don't yet have arrowlake events/metrics, should there be a fixes?
> > >
> > > Ok, thanks for the clarification.
> > >
> > > > I'm just preparing the patches for the latest vendor json from Intel,
> > > > but they will depend on this. I suspect given the size of the vendor
> > > > json it will miss the current merge window.
> > >
> > > Probably best to have big patches via perf-tools-next at this point in
> > > time.
> >
> > I'm seeing this after applying:
> >
> > /home/acme/git/perf-tools-next/tools/perf/pmu-events/jevents.py:434: SyntaxWarning: invalid escape sequence '\*'
> >   return s.replace('*/', '\*\/')
> 
> It likely needs to be:
> ```
> return s.replace('*/', r'\*\/')
> ```
> note the r. Could you test for me?

Sure.

- Arnaldo
