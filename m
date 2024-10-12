Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3860282FE
	for <linux-perf-users@vger.kernel.org>; Sat, 12 Oct 2024 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728757825; cv=none; b=ngDdYUE3lxhKLGyfHkt3W2LCbSX3/W16tcicET99oQnKLSgRs1ud2CLjwBWJUfIwDYM5lZyNd/c+0uLMEoRVeR2ZvUd2TEy0i5i9bzzYJzbmoWn/Y8EKJ7cyc9p693PS9PuBK/8qRJKZzznQh2FIy6ExtiHVYRgIMtp848m90pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728757825; c=relaxed/simple;
	bh=pmalQ7Pa/jfOU8FXiK2fLtAmqyccz5gyqQGbLdQG0yY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDGUk08nxw94nhMqwCY1+KrU9Fv81YgMSAcKrFEOK+dUvX4TehvTodlfWD0ttG7iZaihoy3tgBPPie/GEv+7i6lI9mza2lwkgzLqElBAfdkG8HR1Fdqt47VRNKvAcP8dlNiv4L3AT1Y5sAo7PMepZdQBAnnw61Pn5YAZatzimxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGMu/UDa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGMu/UDa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21907C4CEC6;
	Sat, 12 Oct 2024 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728757824;
	bh=pmalQ7Pa/jfOU8FXiK2fLtAmqyccz5gyqQGbLdQG0yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGMu/UDaA/ce3xO/3a5qudXZzFN+hX2+Rm5xF+BqkP4wXn9ERsKHI+WK8ZqN8AkW/
	 iKnRmHJMok0tZijfSpieM+3UHw3VtrFvPCR/iofZ1fO2gJQimbP5xm/IoY8h2Z9/7w
	 W7K35k6LHfpRsS5uneAWohJfY5DxtMeXvxQjFnPFUfLHymZGxmLcIbWmkGEcjmGMXi
	 JtaKv0chnohNMy6TdpnrDW/xbFu02y+uFAKNNcBKMjRANZvpvGgmRXJIAS37K+wucX
	 98EZFViEAOnndUYhBa7jUC/wQx4L4DE9w1fk7rq6m0y1gO/gBfLJopIIeRHQLS+BL6
	 0w45rA2Tz+7uQ==
Date: Sat, 12 Oct 2024 11:30:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
	mpetlan@redhat.com, peterz@infradead.org, mingo@redhat.com,
	mark.rutland@arm.com, irogers@google.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com
Subject: Re: [PATCH] perf dso: Fix symtab_type for kmod compression
Message-ID: <ZwrAPuAv-OlVMVj0@google.com>
References: <20241010144836.16424-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010144836.16424-1-vmolnaro@redhat.com>

On Thu, Oct 10, 2024 at 04:48:36PM +0200, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> During the rework of the dso structure in patch ee756ef7491eafd an
> increment was forgotten for the symtab_type in case the data for
> the kernel module are compressed. This affects the probing of the
> kernel modules, which fails if the data are not already cached.

It's easy to miss something buried in a mass conversion. :(

> 
> Increment the value of the symtab_type to its compressed variant so the
> data could be recovered successfully.
> 
> Fixes: ee756ef7491eafd7 ("perf dso: Add reference count checking and accessor functions")
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index fad227b625d155c5..4f0ac998b0ccfd7a 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1343,7 +1343,7 @@ static int maps__set_module_path(struct maps *maps, const char *path, struct kmo
>  	 * we need to update the symtab_type if needed.
>  	 */
>  	if (m->comp && is_kmod_dso(dso)) {
> -		dso__set_symtab_type(dso, dso__symtab_type(dso));
> +		dso__set_symtab_type(dso, dso__symtab_type(dso)+1);
>  		dso__set_comp(dso, m->comp);
>  	}
>  	map__put(map);
> -- 
> 2.43.0
> 
