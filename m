Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41F033AD9B
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863599; cv=none; b=Ctk/T1SqgG7Z6TQnR2EWAWSEZgpsolIb1Lv6oS8zGBExqhNGLX+lspCTjF4MFzZIVOElpDLfwm2KmMKOMlPDZkElkPgF8pBnaRYizccaVBSGP/S3QBjzu99FB853hrjKoY14+pb5pXQZMzCp6eE0qd0zt5cWdVBx7qqm99JzsYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863599; c=relaxed/simple;
	bh=jbeigyJgmdJ95WdVS6ujhvxIW1iecOiddKzhK8+8/ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irbe+xxrj33FuSvAkp51FhjItf/AuODUiszy7ljI3ZK+sXMeqDyKuBZpQsD/EJpLaOgIJbA/Wd1vVI2Yddh3Ft/mlcHR+Aymi22kIk7MwagEV9+ML4OwcGPCcKPKtn3YwrpteHQYCDCn+ldObaaUCxIuOhDMZHvQ8812Nr9zJZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtvzx3QE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtvzx3QE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020CA1F00A3A;
	Tue, 30 Jun 2026 23:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782863598;
	bh=nJ0p6I+XWHcdzHTYTdQzvWsk4iQLdC8UOrlgSr+ISxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dtvzx3QEU3ga8Y4lGN+M7dTdEmQb6G8/Q3lne1hP0DJGrfAU7xuLN+qJzipWdZAVj
	 hpMtH1jeyPl4weso8VHVj83ZoXZJhYNM/j7Xd+wuLV2gvl8kk196+KcswRvERDxgd8
	 iYE1VkU/Ztb41Fhr8g3ULbagZQB+xIxkGs+nGLWfhZw/4XMCtyurTHUPJlj609tJf2
	 pFp0YCf4+NGQbvEDGBwz6xCr6O2KYMLudXshInXtc7SG4eaKYHO1zJUOQ7L651L24L
	 0jyoUMdd+COm1eBzU2nIt+cR9y8oe2SAzABneusKrQTndTJaNdsKi/q4RvItGEwXVQ
	 oqYuSYVLkFTTw==
Date: Tue, 30 Jun 2026 16:53:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Al Grant <al.grant@arm.com>,
	Paschalis Mpeis <paschalis.mpeis@arm.com>,
	Amir Ayupov <aaupov@fb.com>, linux-arm-kernel@lists.infradead.org,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	Leo Yan <leo.yan@linux.dev>
Subject: Re: [PATCH v10 0/9] perf cs-etm: Support thread stack and callchain
Message-ID: <akRW7P-4UyfXz5GB@google.com>
References: <20260617-b4-arm_cs_callchain_support_v1-v10-0-e8b6e5d63db5@arm.com>
 <akMPoLNBbAEyNU64@google.com>
 <20260630082310.GE1812158@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630082310.GE1812158@e132581.arm.com>

On Tue, Jun 30, 2026 at 09:23:10AM +0100, Leo Yan wrote:
> Hi Namhyung,
> 
> On Mon, Jun 29, 2026 at 05:36:48PM -0700, Namhyung Kim wrote:
> 
> [...]
> 
> > Will you send a new version or want to merge this?  It seems there are
> > some remaining comments from Sashiko.
> 
> I prefer to merge this series.
> 
> Sashiko reported several critical issues in the common code, they are on
> my to-do list.

I see, I'll merge this and looking forward to seeing more fixes.

Thanks,
Namhyung

