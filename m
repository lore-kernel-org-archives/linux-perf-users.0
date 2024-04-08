Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB2762CD
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Apr 2024 23:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712619242; cv=none; b=R+v8WJ6ax+qan1p7tx6XIvXQRB5172vFYaUrJrNH2wWz0clxxTCVis5Iynpc3U0t4jiN3cslxh/sW6DQeosHW17UB4L1YzShcUXMoOVSmc59iXn/joQXoOmhJEhMwMPu3JfILli/aOFxrkpFfazwn2CFyXoMYFLfQJ7kV4bNZOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712619242; c=relaxed/simple;
	bh=EPZR0ymsR8ztHP32aBeHKcXjtw0xHE/H6AwRhVBmm2g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=q66m5G5stpg50kKnKiwZnV9EnHRwcKoiO+ZUp57X1fxa37mqJ/uTqKbn93M5nnqgJcP0sTY6eRRMxigH2DCgCRYCHLbGtJGZfEI+7O3nnnjSZQlOaob98VX42+LjM6ui5k8GlXSUilVCUyw+m+Y3hk8PO6aeO2Sb46NrorOXHL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEtykOaT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEtykOaT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A364C433C7;
	Mon,  8 Apr 2024 23:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712619242;
	bh=EPZR0ymsR8ztHP32aBeHKcXjtw0xHE/H6AwRhVBmm2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SEtykOaTZhrRprlNITSxZZh+JgOlSXE5/MFBHB6ks4rBmtprw1+amG0epy0ahCqW8
	 0ZbFuE4GROQhx9MxNzENi0dRkHBGuTXtGJb7TlLS8ux60PUTkJlxXLDaXRdeIDrBn2
	 950RJsbqR52LouTrJgzLFornsaOM/Gg2JYNqJRLm57hFAlLcagjLJrB55Der0Ccmg0
	 Yp4kErfrWfZFopSMXhkcbK25akeD/y2oc3aRVG2ArU9np8Kq8H3VrIOQR2nBKSW8L1
	 8gIJ7j182oQ7EaJJM3/yw6Z2oTe2nrNFitRlKMCV5b6wHosEclQRYVIwkPR7O2QmNT
	 4FYzLGQ3nKhMg==
Date: Tue, 9 Apr 2024 08:33:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
Cc: linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
 james.clark@arm.com, Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: Re: [PATCH V2 4/8] tools lib: Adopt str_has_prefix() from kernel
Message-Id: <20240409083359.e02be97c6a19ef2a5014e894@kernel.org>
In-Reply-To: <20240408062230.1949882-5-ChaitanyaS.Prakash@arm.com>
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
	<20240408062230.1949882-5-ChaitanyaS.Prakash@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Apr 2024 11:52:26 +0530
Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com> wrote:

> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> 
> Add str_has_prefix() to tools/include with the intention to replace
> strstarts().
> 
> Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> ---
>  tools/include/linux/string.h |  2 ++
>  tools/lib/string.c           | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
> index e43c8f78d63c..e02292fa1fab 100644
> --- a/tools/include/linux/string.h
> +++ b/tools/include/linux/string.h
> @@ -44,6 +44,8 @@ static inline bool strstarts(const char *str, const char *prefix)
>  
>  size_t str_has_suffix(const char *str, const char *suffix);
>  
> +size_t str_has_prefix(const char *str, const char *prefix);
> +
>  extern char * __must_check skip_spaces(const char *);
>  
>  extern char *strim(char *);
> diff --git a/tools/lib/string.c b/tools/lib/string.c
> index 9cb515048239..76b15ee6493e 100644
> --- a/tools/lib/string.c
> +++ b/tools/lib/string.c
> @@ -252,3 +252,19 @@ size_t str_has_suffix(const char *str, const char *suffix)
>  
>  	return suffix_len;
>  }
> +
> +/**
> + * str_has_prefix - Test is a string has a given prefix
> + * @str: The string to be tested
> + * @prefix: The string to see if @str starts with
> + *
> + * Returns:
> + * * strlen(@prefix) if @str starts with @prefix
> + * * 0 if @str does not start with @prefix

Here, too. Is there any reason to return strlen(@prefix)?

Thank you,

> + */
> +size_t str_has_prefix(const char *str, const char *prefix)
> +{
> +	size_t prefix_len = strlen(prefix);
> +
> +	return strncmp(str, prefix, prefix_len) == 0 ? prefix_len : 0;
> +}
> -- 
> 2.30.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
