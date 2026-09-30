Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594C8501291;
	Wed, 30 Sep 2026 17:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790783; cv=none; b=HQMZ+ne6Uw4ve7iaECKX6MBrtoExwvYY/hodJWUcKXCW+fjCqoPUeRjMlsZKH20Uo2e3ULZqhL5+f/4QQouGyO+JhZHYTCCUyhxEeMSKocUhBciqx6Am3KdwmRLha83xqmuaDaxicRb6Id/6mhUCC08Iy30LzcEtTctDkCJ4TcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790783; c=relaxed/simple;
	bh=izTJXed8fxPVJV8NAzCn4jXxCaUAYqPQKK+4+fp21Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiyOKSOdNKDJrtwiVQ/f1S6qYd9U72MMFY6AAtbVxoGtLbQvgYdb/Qd07H7oqlQv2i0UKVEHoMtDHgGFGEQlbs874MfHrC05v8tBO1wu8spgTFEYukTJ+rfE/2hR1siMATst27TKm29hfmbZZ2r1jaXFOOX993uTsr//wRtydDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO/0WvLg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO/0WvLg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE481F00898;
	Wed, 30 Sep 2026 17:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790790782;
	bh=Noi8WOljbF5PI4Pj0kwJ6r64GEXIGUCCQxjLTTgqP9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NO/0WvLg86Rr2TzseQlCM0HLwpeKrfD0SaRLcuBtFCUYXjDlff2FVDENTLNJeepmn
	 Nq1uouB1mvcudve9fESiBYpdTYVongVTraIoD8NI1Fac+qXJthTl6D5uqggKAZT4rm
	 9x4BVZu1QtBKEDpCSoA7/41uMYeDVt2d7svnzT2Zh83HuuH8rgf0d1/6IQcBKCyk+8
	 XsfGy2x8/GeeeYlxa2F95RoRdRoB57Rmjgin+b6SVALu6XVfNrtc3cdMl2T4cnf7oI
	 XuzJsGvbbnG3AuDJLoviq0evnGULf0bgArbcZ8KtyQT7TxMUSMrwe8SX2ghHpPjKT3
	 7oZbC/f8T6i0g==
Date: Wed, 30 Sep 2026 19:52:58 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Aishwarya TCV <aishwarya.tcv@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2 0/4] perf build: Fix pylint build failures
Message-ID: <ar1Mel67b1hspZ3h@x2>
References: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com>

On Wed, Sep 30, 2026 at 02:11:35PM +0100, Leo Yan wrote:
> Recent changes to perf's Python module, including enabling pylint by
> default, exposed build failures in our CI. For example:
> 
>   tests/shell/lib/perf_brstack_max.py:8:0: E0401: Unable to import 'perf' (import-error)
> 
> This series builds the perf Python extension before running pylint on
> its consumers without delaying C builds. It also prepends the output
> Python directory to PYTHONPATH for out-of-tree builds.

Thanks, applied patches 1-2 and 4, waiting for the suggestion from Ian
to be considered for patch 3.

- Arnaldo
