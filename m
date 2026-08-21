Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1148443A88
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306488; cv=none; b=KNarVOYPMqeM9o/1MJ778iinRgWPJbP0H0pvc3mp6D1F3MmB83NnvZmwlWzE1LDVoI/cGVvJA6WGdNxwL05lm3yb+sQMw0QF+HECV8MHWBHssf9jVsijnTh4ZNRRBjF/TfhxSwybRrXdVobGu0hAF8OpduedKxlmKv8q1JqNAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306488; c=relaxed/simple;
	bh=IgsthnuIFdP+cJylTfKOkTuZ5G8WW3VywZde2oDr/UI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aaoYscmAkfVqVR4OI9qqZ1MD10zQwLylo+XFqucAjIHW/OToTc0Gp2c+Bq2MmTnNaWyqSk7O0Lrkwu7yC4mHeigjTAYIIBgFDANHqVtbGr+nUMPMxkdkTCVDbpyqgGKRflxWe8Ab7tQyXW9VAxykUDTJePkyU0ZYMhHTYCb4elU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTTv+nyY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTTv+nyY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DDB1F000E9;
	Fri, 21 Aug 2026 10:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787306475;
	bh=IgsthnuIFdP+cJylTfKOkTuZ5G8WW3VywZde2oDr/UI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KTTv+nyYin4PaOvwtKayHoU21LB8gQhImobXmRrhPy9Y7gnwi+K0y0UTFn7N/FFsy
	 dXu55g6yP6RvOJf5ftVvgDc2dj8vLUwQh2gFSmgIQTHVAXPrePzozx1F4GC1TTO5SX
	 EfI7RmgicD/hDT2cztcveyA2F8QMzbKkUCWIMRoMqOucN36QqSUV+8l5z1u7jSAt9K
	 OKJMX5+t3OK5nTIKEdHM6gnX69jFk2nI8DhSUioC21sTIbLRXqFKnJycmTG0VsNM87
	 PQ8UEptcy5N6mlxSvCMJ2Tvchi9LP12gPnjLJSrXI67q2HKExglcQXqC0lz+niFGv+
	 LDFn0+hsDlFrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/14] perf cs-etm: Don't print missing buffers in
 snapshot mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821-james-cs-unformatted-per-thread-fix-v2-10-00c4fd0701b4@linaro.org>
References: <20260821-james-cs-unformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org>
 <20260821-james-cs-unformatted-per-thread-fix-v2-10-00c4fd0701b4@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 10:01:14 +0000
Message-Id: <20260821100115.44DDB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> The driver produces lots of AUX records for trace data that was never
> captured in snapshot mode. Downgrade this to a pr_debug3 message as it's
> only an error in normal mode.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-james-cs-u=
nformatted-per-thread-fix-v2-0-00c4fd0701b4@linaro.org?part=3D10

