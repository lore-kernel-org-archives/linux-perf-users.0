Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D76C230BFD;
	Thu, 29 May 2025 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748550282; cv=none; b=VIv2zxkx3hBRAQth2hH+A4rE1ybr8+f5aC67mL/pAq+OdIQX96qsZ5hhlXkkYpuEGy9yJOx0itd6RmrJagWwgM4KPKKK+WAZwC9pAGT1exNk7pZ1xUiJBvc3aCh6zKyj7HLRVkC/sBpf12oItU+bIZt06x2Yy+53jSCvDYCew7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748550282; c=relaxed/simple;
	bh=5ihwG/LJXHnIwkyvyR0nDlkHVdNYPb7/xaoi5raJKkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXXbW4bAwp+S8GFm0fX6xvPGunx1NHJFBsbjremosczum0onwjmIxR+h8BBlHshxEYO9XO8DhJm7vgY0qgGsD1MArMm68lxOjzsMIyHO34Sb9sqVH+FbxnA+VwBWj2KR9eV+J+9BKTmUdG6KcQk46FFXBwgUTDWC0Lqq15D8I6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIf78UaB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIf78UaB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82534C4CEE7;
	Thu, 29 May 2025 20:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748550281;
	bh=5ihwG/LJXHnIwkyvyR0nDlkHVdNYPb7/xaoi5raJKkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIf78UaBrPatPNtTn4efNMQShQfQ8FQJ/72t0aZrOWpRQx4XIev3u+jsivzbj5xI4
	 SuK/fbKbjlJ6YpoLyERYO0y375WEc+oq9owaeULLPUSyeOfb99QhENwToTWxjMHP2O
	 mg3djzPocXmGcYmfYi56N01sRPu2kxt/iZB55xHynTgs+RxUxsfIId3bNhD60g0dOE
	 8wpQo4M+YfvkyBzErOl4z7hVEXvCg57CVyYdkjleih60TBDqocAd+eZJ8qF+IY0WOI
	 WBGPFG62PXjXOgu6KFDeI4BJnuo+X1cU5Q0jpchIgFpOzgjHte31J8O3YEGfDA6WY+
	 2XIq5ZkajhygQ==
Date: Thu, 29 May 2025 17:24:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Yuzhuo Jing <yuzhuo@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	James Clark <james.clark@linaro.org>,
	Tomas Glozar <tglozar@redhat.com>, Leo Yan <leo.yan@arm.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Adhemerval Zanella <adhemerval.zanella@linaro.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v1 0/4] perf: Remove libcrypto dependency
Message-ID: <aDjChk6XTtHUrPd-@x1>
References: <20250521225307.743726-1-yuzhuo@google.com>
 <CAP-5=fX-Hy-YLD_P_73Z2+7PfPnSU=0e5yaDgoeZ3gw_getaYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX-Hy-YLD_P_73Z2+7PfPnSU=0e5yaDgoeZ3gw_getaYw@mail.gmail.com>

On Thu, May 29, 2025 at 12:31:59PM -0700, Ian Rogers wrote:
> On Wed, May 21, 2025 at 3:54 PM Yuzhuo Jing <yuzhuo@google.com> wrote:
> >
> > Currently, genelf.c is the only file in the perf tool that depends on
> > libcrypto (e.g. openssl), which only uses it to calculate a SHA1/MD5
> > Build ID.  This patch series pulls in the SHA1 implementation from the
> > kernel tree, and removes the libcrypto dependency from perf.  This also
> > switches the default Build ID calculation method from MD5 to the more
> > commonly used SHA1.
> >
> > Yuzhuo Jing (4):
> >   perf utils: Add support functions for sha1 utils
> >   perf tools: Add sha1 utils
> >   perf genelf: Remove libcrypto dependency and use sha1 utils
> >   tools: Remove libcrypto dependency
> 
> Tested-by: Ian Rogers <irogers@google.com>

I reported a problem with some integer comparision, the code is the same
as is in the kernel, so I left it for later to continue analysis, if
someone can try to continue from where I left, that could help.

But then this can be left for the v6.17 as we're already in the merge
window for v6.16 and we need to have some time for what is in
perf-tools-next to sit in linux-next before sending to Linus.

- Arnaldo
