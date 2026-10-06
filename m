Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECBE378811
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305408; cv=none; b=N9wb3B6EU0UcElfGFHoJauF0CuMim0NnBEEkHxIUbV72kR44uH6zu80aeekjRN7AYA+kvFQld7kcxjhri64and8zAVWnVGfQrG+H2JtOT9Vhnlo33gMXDa3918Xw5JeNUw+2XuCG30L9TSaMFRcpAxT2qDcN2tIx5nj50LzV4w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305408; c=relaxed/simple;
	bh=XdWVLu9sDP5uClSRZG6NkTi5fq91RirMIRywgvCBtBw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=pWKLNiO+lKcS3HRPvQwNDCtYz35mSUklDTVaBGOm0a4JanFk5VaabmL+IkqhNFAvzymtvGEZITBQtv23E4A6eCY8h9TYfEip7VdHtzxqBBOAaSegMa1K93TbD9NLFZBYavh8SSQ2Fw6QsyGTzhyiSSYNAT/oBC6j34WNnMo6JsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZBveLDD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZBveLDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64D31F0089C;
	Tue,  6 Oct 2026 16:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791305405;
	bh=rmDtv01T9MYhv+paMK8FenHcg93IFaczrHcvN4cRSNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KZBveLDDT9ORiGPLps8M3ID7LdpI2ze+Uk6aekc6sPViV21NlUrOvxVfxnNT+9CBT
	 P3l4zmFuSJs+mULVi+UOsaK2WEbJvlYF1IaKVWFhOwPg4aYLUWAuwoOUa8m8QaYeW6
	 ive7iMiGv/LShJjO1HBhwBie7sd1Eq7NDHq8K5TtI+iZ6HaBavmeGCJGydrojbOudU
	 wTiyYYXkt+fHEgfing1qQ5odft1gi17aOsvvMpkBJkfvp2jU0hrqMAKrwdkjQjF+/F
	 rVeUCKdo1eEjI56AuVZ1Bjyb8W2a2LuVqeE3wwTBekxdeyeeuIMkh6pZlt/A4wEsCt
	 k+Ieh9a3bT1kA==
Message-ID: <sashiko-outbox-162271@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] perf tests: mmap-basic: fix user rdpmc detection
 logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006-rdpmc-detection-logic-v5-2-b25c9d49baa1@linaro.org>
References: <20261006-rdpmc-detection-logic-v5-0-b25c9d49baa1@linaro.org>
 <20261006-rdpmc-detection-logic-v5-2-b25c9d49baa1@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 16:50:05 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] perf: System state leak when encountering unexpected user read sta=
te
- [Medium] perf: Logic bug in user_read_file_op() overwrites read failure e=
rror code
- [Medium] perf tests: NULL pointer dereference in perf_evsel__delete() on =
allocation failure
- [Low] perf: Missing POSIX header <unistd.h> for musl compatibility
- [Low] perf: TEST_FAIL is unconditionally overwritten by TEST_SKIP
--

commit 5162e68ee94e9013764b1ff51c5530feccced06c
Author: James Clark <james.clark@linaro.org>

perf tests: mmap-basic: fix user rdpmc detection logic

This commit modifies the mmap-basic perf test to use
/proc/sys/kernel/perf_user_access as a fallback for user counter access.
It tracks and restores the user read state, checks constraints for
different architectures, and handles file permission edge cases.

> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> index 208cd889f23db..2c3276e82da8f 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -12,6 +12,8 @@
>  #include <perf/evlist.h>
>  #include <perf/mmap.h>
> =20
> +#include <tools/config.h>
> +
>  #include "cpumap.h"

[Severity: Low]
Does this file need to explicitly include <unistd.h>? The patch adds calls
to POSIX file I/O operations like read, write, close, and lseek in this fil=
e.
Without direct inclusion, this might fail to compile on systems using musl
libc.

[ ... ]

> +static enum user_read_state user_read_file_op(int fd, enum user_read_sta=
te enabled)
>  {
>  	char buf[2] =3D {0, '\n'};
> +	ssize_t len =3D read(fd, buf, 1);
> +	enum user_read_state old_user_read =3D USER_READ_ERR_NO_FILE;
> =20
> +	if (len <=3D 0)
>  		pr_debug("%s read failed\n", __func__);
> +	old_user_read =3D buf[0];

[Severity: Medium]
If read() fails and len is less than or equal to zero, buf[0] retains its
initialized value of 0. By unconditionally assigning old_user_read =3D buf[=
0],
does this overwrite the -1 error state (USER_READ_ERR_NO_FILE) initialized
above?

Returning 0 on error seems to trigger an unexpected state failure later on
in the test.

[ ... ]

> @@ -256,8 +284,28 @@ static int test_stat_user_read(u64 event, enum user_=
read_state enabled)
>  		bool mapped =3D false, opened =3D false, rdpmc_supported;
>  		struct perf_counts_values counts =3D { .val =3D 0 };
> =20
> +		if (__is_defined(__aarch64__) && enabled =3D=3D USER_READ_ENABLED)
> +			attr.config1 =3D 0x2;  /* Request user access */
> =20
>  		pr_debug("User space counter reading for PMU %s\n", pmu->name);
> +
> +		if (saved_user_read_state =3D=3D USER_READ_ERR_PERM) {
> +			pr_debug("User space counter reading for PMU %s [Failed to get user r=
ead state]\n",
> +				 pmu->name);
> +			ret =3D TEST_SKIP;
> +			continue;
> +		}

[Severity: Low]
If an earlier iteration of the PMU loop encountered a failure and set
ret =3D TEST_FAIL, does setting ret =3D TEST_SKIP unconditionally here over=
write
the previous failure state?=20

This could mask test failures on heterogenous systems where multiple core
PMUs are tested.

> +
> +		/* Check value is in the expected range */
> +		if (saved_user_read_state !=3D USER_READ_ERR_NO_FILE &&
> +		    (saved_user_read_state < USER_READ_DISABLED ||
> +		     saved_user_read_state >=3D USER_READ_MAX)) {
> +			pr_err("User space counter reading for PMU %s [Unexpected current sta=
te %d]\n",
> +				pmu->name, saved_user_read_state);
> +			ret =3D TEST_FAIL;
> +			continue;
> +		}

[Severity: High]
By using continue here, we bypass the loop's cleanup block and the call
to set_user_read(pmu, saved_user_read_state) at the very end of the loop.

Does this leak the state modification and leave user-space counter reading
permanently enabled or modified on the system?

[ ... ]

>  		/* Make the evsel. */
>  		evsel =3D perf_evsel__new(&attr);
>  		if (!evsel) {
>  			pr_err("User space counter reading for PMU %s [Failed to allocate evs=
el]\n",
>  				pmu->name);
>  			ret =3D TEST_FAIL;
>  			goto cleanup;
>  		}

[ ... ]

> +cleanup:
> +		if (mapped)
> +			perf_evsel__munmap(evsel);
> +		if (opened)
> +			perf_evsel__close(evsel);
> +		perf_evsel__delete(evsel);

[Severity: Medium]
If perf_evsel__new() fails and returns NULL, we jump directly to cleanup
and call perf_evsel__delete(evsel) with a NULL pointer.=20

Looking at perf_evsel__exit(evsel) inside perf_evsel__delete, it
dereferences evsel immediately without checking for NULL:

tools/lib/perf/evsel.c:perf_evsel__exit() {
    assert(evsel->fd =3D=3D NULL);
    ...
    perf_cpu_map__put(evsel->cpus);
}

Will this result in a segmentation fault if perf_evsel__new() fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-rdpmc-dete=
ction-logic-v5-0-b25c9d49baa1@linaro.org?part=3D2
