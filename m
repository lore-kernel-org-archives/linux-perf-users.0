Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037F64EE840;
	Mon, 28 Sep 2026 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625619; cv=none; b=LsypQzIv3IndI4cNReP6Q+bV8IwMvq5nfEXD4+OripUmhoQVEZonq6DPk+o75SqAggRQm+aKbbjwquUEPrJf4LBwWnmv8lRP2/poRYyQYwymNvz6BprCB5jypxD3KnUlG+3xlyGVOGtEMNOwHMcxMjLTxWYVjNy8BcrR5ct5+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625619; c=relaxed/simple;
	bh=aQ3vNB6hz713/DTmXQ5YjGLNCqdPSScI4G9VpMsdLWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6NTD1JBEIKYCV2tyP5LvCkUy779uExufNoWyow8HO4GMsPXzuVUkPVz3jG1U9KldsV+koXxbzcAKZSWqCM/5iZ4obnLQf7/T8Kp0YfDNtekch3241bm2/h5+7JGjlRMQ2J9/SgGVLqq1EoNayGltbiSfwiP61+SxQOMpM7BI90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gso8+2kP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gso8+2kP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24941F000FF;
	Mon, 28 Sep 2026 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790625617;
	bh=aQ3vNB6hz713/DTmXQ5YjGLNCqdPSScI4G9VpMsdLWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gso8+2kPyPVs1W/janbuYqbuZ2T5KyRmZ3GXRBeRRMJVlC78/vmAFXnDAZkqEueiE
	 h1raBaum4WIZPB9IfV8+QZhllK7DuIRQPOz+XtpmvC3WxZoMS5eFXCdqGje1Abr7u3
	 6QNwTVsTU/WV40ExGH/eq+EmLHzk4i+UtKZHnikeRb9TMXDnKvdkyV40l3be6Or/2x
	 C+Q/6hgPGe6C0iLoNqa7ksIt3K0u+if6yxoSFBhRAGSJRscHWCHfxKfcCfQxOPFPSg
	 JSlXMwt7G298Jin6lb9nBpFD7unOLs/yFHv213zIMp3aJCvD36ur/BrasZqUnARRVN
	 +sN/2S/gDknpg==
Date: Mon, 28 Sep 2026 22:00:14 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test probe_vfs_getname: Also look for the probe
 line in do_getname()
Message-ID: <arrHTjiRa2__-oKm@x2>
References: <20260926223905.6865105-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926223905.6865105-1-irogers@google.com>

On Mon, Sep 28, 2026 at 11:05:32AM -0700, Ian Rogers wrote:
> Since commit 9fa3ec84587c ("allow incomplete imports of filenames"), in
> v7.0, getname_flags() only calls do_getname(). None of the lines the
> vfs_getname tests search for are in getname_flags() any more, so the
> tests always skip. Fall back to the initname() call in do_getname().

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
