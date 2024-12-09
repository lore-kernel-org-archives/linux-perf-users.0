Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ED5137930;
	Mon,  9 Dec 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776107; cv=none; b=k3e14onBrqOdBwkjUD8uPa/d3EeWGubVa+S+lZi3wKetXDscOUfvVyKhhSlFZrnD9VG+wKGj/JRxfSNlVgGmAs2A5JA82GU+1eTvOfSB9GoDiK8bqvZ9zSwQ0fQZkWdYSp1yvpQWXMxPC+wpVMoNNMS9q258CfBRhJyIkP37HGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776107; c=relaxed/simple;
	bh=3iCzJ2pzD90rukq9de1K6pOTtKPRtd8HiSlaoyLNQ/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6icJP5/u1c9F53yxJsnOu1vwFV6mQluJRlhTYon11aq2Zr8LOaixCrQkupqEdLE7sKG87XYMKbMQYUxoBKngP9Um7zIHi3ms2/g0N/JIl2yQkVTzk17oeYUJ12NlnlVXvWoXDlGvEtDSyKJVX07+JsJWZl5QKdZ+3Q44eZbetk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOOB6X0A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOOB6X0A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9827C4CED1;
	Mon,  9 Dec 2024 20:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733776107;
	bh=3iCzJ2pzD90rukq9de1K6pOTtKPRtd8HiSlaoyLNQ/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JOOB6X0AqZeID5RY3k7vsAMFlQNDYcXl4sMt5jDjZAzDUr+JmpsII/FcRr/0oChS6
	 lNG300DHcSx6rH6HBGJAwG9F0KPVH4iT7/SZbO4ImkZMu2MrV4DmHCt/z8hKOUJjuy
	 8kGaDlpq4M3MW7CBpst65/ToFmSedNtEp3tZzcjiGDZFQeA7CKR+mYq6Gp7jxjrJ5h
	 i73QUmLhjM+KhQ05DQMtZlNoembgM4vph1G6kbm6oWYNQQ+HUqwbbEEgQ66NDnYJ0V
	 f/KumlacPGJEeUTUsRC7vJrCVcH7ly7AAK1SJdQS8No/0rxJyTY/AXtcX/H3/NH+cP
	 iQF4BsbKIoikw==
Date: Mon, 9 Dec 2024 17:28:24 -0300
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
Message-ID: <Z1dS6HrfkVS4OeZz@x1>
References: <20241113165558.628856-1-irogers@google.com>
 <CAP-5=fWK-eeDEvE4+LeeScbHFecmc5+H8WB_5fepfrJJLZsF0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWK-eeDEvE4+LeeScbHFecmc5+H8WB_5fepfrJJLZsF0Q@mail.gmail.com>

On Mon, Dec 09, 2024 at 10:35:34AM -0800, Ian Rogers wrote:
> On Wed, Nov 13, 2024 at 8:56 AM Ian Rogers <irogers@google.com> wrote:
> >
> > For big string offsets we output comments for what string the offset
> > is for. If the string contains a '*/' as seen in Intel Arrowlake event
> > descriptions, then this causes C parsing issues for the generated
> > pmu-events.c. Catch such '*/' values and escape to avoid this.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Ping.

A fixes: is missing, probably this should go via perf-tools, i.e. for
this merge window?

- Arnaldo
 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/pmu-events/jevents.py | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
> > index 6e71b09dbc2a..028cf3c43881 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -430,8 +430,11 @@ class JsonEvent:
> >    def to_c_string(self, metric: bool) -> str:
> >      """Representation of the event as a C struct initializer."""
> >
> > +    def fix_comment(s: str) -> str:
> > +        return s.replace('*/', '\*\/')
> > +
> >      s = self.build_c_string(metric)
> > -    return f'{{ { _bcs.offsets[s] } }}, /* {s} */\n'
> > +    return f'{{ { _bcs.offsets[s] } }}, /* {fix_comment(s)} */\n'
> >
> >
> >  @lru_cache(maxsize=None)
> > --
> > 2.47.0.277.g8800431eea-goog
> >
