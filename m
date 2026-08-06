Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20002D0614
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 12:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786020746; cv=none; b=etnqMW2f7JiXV4KBtn6KNQnN3om5MPpTtbs8YYjSJKKM1UQR8CVn9cwSbvN4vc0mqcYhpnCa765mS9q7qF4S8d1X6Bbx4m3+j4Z4gfNdz4muSYHiqNzMar6VMdhOtZ41/iHAEyEnDgeiXcQGxrQPkJ3hTInOUVpWUEl8p61H040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786020746; c=relaxed/simple;
	bh=ovv+MgvQrkdUYaSqKNpWQ6uZm7EOPj9he4WzvAqm53M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dMq6RpsYJJTkAttWw4Fq/5N40d1y3hxi8PjKcCfzqlX2YHjmALHS/tbdPwtgZyPALEXfgow6A7KAbCLGvf1AEF4lJ3UQjl+AiCp+gcR78VKRN/Ve+48S6HrH1oW/CFnoGsbCUXw9JlQZcXyy5uguVkppInoEYlI0MjJD6euc1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOfkqOe4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOfkqOe4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E07A1F00A3A;
	Thu,  6 Aug 2026 12:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786020744;
	bh=YunMOd5EyF0cZq7z4YcHpZc4Emh6A9IYd+4gQxBA/Y8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lOfkqOe44EcXB32CCIbhFP1tHsBcwoUlGSCYSg1xkuG+TfcJTI5bzyCajwsfjhIkp
	 d+llUsuQTyQOq4c6i1iHm2GKn5dyqBm8BcX3zM6kb9bLYjsoRMKWK3OW02NBqFcjKS
	 9zHhMDpZ7PFGgoYm/hqRjR2u76b9uLq+zC5OqUgRbGTP4JP+3UI/F3KnCRfuWReNeD
	 zkOs0XoLVIijilCFlgBjjeN+ybwknT2TdTKC+WxS2+dNeLJyheSVJRxxCFpaFCWgSr
	 XlHOrJtFecmSZIQ1sJus0QDLtd04qU6Hd65h5IMPToJUB5mQ6iThAcmuu9ne2FxlGQ
	 WE7cZT8etVZNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/12] perf jitdump: Check snprintf return before
 computing header size
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260806123604.271277-7-acme@kernel.org>
References: <20260806123604.271277-1-acme@kernel.org>
 <20260806123604.271277-7-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 12:52:23 +0000
Message-Id: <20260806125224.9E07A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Out-of-bounds heap read leaking information into `perf.data` via=
 `jit_repipe_code_move()`.
--

--- Patch [6]: [PATCH 06/12] perf jitdump: Check snprintf return before com=
puting header size ---
commit 8f494719852b9efdd2ae99317e82686b5aa7c596
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf jitdump: Check snprintf return before computing header size

This commit fixes a heap corruption bug caused by an underflow when
calculating the header size if a jitted filename exceeds PATH_MAX. It
clamps the length returned by snprintf() to fit within the bounds of
the event's filename buffer in both jit_repipe_code_load() and
jit_repipe_code_move().

> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 7efbaa07f1ba7..45f0e21b0e780 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
[ ... ]
> @@ -625,6 +628,9 @@ static int jit_repipe_code_move(struct jit_buf_desc *=
jd, union jr_entry *jr)
>  	         jd->dir,
>  		 nspid,
>  		 jr->move.code_index);
> +	/* snprintf returns would-be length on truncation, clamp to buffer */
> +	if (size >=3D sizeof(event->mmap2.filename))
> +		size =3D sizeof(event->mmap2.filename) - 1;
> =20
>  	size++; /* for \0 */
> =20

[Severity: Medium]
This is a pre-existing issue, but does this function allocate enough memory
to handle large dynamic idr_size values?

Earlier in jit_repipe_code_move(), the event is allocated with a hardcoded=
=20
+ 16 byte extension:

tools/perf/util/jitdump.c:jit_repipe_code_move() {
    ...
	/*
	 * +16 to account for sample_id_all (hack)
	 */
	event =3D calloc(1, sizeof(*event) + 16);
    ...
}

However, the event size calculation uses the dynamic idr_size:

tools/perf/util/jitdump.c:jit_repipe_code_move() {
    ...
	event->mmap2.header.size =3D (sizeof(event->mmap2) -
			(sizeof(event->mmap2.filename) - size) + idr_size);
    ...
}

If the idr_size is greater than 16 (for example 24 or 32 bytes depending on=
=20
sample types like TID, TIME, and CPU), could this lead to an out-of-bounds=
=20
heap read when the event is written out? It appears the calculation for the=
=20
header size expects the allocation to match the actual idr_size.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806123604.2712=
77-1-acme@kernel.org?part=3D6
