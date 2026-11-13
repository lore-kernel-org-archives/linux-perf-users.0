Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602689;
	b=J0WleQ7I1uA2rQWL2MP/AyEmgkvDA+1ub3M/IKhlRAWboLkopkaUK1IWpDDkRQngNEuz
	 SZSsdTMc0di8+zZbab1azamuB0wNhlNYuRbD1ZDc2PPpxiPf0zCcFY1VwTEDt3pLABvcc
	 mk1kqPKpvGLuuOmn/45289DQZagCVtB6WCeGY/qI7B+ytW6yQN3+oOT4xr900gUvsIKey
	 pHewzBnh58Nn3qO4vWBSzM4lrpk4dwQwupw5Or4NwQ+1mFAfv602Zn1u8i9D3c2qS/IJQ
	 oIIrNn0ghUvuqIpTOFE5mHSmzpWL2Ed4GlEZYYRE2kovfC1iWL7HGSroVhHne5ce2mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602689;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eGEYYHVPJ1f4CpnOh6DJ3tj9mAIQCYlQoT1G9njzzxk=;
	b=lj40AK5OCdy4RGl/aIGhntnnQKa25TQwi13n9HX3nj9CdLE1nSxDvHC7B7UuvTelXJi+
	 yp7eG0l4rXrCAPCXaIih0J7wnrMD5a+QuHibfuZkeaJbhytUGsYJIdLppXw+I/ogo0SV/
	 X7GqQ7vnhNssxlWt2AFwf+GAuJ8u8MZjsu+eRGp38Smmg5josalGTB22zbwQG0e0//xiA
	 nMjT4njYubYg0wlNUc/wIF5Q2FVm5Bu+zEdPy9MYvq203m6wH/8bLx8K5nMoWJVIxcV9I
	 PD9WGJbRqgnUtzn53l9JGGtJ2t4PMo5rsRkN/PyxWPDymZmEOzIoJ9lpRRUuU0e1lWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UC5NgVhr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA96606A331
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UC5NgVhr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1DA1F000C4;
	Fri, 13 Nov 2026 20:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602689;
	bh=eGEYYHVPJ1f4CpnOh6DJ3tj9mAIQCYlQoT1G9njzzxk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UC5NgVhrMubdAiQX0cjsHtueL1d4Q03EgE5q+vgpKxPKN4GxULCoTbwjw/nBu6ph4
	 2oLeoRmYiTlgdglNmSBVo7mHxJlzZaBtWft5Bs+Mn47Fh2Z3e4SDVHoABT2MmxenzQ
	 6LhCwgOwhk2bjVOwf8NFnGR/fadtIzlqzNEgFHgdmH8+HeE3Ksch69GTspMFCuKY3H
	 C2n/ewN+2j/nsCseRxIcgTCJProol3aLeNSEKW3jslBqW3N0Il2J9oUiz8/MvJcksV
	 oBSnG92QLcIs5Ypr8VUtI4BW2FEyPQDAQjh7IZ4fE3r1QZtUHWltQq4afR7ylRNCD3
	 NChTFIh9hv8eg==
Message-ID: <sashiko-outbox-213676@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 28/30] perf stat report: Display metrics for recorded
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113195335.2865725-29-irogers@google.com>
References: <20261113195335.2865725-1-irogers@google.com>
 <20261113195335.2865725-29-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:44:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> perf stat report displays the recorded counts but not the metrics that
> perf stat record displayed, as metrics aren't recorded in the perf.data
> file. Inspect the recorded command line in struct perf_env and display
> the metrics requested on the perf stat record command line (or the
> default metrics when no events or metrics were explicitly specified),
> for example:
>=20
>   $ perf stat record -M insn_per_cycle -a sleep 1
>   $ perf stat report
>   ...
>     784,599,279  cpu_atom/cpu-cycles/   # 0.7 instructions  insn_per_cycle
>     586,070,692  cpu_atom/instructions/
>     776,737,361  cpu_core/cpu-cycles/   # 1.3 instructions  insn_per_cycle
>   1,011,699,468  cpu_core/instructions/
>=20
>     1.004467030 seconds time elapsed
>=20
> Also add --all-metrics (and the stat.all-metrics config option) to
> display all metrics whose events were recorded in the perf.data file,
> as well as -M/--metrics and --metric-only options to perf stat report.
> Set stat_config.system_wide from the recorded thread map as metrics
> such as CPUs_utilized depend upon it.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113195335.2865=
725-1-irogers@google.com?part=3D28

