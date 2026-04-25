Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8B8381AFB
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158367; cv=none; b=KnAmXfYk5EblIhWQpV3Ir07ZoUdk/1IdJqwYiLbXkQB4zguiIk7+9ZIoyFRDi7mLzTnHk75CI9Qmgbcy5B0XJrq7vVb0DZCVCP5pHhihGj4OminBHqnMBNINWL7W54N5wDsHAk0PEEKVkMG6ujFicuNb8Nm688NE/LobAsZx7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158367; c=relaxed/simple;
	bh=WhahERFi/CglrrQYxEW1ZUgvJA3v6cDGQPcz/dMqqfU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FWJ7NV2BWzm/2tjWyCNSvOyfVZkHGlcIDQqyrPuGgBmivA9p+0mjr6l5lj/F1NPttTH/Khvv9PxNz23AbN5ayslOJrUgzuxCl8FdT4YcOAon/5t8KRX0VpKB4DyC8TbAx6YvIAtnTnjjFlzdyds+ORknXNH6BwHENxNH826dxO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXaVww8d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXaVww8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254E4C2BCB0;
	Sat, 25 Apr 2026 23:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158367;
	bh=WhahERFi/CglrrQYxEW1ZUgvJA3v6cDGQPcz/dMqqfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TXaVww8dDx2az3bjujZkX05SBNhvMlpiLdZ2f0lHJQnI2iSr59qzjZd2Zzt6bkImM
	 zgdDXtN3G3mJcr8Zkpo0ll6qrHdhQExZwrcIh13knuUjGzXBHHm3OGeTbwwk3tKjzM
	 dufJmE50Wu+EcdihF7DrTeV3XwkJcxktTB36Pau6zFnCJWOHzxfNDcAtlqbDW9bVzZ
	 NFtr0eg8NEnhnvAcYQuEVclzX6jKHLIN+ElETt0d5UywI38bfwaQXePHkpiKz6rFkH
	 HO1wrQha4PHvDR56aVlywNgcmQXlWTJYd9P+p0m398J5HmRsyHD4PRwpBkA3kcc4W1
	 2TDnBRrd0ZEYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 26/59] perf mem-phys-addr: Port mem-phys-addr to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-27-irogers@google.com>
References: <20260425224951.174663-27-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:06:06 +0000
Message-Id: <20260425230607.254E4C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] Python 3.10+ and 3.9+ specific syntax breaks backward compatibil=
ity.
- [Medium] Leftover debug `print` causes massive stdout spam and performanc=
e degradation.
- [Low] Unintended negative indexing due to flawed bounds checking logic.
--

commit e001fd33f0feacc6bc55010469946b81f05191b8
Author: Ian Rogers <irogers@google.com>

perf mem-phys-addr: Port mem-phys-addr to use python module

Give an example of using the perf python session API to load a
perf.data file and perform the behavior of
tools/perf/scripts/python/mem-phys-addr.py.

> diff --git a/tools/perf/python/mem-phys-addr.py b/tools/perf/python/mem-p=
hys-addr.py
> new file mode 100755
> index 000000000000..ba874d7a2011
> --- /dev/null
> +++ b/tools/perf/python/mem-phys-addr.py
[ ... ]
> +@dataclass(frozen=3DTrue)
> +class IomemEntry:
> +    """Read from a line in /proc/iomem"""
> +    begin: int
> +    end: int
> +    indent: int
> +    label: str
> +
> +# Physical memory layout from /proc/iomem. Key is the indent and then
> +# a list of ranges.
> +iomem: Dict[int, list[IomemEntry]] =3D collections.defaultdict(list)
> +# Child nodes from the iomem parent.
> +children: Dict[IomemEntry, set[IomemEntry]] =3D collections.defaultdict(=
set)

Does using list[IomemEntry] and set[IomemEntry] break compatibility with
Python versions older than 3.9? These generic type hints were introduced in
Python 3.9, which might cause TypeError crashes on older supported
distributions.

[ ... ]
> +def find_memory_type(phys_addr) -> Optional[IomemEntry]:
> +    """Search iomem for the range containing phys_addr with the maximum =
indent"""
> +    for i in range(max_indent, -1, -1):
> +        if i not in iomem:
> +            continue
> +        position =3D bisect.bisect_right(iomem[i], phys_addr,
> +                                       key=3Dlambda entry: entry.begin)

The key parameter for bisect.bisect_right() was introduced in Python 3.10.
Will this cause TypeError crashes on systems with Python 3.9 or older?

> +        if position is None:
> +            continue
> +        iomem_entry =3D iomem[i][position-1]

Since bisect_right() always returns an integer, position is None will never=
 be
true.

If phys_addr is smaller than the first element's begin address, position wi=
ll
evaluate to 0. Doesn't this mean position-1 evaluates to -1, accessing the
last element of the list instead of correctly handling the out-of-bounds ca=
se?

> +        if  iomem_entry.begin <=3D phys_addr <=3D iomem_entry.end:
> +            return iomem_entry
> +    print(f"Didn't find {phys_addr}")

Will this print statement flood standard output if a large number of physic=
al
addresses cannot be resolved? Since find_memory_type() is called for every
sample in the perf data, it might severely degrade performance and make the
intended summary output unreadable.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D26
