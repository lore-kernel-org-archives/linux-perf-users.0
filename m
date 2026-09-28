Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AFA4EE850
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Sep 2026 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613078; cv=none; b=YjELrUTu9viI3VEIVLaFm+EOOk65Y6e0U2nIVvvdAYh3MYXQX+A7g0NEyxBXF98xrAUq2j7Pd0p05Yox+VUMw0qG/wtw+Mrmu39F1AgIprZLy8UJnWZzhdeVFVlaAS8BMqbgxBo74WO7VR1PE032C9vXuK2kzavVGz09ooVcom4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613078; c=relaxed/simple;
	bh=Fci7YTcv7MVJJa2SO58YNFzKsfEt3w2v/66xgpdfCrs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hhw94B2UL7FlYlnv5o9Pc1a2TcM8+16Lw323Px5J39M9U8WQ/aApqp+Gsx+GeRnz22P5cXxV0ULy2yXq+ri9PNq8FW2ELhBEDFH+UYH5Itd7/+TriXHsjKbYARuvKrmemGQhjBr/I4IfmDHUW8qLPeyZi0t/SZ7X9hHkjeQK7JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCW0mm+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCW0mm+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DE01F00898;
	Mon, 28 Sep 2026 16:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613077;
	bh=FrwYp0ft1tpWgCplNtZI9pv/k67x2OLOjKSihVVPA1k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nCW0mm+DcAZb8b3mbGptu/tJPUFHcK4SLn1P9BhQ/b9cWxb74MjpDTkca4X7RiyLr
	 XTAg4A0hYA+tjOvez9+WFFWIKeFN3yQIatwchc0bIlll/CjzFI/YmwOkrdMDj0+DUE
	 yO9as6syFvNdOAtQ0Kgty6QYRe4R3zU10uiQtVFBxbp5K9S7KM76k7EATew3cQ+eJ7
	 lYIwcjIAB+ikR3uSQ2vD59/dEOspDSp4hdwF0sf/gL/Y3rYSFKeCqgROYjJyfa47B2
	 R382C1FWTWdyu08HZaP52nUXcuD5zQ7rKV6Revo2lCuMqJiiO03/cALgvksuC5IT8C
	 NX8JhUvvP4jRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] perf report: Add --progress option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260928162250.2413383-3-acme@kernel.org>
References: <20260928162250.2413383-1-acme@kernel.org>
 <20260928162250.2413383-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:31:16 +0000
Message-Id: <20260928163117.58DE01F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> Processing a large session with stdio output gives no feedback about
> which phase perf is in or how far along it is: ui_progress updates are
> only shown by the TUI.  Add --progress, installing a stdio backend
> (ui/stdio/progress.c) that prints the phase title, percentage and
> counts:
>=20
>   Processing events... [42.3%] 317M / 746M
>=20
> Phases can be nested, so the backend tracks the ones started to
> complete the right one on ui_progress__finish(); that requires
> init()/finish() pairs, fixed in ordered-events.c and the pipe and
> directory event processing.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928162250.2413=
383-1-acme@kernel.org?part=3D2

