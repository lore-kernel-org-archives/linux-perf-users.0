Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A58F3A8FEE
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263518; cv=none; b=Kzue0kGZeMdvk9OkbluvsuVJjH7u552VJ9RcD3vBeKcV9tRaJZj78CgE3nbwVEfXdPApB95C4AXN7gmLTQ7EKfi1k87WRiHtygCky/JHzfFH4vtoBywSOD620NvDFf3HN7g1TfExr3EkdrjPRkzwLkoppQY1OkYOSbKciejp1GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263518; c=relaxed/simple;
	bh=+iM47PDW/a2tBD9ygJjm9IJbMewF+I1XrXvmuTvjwao=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=jLJWlvrMH+W2t1zkakxTtSYllYXrZXEEltvlyfgJ6UMMRxpLOauUZzNjBqUaSH0XGPsjGCI0zh9MG9AmuuFvXQxP/ZkrVLmd2meBf4NdlULlYzXgqdL6DwVpcUjPYxndtO22XQwHTrbJN8eWQUPfF4DLP9IzvSb9FOO3MYqYAfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2/Mdkrk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2/Mdkrk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B5C1F000C4;
	Sat, 17 Oct 2026 18:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792263516;
	bh=+iM47PDW/a2tBD9ygJjm9IJbMewF+I1XrXvmuTvjwao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K2/MdkrkyOtibzxiX6efRyhiXC6622q5ghJbBC9DSEHGafFBfNuqE63qFy09su/hR
	 XP3Y3UK5luWKGBjelaptFKIeir+uHLWBSD6skMyvySdOzJUEHvkZJHH5zvKw40Sy9t
	 sDJ10cc8yg+zQQEYJYHGlaWY1+dA5I0LMvUnbyFq/nAQSXQQ9I3xLKvxft/gXWxeNB
	 OaWAgtWRHiqKAimxybxzJzFvE4kLnEEUdWIm9L/PqMKeYHNEY8gTZb0yTQ3xyF+47b
	 9Nt4EgGlGZQ59wB+DE93ggZsNowVeU+WeJAkmtuhGAVz5SC6rpYZNzdW2R5p2lMFaK
	 wBKJMVyoN0eKQ==
Message-ID: <sashiko-outbox-175769@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 9/9] perf test: Add perf sysinfo shell test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017185442.2137623-10-irogers@google.com>
References: <20261016213258.945737-1-irogers@google.com>
 <20261017185442.2137623-1-irogers@google.com>
 <20261017185442.2137623-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 18:58:36 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Add a shell test exercising default 'perf sysinfo' summary output,
> '--pmus' per-PMU output, '-j' JSON validation, PMU glob filtering, and
> '-i perf.data' inspection.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017185442.2137=
623-1-irogers@google.com?part=3D9

