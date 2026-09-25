Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4346F442373;
	Fri, 25 Sep 2026 09:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330371; cv=none; b=dTaivKlYUfNpYZFXYyTJeayY5cbNE+5PxwfEhJz972f0fGOrVdtd+6XKLFxAwePJ6N/bFChFsMHhPknlEkpUL6s4LeSUtI+5sTj2zUdNL6V1f5s3pcFbGlUOLuKw+jubDqTU05+k+W1WkrgRtIfXZZGwbmhnBxPWzU6eMTPZ+qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330371; c=relaxed/simple;
	bh=eQL7zr/KPmAJVuyES36yfi/Xyz23hZOidmbZj3Qf+DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiBKoxFMfE8l635d3pbs6Fy1Ka78NdlNdr08AlffYyeMyjraVyfw3ez24ai4SmqiqlZkQofErzHFw/BS1ysZjpHvZ/sucw8qR7qUvDwLFzeuzzJwnCGL58478savsgwa71vwV52CJq40b1VWx45Rgz6PkMfpG+A+F+oXlWyTQc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAfIwV2+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAfIwV2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2C01F000FF;
	Fri, 25 Sep 2026 09:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790330367;
	bh=PUU4oauHAe2xTc2MvIBIYRSMedST97jjb/Ogls4S8MY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jAfIwV2+zLaIyGsw3M7gB/gd1Hd75RxMF9VPmfUb8a4qlrw9xyVhMxqarnN3EP7rd
	 1nSTMOSTbIrLauArCHV5rNttLr7d6k6ZKSx7ODPx011Ms1r99Yrr4STlCxeWKsae0M
	 86HhoHjLJgSwWiO287EK9qPtS4RCukqI7VgqLwkn80ghTruRiRx+UQg57r05mxp0aI
	 Cy333rrUFTy8jR9xVCf8Jalkl7Tsup15E855tdvLwkylsuQIGkkM1MtPcbkX+7rgxk
	 KvU9ujAruZEXtnubH2mVW/UHoWNEsCOPFzt1MqNBxZJr2NKMmnT0/mYesyT/ybzBf9
	 h6w+IYnLdBhtg==
Date: Fri, 25 Sep 2026 11:59:24 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>, Ian Rogers <irogers@google.com>
Cc: "Steinar H. Gunderson" <sesse@google.com>,
	Namhyung Kim <namhyung@kernel.org>, james.clark@linaro.org,
	xueshuai@linux.alibaba.com, Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] perf llvm: Fix memory leak of args->fileloc in
 symbol__disassemble_llvm()
Message-ID: <arZF_Mphl3Rim0Gw@x2>
References: <20260917125802.1198419-1-wutengda@huaweicloud.com>
 <CAP-5=fVOdeA-cf1NRJxQ_YFeYKu3F1PJ3ykXR5Gtx7r0MtsUtA@mail.gmail.com>
 <arZFMCzEiHbTL6IK@x2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arZFMCzEiHbTL6IK@x2>

On Fri, Sep 25, 2026 at 11:56:04AM +0200, Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 21, 2026 at 11:36:08AM -0700, Ian Rogers wrote:
> > On Thu, Sep 17, 2026 at 5:58 AM Tengda Wu <wutengda@huaweicloud.com> wrote:
> > > In symbol__disassemble_llvm(), after calling llvm_addr2line(), if the
> > > subsequent disasm_line__new() fails, the code directly jumps to 'err'
> > > without freeing args->fileloc, leading to a memory leak.
> 
> > > Fix this by explicitly calling free(args->fileloc) before jumping to
> > > the error handling path when disasm_line__new() fails.
> 
> > > Fixes: 048856817888 ("perf annotate: LLVM-based disassembler")
> > > Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> 
> > Reviewed-by: Ian Rogers <irogers@google.com>
> 
> I replaced the free() with a zfree(&), minor.

I understand why you didn't use zfree(), to make it consistent with the
other free, will keep it and leave the zfree() for later.

Sorry about the noise,

- Arnaldo
