Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AC12C21D0;
	Mon, 30 Mar 2026 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774904740; cv=none; b=hPdgc1ZdMcds/39RtJmzDlaxSv08qkx2tcfuW3eNWdDujOb5TPVckA3ztqPu5T0SY0doH4dCH0FZtVxe+ikBzKZ3mNXiYij+EUvFpaX08PPyKkaxoHSc6QhR2SKQ8qHOnfCj33MJM4dG0C+cXeW+8V0PAHIZBTPOoQrNfB/Ujcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774904740; c=relaxed/simple;
	bh=jNiz7z/SeZ4TL5aaqPZSVcUIWnCHYFd0G4Vg82weJ3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvWYdCQfQ/2spxUPpmu9g3TTWDkK/WRsZvqehgYAnkSjRT1WxsYDfrpsKzUddt9eY3HQLsOXX8o5vBkhxoTqPLqp9sbgRppHUQJ0NCU6Wd6y6zXh0+VegmN8CfE3Hgxfeu89Jei1EybakpJxBEVH/dKGZJymaLGrn/PUrncZdzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPMX6Ihu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPMX6Ihu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 093D0C4CEF7;
	Mon, 30 Mar 2026 21:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774904739;
	bh=jNiz7z/SeZ4TL5aaqPZSVcUIWnCHYFd0G4Vg82weJ3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gPMX6IhuQrL3rE7n3clMOsUEV0ZZVlSatKWHVfTm/PPpu2vBva5OWxLplM7HssEK1
	 Uht8IP/edANfbkd1Y7n3Rjfkbk3R7yBDhLTrZhECHz3VnZsKQwwxMC+Ttw5kirbXnW
	 J8fTz3adPTJaftT4K7NpAEDlJ8ECRsgajOpVoGs12rX+qd0+YfRUxdVDj2k3y372NI
	 4aHNsfcYOXMK6kG/37ug2drqzPlvTWxBBWkALIAZqo3WHtsAjk8hDa6oxHNYG89Vt1
	 PbGKjDKCMsrp8LXIUJ6AprcSIO9BpEY27SYrMVC84iaTvmg3xqbrK0OCQqdvCpaLqo
	 W8XyELKgPoFTg==
Date: Mon, 30 Mar 2026 18:05:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, andrew.jones@oss.qualcomm.com,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, howardchu95@gmail.com,
	james.clark@linaro.org, john.g.garry@oracle.com, jolsa@kernel.org,
	leo.yan@linux.dev, libunwind-devel@nongnu.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	mingo@redhat.com, namhyung@kernel.org, palmer@dabbelt.com,
	peterz@infradead.org, pjw@kernel.org, shimin.guo@skydio.com,
	tglozar@redhat.com, tmricht@linux.ibm.com, will@kernel.org,
	yuzhuo@google.com
Subject: Re: [PATCH v2 2/8] perf build loongarch: Remove reference to missing
 file
Message-ID: <acrln3IwOebvb6yj@x1>
References: <CAP-5=fWVU3ktkGAnZQrjQJf+Z5AtQo73BVUhj-nr3H95GdcEJQ@mail.gmail.com>
 <20260305221927.3237145-1-irogers@google.com>
 <20260305221927.3237145-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305221927.3237145-3-irogers@google.com>

On Thu, Mar 05, 2026 at 02:19:21PM -0800, Ian Rogers wrote:
> The file was removed in commit e62fae9d9e85 ("perf unwind-libdw: Fix a
> cross-arch unwinding bug") but the Build file not updated.
> 
> Fixes: commit e62fae9d9e85 ("perf unwind-libdw: Fix a cross-arch unwinding bug")

Removing the 'commit' part.

- Arnaldo

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/loongarch/util/Build | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
> index 3ad73d0289f3..8d91e78d31c9 100644
> --- a/tools/perf/arch/loongarch/util/Build
> +++ b/tools/perf/arch/loongarch/util/Build
> @@ -1,4 +1,3 @@
>  perf-util-y += header.o
>  
>  perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
> -- 
> 2.53.0.473.g4a7958ca14-goog
