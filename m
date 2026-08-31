Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C6236E47E
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207598; cv=none; b=RfzBENee6WS5GkdaNT9tbw142+2cMEjCC001PqIAWJOCYKviW3L1DQqYkqUU+W0K2Rfk9K55b8YZ6VG+eWpYkO4KgfqRqcrN6Kj/WMPeltLuQN7ZQSK0jidAdT3MxIZquFMw9glDW3mouALfDkRXv4eEDC34quGuxL+yMhhyNVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207598; c=relaxed/simple;
	bh=JvY9PXDdMKiOhyYZ293K73i0n5hvRmJFl8EBbnm7bjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LGMgaMclvRDIDM9aodUNnGkHhx6WYenJQ/QeQpq3hP2+SLcGZuKQ2obE60j2YCPmq1lOd5kLxLV5sTrJlsGZFnQOGS+xY6+57+8NoDDNZ+9ii2cKOv1YEoXnw+dAWZhP4EtNF4p5GkZlubn/FYGILdh6bfNsWdIgkzz8/Fycg0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTNYU57G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTNYU57G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBCE1F000E9;
	Mon, 31 Aug 2026 20:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788207597;
	bh=JvY9PXDdMKiOhyYZ293K73i0n5hvRmJFl8EBbnm7bjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dTNYU57GtvRsUiywatFrAS9jjOiaC5RKzFZei3Pf8Kp+uixyq6p99k96StyIWv0TQ
	 KDViAzh0RFfi1KMZAXQtxOtDvHxqs1gikTl0B8Q9d8FVI3iTVA/9zuDpiKBsWhkZbR
	 DyqGZxhVio+0PLPb4nvEQKgs8Cyd7zJ6YmOmiTGIsY2X/XErWjYFwxjLPKbSXFuHDx
	 M7b5tIR0UtpPsLS5vGjNR/D55mHK0yD5YdBXbze9O9xvyrIjwkEguCu9qRKHoO/620
	 c2v8AhDdRQP347MfYtf4/IdWmlPBrYHF4e6r6TtjyiGwgJVaE8ltf6SqzG8gdh7Z46
	 1GhF0NuFjhlcw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v1 12/19] ptwrite uprobes: Add pacing to the probes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831150651.1134594-13-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-13-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:19:56 +0000
Message-Id: <20260831201956.DBBCE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When PTWRITEs are too tightly spaced they can lose data. While the decoder
> makes some effort to recover from this it can be still annoying for the
> user. This patch adds LFENCEs between the individual instructions to
> mimimize (mostly avoid) this problem. It can still happen with parallel
> branch collection or if a high frequency of timing packets are configured.
> The extend also depends on the core-type.
>=20
> It can be still disabled with %nopace. This is useful when the user knows
> the probes are not too tightly spaced. It is usually still needed
> with many arguments.
>=20
> This patch generates LFENCEs for the probes unless disabled.
>=20
> Compared with %nopace, default pacing increases probe cost by roughly 272%
> with PT off, 227% with full tracing, and 48% in snapshot mode on Alder La=
ke.
>=20
> Assisted-by: omp:gpt-5.6-luna
> Signed-off-by: Andi Kleen <ak@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150651.1134=
594-1-ak@kernel.org?part=3D12

