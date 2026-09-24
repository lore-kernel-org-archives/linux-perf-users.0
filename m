Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882AF4B26FA
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269681; cv=none; b=hsykdgsfuBsjtA2AjSjBlptkVgnlTvzEkTPqJhZo6MrSTB2/DWqRPnnk3XxmCj33YnU3aIVr4xi670wJASeGsJGjfJUcUVcPrQPkyi96ZG6mKMPW+bRLV8N1ccr4scvcdU5ss8KRr2HGRL8/MR8whTA6YyKVEJ/jpuxh+ogIj38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269681; c=relaxed/simple;
	bh=8hV04fbBDmxbyUwm6oYMDFz5/sU6+nvPQ6ovNapp2GI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SX28AxNEC56QKdvr2QwMGVgU1HZZIHGrR5+LOLwYLS1DD8gUNJ+ZJpAMEgKrq+2iFoClPTJsA2fDRwRnj598lqOK1zOtbWgfmwvvE3TNbUzTpUhRNlVFgVFCBsv2zj0l/Tnqkw47P+yE54mIpd589WE9QUcdyyCUfu5pPnpdwKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y32MR/kt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y32MR/kt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15541F000FF;
	Thu, 24 Sep 2026 17:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269680;
	bh=JmRBMniF22kYC1BGef/KT0pBJRQ1NFdysOjC9+GCEnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y32MR/ktPtqlHlj17pIkcR0GM8gX288yrrGEVrApmFggu15KFbzO/ZAugjZdIowFI
	 2neMXsp4OfFSeqJl40p+V1nDaxOdtzR1c3KFF0HhZWqU6GvCYP/bIazywcc1wErDti
	 emV+OwLGiVvZbeEgxhjnjUsZXEhbx+7Gt7yKtQC27TafbkTJkneA9ZRda3XTWI5dV7
	 fnkKBfLbXUrP5kK91fGj1YyTlrr2FI+PioLxmBa+LDWlIuVPmzhBZdKSvEpsWXOF8i
	 Xr12DPBVbxCOUkLCzR2jdZXM+9/g4DeKs5oru0c4nGisASqrNE7KaJMM+1qxlHrAwx
	 OzltwSTUWxH4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/26] perf vendor events intel: Update ivybridge
 metrics to TMA 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-12-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:07:59 +0000
Message-Id: <20260924170759.F15541F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The updated TMA metrics were published in:
>=20
>   https://github.com/intel/perfmon/commit/f9358e8da04bec945d8023e3f9b20a8=
87ad46c45
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D11

