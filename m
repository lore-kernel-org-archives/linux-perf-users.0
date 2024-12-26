Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD2B1E505;
	Thu, 26 Dec 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735226436; cv=none; b=a2YImLL2rSBgzu+EtsJQd21gyYD8f1quRV69jVQSDcMLmoNIq0KXPiUnbjXowQ0ah1hzouAncHLFQo1SBTLRs8sPE/+ZTo5srf3vbDNEDtsx6fZlZSrKvgVLW/I+8YmymFgPAx4v/ytTYfnA0EXc8j4N8g44q6ML74zZ+yu9u9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735226436; c=relaxed/simple;
	bh=wdWlOCG/vdIhpcrpAyZ9IiU5paF/RaUWXnzNEPEcU3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6OUWvvaVQNysZOU5yGMsffDVnSfUp2HBO0TtQ9Al7XoFQAE7iXbHQg1atyTmDIfmeLUK0wgU0qwqICha5GyelQjitfPodkog+kJSmjXqqTJZK5eYIk67vdoIf2bxuF7QUl8Pj3TZsDLXlwzLvg4RCI0kGE87xNafmqYUmc2Mc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LncoSS08; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LncoSS08"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30211C4CED1;
	Thu, 26 Dec 2024 15:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735226435;
	bh=wdWlOCG/vdIhpcrpAyZ9IiU5paF/RaUWXnzNEPEcU3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LncoSS08voFAyE28TWvAxiDppHSuXpJuGaRg1R1onkvAu7DqQaTxB7QlAeJf4S/+n
	 RuTWQ7qv51oCuhr5XQPpqEWbJ50rutpn17jJMuAAcV3jH4f6hRfNfcdX+xtu7zmSGD
	 EwU0YY4cWTrR5r/bj8KjvF7+vQmRK6Eq6I2fagLSb0Hm0201vtopaa4Z/WjQXW14Oq
	 JvD/bVQUTpY1AC64+EDrwXAN36F+TS0DYM58+EbzQyVvpVMgnw/Cbdfo3BcrVyidSn
	 VnSb90DGfdE8EKsbiHAf72lCqI91jIcPxzUEoYRJENwdNv75+4WXVU7wxg/fnXyuyK
	 AiuvYtsUNPuZw==
Date: Thu, 26 Dec 2024 12:20:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
	namhyung@kernel.org, tim.c.chen@linux.intel.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] perf stat: Fix trailing comma when there is no
 metric unit
Message-ID: <Z210QHEkCXUlekN8@x1>
References: <20241112160048.951213-1-james.clark@linaro.org>
 <Z1iLqNmDyNH7fDpa@x1>
 <CAP-5=fUfPnkS0HS1dMx2uR-a4GPfk4E4nD85rUtRUbVcETtY9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUfPnkS0HS1dMx2uR-a4GPfk4E4nD85rUtRUbVcETtY9g@mail.gmail.com>

On Thu, Dec 12, 2024 at 12:01:00AM -0800, Ian Rogers wrote:
> On Tue, Dec 10, 2024 at 10:42 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Tue, Nov 12, 2024 at 04:00:40PM +0000, James Clark wrote:
> > > The first commit is failing on Arm and I think the fix should stop more
> > > trailing comma issues which keep happening.
> > >
> > > The second one I just noticed when looking at it. I don't feel strongly
> > > about it so not sure if we should do it or not, but seems like the empty
> > > metric-units exclusion from the JSON should be consistent if we're going
> > > to have it at all.
> > >
> > > Changes since v2:
> > >   * Do more documentation and tidyups around struct outstate
> >
> > Ian, have you had the chance of going over this series?
> 
> It looks good to me, I particularly appreciate the additional

Indeed.

> comments/documentation. Tested with sanitizers.
> 
> Tested-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
