Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB864EDCD6;
	Mon, 28 Sep 2026 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613106; cv=none; b=oTQq16Bvu6/NXF84G3rodS/pm6pij0LfdnTv8Bw1y16AmVychBwlPFOcXDsk+luIv8TCqkIYwy9KTb9qvxPcj7ksaNcbKUh0Q2/cKRMpH5QoH8cjgDsKIpNKuHJ1d7lhKZ7R/PfBNt1f2g5stijyPV/DpaicH+vMy7zxWYiljPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613106; c=relaxed/simple;
	bh=c541e+Yf/1TkzNRiiS1DegAycr4yZV+4QccWpKXqm8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4HklI5uMtCyySb/MYspRWXdsewR9Tz+GdqrXvgHBOAoNQNw7eJI3u28Qg+yXv9Q0R/8HO56cU9fg8IkYt9MsCHWx1nTtqqygx/RGjy1nRUiipWpq0zkiQBun8iqiaeB477xRuyvTg/RrKIQzvX93uIcoc3WbbWIWfM1zkqJjSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggGsrxCJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggGsrxCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BEA1F000FF;
	Mon, 28 Sep 2026 16:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613105;
	bh=5GpRpNe92QpGRvNBfRb9js65IBscjYzBPJDtk432NWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ggGsrxCJcCVfBhbDDe5wweiFa11dtdqZONL6hGceidJWjnTSl2SPFmGZXWpQDsw8f
	 JwstrbRF5NyKr0IYJUTBIsjQ0umloPXgXRxrPnf41ADGTGCsHjwxcC2EtGuzjMlqh7
	 BwZsjwGPT3Mi2rqSC+HiM63nVW4T7U6PW2dwo8mg4nq/52QTpy8KmrdbE1HEm9A5B4
	 IwdWgpCTeYsGUFwuOeW2VWQy6sxN8djuyRVuAvaRyNp2nt3ZTXjb4GS+1fE0lRr3y3
	 8mhRVYR2hewuRIRh4ohElTixJUKVTzAkUBflv1MZHyePic0en8YBJEHP98Lyxtfoof
	 KizmyksIBKuOQ==
Date: Mon, 28 Sep 2026 18:31:42 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: John Garry <john.garry@linux.dev>, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, will@kernel.org,
	james.clark@linaro.org, mike.leach@arm.com, leo.yan@linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update John Garry's address for from arm64
 perf tools
Message-ID: <arqWbrUcrkQnHEjy@x2>
References: <20260928151652.66499-1-john.garry@linux.dev>
 <20260928162436.GF14479@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928162436.GF14479@e132581.arm.com>

On Mon, Sep 28, 2026 at 05:24:36PM +0100, Leo Yan wrote:
> On Mon, Sep 28, 2026 at 04:16:52PM +0100, John Garry wrote:
> > My employer e-mail address will stop working soon and I am likely to get
> > more involved in this area in future, so update my address.
> > 
> > Signed-off-by: John Garry <john.garry@linux.dev>
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
