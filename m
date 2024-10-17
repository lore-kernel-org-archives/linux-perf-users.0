Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4901DFDBC;
	Thu, 17 Oct 2024 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184118; cv=none; b=fyi3H2ZEmw2ozoSxKRbqaY9XVO4Gzz3HWKPEiX6OHw8bth3o2oLMKgCFynsAlC5PUBXYGgp+95+J2m3ILlaUu8Ja9TMFgSl6uRElXnYx1b9SMRxhoVDogvv9feBwp7bfva3kOkqbo2frbQMBK2oXBRunqQKw2JpJ76MuxqqRN8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184118; c=relaxed/simple;
	bh=1yhSqIrkwoDDD3H433S45ysEdGXUHCZezek1jfBZpok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBoaUV4RWhw9GEyrAjt+c+bpt5vSgRv0PioUECtloWvrKTV1BtGvVlJuKXC+lB9p9lHg3DhyxqfnaocTXIOhDj84qDKB+Du+zBbVGKiPQzXHof+/i0kb5hQWTG+MuFptWDLVn8TI8TjF9TwX9S0/dyFu6QWdEwi7xGnk6aHRLlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CcpYffaW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CcpYffaW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA684C4CEC3;
	Thu, 17 Oct 2024 16:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729184118;
	bh=1yhSqIrkwoDDD3H433S45ysEdGXUHCZezek1jfBZpok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CcpYffaW0CzrdKWRnvYQkSoejoNPZQknMzlXmLXUqaevk6GLsmEnZgL+L7ZF5OBl6
	 9lbpDr9N8Nl67JA8d/JXXVYrsshi+y+dJuYZxlNfSLTz0X4QhvyGA8FNvoUZj1SUUn
	 ZNUb0nmA76j3edAQ1URifedBL/flbe67Cn5502AOmoFhDt1f7nxwPOsjAE0H4GhZ4D
	 beTKNC+pFNrSbTqdjFyvx1uvYKhu764uPHhmCDLOT61dsyWT0v3pnn+q3rE+TVAlIB
	 iF8/tADAHKY8f1MfTieqlaHSIW3LDgBJI1Tu+7EGV+/c1zKX9mjWPsX23MW/Ww0jSj
	 guxyhYlKyirGQ==
Date: Thu, 17 Oct 2024 09:55:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] CSV/JSON metric thresholds, fix printf modifiers
Message-ID: <ZxFBdCMFZ50oo-s2@google.com>
References: <20241016175350.116227-1-irogers@google.com>
 <172918316032.639809.5792146702013848062.b4-ty@kernel.org>
 <CAP-5=fWMkF-z5t6-Oz8e8YRuW0rsMg7JXj4vSHqLZFe0y3=sUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWMkF-z5t6-Oz8e8YRuW0rsMg7JXj4vSHqLZFe0y3=sUA@mail.gmail.com>

On Thu, Oct 17, 2024 at 09:44:08AM -0700, Ian Rogers wrote:
> On Thu, Oct 17, 2024 at 9:39 AM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, 16 Oct 2024 10:53:42 -0700, Ian Rogers wrote:
> >
> > > Metric thresholds are being computed for CSV and JSON output but not
> > > displayed. Rename the color that encodes the threshold as enum values
> > > and use to generate string constants in a CSV column or json
> > > dictionary value.
> > >
> > > Add printf attribute to functions in color.h that could support
> > > it. Fix bad printf format strings that this detected.
> > >
> > > [...]
> >
> > Applied to perf-tools-next, thanks!
> 
> Sorry for the trouble, could we switch to the v4 series due to issues
> on hypervisors with not counted events in CSV output missing a column:
> https://lore.kernel.org/lkml/20241016215139.212939-1-irogers@google.com/
> The patch set drops the CSV output metric threshold support.

Oops, sorry for missing v4.  And I also noticed a build error on i386.
I'll drop this for now and push perf-tools-next soon.

Thanks,
Namhyung

