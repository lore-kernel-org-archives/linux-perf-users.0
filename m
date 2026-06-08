Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEC21A0B15
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 01:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780883140; cv=none; b=fInMIsBqFyPybJUUi0LHO6fLXZTJxVW1CaUJADa6wz2Fhm1ovdQAM9EWAgPN67Njzb8LBakl7DRLWYWiTQL57uxwH61nCACkG90ig8ARY80DtIT6m5dSN43HHL1k1vqQaubAqlTixKY1AjwNpC7YhpXfhdGJRqsqEz36cyb0HQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780883140; c=relaxed/simple;
	bh=Ir0hZWo/mRN6RSSeLv1jiUkAwO/T5FTJT2jBijHoXt8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LQkfCKvoeOLFYdQK51RlZ9rmdgMOOtjTc+RqBkDxaOJA4DAnH0TINVXAQxo8wZSEEGTn6zikzZhnT56Mffn795O5QPU4ccUtJi6bLB2O9ut6MJnOzscvrIwwgdsaiUVXOySZhjGJAOMHs+HsAgUPhTd+S471Rrhnn1wKZ9qjsVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCzlJD24; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCzlJD24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F087B1F00893;
	Mon,  8 Jun 2026 01:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780883139;
	bh=RJAIDTXk7uDyVyH+Y/NONi3FeZ517kYNnNQkzQH+Yso=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jCzlJD240i4GmDGqJhnk1sxZPofl7wCNqd+sDxl0isTC4rzJA2WdMDuPFLBBOvYAP
	 6rpWVe32m5cDk/CbSwr7VhuK15BFwbpztnxN9cG//PP5EMWPL4VKJKWnVbKpAy1oM9
	 q07agFYIGBwy4GdKD8JQ8cnBi3swUI7DnebVA7QHeY64d/bxR3hQMz7jjeRcuVrFlT
	 4zJ09tuKpWEM1k/SAajwKlG6+zQpIsuiGqnqb93OAhMIUIrIZFTIryeaUywiTIau96
	 ECYEzjaMvojrWt5Guk2gKS0/U+JmHVI064a3XmfSYE007B12uVnifjLFrXv7DwTiqJ
	 H8EpyjrVgC4Bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] perf tools: Fix get_max_num() size_t underflow on
 empty sysfs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260608013057.1942953-2-acme@kernel.org>
References: <20260608013057.1942953-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 01:45:38 +0000
Message-Id: <20260608014538.F087B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Heap out-of-bounds write (poison null byte) due to size_t underflo=
w when reading empty files
--

commit 1a2f44329fa687f2b52540b18c56a66a0d4e9628
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Fix get_max_num() size_t underflow on empty sysfs file

This commit fixes a size_t underflow in get_max_num() by adding an early
return when a sysfs file is empty. Previously, reading an empty file would
result in num =3D=3D 0, causing a backward scan to underflow and read
out-of-bounds memory.

> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
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
This isn't a bug introduced by this patch, but while you are fixing
empty file reads here, does this same size_t underflow pattern occur in
other places that read strings?

For instance, in tools/perf/util/pmu.c:pmu_id():

	if (filename__read_str(path, &str, &len) < 0)
		return NULL;

	str[len - 1] =3D 0; /* remove line feed */

If len is 0 because the identifier file is completely empty, len - 1
underflows to SIZE_MAX. Since the string is heap-allocated and returned
with a length of 0, writing to index SIZE_MAX effectively writes one byte
before the string, which corrupts the malloc chunk size metadata.

A similar pattern seems to exist in
tools/perf/util/thread.c:thread__set_comm_from_proc():

	if (procfs__read_str(path, &comm, &sz) =3D=3D 0) {
		comm[sz - 1] =3D '\0';
		err =3D thread__set_comm(thread, comm, 0);
	}

Could these empty file underflows trigger similar heap corruption if the
identifier or comm files happen to be empty?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608013057.1942=
953-1-acme@kernel.org?part=3D1
