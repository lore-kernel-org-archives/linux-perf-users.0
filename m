Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73F9331EC3
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882905; cv=none; b=HoyqyK8Uw9M/JPKSDipKF/B2OqJrKvCoBTHe1wKxfK1d1ESAHKaMRq7t+3PROXhvYXqTZRZ49M3oNYpqCYVLWlggoLj473MqhLPOFd1KIZs01KCKAQE/7WCcHDefqJtA1xSX5PusterSoUhYkdmlMz+nq4S94CHVmeiyimnspIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882905; c=relaxed/simple;
	bh=Er7urJGeDhxVTIC6KQbtRQ7XHU9XND8itcQ32E30LXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jYcPHFyBVzyjzCFWbMI6vj1QvK62O6AhMqhOC7Cn2UBN7YOr5jLGVGFzq1GiLKv58lewaBUsDMZH96w7Jdx9GhAP/x0mJ+iHlc5BSS9coVnSK/XcJHhCuZhGpUZ9tXiVWMSjpllbfABi0WdvbHaZgTV6eYwJhz27MgF0mzYmXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFZ5BuO6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFZ5BuO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE831F000FF;
	Sun, 20 Sep 2026 05:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882904;
	bh=Er7urJGeDhxVTIC6KQbtRQ7XHU9XND8itcQ32E30LXg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YFZ5BuO6LAiHW6MyDacdpQKVv3wp3T7c7s/2fD0IcBFWwfsTvQ7wnyzlmEepRzmee
	 sSYXpDRhJtGWioRvtP481nZmFqJTFREKJZUozvujawQu6GK3k6SdO292ND9U7QRPCl
	 Vy1U8aktJQKNpptc+66wU5lGS466UtwN7G7ULxx3pUHg+lobW9/Kl/yLtFRyZio5BW
	 vhOST7fEuev+MLzGL81KpGbmGpLyxKPTfBaUdUxaWBqbb/jiygFoOFRgOBLBUnviNf
	 1OuWUBKuONotUzPrn4H4tHJZ6cSuHN4pFtma8KWMakwbQ+cy4tTewK15FZqpCMYRXj
	 L0LQkhiEbgCCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 47/49] perf Makefile: Update Python script
 installation path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <4d04d53330f60bf25981a8c0fa8aa8e491ea6a2d.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <4d04d53330f60bf25981a8c0fa8aa8e491ea6a2d.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:41:43 +0000
Message-Id: <20260920054144.6DE831F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Replace the libpython feature test with a python-module feature test
> checking for Python C extension build capability, and update feature
> test references accordingly.
>=20
> Remove references to the legacy scripts/python directory and install
> standalone Python scripts directly under the python directory in
> libexec. Update the TUI script browser (ui/browsers/scripts.c) to
> discover standalone scripts from the updated installation path.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D47

