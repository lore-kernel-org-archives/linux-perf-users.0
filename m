Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E5437266D
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932381; cv=none; b=fY5AxHIyvfxiuQoWjblOGgCAas+mSBFL58xrUhVb8u2VdjyLzFlkIjbGx8eSvKUYBXcnbspuLJFFgG7GgoCunWtBEHtoWFuvhbc51GY1RSEmwykM7DBguLXoIhU59JsZPISNzRmvkvl6KPaiG6vkSGdDmv7kDjhDiTVwmGGQWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932381; c=relaxed/simple;
	bh=LvOLhKmyQxouDV+XI8WT29EApPvqe25rVMIHCLLcNYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jEcSytyg8OBQHXFzcn8IbYCQs4sJ2j9x7t8xcMoizQU8pBGzGknTlvXLw3kfEjrQtoyERRdFetlEFb4ztWxfKAh9Hms2UdHqyIWLk2KPR5gBZlqlX7TN3COpRPNIJ6pRwq08kyzvyFu/F+rFQAZFYacb6MEtf+nITOMYissQ4l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzsgdhR0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzsgdhR0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2DF1F00893;
	Fri,  2 Oct 2026 09:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932379;
	bh=zeKWGlAJL7qZyPWoR3pdUjFH2BLYQ9bjny/AtTlfjrE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dzsgdhR0m8e4WIUdOes/4FNgIqyt71WaicIt1UR7BC6vOoIJPWx61phaoKl0ree+c
	 TNfunEvpR4xiSvbLarvdvDvqDcB9h9LfBfLpxk+VURmfuzPoiF4FElC5WTZ7MbaDFO
	 M0HgapdeAUAEPXoiVZbxpZe0S4tK1arrgszBbyRguOeehirof9PilUZcd4u7mRTZIK
	 OZjzc6naAF+SrgA+Rb0YqOLahHG5EuMiERf2+VBea9OyMrf5jdlADRTPhZ0FQageXq
	 cefmWZ/cISo7hJOoXK4/sY+WKMNllcVaJufemyX4C0Z82XCPzSGYCqLnjJ/IlaWZlQ
	 x1OSP4RXVlTng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] tools: perf: flamegraph.py: fix "Error reading
 report header"
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stephen Brennan" <stephen.s.brennan@oracle.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261001182004.1160406-3-stephen.s.brennan@oracle.com>
References: <20261001182004.1160406-1-stephen.s.brennan@oracle.com>
 <20261001182004.1160406-3-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:12:59 +0000
Message-Id: <20261002091259.8C2DF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When running "perf script flamegraph" in a directory without perf.data,
> the script succeeds but prints out the following error:
>=20
>     # perf script flamegraph -ag -F999 -- sleep 5
>     failed to open perf.data: No such file or directory  (try 'perf recor=
d' first)
>     Error reading report header: Command '['perf', 'report', '--header-on=
ly']' returned non-zero exit status 255.
>     dumping data to flamegraph.html
>=20
> If a "perf.data" file were present in the working directory, then the
> error would not occur, but flamegraph.py would silently include an
> incorrect header as the context for the flamegraph.
>=20
> The issue is with the "-i" option and how it interacts with option
> parsing in the flamegraph-report shell script. Below are the different
> flamegraph-report script calls in recent git history:
> [ ... ]
> what input file perf is processing. The previous commit implements a
> helper for this, so drop the "-i" option entirely and use the helper to
> properly detect the filename.
>=20
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001182004.1160=
406-1-stephen.s.brennan@oracle.com?part=3D2

