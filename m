Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F877581258;
	Wed,  9 Sep 2026 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966245; cv=none; b=Su8Y3k2aNZVf52tLFiBddSThEGvpT0mJgJEVeyGmqqptBvVCXswgr/yR+Ui9g5PuZUE7XQehvA7tM+tODeZarPePcsN8GjkdI014H/4IwYmTFbBsbO2EhukHakl51bHseVP/bAePFdCFS5A9NcRDL04El5ib9/0tVOE10h0BFnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966245; c=relaxed/simple;
	bh=5dSed8Hp3dj7E78JrPEkrYlg7azppnBTpJuYwyIb+fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dw7iw5VF4aORn2WAAntEassLKbOLE3NwSZdza2KAz3PkV53WeSLxEyDPmuU4E3zyo1cLgmeM8joPot4cab3Jd5MjOMMCCSpwKZb3fumfG7EY1luUq4eaE6PTjO03nXn4Ndhc/Nl62Ypu1174bXtTU8HDXh6+hQW8uXR5b/KHPeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckOeTEex; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckOeTEex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1333D1F00A3E;
	Wed,  9 Sep 2026 15:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966244;
	bh=a1nXGt3sUE4iIFwdKhFlwdKZaXGx+rt3d+o/xi7xrPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ckOeTEexCbb4GHllWvfYmApqLe/8ETS4aXzbBXiRzmRp+ihzaBG69xORKQYFxjx6t
	 gmurL2MvJcHOai1UQdy9c+usupKTE/kA4cfVtJiobxhrcnLzGZQccnp2IKXRncC6Ku
	 xlZvxdRUtwk+lBzdVUjQlBSmEV/3ubljarR+Ah68jyyb3dBw2olbpLgENkGBh3sQU9
	 AX4vPfN8WCCwlvHSmv3Ke67IPHcE2xQXxu+I9pQOD8a+T1qqYkk0/N4kwNAZg+ZNE2
	 7OT5/uyxPon/v26GB0ryqZo+GWQ/tv1BiZqPHq/H0ZpelzAnfwkTB8QE0UkQ2QyHsu
	 zmyKENOKHBuQA==
Date: Wed, 9 Sep 2026 11:04:01 -0400
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: james.clark@linaro.org, xueshuai@linux.alibaba.com,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v5 08/26] perf annotate: Adapt arch__dwarf_regnum() for
 arm64
Message-ID: <aqF1YbtYmVV3YNAO@google.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <723d0c1e1261cb5b38af7ed4fda9d26ae2986319.1788872630.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <723d0c1e1261cb5b38af7ed4fda9d26ae2986319.1788872630.git.wutengda@huaweicloud.com>

On Tue, Sep 08, 2026 at 01:05:11PM +0000, Tengda Wu wrote:
> Currently, arch__dwarf_regnum() assumes that all architectures use a
> register prefix character (e.g., '%' for x86) defined by
> arch->objdump.register_char, and uses it to match register names in
> objdump output. However, this assumption does not hold for arm64,
> where assembly syntax uses bare register names like 'x0', 'w1'
> without any prefix.
> 
> As a result, arm64 builds may fail to correctly recognize register
> names from objdump disassembly, leading to incomplete or incorrect
> annotation output.
> 
> To address this:
> 
> - Make the register prefix check optional, allowing architectures
>   without a prefix character to be parsed correctly.
> 
> - Extend the delimiter set in strpbrk() to include the closing square
>   bracket ']'. In arm64 assembly, memory operands often use bracketed
>   syntax such as '[x1, #16]' or '[x2]'. Adding ']' ensures clean
>   extraction of register names like 'x2' without trailing characters.
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/util/annotate.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index a3d48cf88dad..710a67980cea 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2474,19 +2474,21 @@ int annotate_check_args(void)
>  
>  int arch__dwarf_regnum(const struct arch *arch, const char *str)
>  {
> -	const char *p;
> +	const char *p = str;
>  	char *regname, *q;
>  	int reg;
>  
> -	p = strchr(str, arch->objdump.register_char);
> -	if (p == NULL)
> -		return -1;
> +	if (arch->objdump.register_char) {
> +		p = strchr(str, arch->objdump.register_char);
> +		if (p == NULL)
> +			return -1;
> +	}
>  
>  	regname = strdup(p);
>  	if (regname == NULL)
>  		return -1;
>  
> -	q = strpbrk(regname, ",) ");
> +	q = strpbrk(regname, ",)] ");
>  	if (q)
>  		*q = '\0';
>  
> -- 
> 2.34.1
> 
