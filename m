Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC771D7E5C
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 02:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789267353; cv=none; b=HDK46CSjZBLVcetRq3pYgLwsr9Mv+w+Izq+VGpO4VHjC1vuZf4QQ7W2hIx+vYFscp+Cbrf+TjVabKsA+e3OLtolNwAVGwLmmzyLJQMRd7hGNFrFEYCIYpPIXqUo5Wv4HSWv9OHrg4QEcRbKZqxNf/KE5xSlTaGpIpdKZMzZ2t3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789267353; c=relaxed/simple;
	bh=MRCqpzP3jjzt6yktEYB/MXvgOYOYOsN65tLyRYxLUts=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M5+blGuvVrK5Q/9PhpGUpu6mmxPvYi+y4TN9C6xpMlSGrwRGFNuz2t8Y9WLNGjB4LdC0srUL1wCAJ4zBYjtuYeSlXHivKEoTv6VIKD8ik81XhYFgBNf1L7CsVLBP93cNdtdasxTRtdZa2jUWX34m+94deMjHCfp6egHes114chs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyoRbt9J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyoRbt9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8626B1F000FF;
	Sun, 13 Sep 2026 02:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789267351;
	bh=mQtkzfjU8RBAVdiRD8gvjcnOko4ej92JgopfRl2L2fU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SyoRbt9JAYv4wC/wJ3Tw9AWMfVbXB6HkHWAHFwm1RPzz0xk4eZPZmiBuOW04aHLvw
	 DXBBiKYoKUaPMRZf/DewgViXcEIAplwNl+Kpe4o99KJSA17uGB65NQymREvfvM1MsK
	 Cv75GpKPigt4G31k910iNd3cIAbxCKudiyRxvi/LE7Gr9xIdA83Lb8FxZ/rpVF1Ug5
	 6zYz3XnD2eYNaE5dEx35Z06J4dZ9Fc7CBTsX2L0gkwBMX0FEc+DdrFhCgL5ZZwqaN5
	 MeLkCbG6oiZF4859Qq+ewuPwNUUVcWSudtCFGsLQZNwrlQAZhLdK2lj0efYDym5Ij9
	 x/2H97ZSQYeVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/8] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913023459.112654-6-acme@kernel.org>
References: <20260913023459.112654-1-acme@kernel.org>
 <20260913023459.112654-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 02:42:31 +0000
Message-Id: <20260913024231.8626B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Processing a large data type profiling session, e.g. an AMD IBS one, can
> take a long time and, when using the stdio output, 'perf report' gives no
> feedback about which phase it is in nor about how far along it is: the
> TUI has a progress bar for that, but in the stdio case the ui_progress
> updates, that are already there, are dropped on the floor.
>=20
> Add a --progress option that installs a stdio backend for ui_progress,
> ui/stdio/progress.c, printing the phase title, the percentage done and
> the current/total counts to stderr:
>=20
>   Processing events... [ 42.3%] 317M / 746M
>   Merging related events... [ 61.0%] 309026 / 506686
>   Sorting events for output... [ 98.2%] 14132 / 14387
> [ ... ]
>   88: Test that perf report handles truncated perf.data gracefully (no cr=
ash, no segfault =E2=80=94 clean error exit).: Ok
>   =E2=AC=A2 [acme@toolbx perf-tools-next]$
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913023459.1126=
54-1-acme@kernel.org?part=3D5

