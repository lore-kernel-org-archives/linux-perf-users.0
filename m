Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01291D7E5C
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 02:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789267384; cv=none; b=SJdGoZ2aZTdsE8/pBvOrZBW+ZEtx+qTycbjM5bAZz1Ht54awzB4bN6a/mWvqGHt6zSpZuujwbwenO4JTqUTDEHOcOyVIyBvjO+tKp8Ig5qxn57WHKVHsWde+ogJEyYF+/mjYoD7/qzuxFYeg0qnkd4pHczqV0RClNSoCpDhvPXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789267384; c=relaxed/simple;
	bh=or6BroKKbyLf2rtvl4A0VcQ/4Hv43Fi1xsZedL3NYBU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rfEPqo+AlN/87S7TCywzXfWYfTa3RO05KxgP2q2XOXqmEgGYbV4OCAoRlVdPfm2/xg7QDPuGFpPrIR2zr+6FnIPQzrRGsQtIlCT8YO8fB9W9vRRzbZDSPuElZYJlZTtDjTx0GkCVLV3bVb+lKnOQnlpjfYjrVP0CqWvxOALYV88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwg/ZCcG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwg/ZCcG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627251F000FF;
	Sun, 13 Sep 2026 02:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789267382;
	bh=zUMC1XpIRzr/hqL3799DiaGDETWqko7jEenz1qCrzNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iwg/ZCcG55Xf3WSExLiIm9QzIwVA8QGuhUwRATCEb1W9l/1bv40GrVwL6ByHzkELd
	 VTLXQjW8D+z1CnOTbJ//el8aPKWP8sjMhGRLQgxuQWHumiCv9b5mFO4ClRQjSH2Ss1
	 Tums7+ARyuuNOPUf50RcmK9o0u/eG+bwya/WVwXtynEsLpw95F3exnA8gYHegHuvtx
	 G3RZsP/MNNoJPW+djIFSyo/4ji0VOr+SkmgDWoPWb9/WNO8FO3SNtiAY236ON92Dkl
	 jMXgM7Ne4EXQMDmA1lbhjqtcF64aeCpopNFQx+8VE7hVYOR8V88M2TqFQQevO3cbEp
	 ijEw538AZ3IKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/8] perf symbol: Fall back to fetching the vmlinux
 by build ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913023459.112654-4-acme@kernel.org>
References: <20260913023459.112654-1-acme@kernel.org>
 <20260913023459.112654-4-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 02:43:01 +0000
Message-Id: <20260913024302.627251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> A profile recorded on a kernel that is no longer installed, be it
> because the machine was rebooted into a new kernel or because the
> profile is being processed on another machine, can't have its kernel
> symbols resolved: /proc/kallsyms matches the running kernel, not the
> one in the profile, and is refused when restricted, e.g. with
> kernel.perf_event_paranoid > 1, while the build-id cache may carry
> just a kallsyms copy with zeroed addresses.  With no kernel symbols
> the kernel samples can't be annotated, so they all end up in the
> '(unknown)' data type and the kernel is missing from the data type
> profile JSON "dsos" entry.
>=20
> As a last resort, when the kernel symbols can't be found locally and
> the user didn't specify a kallsyms file, fetch the vmlinux keyed by
> [ ... ]
> struct tty_struct, struct qspinlock, etc, with the kernel DSO, keyed
> by its build ID, appearing in the data type profile JSON.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913023459.1126=
54-1-acme@kernel.org?part=3D3

