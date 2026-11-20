Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138720;
	b=zlOFJROUc05xLDi7q1BweACrAHGxJMfSqSgAdIlrwvgdiYRGNRPZGLTovyQCvhPlbvJq
	 Wp3+6OAm4z/JaX9aql7bf4vmr1Fm30hbd8AerYbvohi0Kv7xdIfve/DlsLrI9jMi8xf4P
	 rt0UtAeigtN/uvKaeiO0uYngXRbh1a2sMyu8TV/NHvRoZLmdCiAYRFv0edH1uNZL8SMhw
	 9MNyQTKko5Gj9JQiuCRIQpuafVNucESWPGBP1xcaU9MIzFIGee2kWXP/Hl6Cg0Izps+G7
	 /CxNJLBQ4YDr5uXptYms2pWKKke7PeKdpOfWU3TQaVVwv+rPdeak51Ook2wkBPBlmrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138720;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jZKtXiJZMFWeDSIdbuJ54/cZyulvnNOn+ClFsIUqqZM=;
	b=ckUPBWBVL4cBpBO1otgByJDCS2UJtyRLLEwp0L8ShpR2dlZVsdJlFour85b8G6xppta8
	 wvdWfHkdHC5gkUI6mfW/a5qWY0+v+vSWbG0EzYvjgdgmpIb05MRI9DxkopBAMliXuZrK4
	 OVwUjDqKraZTz4WkWU2w9KPodxBgk/pBjCWH0ltFixZPu+GOfYgyxI6Gp3T0HkgibjXzb
	 2fcEnpPWsMmcxjZ6wYuRw/m/dWwU/F5bJu4U50ebL2a5IFO+SwwwVNbAD4US/wZMBe2zH
	 rtBwZoXlfCWLNgsExkaqKhW+PLTZFo03nc8hvGoSNv9JQAk1ZdsahiJDircw/zxDpJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PDxVl55d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1E4606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PDxVl55d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35A41F000C6;
	Fri, 20 Nov 2026 01:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138720;
	bh=jZKtXiJZMFWeDSIdbuJ54/cZyulvnNOn+ClFsIUqqZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PDxVl55dNmudE0A+qKlcS3jPWt+WPLBLazaqtawk+jevaQTYhe04hTxX2uvEQSIZZ
	 2eBlkVzVuTglWJpIMmVO96fZVDjSdcCaYemE4wnZllwyMEMhZaqZ3IQ4sjDa4JkHYQ
	 7M9Ztg+G5ufBPkiuugvizax8/gr/oTqFELbVaQonj0s1XcOzwfEdQnhnw1uJTXoRbO
	 HCsJxhtwuwavCyX1kLG2t1vjAjnvan7/lrfFDH7RbuX/WyC4RI67HN8aHiVmVLpvrZ
	 nF6WAjqo3AFLsCQWjfYbqvH1DnFqtdK3N/khEJHWwY8m8LaD7MDcs7NZ7DRuHdpygn
	 3CcjlvnjT4c1w==
Message-ID: <sashiko-outbox-224327@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 05/13] perf tests: Exercise the flexible array member
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261120013211.1510-6-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
 <20261120013211.1510-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 01:38:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> No test covered find_flex_array() and get_flex_array_member().  Add a
> flex_array workload that keeps a struct with a trailing data[] behind a
> global pointer, and a test that checks the accesses past the struct size
> are resolved and named after the flexible array member; find_data_type()
> folds offsets past the struct modulo the element size back to the
> member's offset (+0x4 for char data[]).  The test skips on 32-bit PIE
> builds, which reach static globals relative to the GOT base register.
>=20
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120013211.1510=
-1-acme@kernel.org?part=3D5

