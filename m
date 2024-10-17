Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA871C1ADA;
	Thu, 17 Oct 2024 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729203652; cv=none; b=jSjwvdIKwZkfiGU7Stlt6z0/h+mzuRLTul1tgHyCbnzagZfnUiGWmIiPtDOSuCQ0rQS+SBFfCYZ2X94zGSWSzUk01P33qMElCL7xkMgbBYx7YMGOoY5xzWJOk4EmdRsfpybJTv3o4DDUeYi5S5Sfv4VgscnrLNRvnWfn85F/pb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729203652; c=relaxed/simple;
	bh=UZFQlI8ALtTjuxp1+9vlyb/9Sn3LWMwZCxzz5dUuJmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=koga1Kc7lVKkZ3CPmPRFRT2f7wQa/x3wRQjJ91sj1sf1J0DZe1jjzpeuI4aEDzfOjp8JRMwm68zoKS7dD+cP1w3EnAFgEIRJmb4FCLoN8OXF5PZ2WY2ZmECXvlDoGLXAh/ucHG8IUWY87Vnq6/3CEDQK8Gwpa/3PDh/LepZ02Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSjWbuON; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSjWbuON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A128C4CEC3;
	Thu, 17 Oct 2024 22:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729203651;
	bh=UZFQlI8ALtTjuxp1+9vlyb/9Sn3LWMwZCxzz5dUuJmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QSjWbuONw9XjQ2z/6dtwTZVOqSRIbR9FH7gQYBWXXl/y/z6OoLBoNOiNRVmrvWOIQ
	 mFgqc6QGaF77bBg8NaVYmPfvFtIBhgOFh+To7a0YQ7hY+6fhjoureyWQqndTJexRg3
	 AwkHqDJ4pgotr+Id+jCPkG731W5Hza/yOh5dyPIo5V0ab9/Wlz32XuzJVb0KiVmrSb
	 1KhwhVL+Otart7XW2VRELn1pX1rCrI5Zzp7ePknlObhkeMtiI28ucRTxUAQS6p2NF6
	 r7duqbt+w+SEzbidbAnY5FuJLJdI3EDG2KJC7A7ExYnsDoMw9P9gyDSxdDUoF1qWgG
	 hshIzaqS6cp1w==
Date: Thu, 17 Oct 2024 15:20:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Li Huafei <lihuafei1@huawei.com>
Cc: atrajeev@linux.vnet.ibm.com, peterz@infradead.org, mingo@redhat.com,
	acme@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, kjain@linux.ibm.com, sesse@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] perf disasm: Fix not cleaning up disasm_line in
 symbol__disassemble_raw()
Message-ID: <ZxGNwWjlflH1azE7@google.com>
References: <20241014114248.212711-1-lihuafei1@huawei.com>
 <20241014114248.212711-3-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241014114248.212711-3-lihuafei1@huawei.com>

On Mon, Oct 14, 2024 at 07:42:48PM +0800, Li Huafei wrote:
> In symbol__disassemble_raw(), the created disasm_line should be
> discarded before returning an error.

But other error paths don't need to free the disasm_line because they
failed before creating one.  I think the simpler fix is to break the
loop when it fails on disasm_line__new().

Thanks,
Namhyung

> 
> Fixes: 0b971e6bf1c3 ("perf annotate: Add support to capture and parse raw instruction in powerpc using dso__data_read_offset utility")
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  tools/perf/util/disasm.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 40d99f4d5cc7..4e5becd5eca6 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -1774,25 +1774,23 @@ static int symbol__disassemble_raw(char *filename, struct symbol *sym,
>  		offset += 4;
>  	}
>  
> -	/* It failed in the middle */
> -	if (offset != len) {
> -		struct list_head *list = &notes->src->source;
> -
> -		/* Discard all lines and fallback to objdump */
> -		while (!list_empty(list)) {
> -			dl = list_first_entry(list, struct disasm_line, al.node);
> -
> -			list_del_init(&dl->al.node);
> -			disasm_line__free(dl);
> -		}
> -		count = -1;
> -	}
> -
>  out:
>  	free(buf);
>  	return count < 0 ? count : 0;
>  
>  err:
> +	if (!list_empty(&notes->src->source)) {
> +		struct disasm_line *tmp;
> +
> +		/*
> +		 * It probably failed in the middle of the above loop.
> +		 * Release any resources it might add.
> +		 */
> +		list_for_each_entry_safe(dl, tmp, &notes->src->source, al.node) {
> +			list_del(&dl->al.node);
> +			disasm_line__free(dl);
> +		}
> +	}
>  	count = -1;
>  	goto out;
>  }
> -- 
> 2.25.1
> 
