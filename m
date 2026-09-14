Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6852C11E6
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426789; cv=none; b=dQsgxrclwKrwWdycW7SLroD49v9irI6p9YYIlbSE+yZvnCZ9PcslpcVwq7bLb2bIxYVb0SIBnjnxD1JatcxIdkBbbPOkRu6n0g1KzV2HvQuAza6PCprEL0NBbqgwKeNiYPut3AWTphlyGIPNkhcl49sWrbaCVrRCwRGqJR24eBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426789; c=relaxed/simple;
	bh=gd6QBj9FbAaUhyp6F+Cq4mh65vbVoXryuxmB/CMTt7A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KbHF+Z/+zbR/WBf+7m3kkmj1ChAwBkPiB9iFWsrxMnKi6GFwCSWP2sCGUWVX39w0OHqQra6fvrtXOlIHvhZI3gArAmiJ1mVnmvXnXt4zLchUSOd4r7QhEZQuX2Log6tnpB+ddmazb7YR3tZCZ8GVVAY21+1uL9VGEi09q95v4ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovimANq4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovimANq4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3731F000FF;
	Mon, 14 Sep 2026 22:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789426788;
	bh=CSb+PNFxkZVaCWy7kKQk5O0XPfjocT/FVPvhGWu/aHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ovimANq4/JVu6fVlFjqG1Fm6nso82fIlFZsjiXxTR9RuDrKoJKDABj8qU3+6YRFHD
	 XDMfzVq9/DdNIC63dArD4A+g9VumR/DA6umi1bWvRmu8v84mjVo480jPTDCt8n0SuR
	 Cq+fx9Jc6Tk1Nx87mUWQfo0qhcc9vNYNnIgZ2g7xy25ewOjDhr4EtPMBGWZC9g8qFK
	 rWnxPsZgXLSwn9pUqDm+0CaQTA5mpPDJZDGEZZsTRBa8bZ7p029tOwaVtGwqfg+d5/
	 7YSEeC9zMpQHM4xG6buWq8oEfaa2PGOt4wWgYg/Bo/1E0PtpbAE4UcM62/ZA6mxxGc
	 JBpcbvGvKojHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 5/6] perf tools: Show memory region in perf-script
 subcommand
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914224650.52982-6-thomas.falcon@intel.com>
References: <20260914224650.52982-1-thomas.falcon@intel.com>
 <20260914224650.52982-6-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 22:59:47 +0000
Message-Id: <20260914225947.DF3731F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] perf: unnecessary session.h inclusion in mem-events.h
--

commit f3a6814df7d1c56b77a8b31b8b171d285c37db7e
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf tools: Show memory region in perf-script subcommand

Show the memory region in perf-script subcommand. Memory region is found
in the mem_region field of the memory information data source.

Link: https://lore.kernel.org/all/20260114011750.350569-1-dapeng1.mi@linux.=
intel.com/

> diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
> index daa22748f9fea..4ebb8109fc3c4 100644
> --- a/tools/perf/util/mem-events.h
> +++ b/tools/perf/util/mem-events.h
> @@ -4,6 +4,7 @@
> =20
>  #include <stdbool.h>
>  #include <linux/types.h>
> +#include "session.h"

[Severity: Low]
Is this full header inclusion necessary here?

Since the only usage of session.h in mem-events.h is the struct perf_session
pointer in the perf_script__meminfo_scnprintf function prototype below,
could this be replaced with a forward declaration (struct perf_session;)
instead? This would reduce namespace pollution and avoid unnecessary build
dependencies.

> =20
>  struct perf_mem_event {
>  	bool		supported;

[ ... ]

> @@ -47,7 +48,8 @@ int perf_mem__snp_scnprintf(char *out, size_t sz, const=
 struct mem_info *mem_inf
>  int perf_mem__lck_scnprintf(char *out, size_t sz, const struct mem_info =
*mem_info);
>  int perf_mem__blk_scnprintf(char *out, size_t sz, const struct mem_info =
*mem_info);
> =20
> -int perf_script__meminfo_scnprintf(char *bf, size_t size, const struct m=
em_info *mem_info);
> +int perf_script__meminfo_scnprintf(char *bf, size_t size, const struct m=
em_info *mem_info,
> +				   struct perf_session *session);
> =20
>  struct c2c_stats {
>  	u32	nr_entries;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914224650.5298=
2-1-thomas.falcon@intel.com?part=3D5
