Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EAE1CEAA3;
	Fri, 15 Aug 2025 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755289346; cv=none; b=SycuvB1UXiH0ESVobskyd/ihjXfo7K386Cn/kNEX/iLc0jYnwKWhNDb3+UHguk8V1f2fBKs7jf9B0jU2IhsFWKfNFoRq6CRJ3fyGu3DIpcInHdKK7t/i6XFYfey9euscxvZKw/l6oYi/ruTwd1i6N8AfMIRcnUGZs7Up6sOWG+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755289346; c=relaxed/simple;
	bh=kW0MEEMIOxa8+y3fvwfvvdW7qGi9x70Eq8rfgsDJPxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAm3lu8jJDxk/IfIyay81DelcmsBKgDZSSyGib6/Y9r1Ufph5qfRUtEXoxQYXMS8jUIG2duigvge1RROd2A6yqYIZE4+UvE8PdKgBX2gZ//NbYMBbF70NyTRh3EHNuvzRpXM0TPBL4mPL8g3urObl0Baw9s2cWkIEEMMHug7nWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LE6zItmM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LE6zItmM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54E6C4CEEB;
	Fri, 15 Aug 2025 20:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755289346;
	bh=kW0MEEMIOxa8+y3fvwfvvdW7qGi9x70Eq8rfgsDJPxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LE6zItmMUAsZqhNPLhw5Knjiv9oJcrS1OqZ0ejn/34eegORPXmAdXkzJ/u5nkvB+H
	 QSlklfOVV2E/g1fkxfZHJfmYGlZHy7s4PdcdigYK0TwTH4H2BD1Vk0rxTSF4Q1U7fa
	 jmvTvfm8Qjl4hhfYJiIHjiyaqoLoDYtydjBKoKSB7M5fdhgSGqRNuyvf1XSKByqDuV
	 b3f4t3AeEzqAFrcf8kKQZ0X6NACWNvyqZ2DZPgUEQ1mltQbxR0ndUHx45qAZPyJ2w4
	 HIMiOCQ1BPiDLlxu3AUlZsGUD8CdXi+Glxh+B8EdaRE7IMESRR8PBKdB3qozqnHGRv
	 cPYpQshOg+83A==
Date: Fri, 15 Aug 2025 13:22:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>
Subject: Re: [PATCH] perf build: Allow using compiler wrappers with CLANG
Message-ID: <aJ-XAEGNnecMKgj9@google.com>
References: <20250805121143.1224807-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250805121143.1224807-1-iii@linux.ibm.com>

On Tue, Aug 05, 2025 at 02:09:34PM +0200, Ilya Leoshkevich wrote:
> It is useful to specify CLANG="ccache clang" in order to speed up
> builds. Unfortunately perf's compiler detection logic does not like
> this:
> 
>     Makefile.config:704: Warning: Disabled BPF skeletons as clang (ccache clang) is missing
> 
> We don't need to know the full path to $(CLANG), so using
> get-executable is not necessary. Fix by trying to run
> `$(CLANG) --version` instead.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/perf/Makefile.config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 5a5832ee7b53..4bc11db5aa4d 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -700,7 +700,7 @@ ifeq ($(BUILD_BPF_SKEL),1)
>    else ifeq ($(filter -DHAVE_LIBBPF_SUPPORT, $(CFLAGS)),)
>      $(warning Warning: Disabled BPF skeletons as libbpf is required)
>      BUILD_BPF_SKEL := 0
> -  else ifeq ($(call get-executable,$(CLANG)),)
> +  else ifneq ($(shell $(CLANG) --version >/dev/null 2>&1; echo $$?),0)
>      $(warning Warning: Disabled BPF skeletons as clang ($(CLANG)) is missing)
>      BUILD_BPF_SKEL := 0
>    else
> -- 
> 2.50.1
> 
