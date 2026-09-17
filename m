Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CFF364933
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661720; cv=none; b=gY6QU5zowIus7iooCgA4gK82O+XQtWL2UWApIum6lO0DvhKZ0tbgKhFMqJyufINt4CIBneB7PEO9DTY/MPj0sVdF1Tuh03bsxTJZzJl6yOrbqaa1U8UmDZa/XshTx+fmCjo5WecCQ9MGUkzdH6DtlQeeOl8uqTDP/JN9ocJn0KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661720; c=relaxed/simple;
	bh=FoPwLY9Ij4T+i9IJPxOk1Qi587GEYiTosOpon0CZLNE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h2gkOyXsVBRHEGq+4Mh1JNo5HehjHfmpIjTaHlXMHgvhmXXG8EdQH9R8nTR/TAvmfCo876H59l81VmL9btfJJvGqcCbXatIz9bsg3NGDTovs4c77dCw/ee+WwRXwYvAAU197xreHhfJF0EUs92WK6+t9ul0H57diLoWY/v0DBPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpNCfo5J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpNCfo5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9C91F000FF;
	Thu, 17 Sep 2026 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789661716;
	bh=ZzGWvjRit7FE+lq2MFsD3CGS1eij8JlmqZzd5FTurcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GpNCfo5JMhPHMXYdKtiAozfmjMB8Lgd9p98sVkG1aOvcNrQqVBbhVieLLCsQZKAVU
	 iVLlmpm32SJDcfQcR+lfl4KDfMKT+rHpr1j05udyz2imcUU83ERno9Rryuo8L88wCg
	 kVrysZwdXI/ZkmyqBWXwrTy0BKrRB4GmPWumIpMm9uXtJqZTqzJpPQOgtSarOz18je
	 sNvTzFEtcW+8VKXqNiadLSNC8iCwtCGjIF7kALeFMidoXmh9NK8zkPA/ac01OwrOva
	 TJIeME72UZSBHXpcMyZjlEND8rtAy9NdOhjc6A2G267c14uUD3DPIrjh3b5ZO9hw9Y
	 +3hx3TflE6gxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/15] perf mem record: Request PERF_SAMPLE_CPU by
 default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260917155528.62607-15-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
 <20260917155528.62607-15-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 16:15:15 +0000
Message-Id: <20260917161516.6E9C91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>=20
> The data type profiling per-sample stream keys cross-CPU contention on
> sample->cpu; without PERF_SAMPLE_CPU that field is the (u32)-1 "no CPU
> info" sentinel, so same-instance accesses from different cores are
> indistinguishable from same-CPU traffic.  'perf mem record' already
> passes -d (addr) and -W (weight) explicitly to the record parser, add
> --sample-cpu as well and document it in perf-mem(1).
>=20
> The rec_argv array only had room for nine arguments per PMU plus the
> user arguments, not counting the up to eight __cmd_record() adds itself,
> which a new argument would overflow on PMUs with separate load and store
> events; reserve space for the fixed arguments too.
>=20
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917155528.6260=
7-1-acme@kernel.org?part=3D14

