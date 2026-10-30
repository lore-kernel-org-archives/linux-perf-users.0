Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793373700;
	b=iGibicPFWU2+z+nnU3hQ172RnjUZrsVDAyae3Ar0MK2we8ULVYBahaptode5JnVw4oJk
	 gpthbCWae6rAyxCJj1ELwkxV5yPi0m509UoZIYNtn7HVcSy/sdZ13fg0kqRSphyOlI467
	 dfAk3JvJgRmdURdKqJ4s5biN+ROeW47CggEmXQV/NyhTLweZiWz37hDZBVVqq6jzKuS50
	 KuXNgd9viB2BbO+IPI2gUq9L1dMieBqA3Li0Tgej+Hj+zGGR6Cyu5HYx0TUSAjo15dorS
	 XUwQ3+cPruO6Qr7iBZotgzA69RNteIvtf8XopKXf0D0BEV4nD90/QOZoVDVOPkQJy5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793373700;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nwBn/aee1ORkzcv/GsKpAeaWHZ0AM5ypiXD9vfLDweI=;
	b=fGcbbV5iBtUFvE2gLhQjrpeZFOufayiVNnZsIkWHnHc2XzjLfWOePPSB/nhAeYvX52JC
	 Ma8vbeGAUgwR6/MqU8SQZy7AYQ0qtiBNIHbOC28/K9Ts9qAK2HLwlEYBQN37DAZkWAQp8
	 1eVTZ9r2ZMTf8LR0zpPxBiCiY7nen3MyaHpSfQKUmVm1la1utHFK3LmkT1nlnmJiSbJRm
	 HiUhn2vTqeH5JyDYXZjrilLsWfh3ena7O9rWC+E+6Yml4BSKxaGXIgH3IM9vgjmwm4IE0
	 kj0n0mGFfJFfPeX5UXuOX88aQGKVQ49DPiJXta5CLBeW82JbicOp8t8M6qPnepjiGOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDQyMuES;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D119606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YDQyMuES
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA551F0093A;
	Fri, 30 Oct 2026 15:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793373700;
	bh=nwBn/aee1ORkzcv/GsKpAeaWHZ0AM5ypiXD9vfLDweI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YDQyMuESa0SkfriNwfIftUylVCD5yjt6XhUINX+H+1xg4VMcXNt6Ti+MXE/Oly9OW
	 0HpvJe5vaM91YQLV/CsQqCJLiR3PwDUrq6KGRNVuVjKd4voi3aJ3kK894MQ8vYtf4X
	 NrCtgmorVKqKxy2n3FvKjtjLlMBwgxm8AD+IJ9/RHehKCvqkIYvNPv/CMGwbPSMDgQ
	 vV+JpZkVUWg7PpCicKDYgoJ8j6WeRGSaYOqw+SEZS0VF9hd0gX8G9v/DQrCEQ1QJvC
	 79ong/MlqE6ILNq3FHv0nU5qJhvEwK5kcIUrzdWnbY47l65U/ugcGKGTtrOYhFtH8B
	 WIWvZUD7JXYhg==
Message-ID: <sashiko-outbox-191158@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/14] perf cs-etm: Mark branches that were not taken
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-perf_cs_etm_fix_non_taken-v3-6-7629b52ab047@arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
 <20261030-perf_cs_etm_fix_non_taken-v3-6-7629b52ab047@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 15:21:39 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> An exception can transfer execution to the kernel after any instruction.
> When this creates a trace boundary, perf may attribute the trace-end
> sample to the last instruction in the range. If that instruction is an
> untaken branch, reporting only its branch type can make the transfer look
> like a taken branch.
>=20
> Set PERF_IP_FLAG_NOT_TAKEN for branch ranges when
> last_instr_taken_branch is false. This records the decoded branch
> outcome independently of exception entry.
>=20
> For a discontinuity without an exception element, perf script previously
> reported an untaken B.LS as:
>=20
>   tr end  jcc             4000f8 =3D> 0       b.ls #0x400118
>   tr strt jmp                  0 =3D> 4000fc
>=20
> With the not-taken flag set:
>=20
>   tr end  jcc/not_taken/  4000f8 =3D> 0       b.ls #0x400118
>   tr strt jmp                  0 =3D> 4000fc
>=20
> Here, 4000f8 remains the last traced instruction and 4000fc is the trace
> restart address. These boundary samples do not establish an IRQ entry or
> an exception return; the not_taken flag records only the branch outcome.
>=20
> Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-perf_cs_et=
m_fix_non_taken-v3-0-7629b52ab047@arm.com?part=3D6

