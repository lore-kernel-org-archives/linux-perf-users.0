Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E282279DA8;
	Thu,  4 Sep 2025 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757020771; cv=none; b=cS5/ir2O4aztQKHQn4n1gT9IfGgsD9l2e3gx3tgesyLc6qafeLToOgV0Zwn/k8OUuK9PZe8srJEBBQ/mBg3SnqfqUmVbD3zAVfqd3ffxdqrbV5gM2+2bb7EyCeWM5UAiFnv5Ebue9Q37Qoezc+mPQL/m0B3gCD1/vGhIB+bRS+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757020771; c=relaxed/simple;
	bh=GC/A3A6Y/v/hxD5uAlzHBWvzqoFel1f6OwGSvndxo4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBUCLVidPK7lRrT7t2oul90gB/DInfcJ8waBpZWB1keLJvJoGbh/f4JXFTKe+pP53h4D3rtTYGYd96iOo+UjgS3+2RHe546kHz4qPP7m54h1awwvkvD/Gc04nS+IWTPkxpNPsw7b4FMBAl2J7waVklDZwayawON21O71/JDNLJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMMGvqnI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMMGvqnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D989C4CEF0;
	Thu,  4 Sep 2025 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757020771;
	bh=GC/A3A6Y/v/hxD5uAlzHBWvzqoFel1f6OwGSvndxo4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gMMGvqnIqjexs+oaj6h/+bNsDAl1MQ4U4l87TbZZJnMQTb8FgbO00zqZAXzITn5vU
	 x1qzUDjBN15/bEXcQChZda8gMwF+i9uxllo8faYykqMVa8CY17Zqd4Xj0EoUaPokff
	 rb52xiQRZkD++dcNuVTgFH+LNzWrWjKmdXt4G2+y1ffT/qkZNyHEWw8QyBs7jfVMYm
	 uDutEzU9sowQwqukQg9GjkjrwJAHk6rtU5bhtlKqBc38S9dDKvuPd7FhG3mOnoo13U
	 1cap99BbuLnKQLh7TyiBYoW/03YBr4cGPd3aVwhir/iQ+J/7YxhsH9yOeUZKsXDhm2
	 QM1lCSCl/qkwg==
Date: Thu, 4 Sep 2025 18:19:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-actions@lists.infradead.org
Subject: Re: [PATCH v2 00/20] Intel TMA 5.1 metrics and event updates
Message-ID: <aLoCX-hWbTWIGchB@x1>
References: <20250818190416.145274-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818190416.145274-1-irogers@google.com>

On Mon, Aug 18, 2025 at 12:03:56PM -0700, Ian Rogers wrote:
> Update events from:
> v1.31 -> v1.33 for alderlake
> v1.09 -> v1.12 for arrowlake
> v1.14 -> v1.16 for emeraldrapids
> v1.10 -> v1.12 for graniterpaids
> v1.14 -> v1.17 for lunarlake
> v1.14 -> v1.16 for meteorlake
> v1.28 -> v1.30 for sapphirerapids
 
> Update TMA 5.0 to 5.1 removing the slots event workaround as the patch series:
> https://lore.kernel.org/lkml/20250719030517.1990983-1-irogers@google.com/
> is assumed.

Thanks, applied to perf-tools-next,

- Arnaldo
