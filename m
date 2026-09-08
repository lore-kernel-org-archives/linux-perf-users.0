Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391CC3D811C;
	Tue,  8 Sep 2026 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788902067; cv=none; b=NRN2n89q1EsIETtDwuCg8x54DQgIVSahCsKVA8s43kmfJ5pPF8QV/Ed75cwv+Y+VviUsdyM2NkPS/egx7b07alYpI49sRbUMezctSI5AftnWNGgKxeCpDOBFAaLdLdGAWCPbR5pPJB8zzBeXv5hQG3l6q/lLgWwxAQaNUQ+rUJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788902067; c=relaxed/simple;
	bh=M/DGy1YyANG1+EJl2wg/uh7e1KuPL1EQ6mAsnTGEk8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVXFPR8lPbTjCBM/nesTRbMdQ3NC/aMiSDgZL5Dh0Hp1hDZE7ZdWYYm8zqaA7CI3IruyLCZqoXKO9l5ceBxd7PSSSZB7LXmAGc1PjCPKGVV+Ks0VAWHcuxnmkA0pHxvfHUp5ThgfN3tZf9KE562bnz0RYjR3CnwXcICvFY4oyT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2ENjhN3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2ENjhN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEDD1F00A3F;
	Tue,  8 Sep 2026 21:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788902066;
	bh=4b5cOP3BG9Yq0rRZjPdPYb2ZsXh/I4WPhyyAvlDQI58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G2ENjhN3QCTk6mtvuqB0nR2T3zrSzoLK3R9BXwl8Ltag7tC7GwtPzGZlEh2QbkBSG
	 AjDnle7vTaWOI5hj2iRqgM8tSaeFedoZFH5apkxbbrgumfBs6lvxNY52om+AJLc7FW
	 4Ecan1ruh4IB4uu8Q63Xj6SPJEhDI0cqycJVyxoCiv3HeHYyIbRbRQJZGfl37XUPC1
	 mf3yF0nHHkcTazPE6UnR2IJmzedv/lOsng6BcheZFl0HW+zquDilzkpgCk/Q1Rgy9H
	 QgnwDBfOlKBR46jyBnioiG3Y8G+brDMQflBBP0gbAw/DfF/4zaXSdH0R33TdwVJjDe
	 zPde2Tthx0u/A==
Date: Tue, 8 Sep 2026 18:14:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Zide Chen <zide.chen@intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf test: Avoid call to missing cleanup function
Message-ID: <aqB6r0SP3d1udSZI@x2>
References: <20260904194954.1192154-1-irogers@google.com>
 <3b4cee11-a3e7-4c31-bc5d-a992f00db0c3@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b4cee11-a3e7-4c31-bc5d-a992f00db0c3@linux.intel.com>

On Mon, Sep 07, 2026 at 02:47:17PM +0800, Mi, Dapeng wrote:
> LGTM. Thanks.
> 
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
 
> On 9/5/2026 3:49 AM, Ian Rogers wrote:
> > Cleanup function was removed by writing to /dev/null rather than
> > temporary files. The exit path still had a call.
> >
> > Fixes: 44f6b4402791 ("perf test: Fix hybrid testing of event fallback test")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/test_event_open_fallback.sh | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/test_event_open_fallback.sh b/tools/perf/tests/shell/test_event_open_fallback.sh
> > index 9420a7557c13..27d440a5355d 100755
> > --- a/tools/perf/tests/shell/test_event_open_fallback.sh
> > +++ b/tools/perf/tests/shell/test_event_open_fallback.sh
> > @@ -57,8 +57,6 @@ ret=0
> >  test_decrease_precise_ip		|| ret=$? ; count_result $ret ; ret=0
> >  test_decrease_precise_ip_complicated	|| ret=$? ; count_result $ret ; ret=0
> >  
> > -cleanup
> > -
> >  if [ ${err_cnt} -gt 0 ] ; then
> >  	exit 1
> >  fi
