Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76DD3FF1B8;
	Fri,  5 Jun 2026 15:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671706; cv=none; b=qg7loSIV2ZLV8NRITEOEhmS8+tUjmOox2XrKcyes03N/heMdmwrRjbjS0Jq4cfRf2S3MqsxskkpFOoD/kcEMXkPmvlz9wxiB6UsZmVioyRgSiPDcycJw0DU22yIElVxnJ6BWUEEg3VucvEOdzvi2NApgoMYvBeqoyxuPJ0WU8hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671706; c=relaxed/simple;
	bh=hXr+RTMBq7sISFgb780qWbHW1dLZ0rWczZsB78SjNxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HAsoBZV7E3sBucgwT3zD2vytYKNoFIrgbRLSYWXFyqjlj/eQ8zC1kdn1VhNOxXj767cgXY9j7j5m09guPubgtm0+jNJYgJ4kyAciKr9MuXnxaPNt7iiy5lBlwZgL/4GhhjKP4Kw9FmH6r8h9cTFxTwWEdcejA/iPBsNjwc+H8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3QpLzWq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3QpLzWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83541F00898;
	Fri,  5 Jun 2026 15:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780671705;
	bh=ovLf2IAGdqjjMtUePwtyFQrfo7j8gfz553pH8Ntxc3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h3QpLzWqfSspG6PaTmDpTKIpiyfrAblEHixibrUMqHHWcFN0fOxlyUwhlL4UQoPJy
	 ylhc9oeSg3KiKbyf+7dd97k3zZa4nvWm0/Zpcyn2SL5CAZbJFzSSGIAjUlX9LxLpFj
	 hzcxzU58Qobq+gekRLgjzv+Tjkj6Pwxrg1Oc/i/sO0L+YisvGNZoO2ismh62y8Yeh3
	 fBvU7z2IZfP6ZNQptTOaOVOTzvy/ihX7aqI7atYrYAEa58spjMIXvYLmjz0OAlq6T+
	 yVXy0wMNMad8BJ5+KYouzdQ8lBzcZKB3dQZRg7dzbHc2UyM7W4xRUzv+EJVOf4G2W7
	 b7vDn9SeScL1Q==
Date: Fri, 5 Jun 2026 12:01:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: Re: [PATCH 4/5] perf sched: Cap max_cpu at MAX_CPUS in timehist
 sample processing
Message-ID: <aiLk1euDqsFGbe0p@x1>
References: <20260605121515.1725549-1-acme@kernel.org>
 <20260605121515.1725549-5-acme@kernel.org>
 <b30d8432-3512-4053-93d6-77f2be96a796@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b30d8432-3512-4053-93d6-77f2be96a796@gmail.com>

On Fri, Jun 05, 2026 at 08:34:53AM -0600, David Ahern wrote:
> On 6/5/26 6:15 AM, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Add bounds checks before both max_cpu updates, matching the pattern
> > already used in map_switch_event().

> > Fixes: 49394a2a24c7 ("perf sched timehist: Introduce timehist command")
> > Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> > Cc: David Ahern <dsahern@gmail.com>
> > Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/builtin-sched.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)

> LGTM
 
> Reviewed-by: David Ahern <dsahern@kernel.org>
 
Thanks, added to the cset,

- Arnaldo
