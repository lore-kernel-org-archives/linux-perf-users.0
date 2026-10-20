Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508515;
	b=d35K7q64vt3MKbpv+0ZE6Szxv3V1lrJQisYGrGcleTycbdpxfOI2XEP8yx/v3LoAXwHk
	 OP2F9xrvUUOMb89nrRwTHu5A7xQJcsd8u/s7GW4Ap6HgpHqA3b+8JT+ocV9hUs0A1Fe2I
	 GOHprGBjoqc5c0alhqFZCGGA9302SudXy79iD190BBzjc3Fy/L8dElEGll+oUi7oGMDxM
	 RtBw0IdoXIJv6IlRfM+h91Of/dPRRBEt25ZRAZw1bAbn/8vZlRpTAZaHw32/SJ3RCcari
	 3vj7BzjlEEnax57lbFTQiCL3cyvAV1C5pzYRiNdX4OrtPdeHNdEa5c/q+kIjf3lk4cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508515;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aDvNb6FhqQa1DouOQH9o5ka7k8mQ6twFsOOW/jD8dkY=;
	b=y5I596Bun4iHhU0AVBdPh8SgP+OcHQS6eQNE+hPrhu800WZV1382cSGt0JA6la4DcJV7
	 /6UFOVVAYu7UOMuM5ibG0nCIbPIMmkzm+FM+ngJI4ibEPqSOLUAGX0wLzelZkIHHpZbW3
	 2Cxn2kmczGQRSYD25up2UC88yGwkSlnbKYmKoqoK/mnr0JPmGRaZEtRcs45BduTE40+Yp
	 umA6aWuhzsvZWpRkLkVtATqFBoQPrrQn1tJv9q0sBHxKBNi0xVXG55/+JE3QiV1OKBsIh
	 CwXAcQrpsmoNoJkEN5+X8uJ03Cxno02I4QV5advITpOtomrLpYhdBs7xppivR+covQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTj9JblR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C2A606A31D
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTj9JblR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596BF1F000C4;
	Tue, 20 Oct 2026 15:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792508514;
	bh=aDvNb6FhqQa1DouOQH9o5ka7k8mQ6twFsOOW/jD8dkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eTj9JblRczQ5GzJe2HF0xRTvzFHKEN4zrMvBqTP333E7n55nPBIZSPerZdlGTLgsy
	 YkAzEf9uXCv8cjzyYvnqNDbmwF7dpsWCYOt/yNu5zniJ1hG8tp4oFOA+lyW1WiETOl
	 Q88PQXJLy2eOtKWyxev5nZS37foR9xyBCFoWTZ8tPusM/hC5napVZP4KYcj5CQnB8P
	 dZWcBq9ol0PNBYi3CtquZ6orJZLp01P5O9l6ruvYCsPJzTWnoWkdw3MzYqhFnbES9T
	 0bgCnKLYiAnOGOPDkOyvfBvD5eYRM95n2WtskZ32f2kMybrS+qJgStEbuPFgZfG5p+
	 lDhmdXIK/U8Fg==
Message-ID: <sashiko-outbox-179209@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 11/15] perf annotate-arm64: Support 'mov' instruction
 tracking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <8e38e27fa8806e3355e579bddfb7739c9619cb07.1792411435.git.wutengda@huaweicloud.com>
References: <cover.1792411435.git.wutengda@huaweicloud.com>
 <8e38e27fa8806e3355e579bddfb7739c9619cb07.1792411435.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 15:01:53 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Extend update_insn_state_arm64() to support register-to-register and
> immediate-to-register 'mov' instructions.
>=20
> For register-to-register 'mov' (e.g., mov dreg, sreg), propagate data type
> information from the source register to the destination register.
>=20
> For immediate-to-register 'mov' (e.g., mov dreg, #imm), store the immedia=
te
> value in the destination register's imm_value field and set its kind to
> TSR_KIND_CONST, allowing subsequent instructions to resolve it as a
> constant.
>=20
> A real-world example is shown below:
>=20
>   ffff8000803eebf8 <get_vma_policy>:
>   ffff8000803eec20:  mov  x21, x0          // x0 (struct vm_area_struct*)=
 -> x21
> [ ... ]
>   final result:  type=3D'struct vm_area_struct' size=3D0xb0
>=20
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1792411435.gi=
t.wutengda@huaweicloud.com?part=3D11

