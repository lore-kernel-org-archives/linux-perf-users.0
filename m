Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B114C67F6
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349447; cv=none; b=L1a+QKREM+7o3hz8JUSbzxk6V7ey6PKTJ9kOvPcjXG6kgQI+4iXz906CXb+MXZk6rCtOOMzj2DZNJyY4xn4SzxabU/F9xNr1IUKL/snEdZGH1pOP5pwMdxKLP9C2LTUq134MgU0BPc9A7zZdyJFn8jHr/0vdxR9fmb152qBe+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349447; c=relaxed/simple;
	bh=LXkuLlgNqZHpglBgfqLne/YZku2qWbqqPfGonz5BqwI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iKGU6oauYPFBXxPD+dF6gBpmbTnVa7q7WPooizQRmD9LZTWwJncPMqcET2whcNK6biDPHxQ722XlrlQBoZApI/MJz0rzASntEjDW9ps6BldtcxFV7W764LjU2sNzUayjD0XxQOzCZYpu/YY/uc9sKugXe/I6CESB27i2/MYDAbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O20SpE5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O20SpE5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546621F00893;
	Fri, 25 Sep 2026 15:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790349441;
	bh=DlgiKUF8jL1IIzms4xWACsWHYokiga+VLaAXGCI0UAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O20SpE5leibru95T+qNrEUa1kOweXwQGcVepgf+WrMVGXrZ6fgBpMA9Uuij3lN9gw
	 36HEdiZYnjVzFcFCVyPjgqhjVku0IfPZ+hf5hRYrS/cGK0xA5taF1l4X02F4GANQx4
	 hfqYg4VofMsZ7nwf6Y/7zre0Cv+3jO5qzmVjGG6ypiA8rJTq050SCe/9GrBgq3rgZt
	 tAbk8jBWcCf114wlrMmAocOb8f126/MYa4sZ3oooz81cP5bCRpligKAEykXvG59Aot
	 0iGXoQFzEB/Vx/NL8vmg+w//oOJiBEALxTEnucLlBJ5aM7ssOQ/gvC83j8aIVRlbA3
	 ms4n+TPZHCGAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] perf mem record: Request PERF_SAMPLE_CPU by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260925150657.1826942-6-acme@kernel.org>
References: <20260925150657.1826942-1-acme@kernel.org>
 <20260925150657.1826942-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 15:17:20 +0000
Message-Id: <20260925151721.546621F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925150657.1826=
942-1-acme@kernel.org?part=3D5

