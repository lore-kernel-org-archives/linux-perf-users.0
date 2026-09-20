Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E47C3D4123
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789882681; cv=none; b=cBQsOlCcM2z79Bo00Q3DNjwFT9sbtN9YljGdeUNLvZ2krD8ypWzyRdJS4i9k1YvF18T3iitYQg132OmLGWMBunKI7DO/O32IHLO72Gnyc/Umf5Y0Cdw9alZGfLiNXvSIngYM5CpPkDZrJAIMXSE1P5mUiO5rSckWUlAo1Dr31vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789882681; c=relaxed/simple;
	bh=ZbJQRXgX460yzB/mq68yTW1A6QeLU6U1c/dwMcOmtmk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nCEDfzpeet3i8XNFitJiHcXFgSpMjgG8YduUS/j2tfewGJErS4tMnKh5HIJdIChtXZmSAENCz8H5yTjqcNHCSCztwYejlkCk1sVOU8d8rBUuLepdqHmitRxOw86aOG8crcl4dMTNxtt01q8JwlKo8Igh1QGJklLyAe+4rootMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USyDqNXy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USyDqNXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6321F000FF;
	Sun, 20 Sep 2026 05:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789882680;
	bh=+iAqovBkrvVJX602c9vOMmzEtTHwt4e1lg0r3Zdh/J0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=USyDqNXyxyKLNlclroH+FU1LPBLhnfbgDPANmg5aeUBF/X1yZibgTVgZAajpSPi3V
	 JX/kGxbOj1rIUEBHvDiv6kSy+VK57LQ0NFnziX/V8hT1GzE+leGppj5uXMQ6ETjmST
	 qGxujK57sFnhoqiKDf9/GzxpJlCBTI7quNnio/KPlSUm6r3sToFG9D5YA1ItlwVfKF
	 4w+vtEohMV6HThi4Zx0vir+DOQDO/+fNL3+ohycs5BD7z9ILIAvfGN7xjRRyy80B6H
	 a4fzEQZXMhHiNsyIDv6uleRWqGqA2n2qHdTfuIWeOuLsVfYl3JfXwfL7QvPYzzI8XR
	 SjJ9W3huJo4Ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 31/49] perf python: Port task-analyzer to perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <492549293c5943ab7cf573695f308955da130be8.1789880842.git.irogers@google.com>
References: <cover.1789880842.git.irogers@google.com>
 <492549293c5943ab7cf573695f308955da130be8.1789880842.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 05:37:59 +0000
Message-Id: <20260920053759.EC6321F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Port task-analyzer.py from tools/perf/scripts/python/ to a standalone
> script in tools/perf/python/ refactored into a class-based architecture.
>=20
> Improvements compared to the legacy script:
> - Support both offline perf.data file analysis (using perf.session) and
>   live trace capture (using evlist.read_on_cpu), accessing
>   sched:sched_switch tracepoint fields directly from sample objects.
> - Automatically disable ANSI terminal color escape sequences when --csv
>   or --csv-summary is enabled so CSV column headers ('Comm,',
>   'Time Out-Out,', etc.) are never polluted by color codes when running
>   interactively on a TTY (e.g. as root).
> - Sanitize non-printable characters and leading CSV formula characters
>   (=3D, +, -, @) in task comm strings.
> - Emit a one-time warning to stderr if sched:sched_switch samples are
>   missing tracepoint fields (such as when recorded without libtraceevent
>   support).
>=20
> Update test_task_analyzer.sh to invoke the standalone script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789880842.gi=
t.irogers@google.com?part=3D31

