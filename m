Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B18947141A
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932393; cv=none; b=mry1GChQClo6Jar/8WJC1gSAxiAUnDk7FbLeSJBTGk7d87Y24Q6jVSKSJSSe1mPcLTi2moSkCpzrAmAOxEcfHulTQ6/zTEnTWMWNT8tHFfBHO4hhylWHNXuzS8VBWJZurDyQ23tAizrWQ/SsMex7hikX42YYyKeX8qdyCWZU1Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932393; c=relaxed/simple;
	bh=rsiUwyq6tj78RwPudkwxPntBxnlvwnmBeGzPxIsQ0LM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=azM/0GSobYQqubME7bqnQwwV1Hjz6+UQ0SA9VdAt4x0+SRHMWEoPKC9yzQADdUWHLZrJ5jH+lItbzoEwxYOh/uKbMkC764bphbEVY4kQ9eNXBykh/gwVLAnZ8oN2g4SaaIr3NUiTgs1y3dw4WI+SGqRm0BPPcrGs9icVB+4/Hr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcIu4Ra5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcIu4Ra5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230B81F00893;
	Fri,  2 Oct 2026 09:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932392;
	bh=oazEZDcb08jNmSd6C+QJlMo1jw04QuRJ+eNYhu9KFk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IcIu4Ra5gWkekO3iAoVUFLOLIDaH+h4zY5DVhr+tMG2Xr6UQ+HHfJKvXOMOGlon4V
	 QiqiMcwx2ZR+GAJ79bKoqHGqI3wQyoM8RsWZv53swgNjaCBtkStzUd3bXhQx02Mwu/
	 G6VqyQX27BT+8SRc2262uurSZBInywOtjhVDwSqV3b9uYhLmaFO3mGgB6f6GA8VnMh
	 DF5tt/FiM2Ij2PE5/4dC48BQfDucRibYe/QwsCyNzjiYlYWK0oJrijqZ8DASyopspQ
	 qR5FXXb7KMZjRPuj0e7cx45QgenjY6tZKhmRBc1kRQVLsN7/055Ld5Co7s4Euej35Y
	 l2+3WvFJO5JOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/9] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001185400.2754753-7-acme@kernel.org>
References: <20261001185400.2754753-1-acme@kernel.org>
 <20261001185400.2754753-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:11 +0000
Message-Id: <20261002091312.230B81F00893@smtp.kernel.org>
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
>   Processing events... [ 42.3%] 317M / 746M
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001185400.2754=
753-1-acme@kernel.org?part=3D6

