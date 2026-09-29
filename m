Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200FC35C1A1
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790717345; cv=none; b=XfUzgRF139Qr0X6n9XyHX3Su9OS22vlMEVC2eVAbNC1ak3RJQ8oR84g0rsQfhH4CSO+c0XHJwnaWZ29kj9oEQzSYTHraZq83lWgnhI57rRIAHfNYWPU0NXUWPKcP9aj4/0kXE/vFfqFhxAW8DEcCM8JIXDYZnAx315OqW1ybtZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790717345; c=relaxed/simple;
	bh=fOSFSyFeyOfdqhrmLGtM8M9JPVymI8rPCUxe562tHLw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uZxKjWDkJmpkGVJ5s4KIvIF9gS+vrIKe0jlHK7SV7jAh+p6hBvHIr0BA+TE65b92ZfGIV0BeMtglu4JwMUi4tfSuZaqlBY1dPsSrUMnELNI51u5qbtdLfD+qkvfxgM29hcidkhoAiICKcMBQQ/u9lN2mEoPiBFyAkyj8wgjV2zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRIStG8U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRIStG8U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58A51F000FF;
	Tue, 29 Sep 2026 21:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790717343;
	bh=g3oMjCNR6YE+/pi6H8uHgV/9rXBOlTnyQipzS9U5goY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TRIStG8Ugf1VgFZPXWRg5rvaa9uMmhhcP/l13Rc34oKCH3Vt9M6/gcVchrYpNtalT
	 oXoVlLkzEOQq3+qsFUncJuXZwv5iOcY+bBCE5MroNdYw3JGlsbIKDwSMWt3d/71J/I
	 j8m1rhiSQvjsY2BbwR52j1s3r0zmRnY7fJw8voCFiSIlV8amSPZUor6RvI/8CR6ilv
	 ZJb5Umj/1cMwozJebZVPLLHBlEsBY7jQ6Q4QYbXsvClRyJ2mIkPjFswV+RtWB6lXh6
	 BLFHhxjfLMziuKLBEHXYBg/0SiGb6ed9BkGrLOyhy0hSg0xZAMvo14ZoY4Ekcv6Pem
	 zWAkoBbG0hMKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] perf scripts: Add perf-stuck, to tell where a
 running perf is stuck
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929212246.2532021-5-acme@kernel.org>
References: <20260929212246.2532021-1-acme@kernel.org>
 <20260929212246.2532021-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 21:29:03 +0000
Message-Id: <20260929212903.B58A51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A perf that takes forever is hard to tell apart from one stuck in a
> loop, and there is no way to see where without attaching gdb.
> perf-stuck.sh samples a running process' /proc entries and its progress
> line at a fixed interval, and with -g runs gdb (perf-stuck.gdb, adding
> the perf-die-chain command) when no progress is made across two
> samples, printing the DIE chain a DWARF type chase is stuck in.
>=20
> It is a prototype: the plan is to turn it into a first class 'perf
> stuck' command.  The process name is resolved with pgrep among the
> caller's own processes only, as root an unscoped one would attach gdb
> to the first process of any user with a matching name.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929212246.2532=
021-1-acme@kernel.org?part=3D4

