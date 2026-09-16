Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C0F5AEC6C
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583928; cv=none; b=dxRxcNyqC0pd3bmxeC1/lGowjusiwW17+SsILU2nK0l38GcxrGYZsW5nQi5AErvVyDKt0bls4LuzEx9DD6Jude3jKl0CZHwzBIgK63CqiMjp6rb13lH4Ud10wjcDSagWl4YSwvUtLkladTc4bWlI7LSzIhoG0TEzhlIsd83vZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583928; c=relaxed/simple;
	bh=NHWeOBMHitjIGnRLH6L18A+8WqEprbgKrpAf/ciQDks=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UNMcsSVOkEGtE241LusYctGQfgERhrIQOBYEcMbou/HG7sJL53APEv4ffbqoIKmJdv9EAQEFZpzizkFdkzQn9Cx0oSDWm4J+yB3W6TQC0z0RAsWhAGcBgM7C2O69YlsNJP2Jb3fam5bqpHTIxTfwTi5LfmKqiTq4h900iqmv9S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m99QOx4k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m99QOx4k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8351F00893;
	Wed, 16 Sep 2026 18:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583906;
	bh=V6I2F7jsjiZD40TLRpjxp7fHajvAndefk/W1IdoJXrQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m99QOx4klXAPffLQV7kd+2lfndnc/EfLol1Dimps6QrW9orSUKNVbz6jbYEgTI0xa
	 6k4lZ8Xzz2l63fMcM2AuQIq8lZDT6f0/+wH+OSmFKp8deokVyji2Xg+k3gdrm+a16e
	 dsKoHFrT8cCSvZjb/HMQ9LAiQf9KiPMhUlmlKRZVmjuAFSW4VN9v3pD/ShEWrNzLim
	 VFm0VJjPsNs7n8+TD/tU9IXk9fIB9muBBMWR/BRCoMyKYi+OwYrZhNCMqgKwHPkjoM
	 ZA/Y6hnbFD6PbeMtV0i/QIMMu4BVGES9r3LXHY0zQC3lR+D12dICaBbVYWchVvyZfs
	 jKVAd/Ng41rtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/12] perf test: Skip data_type_profiling when the PMU
 cannot record memory events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916183215.54305-2-acme@kernel.org>
References: <20260916183215.54305-1-acme@kernel.org>
 <20260916183215.54305-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 18:38:26 +0000
Message-Id: <20260916183826.7A8351F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The test records with 'perf mem record' in per-thread mode and its only
> guard matches one specific message:
>=20
>   perf mem record -o /dev/null -- true 2>&1 | \
>         grep -q "failed: no PMU supports the memory events" && exit 2
>=20
> A PMU that has memory events but refuses them per-thread falls through
> it, and AMD IBS does:
>=20
>   $ perf mem record -o /dev/null -- true
>   Error:
>   Failure to open event 'ibs_op/ldlat=3D0/u' on PMU 'ibs_op' which will b=
e removed.
>   Invalid event (ibs_op/ldlat=3D0/u) in per-thread mode, enable system wi=
de with '-a'.
> [ ... ]
>=20
> Fixes: f60a5c22967b ("perf tests: Test annotate with data type profiling =
and rust")
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916183215.5430=
5-1-acme@kernel.org?part=3D1

