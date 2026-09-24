Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0753DE448
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228633; cv=none; b=Xmyl+sBJG0EGNdEqV0gWi9MVP+yvbbs8MNUAkkFYkkqKFhe8Xmt6F2r5HKnkmyxxOGMOuRuH53hqYhhJySRXnsamkS23hzJ5Bf97cvvJIAvDO+ORDSkhNTdO9GTp6k7RKOcF9vP73Lj1pwB/R3LY286PqJrbOA6kPBK8wXzGfrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228633; c=relaxed/simple;
	bh=JGcrkKoEYv+YsSjyYznxNMhLhQunOTBH9n4Av9iSFQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nB5CQAUs+/vFGIHNfQZiLOCC3BLmx4x+UkjUbMfkhTFUchTzbbZBFz+ROOJzGPBZQ9GEL6S7h18ja+0eWX3LxvLLER9dthPU7SXj7Yh1HgTboY+Z2jJ4GOk6j09KHy0aA95NhOT4IrhMaXrS1e1PHhgupgW+HrBscLRn//qN36c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2Z8+atR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2Z8+atR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF9C1F000FF;
	Thu, 24 Sep 2026 05:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228632;
	bh=jruzLkwOMgpU4+f7AI6jsO2xWSyIE732RIOOYcUXfZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K2Z8+atREBYUYr9ZvO/CNIxitIp+drzY0v7rBO7RJZwkXu71nt2KlPvwRkUPoUAXI
	 rr5P/rykB16JAGPYPQsHnZHGz1Up+hyBNkMWAZQeshlxy7x6dqlh8AhIlAXuAWgqy1
	 90/vGcPFungJCpvtriJdlszKrJ5ac18KFHWnsyDYPUEaAv3I0LxX0RrXz7jSM7hICE
	 /2uWFKnmPVkfeWwrp3SQurn7QFkWepsJq7ODrO9C69nean41jfnoSqnGRL5YyaKA59
	 CLvXOssi4nv4raKJNah0vwhGR/8GdFWL+Xo8v6VDIGytqoJMlnoaKN+rntF/LTj1AO
	 buVFhQjppEh6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/21] perf vendor events intel: Update icelake
 events to 1.25 and TMA metrics to 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-10-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:43:51 +0000
Message-Id: <20260924054351.7BF9C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/f66167560acda5c49b55e8cec9db95e=
e785f2ecb
>=20
> The updated TMA 5.2 metrics were published in:
>=20
>   https://github.com/intel/perfmon/commit/f9358e8da04bec945d8023e3f9b20a8=
87ad46c45
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D9

