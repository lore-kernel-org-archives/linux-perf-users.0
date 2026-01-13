Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EE0276051;
	Tue, 13 Jan 2026 20:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336636; cv=none; b=a56REvI1DddjaS/C2OutWLdQUPYwe8cX9gp1hQ439mMuYu6JiHEwyn5+4oCb2NzEoXHfge+A2DmlbhrChdC0DHFYaIut9GxMlMc9pY+b9zVIPW5hkpqTXluD1OkOUzxIRozTsqNjbqS4AorxVSqX6lqqxpNB0pl0m3XUQBOMeAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336636; c=relaxed/simple;
	bh=2psVcCOAJwKUDvmp4EQXRRArsO4jM8L1xUaqvE+6wMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxnoJiaXHTUgaErWf6KCt++4Qjv0L6c9psZDM+uLiAgdTDsBSOITpSQRkDjSQSgX0JxhRV1KCzo05kkqMvdc1N5LjXGPYtExcvH7NppSFqAFEaOgHMkejDULa7AXKjyW91BcD1iED5o1Jhih4Ov1CmSKUs+Hf1Ujk4CbhDtS378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dz5ug+uw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dz5ug+uw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17D0C116C6;
	Tue, 13 Jan 2026 20:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768336636;
	bh=2psVcCOAJwKUDvmp4EQXRRArsO4jM8L1xUaqvE+6wMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dz5ug+uwLpHw2ZkTrKWJMSX4PKTORiBxYKEJ+8LLTDThZb0bPa1MhYEeOkxTaq41h
	 AoxZJTcB55ien7jl7MGbw/UMMwcBQIi2vZ3j82pJr6mJMZJnz5jVS4Wd+7C3BBFNZr
	 2zGYd0bBPQvGmFxc2VazTtI5Nrp5H4OCeS62P3MEkeD0q+8QAJ2pcTkdGdGWbZF4hF
	 10XJnAseKljkHjXYDjZ9J7RF59Ux3eDuOv59Nl+i+ZoBb6XbrMZ3Cp7SJXa72rwgmO
	 in4Xy7SlNXmHEYdKbiwNE9BOcx2qrpEo8DkWpZqAjldXf3XdckyJfQ/8cPZwjsyGQP
	 bA7wu65mVqE0w==
Date: Tue, 13 Jan 2026 17:37:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Dump callchain context marker names
Message-ID: <aWas-QjeSE1iB_Zt@x1>
References: <20260102-james-perf-dump-callchain-markers-v1-1-3a9bdec20c58@linaro.org>
 <aVhJRW9URWItj2fh@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVhJRW9URWItj2fh@google.com>

On Fri, Jan 02, 2026 at 02:40:05PM -0800, Namhyung Kim wrote:
> Hi James,
> 
> Happy new year!
> 
> On Fri, Jan 02, 2026 at 12:15:43PM +0000, James Clark wrote:
> > These are hard to interpret in the raw output because they are printed
> > as hex but are defined in perf_event.h as decimal. Make it much easier
> > to read the raw callchains by just printing their names.
> > 
> > For example:
> > 
> >   $ perf report -D
> > 
> >   1798195372321 0x4638 [0xb0]: PERF_RECORD_SAMPLE(IP, 0x4002): 44922/44922: 0x7c8046dd3400 period: 120218 addr: 0
> >   ... FP chain: nr:12
> >   .....  0: fffffffffffffe00 (PERF_CONTEXT_USER)
> >   .....  1: 00007c8046dd3400
> >   .....  2: 00007c8046db86d3
> > 
> > Signed-off-by: James Clark <james.clark@linaro.org>
> > ---
> >  tools/perf/util/session.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 4236503c8f6c..e812f8954075 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -841,6 +841,26 @@ static void callchain__lbr_callstack_printf(struct perf_sample *sample)
> >  	}
> >  }
> >  
> > +static const char *callchain_context_str(u64 ip)
> > +{
> > +	switch (ip) {
> > +	case PERF_CONTEXT_HV:
> > +		return " (PERF_CONTEXT_HV)";
> > +	case PERF_CONTEXT_KERNEL:
> > +		return " (PERF_CONTEXT_KERNEL)";
> > +	case PERF_CONTEXT_USER:
> > +		return " (PERF_CONTEXT_USER)";
> 
> We now have PERF_CONTEXT_USER_DEFERRED too.

I ammended the patch with:

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e812f89540755f31..65fa9bdff1b8cdf2 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -856,6 +856,8 @@ static const char *callchain_context_str(u64 ip)
                return " (PERF_CONTEXT_GUEST_KERNEL)";
        case PERF_CONTEXT_GUEST_USER:
                return " (PERF_CONTEXT_GUEST_USER)";
+       case PERF_CONTEXT_USER_DEFERRED:
+               return " (PERF_CONTEXT_USER_DEFERRED)";
        default:
                return "";
        }
⬢ [acme@toolbx perf-tools-next]$

And added a note about being Namhyung who made the suggestion, thanks.

- Arnaldo
