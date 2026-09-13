Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7978F3CF67F
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789339151; cv=none; b=fRNx/TWk7UtzRKuCBXY8n8Nq0opac0zfiUFLpEVDm6DfpnMvEoByFDmv6cIqyPHWCTJGP2pNRFTSQ1+08dLAaVhQ6xnkQdfI8EPtDNLEza/PEh2rBwcIShzECdJEWFwauBaGz7YTsHFfVihOe6l9LSNINejvdYGHCOKGbS8x9AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789339151; c=relaxed/simple;
	bh=wl9J+ZMXtUQBqPYBXOtszLYgO9kbQZXUqZKtCjYdaHk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EzKRcNMqt2iEuIDgtmMjm14cChm+TL/9AajnQHsrrognrCyWIVwMPURc1qejAaHBKW3PX6n3dnYfXwlZGa/+P1TYw6+3GDYFS5C3e5rcviXBbbYWDCYSx25Cuty8D07DXzX+Ok4WFL6zFMOGzzTtUpAwmMHs2HhP95J6TCMWT7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYg/iaJR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYg/iaJR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9561F000FF;
	Sun, 13 Sep 2026 22:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789339147;
	bh=2pz//EK3liaQwaoMjH2CXqbNIqbKzp2VfLltRRDqiUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CYg/iaJRcKHTJLpnkhhyz1NZOhcPzPCxvhJI0awcbnMp8GSxLSf4wGXQFDQ1Q66eo
	 97qWnT+WRrdmxgvilXA7jm6XKGBwiGryhOE+GQDhqBsTYMHwIdBbvL1AsLc+aku8WZ
	 s4BeSt4xU/c9dUxXAHGwZymrVDb0EqzJpF+MWz4WGNd9T6eC37mISVpWhF9o8Jd3UO
	 9ITcAJregK0M84XtOIXvy9sYJQ0DR4uyt1BY3mTnpes7f+t9hdgGVc/JoXXotAtz5P
	 3MTk25LS5oV8iUXoRmNqstvdxOIHn41GPK+O7IsYD86n1y/Kd0nF/eyU17ODK9c1ZB
	 dRLn8nVecDw9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913222821.3353-6-acme@kernel.org>
References: <20260913222821.3353-1-acme@kernel.org>
 <20260913222821.3353-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 22:39:06 +0000
Message-Id: <20260913223907.4C9561F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Processing a large data type profiling session, e.g. an AMD IBS one, can
> take a long time and, when using the stdio output, 'perf report' gives no
> feedback about which phase it is in nor about how far along it is: the
> TUI has a progress bar for that, but in the stdio case the ui_progress
> updates, that are already there, are dropped on the floor.
>=20
> Add a --progress option that installs a stdio backend for ui_progress,
> ui/stdio/progress.c, printing the phase title, the percentage done and
> the current/total counts to stderr:
>=20
>   Processing events... [ 42.3%] 317M / 746M
>   Merging related events... [ 61.0%] 309026 / 506686
>   Sorting events for output... [ 98.2%] 14132 / 14387
> [ ... ]
>   88: Test that perf report handles truncated perf.data gracefully (no cr=
ash, no segfault =E2=80=94 clean error exit).: Ok
>   =E2=AC=A2 [acme@toolbx perf-tools-next]$
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913222821.3353=
-1-acme@kernel.org?part=3D5

