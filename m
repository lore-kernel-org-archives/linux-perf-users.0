Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F8538A701
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950700; cv=none; b=ThgiaWah5c9Hk6gvgXXAhHEHY/f7U411REsLWeGD7rXMGYC1ZUhDeF4pkNKt1iq1ITmFAWK+6EmD3q0duvBNW++ZHLu9qFL3xPHI4fq2twerMEpUxjpHMjeCQIXX3p29YpmZxSgdZGiVx9fR9eN5u2ISKqVLcPC6TwJf5oMTni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950700; c=relaxed/simple;
	bh=6vlUqEES72apUWYH0hxxkxab4ffnHdukCnF6Ey6fe/g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=osAhkdBl6XFTGAg7g8LKwjTp5Cne/U7eQTFTItQN5piataM8qELTt+c+y7UCSxNELwmpHDrUmgkOwqA6BEjOW5YUXoHtCVg+3lhD5JGRFMfpwsWguouOZw6ZN/g8mhNvmxEBffLuzHPOOKsdtraFx/q0rSVfZnzbBlw02wXZE9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkOsFonu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkOsFonu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A241F00893;
	Mon,  8 Jun 2026 20:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780950698;
	bh=kTuQGrPrI0g+lr6HJbKI8VCt2X29FwuiQoFOFomN9u8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dkOsFonuUPR5G8zPyWun3WlKflLwgOcvgP/XWduyDoCV6TPqbjDGRUFkg3l7BX+Y8
	 EsnniSDlWOb0jTgTV68MRZ15ftdmnVOBgKC+Nptbwzo7mJ3NTccZzd2ZB8KRhCbrdC
	 DuW1Lbphd6rhB+U10Lg0kKdjXBQh3cUeDciWBCKLo2PMbvRT+MglNa0rYWy2qAdZkc
	 65X72t6ts2OXvdJcYOH2ahcec9xAML9545RS9ZKrAr2OUZHuseEdAvLcEU36mzRZRF
	 ocSX4LqTgFMJnZ8j2O/BO1BdCMb3r05cBkJl4Z7SzpJhzPtHcWEgQrJ6gh3NbxyLmU
	 KCQ4CHUBU95kA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] perf tools: Fix get_max_num() size_t underflow on
 empty sysfs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260608201753.1979464-2-acme@kernel.org>
References: <20260608201753.1979464-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:31:38 +0000
Message-Id: <20260608203138.A9A241F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Buffer underflow and out-of-bounds write when parsing empty PMU sy=
sfs files
- [High] Missing null termination in `filename__read_int` and `filename__re=
ad_ull_base` leads to uninitialized stack memory read
--

commit 8d602fc039d9415d5215be33dc13b838d360d23b
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Fix get_max_num() size_t underflow on empty sysfs file

get_max_num() reads a sysfs file (cpu/possible, cpu/present, or
node/possible) and scans backward from the end to find the last
number.  If the file is empty, filename__read_str() returns num =3D=3D 0.
The loop `while (--num)` decrements the size_t from 0 to SIZE_MAX,
reading backward across the heap until a comma or hyphen is found
or unmapped memory is hit.

Add an early return for empty files before the backward scan.

> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 21fa781b03cc7..1fab00ec4a59a 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -448,6 +448,12 @@ static int get_max_num(char *path, int *max)
> =20
>  	buf[num] =3D '\0';
> =20
> +	/* empty file =E2=80=94 nothing to parse */
> +	if (num =3D=3D 0) {
> +		err =3D -1;
> +		goto out;
> +	}
> +
>  	/* start on the right, to find highest node num */
>  	while (--num) {
>  		if ((buf[num] =3D=3D ',') || (buf[num] =3D=3D '-')) {

[Severity: High]
This isn't a bug introduced by this patch, but do similar underflows occur =
in
other files when parsing empty PMU sysfs files?

In tools/perf/util/pmu.c:pmu_id():
	str[len - 1] =3D 0; /* remove line feed */

If len is 0, this writes a null byte at str[-1].

Also in tools/perf/util/pmu.c:perf_pmu__parse_scale():
	if (scale[sret - 1] =3D=3D '\n')
		scale[sret - 1] =3D '\0';
	else
		scale[sret] =3D '\0';

When sret is 0, this reads and potentially writes to scale[-1].

And in tools/perf/util/pmu.c:perf_pmu__parse_unit():
	if (alias->unit[sret - 1] =3D=3D '\n')
		alias->unit[sret - 1] =3D '\0';
	else
		alias->unit[sret] =3D '\0';

When sret is 0, this accesses index -1 of the struct array field.

Could this corrupt heap metadata or memory when perf runs against empty sys=
fs
files?


[Severity: High]
This is a pre-existing issue, but I noticed another potential read issue.
Does filename__read_int() read uninitialized memory?

tools/lib/api/fs/fs.c:filename__read_int() {
	...
	if (read(fd, line, sizeof(line)) > 0) {
		*value =3D atoi(line);
	...
}

Since read() doesn't append a null terminator, if the file doesn't end with
a non-digit character or if the contents reach 64 bytes, could atoi() read
past the valid data into uninitialized stack memory?

Similarly, in tools/lib/api/fs/fs.c:filename__read_ull_base():
	if (read(fd, line, sizeof(line)) > 0) {
		*value =3D strtoull(line, NULL, base);

Could strtoull() also read out of bounds here for the same reason?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608201753.1979=
464-1-acme@kernel.org?part=3D1
