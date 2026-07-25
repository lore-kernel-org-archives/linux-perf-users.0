Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD20938910D
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784969812; cv=none; b=VXQOGEUqqrLGagPHpVenVx7MixRpSZFJCkUJsow9sOlCINZ/XeJ2R1w+zJVbxPHJ60/o/GINiyF102CLAEbPM3Y/jkDdW99/eSbBlvy0X4CxYCsUx1t5y14yS3gLMtR8qKmh5zgTyN3P7IwYIcAy1FQMhMDukUFj8J0tf+E0KF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784969812; c=relaxed/simple;
	bh=KBBx1b+Kmayo5i3hIEB2GANMZursIqM296AJqNtcEMk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VWvnDJI7qitZhXR2ubcl+rG3TG5dEhVMpItBD6i2PWiUqbDHc588LDJc+amtyC/obHhTwinLi2GS9vBiY9b+3PJ9snVqjeD/rjMFiciyr7gwzd7+JCbhz6XNAY4rOa28QSWfCv5UhEykQ5A3ucT4kfxXOTWDBkAfVRbefJ9MHlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMW+n0AG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMW+n0AG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648B11F00A3A;
	Sat, 25 Jul 2026 08:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784969811;
	bh=4bd0hYcHwjcdx74ZDlAvmBFe76EZfo1D7XSELT1QJ0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hMW+n0AGzpCN0kRlyiQN+xH0zLLyzH5nL7jjZjcW9TUkTwsuRYYeYQQZ7ZzHGObo8
	 cm4bkT5CEpGipwMO7t9OMxmSZ1THeXzY8AI6b17iQeoQ0SI0AHZidZqfOxdjVf7BBs
	 uUVU7Yy9kFe5zxKiDxri3mtrd7crwTzzBYKG4O48oBRwxFSZMB5PtM5V19yBhXWxES
	 bZcJu8Us25V2QTptfbvQJCrhoQZymcstKl9eXj8/+gbiHFDPewfqblJEIpdNm7M4nJ
	 F8LAe20BVeAhMbpvPYUbWyENsh8b62OIsfwVSZ/taFwG02mKMDqe8BVXGnfPOEQ5DT
	 oSf5Obyv1eqqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf test sample-parsing: Validate PERF_FORMAT_GROUP
 values without LOST
Reply-To: sashiko-reviews@lists.linux.dev
To: "PVS Narasimha Rao" <venkatasuryapala@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260725084704.15463-1-venkatasuryapala@gmail.com>
References: <20260725084704.15463-1-venkatasuryapala@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 08:56:50 +0000
Message-Id: <20260725085651.648B11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The test setup for grouped reads without PERF_FORMAT_LOST valida=
tes garbage data because it provides a standard C array of structs rather t=
han a tightly packed buffer.
--

--- Patch [1]: [PATCH] perf test sample-parsing: Validate PERF_FORMAT_GROUP=
 values without LOST ---
commit 803c0b64d4e8c311df29991bbbdd74726b85a1dd
Author: PVS Narasimha Rao <venkatasuryapala@gmail.com>

perf test sample-parsing: Validate PERF_FORMAT_GROUP values without LOST

This patch updates the sample parsing test to validate the value and id
fields in grouped reads even when PERF_FORMAT_LOST is absent. It uses
next_sample_read_value() to properly navigate the variable-sized group
entries during validation.

> diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-=
parsing.c
> index 55f0b73ca20e0..e44b01e5cd14c 100644
> --- a/tools/perf/tests/sample-parsing.c
> +++ b/tools/perf/tests/sample-parsing.c
[ ... ]
> @@ -86,10 +86,27 @@ static bool samples_same(struct perf_sample *s1,
>  			COMP(read.time_running);
>  		/* PERF_FORMAT_ID is forced for PERF_SAMPLE_READ */
>  		if (read_format & PERF_FORMAT_GROUP) {
> +			struct sample_read_value *v1 =3D s1->read.group.values;
> +			struct sample_read_value *v2 =3D s2->read.group.values;
> +
>  			for (i =3D 0; i < s1->read.group.nr; i++) {
> -				/* FIXME: check values without LOST */
> -				if (read_format & PERF_FORMAT_LOST)
> -					MCOMP(read.group.values[i]);
> +				if (v1->value !=3D v2->value) {
> +					pr_debug("Samples differ at 'read.group.values[].value'\n");
> +					return false;
> +				}
> +
> +				if (v1->id !=3D v2->id) {
> +					pr_debug("Samples differ at 'read.group.values[].id'\n");
> +					return false;
> +				}
> +
> +				if (read_format & PERF_FORMAT_LOST &&
> +				    v1->lost !=3D v2->lost) {
> +					pr_debug("Samples differ at 'read.group.values[].lost'\n");
> +					return false;
> +				}
> +				v1 =3D next_sample_read_value(v1, read_format);
> +				v2 =3D next_sample_read_value(v2, read_format);

[Severity: Medium]
This is a pre-existing issue, but does using next_sample_read_value() here
inadvertently cause the test to assert equality on misaligned garbage data
when PERF_FORMAT_LOST is omitted?

Looking at do_test(), the original sample is initialized with a standard C
array of struct sample_read_value:

tools/perf/tests/sample-parsing.c:do_test() {
    ...
    struct sample_read_value values[] =3D {{1, 5, 0}, {9, 3, 0}, {2, 7, 0},=
 {6, 4, 1},};
    ...
    if (read_format & PERF_FORMAT_GROUP) {
        sample.read.group.nr     =3D 4;
        sample.read.group.values =3D values;
    }
    ...
}

Since this array always has a 24-byte stride, but next_sample_read_value()
advances by a 16-byte stride when PERF_FORMAT_LOST is absent, both the
synthesizer and this validation loop end up reading overlapping memory
instead of the actual struct fields.

Could the test setup be updated to provide a tightly packed buffer so that
we validate the actual fields rather than falsely passing on identical
misaligned reads?

>  			}
>  		} else {
>  			COMP(read.one.id);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725084704.1546=
3-1-venkatasuryapala@gmail.com?part=3D1
