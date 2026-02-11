Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F9027FB21;
	Wed, 11 Feb 2026 02:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770776623; cv=none; b=KZnfftPeWwgxmaxsmrCjLKcAKJmdSMiRzgAPivOhthgAzikjouzhaVWqUQr2LqUPfIqzYDKl6n1/vLv13xWoK2jq9INJRkb1E8VfMEYbTNxKbI6arbURntxVNCW/Ghzl9TxMpjzONNkiKw9KNdLUJJTG3Xd0gSMZCkQg9D1w7ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770776623; c=relaxed/simple;
	bh=tViUI6g7ORT2tPuXLiX4X2qQ9W+/n5w12qXRc6F77UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIpbtmEIwH4PMoxCe5onEOjQR09e1YcHw2Aa08456Tgz8e1uTfhdVx1jc0Pn+MHFdy04jeoOXwCUGtv8ikuXVBdAu/dM5Ruk3/LD+4A/P2+L8C06QHxDI45Wz4XauhaMYLM8BkdB/F2N9hI8yOu5tirN4gQdJvh/k9/f5dnyWbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U64pR2W4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U64pR2W4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432DDC116C6;
	Wed, 11 Feb 2026 02:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770776622;
	bh=tViUI6g7ORT2tPuXLiX4X2qQ9W+/n5w12qXRc6F77UI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U64pR2W4+raKJQESBxKbRuU35qAxyxi2WFr3TpYNOLOFNIiDUoWw9b7G1ScHJZ/12
	 2kHVKXIETfiofbiD6ZXPtxhXnwerJ9CtyJ/TAQ6pSvFcgCc5pFDHIDrv113VzF79pP
	 JI+BDpPL14zBYs3nwLbhIHXan33P32Xhd9vhRqjjiRFOCFbQfJJrX/i4PmLsNfjyT8
	 KbR6U9K/sgG5RFVxm40GajUzLycxaYvU+qiB7VqJkMT998H686sKsfPs2wSJidFvfu
	 pzjMlmPjfJw4IXSrQaZPNGSA2qYjLhQW6VlWffW9neokQrJHK0dsqUZBWiiat6fvD3
	 H+1I2dCu9gdrA==
Date: Tue, 10 Feb 2026 18:23:40 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zli94@ncsu.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, xliuprof@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zecheng Li <zecheng@google.com>
Subject: Re: [PATCH v1 03/11] perf dwarf-aux: Preserve typedefs in
 match_var_offset
Message-ID: <aYvoLPbk82HUR23S@google.com>
References: <20260127020617.2804780-1-zli94@ncsu.edu>
 <20260127020617.2804780-4-zli94@ncsu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127020617.2804780-4-zli94@ncsu.edu>

On Mon, Jan 26, 2026 at 09:04:56PM -0500, Zecheng Li wrote:
> From: Zecheng Li <zecheng@google.com>
> 
> Since we are skipping the check_variable, we need to preserve typedefs
> in match_var_offset to match the results by __die_get_real_type. Also
> move the (offset == 0) branch after the is_pointer check to ensure the
> correct type is used, fixing cases where an incorrect pointer type was
> chosen when the access offset was 0.

Can you move the patch 1 after this so that it doesn't get the temporary
regression?  Maybe it doesn't matter much whether it sees a typedef or
an underlying type, but it'd be better to keep it consistent if it's not
too hard. :)

Thanks,
Namhyung

> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> Signed-off-by: Zecheng Li <zli94@ncsu.edu>
> ---
>  tools/perf/util/dwarf-aux.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
> index 96cfcbd40c45..ce816aefa95b 100644
> --- a/tools/perf/util/dwarf-aux.c
> +++ b/tools/perf/util/dwarf-aux.c
> @@ -1420,26 +1420,29 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
>  			     s64 addr_offset, s64 addr_type, bool is_pointer)
>  {
>  	Dwarf_Word size;
> +	Dwarf_Die ptr_die;
> +	Dwarf_Die *ptr_type;
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
>  
> -	if (is_pointer && dwarf_tag(&data->type) == DW_TAG_pointer_type) {
> +	ptr_type = die_get_pointer_type(&data->type, &ptr_die);
> +	if (is_pointer && ptr_type) {
>  		/* Get the target type of the pointer */
> -		if (die_get_real_type(&data->type, &data->type) == NULL)
> +		if (__die_get_real_type(ptr_type, &data->type) == NULL)
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
> 2.52.0
> 
