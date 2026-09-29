Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DA639B489
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665694; cv=none; b=MLxh4tkZdnhe8KQGsw95hwVCD9+7VtOwOHWORVLFmIJIgooqGTdARvEehHTexT8UAfXoiugbTqxo/RhK4gAlgIMSE5LV17ZFKynKlo3T6EiXgusxixPC68m/8/TwxUhnHlZDCAqkneiIRJRt4CDG70VStoUw7VhECVfjGR9I7eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665694; c=relaxed/simple;
	bh=wph2NWQ7Osfua+PNpMDTR9ngYDJi7RP3zuwX1eIb3Ds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lGINDl6Kw3f8jwY+qCViGLIAW0Sq7tJV+BynJ/QHFSYcMbkYaKRBMfDN5nOczV0nECUANDE5t0/s/iNArY14SMyfYEFWvbM67Xc0frBwxZWtziFLy3gG9jH8NZdewntR/uORIs7HYF4BjGrqdAjWom4qCmIhs06kUOgRFrDLDZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGi8SEHd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGi8SEHd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7B01F000FF;
	Tue, 29 Sep 2026 07:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790665693;
	bh=wph2NWQ7Osfua+PNpMDTR9ngYDJi7RP3zuwX1eIb3Ds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jGi8SEHdsuA2j1fjEiE0MYGpecySppfmSN3aIDI4lLS/H17PrJWysBwv3h9pkDtEt
	 2CqjDoTgbS5sA+sRCH1rBzn0qjkQ8SWJIDzGtANqizfGcupBqcWHpvbgmubWk4rNkQ
	 kIm4S+/migpz+YCIVF7UEy6XIMT6S8EODpTwpkpI9oH3mInT8IoXiSWHwC8BtVqb2b
	 lfg0lGpX8UBNaZx78UfncifNerAsQwqL7R1XGgNm5MrXt/NrmZxgnE+7d3nPbfMtBR
	 zAN81m6SsGPDcOzUEv4LM8vUrJ66lpqBTK8sKG/Mwl7SG7FjQob0Ce23RGIVxvOI7V
	 VBEmLI8478ccw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/9] perf evsel: Clamp sample_id size for ksymbol,
 bpf, and text_poke events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929065839.407062-2-irogers@google.com>
References: <20260929062937.374137-1-irogers@google.com>
 <20260929065839.407062-1-irogers@google.com>
 <20260929065839.407062-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 07:08:12 +0000
Message-Id: <20260929070812.EC7B01F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929065839.4070=
62-1-irogers@google.com?part=3D1

