Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B54C374D1;
	Wed,  8 Nov 2023 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5F0BU0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457C1C433C9;
	Wed,  8 Nov 2023 20:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699475461;
	bh=oPn6KS+Zvkah5IriBkZDjAISiIA9Wf5qt6C30aHY68U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W5F0BU0gws/cuOzT8grC+rUiK7lzjZHV2/AzH61SrghHMHuwEyBLVBy8qlvNndYg7
	 efYmP9h55PnkE+wOrMusUV07kygpRTC061HFyC83CdIrUWgpuPq4w6D9Nk7hHLw3Z+
	 7l9NgmVAUmae5ncrO6YyBbhNzPxI5JE7z75rNdX6BLhANq8FLH8iI8/vn4HH/wz6Gg
	 pG85hHkswC3US32CLAy/s61FazpRSwQa/SoBadbOtZIRUN5OlAgU+nKWNpxufrITgF
	 MnivqAAc3gPMMgJpjdQ5JCoJlMQoUA8pSeksSD9L/IFGY2qMkvfqcy8rNNC7Dj9ItE
	 /wnOsq7d/uSGw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 38EC14035D; Wed,  8 Nov 2023 17:30:59 -0300 (-03)
Date: Wed, 8 Nov 2023 17:30:59 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tests:FIx spelling mistake "whic" to "which"
Message-ID: <ZUvwAzCV2GEog4IX@kernel.org>
References: <20231030075825.3701-1-zhaimingbing@cmss.chinamobile.com>
 <CAP-5=fX6EW+6ZpTkdqKJeeXPjgBiwAGyDLWJGAzoNF5DEYmViw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX6EW+6ZpTkdqKJeeXPjgBiwAGyDLWJGAzoNF5DEYmViw@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Mon, Oct 30, 2023 at 09:30:58AM -0700, Ian Rogers escreveu:
> On Mon, Oct 30, 2023 at 2:12 AM zhaimingbing
> <zhaimingbing@cmss.chinamobile.com> wrote:
> >
> > There is a spelling mistake, Please fix it.
> >
> > Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/tests/attr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
> > index 61186d0d1..97e1bdd6e 100644
> > --- a/tools/perf/tests/attr.c
> > +++ b/tools/perf/tests/attr.c
> > @@ -188,7 +188,7 @@ static int test__attr(struct test_suite *test __maybe_unused, int subtest __mayb
> >         if (perf_pmus__num_core_pmus() > 1) {
> >                 /*
> >                  * TODO: Attribute tests hard code the PMU type. If there are >1
> > -                * core PMU then each PMU will have a different type whic
> > +                * core PMU then each PMU will have a different type which
> >                  * requires additional support.
> >                  */
> >                 pr_debug("Skip test on hybrid systems");
> > --
> > 2.33.0
> >
> >
> >

-- 

- Arnaldo
