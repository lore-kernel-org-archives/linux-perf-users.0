Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5701BA882;
	Wed, 11 Sep 2024 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069725; cv=none; b=BP1fNgW35U0Wn+rtJ1PvyrEUXUe/f4LnIfFS1tASKaEUT/4JU1bZHI8RBFDiFEIgKuVOgWiAG2HCd5Nb+44zFK+R9PlS1v4TfRJZPNTd3SaemhehvHFMowi3Yh/MqtBExeXq53L4LUgrERgwoAlZwXdizrmmMbmALKYk3HWibT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069725; c=relaxed/simple;
	bh=uKOBO3/ZEvAfJ8xxHMEtIC+7uc2GWc7wTO6wZWMjJwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1309bUVCQbunyeBbrcodGfoK5osdLC9tvRfw0r3u3hW+DrpSe5wT1VJkUDk6BJokUigEL2SBGsoknSbCrA+XAG0G9HIqlkOXzMdqFirgqzhg3XI3BP/rDY2PKQPyUJSDx/ohBEQUnHysLM17Jt2G0mkOGMTNcUmZGx+KVIqR2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx7ylrO7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx7ylrO7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D4CC4CEC5;
	Wed, 11 Sep 2024 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726069724;
	bh=uKOBO3/ZEvAfJ8xxHMEtIC+7uc2GWc7wTO6wZWMjJwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jx7ylrO7GicKxEMBRKdsbV9GwJdEsgS1Yzv+NfWMmJFjAgaOT+NelR4YTO29UEW0y
	 maGyviVKZiZ0fiPBEvrrijPPYBkI3JU4tIeGpVhCkaQ3BLxNRsvpOwrN5c3cr0FvzE
	 5iN8P27396QSAZSJrke2llN2zG+mlywiaSyomDYnHqleowoPdKeiw3ZMEu7luGKVnA
	 pD3vGOAMmBSrYOWAuPGsKjG+o5kD6PmT78DVNjQBJeigkzAiUvU8an9MtXWGBXz0OJ
	 yFirHTwnJhFD5pTb5HUUy/BNRkQ4NGYuGL0H3qOuroHvVc8NaBhL+zXm/DEg9k5/Hs
	 Lzcc9fnBIfOeg==
Date: Wed, 11 Sep 2024 12:48:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Sam James <sam@gentoo.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] tools: drop nonsensical -O6
Message-ID: <ZuG72Y_7XRkedEBz@x1>
References: <4f01524fa4ea91c7146a41e26ceaf9dae4c127e4.1725821201.git.sam@gentoo.org>
 <Zt9zoVFkFaCDwJ36@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zt9zoVFkFaCDwJ36@google.com>

On Mon, Sep 09, 2024 at 03:16:01PM -0700, Namhyung Kim wrote:
> Hello,
> 
> On Sun, Sep 08, 2024 at 07:46:41PM +0100, Sam James wrote:
> > -O6 is very much not-a-thing. Really, this should've been dropped
> > entirely in 49b3cd306e60b9d889c775cb2ebb709f80dd8ae9 instead of just
> > passing it for not-Clang.
> > 
> > Just collapse it down to -O3, instead of "-O6 unless Clang, in which case
> > -O3".
> > 
> > GCC interprets > -O3 as -O3. It doesn't even interpret > -O3 as -Ofast,
> > which is a good thing, given -Ofast has specific (non-)requirements for
> > code built using it. So, this does nothing except look a bit daft.
> > 
> > Remove the silliness and also save a few lines in the Makefiles accordingly.
> > 
> > Signed-off-by: Sam James <sam@gentoo.org>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next,

- Arnaldo
