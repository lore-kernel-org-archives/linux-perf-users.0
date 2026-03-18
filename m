Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A672721CA03
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 18:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773858889; cv=none; b=Y9rAZEz+Cd5GC4AoNjqT4+FGBmNPKll2CYIEvfykipdIRQ+U7okRauFhOTUbd6XiUwcbqF8j1R195uZeAxi7SmJize0O5AGObqMYFqzwN2UfuGnKF5rcfZMX7i0nXcDuX3JOnHvBRpOxc4DhMaMupyOIK1DzrylCY5SgT54Ot4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773858889; c=relaxed/simple;
	bh=xGK6GsdwL25ism2FGlBFdHI5dICdcBy3SGVUEwOEoSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XY86vp7BoEZ47AcsnSJ4BHCEq98a5GcYFEBdeTKkLrc2Lzc1eongKZ2xCQ54kP7ZcchW9ByI6ON368GDKGSLtlVJvRTvpwL30fynZbX9AlFNfvJFpRnv4Jba1p+wd7IeMweszYaHJoWyl4NsQAYBoZo8IhJTVXQKvLQJ+gwgjCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOjUh3pM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOjUh3pM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9510C19421;
	Wed, 18 Mar 2026 18:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773858889;
	bh=xGK6GsdwL25ism2FGlBFdHI5dICdcBy3SGVUEwOEoSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOjUh3pMNW7qDQXCKG+Vi4baSl8GMRqD3dznXQD+DkPnokA1HcpD3Orge4gtoYc3z
	 9jnlcTHv7Y2WUCL7m48BXnKHQDzM5IhOF2xfXzWHIqEh0KDAEEhWgxhaM7gAUBWk9g
	 yMesPdbuu2j6CCBob0BI6d/IxQFKoCTkEOkFvAZfDe3UZkFKFCBghYAsThK2CHqyfs
	 aZJ4ia2ZFJrOwV/7s0upMzprZNcGn5nWItsjwfd6Lo/qDcPyzWPepsekfrtBdo6lWt
	 j7f0PqwceJq6QbKpfh+kgZROAK9PeoqZTqt/KD2ZeR5g+7wPZvOXnpl1UeXKXCtY5J
	 tBkwBOdpEkMlg==
Date: Wed, 18 Mar 2026 11:34:46 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Chen Ni <nichen@iscas.ac.cn>, linux-perf-users@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org
Subject: Re: [PATCH] perf intel-tpebs: Remove duplicate include of stat.h
Message-ID: <abrwRmaS7CDhzAyl@google.com>
References: <20260318034932.398913-1-nichen@iscas.ac.cn>
 <CAP-5=fUitzKwJONTngiW17XkS7kVr2cDS4cDL_HccJKcnR2EgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUitzKwJONTngiW17XkS7kVr2cDS4cDL_HccJKcnR2EgQ@mail.gmail.com>

On Wed, Mar 18, 2026 at 10:33:54AM -0700, Ian Rogers wrote:
> On Tue, Mar 17, 2026 at 8:54 PM Chen Ni <nichen@iscas.ac.cn> wrote:
> >
> > Remove duplicate inclusion of stat.h in intel-tpebs.c to clean up
> > redundant code.
> >
> > Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> We should really have a style for #includes and try to get it into the
> kernel coding style. It doesn't matter so much in the kernel but
> inconsistencies abound in tools, and the lack of alphabetical sorting
> allows duplicates to occur. Here is a proposal that makes sense:
> 
> For any given C source file (e.g., server.c), group your #include
> directives into distinct blocks separated by a blank line, ordered as
> follows:
>  * The Corresponding Header ("server.h")
>  * C Standard Library Headers (<stdio.h>, <stdlib.h>)
>  * OS/System-Specific Headers (<unistd.h>, <pthread.h>)
>  * Third-Party Library Headers (<sqlite3.h>, <jansson.h>)
>  * Your Project's Other Headers ("utils/logger.h", "database.h")
> Within each block, alphabetize the headers.

Yep, sounds good.  I'm not sure if we want to convert all existing
sources for this.  I think it's good for new changes touching header
inclusion.

Thanks,
Namhyung

