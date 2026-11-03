Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672814;
	b=gTQEHEHmcE6rLZmpHa4GxJCj8YtQzx9rOU55EzXv38QppvhlHKryFYLwZATYbrhq/5Or
	 gH3tkanS+YuZgWd/YDTlGWgq7gILau9UI8BxZ7vc6f4WVGiilfy3xWBa4YNsC8m+D21/y
	 fOZSW+kF5UDkbeYkdOrfj8BgtopcpRB82NZoVGY9iNaG+ELxHHL1xVwn17mnEGYh0/TP+
	 zYcDqHUQoofMTAUZv8ZY0yRCVXU7uLQqSTGT2wVuPu10+Qpq+20oqnVzfVGp1+Kx3bQKq
	 lzezfGq1606fW2RZMZ2PYTHr2zyLo2rD1dl445QjRwW+/0RAFaqcMrOCKvI9ilGc91g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672814;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pwb6JLLpCEVR88W/B1iVG0CiQ4Vpf1j5sJTjt4xv0+4=;
	b=cAm0azlUr5VOPtSBMAa1dixJGNlIdE4vgygeF0ucfIchqGf5TL/w+wLVD2v+Eanf95a6
	 Qe3QrihmHKunHk1fU3KrBZsG5CfQqGjIkIsWb+5WaJSVxqSA+Z6ifCHzw4pNn4tVKgX47
	 Wurg+/hvCmYGJpOezLuV9C63nJ1Nxqp51ydUA04GMssEjxXzw0bvPHypXeM8lzJnHHswh
	 sbVqvtwhYgrVlUKfXSAv50XoSJy9F2K2YXHoRrAPSskLHa4rtxKBYaRvTsfut6LJ2Kbdr
	 j0rIbMcfx/AKRx+19BoMeh2nkh9WUhA78dIU+P7xoAhDrZ5AowY5dONTlXu/oUC4+2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwvXlKx+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06BA606A326
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 02:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwvXlKx+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5132E1F000C1;
	Tue,  3 Nov 2026 02:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793672813;
	bh=pwb6JLLpCEVR88W/B1iVG0CiQ4Vpf1j5sJTjt4xv0+4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EwvXlKx+ugw2fKvAfIZuvmadMuptEsg1kRg+LcsGiZK5VJ1BqjX780Rov8C04KBVZ
	 0XV9vlTmrcIwehBM+ze1C9WmfF75hU1vLUivmpY7Jcf/TqSVDIMlmAvQ10YuV0pzcN
	 0sbQOuRRgtT5Q0DCN1f0DuGzz72gNO4C2bTqoKnuWukbvk4EOdOVn+SqWdpGMRkCxL
	 EvRkaRhy/eebTq2Ki62UEZDHmjVAApXMs/t2slcbo9PLPJ5+jADHqy+R88WmIpnXi3
	 Dgo9G44Cr2TzgNGavOdAUTxifA2dcK2V6K2pvnrs01YJg+eOvDcnCbnlX2cZUsb1TK
	 GWq2RvBwaUp6Q==
Message-ID: <sashiko-outbox-194459@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] perf alpha: Decode ProfileMe raw samples
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-perf-alpha-profileme-v3-1-4bf6e1dda733@gmail.com>
References: <20261102-perf-alpha-profileme-v3-0-4bf6e1dda733@gmail.com>
 <20261102-perf-alpha-profileme-v3-1-4bf6e1dda733@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 02:26:52 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The Alpha cpu PMU attaches struct alpha_profileme_sample to each
> ProfileMe sample as PERF_SAMPLE_RAW data: the profiled instruction's
> PMPC along with the I_STAT and PCTR_CTL status that says what happened
> to it.
>=20
> Decode it in perf report -D and perf script -D the way AMD IBS raw data
> is decoded, naming the trap from TRAP_TYPE when TRP is set and from the
> PALcode entry offset in PMPC for redirect traps, which TRAP_TYPE does
> not report. The payload is copied out of the sample and converted from
> little endian, so that it decodes on strict-alignment and big-endian
> hosts too.
>=20
> Copy the uapi header that defines the struct into tools/arch and add it
> to check-headers.sh.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-perf-alpha=
-profileme-v3-0-4bf6e1dda733@gmail.com?part=3D1

