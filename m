Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A956253389;
	Mon, 11 Nov 2024 17:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347632; cv=none; b=AnxtCgYNnWn/+kZiUYQlBgvvMKzvagGaxakVxBWPukq5wkrUAlJ8GvJOzUWr763rqnBCOlxwR2DJO8GhLvRYjM0xu9lm6F4Rf6/bKkDRfXDOmiGPE27doCFgfy1fXEv4FqBkt6ESDJZfu8pmCx38Su/PX9yo8Bf5nC9n/5uM/Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347632; c=relaxed/simple;
	bh=Fsu1/owX5uR9OfwC4B9okARn57VLAiFArAKG5RlL9HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzy8K8id8Ew2HHbcH54uSkrFzIdJaIOlPgy3ypJTtVo1TmxbrMlMS8FAjUTATD5KYiVGzdjMjMCQl+uyR7C9sOXCPRcJ7S10G4Zt5WCQM7W6/t/byRWcvpKLzi2Ww/+KukW4DK+nkOFCP4T+GEXulofzSeH0sNuSKxvYCvO0fRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pw+WHS1A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pw+WHS1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21E9C4CED7;
	Mon, 11 Nov 2024 17:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731347632;
	bh=Fsu1/owX5uR9OfwC4B9okARn57VLAiFArAKG5RlL9HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pw+WHS1AW2OetHJDf0CKGAI3+abzCg4/drobGeP6pEGZ/x6/cqHLErnGL4in7+kxG
	 pCsMmjcxIETyYZSiPoT0PJSmKJeo2VUwEl9jVuZaPAxcv85G9vpD2LURiI/ABm0O7D
	 zKrsZpV/VsFX3/TQcTAqBYtZPVkSiA0z4jjDw/gTKUyAsqdoj5C/qZgldOyzx4gFxt
	 nxgbR8KLlilp/tXlXwOrgC1ekIpj3tMm02iuzgypek4MpRTuO6ba3rNcS04a0LyMdO
	 +q/m73+6M3Knx5jkQqmcyoka3wKPkBYriVwwuknVKUN6S7BFiCEJWON0RUW66OX0o6
	 B0kQoym8Hiypg==
Date: Mon, 11 Nov 2024 14:53:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Remove redundant variable assignment
Message-ID: <ZzJErOTawAelWAQd@x1>
References: <20241111082713.274761-1-luoyifan@cmss.chinamobile.com>
 <ZzJCEadEKi8LiSTm@x1>
 <ZzJEGipP_AvUoPWw@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzJEGipP_AvUoPWw@x1>

On Mon, Nov 11, 2024 at 02:51:28PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Nov 11, 2024 at 02:42:46PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Mon, Nov 11, 2024 at 04:27:13PM +0800, Luo Yifan wrote:
> > > This patch makes a minor change that removes the redundant assignment
> > > to the variable ret, simplifying the code.
> > 
> > Thanks, applied to perf-tools-next,
> 
> Are you build testing these patches?
> 
>  GEN     perf-archive
>   CC      /tmp/build/perf-tools-next/libsubcmd/sigchain.o
>   GEN     perf-iostat
>   INSTALL libbpf_headers
>   LD      /tmp/build/perf-tools-next/libsubcmd/libsubcmd-in.o
>   AR      /tmp/build/perf-tools-next/libsubcmd/libsubcmd.a
> jvmti/jvmti_agent.c: In function ‘jvmti_write_code’:
> jvmti/jvmti_agent.c:366:13: error: variable ‘ret’ set but not used [-Werror=unused-but-set-variable]
>   366 |         int ret = -1;
>       |             ^~~
> cc1: all warnings being treated as errors
> make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:106: /tmp/build/perf-tools-next/jvmti/jvmti_agent.o] Error 1
> make[2]: *** [Makefile.perf:936: /tmp/build/perf-tools-next/jvmti/jvmti-in.o] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   CC      /tmp/build/perf-tools-next/util/header.o
>   LD      /tmp/build/perf-tools-next/util/perf-util-in.o
>   LD      /tmp/build/perf-tools-next/perf-util-in.o
> make[1]: *** [Makefile.perf:292: sub-make] Error 2
> make: *** [Makefile:119: install-bin] Error 2
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> ⬢ [acme@toolbox perf-tools-next]$
> 
> The original patch by Stephane has it right, that initial ret = -1 is
> used when there are other problems and the code goes to a label at the
> end, returning that -1.
> 
> But the code was changed later and problems were introduced, so you
> removed something simple at the end and somehow missed that it breaks
> the build (at least for me) and when I go look at the code, I see the
> other problems, so please take the time to try and investigate this and
> fix the 'ret' variable usage.
> 
> I'm removing this patch from my local tree.

Ok, some of the other functions use the label at the end + return ret
and looks nice, but the jvmti_write_code() one has this problem since
day one, just look at the other routines and fix this one, please.

- Arnaldo
 
> Thanks,
>  
> > - Arnaldo
> >  
> > > Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
> > > ---
> > >  tools/perf/jvmti/jvmti_agent.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
> > > index 526dcaf9f..751219143 100644
> > > --- a/tools/perf/jvmti/jvmti_agent.c
> > > +++ b/tools/perf/jvmti/jvmti_agent.c
> > > @@ -408,9 +408,7 @@ jvmti_write_code(void *agent, char const *sym,
> > >  
> > >  	funlockfile(fp);
> > >  
> > > -	ret = 0;
> > > -
> > > -	return ret;
> > > +	return 0;
> > >  }
> > >  
> > >  int
> > > -- 
> > > 2.27.0
> > > 
> > > 
