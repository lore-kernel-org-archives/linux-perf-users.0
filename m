Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201B032B13F
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jun 2026 23:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780875957; cv=none; b=ofKW0cbhaX2DgTZHiDaUVwPFCn+kyEkqtOFtB6S6UzfUchXgjyUspCpYrFADY9zPE1IrpTqbVxkvAB0bVL7cDD8XNufy6dAOXJsLoCMYzgT+aNsc8NSqUx/6LRszVC0nE+2+s+tTcLvphRpXPCCg9ixEynYIrKsLM1zQ3mdNuhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780875957; c=relaxed/simple;
	bh=NmODanV2m9HArCDhvDViW/py2mXK8Q8rBTeV1VRNFQA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r99iE7IQQCWYzCde8d1GZUkqsfy37H+yc9LMHBDS+kbkR40Ar+5DXruEK6fBFNBGSqphBpnCN/R49coJ21aEonWbnh8Ew5Vy0N0UZiqelzQ0poSgoq8auRgtgQR2eQ7a/LGM0H1OwrrCq70wN3WC0K0cMlChEpKnZ82D6u+rojU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guTNQ3QM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guTNQ3QM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF2E1F00893;
	Sun,  7 Jun 2026 23:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780875955;
	bh=xObX9GSp+zRSsnItYuO24P5ZGb8gEDaLfnOZizf0NyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=guTNQ3QMMaHmcbJhton/4d0VES07xWgvdN2wMaj2shvYGR5N5yTw+nBkmU+RgguJf
	 Cky5KKBl51c0BXgy9SITXlov3NWb6lqUuJMBGNzRqxORFUqKKoYEtGNIowGiY+CLdX
	 m9bRfMQlRSPXt5Zo0x11kfEcO244eVJO7mtBcQgpNV4myTz3A5+IhnxOgppvHQIFBu
	 cGKjU6cVddQIxS6/2Vczug25kfiBf/4M6+nzfit6k8LVNvQxoRA3PX2zB/jAKBpn4D
	 5dvn+4MOj995ODwLorBLiHmESf2XSoNm/td/hEkCtwYjw/Wr4SG85KHOEtA7fGqRG2
	 3ouyj/VUJJmhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] perf tools: Fix get_max_num() size_t underflow on
 empty sysfs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260607232925.1935819-2-acme@kernel.org>
References: <20260607232925.1935819-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 23:45:55 +0000
Message-Id: <20260607234555.9DF2E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Heap buffer underflow due to unsafe length manipulation after `fil=
ename__read_str` on empty PMU identifier file.
- [High] Heap buffer underflow due to unsafe length manipulation after `pro=
cfs__read_str` on empty procfs file.
- [High] Reading an empty PMU scale file leads to a stack buffer underflow.
- [High] Reading an empty PMU unit file leads to an out-of-bounds array acc=
ess inside the `perf_pmu_alias` struct.
--

commit 3cacfb3c562f81ba051910331484d58d28297996
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Fix get_max_num() size_t underflow on empty sysfs file

This commit fixes a heap buffer underflow in get_max_num() by adding an
early return when an empty sysfs file is read. This prevents the size_t
variable from underflowing during a backward scan of the buffer.

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

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a similar pattern =
in
tools/perf/util/pmu.c:pmu_id(). Since filename__read_str() returns success =
(0)
and sets len to 0 when reading an empty file, does the following code
underflow the len variable?

tools/perf/util/pmu.c:pmu_id() {
...
	if (filename__read_str(path, &str, &len) < 0)
		return NULL;

	str[len - 1] =3D 0; /* remove line feed */
...
}

[Severity: High]
This is a pre-existing issue, but another instance seems to exist in
tools/perf/util/thread.c:thread__set_comm_from_proc(). If the procfs file is
empty (e.g., due to a race), procfs__read_str() returns 0 and sets sz to 0.
Could this lead to a heap buffer underflow when setting the NUL byte?

tools/perf/util/thread.c:thread__set_comm_from_proc() {
...
	if (!(snprintf(path, sizeof(path), "%d/task/%d/comm",
		       thread__pid(thread), thread__tid(thread)) >=3D (int)sizeof(path)) =
&&
	    procfs__read_str(path, &comm, &sz) =3D=3D 0) {
		comm[sz - 1] =3D '\0';
...
}

[Severity: High]
This isn't a bug introduced by this patch, but reading an empty PMU scale
file might cause a stack buffer underflow in
tools/perf/util/pmu.c:perf_pmu__parse_scale().=20

If the file is empty, read() returns 0, setting sret to 0. The error check
passes, and we evaluate scale[-1]. Could this read uninitialized stack
memory and potentially write a NUL byte out-of-bounds?

tools/perf/util/pmu.c:perf_pmu__parse_scale() {
...
	sret =3D read(fd, scale, sizeof(scale)-1);
	if (sret < 0)
		goto error;

	if (scale[sret - 1] =3D=3D '\n')
		scale[sret - 1] =3D '\0';
...
}

[Severity: High]
This is a pre-existing issue, but there appears to be a similar out-of-boun=
ds
access in tools/perf/util/pmu.c:perf_pmu__parse_unit().=20

If read() returns 0 for an empty file, sret is set to 0. The code then
evaluates alias->unit[-1]. Since unit is part of the heap-allocated struct
perf_pmu_alias, could this overwrite the adjacent pmu_name pointer field if
the preceding byte happens to be a newline?

tools/perf/util/pmu.c:perf_pmu__parse_unit() {
...
	sret =3D read(fd, alias->unit, UNIT_MAX_LEN);
	if (sret < 0)
		goto error;

	close(fd);

	if (alias->unit[sret - 1] =3D=3D '\n')
		alias->unit[sret - 1] =3D '\0';
...
}

>  	/* start on the right, to find highest node num */
>  	while (--num) {
>  		if ((buf[num] =3D=3D ',') || (buf[num] =3D=3D '-')) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260607232925.1935=
819-1-acme@kernel.org?part=3D1
