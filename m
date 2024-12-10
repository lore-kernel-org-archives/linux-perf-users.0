Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E721AAA2F;
	Tue, 10 Dec 2024 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871317; cv=none; b=hYGooFKFGb1T4faCrwp6zlSGM+C6+8DH7qmBBqZY2hXICOvqMZVi9Bp3UGKzax+W7EKX4UIQT6RyoN7PSMza4qp9heVG5+zcvDOvXxj75NKHRs6NawXpiknPBVPcWlT17jwu8pFqW0D1jv/RGjodQqTFjIGve0/srKov4PIdWDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871317; c=relaxed/simple;
	bh=vS6taeVvtMUK1x8YDCRaE6xOh693IkAcJRtaIRw6LQQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DNjnLH9uud1b+PfowM/I/PLZj9RwmXc5nP9TozHV6eTxcdU7wJA3cr7BL0F/TiCTqI6rlGDMBGmKjFJXhNeGLBj8Qj/dloAH+DR0FsVltAsbc+E/8OJmXylzzeKUCO7vDy7xDOO0RNR9jlhWtyBlO6revhChZXRZZeSHg3zckqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgadqRS6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgadqRS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65611C4CED6;
	Tue, 10 Dec 2024 22:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733871317;
	bh=vS6taeVvtMUK1x8YDCRaE6xOh693IkAcJRtaIRw6LQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SgadqRS6mwTM5AccjhHKPttp3+QBTmWY3srV4Y4priF394l5Zz2NB/uSZ7tueKgwh
	 UJeJbjX6FfnsVqdeDW1+/9s1hXV1FJKI/uqbEzMor/OWxmU2oriOVitCaei5FeFYuY
	 uFSBw5fnRngYTaC5TCBOLSHpuDX5/24CHGlyYyMbVN/quO+uL7BveE7hZ3d+UeZezg
	 rdlD3xx64Xflyk/jCJW+Z/yWoodxdkzHBn1pgSF8H5uI+MEavobIKvsfHRSx7jgH8G
	 4lOw535/cfzqWSnUpf60M34RDPFJVwgVfnkL7IruJ341LhLeJN13xZ2XruoiSzbLiJ
	 Ch1AU++H0UO5A==
Date: Wed, 11 Dec 2024 07:55:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, acme@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Leo Yan <leo.yan@arm.com>, Dima Kogan
 <dima@secretsauce.net>, "Dr. David Alan Gilbert" <linux@treblig.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf probe: Fix uninitialized variable
Message-Id: <20241211075510.ea7924b5b80bf0d95993086b@kernel.org>
In-Reply-To: <20241209171222.1422577-1-james.clark@linaro.org>
References: <20241209171222.1422577-1-james.clark@linaro.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Mon,  9 Dec 2024 17:12:21 +0000
James Clark <james.clark@linaro.org> wrote:

> Since the linked fixes: commit, err is returned uninitialized due to the
> removal of "return 0". Initialize err to fix it, and rename err to out
> to avoid confusion because buf is still supposed to be freed in non
> error cases.
> 
> This fixes the following intermittent test failure on release builds:
> 
>  $ perf test "testsuite_probe"
>  ...
>  -- [ FAIL ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -V bar (output regexp parsing)
>  Regexp not found: \"Error: switch .+ cannot be used with switch .+\"
>  ...
> 
> Fixes: 080e47b2a237 ("perf probe: Introduce quotation marks support")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/util/probe-event.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 6d51a4c98ad7..35af6570cf9b 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -1370,7 +1370,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
>  {
>  	char *buf = strdup(arg);
>  	char *p;
> -	int err;
> +	int err = 0;

I think only this is required, and others are just cleanups by renaming
err -> out (usually for-next).
But Arnaldo is OK to combine these changes, I'm OK too.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

>  
>  	if (!buf)
>  		return -ENOMEM;
> @@ -1383,20 +1383,20 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
>  		if (p == buf) {
>  			semantic_error("No file/function name in '%s'.\n", p);
>  			err = -EINVAL;
> -			goto err;
> +			goto out;
>  		}
>  		*(p++) = '\0';
>  
>  		err = parse_line_num(&p, &lr->start, "start line");
>  		if (err)
> -			goto err;
> +			goto out;
>  
>  		if (*p == '+' || *p == '-') {
>  			const char c = *(p++);
>  
>  			err = parse_line_num(&p, &lr->end, "end line");
>  			if (err)
> -				goto err;
> +				goto out;
>  
>  			if (c == '+') {
>  				lr->end += lr->start;
> @@ -1416,11 +1416,11 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
>  		if (lr->start > lr->end) {
>  			semantic_error("Start line must be smaller"
>  				       " than end line.\n");
> -			goto err;
> +			goto out;
>  		}
>  		if (*p != '\0') {
>  			semantic_error("Tailing with invalid str '%s'.\n", p);
> -			goto err;
> +			goto out;
>  		}
>  	}
>  
> @@ -1431,7 +1431,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
>  			lr->file = strdup_esq(p);
>  			if (lr->file == NULL) {
>  				err = -ENOMEM;
> -				goto err;
> +				goto out;
>  			}
>  		}
>  		if (*buf != '\0')
> @@ -1439,7 +1439,7 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
>  		if (!lr->function && !lr->file) {
>  			semantic_error("Only '@*' is not allowed.\n");
>  			err = -EINVAL;
> -			goto err;
> +			goto out;
>  		}
>  	} else if (strpbrk_esq(buf, "/."))
>  		lr->file = strdup_esq(buf);
> @@ -1448,10 +1448,10 @@ int parse_line_range_desc(const char *arg, struct line_range *lr)
>  	else {	/* Invalid name */
>  		semantic_error("'%s' is not a valid function name.\n", buf);
>  		err = -EINVAL;
> -		goto err;
> +		goto out;
>  	}
>  
> -err:
> +out:
>  	free(buf);
>  	return err;
>  }
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
