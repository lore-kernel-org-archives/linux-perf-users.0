Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086C11758F;
	Mon,  9 Sep 2024 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725900150; cv=none; b=hmIPgwN167aQV+k9hUTvBH9RHZ4zV5FdEnSqd6RFQX0dTz0XtivQQZWnJQhqdNLsg6apQ6v/1miKRHNd3v/MT7oN0e+2M4PsnEN2RB+jjKWPBiR5+8wx9aVIH+wI1shekofumGNnBJWbl5r0o3okaBjed3LhXXa0cCWdGaoxU8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725900150; c=relaxed/simple;
	bh=maq2QnAMsZRxAKmpijk2E+RUELu2pWF3zVrXvWIPaJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiI0Fxwhq6g04djbY7MHK5NRZsUX3usxXvMQBsaORVCerbDRGMFg1u4Uc7skZdYunCtGCcM1p4RpsfbjVkYRZvteMVCqHlcLpyfIYVXtdiaORIg5mhaeVmM4dgSwOcv6wTm+Wi62dtCHHMLe/a/CGSdRe/C2W64TyPUiJv177G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/+592J3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/+592J3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE28C4CEC8;
	Mon,  9 Sep 2024 16:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725900149;
	bh=maq2QnAMsZRxAKmpijk2E+RUELu2pWF3zVrXvWIPaJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/+592J3FF7YgKMVGLuZcx64FCzMbWb372ccHEykHdC7MuTyYxs6Fr96lH99RAIrS
	 l+KaOHM5v0BR1gdi7GKoJFVcifHeTJfafVLMbtVXLA9oqF186lfj4C2Ra0hO8GJ1ZZ
	 dx7ZT8avQqX8BeOxPtvTBlsSKL/nRcKZI4tHTuCpD8zoneBR7Oh+R0h3Lonj2jjWTG
	 zPbUsrvxwyrbA7YjaftfKsNfarbaVw4auznmun0h+xjT0UesHm4E/K6uxVKQwMmg+w
	 wpvaX1gWxuUI54agwVMs8P7855u7p80vTX5vLWxR7DlT7gg5Z/uaUizBKDSNcO61lm
	 kzqrteFXhpnYQ==
Date: Mon, 9 Sep 2024 13:42:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v9 1/3] perf report: Support LLVM for addr2line()
Message-ID: <Zt8lclBTUpZcxQqP@x1>
References: <20240719150051.520317-1-sesse@google.com>
 <ZqlCIJ4khe2_xyp9@x1>
 <ZqlDuIj_nMVXhYou@x1>
 <ZtRIla5pCqlMIKvN@google.com>
 <Ztbga0xLyt1eaehi@x1>
 <ZtcWwANOWyXEnGdC@x1>
 <ZtcaC5WOTj-fh_Px@x1>
 <Zt3yemuoUCXTaClB@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt3yemuoUCXTaClB@google.com>

On Sun, Sep 08, 2024 at 08:52:42PM +0200, Steinar H. Gunderson wrote:
> On Tue, Sep 03, 2024 at 11:15:39AM -0300, Arnaldo Carvalho de Melo wrote:
> > Or, as I'll do with debian:11, just remove llvm-dev and not build the
> > features it enables:
> 
> Thanks for looking into this! Is there anything I should be doing,
> or are the patches you posted earlier sufficient?

Everything was merged already, I was just mentioning that we don't
support building with llvm-dev in debian:11 and a few other distros
where the version is old and doesn't match what is being used in perf.

- Arnaldo
