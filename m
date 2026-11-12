Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515647;
	b=RaQQGtWca9lQFufT6lwjUzWZk84zuXFOwghvu4Ig2mxmnbWXMXAYy7sk/ua32zW2V6Rn
	 xb8TEFhMb/m4XjkbSCQRRVAK6lz9/jp014F+8+aUhO7f6IfJZySLH7sxtHVhqvjTg93Gr
	 5fNeWE8LXUObCrTjS9e22UoDPq7k7eyUf/w3WKb2+wg/g8O8mf3qwqw7suLtWtRPZsVD4
	 oTu/gy9II/vEjESlG0XLkjAaN5mWV0VKMdeivIrANuFlaBZBVGmxYUBUVRKebRoVrgGXV
	 XYOX+a94N8YT48iZkgGDiD5qouCq658YShCOcGxjzdiELOw4+uf+BBGd3Nl5pga/IuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515647;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PQNfdKOGJm//bGRyI2DZFVP4wxqul1kQP8Nxz6tnddk=;
	b=jKU12KHqVRMb3rZ/fBx8kil749c/KsQVqOy+vCXaRta4VPfH1uIDfJK62zUrMZVDEIPt
	 jWaEoQSeipY4/FzMrkP5NeVRRcS03TA9k1UtYnj+/K4sIryODGTonQ+ry1ZDgrhrGQyV7
	 sSFV66PEz6oLEcy6t867/cYxpiiNBFdKdT/tRB4Rkw9x1/Z0mtipOO9FBrw0fXewPTmXW
	 dmAo7tUwsMsEHXeJSQhvpc1qTiNBHmRgxAcPU9vAlBApBGB5K+SZIfZo29/QU6LVuMKfy
	 mPLqshOkxij1R9Uk5Zsio1Rt6dWHw+N2GJdpPwJZir1jlM+HPK3wphmwmZLA8+1E5ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZgKGDHxH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DD0606A32E
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2026 20:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZgKGDHxH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685661F000C4;
	Thu, 12 Nov 2026 20:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794515647;
	bh=PQNfdKOGJm//bGRyI2DZFVP4wxqul1kQP8Nxz6tnddk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ZgKGDHxHNWXHa8iprmNZ2/lqhIaBdgd/KeAxyoU9JutUT4URk6D2AYVJCh3RCMPMH
	 BNbsslXRYWcyARerplzitZ0F4nFyKURD1dw8EmpKZmit7TChvkp3lRsypDIlimscRI
	 dGG48TLqA1RM9shTpqmE9AGHVEvFpkeej55m1QZpUjKAylD9V5Mo39LIrk1u8lb51Z
	 6PZguhve4qcSDI8KTL0PhSeVNQ4VgAsuWrhlLjtDyaku+7Ysz5rsJSyA4rQXsvKFTe
	 gCdm/8cL4qJNlzWGW947nE+7YV2EVnwniUJ43axL+XfhnDER9NdFPHRNVDUfScyjVF
	 pMQ6pDQfnZU7A==
Message-ID: <sashiko-outbox-211795@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] perf docs: build only the declared manual section
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?T1JUT0xBIFJhcGhhw6ts?= <raphael.ortola@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <CACzNvX6qkkd-QgJzcQquHS6XiKacMqb85JeLC8LmfLTeWqu4EQ@mail.gmail.com>
References: <CACzNvX6qkkd-QgJzcQquHS6XiKacMqb85JeLC8LmfLTeWqu4EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 20:34:07 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] perf docs: missing Signed-off-by trailer in commit message
- [Low] perf docs: missing Fixes trailers for multi-target manpage build
  rules
--

commit bfd2c7c72bce033b21098d6070bc47bebfe6a33c
Author: ORTOLA Rapha=C3=ABl <raphael.ortola@gmail.com>

> perf docs: build only the declared manual section
>
> Hello,
>
> While building Ubuntu linux 7.3.0-9.9, GNU make 4.4.1 reports that the
> perf manual rules do not update their .5 and .7 peer targets. The
> implicit multi-target rules promise all three sections for each input,
> whereas XMLto and Asciidoctor emit the section declared by that input.
>
> The proposed change uses the existing DOC_MAN1/DOC_MAN5/DOC_MAN7 lists
> with static pattern prerequisites and one recipe per backend. The
> shared asciidoc.conf prerequisite is moved after those rules so that
> $< remains the manual input rather than the configuration file.
> USE_ASCIIDOCTOR selects the two alternative backends.
>
> Checks on this downstream source:
> - Before: the native XMLto build reports missing .5/.7 peer targets.
> - After: all 41 native XMLto manuals build without warnings.
> - Additional section 5 and 7 fixture manuals build with XMLto.
> - Asciidoctor 2.0.26 with Ruby 3.3.8 generates section 1, 5 and 7
> fixture manuals without warnings, using explicit ASCIIDOC_EXTRA
> backend flags.
>
> This is an RFC for the documentation rules; it is not a claim of a
> completed kernel build or testing on current upstream master. Please
> review the proposed fix below.

[Severity: High]
The commit message is missing a Signed-off-by: trailer, which is required
under Documentation/process/submitting-patches.rst before a patch can be
applied.  Also, the greeting and RFC note should go below the ---
separator so they do not end up in the permanent git changelog.

[Severity: Low]
Since this fixes the multi-target implicit rules for XMLto and
Asciidoctor, should it include Fixes: trailers for the commits that
introduced them?

  Fixes: c1c2365acf8c ("perf_counter tools: Generate per command manpages (=
and pdf/html, etc.)")
  Fixes: ffef80ecf89f ("perf Documentation: Support for asciidoctor")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CACzNvX6qkkd-QgJzcQ=
quHS6XiKacMqb85JeLC8LmfLTeWqu4EQ@mail.gmail.com?part=3D1
