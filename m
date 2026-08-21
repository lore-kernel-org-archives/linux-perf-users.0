Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448683B14A2
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306776; cv=none; b=ol5sbwgKfoBbuic/R8B6eIlGBp8pPGdH/Jhz0Ms6wFlZI/b22IrAxe4SQ+o4wrQiMD1L4QWt1nFV5MgOg5pKxIQjXTOLUzvqvBmXejMxdFpmSWbD2d7lBU8sNRuaukVzZNeRo6QypcQ/BSedTTFOfR5qyx4GP0MamvSFCBzVleI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306776; c=relaxed/simple;
	bh=mN4Mz/VwiRSSekhn6ZcT6R81s1IJC+k+7XO+BM7Ux9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XkJG19sTiRLqfo6Vg4GlQvZSDIRb05GYEpCX3tW6J7jAPv7hgYnwh1M93QIZsPcBeg/KkaLTnyFrOuUVE4oydstHYZfCza7/mOhJnO8lbbdAmU8qAjM9iYp0uyElOR/PUwucs+lWkZ8LAvnq35vITGuUvVZ8ytWP9AD0SLS/y9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtPp90SL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtPp90SL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD30D1F00A3A;
	Fri, 21 Aug 2026 10:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787306762;
	bh=mN4Mz/VwiRSSekhn6ZcT6R81s1IJC+k+7XO+BM7Ux9w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KtPp90SLxVbYQdtiD5p8IXw0/UvwdxbXDWwD7MeThVfCrLClKncQx8x0agLKFyQQO
	 czdm+uFXBTWN1pzDlm2NuYgy1S2U3vA8aioYgP3h2NKQBtAwPe0H/ZVQqaJCdOg3Tt
	 hYYdf3Gl6TMlVHp/NlkB8OoBAiKXpZvqWUL3kp8aTXNHCaCkGYhUk1mOQG3Jj8BCeE
	 oIaIDQQVm+7HQc1bJ65hVgnff+N1f2tVHt0JBJ/PMW+aGkSa8hAgQePoPtMk/DdHGI
	 4ygs+vNrS5dGvnqA74XsxduovP/vq0u6NtxOwkHp93eam4JRaGL5+WfvhB1PWj/iOm
	 WG7O8QdUd77Ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] perf cs-etm: Synthesize missing HW_ID mappings for
 raw trace
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-hw_id-output-failure-v1-3-9d532ddabcc3@linaro.org>
References: <20260821-james-cs-hw_id-output-failure-v1-0-9d532ddabcc3@linaro.org>
 <20260821-james-cs-hw_id-output-failure-v1-3-9d532ddabcc3@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:06:01 +0000
Message-Id: <20260821100601.CD30D1F00A3A@smtp.kernel.org>
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
> Backfill missing mappings for non-empty UNFORMATTED queues whose trace
> ID map is still empty after the HW_ID record scan. Real HW_ID mappings
> remain preferred and are not overwritten in case someone is trying to
> link what the kernel outputs to the raw trace dump.
>=20
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-h=
w_id-output-failure-v1-0-9d532ddabcc3@linaro.org?part=3D3

