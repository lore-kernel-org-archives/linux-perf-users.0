Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4ED36654C
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940207; cv=none; b=qMSeFdS6oOFICANdR3lXmU24dcNeUAjFclhsghZl9KoWX2a8oavB5cMXmI9lb6S8AVowdLPBRRW4QgMMbRxYRqB1zqwqkvSzdVLabx2RWWcNcdlfEyVj0mdU5FyXFQ4PH0jWFToC2F4Fyii7Zdxs/DOqKNcEV4Tx2J7HLzOmlkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940207; c=relaxed/simple;
	bh=sIaPLjzqft4JpSIuOR6jNBf1IOsgcaJiZ1hQ18gXTac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rjXRhc0M1sW8od1OsaNanbCMDW11jCvT7DOsEpREPmN++46HuyrsBWot3dreKJjOl5m+Nzt/w3aHsbJF6Bujr66CZnPrauo+N28U7o5UjkHWWjzJRyoLY7+DXFuQ2sZ47eGzz7SsRx714an+H1HYkZItE5gcBm68fNeNC0KBpNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLVI29bV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLVI29bV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F0D1F000FF;
	Fri,  2 Oct 2026 11:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790940206;
	bh=sIaPLjzqft4JpSIuOR6jNBf1IOsgcaJiZ1hQ18gXTac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nLVI29bVhBjvlRjtpoKEsIYIixpLFZRqCJNkIyUAcj2+JW3+5eIAYaA0jA3aFU6GK
	 t+u/nvvh+/6fBPg+OeYN9/uzXqs04E+q/Ujn1tOBwh4hFbMaHoXvrdMImdUXA6mjVy
	 DI3pX69jCJcmxZEB+q8e8GHUVQ1f4hRK3Kxt7P3FfIPSo3enEQ2I2LEswOpWJxGzTF
	 Ef1lewBQ1vr1unDJWSTzzwdJY2SDnJYpqX/UCMi0izjJGpQF9hMvozjRhumVM8Vdm7
	 v2Y61R4y8ih7ZbrgeDQhGYlAcspQvHEzbLfJJ4e775ocFXdg8Fye29qwlI2I2iMlsS
	 zvxx3wX+zeVaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] perf cs-etm: Synthesize missing HW_ID mappings
 for raw trace
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002-james-cs-hw_id-output-failure-v3-3-1d8b6ef339c8@linaro.org>
References: <20261002-james-cs-hw_id-output-failure-v3-0-1d8b6ef339c8@linaro.org>
 <20261002-james-cs-hw_id-output-failure-v3-3-1d8b6ef339c8@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:23:25 +0000
Message-Id: <20261002112326.43F0D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Leo Yan <leo.yan@arm.com>
>=20
> The CoreSight driver emits PERF_RECORD_AUX_OUTPUT_HW_ID via
> perf_report_aux_output_id(). If the perf ring buffer is full,
> perf_report_aux_output_id() can fail to emit the record and return
> silently.
>=20
> When at least one HW_ID record is present in the file, perf skips the
> legacy metadata-only trace ID mapping path. Therefore any raw AUX queue
> whose HW_ID record was dropped can be left with an empty traceid_list,
> and cs_etm__create_queue_decoders() will not create a decoder for that
> queue.
>=20
> Fix it by ignoring all HW_IDs for unformatted queues and always create
> one decoder per queue unconditionally. Trace ID is unused so we can hard
> code it to 1 (0 is a special value used in
> 'pending_timestamp_chan_id' to indicate not pending). We also need put
> the same trace ID in the CPU metadata because the relationship between
> CPU metadata and traceid_list is bidirectional. Moving
> cs_etm__metadata_set_trace_id() into the mapping function solves this
> and simplifies existing code. cs_etm__insert_trace_id_node() now does
> two things, so rename it to a more generic cs_etm__map_trace_id().
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-james-cs-h=
w_id-output-failure-v3-0-1d8b6ef339c8@linaro.org?part=3D3

