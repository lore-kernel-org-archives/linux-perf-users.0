Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81511168BD;
	Fri,  6 Feb 2026 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770412628; cv=none; b=RnpWY4UiiKZjsBEmAFHwPE4HEW6S2tfouKVkWd9LwTFT2AEGjM0RiEvFpjAfdMQo/K8CraC+CUVasfbqO1xuYTIwavpbEQPod4p2k36Kw/RyWkYz8B/s9eDacmrFtI+GOrYfTkHHp/6wuLKrfdubUj+KglER3p8CZKf/An5eHEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770412628; c=relaxed/simple;
	bh=UDFonzXoxRd3JKhIV7C8fcplRup4ATySi/m1YsLDa30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGZUeV6hW9ZaeMPaaea5avleZU7aT2mHOUCUs1NZLNGL2WcP73dlm4STefTBe5yUlC3n2/jcesDBEvjLmoGo6MvXVNFeUtqYzo+8cIU7u0iOQgChpwocwXj8TA+1CwiX3UnPAEkWq33z1xPE/RjapEqMsuLddB0baSzieZFB1To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkAyRJyX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkAyRJyX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D8CC116C6;
	Fri,  6 Feb 2026 21:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770412628;
	bh=UDFonzXoxRd3JKhIV7C8fcplRup4ATySi/m1YsLDa30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qkAyRJyXkO4KuqNWoIN95k+8Xrk7zuBRfap1lur9vUTOM7MyNk96zxEkUYe+Iv+tC
	 TsT/JCftwEGyd2eCIxPg7uNeIAJVz3/z/SioGY+s7cEy1Weta95r4O2ssw9MmyXl4N
	 6Q6NJWOfAEa75zUYq4JpK7cwsU4S3Z3Cv8KjqH2wqnLgQ3GTPGA8VNUaMyby+bc0Ss
	 047inqXExrCUU3KATsEp3tHcjx2dvmlCyCSelXXcy98lJ7MYwkxnqN3Fxi4pr9XSLz
	 qmiOKi2C2QvWDM+oqcczO0Vp22Vwr5iDRcqXTs1i7Wi4+FQZd4ez0meTijJmM8T6cC
	 Hui+0YaM18oOA==
Date: Fri, 6 Feb 2026 18:17:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org,
	kan.liang@linux.intel.com, yang.lee@linux.alibaba.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf stat: Ensure metrics are displayed even with failed
 events
Message-ID: <aYZaT4eZCGHDMAui@x1>
References: <20260203230733.1474840-1-ctshao@google.com>
 <CAP-5=fXL0Dw5v4VoNJhQ78adCHhvPQLzyjsophXx-j-FXGwuWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXL0Dw5v4VoNJhQ78adCHhvPQLzyjsophXx-j-FXGwuWg@mail.gmail.com>

On Tue, Feb 03, 2026 at 03:41:30PM -0800, Ian Rogers wrote:
> On Tue, Feb 3, 2026 at 3:07 PM Chun-Tse Shao <ctshao@google.com> wrote:

> >   $ ./perf stat -M CPUs_utilized -a --metric-only -j -- sleep 1
> >   {"CPUs  CPUs_utilized" : "none"}

> > Signed-off-by: ctshao@google.com
 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
