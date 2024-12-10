Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E142023ED63;
	Tue, 10 Dec 2024 19:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858231; cv=none; b=LyFE3xMWP1dJtJDNDy+TtFFZXdI7YFaAGIICSpIsPzP+lbcHHleSLH9EI4nai1l9sxfJBmRLx3/oaJO3WW1e4GWWeUTxHmlMhyqkYsJqX8+69OlsnQwsxsgSQ05oGx4dihIVDNrDErmjiq0CEyLNXRord22ynJY19TTkCxtewvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858231; c=relaxed/simple;
	bh=xzrheW4J8uYYbzIZNNJDsJ0uv7i/abHziHUet3dfAR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puRic4EUjqG/287EeBhWBv+1/qBobsLMhJZQbKv/ri/OSi6AtGFs6zX9LVxrb8tHHsiZ74yDD5ytLhKO4KKVbC+28fZqqzHiOcVZgkNMxW1XEYoxyd03XeJbckV2fWyC+o8APkZYYMIefWcAm7yODugS0WDtvFzewT8uKB3EioA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiV+H5b3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiV+H5b3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EAD6C4CED6;
	Tue, 10 Dec 2024 19:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733858230;
	bh=xzrheW4J8uYYbzIZNNJDsJ0uv7i/abHziHUet3dfAR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KiV+H5b3FrmvwCvv6PaqvWEVQPgew9FR6HqdXSvUSzsDDROlDh54R8f16w+xJ2yIa
	 YSuCoKEXnWudLMF4iEa5+8JePyPjQC4b7YSZVkHDFxbkuD3S17rHfr4viB2hcM5VD4
	 y732TZlO36btvjO7i3PBG85vA/rKxvnL5ckRQExn1e8n2rEjUh5LfNrJl9diCP7P/1
	 FpVAxIq2vzsPXp2erFC84nmQutTayUdlytYU8tv+dPfup7zElxmAESWciVsv4/xEGU
	 LRdwY5jUgc9lmranR2ZomYV1/kFtVmuvA6YbOSG7zYNshbZfONGg/JHJQOJLlq5iQf
	 HW0Ul8Q+Jpy+w==
Date: Tue, 10 Dec 2024 16:17:08 -0300
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
Message-ID: <Z1iTtJcMMsuwI0JX@x1>
References: <20241113165558.628856-1-irogers@google.com>
 <CAP-5=fWK-eeDEvE4+LeeScbHFecmc5+H8WB_5fepfrJJLZsF0Q@mail.gmail.com>
 <Z1dS6HrfkVS4OeZz@x1>
 <CAP-5=fUze9j8etq-17L0dWVoYfE-bA+61wrEAXN9vJSCj9dCbw@mail.gmail.com>
 <Z1g-8ggHQ8MoVNhx@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1g-8ggHQ8MoVNhx@x1>

On Tue, Dec 10, 2024 at 10:15:30AM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Dec 09, 2024 at 01:29:15PM -0800, Ian Rogers wrote:
> > On Mon, Dec 9, 2024 at 12:28 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Mon, Dec 09, 2024 at 10:35:34AM -0800, Ian Rogers wrote:
> > > > On Wed, Nov 13, 2024 at 8:56 AM Ian Rogers <irogers@google.com> wrote:
> > > > >
> > > > > For big string offsets we output comments for what string the offset
> > > > > is for. If the string contains a '*/' as seen in Intel Arrowlake event
> > > > > descriptions, then this causes C parsing issues for the generated
> > > > > pmu-events.c. Catch such '*/' values and escape to avoid this.
> > > > >
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > >
> > > > Ping.
> > >
> > > A fixes: is missing, probably this should go via perf-tools, i.e. for
> > > this merge window?
> > 
> > We don't yet have arrowlake events/metrics, should there be a fixes?
> 
> Ok, thanks for the clarification.
> 
> > I'm just preparing the patches for the latest vendor json from Intel,
> > but they will depend on this. I suspect given the size of the vendor
> > json it will miss the current merge window.
> 
> Probably best to have big patches via perf-tools-next at this point in
> time.

I'm seeing this after applying:

/home/acme/git/perf-tools-next/tools/perf/pmu-events/jevents.py:434: SyntaxWarning: invalid escape sequence '\*'
  return s.replace('*/', '\*\/')


⬢ [acme@toolbox perf-tools-next]$ head /etc/os-release 
NAME="Fedora Linux"
VERSION="40 (Toolbx Container Image)"
ID=fedora
VERSION_ID=40
VERSION_CODENAME=""
PLATFORM_ID="platform:f40"
PRETTY_NAME="Fedora Linux 40 (Toolbx Container Image)"
ANSI_COLOR="0;38;2;60;110;180"
LOGO=fedora-logo-icon
CPE_NAME="cpe:/o:fedoraproject:fedora:40"
⬢ [acme@toolbox perf-tools-next]$ python --version
Python 3.12.7
⬢ [acme@toolbox perf-tools-next]$
