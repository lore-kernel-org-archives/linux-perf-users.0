Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57F521ABC6;
	Tue, 25 Feb 2025 19:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740510678; cv=none; b=UPsmwSLyBcLSvQ9UxaA5TCHWWXxP8cYlOaMHbLvF/mfNpnLd+G/gHWGx6+V0GtcM+EQUHeK6ltgQkHFXbysErrzPSROL4dwA119iOd/wTqDzl13t2cE6aOmyOXOnVXXU7mJw1tK4CDAUz+h7CYmPRYLPkYE8ZIiB1lmV5Xd6usc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740510678; c=relaxed/simple;
	bh=QHPuM589pB5dcxKrgioJlCNw46jL42eapMXxVxkal1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJoHaUem89Ej0lKavew5eRCzIJG1Xjo+n807L9QrrQSIEes5THETCXLRfQomSgM2ySvO3FsDjPSWS7h1SXA/scN2CsVHGZHBoqXd0FdgSYRkQ2vsXp5/ejZhUtboOZIsq5Dse6Mmyvg+uaGbLVNw0u8ha9X74XKXO1yP4ocYLaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idzlBdrI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idzlBdrI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB74C4CEDD;
	Tue, 25 Feb 2025 19:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740510677;
	bh=QHPuM589pB5dcxKrgioJlCNw46jL42eapMXxVxkal1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=idzlBdrInoLZhjQzo+Pcik0Yqs3/lS+wCDmkjXKesvzEnV45PDYIfDDca3RtoxIhL
	 4fCbDXtvkF4U8EXsGhfKjw/iAWjYJ/XV6NRzgLuME44QqWvXlVHC2mDcMHfgqKiexd
	 k0ku4penvTtDPzvafbjMvfIIh9ORvyUgexCG5afKoAOKF9hVoJ3F1jW0c8PE1Q41gU
	 rAAVQS8ILAcyPW7TqfB47ru4hRyN2JpTpN+cnJt04hmyu0pYi4I8+X/E78HHqIWX/i
	 Nm5PjQuowg58/ZymBeg+xYuWEUIyVTnhgahZbOS1Pc8OsLleGMv45f9qJcr2ZdYjfk
	 uyrIzpEZsr4TA==
Date: Tue, 25 Feb 2025 20:11:14 +0100
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf report: Add 'tgid' sort key
Message-ID: <Z74V0hZXrTLM6VIJ@x1>
References: <Z7XsltyqUWrdKma0@x1>
 <Z7XvEFEZtCRZKG7Y@x1>
 <Z7ZIqpwffQbibwL2@google.com>
 <CAP-5=fWZXPjD3Ok5XmMwwaYt+9mL+V8t8fNSUdf-F5PPiEAvrg@mail.gmail.com>
 <Z7gllQZeg6U2OvZE@google.com>
 <CAP-5=fXEEMFgPF2aZhKsfrY_En+qoqX20dWfuE_ad73Uxf0ZHQ@mail.gmail.com>
 <Z70wHEl6Sp0H0c-3@google.com>
 <CAP-5=fUosOVUKi5tQ3gVtHhfApk0oH3r2zHDW7-i+_qASKm+Cg@mail.gmail.com>
 <Z712hzvv22Ni63f1@google.com>
 <Z74U5s7Yf0f6I7Mo@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z74U5s7Yf0f6I7Mo@x1>

On Tue, Feb 25, 2025 at 08:07:18PM +0100, Arnaldo Carvalho de Melo wrote:
> On Mon, Feb 24, 2025 at 11:51:35PM -0800, Namhyung Kim wrote:
> > On Mon, Feb 24, 2025 at 08:40:37PM -0800, Ian Rogers wrote:
> > > On Mon, Feb 24, 2025 at 6:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > > On Mon, Feb 24, 2025 at 10:18:37AM -0800, Ian Rogers wrote:
> > [SNIP]
> > > > > I thought the real-time processing had to use
> > > > > maps__fixup_overlap_and_insert (rather than maps__insert) as mmap
> > > > > events only give us VMA data and two mmaps may have been merged.
> > > > > Shouldn't doing this change be the simplest fix?

> > > > Make sense.  How about this?

> > > Lgtm, I have no way to test the issue. Why does maps__fixup_end need
> > > to get pushed later?

> > I just noticed it would add extra kernel maps after modules.  I think it
> > should fixup end address of the kernel maps after adding all maps first.

> > Arnaldo, can you please test this?
 
> Trying it now.

Now we have something different:

root@number:~# perf record sleep
sleep: missing operand
Try 'sleep --help' for more information.
[ perf record: Woken up 1 times to write data ]
perf: util/maps.c:80: check_invariants: Assertion `RC_CHK_EQUAL(map__kmap(map)->kmaps, maps)' failed.
Aborted (core dumped)
root@number:~#
