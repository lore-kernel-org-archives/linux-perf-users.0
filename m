Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201FE377AA6
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991211; cv=none; b=i2onQnKWnIlAYWhC72d+J4cAniv48Nk27ppxkI7/219UOApUBCZwPF3s+TcT1aPWafpxEnDUBfwibTIE41+1hvIhjpbloOKMcxyaJsthFVY6LowNy7qcFZjHqxf4dt6UgBwMCfved0y4VLFrvJVIYHVHDR2yBkNG7VHaC1J44FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991211; c=relaxed/simple;
	bh=tgNo0efBBWDyH4X+ydIyvtI/yu6VN3xeo4qoDmS5CzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UOpYerCBDTu+169qEmCcyN7pUobbDrNcCmAC5PEiUuXNylGLZ56VFim+eQ3NwpIh3/h/M90nNsYsk9mXU4dksLMIAngYqPOYN/AN+GY3eu9N71PxDReBOnlVm4O91GttTp6EbHL9mLWxfwqwW2ShbSzwFErkWSdYuvz7p75ItA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgtwy9Hw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgtwy9Hw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14171F00899;
	Sat,  3 Oct 2026 01:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991210;
	bh=tgNo0efBBWDyH4X+ydIyvtI/yu6VN3xeo4qoDmS5CzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kgtwy9HwQnrVID2UA0+6RToPpb2/XKOlsKsR4o4/9yiL1XE2cEqXU8QNBCxiWd3fk
	 7I91p9sPmfUbLgIJbBJZMvH+6HbO9+dWET/kmzWbgWZnhvtAepDUrchnTvoVQF7rnA
	 1OzfFqV3dbI/H0Ikaz7pbFcw/FPdC78dZgXlmKbzcY/s3ciC8UmOmwH8W1VDFUX6ou
	 q3Z/3DMw5vVAm4RJXqWyB6ovmTGLfEF8SQFd3ODynxx7yX2yQSzqvkZn4jQEK1+6w2
	 1Y/kN60pVFm8e407E8Ws8tYuVYS0yuQzPzjyWZZvayKfvly3lVGbqjW4XQc39nfFQU
	 Au0A9teaWGj/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/13] perf list: Add a --tui option to launch ilist
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002182624.3259797-7-irogers@google.com>
References: <20261002182624.3259797-1-irogers@google.com>
 <20261002182624.3259797-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:29 +0000
Message-Id: <20261003013329.D14171F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add a --tui option to perf list that launches the textual based ilist
> script through perf script, similar to perf timechart --tui. Rather
> than printing the events, the PMUs, events and metrics can be browsed
> interactively and the selected event or metric is counted on each CPU.
> Arguments after '--' are passed to the script.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002182624.3259=
797-1-irogers@google.com?part=3D6

