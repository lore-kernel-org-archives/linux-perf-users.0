Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350592;
	b=mVzun8M/rokeehZ23Z12grMe2dsIgzXCwE50IgJUfQRhxYBSm2j/1vK2kMykxiQC3ewK
	 IC+BPnqokW9WcRisKgN7pmY86EQCXxb5qv9Wl2yTPl8j6nF5vG/Je9ymsvWABQ56Ds2QS
	 eJYgvKVWFZga5OwTOsUcHuEu2aT1bsMqBCCcoMU0t9lH1fTe8en7zZOgMacmfIiu+ABD1
	 y+ccLpYduiRrL5uZ6AJNBVR53/yVuogjiwpDi5sNHOa9gTEjvPvTcfYD1kPeZSSfQY8fy
	 rZsdfvmzoafEWJyDzZA9Uqv4VNyuMRMk2ZM7zNuu+VEnlJMwxgkea/+W644h/ahKwvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350592;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eHQwjAtcBls/Ni1MIk1eRY2QcgJLMLgRgOLh4+xFT1A=;
	b=g5Ie9pKE89VXxZfHjFanJnHHnsAisXKlYetH0PUwSLu4zQsWHyHGARGhEYtwGOELn71C
	 DplVsdO7wCGuQsyFKcFhQK9j/AYsQGAaTxbxXbnm/aVUMq5bY+CAt1fko3gGNKcJVTMGH
	 1Y3Rdd9Pb95Wo+bmG1u0pKY8X2+0hluSEis60VKvek9oJrqGtfc4EWKfuhp4ie3L6hrFn
	 Os9ayI7vGsU7q9+nTS9DKwIj+yKG92AH2DU9owSC+iu6MMF7hnCxMMot8WFgFHzZx/BRj
	 wBfxkoDMw8vG1DeTIKa/TrS8Rt2ztazTOYyLqkIB5fhLWvust6jINxx3POyPYQX4P7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAlWOzbV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC41606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAlWOzbV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A521F008A2;
	Tue, 10 Nov 2026 22:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350591;
	bh=eHQwjAtcBls/Ni1MIk1eRY2QcgJLMLgRgOLh4+xFT1A=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DAlWOzbVTh5plfchPUQrwD2eEyGdd9X4ROQbLwYDz7hg8yaDwJgBxEcaJk9GhoV4f
	 PWRzRxrdw9xKziaFkDa415rOJz+XGgK/5cxqPmso4KdVprR98eSzFTixofQMvBYbN1
	 xVMq0C6dCFxF0pznQwi/v4yhux4aJ6x0QTmN6wN1s/nf+UeeksDc4RISJ/iIiYzvfQ
	 L8kVC3qG24+pmfHEARgebDU2r9qqvB6A2CiYr4ghHcZ8pZUWVXHIakJqsS66T9xIR+
	 5mm8EyF/NTYfgn0uaoDagi+U9Yhu3T9LvrruXeFSI1BepIurQiZGO4ySGbE3vD9Wr1
	 TqiKeOmfEetGg==
Message-ID: <sashiko-outbox-207841@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] perf jevents: Make the model argument optional
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261110222250.1864777-3-takano32@gmail.com>
References: <20261110222250.1864777-1-takano32@gmail.com>
 <20261110222250.1864777-3-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:43:11 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] perf jevents: missing Fixes trailer for unreachable model
  default
--

commit b4da888ac73bbe46e6f0c875cda7b46a6a7699ff
Author: TAKANO Mitsuhiro <takano32@gmail.com>

> perf jevents: Make the model argument optional
>
> The model argument carries a default of "all", but a positional argument
> with a default and no nargs is still required: "jevents.py x86 <dir>" exi=
ts
> with "the following arguments are required: model", and so does any caller
> that only wants the tables for an architecture.
>
> Make it nargs=3D'?' so the default is reachable and an omitted model means
> "all".  Builds pass it explicitly, so the generated tables do not change.
>
> Signed-off-by: TAKANO Mitsuhiro <takano32@gmail.com>

[Severity: Low]
Since 5a09b1fd1b1f ("perf jevents: Add model list option") added the
positional model argument with default=3D'all' without nargs=3D'?', should =
this
include:

  Fixes: 5a09b1fd1b1f ("perf jevents: Add model list option")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110222250.1864=
777-1-takano32@gmail.com?part=3D2
