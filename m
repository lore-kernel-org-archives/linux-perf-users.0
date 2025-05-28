Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05412857E9;
	Wed, 28 May 2025 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748436736; cv=none; b=LL5zw5cjgNOf59suxe/vpVq+y98vza1BVAGSjjN9EIX2NlrAm4UCjMP7hZZV4DvEwwjOviYAzeUCPNQABmvnOnRt0K01Uhw30dwz3qDt/8eFGUlKPJIEtuTJNR/S0DuDwA/FaHPQlaZamWD+bWFKlXSzok34I2Fksx922lcJ24I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748436736; c=relaxed/simple;
	bh=/7nc0zNXso/vg7/WocILzt8NiGgJZkpeuyv+TmpJgmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eaAlSwqh0NL3K7ivSGxoxZTndwmkGS3uJICKoO6RSXvaEM2b66Q2yupC6TbqfBx1oqj5K/9uEQo7uYHpsiD+YOGnfJV2DkIiA03/Y5gFO/+BXL7WPDfDGwvm1dGXGk2COLoOKF/7QrPCyADC8uy8fktv0wEgMWRHTIkHAZCZcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1iu/fi+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1iu/fi+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944AEC4CEE7;
	Wed, 28 May 2025 12:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748436736;
	bh=/7nc0zNXso/vg7/WocILzt8NiGgJZkpeuyv+TmpJgmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E1iu/fi+ZFkGZjfL8K7ror9VBvwW9RNtuulNJQ50cw/e7tyReflVdoIDmOdQpzMoT
	 YPalzoxFULCr8pdfE9n+3ZDH8jwmcyBNBkiwW3FJBfW5rhYevsvsjcnBHRrC7OAWSW
	 Aisw7u/ikdFnFXkr7nExR7Cky5hfpIx23femLnWRPkWlXNV/PoeQvMCuuur6vL5kJr
	 oXP/+NsEhML2WUFvNizTUh5+QDPCyL4I4HX6aO/bqPc0W98ocn7vbnU51013lny7jC
	 BHEsQCBZFuj3+pjpIxGOXIH/oAXHLGWqd3CNNOVlbZXi/Xa8XWaI4zGXFtNgZMw/Md
	 15aTSUjk1g5Jg==
Date: Wed, 28 May 2025 09:52:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	James Clark <james.clark@linaro.org>,
	Howard Chu <howardchu95@gmail.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/6] perf test intel-pt: Skip jitdump test if no libelf
Message-ID: <aDcG_RVzA4d5FY2R@x1>
References: <20250527180703.129336-1-irogers@google.com>
 <20250527180703.129336-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527180703.129336-6-irogers@google.com>

On Tue, May 27, 2025 at 11:07:02AM -0700, Ian Rogers wrote:
> jitdump support is only present if building with libelf. Skip the
> intel-pt jitdump test if perf isn't compiled with libelf support.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/test_intel_pt.sh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
> index f3a9a040bacc..32a9b8dcb200 100755
> --- a/tools/perf/tests/shell/test_intel_pt.sh
> +++ b/tools/perf/tests/shell/test_intel_pt.sh
> @@ -288,6 +288,11 @@ test_jitdump()
>  	jitdump_incl_dir="${script_dir}/../../util"
>  	jitdump_h="${jitdump_incl_dir}/jitdump.h"
>  
> +        if ! perf check feature -q libelf ; then
> +		echo "SKIP: libelf is needed for jitdump"
> +		return 2
> +	fi
> +
>  	if [ ! -e "${jitdump_h}" ] ; then
>  		echo "SKIP: Include file jitdump.h not found"
>  		return 2
> -- 
> 2.49.0.1204.g71687c7c1d-goog
