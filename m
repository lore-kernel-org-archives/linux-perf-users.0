Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDAB48BD46;
	Fri, 25 Sep 2026 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330165; cv=none; b=A/7R1Vt7GQWjp9R8iCYZ9GNvCCSHgH9FUyHE/l9mk58wDDUbTW/5XQMG4T/zq578IZfmmsB/HBh6sQHDU/nfrPUbjKyRUle5NgIzomOZgUo8Me8Y7PBkQs6+oN9e0S84ZFIqp8nuYvFru4pKHkdVdYBK883voYhwe8Kslk8zW+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330165; c=relaxed/simple;
	bh=YKjmF64kEIzzlVoXlU3EnYTbP53sDYQ5FoKpJ/s8zm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6TSFkhkRPMkkL7Wsa6VhfV0XhELD5Mtob9HiNgZhtxgOr/B3mCHV2/eSyo5vI0dH/xUEZVBTR5aYsOMGSA1N8ZTEOZeXc8XzyvyF0ATeEivxUd6mm1PFVtukFEnBb+2IYQwXJd/0/5qsEiec1oo8dhKEO5nBl8IYzx3AkDr5Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJo/jaS/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJo/jaS/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6001F000FF;
	Fri, 25 Sep 2026 09:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790330163;
	bh=YKjmF64kEIzzlVoXlU3EnYTbP53sDYQ5FoKpJ/s8zm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oJo/jaS/Ldv/lKltzBRteLlqP0+aKON+Tc0ElXd5F+5rwtC1pexoH06xb+epKSuWz
	 7z5hV6REYHsGzEoRkl3l9V6LeEQEv7viLfP43GQN5DI3HSCBLPZp58Jve6Or1nhpKi
	 7cHx6+Puc46ejCMDY7QLRJL49t8FAYgWE+4KyrOtnmS0rkkGqiPibr+OjzyS+azLFO
	 ILtTi8J1c44E9b3pnTXY9YGr66nly1VKx41ZRj3MI0ONWBeOBWngPDGlo8qaF5wzR0
	 GAzfkVMT3jGY8qc68kYjzJJY+0W7UPkZDykPmungJAG7Rd+4/2iOuPSCkLzGSrFxF0
	 SHn48lpw0f20Q==
Date: Fri, 25 Sep 2026 11:56:00 +0200
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
Message-ID: <arZFMCzEiHbTL6IK@x2>
References: <20260917125802.1198419-1-wutengda@huaweicloud.com>
 <CAP-5=fVOdeA-cf1NRJxQ_YFeYKu3F1PJ3ykXR5Gtx7r0MtsUtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVOdeA-cf1NRJxQ_YFeYKu3F1PJ3ykXR5Gtx7r0MtsUtA@mail.gmail.com>

On Mon, Sep 21, 2026 at 11:36:08AM -0700, Ian Rogers wrote:
> On Thu, Sep 17, 2026 at 5:58 AM Tengda Wu <wutengda@huaweicloud.com> wrote:
> > In symbol__disassemble_llvm(), after calling llvm_addr2line(), if the
> > subsequent disasm_line__new() fails, the code directly jumps to 'err'
> > without freeing args->fileloc, leading to a memory leak.

> > Fix this by explicitly calling free(args->fileloc) before jumping to
> > the error handling path when disasm_line__new() fails.

> > Fixes: 048856817888 ("perf annotate: LLVM-based disassembler")
> > Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

> Reviewed-by: Ian Rogers <irogers@google.com>

I replaced the free() with a zfree(&), minor.

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
