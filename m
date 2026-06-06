Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B759E4071E4
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jun 2026 20:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777157; cv=none; b=sIGNDQLlRdwh1TBiYxv0t8OfM3KL529M5wcgeXzcR+WDwAhuh/AhOvf/PGECSRiinmVmpf+FckD2PhcZp1SbS9kOcD7lcOTC3FG1jsZ81Rs7FDT/J8PX3JlnW+7Rytd0nvX8KtOzEBzqi8rVUpuPL193m6gAU4l0MsXhjzq98xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777157; c=relaxed/simple;
	bh=1/j2eUXTNmXDk2kDEhM5DoThCdzkWBVM+JhPdHEQzDM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cvrJOBj9kgqok4W05xa1d1wOY5GrFTpsxytjNHLVJz6geOeXp84Yec2jhgNUjfP+REPpPUJkWp51fF0F9X9+VOzrp3f9zkqA0Mc7ElUiFJT4UGjkVj8GVFr8sJKFDpoxa378v6Chfnid859OV7/CZzlNt+XMTSYQS17t0BCjXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hst0/IsY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hst0/IsY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266321F00899;
	Sat,  6 Jun 2026 20:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780777156;
	bh=yjiLg6nOlS040XwtgiQenZjC11K7SELCRh7I3F3Ze6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hst0/IsYW4n5iX+o0Eln/YEDvYkl61eB+gvA1hOE2/MpadZLW9K9OSxEyRKznU03T
	 0En07mXpSwEfbp3DgTUxODx8ARSm6RQryGEzcyP33QphHMVsBCWQGXJsDglpD+Inye
	 Qs/hJmQqAEQd8FdOA0f0R5HDaH1IX+k7rPfmwTC1360jTEFrvJf6iGLszm5h2nTTB1
	 //y0FH5vE359qPf8daXYxoqxOrOMGKTyNFdycWFq18lTlTHKqQ0//ky+lvKtSKqgpQ
	 qx8aK/C5t9PCuZjj5KVfqsz0o4k/iNGanfsePuhJysWlS9ikbwSwBaE7rdc19icoAX
	 fTLsEdIbd3BUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] perf tools: Fix int16_t truncation of max_cpu_num
 in set_max_cpu_num()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260606200601.1861227-6-acme@kernel.org>
References: <20260606200601.1861227-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 20:19:15 +0000
Message-Id: <20260606201916.266321F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Stack buffer overflow in `cpu_map__snprint` due to unsafe accu=
mulation of `snprintf` return values.
- [Medium] Integer underflow in `get_max_num()` leads to out-of-bounds heap=
 read when parsing an empty sysfs file.
--

commit 191c419f9d3237462ce91c226e3e3cccc5097d51
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Fix int16_t truncation of max_cpu_num in set_max_cpu_num()

set_max_cpu_num() assigns the sysfs "possible" CPU count to
max_cpu_num.cpu which is int16_t (struct perf_cpu).  On systems
with >32767 possible CPUs the value silently truncates, potentially
wrapping negative.  This causes cpunode_map to be underallocated
and subsequent cpu__get_node() calls to read out of bounds.

> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index d3432622b2adc..21fa781b03cc7 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -494,6 +494,16 @@ static void set_max_cpu_num(void)
>  	if (ret)
>  		goto out;
> =20

[Severity: Medium]
This isn't a bug introduced by this patch, but while reviewing
get_max_num() which is called just before this line, I noticed a
pre-existing issue where an integer underflow can occur.

If filename__read_str() reads an empty sysfs file (for example from a
mocked sysfs directory or malformed kernel state), it returns 0 and sets
num to 0.

tools/perf/util/cpumap.c:get_max_num() {
...
    buf[num] =3D '\0';

    /* start on the right, to find highest node num */
    while (--num) {
        if ((buf[num] =3D=3D ',') || (buf[num] =3D=3D '-')) {
...
}

When num is 0, the pre-decrement --num on a size_t underflows to SIZE_MAX.
This causes an immediate out-of-bounds memory read on the dynamically
allocated buf array. Can we add a check to ensure num is greater than 0
before entering the loop?

> +	/*
> +	 * struct perf_cpu.cpu is int16_t (libperf ABI) =E2=80=94 clamp to avoid
> +	 * truncation to negative.  See tools/lib/perf/TODO for the ABI
> +	 * widening plan.
> +	 */

[ ... ]

While reviewing cpumap.c, I also noticed another pre-existing issue in
cpu_map__snprint():

tools/perf/util/cpumap.c:cpu_map__snprint() {
...
    if (start =3D=3D end) {
        ret +=3D snprintf(buf + ret, size - ret,
                        "%s%d", COMMA,
                        perf_cpu_map__cpu(map, start).cpu);
    } else {
...
}

[Severity: Critical]
This is a pre-existing issue, but does this loop unsafely accumulate
snprintf return values?

The standard snprintf function returns the number of characters that would
have been written if the buffer was large enough, not the actual bytes
written. If the constructed string length exceeds the provided buffer size
(such as the 1024-byte stack buffer passed by cpu_map__fprintf()), ret
will become strictly greater than size.

On the next iteration, the unsigned arithmetic size - ret will underflow
to a huge value, and buf + ret will point past the end of the stack buffer.

Subsequent snprintf calls could write entirely out of bounds on the stack,
leading to a stack buffer overflow.

Could this happen when processing an untrusted perf.data file with a
highly fragmented or large CPU map?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260606200601.1861=
227-1-acme@kernel.org?part=3D5
