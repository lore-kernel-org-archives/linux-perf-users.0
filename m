Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63F4AA575
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269868; cv=none; b=rqHFOcbbFNc699gCYA+UgVi/mxVF44aCiFtoWmCn+2v7mS4DEaIVo8pYFGVslYidXw58SCBZXqRr1gRfU12kuS4k9PLQ7a9q4eBArz0fpSTDPJCrKIjUbUs0AZPBzRa1PZY6hD6QKpvN0Lw3I3A6wpOxGolFTYQsBKDGfXKHz/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269868; c=relaxed/simple;
	bh=zt6GyvHUxBgfvd6kzuK7NcchIHmJy5MjVph3va1Smgw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hWiO6U9XPdEBnPt+zXuGHWFot3arwiNOEnohxddxpE1hOxB03kYqHlh9ZagD2k9aGaRZFTjau6ZuNl5szmluGP6BOYDvpxqhy6/AkLMEj1FLdJw7g1AYoWqu7jtFUwhwmP+HeaIVW+M760bpFriWfIvNVsRXq6QdXDZG1SzxZ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AA/K7Acj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AA/K7Acj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABDE1F000FF;
	Thu, 24 Sep 2026 17:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269867;
	bh=7cVFQK6BwQNz577VV/z5u3yeHYQ06bNHmqm5aZD54xc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AA/K7Acjt30ec0iEW4oYoepzTnI9+zxaDGd34Ac8YLySdJXXEk767YlDMtCgGk+Xe
	 Xu7+AgOeBEDreZL2fgKnONp+UcDlOBPk48qtKkyNayLmctlItIPDNBUMkrdb7lQTVG
	 oiarjj3GQf3gc4hueoJB85IKAo25IAvYgB1ZSRgg7szR5ySeiY5nAW0WBxYQgbySVi
	 IS1WlCpUbUO9rtzhD8kNcXh5VlXYbc535Hw/CxLTXvZqom/R4V7dFlwTwqKwHCRCm7
	 s6MEI9Z+LMnIAwcLc6mOfCnX8XzVIFZ98T5JtEls+2weyMTJ5NQv2QYuat9E2RAC4d
	 anteoOwNX7cHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 21/26] perf vendor events intel: Update tigerlake
 events to 1.20 and TMA metrics to 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-22-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-22-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:11:06 +0000
Message-Id: <20260924171107.2ABDE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated events were published in:
>=20
>   https://github.com/intel/perfmon/commit/228a83d851e8908aa09fac00a96a694=
04f2d3107
>=20
> The updated TMA 5.2 metrics were published in:
>=20
>   https://github.com/intel/perfmon/commit/f9358e8da04bec945d8023e3f9b20a8=
87ad46c45
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D21

