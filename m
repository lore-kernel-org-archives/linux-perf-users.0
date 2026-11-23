Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795451506;
	b=Hj6xo/EQfFsIM4QF4zy2Ih8yxWArb6aNZGpAYIpC9AIlLF+XsySCWVw7tsboHAd3ygRP
	 fa4rXe8hZzB8eOnqwSpq1DuvcqjT37pnMgHWcNpx637rnwgqWJLQB1xKuI4xRhMwqRIdM
	 vUlqBd9RAIw+zp0W/vNSt1vrfKEGcuhN9Ir9GjxtKFUx1JzzlpY2iKKhbjMsedhfPK9ba
	 yiuGyNdP+sL0Fv90zHod/LYCRUfFsQGUjhp055FvFJUgmp1EE9Y9uZhZa5WtOxCEr1Eb/
	 pFiyxjtf9tWgjuzJDcZtOQ6RdeOhu9paKQ0J+DMCOM4Oy30xTuJoMOcCxpMr8orHk+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795451506;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bWAVJQnhoAdB3lzdnm+TDv4u2x1elR+s9ERFMcYQE9s=;
	b=M4pi05UmVnVbIbpsie0jH2Dhnv3mYrDc3UrYOXTgRLBN9CdFsa3INs9uEcHkbDkMX38t
	 kGyUOY+XvoqDwyi7Y+mEhB86eL7msRZddRTs1JYZ6x8IDpd1t+5RmU3QsdJahdIS7O1d5
	 s2Q+9NjeX4HAdECc6ooTetB2xHXOOzdKJXFg00/CX4A+ATc91el1JBmf2vGyV4Gvdi1+q
	 zN9GQ5+a62GDm8EWTzwNFCubowiWs0Hgi6HDcp8NcJW+pv6R05rSZ0GZ4Vpw2FccBDfTb
	 ndpcpnnpD0Uj0pA8yPMfffS6OOJOGRGJ9cyS6Oto776Pz5w7SDnQC7zrIQaVKk3Tcmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L6k6vuQN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DE3606A696
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L6k6vuQN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D558B1F00AD3;
	Mon, 23 Nov 2026 16:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795451506;
	bh=bWAVJQnhoAdB3lzdnm+TDv4u2x1elR+s9ERFMcYQE9s=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=L6k6vuQNb3NTO2GWP3BzDfLd/k040BWhuT72ubXTnqUiwZ4cMc7oyVcIb0X24bY4v
	 W3pXCMu3ns4edcaWnEBJkoHdQIY9mQieBjhszJJKTQ9IXL51Z7bfDVNsFj7U/jX81q
	 wuvzsTEiSE2DYYAJLoMjDjOKWiCCH+gMNOlEdesIPDDW8+KMzz9aD/d4c6DcEzGScc
	 pEuBFBUyvwZgK2OCLfaj9D/6XprGZtik7J4X87nuHP8yRQrSFPPKaNmcJsuzmhSLsG
	 3Py34TQoF3twzulfw+ro28IEnFI/DsKTLzmOo5TAJNqWsgr+rAgLCX4LetV8ScBIpH
	 WL5l3su6FJsnQ==
Message-ID: <sashiko-outbox-229661@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/x86/amd/ibs: Don't leak stack contents through
 PERF_SAMPLE_WEIGHT_STRUCT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Usama Arif" <usama.arif@linux.dev>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261123162315.1142701-1-usama.arif@linux.dev>
References: <20261123162315.1142701-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 16:31:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> For a load that missed the data cache, perf_ibs_parse_ld_st_data()
> reports the miss latency as the sample weight and marks
> PERF_SAMPLE_WEIGHT_TYPE as done, so perf_prepare_sample() leaves the
> field alone. With PERF_SAMPLE_WEIGHT_STRUCT it writes only var1_dw and
> var2_w, but perf_output_sample() copies all 8 bytes of the union into
> the ring buffer. var3_w therefore carries whatever was left in the
> on-stack struct perf_sample_data in perf_ibs_handle_irq().
>=20
> CONFIG_INIT_STACK_ALL_ZERO hides this by clearing the struct on entry.
> Without it, every such sample hands 2 bytes of kernel stack to user
> space. "perf mem record" asks for PERF_SAMPLE_WEIGHT_STRUCT on x86, and
> since v6.14 swfilt lets an unprivileged user sample their own tasks with
> IBS.
>=20
> Write var3_w as well.
>=20
> Fixes: 6b2ae4952ef8 ("perf/x86/amd: Support PERF_SAMPLE_{WEIGHT|WEIGHT_ST=
RUCT}")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123162315.1142=
701-1-usama.arif@linux.dev?part=3D1
