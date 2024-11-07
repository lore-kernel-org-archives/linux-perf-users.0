Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAFC16419
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731005503; cv=none; b=kezHUTPWO10WI9+JrF6h5A90q9cT51+uK35XxAjFk8mIPnz72maRNUKqM5+6M0jsZrCZ84BHU0OnBFLMyzjUOR4m2fWU80ilamI3whzTjlcWaRBUgUclEZ8yddCsYUGlvb30H3HYZepFKKey3kbBl7dGtzMBBa1otad8I5PG5eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731005503; c=relaxed/simple;
	bh=F7XeE+bTVwZHEDe35rY7oTkCr56f045W1p7MsvwWR2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQOL7V/v5PSv7KPslrVogrilOt/xeYzhB3wOxzeQ9tfFpLcWo5HhRWaZjeWQnshd/5tshix0aDLsG5tjWVYh9pw1qwDhXmVwQOtG7n0HYHCLiUkFbbdZEk9v5YU5fNpUj3exb9CKULIDNBVquPV3ilqlTC2Jc4+imOj4sSJoAR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSfuakC7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSfuakC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D420BC4CECC;
	Thu,  7 Nov 2024 18:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731005503;
	bh=F7XeE+bTVwZHEDe35rY7oTkCr56f045W1p7MsvwWR2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BSfuakC7hNsJyU2A8aGkoaH3az+z4hXy9SZD5PX8GejNM/ijhHwSMemUcnlDoSu7w
	 UZztW+J0BahGvRKq/mq0iFlwmYmqdNemMqdEzmxiX+eXi63TgT1a9+5IiHTlTZ2XIt
	 azWqFjjHkBcWBPv0aJ/M61WcQcvuTffQY4YGjcX2Iy+CQ4JmxB53a+vB7V0EhkapGX
	 NlEc4ehRsJbitTfCJfjDRGHfYfVPU1n/i/eizs3zm8SztNEPJWC6m5RLocmV4TOVGV
	 jvRhqBsBAkvO/Xr8DSsuVyxB7HUACAPuR6kr2GRTkLo02x4Ic3ypnJDeEZHUDXjlVY
	 +yucEk/Vix1UQ==
Date: Thu, 7 Nov 2024 10:51:41 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Steve Clevenger <scclevenger@os.amperecomputing.com>
Cc: leo.yan@arm.com, james.clark@linaro.org, mike.leach@linaro.org,
	suzuki.poulose@arm.com, ilkka@os.amperecomputing.com,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V10 RESEND 1/2] perf util scripting-engines cs-etm: Add
 map_pgoff to python dictionary
Message-ID: <Zy0MPdvV5ofHtyE3@google.com>
References: <cover.1728599785.git.scclevenger@os.amperecomputing.com>
 <20241106235110.5NbhrBJjBk6qY_Sg0BJUbMXfpfpi8KZK5R-y4rZfKXI@z>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106235110.5NbhrBJjBk6qY_Sg0BJUbMXfpfpi8KZK5R-y4rZfKXI@z>

On Wed, Nov 06, 2024 at 04:51:10PM -0700, Steve Clevenger wrote:
> Add map_pgoff parameter to python dictionary so it can be seen by the
> python script.
> 
> Signed-off-by: Steve Clevenger <scclevenger@os.amperecomputing.com>
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> ---
>  tools/perf/util/scripting-engines/trace-event-python.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index d7183134b669..367132b3a51a 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -793,7 +793,8 @@ static int set_regs_in_dict(PyObject *dict,
>  static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
>  			    const char *dso_field, const char *dso_bid_field,
>  			    const char *dso_map_start, const char *dso_map_end,
> -			    const char *sym_field, const char *symoff_field)
> +			    const char *sym_field, const char *symoff_field,
> +			    const char *map_pgoff)
>  {
>  	char sbuild_id[SBUILD_ID_SIZE];
>  
> @@ -809,6 +810,8 @@ static void set_sym_in_dict(PyObject *dict, struct addr_location *al,
>  			PyLong_FromUnsignedLong(map__start(al->map)));
>  		pydict_set_item_string_decref(dict, dso_map_end,
>  			PyLong_FromUnsignedLong(map__end(al->map)));
> +		pydict_set_item_string_decref(dict, map_pgoff,
> +			PyLong_FromUnsignedLongLong(al->map->pgoff));

Please use map__pgoff(al->map) instead.  Otherwise you'll get this in
the debug build:

  util/scripting-engines/trace-event-python.c: In function 'set_sym_in_dict':     
  util/scripting-engines/trace-event-python.c:814:60: error: 'struct map' has no member named 'pgoff'
    814 |                         PyLong_FromUnsignedLongLong(al->map->pgoff));   
        |                                                            ^~

Thanks,
Namhyung


>  	}
>  	if (al->sym) {
>  		pydict_set_item_string_decref(dict, sym_field,
> @@ -895,7 +898,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>  	pydict_set_item_string_decref(dict, "comm",
>  			_PyUnicode_FromString(thread__comm_str(al->thread)));
>  	set_sym_in_dict(dict, al, "dso", "dso_bid", "dso_map_start", "dso_map_end",
> -			"symbol", "symoff");
> +			"symbol", "symoff", "map_pgoff");
>  
>  	pydict_set_item_string_decref(dict, "callchain", callchain);
>  
> @@ -920,7 +923,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>  			PyBool_FromLong(1));
>  		set_sym_in_dict(dict_sample, addr_al, "addr_dso", "addr_dso_bid",
>  				"addr_dso_map_start", "addr_dso_map_end",
> -				"addr_symbol", "addr_symoff");
> +				"addr_symbol", "addr_symoff", "addr_map_pgoff");
>  	}
>  
>  	if (sample->flags)
> -- 
> 2.44.0
> 
