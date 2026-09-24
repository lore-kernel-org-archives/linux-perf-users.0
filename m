Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FFA4028E8
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285856; cv=none; b=VasHcvVxYj9g9gfJ+SfmYghqQQrUg1bRlhamzqIWUiPRhrQHMR9fhDTFJ0091yPcYhQynYSBynHpTghZY+xBi2uCZjRI34HCeSoYvQu5H+Z5AorRfaxykZe2jgQb+D8AbR0o+6+mUXBL4TBuGEI7+LAEzuYum9Ec5wMaSipyLv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285856; c=relaxed/simple;
	bh=BHIT508pD7hlFr1l2FD+ijR/jhc1tg9U0ZFE5XFdqkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h/YHTlANAdoB8P+KE0/njFXHt1620p0dK2WeDEKZeNquiaheyPUuA9HoxraXEzaos7EHaKESK8OfLzcnHE242r0hLrbqnObWCCUu5VLMRzN/Qv1Eznai4FVaiIcZZ4kpA6l5Wc8Gt8Vpn1idgWN1Rnm2VHVlENhcQdhLepTU2MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF2V+8Iy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF2V+8Iy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FC01F000FF;
	Thu, 24 Sep 2026 21:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790285855;
	bh=LNXiw6bXPFwt7n7BbeJABVyIU/YcH6pcdKEQZywHnOk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eF2V+8Iyz0ifgD6eAjpnzr4OBi9R8vF1XDe4asprmmSrPZbnL3IbefqH9LXh8N7Hn
	 4gyQRpMMLFLl8UcuETYtNY0FX0inUowV8o9yGtSXmg8Ja0kzpigNAfXz0ql8Ee/HXK
	 L9urEkv2azZDFaewT+UyGd8hlU5D72a3YOkYu1uohAo48qszcAgG/0QePXIIrKk2b8
	 DF408ribDI1bBR3dQ7uSZ60+R3bZBRf27UNbZCP3ysYzOPBbD7u9Jwm1F25dirOIkW
	 AN/uxuVleI588DqOof1dZAlRY4qFNVI2w7Iy4D/AZn5EV+8KPQS6hD4b/+G4JT3frm
	 FwuzuEQ+jSogA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] perf mem record: Request PERF_SAMPLE_CPU by
 default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924212809.1733663-6-acme@kernel.org>
References: <20260924212809.1733663-1-acme@kernel.org>
 <20260924212809.1733663-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 21:37:34 +0000
Message-Id: <20260924213735.12FC01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The data type profiling per-sample stream keys cross-CPU contention on
> sample->cpu, which without PERF_SAMPLE_CPU is the "no CPU info"
> sentinel, making same-instance accesses from different cores
> indistinguishable from same-CPU traffic.  'perf mem record' already
> passes -d and -W to the record parser, add --sample-cpu and document it
> in perf-mem(1).
>=20
> Also grow rec_argv: the new entry overflows it on PMUs with separate
> load and store events, as the space for the fixed arguments was not
> reserved.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924212809.1733=
663-1-acme@kernel.org?part=3D5

