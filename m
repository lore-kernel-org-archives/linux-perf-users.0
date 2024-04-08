Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67A714A60C
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Apr 2024 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712618458; cv=none; b=Imb7ZO8RBADcSrmYv5t5m4IgB7zeJyOdbRibVFc8MGZ8Za7QN364L15viw+RO5UWQA+M3SK/3f8c7JyAYwMk6u+jrqP6XUFQztLGF+KQD5Kh/nYicN6YghaELAP3RPTpJqWSDJ+U4njmLqTc2xhpS4PmK7qMGOGlIutv9okqIi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712618458; c=relaxed/simple;
	bh=b/iyRrnZa/z967JTJu/ve5i+11t6msbl6kk+AoG/CKs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SKnLhF2Wk8cg/IMd1FwUS/kqMBwGBRwMotV71EQd7lWqDTtDpiXacahDGlpguxyxuk2AhE7a388RVicG8gdZ0Whyp6Q4CILch4AnJCae0FBcnJ80777+Resh82HcGGPuBVWO0Qg12TFeaTRWoUdJ7O/AWy9+gYGsApl4JVcJ5cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tpr7bi2l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tpr7bi2l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA9EC43394;
	Mon,  8 Apr 2024 23:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712618458;
	bh=b/iyRrnZa/z967JTJu/ve5i+11t6msbl6kk+AoG/CKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tpr7bi2lgCaTVFK5ago+39naVO5F+IbIMMEpwiJx1a9rRE1hA29P3t5dHhicgBYoe
	 LvgLSj0ei0DTgp9+YaqOQQbfHLr949mXrFeR7FSl86CFcoIs8ED08owZxNPJpffSwp
	 rFJ/xp/p8OGDysor7ZOcqjPBg7CBWRuXdhN21qVXUN2alOTewLPK85z8lQ393GUuIZ
	 rl3hXcVca+shD9WsRn9m20IRn/LIwVyTE7sPSzBaBMQcAMPlj2dGIM05bEu3X4WHlw
	 ORvc9TmVKCf+DWHzYvQ0tg+CxSrpQXtVjGiy5KFZNyhI8DJKIe8SO9fj1dezRd1E7a
	 ckMOGamb9VsEA==
Date: Tue, 9 Apr 2024 08:20:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
Cc: linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
 james.clark@arm.com, Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: Re: [PATCH V2 3/8] perf util: Replace an instance of strtailcmp()
 by str_has_suffix()
Message-Id: <20240409082054.89a01cce8e5f55f067e13eb4@kernel.org>
In-Reply-To: <20240408062230.1949882-4-ChaitanyaS.Prakash@arm.com>
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
	<20240408062230.1949882-4-ChaitanyaS.Prakash@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Apr 2024 11:52:25 +0530
Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com> wrote:

> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> 
> This particular instance makes use strtailcmp() to check if the "path"
> parameter is a loadable kernel module, it does so by checking if "path"
> is followed by ".ko" suffix. As this use case is more suitable for
> str_has suffix(), replace strtailcmp() with str_has_suffix().
> 
> The other calls to strtailcmp() do not seem equivalent to the
> str_has_suffix() use case. As this function is not being hit in any of
> the tests as well it would be rather risky to replace its use with
> str_has_suffix(). Therefore, those calls are retained as is.
> 
> Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> ---
>  tools/perf/util/probe-event.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 2a0ad9ecf0a2..59e700170541 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -564,7 +564,7 @@ static struct debuginfo *open_debuginfo(const char *module, struct nsinfo *nsi,
>  	ret = debuginfo__new(path);
>  	if (!ret && !silent) {
>  		pr_warning("The %s file has no debug information.\n", path);
> -		if (!module || !strtailcmp(path, ".ko"))
> +		if (!module || !str_has_suffix(path, ".ko"))

if (!module || str_has_suffix(path, ".ko"))

strtailcmp(a, b) returns 0 (false) if a is end with b. So above condition
checks @module is NULL (== kernel) or @path is end with ".ko" (== module).

Thank you,

>  			pr_warning("Rebuild with CONFIG_DEBUG_INFO=y, ");
>  		else
>  			pr_warning("Rebuild with -g, ");
> -- 
> 2.30.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
