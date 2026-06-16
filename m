Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F17E47AF43;
	Tue, 16 Jun 2026 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635639; cv=none; b=sdtgazmP3T2n6/jdarcx+SMTVxWWXk409vTZ8FyvtoTgLa+EpasMttNVqdGKa+qXicJOsIBCSa+ULMIr0KfqZVp8z4lwVsYxH6n+g7HSQNFPL83x1gb52eJmASocsOnj6OZCWJ+BB+ecZZcDBXZC5tzmXzuT0ahgXFEAXEVe4j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635639; c=relaxed/simple;
	bh=lPtqWXon5MIl0aaDsN+OFYj0FC8iKlrwp+KoTGY5hxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxgtSulyNf5ZOrMz/LqvYILLtH+Tw1+kCC3AkEcSCVNHuh7rxkmRnbzOLkvSLfMMn9pCEHBxz+ZquZDLHbB1sp/ptZM3e8A0aclygBqLsGYSv8mop6p2c5Q52Ey5ov50bWBxXQWB2S4vJ5+wu3cteB/1/UFLvbDikceE+UJqof0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hj9sLAX6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hj9sLAX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CB51F00A3A;
	Tue, 16 Jun 2026 18:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781635637;
	bh=dkFKr7CU9O426Ttw+ERPRygHHOZqQUerx721Kib79Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Hj9sLAX6YcpVnnevxHG36GnNbyzXZnxkIqP/cH9Ktl5LZt6MUpDDyQAbj5nob56IJ
	 W/cTo7jGWJHk3we8OYMjyh7ydd+j0q0O3YYcAtYBETiWeYiBJZhXlbBWevvAL0jXHm
	 2J5Zmiek86jTH8Kx22Zw8a3U+iBZuzyba+cxHYW8vTbZFq8k/qiB1GRI+ziR9y2wC7
	 oJJbJ3xZYExCvJrCwpyb7H0m3bRP+7aiFK/29PFhXGqxmPHWjRj/2btcpT6be7aLVG
	 NtlnIKy2zn2lLb98zwsPSfyzp0dZQ5Yq0gqG66hZh3j96122RE/0rM3F9h9Y1tO6Em
	 pBFOMUIxWoxQg==
Date: Tue, 16 Jun 2026 15:47:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf evsel: Add lazy-initialized probe type
 detection helpers
Message-ID: <ajGaMjKm56V0VNF-@x1>
References: <20260616182546.8892-2-acme@kernel.org>
 <20260616184006.0CC9A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260616184006.0CC9A1F000E9@smtp.kernel.org>

On Tue, Jun 16, 2026 at 06:40:05PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Ftrace-based return probes (kretprobe, uretprobe, fexit) are incorrectly classified as PROBE__NOPE because they lack the __probe_ip field.
> --
> 
> commit fc58c48524e7c99a712f8fb111c94abfbbeb4b6d
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> perf evsel: Add lazy-initialized probe type detection helpers
> 
> This commit introduces lazy-initialized probe type detection helpers for
> perf evsel. It caches the probe type lookup in a 3-bit field within struct
> evsel to avoid repeated PMU list walks via evsel__find_pmu().
> 
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 05fa0010c858a..ea9fa04429f08 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> 
> [ ... ]
> 
> > @@ -254,6 +254,58 @@ const char *evsel__pmu_name(const struct evsel *evsel)
> >  	return event_type(evsel->core.attr.type);
> >  }
> >  
> > +enum evsel_probe_type {
> > +	PROBE__UNKNOWN	= 0,
> > +	PROBE__NOPE	= 1,
> > +	PROBE__KPROBE	= 2,
> > +	PROBE__UPROBE	= 3,
> > +	/*
> > +	 * Ftrace-based dynamic probes (kprobes/uprobes/fprobes created via
> > +	 * tracefs) report PMU "tracepoint", not "kprobe"/"uprobe".  Detect
> > +	 * them by the __probe_ip field that the kernel adds to all dynamic
> > +	 * probe formats.
> > +	 */
> > +	PROBE__FTRACE	= 4,
> > +};
> > +
> > +static void evsel__resolve_probe_type(struct evsel *evsel)
> > +{
> > +	const char *name = evsel__pmu_name(evsel);
> > +
> > +	if (!strcmp(name, "kprobe"))
> > +		evsel->probe_type = PROBE__KPROBE;
> > +	else if (!strcmp(name, "uprobe"))
> > +		evsel->probe_type = PROBE__UPROBE;
> > +	else if (!strcmp(name, "tracepoint") && evsel__field(evsel, "__probe_ip"))
> 
> [Severity: Medium]
> The commit message mentions this covers kprobes, uprobes, and fprobes
> regardless of their group or system name by checking the __probe_ip field.
> Will this successfully detect ftrace-based return probes?
> 
> It looks like return probes like kretprobe, uretprobe, and fexit do not
> contain a __probe_ip field, but instead define __probe_func and
> __probe_ret_ip.
> 
> If evsel__field() returns NULL for return probes, won't they incorrectly
> fall through to the else branch and be classified as PROBE__NOPE?

Sure, and this is an interesting observation, we need to cover
__probe_ret_ip in the same fashion as __probe_ip, probably __probe_func
as well, but this should be done in an upcoming patch series.

I'll make sure to save this in a TODO file for later work.

- Arnaldo
 
> > +		evsel->probe_type = PROBE__FTRACE;
> > +	else
> > +		evsel->probe_type = PROBE__NOPE;
> > +}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260616182546.8892-1-acme@kernel.org?part=1
