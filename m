Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808965;
	b=bO2T8Cvf3htWThvj04Fg2MeT5YOEfByBlKm6/FOqVrGYcRQhvIBOH/zFRi2jcxfDjGky
	 hhkNcbzb0LBspWcjPIPk2417FLR3kkCyicvox4ggSo5ZRP6kAexAe04vyfKYLTiepbFvn
	 wAO+6yJRM/UDRcKY71ldn8oXkS2BJuCBmtuIp0iIuYCr2P/Dj2nfWH7jwyRBzJjgNMWYz
	 ggE5ZNWctHWTIQi0g33RBISa1RZ3fWEoI6tceCe8jVoTD3Dlclvj8g1QqgklyV/ImV3MG
	 OTVTlx8BRSNiQQjHP+Qt/aGMB8MwXQK8dVfzq698sXLISs8mMRcQNi+etyUfl+eYJBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808965;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=poG+xaCeLPnvBQ3Lx1bl2r9pxKTCd/1FXJTomkX+4no=;
	b=0Y8AA+nlmEMFPaPbVoLiP2rR2fVs93rXpC4gMzyjyLujOmeT/2/svUwumdPPykBQUAf5
	 04N4JoW4qIv9wwmdzFeywrvL/9zSob59UAso1xDAHsw3rda3Jmvqozn3/enZx3Pn6J7PM
	 m83Hd5pRuquLGlIFkVXrIHCEQQkiSS/8U24QQBBpw7WHP2QXyYj08ht4NM1/4fUZgMH2D
	 BQivZ1LIVXrpCgFGye3XYdzkmvnUoRRN6wQt8wNAXeKwN+XU8pBmyng4HyepYzy5HhIV2
	 p3KlGbRmfdzib4mM5xxK3QCN6TS5CKnLy7Jfsc18csYra+GUvAssfxyGOE+azSEyyeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMgfvNF9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54699606A882
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 06:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMgfvNF9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0394E1F000C6;
	Mon, 16 Nov 2026 06:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808965;
	bh=poG+xaCeLPnvBQ3Lx1bl2r9pxKTCd/1FXJTomkX+4no=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fMgfvNF9dYDLhHTN7U4jeUA69dS/urvxkOvyhiln+bAwczq2HN+HMYfKI1R8wF5U7
	 EySGLBZMoW8gFp/Cfs8Vv7wTAoOh74dGvPjbenDxZA3sH8VDVr065ePEdkEBFkwYXp
	 wUmdt/W80x5LxYYsYSH05DRFL1+/BtSmoOKS+HHfo68VDMlDa+vxmiRJ4386Vf5RM+
	 nfTblw0NooX1d+iH/R4taKv0cDBfW5xON83StEQEaK/qQ1MQdYo+Xa+BEy9g40TNw/
	 W6cyecwB+NrtHhE60j6XSBKRlbAoJc2/cVc6zPJH/3obpITQAgCqq07etblgS3wfr2
	 BBGMeDCX8sxVw==
Message-ID: <sashiko-outbox-216239@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/11] perf tools: Add perf_env__is_same_boot()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261116055731.707164-3-namhyung@kernel.org>
References: <20261116055731.707164-1-namhyung@kernel.org>
 <20261116055731.707164-3-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:02:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add perf_env__is_same_boot() to compare the recorded boot_id in struct
> perf_env against the running host's /proc/sys/kernel/random/boot_id.
> For live sessions where no offline header was populated, it falls back
> to reading the host boot_id and returns true.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055731.7071=
64-1-namhyung@kernel.org?part=3D2

