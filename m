Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A55412276;
	Fri,  2 Oct 2026 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927539; cv=none; b=oudWw1BdaMNtJhi+z1fPlgXkHmFza/5nzAfIxJ45wMixXF2u8FOKTZ0ufvo+OO7a7YKKBR9PHGtl7e4GuNkdptSRv+1O3gebHXWDC9090ErqmDRQJmAZ8nwi92+6jMm3OGgYh4ZCrAG/c6BOq6kJMcDMEgZaeI8/KWw4bFnPk9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927539; c=relaxed/simple;
	bh=+RDiVJOBHcLWyoFcL8fzBTJOSy0HVXaB5fVTASrdkJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7OxDAkGuJIcZJnGe3C1dicWwW7UlJ/fhYg54j2UJcx4suwfn8TKGt6AyK1k7umsp2DQV6WF8ITqNbAfeIwnpLsWZcXJ/SBKzszrqPtTdZZtkO/2lsL3/OPH3DLDRSfX6HKuwwhZBFMUR0762fQdPFK5UPF6ZWRFQVWopi15kFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=T8yCSVq+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="T8yCSVq+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D331497;
	Fri,  2 Oct 2026 00:52:12 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AC503F86F;
	Fri,  2 Oct 2026 00:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790927535; bh=+RDiVJOBHcLWyoFcL8fzBTJOSy0HVXaB5fVTASrdkJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T8yCSVq+IkcMsgFlqIyulbFNDBdKc6tHrs4MCE42T9rnK9TkoEXF68HgZTEecqvUR
	 QBHp1zQ9kS6AqXQRItdrbs/hVknn/zEqRtpNt6ZxxQGf1yNwNBtC7XzJbd+TUEZBbj
	 CcLuMa6XRVfOBjYd1WuveK6A0XCRygQdowC6dwjg=
Date: Fri, 2 Oct 2026 08:52:13 +0100
From: Leo Yan <leo.yan@arm.com>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Replace optparse with argparse in attr.py
Message-ID: <20261002075213.GB1208404@e132581.arm.com>
References: <20261001-perf_replace_optparse_with_argparse-v1-1-268b604f8e55@arm.com>
 <CAP-5=fUKDL6yDs0-7h7zz43BJ1uwC6Y-CiS5TMh+=F=iNc=7Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUKDL6yDs0-7h7zz43BJ1uwC6Y-CiS5TMh+=F=iNc=7Jw@mail.gmail.com>

On Thu, Oct 01, 2026 at 09:20:20AM -0700, Ian Rogers wrote:
> On Thu, Oct 1, 2026 at 8:52 AM Leo Yan <leo.yan@arm.com> wrote:
> >
> > Depending on the Python and pylint versions, pylint can report that
> > optparse is deprecated and fail the lint check. Use argparse to avoid
> > this potential warning.
> >
> > Preserve the existing options and defaults, and let argparse handle
> > help and unexpected positional arguments.
> >
> > Tested with:
> >
> >   # ./perf test -v 'Perf attribute expectations test'
> >   78: Perf attribute expectations test              : Ok
> >
> > Suggested-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Leo Yan <leo.yan@arm.com>
> 
> Hi Leo, thanks for the fix! I see Arnaldo already took this equivalent change:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=tmp.perf-tools-next&id=cd116fcbc0bec7340a659e62210b963c49f93c1e
> 
> Sorry for the extra work, but again thanks!

It is fine, thanks let me know.
