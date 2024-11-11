Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688421A4F0A;
	Mon, 11 Nov 2024 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347486; cv=none; b=GMtBylFwCtfwci1GgRpa0+N+i0MVATtFKcseVXrlLb8GHfsW1zI67b+0syuxqieEDxijz+31eakALV9ZMKpa4P3TzJJIW2VF3YEKV5udKxMvIeVlNnWcsA+C/xPJwYoHwj0I97qv/ByzwJ29z4tIQrLYMPAuba1ODbr3ZAToL54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347486; c=relaxed/simple;
	bh=qucWoD3U+wiP62CZ51ISOtD1EZMtjZ56hiKOnRr9a+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JypYWUzRvkk4s/DLqEMVU3o7gBWUMXV8pTbgBfWgPNrjijNr9iF8O83lcFrpOGIfPYwTYAsj17u9nnkobK88WQqQRyiysHippFn9WBs5sxIaMMfoB56P8+CMCPUKXvVLiiMDBRp63NNZbMePKm4K+lOpihIPBoqEPQZl0d4RRo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a72DBlje; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a72DBlje"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FACC4CECF;
	Mon, 11 Nov 2024 17:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731347486;
	bh=qucWoD3U+wiP62CZ51ISOtD1EZMtjZ56hiKOnRr9a+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a72DBljeqeGThd3CzNjMQL0M1EFKTtmfaHZ4/+ilEJXUs7by9EcV/JAGqkXYsBE97
	 azQ2l3qke8tr65iSHx4Z0WMXwzfqzWe5FWh1k0r1pFNLt4dKeNZNJjUDgy+4gCvmsH
	 BGXecJ6Brxm3yR/Js2GmdrDau+p+mux7O20u7AxbF++iB6PBHJxX1+9jCc/kicEFOf
	 I/PmFNl4Qxbu1i6CdHb7JR6uSfAdWSHCBFEREjCjiAeXIP0f24Xv0FtFCTAOcGZ275
	 byRCuIaeMWHP8iWhdmvKEXHL94Ut3PfbOOPFfCmQnbV6TN1SwedoySMK/7yrsBFylz
	 K9ZbcHOa5YkmA==
Date: Mon, 11 Nov 2024 14:51:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Remove redundant variable assignment
Message-ID: <ZzJEGipP_AvUoPWw@x1>
References: <20241111082713.274761-1-luoyifan@cmss.chinamobile.com>
 <ZzJCEadEKi8LiSTm@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzJCEadEKi8LiSTm@x1>

On Mon, Nov 11, 2024 at 02:42:46PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Nov 11, 2024 at 04:27:13PM +0800, Luo Yifan wrote:
> > This patch makes a minor change that removes the redundant assignment
> > to the variable ret, simplifying the code.
> 
> Thanks, applied to perf-tools-next,

Are you build testing these patches?

 GEN     perf-archive
  CC      /tmp/build/perf-tools-next/libsubcmd/sigchain.o
  GEN     perf-iostat
  INSTALL libbpf_headers
  LD      /tmp/build/perf-tools-next/libsubcmd/libsubcmd-in.o
  AR      /tmp/build/perf-tools-next/libsubcmd/libsubcmd.a
jvmti/jvmti_agent.c: In function ‘jvmti_write_code’:
jvmti/jvmti_agent.c:366:13: error: variable ‘ret’ set but not used [-Werror=unused-but-set-variable]
  366 |         int ret = -1;
      |             ^~~
cc1: all warnings being treated as errors
make[3]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:106: /tmp/build/perf-tools-next/jvmti/jvmti_agent.o] Error 1
make[2]: *** [Makefile.perf:936: /tmp/build/perf-tools-next/jvmti/jvmti-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC      /tmp/build/perf-tools-next/util/header.o
  LD      /tmp/build/perf-tools-next/util/perf-util-in.o
  LD      /tmp/build/perf-tools-next/perf-util-in.o
make[1]: *** [Makefile.perf:292: sub-make] Error 2
make: *** [Makefile:119: install-bin] Error 2
make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
⬢ [acme@toolbox perf-tools-next]$

The original patch by Stephane has it right, that initial ret = -1 is
used when there are other problems and the code goes to a label at the
end, returning that -1.

But the code was changed later and problems were introduced, so you
removed something simple at the end and somehow missed that it breaks
the build (at least for me) and when I go look at the code, I see the
other problems, so please take the time to try and investigate this and
fix the 'ret' variable usage.

I'm removing this patch from my local tree.

Thanks,
 
> - Arnaldo
>  
> > Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
> > ---
> >  tools/perf/jvmti/jvmti_agent.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
> > index 526dcaf9f..751219143 100644
> > --- a/tools/perf/jvmti/jvmti_agent.c
> > +++ b/tools/perf/jvmti/jvmti_agent.c
> > @@ -408,9 +408,7 @@ jvmti_write_code(void *agent, char const *sym,
> >  
> >  	funlockfile(fp);
> >  
> > -	ret = 0;
> > -
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  int
> > -- 
> > 2.27.0
> > 
> > 
