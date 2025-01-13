Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10CD17557;
	Mon, 13 Jan 2025 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783320; cv=none; b=AWf7Y/7kymamp1aGwArCKSIRdD9NQ/q8sgTM9OM0md7Ws0UHuJ3MJ3TF6rbHkDcsNOelbzpnnCWGYlSaUh6TVJ8MJJmCNNXJmnA6ca39yXD4A+olKMV0BV5w2pMBaFo8xTQkpww1Kr+lBwiIEaxWQeMHZ1JN9dIyVib/v1Gegfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783320; c=relaxed/simple;
	bh=q8nYehHYoicOGXwunJWDhfW0S5+WX2+WdcPUvH6l/xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYOrgIL1/oL9WQUSHAzy1ymlpLrqD5Ckp+Csi4uTlwF3NOhHVq3H3Iujpqc2ATHBgALGEsb5MjkrFj8QnZSroc6zzSNLBRwJpN/9MKxdj1a3dutR7BAjsmbCwNGVEhGqEHmc0Cvn3jjfBsZQgMZttCsDtAKucRaCg5HUmyx8Q/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xdb0vyMc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xdb0vyMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5013C4CEE1;
	Mon, 13 Jan 2025 15:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736783320;
	bh=q8nYehHYoicOGXwunJWDhfW0S5+WX2+WdcPUvH6l/xA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xdb0vyMc8ByqCIKWVxuLqjBmQAsojkQsIA8D2QumOl7QXJxq6MMf7pb1poElk0uI2
	 mJsmb8eP6/V5p0krWQigVHW54ftWU0ZrUjvWk1r/H/9YetTMNjclWmKD3yBRCxVTIf
	 fPiGpAeQ5qatbqJdjLVYZtrsTczhG+7Lvroh5FMtayzvB4uOXAgCD8GQL1PyFJbRlv
	 EMIyPuTOUX/HruH7hXqJ0mPYVvDE8iNrspOStTv4mfLTSV+NwwQxbZewJKTd7D0lpH
	 BJrWCvC2KG+3+rgWteqaC9CQP7T5qyXdrqtsqWjeAjc5TId+OTEeAbnAiX0rocFoH9
	 tD+wdu2VBcF1g==
Date: Mon, 13 Jan 2025 12:48:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf inject: Fix use without initialization of local
 variables
Message-ID: <Z4U11bKn3zJjLQij@x1>
References: <20241211060831.806539-1-irogers@google.com>
 <6f441be9-7731-45dd-a131-39cc2e34dc1a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f441be9-7731-45dd-a131-39cc2e34dc1a@linaro.org>

On Wed, Dec 11, 2024 at 09:58:00AM +0000, James Clark wrote:
> On 11/12/2024 6:08 am, Ian Rogers wrote:
> > Local variables were missing initialization and command line
> > processing didn't provide default values.
> > 
> > Fixes: 64eed019f3fc ("perf inject: Lazy build-id mmap2 event insertion")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/builtin-inject.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index d6989195a061..11e49cafa3af 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -2367,10 +2367,10 @@ int cmd_inject(int argc, const char **argv)
> >   	};
> >   	int ret;
> >   	const char *known_build_ids = NULL;
> > -	bool build_ids;
> > -	bool build_id_all;
> > -	bool mmap2_build_ids;
> > -	bool mmap2_build_id_all;
> > +	bool build_ids = false;
> > +	bool build_id_all = false;
> > +	bool mmap2_build_ids = false;
> > +	bool mmap2_build_id_all = false;
> >   	struct option options[] = {
> >   		OPT_BOOLEAN('b', "build-ids", &build_ids,
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next,

- Arnaldo
