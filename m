Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641CD54A7C3
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873714; cv=none; b=WKW3ayh3LVMptXSu3jswUwVwAn/TctKKppnXd5ZKLKEyl85U6e/np3N1aiFv6w9vwmvqP/UdFRVBqTBBYI2/TejWsE83VE8wvSpZL66QE+rR2aks9IlgKaqrt1XB3Xaxp6L2BSE36uo3EZJSH/KrFCX7PPk0re8bbtXMqMPIIUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873714; c=relaxed/simple;
	bh=5D8xO3urJ64xhhjZkSgHLMIzNBPot4FgSpA3SerGt/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ih21w/Y5ZzkyCU4b0i6IqZSTBq2ZQXtebmKnohv3ZPqroZNkdqZEkKO0pB8OMbcNwTO/ttc0VlhJ2ghn6CGJlbjaNwx/DLZN/IPOE6YV+PLS/4Cdym0iak8nsZAvMtptDpuvdvH+wdJhVISoB2cSRE/GR1+Oaj4kLYVtB5G2DaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A131F00AC4;
	Tue,  8 Sep 2026 13:21:51 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/26] perf dwarf-regs: Adapt get_dwarf_regnum() for
 arm64
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <61714d93cd55cd461d5c37146713ddb9e1d04743.1788872630.git.wutengda@huaweicloud.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <61714d93cd55cd461d5c37146713ddb9e1d04743.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:21:51 +0000
Message-Id: <20260908132152.08A131F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing 'lr' (link register) support in arm64 DWARF register pro=
grammatic lookup.
--

commit 5d023c42589d9bd9061d9468194dc470f5cdc273
Author: Tengda Wu <wutengda@huaweicloud.com>

perf dwarf-regs: Adapt get_dwarf_regnum() for arm64

This commit replaces the static table lookup for arm64 DWARF registers with=
 a
programmatic parser in __get_dwarf_regnum_arm64(). This allows resolving
arm64 register names directly into their corresponding DWARF register numbe=
rs
for perf annotate.

> diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c b/tools/p=
erf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> index 593ca7d4fccca..720c863d18696 100644
> --- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
> +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c

[ ... ]

> @@ -10,3 +13,22 @@ int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_=
regnum)
> =20
>  	return perf_regnum;
>  }
> +
> +int __get_dwarf_regnum_arm64(const char *name)
> +{
> +	int reg;
> +
> +	if (!strcmp(name, "sp"))
> +		return 31;
> +
> +	if (*name !=3D 'x' && *name !=3D 'w')
> +		return -ENOENT;

[Severity: Medium]
Does this code inadvertently drop support for the link register ('lr')?

If perf annotate processes an instruction containing 'lr' (e.g.,
stp x29, lr, [sp, #-16]!), arch__dwarf_regnum() extracts "lr" and calls
this programmatic logic. Since "lr" does not start with 'x' or 'w' and is n=
ot
"sp", it will return -ENOENT. This seems like it will prevent data type
tracking for the link register, which was previously supported when mapping
to DWARF register 30.

> +
> +	name++;
> +	if (!isdigit(*name))
> +		return -ENOENT;
> +
> +	reg =3D strtol(name, NULL, 10);
> +
> +	return reg >=3D 0 && reg <=3D 30 ? reg : -ENOENT;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788872630.gi=
t.wutengda@huaweicloud.com?part=3D7
