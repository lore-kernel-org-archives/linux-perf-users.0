Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E39D1E7C19;
	Sat, 30 Aug 2025 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756539142; cv=none; b=sUyEwvxRUddQyGfNKgKPy2pK/Vk6yfK4AWJWvCqxsGn6aTIimYjGIMPNZm8JbyiXByoTbRG6zydPMRjhwDzY5A9G9lQ/8bLYXtaMzzq4SCzpkknSJSIGgR5Iw5zRp9Zkzovt4r/1CXDz64c6U3fx4ZqcLFK4CKX3JbeegRn76E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756539142; c=relaxed/simple;
	bh=RGp3ddA4LilfmaKgx4X1UvwIDC2Qxah6dGbdz6vqB+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPWXjo4c5UdnJeO+EVwehiUDRKHg9+PRC/L7NavmVtwEH55SHPL87YSac3Sgv51W+Q8MPppEKsQPfN0leNZNgIMevkKirD8BxF74U/dFzNfqEezBSJPvq+CzBG5GNAmOsVmzKhGr3rXJt4bRWZTyuRpRkTjoMIIZ65uxvLRATyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pl4Fj5WI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pl4Fj5WI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A136C4CEEB;
	Sat, 30 Aug 2025 07:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756539141;
	bh=RGp3ddA4LilfmaKgx4X1UvwIDC2Qxah6dGbdz6vqB+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pl4Fj5WIahTvym+NX4p6COPbJWOK9MEWCv0PaGcqnAb2a66F/1SGc2eSLrvCnINa7
	 USTC4ovvQXFJ+RQf6+T7XgtlEMDFZnG654YY27kdPSpw1XdfH5HayMVQAL1t8KVL80
	 xcnyNOU/zX1fmpCeZhreDBs3D8YvutlKYiESNmvCmNZhiiCivoF0tXJVBUbJms6IcH
	 tTjEf5Lc71qOlTZNZ7bPpTyNwBV1LCSup+w4BtmJPDtdX7oYaIU5PU7zpOanC2soD6
	 HSg93vxlp6/yNXdM1eSF4agjSlWO5VuzaK9D1Pt6T6QiHBckYx2ta9xXcDD5OgVDlu
	 vJhXsgc+oLLvQ==
Date: Sat, 30 Aug 2025 00:32:19 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] perf dwarf-aux: fix __die_find_scope_cb for
 namespaces
Message-ID: <aLKpAxq5QQIwD_Z_@google.com>
References: <20250825195817.226560-1-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825195817.226560-1-zecheng@google.com>

On Mon, Aug 25, 2025 at 07:58:17PM +0000, Zecheng Li wrote:
> Currently __die_find_scope_cb goes to check siblings when the DIE
> doesn't include the given PC. However namespaces don't have a PC and
> could contain children that have that PC. When we encounter a namespace,
> we should check both its children and siblings.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/dwarf-aux.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 56e1b5690dc4..013862ea8924 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1962,6 +1962,7 @@ struct find_scope_data {
>  static int __die_find_scope_cb(Dwarf_Die *die_mem, void *arg)
>  {
>  	struct find_scope_data *data = arg;
> +	int tag = dwarf_tag(die_mem);
>  
>  	if (dwarf_haspc(die_mem, data->pc)) {
>  		Dwarf_Die *tmp;
> @@ -1975,6 +1976,14 @@ static int __die_find_scope_cb(Dwarf_Die *die_mem, void *arg)
>  		data->nr++;
>  		return DIE_FIND_CB_CHILD;
>  	}
> +
> +	/*
> +	 * If the DIE doesn't have the PC, we still need to check its children
> +	 * and siblings if it's a container like a namespace.
> +	 */
> +	if (tag == DW_TAG_namespace)
> +		return DIE_FIND_CB_CONTINUE;
> +
>  	return DIE_FIND_CB_SIBLING;
>  }
>  
> -- 
> 2.51.0.261.g7ce5a0a67e-goog
> 
