Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E763E1B4138
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Apr 2026 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783070; cv=none; b=BQrH7jBlBacZc18xmqcF31rDEsBiLWZDKMSUcCJEUYf8XzHGewfyXproI4Ue57kakOTgvpk7fX8XNYyj+rkYkKJn0SaL5ya8GXaqraX6DJ2jaJu6lOstroz1QL1ggR0MULN3Sd092yV0VV90buDeE/rdVEaut09yoOPferfRO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783070; c=relaxed/simple;
	bh=99XO5yajChLugbYfQZkKnWL5IfJB6fR+AJgVNA/QjNk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=obIorsnjoghKV6PXyEXe4iMcQqzJesv+Zhk4f+BKH8zFBYBItvkjF2nCjPV0mle6Xqq/laEaN55KJEPJUTRFlGaIfksm4SYUKgVJ5ZI/XsLTjG8LBUMVhGXRUFVm52XTtdTgc6/6B6Wqr5iErHPb6RClTOhXVBk1SRjTLMFCJ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmSL4SCT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmSL4SCT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4C1C4CEF7;
	Fri, 10 Apr 2026 01:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775783069;
	bh=99XO5yajChLugbYfQZkKnWL5IfJB6fR+AJgVNA/QjNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=dmSL4SCTz0iTatE3wxseyhtBOhafXE77UvHuUMQFAweM4ZfG0qoyKtaUgexFNg8jt
	 pVQA05M4zbXYO7sGy0hGJpLaTckcCX515RSiowcokYchNhIH9PGxYUISFVfRgwVr8/
	 wskwnBCI8Jxsfl6YRu2P+ty4MmHiG6M5VLUEWMs+ocMO46J7UkH0NyhxvgxVMXWrcX
	 HBcgCS6TwFBe0P1H6IP9lP4fSI7GbfuiESS3/9mUWBLYv8N+stYnSxuVct4wunkVxB
	 o/afFiu3K6GWxlW02ufcCZzDZP+MK/DbmuKuUOzaxY+TAh5G9GK0a9x/GBdxm0x2v8
	 se4mnvc8OINpQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] perf header: Sanity check HEADER_NUMA_TOPOLOGY
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260410004000.148138-6-acme@kernel.org>
References: <20260410004000.148138-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Apr 2026 01:04:28 +0000
Message-Id: <20260410010429.8A4C1C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] The minimum section size calculation under-calculates the required =
bytes per node by omitting the string length field.
--

commit 39d7a2e6e6f3028c87af277c0da0635894776c8f
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf header: Sanity check HEADER_NUMA_TOPOLOGY

This commit adds validation to process_numa_topology to harden against
malformed perf.data files. It adds an upper bound check on nr_nodes and
verifies the minimum section size before allocating the nodes array.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> @@ -3003,6 +3003,19 @@ static int process_numa_topology(struct feat_fd *f=
f, void *data __maybe_unused)
[ ... ]
> +	if (ff->size < sizeof(u32) + nr * (sizeof(u32) + 2 * sizeof(u64))) {

Does this minimum section size calculation under-count the required bytes
per node?

The validation check calculates the minimum payload size as 20 bytes per
node for the node, mem_total, and mem_free fields. However, the subsequent
loop also reads a string for each node via do_read_string().=20

Since do_read_string() internally reads a mandatory 4-byte string length
field first, does the actual minimum size per node need to account for
those additional 4 bytes?

> +		pr_err("Invalid HEADER_NUMA_TOPOLOGY: section too small (%zu) for %u n=
odes\n",
> +		       ff->size, nr);
> +		return -1;
> +	}
> +
>  	nodes =3D calloc(nr, sizeof(*nodes));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260410004000.1481=
38-1-acme@kernel.org?part=3D5
