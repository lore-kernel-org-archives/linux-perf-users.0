Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DB814A09C
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Apr 2024 23:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712619133; cv=none; b=qc1kT63jyZWfkqtMgHeIyKTk36aWfOj+beuCnHZ2L6QE58Ec8yB7ZYdDw4j5/DZZpcGLtqgquqGEIKQhiZPBuLrR9GVgT40xYJXe5lEBuF6j61ek9mjzXlnV/YoVpRHrFQjzMYgI95D1QdqtcExjjUy2GyAT7WyhgrU/92oe/wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712619133; c=relaxed/simple;
	bh=MQwJwhmpaKJ27PlWek2zI2MXubCACLIe7/RzK9r8xK4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rPSNJz+ygf13TatK4T3wFddya3RFNqkns62jb2jtd7I4iG8g+8qcxc10o0EBoCEdWhHfBEJTvA59qm8TUxDOwTwuPbeCI+BIJ5MqwD+2y8/VZLQoJb4Fd3uCj8Vdr7Ih1XEMJI2vHIs7SFMpSpn246bFKIS1CTMgmCkitGDB0eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehWA43uE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehWA43uE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93983C43390;
	Mon,  8 Apr 2024 23:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712619133;
	bh=MQwJwhmpaKJ27PlWek2zI2MXubCACLIe7/RzK9r8xK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ehWA43uEj1w0RzAvYSx+mNCs6s+O67wzTboooc13PokFARLS6klofHtbpbkb71m4h
	 fL+pWfP8OG3onvQu109OYu4R3VdPVQd9xgr/gTcqltlDvMnXj7bW+OcPgaBC4clVNd
	 G8nZFaNT9w7jXRV6vuFyDUR69/eZUg0GE3xhVqMrtuR9U8N9kcLdbBbPdG2Kq2XvBW
	 kWdC69oCrseJokJunPp+p6euT5QwPdvzMpbu3N+7nbQ2vaRl/9eMIuilqQ5tJI3l2F
	 lejimjAeg3q+lIhIdq6LHsvtOmBvF6C2DBJdFd3Hu/Uhug2iwhLPr1CcE5+P5JvhGR
	 Cmv7SW6pF4ZyA==
Date: Tue, 9 Apr 2024 08:32:09 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
Cc: linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
 james.clark@arm.com, Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: Re: [PATCH V2 1/8] tools lib: adopt str_has_suffix() from
 bpftool/gen.c
Message-Id: <20240409083209.f56351bcc8726439324a8d72@kernel.org>
In-Reply-To: <20240408062230.1949882-2-ChaitanyaS.Prakash@arm.com>
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
	<20240408062230.1949882-2-ChaitanyaS.Prakash@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Apr 2024 11:52:23 +0530
Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com> wrote:

> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> 
> Adopt the definition of str_has_suffix() from tools/bpf/bpftool/gen.c
> and add it to tools/lib/string.c The function is modified to return
> strlen(suffix) on success and 0 on failure.
> 
> Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> ---
>  tools/include/linux/string.h |  2 ++
>  tools/lib/string.c           | 26 ++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
> index db5c99318c79..e43c8f78d63c 100644
> --- a/tools/include/linux/string.h
> +++ b/tools/include/linux/string.h
> @@ -42,6 +42,8 @@ static inline bool strstarts(const char *str, const char *prefix)
>  	return strncmp(str, prefix, strlen(prefix)) == 0;
>  }
>  
> +size_t str_has_suffix(const char *str, const char *suffix);
> +
>  extern char * __must_check skip_spaces(const char *);
>  
>  extern char *strim(char *);
> diff --git a/tools/lib/string.c b/tools/lib/string.c
> index 8b6892f959ab..9cb515048239 100644
> --- a/tools/lib/string.c
> +++ b/tools/lib/string.c
> @@ -226,3 +226,29 @@ void *memchr_inv(const void *start, int c, size_t bytes)
>  
>  	return check_bytes8(start, value, bytes % 8);
>  }
> +
> +/**
> + * str_has_suffix - Test is a string has a given suffix
> + * @str: The string to be tested
> + * @suffix: The string to see if @str ends with
> + *
> + * Returns:
> + * * strlen(@suffix) if @str ends with @suffix
> + * * 0 if @str does not end with @suffix

I think this should return boolean, because user will never check the
return value is strlen(@suffix). (and user always use the return value
as a boolean)

Thank you,

> + */
> +size_t str_has_suffix(const char *str, const char *suffix)
> +{
> +	size_t i;
> +	size_t str_len = strlen(str);
> +	size_t suffix_len = strlen(suffix);
> +
> +	if (str_len < suffix_len)
> +		return 0;
> +
> +	for (i = 0; i < suffix_len ; i++) {
> +		if (str[str_len  - i - 1] != suffix[suffix_len - i - 1])
> +			return 0;
> +	}
> +
> +	return suffix_len;
> +}
> -- 
> 2.30.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
