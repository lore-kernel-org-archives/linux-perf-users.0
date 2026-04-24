Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00963264E6
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050512; cv=none; b=DEoaGYMdpMryglII2e1zJ+zLJrmMJ7WbrlqcjqZm8S+Q9wLyp9zBVWI7RcACQqzlGmTjdrpMzyLp0Cxvz7acv+MDfTuHzG1aOkqiV9FiAmopTOXHxOP2Lmvy32qwVMLJjiKa0+6fpHjJKSlNpg2SfahU1xv46FeGh+sqQA+FJ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050512; c=relaxed/simple;
	bh=5lia/BBEwFQQiBv6CMUtk7K85qKmtywZaqRmlsfEVgQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ncRbhO8w50344/JtQynupSBEvWdFjGNOZGq2HfBKQlEXhjBgWhaSOZbGRCpsj5XX43a2FDGuuaDkcd38tR+yXwv6cXBBibW9DZCVHxdbbxezD/bfP21Xzqxo9ASZ/Y+dTM/Q5BJlJN3FhMf94ikj9n8AF7L4cPIubCFZtjtAu1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmwROByQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmwROByQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A364EC19425;
	Fri, 24 Apr 2026 17:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050512;
	bh=5lia/BBEwFQQiBv6CMUtk7K85qKmtywZaqRmlsfEVgQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rmwROByQ6KG3pNkpgU6oBjhdEdV5cOrRCAL7034FCWpQZtW+FQeZ+yoNvR1LhYEH3
	 IJhji6yUN5Fe8uQ3R0Au1Uayuo0S96z0PiP8L7h71MN/zuguGdcG9ehMBQf2/w315l
	 QUdr3DbZA5x7r6SzgkZM3OYrDSfpRrMBbDU/O+RiIu1ANNM4oF+n6NS2Crq7as/jaO
	 aRs8Zv0TYhDuzvkCk9YUT6CxcVOaHjos+fP/eliKtPHhyxq5zCThDKJnD075MFlc4g
	 mzAJ5DpVQ+v9XQHiG6rClwcJM9C//y/nudlu9CBejbvL4/Qu9Fm9/JOoAK40Cifdt8
	 fwpgO03AKQOXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 26/58] perf mem-phys-addr: Port mem-phys-addr to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-27-irogers@google.com>
References: <20260424164721.2229025-27-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:08:31 +0000
Message-Id: <20260424170832.A364EC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Medium] Python 3.10+ requirement breaks compatibility on older LTS distr=
ibutions.
- [Medium] Per-sample print statements for unresolved physical addresses wi=
ll severely spam stdout.
- [Medium] Missing validation of physical address presence risks silent out=
put corruption.
- [Low] Logic flaw in binary search return value handling causes unintended=
 negative list indexing.
--

commit 2fe83bab7027dd98239e7ac8be26c0436646b4a9
Author: Ian Rogers <irogers@google.com>

perf mem-phys-addr: Port mem-phys-addr to use python module

This commit adds an example script demonstrating the perf python API to
load a perf.data file and resolve physical address samples based on
/proc/iomem.

> diff --git a/tools/perf/python/mem-phys-addr.py b/tools/perf/python/mem-p=
hys-addr.py
> new file mode 100755
> index 00000000000000..ba874d7a2011cf
> --- /dev/null
> +++ b/tools/perf/python/mem-phys-addr.py
> @@ -0,0 +1,117 @@

[ ... ]

> +# Physical memory layout from /proc/iomem. Key is the indent and then
> +# a list of ranges.
> +iomem: Dict[int, list[IomemEntry]] =3D collections.defaultdict(list)
> +# Child nodes from the iomem parent.
> +children: Dict[IomemEntry, set[IomemEntry]] =3D collections.defaultdict(=
set)

The built-in collection parameterization using list[IomemEntry] and
set[IomemEntry] was introduced in Python 3.9.

Will this script crash with a TypeError on systems running older Python
environments like Python 3.8?

[ ... ]

> +def find_memory_type(phys_addr) -> Optional[IomemEntry]:
> +    """Search iomem for the range containing phys_addr with the maximum =
indent"""
> +    for i in range(max_indent, -1, -1):
> +        if i not in iomem:
> +            continue
> +        position =3D bisect.bisect_right(iomem[i], phys_addr,
> +                                       key=3Dlambda entry: entry.begin)

The key parameter for bisect.bisect_right() was added in Python 3.10.

Does this create a strict dependency on Python 3.10+?

> +        if position is None:
> +            continue

The bisect_right function always returns an integer, so checking for None
appears to be dead code.

> +        iomem_entry =3D iomem[i][position-1]

If phys_addr is strictly less than the first element's begin address,
bisect_right returns 0.

Does this cause position - 1 to evaluate to -1, which then inadvertently
accesses the last element of the iomem[i] list?

> +        if  iomem_entry.begin <=3D phys_addr <=3D iomem_entry.end:
> +            return iomem_entry
> +    print(f"Didn't find {phys_addr}")

Since find_memory_type() is called for every single sample in the dataset,
won't this print statement heavily spam standard output if a dataset contai=
ns
many unmapped physical addresses?

> +    return None

[ ... ]

> +    def process_event(sample):
> +        """Process a single sample event."""
> +        phys_addr  =3D sample.sample_phys_addr
> +        entry =3D find_memory_type(phys_addr)

If a user runs the script on a perf dataset recorded without --phys-data,
sample_phys_addr may default to 0.

Without validating if physical addresses are actually present in the sample=
s,
could this silently attribute all such samples to whatever memory range
contains address 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D26
