Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81353D994;
	Sat, 14 Mar 2026 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510150; cv=none; b=goK2Aq2gky+3ggiFZMd8YbVzdwIyy7GymnOpKeWrNGUxCw4ZugbYY0OJO+sZJM7BrPRvIw1uTbInzqktXczOHJIaBTbCrvDd3qIIZFvcARVPCNn4z8/KihUtyg3oxl32pSf1iWpfA57wKrpvw0UsBGyv5nQHcWSgmqIfkyQ/eto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510150; c=relaxed/simple;
	bh=L6z2karfq36/7M0guikZ7xpYFqw7WrpcgqqYcuFOVEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nd0N+Jc+3Mgnirfo/bxkmwKt8AEWaik08l/9JSYh/ZvZb2rzTOf9FaDaV8GMOEtl9jvB8bM0grLTxkyoJsqMT+OIPAFIeS+J22w6x2dWzaGusJf0vwU76IEbkp+NbDAX7jDzTuyA9Rn1XLkOHUlFTa9xCLbp5DvNVh8ERLikeaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPHwEjhZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPHwEjhZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E4AC116C6;
	Sat, 14 Mar 2026 17:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773510150;
	bh=L6z2karfq36/7M0guikZ7xpYFqw7WrpcgqqYcuFOVEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gPHwEjhZQm5+02NEFrIhhtdF4+QpHwY/HU2Z4Zv0NUFHLic6pv3/DaGisTDBO43jh
	 iu2hyNtakth+doNtTn5ktcmIIIiMhEx+51LXDP/1UQErOsFFiLdZM5tHC5EgyOd1IM
	 siNqiOEz4qEWx0Hl1hGdb6ecMaZo1uxRjZcAGv8XCSGQ7/z6Ty0ssdIEnhSBcN23sz
	 FmwG0iG3mnr3VqELX2yj2ApphBb22WWWSfZuS8qW0To7L8rYdzBbY9C2zxYoVPMIfx
	 6w5tmJGWUJbkhyfRHl9Sz7hSdPJark7fhbx5QApBvM6bf2rYZGCRurkdJFPEsr3rYO
	 hnPVkKhYcyGpQ==
Date: Sat, 14 Mar 2026 10:42:28 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 0/5] perf tool: Minor code clean ups
Message-ID: <abWeBJLfxV9nluNu@z2>
References: <20260207082428.1742209-1-irogers@google.com>
 <CAP-5=fWUk4pwHpgSQbrCuXKDu_wZDjmLd6kbtQ9zqCkNdJZGmw@mail.gmail.com>
 <abSA8h6GoTW_CD0g@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abSA8h6GoTW_CD0g@google.com>

On Fri, Mar 13, 2026 at 02:26:10PM -0700, Namhyung Kim wrote:
> On Thu, Mar 12, 2026 at 01:40:53PM -0700, Ian Rogers wrote:
> > On Sat, Feb 7, 2026 at 12:24 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > Remove some unused functions, files, etc. Reduce scope of variables
> > > and functions. Constify arrays in perf.c.
> > >
> > > Ian Rogers (5):
> > >   perf symbol: Reduce scope of elf__needs_adjust_symbols
> > >   perf dump-insn: Remove dump-insn.c
> > >   perf tool: Constify the command and option arrays
> > >   perf bpf_map: Remove unused code
> > >   perf record: Remove unused cpu-set-sched.h
>  
> Sorry for the delay.  Looks fine to me.
> 
> I'll test and process them soon.

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

