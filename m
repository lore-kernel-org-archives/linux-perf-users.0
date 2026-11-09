Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794246676;
	b=hf1S6pr8Q55XSKOcMoGzM7K0vhjL91aXaNclu1bJ3Gd6sl2aiW/CzrZiyw1S9GmNcUvm
	 e3aLJqsqVzcTzH9tuURBVU+rTDOEKIGWIfUVv4oOkcngFIdhBJc8u+X620frZRa34cWEU
	 2TGypENdOFjiwEbUNxG8g9bRGsiGFUaFYkQDebDtfwfL/PNH4wWR9zQcTlKWAvE1g1T21
	 x0I9fpZt3ggndutFbEYoNn7eJ0x8DtsJk9Pt6txpxLmXSoAM7mXXrW75inDFYTy1v8MQm
	 jHlHvEV0s8MCryB5u7/VcIG9+5kbga4p6LDVJ+QhA/qsafiOWDpwWeBjxIk8cPwmoUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794246676;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8D7eTi6dBIxHazN2T6Qm5RLEdNUzQGO3/thMd8IrXNQ=;
	b=fUi+Z66I/RCKRCBGYfNRzJm6x+0/7zN8qkZSmkX1lab3hL6mElfJB8EHEegrvz61vWSI
	 UruiDlI425OhDU0QdRU4K0lTOn8dqqs5xhoNkGqyKQBAJCISua6B771sISGpLLmyqy9m3
	 0hXBLHSDw7S/fYGXozkR0fbgcsnhrkeeyuxOxYK/yVI1gnUjxoDiPiNNsDTUYHrZcEdHy
	 8tCcZ7IlqD8IfTVgj4NDGlIzBQLBDRmPPey1kVDK9ceTRO+8gCfA/5Um5VPMTb7F4OlDq
	 4MfiJ/OTxRfN1jz/PUeVz96xI9L63p1uAeLLcXoqLOIeEkE/G3xV8OZcs93Jww+fucA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nf1dAFaJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D41B60A5BC9
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nf1dAFaJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394C71F00A10;
	Mon,  9 Nov 2026 17:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794246675;
	bh=8D7eTi6dBIxHazN2T6Qm5RLEdNUzQGO3/thMd8IrXNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nf1dAFaJ6e/K0fk6EJnQfVgKZLYH4DOZZgmIAnPbxkYHZv4EuY6/i4dXkfMMhxMxQ
	 n2jjMicztJaXaN4QfBqbgtd7wrVAEUNT+0dVrUeM3uczQWU0gdMZn7mvOnXtbJniu+
	 OvzOVheLf716U9uFKsw0GYQiJ1XdOjuQjINyeP4ltM5+uR3k+JQs4CIek4BqzOp3ap
	 oIKHZ7yXXUSUVtC9ymNma3sp3jIYRC6szEoEcwSI6ZyI3+Mp3GctwB6MmeJVghDkWj
	 3sCNf9oCMX4SSlJV7YtbFkqoV/zoHue72pNubmZuHyvBgcy+PoUqtf185fputaSrwv
	 0WtdqXg/NevnA==
Message-ID: <sashiko-outbox-205345@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/arm-cmn: Sanity-check DTC discovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <a1abc2ce99b91db64948cfc3b639c878f896858c.1794245895.git.robin.murphy@arm.com>
References: <a1abc2ce99b91db64948cfc3b639c878f896858c.1794245895.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 17:51:14 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> With the device isolation feature, the control registers reset to
> the "all ports disabled" value and so require explicit programming
> by pre-boot firmware. Apparently if firmware forgets to do this,
> we can end up skipping all leaf nodes in the discovery walk due to
> the CMN_CHILD_NODE_ISOLATED flag, and thus dereferencing dtc[0]
> uninitialised in arm_cmn_set_state(). While this should only ever
> be an "early platform bringup" kind of issue, it's not too hard to
> fail a bit more politely in this case, so we may as well.
>=20
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/a1abc2ce99b91db6494=
8cfc3b639c878f896858c.1794245895.git.robin.murphy@arm.com?part=3D1

