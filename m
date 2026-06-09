Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B65530BBBF
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 01:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780968258; cv=none; b=P/Waq4TyPsOidIo/Ymng2ma/W7Dhl1AjC7wBVuh6ZVDYEYwLtWmZPPrDMMlsWlpAXILBOVpamhCLL3n41cMuL6LUyRIDKTKCmx+lnPLT/Zmx31segi4bSPUT9i44VHqZ59whH5s3X78tYwT6i5KtPK/DrpninF4XcPdqgso+BRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780968258; c=relaxed/simple;
	bh=oQNARPbtKE4fk4z2TFfBjMbOdNNL9mqr1y2hdR5nWO0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JxZ65zt5ZKRhRCLh6drALzt9fa9MyJPP+JDWrVfXNPAYkR5iuRc0MZWY5CDXrXEehMmPIF/8C0NlAKdzwMWZv0TH9cg4sWX35ZMtuEK5V7dUWuN3WFXhQKNEoSoLBBo/Z5jBBHN11fP3YLJ83J7SE48TWikkYoVMhVaiGX6itrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By0HyAYW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="By0HyAYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B171F00893;
	Tue,  9 Jun 2026 01:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780968257;
	bh=nbZ73ks+lIyUrZ7Ipofqp3WShFpxt9p5+jVAlVQhMW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=By0HyAYWD9lj5785AHo6tkGu4whRzP4D2NhjGeqI+Wqtgoau++BpGoxRlNeUAeJXv
	 p4YpCXmr69C9we5v0OkTOSNX8TXSbAX+REYj9TcT4vKm1dqfdphEv/ISNmBOdkW8QP
	 67I49ysf+SDb4nv7eUqSFDtZNF/Io/T3OTeJj60B9bGoyf3TqO+DlEkawAnKzhziuz
	 3VtYYs2DE5XSTePIxNZd34Eqv+qelwweq8qCG/ufYyaYfloytpFbXVF/PAPY3i++nA
	 PhXL2bqwoOErvR44gKTaX6SA2Cg7V7KWuoAIOsfCBMRfd+LknnsFamfvkxDjhP3/Y4
	 7TnfTF4ZbGRxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/11] perf tools: Fix get_max_num() size_t underflow on
 empty sysfs file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260609010526.1998472-2-acme@kernel.org>
References: <20260609010526.1998472-2-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 01:24:16 +0000
Message-Id: <20260609012417.24B171F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds write (buffer underflow) when reading empty files du=
e to unvalidated length after string read operations.
--

commit a32722a23e97db7d655860207d1ea4758fadcf7b
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Fix get_max_num() size_t underflow on empty sysfs file

This commit prevents a size_t underflow in get_max_num() by adding an early
return when filename__read_str() yields an empty file with a length of 0.
This protects the subsequent code from scanning backward out of bounds.

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
This is a pre-existing issue, but since this patch successfully prevents an
underflow with empty files, could the exact same bug exist in other places=
=20
that read system files?

For instance, in tools/perf/util/pmu.c:pmu_id():

    if (filename__read_str(path, &str, &len) < 0)
        ...
    str[len - 1] =3D 0; /* remove line feed */

If len is 0 due to an empty file, does len - 1 underflow to SIZE_MAX and
cause a 1-byte out-of-bounds write that corrupts heap chunk metadata?

A similar pattern appears in
tools/perf/util/thread.c:thread__set_comm_from_proc():

    if (procfs__read_str(path, &comm, &sz) < 0)
        ...
    comm[sz - 1] =3D '\0';

Could this also result in the same buffer underwrite if the /proc/.../comm
file happens to be empty?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609010526.1998=
472-1-acme@kernel.org?part=3D1
