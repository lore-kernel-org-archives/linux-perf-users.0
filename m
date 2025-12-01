Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A40F1F30BB;
	Mon,  1 Dec 2025 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764612266; cv=none; b=dMqIwveBB+tWVmC4DHySnRTJxz6z2hZB6C7R1K+abwrjZXM3DaVOMXEpytGnKRU0m7eNX5y4mcpiRqHuKShmT6qA+/JTPS2WSYxLyEixnMM8+JEUKBl5wKReqOUD97rxrnlAWemKED+NVeQEF/qrb1Ya1UApt4zQF9DsBAHd7gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764612266; c=relaxed/simple;
	bh=Gb4XTvI/x9vKAgaq8ubQZtTAYFOtWMWwkqv/JpD+ADY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSGWfj8G/qYWwZ7FWwpTLXMHUrI58vgycPKegtrQTqVhx7E1qrbUZmpmFOkYtMmADALgxUjrGRiQFZpLQZE4GZyZcl/dzayattELtCQtfBfSyXVLK769FbPhhXGQCBUeuof1R/0XIawCl6QWI/CHiZgY2GOjaXx1UlqmJd6hiYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gi4OwzsT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gi4OwzsT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FECC4CEF1;
	Mon,  1 Dec 2025 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764612266;
	bh=Gb4XTvI/x9vKAgaq8ubQZtTAYFOtWMWwkqv/JpD+ADY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gi4OwzsTkPkU1RM3Q8E69+v3xNudw6vRjerVLkMzvd5/KvjMpF/G/xa+Ruho0OZpP
	 cRYqE/UniHHIfDlUF88I//FPuGmC7cm/QIVBJ8zQEZh4m1aXbbwgdZrNos+UyCmIZe
	 DznzG9ou0ctkO2N2O86s7uJrpTZdBN+G3U8i6f9menekNchZH6wgkSFlGmV/FXtg88
	 ZTEkrTf/Dr+fHyfuhNytFU2rFzrGTJIzHFul1AxEvOicWoj+edq9jGh4kx80ro8igy
	 3+1pXkUkGl/dmje/n0+MnMqF0yIuST5wdIW1LPLbdHhFOxoM1oY62JEkdR6+pDUTLx
	 sL84trwkXmTzg==
Date: Mon, 1 Dec 2025 15:04:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 03/17] perf symbol-elf: Add missing puts on error path
Message-ID: <aS3YpyPwlBq2ald2@x1>
References: <20251122081929.7588-1-irogers@google.com>
 <20251122081929.7588-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251122081929.7588-4-irogers@google.com>

On Sat, Nov 22, 2025 at 12:19:15AM -0800, Ian Rogers wrote:
> In dso__process_kernel_symbol if inserting a map fails, probably
> ENOMEM, then the reference count puts were missing on the dso and map.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/symbol-elf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 9e820599bab3..4c76e680b13d 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1446,8 +1446,11 @@ static int dso__process_kernel_symbol(struct dso *dso, struct map *map,
>  			map__set_mapping_type(curr_map, MAPPING_TYPE__IDENTITY);
>  		}
>  		dso__set_symtab_type(curr_dso, dso__symtab_type(dso));
> -		if (maps__insert(kmaps, curr_map))
> +		if (maps__insert(kmaps, curr_map)) {
> +			dso__put(curr_dso);
> +			map__put(curr_map);
>  			return -1;
> +		}
>  		dsos__add(&maps__machine(kmaps)->dsos, curr_dso);
>  		dso__set_loaded(curr_dso);
>  		dso__put(*curr_dsop);
> -- 
> 2.52.0.rc2.455.g230fcf2819-goog
