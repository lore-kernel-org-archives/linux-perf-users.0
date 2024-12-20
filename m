Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0095F22257A;
	Fri, 20 Dec 2024 19:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734723915; cv=none; b=OHH2CDc2a2f8HBaz517BNj/yP5yQRhDcyB0uCoOlhtd1YsMmQABh52/jIBRK+YpUbyvNQEQDR/R5LzKNK85J8O/GbSC8iZLYCmKQXsEgQ53WbU8abqX9bKw8NIdujP9cBIhFjuu3XYcU7nVRIIY7z7/cag4sefEO+jVBupnfsFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734723915; c=relaxed/simple;
	bh=twKmijV3Isl2b42dmSUPZPJhFht6HOf8zrpGL9R95TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HW9rrgsfWqxphhcV+XMUisLSRp6tLaoKFrTgfqO9XbYMT/QiaLqb1gspVabNYriRMi/QCN2372yODe/aqqKuKOKzh9SGpaKVaHFzzDHY8lcANav+I0WUuuotWvPgkYZYRzyobnaVX5jfblhqDHkf3c9O2JZDz0mqMyWaI7cMOCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPDbmuU1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPDbmuU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA30DC4CECD;
	Fri, 20 Dec 2024 19:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734723914;
	bh=twKmijV3Isl2b42dmSUPZPJhFht6HOf8zrpGL9R95TE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aPDbmuU1I6LYZ5f3vxfL0EFl1UifgVuOA0oLmaaBfFVrpslI3zQSpXOre8Yk0FdhK
	 aKSkFE+Qba6JMjBMZqYIJwmfz+samLr5UYConNB17rJJypFQl2wIW09vsqP1RW7HeU
	 yJXU1cewq0hB1iyH16LmwKkjW0sR35kl3GNbA0JrAUN7ke9XAbhYoS2RXPoLcp3SQK
	 FzZ4kQisYHH/ht9CiDxRLa+zXR9PHxG9QtYfmz8/nsQEv5c75eZmRSSvkqTjsJOF4j
	 ux+6L5COSpVmQM8XwS826vS4bFaroLMeRICkW2Zbe2T+esgk9bFJAw6SlN4OkbYSYi
	 cC6A3Od7krX8A==
Date: Fri, 20 Dec 2024 16:45:11 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
	Chen Ni <nichen@iscas.ac.cn>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Prefer evsel over evsel->core.idx
Message-ID: <Z2XJR5K-dQIJRuJO@x1>
References: <20241114230713.330701-1-irogers@google.com>
 <Z1zNuQaqtDDoQhP6@google.com>
 <CAP-5=fXOdoyuXwTC2coFUAg_ruaYqj3KVe27YjcBtHCAFt_NeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXOdoyuXwTC2coFUAg_ruaYqj3KVe27YjcBtHCAFt_NeA@mail.gmail.com>

On Fri, Dec 20, 2024 at 10:57:58AM -0800, Ian Rogers wrote:
> On Fri, Dec 13, 2024 at 4:13 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Nov 14, 2024 at 03:07:10PM -0800, Ian Rogers wrote:
> > > James Clark's patches fixing evsel->core.idx [1] reminded me that we
> > > pass the int value around unnecessarily. Passing the evsel avoids
> > > issues if the evlist is reordered but paired with sanitizers we can
> > > also know when something is used when it shouldn't be. These patches
> > > do some initial work reducing the use of evsel->core.idx or reducing
> > > the API to pass evsels and not their interior index.
> > >
> > > [1] https://lore.kernel.org/lkml/20241114160450.295844-2-james.clark@linaro.org/
> > >
> > > Ian Rogers (3):
> > >   perf stream: Use evsel rather than evsel->idx
> > >   perf values: Use evsel rather than evsel->idx
> > >   perf annotate: Prefer passing evsel to evsel->core.idx
> 
> Ping.
> 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next,

- Arnaldo
