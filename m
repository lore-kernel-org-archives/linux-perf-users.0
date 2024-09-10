Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F386217E473;
	Tue, 10 Sep 2024 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000279; cv=none; b=uomyh4t2ih0KPV5c9zBeLOYg7t6jnZwtrNUXO1V/MAYh+bA0rsEASpnPksq5oRcBqrrGystpwcql3ssBuLNWBX8Aze+NT2d/0DcPV6ZTTVFDAZzlHZi6F2TqL6pS8x4buxBSOWEG03PPl2ZonMJwr2AglT4o1PHKW48A+yQjwMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000279; c=relaxed/simple;
	bh=a4T4Dmdo05TZg9KBxK6ccPdxczJK5ZlI5jijiQNdz5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgMzn4g4q/sYcH9q3q+XrQTI1YHDz+UtEaOecXGr/XS392uOLW+wWygjX577z8Emw6tjMn4CIOtNU+iq8rB0QoP3r1fumHzPMruRE28kiomOpv8syI1BLUghn3xjPEmVPHZEQnCv5VSwRH1Gh6x6Uqt6VEeH6nxRuJjvy/WPldA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT2FSbMq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT2FSbMq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FDAC4CEC3;
	Tue, 10 Sep 2024 20:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726000278;
	bh=a4T4Dmdo05TZg9KBxK6ccPdxczJK5ZlI5jijiQNdz5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hT2FSbMqASEW6Mjc6LatvrMqbFHhwG+2/kWDUL5LuhfOrJrIN+U+3MKn1DRAztv7N
	 hFiYC9oMA320RlYRdBEGmxu6wir3TOuoy3zuvG7EiR4DDz7pRfBkDBpmfTZY3t3Z39
	 3eUxAIuFv010yrpf8JN35ZcyUGw9whWFGZAcUacpclCxvrpuziR8pYxl/0iZT/Ju0H
	 8/q/vVUPHSpcTg5XvzkDfGqO9iK/wFqaKQfF9ayH7VkCErPMk4mqG7V5BOTDv+rZXo
	 pxQtTIsGFjpvHPcmhGkfX4o4+jTKMT7UMgGy1bT6L6e8iAzC3U5S0tPIKY5T/XfzOh
	 yh4ZZBuQGqZ9Q==
Date: Tue, 10 Sep 2024 17:31:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf trace: Support collecting 'union's with the BPF
 augmenter
Message-ID: <ZuCsk9vnCN5BrCUi@x1>
References: <ZuBJQp1lf5uAjpo1@x1>
 <CAH0uvoh=Q6iv1YG96tVw3ynskOGhBEhKzCGBS9nwbu_zgZOB3Q@mail.gmail.com>
 <ZuCr7yOQb-1qeuox@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuCr7yOQb-1qeuox@x1>

On Tue, Sep 10, 2024 at 05:28:34PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Sep 10, 2024 at 09:16:56AM -0700, Howard Chu wrote:
> > Hello Arnaldo,
> > 
> > LGTM.
> 
> Taking that as an Acked-by, as per the Documentation/  submitting
> patches docs, next time consider providing an:
> > On Tue, Sep 10, 2024 at 6:27 AM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > > @@ -2365,8 +2365,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
> > >                         default_scnprintf = sc->arg_fmt[arg.idx].scnprintf;
> > >
> > >                         if (trace->force_btf ||
> > > -                           (default_scnprintf == NULL ||
> > > -                            (default_scnprintf == SCA_PTR && strstr(field->type, "struct")))) {
> > > +                           (default_scnprintf == NULL || (default_scnprintf == SCA_PTR))) {
> > 
> > Can we discard the parenthesis surrounding the 'default_scnprintf == SCA_PTR'?
> > 
> > (default_scnprintf == NULL || default_scnprintf == SCA_PTR)) {

Done:

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d28a56cc171b2b2e..ed4c5e637e24eed0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2364,8 +2364,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 
 			default_scnprintf = sc->arg_fmt[arg.idx].scnprintf;
 
-			if (trace->force_btf ||
-			    (default_scnprintf == NULL || (default_scnprintf == SCA_PTR))) {
+			if (trace->force_btf || default_scnprintf == NULL || default_scnprintf == SCA_PTR) {
 				btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
 								   size - printed, val, field->type);
 				if (btf_printed) {
