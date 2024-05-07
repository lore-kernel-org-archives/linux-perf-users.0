Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BA615FCF0;
	Tue,  7 May 2024 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715093580; cv=none; b=aYyywyqMCe4O/VjAzflFYHOt5cZ0rdU4PRmJuP4HwWjW1ilxcy6/J9tdlZ3PK2lgETpr+nF2b763OSH26D08PJfOSMoXTe1fREoMdtt8mKkqrkIWzZJinq33RF9xdvw3H5JNvZ+e9rxMUPz11C2/WxjChi+KZjVOAuqYP1MB2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715093580; c=relaxed/simple;
	bh=G2fd/G6gHoEl3QR40FzwdMkgc9pQE2sWSv49OHbI4d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jw6988NMg/jlYH/iJ3Z5OiM/L0q1Jvur3tBXNUQD0YfUtj6uuHMoGLAx3Gm1MnobHgYTcnPwY8Sj38rGqHN+VCeBsUTI5hlf+HNzIt7cyCNXuiPFwT/CgnBL9DZ11s2oog8NtggiYpFRZxnRjav4+5WxG4+H9ti3/Iuae/KMX70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvNPgBvv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvNPgBvv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B756BC4AF63;
	Tue,  7 May 2024 14:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715093580;
	bh=G2fd/G6gHoEl3QR40FzwdMkgc9pQE2sWSv49OHbI4d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvNPgBvvlZTMle2tmEciAGw4tri1AC80m9Gm4LuqqYzLzoD5yn/+U4w1lq0hVsEPN
	 NuNmtC1elTWZev4XncK6IHzUFAxmbg4LwnEV2c9vAfCl5HJiireagp/Ej8oPJKGuul
	 /6wHXPs9HT5lEn/+xwvxUOqeUwCCUpDzN95f5CsNZGT/7Chke0GafGBJQAcZez/uUq
	 7poyjgcEqoT6wr6EBEJHitW+ROmlFfZzQBtREzVs2C9YM3212ZkdWRARw8oLHMVc5H
	 OynWw14pkd5xCPEp01lHucmRHRS0CLawCT4nnn2ZQ71hfKMrdUUgBFHkFabTYqEwrO
	 EdReYeVrSrymw==
Date: Tue, 7 May 2024 11:52:57 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
	adrian.hunter@intel.com, irogers@google.com,
	segher@kernel.crashing.org, christophe.leroy@csgroup.eu,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com, kjain@linux.ibm.com,
	disgoel@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	akanksha@linux.ibm.com
Subject: Re: [PATCH V2 3/9] tools/perf: Fix a comment about multi_regs in
 extract_reg_offset function
Message-ID: <ZjpASVk1GezAzDAG@x1>
References: <20240506121906.76639-1-atrajeev@linux.vnet.ibm.com>
 <20240506121906.76639-4-atrajeev@linux.vnet.ibm.com>
 <CAM9d7ciKUQErzu1Y7FnWCryW15xUkyJLSt-Jez9h8TYgp-tLjw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ciKUQErzu1Y7FnWCryW15xUkyJLSt-Jez9h8TYgp-tLjw@mail.gmail.com>

On Mon, May 06, 2024 at 09:40:15PM -0700, Namhyung Kim wrote:
> On Mon, May 6, 2024 at 5:19 AM Athira Rajeev
> <atrajeev@linux.vnet.ibm.com> wrote:
> >
> > Fix a comment in function which explains how multi_regs field gets set
> > for an instruction. In the example, "mov  %rsi, 8(%rbx,%rcx,4)", the
> > comment mistakenly referred to "dst_multi_regs = 0". Correct it to use
> > "src_multi_regs = 0"
> >
> > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Cherry picked this one into perf-tools-next.

Thanks,

- Arnaldo
