Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169BB2F60B5;
	Mon, 20 Oct 2025 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952700; cv=none; b=Jt7JU+VWAe1wnUqosl49Ru221Vk3wVSkFPEJJBZ5Eyg3OYz403ylDiy93QkNBnL60QJUHzFQ9jjlWS322j61tyLVRtDFL/Fc4LJrD5kDX2mh0D4pU5GyV3Fmp6r7TX71L4Qj1mib/C9biFGpH0RH+7xxBHdvRHZpCN+rTP4bY74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952700; c=relaxed/simple;
	bh=gpoKqfk8Tac056IZIUr9oMWbYhowyk9iGVsuswKpAXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6V+JkC32RhLFoz7jDH2A0E+nkNdLF0apyJmn6X4614G//vDrsru9GEu8U2BbYaJTS+0m8bDYgVa+OqxEFlpA8s94XsyaKKn9w/m3Vs9sTz4dR51+tKEANAHMEgAhn2NGC5LQzpeVGiSaH+XOoFzeE6Qgj0TI6yrvPbTfLPnX8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8890A1063;
	Mon, 20 Oct 2025 02:31:30 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07ED63F66E;
	Mon, 20 Oct 2025 02:31:37 -0700 (PDT)
Date: Mon, 20 Oct 2025 10:31:36 +0100
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf build: Add Debian/Ubuntu python-is-python3
Message-ID: <20251020093136.GD281971@e132581.arm.com>
References: <cover.1760617634.git.geert+renesas@glider.be>
 <e1c0c2acbab60630cf8538ac5446f91970dad92d.1760617634.git.geert+renesas@glider.be>
 <20251017122904.GC281971@e132581.arm.com>
 <CAMuHMdUUH2AN7tE3C7cPWeNJDW6jL9vQOktaRDW2HChDwvroSg@mail.gmail.com>
 <aPRR1APPW8vro4HB@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPRR1APPW8vro4HB@google.com>

On Sun, Oct 19, 2025 at 11:49:56AM +0900, Namhyung Kim wrote:

[...]

> > Aha, I found it.  After uninstalling python3-dev, I got into the same
> > state as yesterday:
> > 
> >     $ make tools/perf
> >     [...]
> >     Makefile.config:875: No python interpreter was found: disables
> > Python support - please install python-devel/python-dev
> >     Makefile.config:918: *** ERROR: No python interpreter needed for
> > jevents generation. Install python or build with NO_JEVENTS=1..  Stop.
> > 
> > So these error messages sound like python is missing. And "python"
> > is indeed missing, but "python3" is available.
> > Hence I installed python-is-python3, but that turned out not to be
> > sufficient.
> > Hence I also installed python-dev-is-python3, and that fixed the issue,
> > as python-dev-is-python3 depends on python3-dev, so the latter was
> > installed, too.
> > 
> > After removing python-is-python3 and python-dev-is-python3, everything
> > keeps on working.  But if you never installed python3-dev manually,
> > and run "sudo apt autoremove", python3-dev is uninstalled, reintroducing
> > the issue.
> > 
> > So just recomming to install python-dev-is-python3 in the error
> > message should be sufficient?
> > 
> > What do you think?

Can we explicitly suggest that developers install python3-devel or
python3-dev instead?  Two reasons:

- python-dev-is-python3 is specific to Ubuntu/Debian; some distros do
  not provide this package and even advocate against using unversioned
  "/usr/bin/python" shebangs [1].

- As Namhyung mentioned, perf has removed Python 2 support (at least
  this is claimed), it is straightforward to install only the Python3
  packages.

[...]

> I think the code was to deal with either python2 or python3 in the past
> and we removed python2 support recently.  I don't know if any distro
> made 'python' to refer python3 and removed 'python3' otherwise we can
> just check python3.

I agreed with only checking python3 - neat and compatible for distros.

Just note, some legacy python shebangs are left, we can update to
"#!/usr/bin/env python3" but this can be done separately.

  $ git grep "#\!.*/usr/bin.*python"
  python/tracepoint.py:#! /usr/bin/env python
  python/twatch.py:#! /usr/bin/env python
  scripts/python/export-to-postgresql.py:#   #!/usr/bin/python2
  scripts/python/exported-sql-viewer.py:#!/usr/bin/env python
  scripts/python/libxed.py:#!/usr/bin/env python
  tests/shell/lib/perf_json_output_lint.py:#!/usr/bin/python

Thanks,
Leo

[1] https://fedoraproject.org/wiki/Changes/Move_usr_bin_python_into_separate_package#Motivation
