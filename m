Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35891481CD;
	Thu,  6 Mar 2025 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266834; cv=none; b=YYFnrkH/dqLkT2Z0Pc6rivV1Wa0z5UPn13xPn8fYg5ytQn47fI4rtUDj7dkB3OINxDUHc3bJHy2pNtiKvz/JNa1FtCBwDANApO0YD4SP98+neBpcZZqpEca6ragkFZo4Kp6chEBtj34AVED+/5SZP1U5MeY+AJsMZ6rNwyT3BWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266834; c=relaxed/simple;
	bh=2YjvzfsrPBho1H6DlpucDv/WaTUvDWx6KTif97I7bcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcS4JE46xS/ALd2yVHLg05sIVP+p91ek++tHARYvUwxG2XHuMTYw2Cnud4odkf84NnMR0H2ih2Q8Os/HY80nYmWtYxAaNa6qkMg5ScwSQkI/dmWluoLqwbFOU1y0gtAUrbrZvaiMv3652eFup4Rjj2SNekjcYmgnrMAuJ8CUD3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ITfpgfrL; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ITfpgfrL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=7y8rhhxB5lSjyrM3hesew8uHt000MTVpnFFEqf0Dw1A=; b=ITfpgfrLtCmV2mM3
	fFInvO2lVuVoaUbsrMCUNT933VW6xgvo+SIpL9rTFMI2eFEYx+ip5EGf3dwgbLtiqO1ot9WZlX185
	qaDahRdNx++1Pu02y5G/LALsB0M/0IRcPChAgN5tdbVRrlr9U/fnOwR8OeOn7F2KMFKy+GuspO+6c
	LEkLAsoa8NwKw/aKoBEU5kyjADoqYxAUVF1Q+gQF6On/Vsty/qjKCCJfPufGWfH/BUwlTna7wEBbF
	t9fIZkI+bnalgys03OQ2PT/6gLwZ04X3bGrVIgPVnMknAEFRl3EhkL7jzlj0P23dmca568oy+Navz
	ja01gF/C5mZPzEejtA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tqB2e-00370y-32;
	Thu, 06 Mar 2025 13:13:36 +0000
Date: Thu, 6 Mar 2025 13:13:36 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Ian Rogers <irogers@google.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] perf: Deadcode - the P's
Message-ID: <Z8mfgA4C26MiG54N@gallifrey>
References: <20250305023120.155420-1-linux@treblig.org>
 <CAP-5=fUpqfWcQAi8231fdofZ-f_bOTi=t8sdLUenvvXjQ3OfGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUpqfWcQAi8231fdofZ-f_bOTi=t8sdLUenvvXjQ3OfGA@mail.gmail.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 13:12:48 up 302 days, 26 min,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Ian Rogers (irogers@google.com) wrote:
> On Tue, Mar 4, 2025 at 6:32 PM <linux@treblig.org> wrote:

Hi Ian,
  Thanks for the review,

> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> >
> > Hi,
> >   This is another set of perf deadcode, this is my set
> > all starting with 'p'.  It was built on top of
> > perf-tools-next as of a few days ago (7788ad59d1d9).
> >
> > Dave
> >
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> >
> >
> >
> > Dr. David Alan Gilbert (6):
> >   perf core: Remove perf_event_attrs and perf_event_refresh
> 
> This will need to go into tip.git.

OK, do I need to split that out of the series, resend or do
anything else?

> >   perf util: Remove unused perf_color_default_config
> >   perf util: Remove unused pstack__pop
> >   perf util: Remove unused perf_data__update_dir
> >   perf util: Remove unused perf_pmus__default_pmu_name
> >   perf util: Remove unused perf_config__refresh
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,

Dave

> 
> Thanks,
> Ian
> 
> >  include/linux/perf_event.h     | 10 ----------
> >  kernel/events/core.c           | 24 ------------------------
> >  tools/perf/util/color.h        |  5 -----
> >  tools/perf/util/color_config.c | 11 -----------
> >  tools/perf/util/config.c       |  6 ------
> >  tools/perf/util/config.h       |  1 -
> >  tools/perf/util/data.c         | 20 --------------------
> >  tools/perf/util/data.h         |  1 -
> >  tools/perf/util/pmus.c         | 29 -----------------------------
> >  tools/perf/util/pmus.h         |  1 -
> >  tools/perf/util/pstack.c       | 14 --------------
> >  tools/perf/util/pstack.h       |  1 -
> >  12 files changed, 123 deletions(-)
> >
> > --
> > 2.48.1
> >
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
