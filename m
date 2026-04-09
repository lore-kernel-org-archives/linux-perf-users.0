Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B0217745;
	Thu,  9 Apr 2026 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775753178; cv=none; b=RCIYIAyDDCcX0qdXMS7QhRR+DZvNptVWevrA9q1FHuj7sTmvonwf+WJh2k1pSkfaX96xCQ5m8vi6d9msTm3Lw2y3Rav90IjnbgSXTXaftKu063goPcW1/yCmDXc8ig0yQMyMWHGwvUGBkslt+XOcmhW1Tk6dqF+BDBfMjbRI/ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775753178; c=relaxed/simple;
	bh=J3bkg1zB4K03704EWFtfXfsMQ43ZySTCSqAxkHYSgrA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TgueOrb65UmAQNqmFzbytQNsN2kuZgwIEUPXW9SMPLJzR48fFZwpRDT5ytXQrhTchrntmT0BO7tM/DZaNs+K5a++0VXZ65fI+pATsel7OAPgcAtjD3yur6GKuytwaCh89dciy1KuW6kZGDWXnWBBd2spX8tWOVg9roP7cn2Lzv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFAxk8s0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFAxk8s0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42ECC4CEF7;
	Thu,  9 Apr 2026 16:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775753178;
	bh=J3bkg1zB4K03704EWFtfXfsMQ43ZySTCSqAxkHYSgrA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eFAxk8s0UbuSI2bMWTni+gbRMdcA0iorUgXlUAH3QZrn9/sC2mosUQIszQ8b1P+NL
	 EH1k09O5k2zpoF3l3yExVlUo3rttIJkqaw9e0YUIfR+xazHzGdBhB0VhbuiAN9ho5G
	 +5Cn9Tpe60XExtw+S1EESJg9LIkDwJ+tGXW4uEEGih2YHDUGoguTscCQ6bWegTDlKm
	 Uv0z6rZhXwFSmDMfpCiCB/sQclhyarat6ZKrdztKssQ2miKj7F46lsL4/o6kX+a0zS
	 LIUdLmIFnpW5Lg6I+3Aju09jV0r2z5gabkJZFfg9663xQ6va2NjqPbVfUjg5tdLDpB
	 M7PbLQEgCDPWA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, James Clark <james.clark@linaro.org>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Thomas Gleixner <tglx@kernel.org>
In-Reply-To: <20260408173203.96700-1-acme@kernel.org>
References: <20260408173203.96700-1-acme@kernel.org>
Subject: Re: [PATCHES perf-tools-next v6 0/8] Cleanups and fixes
Message-Id: <177575317786.128404.4163210567225047558.b4-ty@kernel.org>
Date: Thu, 09 Apr 2026 09:46:17 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 08 Apr 2026 14:31:55 -0300, Arnaldo Carvalho de Melo wrote:
>         Here are some cleanups, a refresh for a patch Ian sent and fell
> thru the cracks, using calloc where applicable, constify some arrays and
> add a missing header that was making the build fail on some musl
> systems.
> 
> 	This also adds checks for perf.data headers that were suggested
> by sashiko.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


