Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166DD3806D7
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 02:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789610619; cv=none; b=cBi9/rZ3FpiX5+cR2lFFcdTtsqNh0gC72Rhf8XLc5MK2fD7r+U9TrlW4yNoaTK3YQ2wC+opy3gq7WAzKIoRmm/8bJUgqO+zM9rYhVr5ZGhM2kzfeP+QpYWE5o9bsBnQ5pKDUWD4gDVfNq6ujjS54spF0djsfni2rfKwDSWetGLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789610619; c=relaxed/simple;
	bh=rNKMur3c+BT8xdMuIYaD+oDPlZEy0vQSBC+uCScZGow=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XOMoxyDX8y1kW7ewd9bLTc/CnCV6E2HOzZSjT2KzJuhW44cZYpcBRyaYFEb9ndKBE9jvrvyGYZnbgDTFMbyIlJnC+4Z7ZXBqLXg2FqRJtfK1Wth4T4VJ/wsl0IwgCMU7nC/3N2AB03/AE4qVPmdGLcrrI/a6R3Lj/hj3BGHRs4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpqwF+ML; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpqwF+ML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3A81F000FF;
	Thu, 17 Sep 2026 02:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789610616;
	bh=rNKMur3c+BT8xdMuIYaD+oDPlZEy0vQSBC+uCScZGow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hpqwF+MLy/4WCqYIcuH01y6TRuTzdww1EjDUEFqxgjUsQNSdnPE4n9eJFgFBoWrEx
	 yKZ8ovsHvxHduMP9hpdo3wdzbZwdEg/se7EK6Y1QsrNRmYR8gA7BQGBfhFEEiSSk2X
	 9TkHTvTP/PuDe2LTXmxYaGBWsJndEks0rrozHlR87uSp4xfQoXITqdILnJzf7418ZS
	 WXkuOjZj8filv/3HFaBnlzFgkxoQAGlwjfGlaT5P+fnXMUj4pDu3lgg7pJTjX6x43Y
	 RB5EDHnj7sSInSlC5dNgrA9otzBlxh95ljhUOon8xl3aGg1BxS57eTD50dVN/8uOL8
	 B+q5BZooogS/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/12] perf/x86/intel: Constrain PantherCove
 UOPS_DISPATCHED events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917015234.981153-10-dapeng1.mi@linux.intel.com>
References: <20260917015234.981153-1-dapeng1.mi@linux.intel.com>
 <20260917015234.981153-10-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 02:03:35 +0000
Message-Id: <20260917020336.0B3A81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Per the latest PantherCove event definitions, the following events are
> only supported on PMCs 0-3:
> - UOPS_DISPATCHED.INT_EU_ALL (0x1b2)
> - UOPS_DISPATCHED.ALU (0x2b2)
>=20
> Add explicit event constraints for these two events so scheduling does
> not place them on unsupported counters.
>=20
> Fixes: d345b6bb8860 ("perf/x86/intel: Add core PMU support for DMR")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917015234.9811=
53-1-dapeng1.mi@linux.intel.com?part=3D9

