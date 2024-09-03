Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24A91A724E;
	Tue,  3 Sep 2024 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725369300; cv=none; b=sC4vNy4zb9uPt4bHunM8cbxShQPVADlJeRC4qmgyV8VrL7NPZgdtujzXzqR/aYizIC4T0CAZf8kvLJitxJVz2Wzjqgh5Lp5lQ98tmWbw4dZPVP/aUVJgGiQF4E6YKeQzZSpx7KLi6Fo4zKoLwiVf6sDpKajvTztnY43eVGBAfNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725369300; c=relaxed/simple;
	bh=gNdxP6S0Q6kJNJkwFbpyMiRiJgpoTPY2bFnMnkVEEqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DR2nrK97BEuoF4RUZuXRkITTyN3cr8ZBlLqv4nuUlOtUtqZNWarGAeadATQqdvzNoDQAZMxAEZwPdaYrVpkqm+MYw9plf/gGuDNddj5xJOZqloRzXRQytf426MzhcV+0zjQXjOL5vEh9ZKwV3250qvh56gxziE2zAHVs7eOlnEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vE6SdtP3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vE6SdtP3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03A4C4CEC4;
	Tue,  3 Sep 2024 13:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725369299;
	bh=gNdxP6S0Q6kJNJkwFbpyMiRiJgpoTPY2bFnMnkVEEqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vE6SdtP3elsN193nAEe74tdIDzuF3cKpc6wwxLjKVq6CoVQv2tsx7+5h+BzZuSmpO
	 r67xuDn0By5BxmrLIC+HiwMXSiKK0QfE0pkFLK+BZJHgQgX1eti9W8wdjTQQkkYS83
	 oy1fZETQp4mEE4fI/4VqgZ+cMRpYuw9BQfAIH0Sv5y4zX20NRQt8eK57MOVRTOM1wO
	 138NQW/FFdkDtgPt/X195D3nFQwQLlGtgff6e9Jr91XHkljbJe8m+v8FsWqBEQbMZm
	 71lFBHF+C8ogi1/NTvJu81D/5p/1JX/klN62PvoB8o2U8XxGhQDvYnFu2Y8tJSlDcY
	 1usbXnEIOIV/w==
Date: Tue, 3 Sep 2024 10:14:55 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	irogers@google.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v9 1/3] perf report: Support LLVM for addr2line()
Message-ID: <ZtcLz45rJYJR7FCQ@x1>
References: <20240719150051.520317-1-sesse@google.com>
 <ZqlCIJ4khe2_xyp9@x1>
 <ZqlDuIj_nMVXhYou@x1>
 <ZtRIla5pCqlMIKvN@google.com>
 <Ztbga0xLyt1eaehi@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ztbga0xLyt1eaehi@x1>

On Tue, Sep 03, 2024 at 07:09:47AM -0300, Arnaldo Carvalho de Melo wrote:
> On Sun, Sep 01, 2024 at 12:57:25PM +0200, Steinar H. Gunderson wrote:
> > On Tue, Jul 30, 2024 at 04:49:12PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Unfortunately it clashed with recent patches in the capstone related
> > > codebase, IIRC Athira's for powerpc data-type profiling.
> > > 
> > > […]
> > > 
> > > I'll continue processing other patched and eventually try to fix this if
> > > you're busy,
> > 
> > Hi,
> > 
> > Is there any movement in getting v10 merged? :-) I haven't heard back
> > since I sent out the rebase
> 
> Test building is detecting some problems, I'll try to address them:
> 
> perfbuilder@number:~$ time dm
>    1    13.50 almalinux:8                   : FAIL gcc version 8.5.0 20210514 (Red Hat 8.5.0-22) (GCC) 
>     util/srcline.c: In function 'dso__free_a2l':
>     util/srcline.c:184:20: error: parameter name omitted
>      void dso__free_a2l(struct dso *)
>                         ^~~~~~~~~~~~
>     make[3]: *** [/git/perf-6.11.0-rc3/tools/build/Makefile.build:158: util] Error 2

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 2e3845ac07ee7be6..f32d0d4f4bc9e659 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -6,6 +6,7 @@
 #include <string.h>
 #include <sys/types.h>
 
+#include <linux/compiler.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
@@ -181,7 +182,7 @@ static int addr2line(const char *dso_name, u64 addr,
 	return num_frames;
 }
 
-void dso__free_a2l(struct dso *)
+void dso__free_a2l(struct dso *dso __maybe_unused)
 {
 	/* Nothing to free. */
 }
