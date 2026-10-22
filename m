Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634811;
	b=QDzEUhJpvSD83Xy1Nm4DxRcsqHrpOSpAmaksquUcbxWAPlMhveBAFirqb8LN/AfKMKKH
	 8R/dh9HSXVoGsVbGulIS5j/+F2YytpjjOVZ/cxlGLxoXMMFkzC1dwEFFuaDUVTMjU6ZwC
	 LF74vLw2N7hQHzmCFMOEOauzvHDO/fwrYCPuGMWs2p7I9F6UB9tHyjvWAzKhCeD7qQENJ
	 N80A5OuMq0SGJy+GZrn7CfOvYcJq/aRoyiJo90R4vBJBqjq6DujL32Ou88KQQlgUAbEue
	 TfYMqz/8khM/tw0+FDYdi8HcNW06+4zLzJXyX23A8Fy1Zrp2oEblsKk2lmlQbKWwK8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634811;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OLSr7M8/g3S1zVD89RtwL9bbabGoxgXJpJb0/zYh33w=;
	b=KZuc5mpvYEEYgzx3D3yEdHlrCQpB6/d/KVjneBDogR4F2JjlRvs6855KaMsC0Q0Ed2gx
	 mZNQttNX8DfsvFOmoEMb0YkN+KOka7sya9DK6BtiX+hEn6hPyYtsNigD81ckFQmBwonD4
	 G8Qzcjetsg+umOKER8/8tV8bV+XE2RhHUZCDOZeK21weXwNVRLMPjhC/XmCFX54glZ9Et
	 QeiATprNvxpIIQOFLnMOpGT0t4uDhtJYInnr/96X4p2ud6W0lInjBIqJ/9Ivg2hrNSUYG
	 ZGMZtdqDG+Dc9/sgjyNRgx3Zl2tgub+JD84FA/XU6+NVO1/Z437ARYWnP/5prxbdN2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gyw5EvpS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B93606A319
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 02:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gyw5EvpS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92811F000C1;
	Thu, 22 Oct 2026 02:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634811;
	bh=OLSr7M8/g3S1zVD89RtwL9bbabGoxgXJpJb0/zYh33w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gyw5EvpSexz+Bj7hZP0c2uUFqrUUV//U33tVwBGRzs0nwyJMmx8tkqWh3dfqQYrXk
	 r06UsHD93/9/l0ZsC5VlX9OPEQZKNIdzYSUuhrSdz/AkS31myQEa2A7WhImW/lSvY4
	 ZzhFK2cjpRWAHcO9aeMvq9cQnmvlwtoB5QEIMvYYHXhyPwnzGa8YWKE+5eHm1+Yaef
	 YoWhtCSRc03jWYyRWJwK27E+3ai8AVQvS6dfAr9vGy2XT/lQQViqHRcFPMAk6WsXKY
	 fjf3C8+RqOpYlOPr16Hl7GV1iqTMarQlk/8IW0o/x9Btp8wpB2M3Q4hXIoijJsTw6M
	 OuDF/Im6oEzrA==
Message-ID: <sashiko-outbox-180858@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/9] uprobes/x86: Finish an unoptimization
 which failed half-way
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022015712.1297331-4-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-4-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 02:06:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> From: Alexei Starovoitov <ast@kernel.org>
>=20
> int3_update_unoptimize() restores optimized nop10 in three writes:
>=20
>   48 8d 64 24 80 e8 d0 d1 d2 d3    lea -0x80(%rsp),%rsp; call tramp
>   cc 8d 64 24 80 e8 d0 d1 d2 d3    1. trap new entries
>   cc 2e 0f 1f 84 e8 d0 d1 d2 d3    2. restore bytes 1..4
>   66 2e 0f 1f 84 e8 d0 d1 d2 d3    3. restore byte 0
>=20
> uprobe_write() can fail with -ENOMEM, or with -EINTR when the task is bei=
ng
> killed. When the 2nd write fails the result of the 1st one stays. Byte 0 =
is
> a breakpoint and it works. But the next set_orig_insn() doesn't find lea =
in
> byte 0, takes it for a plain breakpoint and restores one byte:
>=20
>   66 8d 64 24 80 e8 d0 d1 d2 d3    lea -0x80(%rsp),%sp; call tramp
> [ ... ]
> fork() removes the breakpoint from its mm. When fork() is killed in
> the middle register_for_each_vma() removes it for the second time.
>=20
> Fixes: 554ba38456da ("uprobes/x86: Move optimized uprobe from nop5 to nop=
10")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022015712.1297=
331-1-alexei.starovoitov@gmail.com?part=3D3

