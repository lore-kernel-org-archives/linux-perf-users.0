Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622233;
	b=fWFnnOTC2yMWBtAUxs95ShuIShUSmSXcDV3NSLidY4GElqQYqJgZodj1o4oBHHaZOOqY
	 QlhBbKtjENqhyXNOQF3RgSoWVGW/mIxkFZ2N6wqLa5crk4XYOzuHs+OATPC19DzO9uYVr
	 GWcVfXjDGMIIrMLvxxHKP2CEkhjsWOlRJpnTtgTJ168ru9U0G+cOMpcmRUZANKAuEOTm5
	 L56oPWzCdeIm+JJkuNsVsqc7IyXT+UZ7ojeHKKc4yeLWP3tHLDdPyvkm6xSsp/+WLZbeb
	 RE2jP3V1TSltjXlKSTgHAMoOsCh6ymSdpmnb+lsLP3hCz0KifdmYrndDQbkc+njm38A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622233;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n7O3ID8M3vqY4O+vWH31IL2uctc8quS4jGoeO5KphlI=;
	b=T1U3Znc1jxF6PYWqxQ5Mqac8SiaIhLqup75Thhavg67v7/JLssArhlhhdBqpj3h0Yp4H
	 eUuDbwo9NwNiPyO8dy99ox/pc7M7qvD5mfs8ZCgT4uy0hNyxUDWwMTRYAml2r+/K8ZcZD
	 j0dkk5Q6llJlcc56Dwg4/uoztl3mAXNaA3ZahI0+oatC1OoTTprVGh+44NGzRDNp2oHBu
	 d/LC36/UjSU96TLmuTuLR5/L666Iww95Ee8OzVYR2QXdVvblQTTfsM9beOJD8Jqp8ry8v
	 58w3DgXyM7iHnSjnWWVkf6o90N+vO72Xqk1PosJp27Xqiu1/gqQvCx0Pd9JJgtp8rHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZBHnY6+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E84A606A32D
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZBHnY6+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19841F00A16;
	Mon,  2 Nov 2026 12:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622232;
	bh=n7O3ID8M3vqY4O+vWH31IL2uctc8quS4jGoeO5KphlI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jZBHnY6+OUVmAByiv3SG0vWuIcnJLRl+iNcsyZRr4YFl/uvlbHsnEG3PXvdrNkQE5
	 ioe/HfiynStrAMQO0dLrxzquoJLQISi6aOe9V/rrCvE/OTVKytTJXLNhSc/LcUNeuE
	 YTCEdX+0ZnDSQkFxQwK4d63Eros2Pb6IbrOFnPPqbjrRnUVXkM5yej7SPZ+YLBxnfG
	 UhJ5vYBNJZts3Q46ATvcEdcZBnEW+5kp1PVqo9AXT61/ND+SYZMzzAmemwFc+UtEg6
	 jAyqAgoJPt+MFQ2lGchxvoZzjAyXUZGmHzGH7cBk3vtwZMNIH9F36Rn6t99u337OYe
	 ryJgRxVNq9uWw==
Message-ID: <sashiko-outbox-193394@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/18] perf arm-spe: Use generic snapshot search
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-11-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-11-dbcb0c281b9b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:23:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The new generic snapshot search gives a similar result as the
> reimplemented version of it here. One slight difference is in the
> pointer fixup. SPE has:
>=20
>   *head +=3D mm->len;
>   *old =3D *head - mm->len;
>=20
> Which gives exactly the same result but written in reverse order to the
> generic one:
>=20
>   *old =3D *head;
>   *head +=3D mm->len;
>=20
> SPE also had a special fixup cases (if (head >=3D buffer_size)):
>=20
> [ ... ]
> [head..mm->len] contains zero data. This should be fine, as zero data
> are treated as PAD packets and discarded during decoding.
>=20
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-james-cs-u=
nformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org?part=3D11

