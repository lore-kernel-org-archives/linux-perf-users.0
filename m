Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2784E1A0732
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Jun 2024 23:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719271849; cv=none; b=SVTkcUGK6KmaAQ9Z9heNXitNO9inhW8jeocV5F+wzl/xbaznGLviRALp4nBnoTKY8nnEwM2vYFmnZeQUZoiRTSrBeUgoUKWsbMj16nO2Pa3kKMP9a1almxNzB4uBncBCcAG55VD9h0qAIWwvMC69KnNk3tu/9UmIors+1lpvwg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719271849; c=relaxed/simple;
	bh=f3I56ppX9JD2HnC7ZrgXP5EmxLeJqntX9v/Q2hy2Cvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j71E4Tceehe/BlYm5OcbJq0DMORdk9+ImUr+VtlaxDRER+o07UzPJIdRnuolgIuWO68aEWa2030RLC1vhIbActkRDp1imoC603V5gQ/clPQ0zB3ZswiZrFCr3Z45EitZE9yFWFhR0bvZa6NP6np19YD4wIcXlywFDeuBPJAV9gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3nHwVQ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3nHwVQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB95C2BBFC;
	Mon, 24 Jun 2024 23:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719271848;
	bh=f3I56ppX9JD2HnC7ZrgXP5EmxLeJqntX9v/Q2hy2Cvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3nHwVQ/lQe0IypRaWBnJhe4DONOXNkk7VESKrYRpXopmX9g0C06wDRKyE7tl+hea
	 nPHKGsRWdyCttTM6thYzEHdf8nxq3sAAFbDMvyNP9Zr1Z9vl2iFl6xYid0J+/KSiug
	 shR4knfb/79s3uvD0jleHv6a4NkBaoC+N1kU9vMdfYz6DNLy1kfUI5fGIh2D9c5xSd
	 Zczb7s1YWTWi2m8sIvZlGHdpxakRb+7NDDQyvI3C4n5rSLM/WJWCjNPHbQwDRPJZEe
	 RzGQHrWnZpT8xYiaGhaThKSuPRj1w7Emr+XZsVywvSEHeOJbBk7Qm5OTMEqQtmdZok
	 41nnwzY5L4OyQ==
Date: Mon, 24 Jun 2024 16:30:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
Cc: linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
	james.clark@arm.com
Subject: Re: [PATCH V3 10/10] perf test: Check output of the probe ...
 --funcs command
Message-ID: <ZnoBpxbuZ1shXBR7@google.com>
References: <20240601125946.1741414-1-ChaitanyaS.Prakash@arm.com>
 <20240601125946.1741414-11-ChaitanyaS.Prakash@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240601125946.1741414-11-ChaitanyaS.Prakash@arm.com>

On Sat, Jun 01, 2024 at 06:29:46PM +0530, Chaitanya S Prakash wrote:
> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> 
> Test "perf probe of function from different CU" only checks if the perf
> command has failed and doesn't test the --funcs output. In the issue
> reported in the previous commit, the garbage output of the --funcs
> command was being ignored by the test when it could have been caught.
> 
> The script first makes use of --funcs option with the perf probe command
> to check if the function "foo" exists in the testfile before adding a
> probe to it in the next command. The output of probe...--funcs command
> is redirected to stdout, therefore, add '| grep "foo"' to validate the
> result.

Ok, I think this can be applied separately.

Thanks,
Namhyung

> 
> Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> ---
>  tools/perf/tests/shell/test_uprobe_from_different_cu.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> index 319f36ebb9a4..82bc774a078a 100755
> --- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> +++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> @@ -77,7 +77,7 @@ gcc -g -Og -flto -c ${temp_dir}/testfile-foo.c -o ${temp_dir}/testfile-foo.o
>  gcc -g -Og -c ${temp_dir}/testfile-main.c -o ${temp_dir}/testfile-main.o
>  gcc -g -Og -o ${temp_dir}/testfile ${temp_dir}/testfile-foo.o ${temp_dir}/testfile-main.o
>  
> -perf probe -x ${temp_dir}/testfile --funcs foo
> +perf probe -x ${temp_dir}/testfile --funcs foo | grep "foo"
>  perf probe -x ${temp_dir}/testfile foo
>  
>  cleanup
> -- 
> 2.34.1
> 
