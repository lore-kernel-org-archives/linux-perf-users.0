Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8B0331EC4
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 13:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782826030; cv=none; b=h3wtalXPXmo+WChwYlO1UXLu9Lf+/HlnkEkxozX/DOet7il1wAodJTHGQSCA7N6yk/X7vuLbqXvNro/X2ZSDEQ2baMwYHd2gIIIGmT6sDGhs5V0aHWY+0WBb9JLCjvullGtBOtEkSA7CCXyNdtkAeCw//Bi8qtm3Sj+PL0SCuhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782826030; c=relaxed/simple;
	bh=JR0hGwTifJi23hQUsyAsADVEClBXYGGkf9VvR/h2S04=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nXzm9mdq4Y8Vgvf2nPnRp1xYwQPczwzJwKiBiwiGe7l6vV51G8SxL86ACpCq0UdPX51WU0xA7Tdq3RHhTY1NqKhftT7Rm5xehwMMBKoNnHJJBb66ZxSkfIdf4hk7jNDNA/VViX4zJGKeKqvPkEo2mv2n1WKPGPm+qCnTrhuna/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMXfYWgi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMXfYWgi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141751F01559;
	Tue, 30 Jun 2026 13:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782826029;
	bh=DU/Bw85yAGRkAgKfd7D4X6rowR2P8Ik/CFIUjc+ErJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aMXfYWgippeT+COL4lV6VHLJOEXSbyoSwbYU+9535qaA1cWD6ijJwGS0qxvzDE4WX
	 QBtxzmh+UmcqoDp4tGUyykhCDA3lhgZLG6cp68IFKBXbHYtAlBl8IIuEeY037mh1+T
	 aRqiw9dUdF7ozjUGBgneXQE3Oq/NST62khW7JGeVZk7WA8sv2gx7v9I1SlynMEV0FJ
	 miuXjlX6ySJCFGIMEaK9veeqXlKJqBZFY9vnm8g5GLL/RR/vT8hpn0oibfS3Z8Hctj
	 urnTo6r3KRFtsWkUTu1acdenuXF9PGPdZTlAwAA4XVZZ+pvQF2svCxtwTm459a5llJ
	 Be0Ns4wz4rEOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] perf/arm-cmn: Add workarounds for CMN-S3 on
 Graviton5
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <e9340d3a4385e6f1a6e80bda944a3ba6435472b6.1782824005.git.robin.murphy@arm.com>
References: <cover.1782824005.git.robin.murphy@arm.com>
 <e9340d3a4385e6f1a6e80bda944a3ba6435472b6.1782824005.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 13:27:08 +0000
Message-Id: <20260630132709.141751F01559@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The Graviton5 workaround sets the DTC node's logical ID to the X=
P's mesh logical ID instead of the DTC domain ID, which can cross-wire PMU =
event routing.
--

commit d22a8571a1d86b4f3c00bde161d5fb2ce99fe43f
Author: Aviv Bakal <avivb@amazon.com>

perf/arm-cmn: Add workarounds for CMN-S3 on Graviton5

This patch adds workarounds for the CMN-S3 implementation on Graviton5,
which reports zeroed fields in discovery registers. It introduces an ACPI
HID for identification, derives the DTC domain from the XP node ID, and
sets the DTC logical ID from the XP's logical ID.

> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
[ ... ]
> @@ -2475,6 +2500,10 @@ static int arm_cmn_discover(struct arm_cmn *cmn, u=
nsigned int rgn_offset)
> =20
>  			switch (dn->type) {
>  			case CMN_TYPE_DTC:
> +				if (graviton5_workaround) {
> +					/* Node info logical ID is zeroed; use the XP's */
> +					dn->logid =3D xp->logid;

[Severity: Medium]
Does this code assign the host XP's mesh logical ID to the DTC node instead
of the computed domain ID (xp->dtc)?

If the DTC nodes' mesh logical IDs do not sort into the exact same order
as their domain IDs, will the array indices be cross-wired, potentially
misrouting PMU events?

Event configuration looks up the cmn->dtc[] array using the node's domain
ID (dn->dtc).

Could this instead be dn->logid =3D xp->dtc; to restore the correct semantic
meaning of a DTC's logical ID as its domain index?

> +				}
>  				cmn->num_dtcs++;
>  				dn++;
>  				break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782824005.gi=
t.robin.murphy@arm.com?part=3D2
