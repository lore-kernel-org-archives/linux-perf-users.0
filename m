Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C084F2C21FA;
	Tue, 16 Dec 2025 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765909420; cv=none; b=jmXbwjiYzp/VmP8PUa14POXuYYtRIlGsSa8KImXDC7atZXbVYHiUaLstYHEPRM34YSEAJjkw366j54HNxmhF+1li7MaqV+xv+Fl3jF4rxLf+rmXnQzcy0DvhPSAbUHWJ0SLKS3avu6/aa5DrifdutmouksGPPFSvIK07Ii9vtYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765909420; c=relaxed/simple;
	bh=PZqgccPgvbK/OCP6qtFpBEn5AyXytFNtrMqXZiTtMx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HotARGQ1bTmzhgxnVU7b44C2kKC7jeO0UhnRgDFzDEITnoCs/11EOH+qHWAeWlX5aF9vg2xgFrWA6Ic2yrNPhT9sagixlEoNdhLTXtZhUPS0e/4YZrD7l2gvBSwDSoArZq3MCMDmltN2V7ORDa/x1Ib/jI/t5veNOj/cjjtIuxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPulAU5q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPulAU5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736ADC4CEF1;
	Tue, 16 Dec 2025 18:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765909420;
	bh=PZqgccPgvbK/OCP6qtFpBEn5AyXytFNtrMqXZiTtMx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPulAU5qvj5E7r8Gj/GoHaRXwa6S+n3heLONB7dneHY51s+aNppYx0Sfa443ZZkH+
	 c+bOIthA4BB+x0NFi3gf76XdKHl/CRpvMXEYjNwpO1Q/r35puh4I0++IDDFnDLl6Vq
	 8yLqFKoIf4QGAPqtfHqbM1Xi6vDWp4wipvWu1fmRpcSTPzbuWBrAEF0s9TXNqG+HgK
	 onOOqIBG0XMGGuLF17WJgI5G8UV9pv7MElzgD8Ssp5QGj+rJReqlt3scNsz7I76s2/
	 6oEpnD0KR7TPaXIYiEzxktYcTjPIBQRQfZWf3hbIwINFbXd3FprEWHkWFU/pfc7rCB
	 M5uJRdbvfn6+w==
Date: Tue, 16 Dec 2025 15:23:35 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH perf-next 0/4] glibc str functions const return fixes
Message-ID: <aUGjp4GOtTUE-7nG@x1>
References: <20251211221756.96294-1-acme@kernel.org>
 <CAP-5=fUaGbbd4z6RcdsV86w=Tta6-s4GikuwJZjFDFjnTQzjwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUaGbbd4z6RcdsV86w=Tta6-s4GikuwJZjFDFjnTQzjwA@mail.gmail.com>

On Thu, Dec 11, 2025 at 09:23:33PM -0800, Ian Rogers wrote:
> On Thu, Dec 11, 2025 at 2:18 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> >         While building with Fedora 44 I noticed so interesting warnings
> > about touching const memory, fix some of them in this series,
 
> For the series:
 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo
