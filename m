Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E2A31283E
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792185906; cv=none; b=eo8Htaj/JcA3We1+YrXJTebzu6lt9dFyRDZHIqCXo1vQmGC51/DR69fKCSIeJLt0eM/6fP9FT5CKQJgQ2CvOqLqz6VZhjmis12o2amjeSWcl3LZ11z2SJKxjggsjEBvvl/mqorbzCPs9qpWI3YNV06aJCMKUgusIOn8a6LCgOVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792185906; c=relaxed/simple;
	bh=E0kORqtBouP4dtyOFnq0uqbeKNlN1lpPXqL6cHATFTg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HciwrJy5UFYMa9kScKFCATbVM6yoeTL9COY2uDB8MECLuwu/CCWq71U8gnbrpyuaSmn7dkrqUjk0sstDeydeshyvWWEU2ryVCt2mOwFYncciPp/5paJazzcGziG87c6QdgpdWKE/Qq2G+xnt/0XgP3ROWeX7CvbmX48Ij6oPpUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEJgKYuy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEJgKYuy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA481F000C4;
	Fri, 16 Oct 2026 21:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792185905;
	bh=N3fJVFglyji8dvbMSWkRbGQ3i2XpyzLF4ldP6pY+afU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hEJgKYuySjiz/V9h4qDwwdItiM7YKux0kJqq/eAPOq9br3u3OczwS2PQ3WTAz3vIo
	 6KEuMrSg/yRJkVIJDFBffs+OGzjgbgLdX9UU61ZJ4fy0rpyNFxjufD41q1GwyUd+I/
	 So0UUkTYmKsbwTQyJmiLZatid8EKK/D3e21fSWF/1AydYYLxNuI/1Gs+eF3SbGYN0l
	 sSv4Zww4422CIz4H/r0sKk0np8qO5c+8bvN073i6mOQwdovA9yjZWCN3xTU1Ip0lox
	 g/puzDh67jhH7VkkjrgcvRiaaZDvY6L2o+V7w4p5lNhHIt6OlFI2sCYXo49bS0klae
	 oS/GXJWvJD0cg==
Message-ID: <sashiko-outbox-174963@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/21] perf test attr: Ignore the dummy tracking
 event and the terms it carries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016212102.76550-14-acme@kernel.org>
References: <20261016212102.76550-1-acme@kernel.org>
 <20261016212102.76550-14-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 21:25:05 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> With more than one core PMU the requested events can't cover all the
> CPUs, each cluster has its own PMU, so perf opens the software dummy
> event to carry the tracking terms (mmap, comm, task, mmap_data), leaving
> the requested events without them:
>=20
>   expected mmap=3D1, got 0
>   expected comm=3D1, got 0
>   expected task=3D1, got 0
>=20
> That dummy event is not part of what the expectations are about, so
> leave it out of the comparison, unless the expectations ask for one,
> like system-wide-dummy and test-record-dummy-C0 do.
>=20
> And when perf used it to carry the tracking terms, those terms can't be
> matched on the requested events, leave them out of the match as well.
>=20
> The terms are left out only where the dropped dummy actually carried them,
> from the sample_type it was opened with, a dummy that didn't is no reason
> to stop verifying them.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016212102.7655=
0-1-acme@kernel.org?part=3D13

