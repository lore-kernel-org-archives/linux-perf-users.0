Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407123590A9;
	Tue, 29 Sep 2026 01:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790646526; cv=none; b=ljoAho/2dU8Vddi3ZCHrf6D/GfhFTtSAHjaJeimXssKskCvuyqamauJMTcOs5gf/2kcRjTZIGfT+K7Ut+zkT8CkX+v0zBtuGA5XZIVLCV4hlFMvBL/aSqGAn3sUDNl53XNOo/XKV61N21FFr6FOyEphEII1GYtsMjitXyIvShRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790646526; c=relaxed/simple;
	bh=ohme0J0f+heRdNlQnl5QLMmslj+asmlCcm2HQ0h7qq0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fXoaw8DHMPzxLqrLMDfvtpyHykKGor5/bbfSVsWKUDVPT0TYoenf4+ywPy4ty8hR5mM7V5oa/gpbapzD+2ojAhugOyy/GyIbKqyaz2e7uPPlGj76yE7Qg98LxzajS3DIxWaBG9FFb6aKKYw/eJDftFkk8IhI4uQ8MM2oNBJhtqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0ZL855o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0ZL855o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A651F000FF;
	Tue, 29 Sep 2026 01:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790646523;
	bh=ohme0J0f+heRdNlQnl5QLMmslj+asmlCcm2HQ0h7qq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o0ZL855o1HFvPjdvcoyMk4IHClio87SH5kNBOSbiipRWRN90qu8NvlV/hCK2zMJ/t
	 56+wHeN9tRT0MAJPNSKSq1edG9sarAhY2SuFm7Rri+N7/D6xuVbh/fZv26HoBzfqCP
	 S8m5lqDh87wXlskk5ctIjnx05XW+e+PtCvOuvbk7JKMX+cvzOUz6bLTUX8tX2LXAqH
	 5dhOYsamrPkb99JarS0Ad7VgRBE3GWGumeKFbnsqZTu6YIXDEOX1givVqL0yLO02Bx
	 wIi9v6T6tQZcvbd+2sSAgqQQOpJmUtssl9KE/HzjmULeeqn0APSwSLO68a5Wm43dz6
	 ZALmljNvV/UKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] perf/core: Restore header fields in sideband output
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260929014206.4175245-1-irogers@google.com>
References: <20260929014206.4175245-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 01:48:42 +0000
Message-Id: <20260929014843.65A651F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> perf_iterate_sb() invokes its callback for each matching perf_event on
> the CPU and task context, passing a shared caller-allocated event
> structure.
>=20
> perf_event_header__init_id() increments header->size by
> event->id_header_size. Unlike perf_event_task_output(),
> perf_event_comm_output(), perf_event_namespaces_output(),
> perf_event_cgroup_output(), perf_event_mmap_output(), and
> perf_callchain_deferred_output(), three sideband callbacks failed to
> save and restore header.size around perf_event_header__init_id():
> - perf_event_ksymbol_output()
> - perf_event_bpf_output()
> - perf_event_text_poke_output()
>=20
> When multiple events with attr.ksymbol, attr.bpf_event, or
> [ ... ]
> Fixes: 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
> Fixes: e17d43b93e54 ("perf: Add perf text poke event")
> Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929014206.4175=
245-1-irogers@google.com?part=3D1

