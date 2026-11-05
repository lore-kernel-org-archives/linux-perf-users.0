Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868068;
	b=SkcMt3511vC7Mk2/IXBAnmGdHQJJylfRMNuPY44FtwQkfCClYeDSXOAxbWtYyzFhowVQ
	 fGXZHCE5unxOnhtwGvqva9kb61dx49Dqz4WwZHDjt+aGhYHJbgEU5KO5NntltCdAGmQdd
	 EDbjcBK3x/MQMd/FfO7/uHQvz6VA2sL4xOf3ZX9DMzyNVTrV6rg7pocoMbnZQ7jV6Yrzk
	 JrLw6XqmJhMlFDzstQemJXVm3Wp/dnjRAU+Khf32MDZZO0kLLUAbCtruwpb7pYgoiO28J
	 w3sl64aue7Z6YbXN/3/XHL0haVLs2jYkxGkWC5WXyGe+i4zZWquSmjSwAcfcVB20Blw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868068;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vd1EvYjWXu9wgN1/qXv5649oMwpTZghAKNnzLS9cZ2c=;
	b=ah0RjKfVOiVcQKoFvZ+D6BcB361ZWEltM37AdbHgUPx5BRnuZqbr3IywJVwyliKP+3bd
	 3MnWps8ZgIwhMVMO5IWKnGShMw+B/zATzOzEMA8Y4OfFS9L2wZxpoa0jO/r+946lyvV+Z
	 sclgWMWs/uXoUpDrsrMvL7XFlaqHQjhRVNTVhgWnle/RorZuDsPnWCEFBXOvIW3oAUje/
	 vGe3LZvJgy7muWvTEihenAKCRsImm4dU3s4o35PRAcvtryrk2QzPuN6no2KHUXPdXw6L3
	 gHwnR7/tq6gMadGxGK9PL5oVx67RGXjvxPo3a3WuAM2Wp5zyd/rZ/Nm5GTDWXPwEclQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CupoUR7t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DB1606A326
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CupoUR7t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F204E1F000C1;
	Thu,  5 Nov 2026 08:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793868068;
	bh=Vd1EvYjWXu9wgN1/qXv5649oMwpTZghAKNnzLS9cZ2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CupoUR7t6+Ra6L+nXrUKoUY/ixrGV/gJZUD2JLtm22q5fcLPMUAiSW/XcM/XDsrHM
	 /y6MvuQLO75EeE3Q3E3/c+QYsxa0Obzo6AiHGg8iEtwM1aXVFHIx3Gwwt4A7ZCgjHD
	 sW5JS8BTOrFywMqHrz3+rwRAUF7mpDwru4kJagLXW7qo3AO0PPKI5PbJvitm2PL0Uk
	 wsC/8ckF+Yf9Vk9Hv1rZiiU8B/Wwd6IEvUPA/CyxlXiUGOLNiBsLR8Qqq8VTj9JcKu
	 48isSr3eTzA3AFlvhMOh5leIp/excwrhgXIGx3+7mcckprmXDwIhIn+yRkY/q6hXEa
	 zPrHMj50zOsyw==
Message-ID: <sashiko-outbox-198733@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] perf: do not call zfree() on uninitialized
 pointer
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmlyaSBTbGFieSAoU1VTRSk=?= <jirislaby@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <8b245572903b8c4ed0dc569d7a71a8f4974e2455.1793867553.git.jirislaby@kernel.org>
References: <cover.1793867553.git.jirislaby@kernel.org>
 <8b245572903b8c4ed0dc569d7a71a8f4974e2455.1793867553.git.jirislaby@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 08:41:07 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> In add_drm_pmu(), the check for type > PERF_PMU_TYPE_DRM_END happens
> before "drm" is allocated by zalloc(). The error path nevertheless
> called zfree(&drm), i.e. free() on an uninitialized pointer, which
> can crash. Remove this bogus zfree() -- nothing has been allocated
> yet at this point, so there is nothing to free.
>=20
> Fixes this compiler warning:
> In function =E2=80=98__zfree=E2=80=99,
>     inlined from =E2=80=98add_drm_pmu=E2=80=99 at util/drm_pmu.c:110:3,
>     inlined from =E2=80=98read_drm_pmus_cb=E2=80=99 at util/drm_pmu.c:174=
:10:
> ../lib/zalloc.c:13:9: warning: =E2=80=98drm=E2=80=99 may be used uninitia=
lized [-Wmaybe-uninitialized]
>    13 |         free(*ptr);
>       |         ^
>=20
> Assisted-by: LLM
> Fixes: 28917cb17f9d ("perf drm_pmu: Add a tool like PMU to expose DRM inf=
ormation")
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/8b245572903b8c4ed0d=
c569d7a71a8f4974e2455.1793867553.git.jirislaby@kernel.org?part=3D1

