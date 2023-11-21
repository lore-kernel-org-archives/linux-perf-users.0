Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3745B1E8
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Nov 2023 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyWpJe5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748E7C433C8;
	Tue, 21 Nov 2023 17:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700587404;
	bh=/AUV+T6dC4Jy/S3IQTHApQXK2DkGP6Vfy23a7EuIvPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyWpJe5OcyLhfTFF9PqLPR/vnTVJ7yoOnLGeFEtTT25znxVoqK+4d/dJ0dtzqWDNA
	 rdvdL3bjdTlNNQxeL8rP5TToGieiLWX9BoyIG3WmEOBkrr12BvI9rUak6CPmcSTf6c
	 dhgI070/vfz8QdhZORqr1uHKT8h1jZMR4RXX/VWMunzaXCrCtHYnppnCaz45Q40Kph
	 jWP0VYWzr9k3etTsgqixpQbL9ils+kQbsPngzcBIPWJlw5VaTeLdaJMMpxf2gFPGj9
	 ShKIyiEUAPKR4X0yVyqQZ+XUiIqEZXum19BcafJ147FvZ3imDP4jnu3Qk8G+ZPWKcS
	 eYYcr6i/dxrMg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 2FD1640094; Tue, 21 Nov 2023 14:23:22 -0300 (-03)
Date: Tue, 21 Nov 2023 14:23:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Sean Christopherson <seanjc@google.com>, Li Dong <lidong@vivo.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script perl: Fail check on dynamic allocation
Message-ID: <ZVznim5Grz/biW76@kernel.org>
References: <20231120112356.8652-1-zhaimingbing@cmss.chinamobile.com>
 <CAP-5=fU4FBah=S_C7Zwh3MSNjwWtT5WrVB9OCc1jRM3eDCykng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU4FBah=S_C7Zwh3MSNjwWtT5WrVB9OCc1jRM3eDCykng@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Mon, Nov 20, 2023 at 04:30:28PM -0800, Ian Rogers escreveu:
> On Mon, Nov 20, 2023 at 3:24 AM zhaimingbing
> <zhaimingbing@cmss.chinamobile.com> wrote:
> >
> > Return ENOMEM when dynamic allocation failed.
> >
> > Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/scripting-engines/trace-event-perl.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
> > index 603091317..b072ac5d3 100644
> > --- a/tools/perf/util/scripting-engines/trace-event-perl.c
> > +++ b/tools/perf/util/scripting-engines/trace-event-perl.c
> > @@ -490,6 +490,9 @@ static int perl_start_script(const char *script, int argc, const char **argv,
> >         scripting_context->session = session;
> >
> >         command_line = malloc((argc + 2) * sizeof(const char *));
> > +       if (!command_line)
> > +               return -ENOMEM;
> > +
> >         command_line[0] = "";
> >         command_line[1] = script;
> >         for (i = 2; i < argc + 2; i++)
> > --
> > 2.33.0
> >
> >
> >
> >

-- 

- Arnaldo
