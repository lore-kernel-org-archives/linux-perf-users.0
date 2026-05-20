Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCF03043B2;
	Wed, 20 May 2026 19:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304418; cv=none; b=iXxHEvwwKyowGQdbnQJlO4XK/1Q0V3kqy74ohFOqNrBG9q/7hOmirFQpWyiPKKYiErIZCwGflmC2Pewio/8wCDJNHK29T5NrZjIeiYzgmEkJFgS8PvnpzrCdJDFQgrjVfpW81dIvWU2X0pqOPsUsRsvlva/WYrhwSEwkLEaibzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304418; c=relaxed/simple;
	bh=nTcmhBVkKwijDXWu/IGq4QCPbpH9XINzYtMwbjwyuzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WrTRlto8Kv7nm8KPkEx+Kr4D4TDT4/2o0G0IoFGUFvlmJHo/TKEaV0xbaMa03JFHBrzaIkzEijxPU0wmWOuadIJRiL8gYNektpwTIG+oYz71Fo1vjs+I8dMZOjHpDdA/oeJaH8n6oWeaLxf/wTWAaBKerUZvEYhAqAOJsxKrnGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLiriCib; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLiriCib"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4E71F000E9;
	Wed, 20 May 2026 19:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779304417;
	bh=l4IqJovSJSJ8OtKvuVr3UfRFJO/2LKWj7Z6o1F53D8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XLiriCibi+DXV6SGT/q23Oc5ZkyiDj001AoD/I8EuKJAi4UCz34rXMo2Yagji+3NF
	 uCeH+XwwE7X1GbBVHPd5F+uL7Z+lx3GJXJNmdlKz98cH6lEB2i3UfjKLALkr2EC+Ba
	 8gi5laAPDzmTmHopdgDKVwvXJkm60E7NPlIqk5tK8CJKdduYl9jc6CbvcON62PuwRb
	 OXpD5T5Q2e1Jc5CpDvFIh4lcoJnt0upCemcC8MVnLVhig65P5VP4KUxVrvvG2rjh/w
	 CHyQ4Ha/cY2wqyC7COkt7uUvwCDzhNXTOETaHwSWfeMsogPKavSR8CSANddVhEGD5f
	 cOsRIU3muRNwA==
Date: Wed, 20 May 2026 16:13:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org,
	leo.yan@linux.dev, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, ravi.bangoria@amd.com,
	thomas.falcon@intel.com
Subject: Re: [PATCH v8 0/2] perf inject intel-PT LBR/brstack synthesis fixes
Message-ID: <ag4H3hdX6TihjQ-4@x1>
References: <20260518203805.2955241-1-irogers@google.com>
 <20260518224325.3037838-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518224325.3037838-1-irogers@google.com>

On Mon, May 18, 2026 at 03:43:23PM -0700, Ian Rogers wrote:
> An intel-pt trace can be turned into LBR events either in perf script
> or perf inject with the --itrace=L option. With perf inject the
> generated perf.data file failed to be parsed as the sample events were
> out of sync with their perf_event_attr. A range of fixes were
> required.
> 
> This patch was separated from a large perf script refactor that
> highlighted the breakage:
> https://lore.kernel.org/lkml/20260425224951.174663-1-irogers@google.com/

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
