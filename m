Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEC7435EF0
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664062; cv=none; b=WWcryGLjYVUE3PgZq6JOXYVk0E7334OrNuUTUwOHkw9x5Nd8++WWMyislpLD1cCgCL7bIj46GFn/A6d+Z8/pvBjIIAeyroHaBKxsxs37X5gq+UrcSwY2PONx+AsE5+D7C96RDZS672ncJgaAr5TTyV+1wYyy6uxezy28rfWqcaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664062; c=relaxed/simple;
	bh=vrcgqtaXszkyVsCYomVgNjjQ6a+HZQbWAcYj3up+JOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BCnCFnHw59Hyrs/545UPmfVP78yJQSnxaUw2BvYrpJwxMQaTBoc7+A72kCciWq9Ev2T25/FGsiifkpmqDkvpo6yKzLEL2+cF3KazI5YzguOqH+NqNHlFDiJsBeMzs2I+prH1TV8rabHmC3MMIiaff3l6rgVPszBuLtW3CXMvGVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQgn4Bxq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQgn4Bxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F180C1F000FF;
	Tue, 29 Sep 2026 06:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664061;
	bh=vrcgqtaXszkyVsCYomVgNjjQ6a+HZQbWAcYj3up+JOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XQgn4Bxqj/bqYq4qLoN+HaYiLfjYqNc92tlEaomcEIJ29fRnL2IsIitdq3BQJQGTV
	 sIfnimd+rGdZLN8/sMvlFubwjOjMCQjITMuembE6FTdGXBpoJhtK08ExBU2y1osOEy
	 UU9fnUrEBluLwAllI2kRK1ruJ0oceun+7b7feEcXSBk1DQUAcZ/EvmwrujvLhY4VWL
	 m68PmVFloOIe7HkXD5t6DrapSUdXE/NglUi2mfe699zGE8hBs9mrhEYqnhgZjZv9Be
	 ST6g1D3SS0A2wpZXrbShymcDxEqpeW9NBtQ+XTTzrb3f0+hO8vVvOGqsbPmT4pk0ai
	 /5q7fge4gS8gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/9] perf evsel: Clamp sample_id size for ksymbol,
 bpf, and text_poke events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929062937.374137-2-irogers@google.com>
References: <20260929021913.56010-1-irogers@google.com>
 <20260929062937.374137-1-irogers@google.com>
 <20260929062937.374137-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:41:00 +0000
Message-Id: <20260929064100.F180C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> On kernels without the fix ("perf/core: Restore header fields in
> sideband output callbacks") to restore event_id.header.size in
> perf_event_ksymbol_output(), perf_event_bpf_output(), and
> perf_event_text_poke_output(), concurrent perf sessions cause those
> sideband records to be emitted with header.size inflated by multiple
> id_header_size increments while the single id_sample is written
> immediately after the event payload. Indexing backwards from
> event->header.size reads uninitialized ring-buffer bytes at the end of
> the record, causing evlist__event2evsel() to fail with -EFAULT.
>=20
> Add evsel__event_size() to clamp the effective size used to locate the
> trailing id_sample for PERF_RECORD_KSYMBOL, PERF_RECORD_BPF_EVENT, and
> PERF_RECORD_TEXT_POKE to payload + id_hdr_size while leaving
> event->header.size intact for advancing the ring-buffer/file stream.
>=20
> Fixes: 9aa0bfa370b2 ("perf tools: Handle PERF_RECORD_KSYMBOL")
> Fixes: 45178a928a4b ("perf tools: Handle PERF_RECORD_BPF_EVENT")
> Fixes: 246eba8e9041 ("perf tools: Add support for PERF_RECORD_TEXT_POKE")
> Link: https://lore.kernel.org/r/20260929014206.4175245-1-irogers@google.c=
om
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929062937.3741=
37-1-irogers@google.com?part=3D1

