Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC8C17E4;
	Tue, 25 Feb 2025 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740443424; cv=none; b=SGWsKX/415aKRSVkf20ZMMc54vt7o/38PhqbEvB1VUOAK+vV+FyX+BqmXFFbsgWEe02GlTTqmP065JVCG6ZU09xmDiPz1r+rV0Bqyod1WJfoDHBu2GHXB49CIT0thXkHqH8U+sbUpHgRNa2ZySiNgw6FYC/V5nNQWuLFrNZCt0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740443424; c=relaxed/simple;
	bh=itZH+jH8pSJiA/RWvW3YnpXIOMmQaCiY+tjCxB6404w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQ3schKw/QIfASTErLzO/7fgR9r4PV0KRIiq0VNmJyx+BH0KwZv4+zfl4Ic4ICje6qYjRCxaJrH2yZZxomF9sz1a7Wgul0R5H1kJIMkm/lFcZR1vC66Nx89slWBA2MSUdbQSaIPVX2OvvloAkodMcY2R4C6J50RM7PFvraggcHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mtma5RMc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mtma5RMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C264C4CED6;
	Tue, 25 Feb 2025 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740443424;
	bh=itZH+jH8pSJiA/RWvW3YnpXIOMmQaCiY+tjCxB6404w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mtma5RMckuICRLFObJSRLR1oi94C1CeRFm/rGaRXGBgCG5cFh4oCXzppEnDzGfMFT
	 u0LGg98KnWQ/1KmLGp3Js5TLFukzYELTDmddK0i5a/7EjlqhNZA6PM9RuPRLurqo6E
	 sntvPNI1xRbGoqIGb2f8gzRLFG1LAj6TKT76nfu78olbab2nuXC2OR13CaCKtUJSi9
	 Y/3vXzntFoRju1VWVGCbQaGGD6SSSLqza5cM+oDlDEJtbmGW5DfJlfTgTVFwXbqmOD
	 a8FLUhOcLllnVJc1Adv2XSYUXczW4b+XdtY/sBoda9cPKql0Bj8w4XPd/XrfXhdcs1
	 QeOh1BOAZb2TQ==
Date: Mon, 24 Feb 2025 16:30:22 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Sam James <sam@gentoo.org>,
	Jesper Juhl <jesperjuhl76@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Anne Macedo <retpolanne@posteo.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Junhao He <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>
Subject: Re: [PATCH v3 0/8] Add io_dir to avoid memory overhead from opendir
Message-ID: <Z70PHtvzjHDLx42A@google.com>
References: <20250222061015.303622-1-irogers@google.com>
 <Z70OqFzD2JcbhFtL@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z70OqFzD2JcbhFtL@google.com>

On Mon, Feb 24, 2025 at 04:28:24PM -0800, Namhyung Kim wrote:
> Hi Ian,
> 
> On Fri, Feb 21, 2025 at 10:10:05PM -0800, Ian Rogers wrote:
> > glibc's opendir allocates a minimum of 32kb, when called recursively
> > for a directory tree the memory consumption can add up - nearly 300kb
> > during perf start-up when processing modules. Add a stack allocated
> > variant of readdir sized a little more than 1kb
> 
> It's still small and hard to verify.  I've run the following command
> before and after the change but didn't see a difference.
> 
>   $ sudo time -f %Mk ./perf record -a true
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 1.757 MB perf.data (563 samples) ]
>   74724k
> 
> According to man time(1), %M is for max RSS.

But anyway, it looks ok and build is fine now.

Thanks,
Namhyung

