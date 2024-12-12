Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B2A1C07EF;
	Thu, 12 Dec 2024 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029687; cv=none; b=Ic/b+tEaDSKAwVxVZF/adr1AICItEDlZpSJROKDnzLSRXD23Psja9A5ZBI+gQ8BSAK2YYcZ+wBPaWeKwhSq9p1z1EwQthhbFXja1zN568DvuMwts0vH88FFqaRV4s4PDcoFEdyRpAA6JJo1xieCqa7qx6xPCWgQzagc/67uiXNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029687; c=relaxed/simple;
	bh=gZyrf1JoKj+vApuck1Bo+6L2JAu1Um1uZpj4PhhsRwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5CP6Rw2A/NS5dHhVOP/lYMBFjYqripA8lPAH/leDtm/Nfq290t5FRI5Zk4JZbA44AbnhmHP0miNcKnSHJccpLdPUuUQb+sZqvQd44AdGvdcr4XPMhxSgjQjpGQk8sh5ArwykiMnvVKGO9u+POzjJok+cq0/jQaoVP561YJbDbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSb6IgVH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSb6IgVH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0421C4CECE;
	Thu, 12 Dec 2024 18:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029687;
	bh=gZyrf1JoKj+vApuck1Bo+6L2JAu1Um1uZpj4PhhsRwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hSb6IgVH+sztZTfDpSfnNlOl1p8d/8apX6uZWqiP0dWqiktVxblHCFxnElp7lIjH+
	 4LZ/kjYYVE4Jzwj9/zlc6WElDFizsveV/g1QPjHjofV3X/CT/c3cFfCGcz7d2sm+Oh
	 cUFsl9ARH6he0CpLNPSskuhVtdlGu4gYYLSkU00HsiTNgz1zXeP/1FVkruxM6LtoWo
	 G4Hf1K4IQY8aE7kquRXHyz1XEQ6QvlvuO+jYax49H9w0sLedykYCaxkA1dIH9DcUau
	 u3GnsoM59WnG/LbAwQtaXDlwAv3o9+UDbmev/w0ZBhyL6DVcaiGC3swRmWrTCvESrn
	 EFR+utLuNw+pQ==
Date: Thu, 12 Dec 2024 15:54:44 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v1] perf string: Avoid undefined NULL+1
Message-ID: <Z1sxdMeSD-pWuUOZ@x1>
References: <20241120065224.286813-1-irogers@google.com>
 <9e9a550c-0017-40b0-af14-99f3c926290c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e9a550c-0017-40b0-af14-99f3c926290c@linaro.org>

On Mon, Dec 09, 2024 at 11:49:15AM +0000, James Clark wrote:
> On 20/11/2024 6:52 am, Ian Rogers wrote:
> > While the value NULL+1 is never used it triggers a ubsan
> > warning. Restructure and comment the loop to avoid this.

> > Signed-off-by: Ian Rogers <irogers@google.com>
> > +++ b/tools/perf/util/string.c
> > @@ -254,11 +254,20 @@ char *strpbrk_esc(char *str, const char *stopset)
> >   	do {
> >   		ptr = strpbrk(str, stopset);
> > -		if (ptr == str ||
> > -		    (ptr == str + 1 && *(ptr - 1) != '\\'))
> > +		if (!ptr) {
> > +			/* stopset not in str. */
> >   			break;
> > +		}
> > +		if (ptr == str) {
> > +			/* stopset character is first in str. */
> > +			break;
> > +		}
> > +		if (ptr == str + 1 && str[0] != '\\') {
> > +			/* stopset chacter is second and wasn't preceded by a '\'. */
> > +			break;
> > +		}
> >   		str = ptr + 1;
> > -	} while (ptr && *(ptr - 1) == '\\' && *(ptr - 2) != '\\');
> > +	} while (ptr[-1] == '\\' && ptr[-2] != '\\');
> >   	return ptr;
> >   }
 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next,

- Arnaldo
