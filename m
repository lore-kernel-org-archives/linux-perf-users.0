Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80C131E49;
	Wed,  5 Mar 2025 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196797; cv=none; b=kVw62Oc0gy/p5DRrLfeFa0plAXUOwhnheWqpFfdp0rFt5NaASeywxIyBWjNW9IAOsV8BDfU0KD0OCwH4dMUPlp6JWXHNuiOQs/YHw7+o6hRfNUt6ToAVpxGuamBYvqHXixHrCkmqvSK2GxOu92HmUdkxJOKv1Y+tltHSF1CEvBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196797; c=relaxed/simple;
	bh=ncIoxkXodMu0mxIf/x1vpG8KgWmbZa3eefDhmWgJUzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJ0K8oPXwi0CjjXG5RHcfl4enwPF94OVKU5tAPX4o8vTIviDCmyHbDefAZykgk2OMfjzp/LcAwAhbg5k7Guru4Yy54kSiy5P/720Y6YxdAocRvbuh3cgm4bGS3G81yTA50HCvgYKTE5zBtfHrSCilJYI610Pc9c/ZWD7cQwz/tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZL8I3V0e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZL8I3V0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2B9C4CED1;
	Wed,  5 Mar 2025 17:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741196796;
	bh=ncIoxkXodMu0mxIf/x1vpG8KgWmbZa3eefDhmWgJUzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZL8I3V0eLjULvOg4HPhuYDQpBpbmVQKyYtUnZNndSElTjJHkTVGgq321XnnSVGug/
	 eSEBuUyblw4HacqS33gQOsu/I9G6tcw5cQEK5z6+oMWyBXNxpEhd2qPkwEyyzwWpie
	 FIA7e1nOpP5QFmc8vlFDZK3ixbMjW3IxDyc/Q19pimHwnV7LHchJKLIvqPJ8WuCVRh
	 14lvv6JuBBJvB0nho9iXMyYD5ItHw98bKak62Scub5wHRuoXbYgGh9qYx/QkhLowlo
	 acFE4uIQdaUCOM1CXe1NTtBkZa4Nz9iOw1xmsnpj4e8uyE0jFmc+OW/fxk7tySufso
	 yCQQ5QPyzak8w==
Date: Wed, 5 Mar 2025 14:46:33 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/4] perf test: Skip perf trace tests when running as
 non-root
Message-ID: <Z8iN-ayVudqyLlRH@x1>
References: <20250301040252.1586750-1-namhyung@kernel.org>
 <20250301040252.1586750-4-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301040252.1586750-4-namhyung@kernel.org>

On Fri, Feb 28, 2025 at 08:02:51PM -0800, Namhyung Kim wrote:
> +++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> @@ -15,6 +15,7 @@
>  
>  skip_if_no_perf_probe || exit 2
>  skip_if_no_perf_trace || exit 2
> +[ "$(id -u)" == 0 ] || exit 2

Same issue as with the previous patch.

- Arnaldo
