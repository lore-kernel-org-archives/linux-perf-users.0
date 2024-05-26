Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F928F6A;
	Sun, 26 May 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716721808; cv=none; b=Axt9ty9A9ISR06EEPJosfh0qR0+WZdeSfz1Aqd2oiweFoksc87shibbBpbDitQYshoanRKxBCv+fTbIQRgOmU2MqnXP2nzFRnMnJH2bv+6pttpkrBnDjd0C2MlAvxao5Wm9iYh7szIsWcQBUTEnzualDdPajFQMakdvFosqW0o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716721808; c=relaxed/simple;
	bh=Vj982JLrWOcJw9DCj7R+f8VzhJL6EXf6MOZT4Q46SH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnfFZW9kGFZkkzK9qhirO5GYIOuyta/WDZdM0HzPhr3gBa2EnCkREFVlkw5apPEwIO5doNO+nouYQKqbpMiTJ4eLOzdK7lVBVpHW64jrBnlV8ZsGoqVapECL9cO4J4KLFJg6ttEkJavoOf9E5a5eqOPvpxm3ySKyZye3Ulk9Sm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQ5vhup4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQ5vhup4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FB3C32782;
	Sun, 26 May 2024 11:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716721808;
	bh=Vj982JLrWOcJw9DCj7R+f8VzhJL6EXf6MOZT4Q46SH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KQ5vhup4Eb33IscmYcxWA/Xtl22VHrd+QOijfdvNFxWfO08blSeST9KAfETZJYglR
	 34UqGt4pp76uZwEcpYfKJ7wZPYu4ox6u9FhsAmJP7pmZaH12O8wRG1sCn9GT67sOXm
	 GSRJruaMtkycx8rFvJU1BlgtJWkqV4EoVLyi7N9Yz1CzdS1ACzMq1AxATVZEZs8lX7
	 y0yuSkDMdxqLKEOCyeH/ptNwG2BLiVgtdF1W3CXrRpx7EecDAnVBubvRn82SwqiZ7o
	 hXGofpdMiPEp+A5pf/f6MUdntVDkkqZQlS8m1BHJKPggBw1g3DiY+/WSlRlwUdm969
	 0+v5sk7kdnkUw==
Date: Sun, 26 May 2024 08:10:04 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Leo Yan <leo.yan@linux.dev>
Cc: Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Anne Macedo <retpolanne@posteo.net>,
	Bhaskar Chowdhury <unixbhaskar@gmail.com>,
	Ethan Adams <j.ethan.adams@gmail.com>,
	James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Yang Jihong <yangjihong@bytedance.com>
Subject: Re: [GIT PULL] perf tools changes for v6.10
Message-ID: <ZlMYjHdX-d0ODqyj@x1>
References: <ZlFE-wbwStOqt8Ra@x1>
 <ZlFGpxWGQskCTjeK@x1>
 <CAP-5=fXDdcjMmn8iBenjPmZZQdB=AX+gc4TYDsHXuwH9TYq4Ng@mail.gmail.com>
 <CAHk-=wheZptGieaObmQEsz6bocUjhQXNpWXFDmCK-TOKbOvO+Q@mail.gmail.com>
 <CAM9d7chXVsoNP6uYMCqy2MZOiWkt4GrFn+giYLHQjaJRsap1Cw@mail.gmail.com>
 <CAHk-=wjY7CG5WRZQ3E1gdEO9YtUQstMe7a=ciShY0wz0hKXyuQ@mail.gmail.com>
 <CAP-5=fUvT+O0iyXxst3WKqnWdpimqD8+aX8GJU7_7zYieniYxQ@mail.gmail.com>
 <CAHk-=wjMvgsBu5n9ifs5d8Qfu8x23=XmXgp6gXYNEN2y-g5UMA@mail.gmail.com>
 <CAP-5=fWk-eDfuRH-tL5TWU8dXumOnCTKby5VKonOfjGad4TG=Q@mail.gmail.com>
 <20240526095838.GA33806@debian-dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240526095838.GA33806@debian-dev>

On Sun, May 26, 2024 at 05:58:38PM +0800, Leo Yan wrote:
> On Sat, May 25, 2024 at 11:22:08PM -0700, Ian Rogers wrote:
> > In doing that work the code was tested by IBM for S390 and by Intel,
> > but it was fixing an ARM created problem. ARM were the first to have
> > BIG.little systems but contributed nothing to the perf tool to handle
> > it, even though each core type has a different PMU. ARM BIG.little
> > remains broken with the perf tool and when I fix it for them they
> > don't review or test the code. ARM changed and left unworking uncore
> > PMU naming conventions. ARM don't fix tests for their platform. ARM
> > don't help make perf's tests cover their different way of naming PMUs.
> > No one is trying to break ARM machines, but when ARM fails to do
> > anything other than review their own changes in the perf tree it is
> > something of an inevitability.

> > Fwiw, I am working on making perf record, perf top, etc. skip events
> > on non-core PMUs when they fail to open. It is a rather large and ugly
> > change. It is also a holiday weekend and I'm spending a lot of my time
> > in it addressing latent ARM problems.

> James is in holiday, so I should cover this in time. Sorry that I did
> not respond the issue quickly - mainly as I am not familiar with JSON
> and perf event part.

> I tried to reproduce the issue reported by Linus on my Arm big.LITTLE
> system but cannot reproduce it. As I saw Linus mentioned the issue is
> related with Arm DSU event, which is absent on my test board.

Yeah, I couldn't either with ARM boards I have, I think we should revert
the change, as per Linus bisect and test that it makes thing work the
way they were before that patch for him and get this work restarted as
the first thing in the next devel cycle.

It has to be widely tested, Ian tried, Linus tried his patch and it is
still not acceptable, its a holiday, kids are home, we should be with
family.
 
> But your complaint is received well and I am very appreciate your work
> (especially in the weekend). I will continue to look into the details
> in this thread, and monitor incoming patches and I will verify them.

Indeed, the situation was detailed to a wider audience, hybrid is a
reality and we should properly support it, taming perf's tech debit on
this matter.

Ian's has been working on this for long time, testing all this takes a
lot of time and requires access to lots of hardware not easily available
for all of us, so its bound to break here and there, what we do when
this happens depends on when the problem is detected, and today Linus is
expected to close the merge window, so a revert is the technical, if not
pleasant thing to do now.

- Arnaldo
