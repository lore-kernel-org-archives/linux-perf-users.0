Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0C31D757
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790575106; cv=none; b=m9wXOmEv5BITP4Hj1N2HFGVz6cuwyBrBU3IKxhzhDou246bPFDugxJqP7xWrC8A1cDuSV6X4BGnp1yN22ZqAgdcSU4zbPtyX7N3abkEhs1dXVgX+KwbJSRUoVGat+MF0aMAtj8WH6H1FaXrKUjrje0wXigIHSM8lu1RfWWECBrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790575106; c=relaxed/simple;
	bh=ZnDeX5SGGZbxG7NeWGdgqTv4j9XN6Al+zP1eNHV23W8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cRMJBqeRCL0K7qn0xrA4ygHSBJsegnXPZMmGSQXkN+mCHu5W3AIs5fZVffG25mVbsOgF7Q69wqEwpFay+fBE8GSrw0zbMVr+aZee2DWNwmP7nDWyh5J4o99J4l8r7t+k7ogerlFPJoCqmWpvdW2eQ61u7dNmZAbvSjq9OtUOuzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLOnIRfo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLOnIRfo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE621F000FF;
	Mon, 28 Sep 2026 05:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790575104;
	bh=ZnDeX5SGGZbxG7NeWGdgqTv4j9XN6Al+zP1eNHV23W8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bLOnIRfotbuNcQgL3PYOAk8bdcQbKyho5P03rttcIuysKInXzNvHlUpXR72En8loV
	 T4pLV1J9urz7qkbESa7yqn0mqunQYpfn4oOS/JaMlAULkPAUEnICzXdNkCT6LFJ984
	 eLD+N9KOGmg7kuGOY0w3r332q6Z4J2AzNt1WViBMgZ2zmy1qkYMbWS+CtLiwgTHrKZ
	 3rIxW8BAUHWYl/D1Bm3Z9qQXZLDg0jr07WiZs+gFG7SlahrdYb6m8dltCGDclKBKio
	 0GSHaDbc2mJUHMpGapQiDidHbiYpHUvJbRhFj6+r7bpYFVy32H2qnHYXA+K2rj6OcY
	 Z3LtpXqnonzZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/8] perf tools: Factor out dso__find_dbginfo_type()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928055055.95144-3-namhyung@kernel.org>
References: <20260928055055.95144-1-namhyung@kernel.org>
 <20260928055055.95144-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 05:58:24 +0000
Message-Id: <20260928055824.9BE621F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> It tries to find a file with working debug info by checking all possible
> debug types.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928055055.9514=
4-1-namhyung@kernel.org?part=3D2

