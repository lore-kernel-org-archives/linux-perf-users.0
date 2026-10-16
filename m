Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DF93BFACE
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Oct 2026 22:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189295; cv=none; b=FJxG+1/gs4SkRfXe1RmN4+a1WHfSAO6C2hZ41vMfBTMPARg8TBUuhvxZlfGf+vLuUvhQ4hDQUVFvU3LM2RDMl0U90hMs2UjMcUpNNWpQBd5fXtO6HW0wyEgxq4OXoMx62rrdbWHshCCU3ME4mHUeLMevJVkq0oIHuSqTBQ8Kc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189295; c=relaxed/simple;
	bh=1OkCbiGNn22R4rXI1kzvq7ge7avdNgm4oxi96DXkE7s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Qi2+cO5m/Tpj8rO2qmwjqPdvQ5f6heiX+pvtnVYfAGREjXzo+D6VFg3LgxLV6GCuriGCwjtqasFbOyuVK9Kd1q83tnpn3HSAFF7K8SLXtq7pSjZ6EzncZGcySUoVtVqQGxpxEL5FsYnz+lqdg4NJUcv4Ek2Pqk9G8cMwyBrXEnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Orbs09ol; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Orbs09ol"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 578111F000C4;
	Fri, 16 Oct 2026 22:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189294;
	bh=1OkCbiGNn22R4rXI1kzvq7ge7avdNgm4oxi96DXkE7s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Orbs09ol3mQqvcy/kPok9+aRkQkgsVMfjZQP3Y4bCn2xpJ9v8ry+acBSvJXaV7qWe
	 I6VLYj3/x2XAo9LJrqdQU5pjEzSCI9FcPXHAsQFHnYDBu15cexvlATnnARyuwL952t
	 AxgEtA6wBnR6lC9KXuzI8/5jJjjVlTrEGIljgpppTZjxQlStDGhzjaVATJf7rKxltj
	 KPJC9l9Ta0uNe/vBzeVe0Uyh/BiemLOXwtSO0iE5nEsBeAV1qKV1sx/IgNnvvzQAj+
	 8JxewBO5Aa5T4JYfP3To5DcRZV0MthF0r+8KUb/8OaC9Qi9xqeB9nNOwDsaMl3GWEb
	 u2N3Pjt9whZoQ==
Message-ID: <sashiko-outbox-175006@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/17] perf dso: Expand context analysis annotations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261016221700.1282659-12-irogers@google.com>
References: <20261016173106.679725-1-irogers@google.com>
 <20261016221700.1282659-1-irogers@google.com>
 <20261016221700.1282659-12-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 22:21:33 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Annotate struct dsos fields with __guarded_by(&lock), annotate dso__data_=
open and
> fd_limit in util/dso.c with __guarded_by(&dso__data_open_lock), and
> tighten __dsos__findnew_id() and __dsos__addnew_id() from shared to
> exclusive lock requirements.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016221700.1282=
659-1-irogers@google.com?part=3D11

