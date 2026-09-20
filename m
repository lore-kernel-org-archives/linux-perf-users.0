Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A0233B970
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882146; cv=none; b=Zi/F9iQDe/euEQaG58YyS78bPWsJ+DDjxnz5Ps6Ig3oNaCmzDOA6yHoYUXF3MQaqTC/D5FgOj7AhuhItDp6IFo+yju0bLrO8nMUkk1cvUxpipbJYAnQ5weEwEy/yWKeeiOd4YtsIR9gtI9+RVI821w89c5QLxXC3KADS2oAzBCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882146; c=relaxed/simple;
	bh=RL1jfWae7krR4FGV9vmdtPCb9PJxLN4MvosaBcFCOAE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MMC5udtSGfy1HmuyoIPk1xT9wUsVyjvds/TaA8woPRuq6E+YzBBKzT32JcOmfMWjujaTSacKga+Zdg9eX1dKC9i1TcHs4lVvyetrdsD+dNrj5wznsfeWSBgyivl+eE8U4JFzFa3zbGVSiglTUAhOhrMCkDWo2TY43SpI5wYL3jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vk/G7ghK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vk/G7ghK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D551F000FF;
	Sun, 20 Sep 2026 05:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882144;
	bh=KmCYbXJyTbTvP+7QkC7XW6xvI9MV1VLYX8UIRk+ylGc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vk/G7ghKzsTXaKmT8/m/zm2dBqsB9GR9DEjBTBXvzzBkZP9HLmp4QL4jwyI0dN37P
	 69wqJrW9mF2IH3CrcSsL7HzYjWV4ZH0af7wEkVAtDU/mmMzbR9JZ1jUu+r9cg35AZP
	 GSw0gvRgxGXC1xU7TXMkrWHoGkQ32bcAxsuvf/N28TiFjsJQ+FD8A6+AW/7jIl/wxI
	 TZSRh43odDEAyLtSQ5Cqe1cd4wy16iZyZjitq3MeZObUV30qoB4qhvGFaU0h46Ebr9
	 2+PBJRiyqNCvNRy9l18PdXRV/WUHsqhdJn+NjKkvAnjejUMKbHZpQ3cnu8YuhqXI4C
	 r1H4oAfxHDq0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 12/49] perf test: Clean up mypy and pylint issues in
 shell test libraries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <5d059447398953037600359260868821d7cb250c.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <5d059447398953037600359260868821d7cb250c.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:29:04 +0000
Message-Id: <20260920052904.71D551F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Clean up mypy type errors and pylint errors/warnings in
> tools/perf/tests/shell/lib/ (attr.py, perf_json_output_lint.py, and
> perf_metric_validation.py):
> - Fix E0606 (possibly-used-before-assignment) in perf_metric_validation.py
>   by importing sys at module level.
> - Add type annotations for stack, second_results, collectlist,
>   get_bounds(),
>   and main() in perf_metric_validation.py.
> - Avoid assigning -1 to list[int] expected_items in
>   perf_json_output_lint.py,
>   rename shadowing variables, and remove redundant lambdas.
> - Remove unnecessary semicolons, use lazy logging arguments, specify
>   exception types and file encodings, and initialize module-level logger
>   in attr.py.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D12

