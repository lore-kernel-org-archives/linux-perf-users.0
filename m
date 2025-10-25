Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D3F22D4F1;
	Sat, 25 Oct 2025 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761414036; cv=none; b=KO6coXXWS7TJHrusjTm7JS/Jk21bj18zSBVpK08RPzJglfp4H1JcfoKY+5Xmb117HJsWsIFetVQrAlXkqaRR+j8goa9gVu6St0jmFrJanRuZl9gCw/a+4zvL4j6n5xQA71EgDmUKWl3yx9CRn0Zln/bZsSOkglUewsRnKj77gsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761414036; c=relaxed/simple;
	bh=RjlO/VhXM00gnisSyTmBDQTxNNV+9bUZv6mBi9rqeC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKvGQUdzhOUPG2pqALXIJSogGLHLIfNI3XUfMkZ4Sn/LD1GJ6NScNIVdvYMU399uwCqDkjMHHCAI7oj6tHrqOXFTPymqvC0GYnUekW5sDLeF7xxv6GHepRrh/8zbSuSH95kViZzBoUNfOWXRCUvHsx7fEKFUkMeypLsU6q2u9K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJ6AsE3z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ6AsE3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5BFC4CEF5;
	Sat, 25 Oct 2025 17:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761414036;
	bh=RjlO/VhXM00gnisSyTmBDQTxNNV+9bUZv6mBi9rqeC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJ6AsE3zvkDjyGJbCrPBVtU8xiIBeUBwsCqB3pHwK8yUlPx5BG//HoE7f06RmC43O
	 VAEslrEEVXrsNsja7tL+kfMDm6JZzS67bS17+bv5AgA93edH5OWWJS7dSRhwuu9kEo
	 WxiGkrknNc2/viIkwJsOcnP4751Vd1udU1BQum2gvpqz9Ny7g4xpup7Gl9M0ZdK5Yu
	 15kjq22nyVGuEWksQNKrdFrT2fRKIsYq+PTPPyyUQ9cjmxpwzbV8I7760lGc89sxPD
	 iUSyCsG4UmBNRTEvRRs0eXpDg2jEfXazRsifE98+n86unJ3lynjvnjHu5whW/zYn6L
	 EuGS+QB3xamfA==
Date: Sat, 25 Oct 2025 10:40:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/9] perf dwarf-aux: Preserve typedefs in
 match_var_offset
Message-ID: <aP0LkimOCj389dNl@google.com>
References: <20251013181607.2745653-1-zecheng@google.com>
 <20251013181607.2745653-8-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013181607.2745653-8-zecheng@google.com>

On Mon, Oct 13, 2025 at 06:16:04PM +0000, Zecheng Li wrote:
> Since we are skipping the check_variable, we need to preserve typedefs
> in match_var_offset to match the results by __die_get_real_type. Also
> move the (offset == 0) branch after the is_pointer check to ensure the
> correct type is used, fixing cases where an incorrect pointer type was
> chosen when the access offset was 0.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/util/dwarf-aux.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index b57cdc8860f0..b2189de07daf 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1395,24 +1395,24 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
>  	Dwarf_Word size;
>  	s64 offset = addr_offset - addr_type;
>  
> -	if (offset == 0) {
> -		/* Update offset relative to the start of the variable */
> -		data->offset = 0;
> -		return true;
> -	}
> -
>  	if (offset < 0)
>  		return false;
>  
> -	if (die_get_real_type(die_mem, &data->type) == NULL)
> +	if (__die_get_real_type(die_mem, &data->type) == NULL)
>  		return false;

If the type was a typedef of a pointer, then the following check for a
pointer cannot detect the target type.

Thanks,
Namhyung

>  
>  	if (is_pointer && dwarf_tag(&data->type) == DW_TAG_pointer_type) {
>  		/* Get the target type of the pointer */
> -		if (die_get_real_type(&data->type, &data->type) == NULL)
> +		if (__die_get_real_type(&data->type, &data->type) == NULL)
>  			return false;
>  	}
>  
> +	if (offset == 0) {
> +		/* Update offset relative to the start of the variable */
> +		data->offset = 0;
> +		return true;
> +	}
> +
>  	if (dwarf_aggregate_size(&data->type, &size) < 0)
>  		return false;
>  
> -- 
> 2.51.0.788.g6d19910ace-goog
> 
