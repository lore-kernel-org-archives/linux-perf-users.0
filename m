Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF611395D8C
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790767934; cv=none; b=tyAVOLLVjQoMRwBcKSKW88GIHmgM5OmspGSRd/QeYRazv8YJN8wG94to4yiiyCz0mnt9jyO5WQgxIFX2FUST00jaUrANsbhTyWIAlzK8z3TfvzqFaKHlyJIuMC0ikEoLF/qPm28mPgheyhgyhjrMijniN0fiZQIrzz4nX6ZZRqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790767934; c=relaxed/simple;
	bh=9lgg8R+86JpnzNEwMvh+35qcVwdby2ywk3T7bfGFryA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q/znyPu5n4s2+XxNgUFw3mU3HenNVZR81bvhPcTOBpHl6OI+q4Uf0a1E1kCuRJC1BCOSL3F7IHHtzb8fIT+1Yr+YwQZQb1+z9u6dNkevgzgY2rH/unKUkhzT3CSrrkwOlo1oubpQgA7wl1VFi720vHrGrUzucwzea2YwZBEnLXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEsVhDqC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEsVhDqC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FED1F000FF;
	Wed, 30 Sep 2026 11:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790767933;
	bh=zvw1YZjclKjcW7ZQ6wRKSdSnH+2CUGPEYokLLgvZW9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IEsVhDqCKbcn5Rm2tPwNXfWxV0ZWzzLl8cIeirY/Z1l1FS94lGu+gFTn/hUCqjodT
	 FoCC+7PvmfhBpg6s+LlZSvtZNRUSGaqRKly1VGzPdL+0VBnh/DeXiRlUcN5+wan9Ql
	 aDVtw/D1dNzgpEU3LM0FJXEwPnmFqDhkMtTaeoRvh7EGAodH8k4mRyXxnG/Y4FlmI3
	 GZIHN9TKDTwf30TI1EI1odvoGQKOh54C0XSnPtZhI5H8sOfuFNiNBcfUXnQaxzRSFV
	 GZvWF6o4cpIUfbPnVqWgtA+6ntumVJOX1jQIfyUqM/pZK9W/3RljgL796I7ttKO3FB
	 JIzxskBugNQJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/5] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930112454.16331-3-acme@kernel.org>
References: <20260930112454.16331-1-acme@kernel.org>
 <20260930112454.16331-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 11:32:12 +0000
Message-Id: <20260930113213.42FED1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Processing a large session with stdio output gives no feedback about
> which phase perf is in or how far along it is: ui_progress updates are
> only shown by the TUI.  Add --progress, installing a stdio backend
> (ui/stdio/progress.c) that prints the phase title, percentage and
> counts:
>=20
>   Processing events... [42.3%] 317M / 746M
>=20
> Phases can be nested, so the backend tracks the ones started to
> complete the right one on ui_progress__finish(); that requires
> init()/finish() pairs, fixed in ordered-events.c and the pipe and
> directory event processing.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930112454.1633=
1-1-acme@kernel.org?part=3D2

