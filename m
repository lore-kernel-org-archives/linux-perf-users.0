Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062A61FC0F9;
	Tue, 14 Jan 2025 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736878609; cv=none; b=fv3zSIKJq/G3WYL29hR7caSrrjWqNRVuJu5npUQqPYTAHSUqSJo0A+3O5Oz1Pln4ogsQFI90AyI78zKfMtQ+KIbnDP7mRL24MZr7b8tKyAlhwAV991Nn/49cjPEwNG8k8jBluZt6yx3R8W884CaEaURLQDqboXpikt2VwTN098E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736878609; c=relaxed/simple;
	bh=2d5mcBQYIOKIiLZ2FTmRSbI9dj5YDJwkn5dj1EWX2f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx4gaG3YXdkD2+qGELGVUX7Huahz8H5YibT7Pt9iYstU+3bvi0geFY9z5knEK3jMlvaIUHjFF4j3U+hNGotLqP+mvbJmn5ImbhlvjYcCODJz4BV/jrw9YsvEvEsulsYaCwRw9M/8YA/yQeMaAgF+ULol+vUdl1gbqM1MXn/qLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhgNlZfw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhgNlZfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86A2C4CEDD;
	Tue, 14 Jan 2025 18:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736878608;
	bh=2d5mcBQYIOKIiLZ2FTmRSbI9dj5YDJwkn5dj1EWX2f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GhgNlZfw4Ce7O+fcLuo+j3/hMsATMBGQG0B8ac+1yJyNLxCLYiPRVSfemE5uoGX19
	 DkSHz3GwOAE3TYz2UaSE1p+UQiPiEC6SSix+7emekPDkwSxyjIVTSDZnRSK6BKjGgq
	 N+R9bzYABf7Ehe4FErpKWcwA+4fokwR11p9eHV6JCIJOaqa7qz6Wr5rrepODTphIcH
	 In9I7RC1Qv4Xbu2u+xb+X6HEbW/gXZIjG6M9o2dlIu+mV0vXYun0GMsfjrPt3QrwVo
	 NULVQmQqs6Ui//FralTq8sBPLuuNkH1orzvnyzrcBfI6sVZx2zI4NEklfJxkiPtpH4
	 h3sNL9MX7uc1w==
Date: Tue, 14 Jan 2025 15:16:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, irogers@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	eranian@google.com, Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] perf report: Add wall-clock and parallelism profiling
Message-ID: <Z4aqDUwCeStTTguE@x1>
References: <CACT4Y+b4WYa9TSqKtDKTJNgXth1U30=KddutfSdp5gmXVOV_jA@mail.gmail.com>
 <20250113134022.2545894-1-dvyukov@google.com>
 <Z4XDJyvjiie3howF@google.com>
 <CACT4Y+b96xynNaZoBHP72-4tJM5Nzo3MBRW19_E7JsMKRWYCzg@mail.gmail.com>
 <Z4aJSde5KXO-rqWM@x1>
 <CACT4Y+b6nbqNHt1MwT_KfWjNrMA_1qvMD=Gkk9gfZNXLL79xdQ@mail.gmail.com>
 <Z4akewi7UPXpagce@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4akewi7UPXpagce@x1>

On Tue, Jan 14, 2025 at 02:53:03PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Jan 14, 2025 at 05:07:14PM +0100, Dmitry Vyukov wrote:
> > I agree it would be nice to have these usability improvements.
 
> Right, and I'm not talking about those as a requirement for your patch
> to get accepted.
 
> > But this is also a large change, so I would prefer to merge the basic
> > functionality, and then we can do some improvements on top. This is
> > also the first time I am touching perf code, there are too many new
> > things to learn for me.
 
> I'm happy you made the effort and will try to help you as much as I can.
 
> I agree that, with the patch below, that I'll try to split and merge
> before travelling, we'll have a good starting point.
> 
> Here is the patch, I'll split the perf_config__set_variable into a
> separate patch and merge, so that you can continue from there. The
> "<LONGER EXPLANATION>" part should tell the user that 'perf config
> report.workload=yes|no' can be done later, to switch the mode, if one
> doesn't want to continue with it as default.

Its now in the tmp.perf-tools-next branch at:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

I'm testing it together with a batch of patches one of which I had to
bisect and remove, soon will be in the main perf-tools-next branch.

I mean this patch:

"perf config: Add a function to set one variable in .perfconfig"
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/?h=tmp.perf-tools-next

Thanks,

- Arnaldo
