Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A98296BA7;
	Fri, 23 Jan 2026 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769189207; cv=none; b=LOEMlebjkY5qE6eyIBqFQwOE08lyAddg84EZvbmXxa6Q4QIpThzwVWmme2NkfL+RNm+qgAldx2VTcBV1T8d6xIrX2ce94MnMHCvP/6hQvbcL/cM8kKKCDYHTymGFCzIppLMsxU5UO9wfC2YjyiPRwKapg99NDFlbUVdE1oTb5Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769189207; c=relaxed/simple;
	bh=KUM5zgI3iLOooxwOeFYviUsiRkSJ1o+njGTKRMK0wRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYWzy2fg/6HLCHCku6M+i0VBPfVwgNz84G8SY6N7elOCra+GnPJ2dpNmGLpyaXD1Qjqqh0QELTqGuBX4OlcObP11yb75HjPs6JUcyxpsX7hYNYea852MdmUPfQ6YGceFtlq7BcKMEpLV3/ZRKKOViawGj7w1IKCdSfB28Af71Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiVgUXA5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiVgUXA5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD177C19421;
	Fri, 23 Jan 2026 17:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769189207;
	bh=KUM5zgI3iLOooxwOeFYviUsiRkSJ1o+njGTKRMK0wRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JiVgUXA5afw8W9nkn8raUFco7fAfN2qrgvwUEKdQQXlGMFE+nYbuq+/VFfebTpbA6
	 iC6C5SOZh8DVMjfUiqTHeVecWRAdPuWFp1k/iw0QiVw2Pzo9YLomIZLF4GntqWeStE
	 R3XpwA5+oJKvbOqZpNDqYajLj20xqxLbmXqEqQ70tx1RppbeZyEvcLDxuq0+C6JMpc
	 1i5b5dFx+6liKZDV1pNZugnBtD6RqjvlmV7r1tbuysicqmKkwtHgcpFRh/TcL+bZIN
	 liQh+/AoikHG+NO8E/mVYJEivPnBvyhT63/xnIkMppqFt9e1jlj//Qaj23zfhvFrAw
	 VReJL/Dq69a4w==
Date: Fri, 23 Jan 2026 14:26:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Suchit Karunakaran <suchitkarunakaran@gmail.com>, mingo@redhat.com,
	namhyung@kernel.org, peterz@infradead.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, james.clark@linaro.org,
	jolsa@kernel.org, mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf annotate: Fix memcpy size in arch__grow_instructions
Message-ID: <aXOvUzI56ePokDd_@x1>
References: <20260122171704.142218-1-suchitkarunakaran@gmail.com>
 <CAP-5=fVOeYCU_6ukDi_3g=H=K5HXoN+UjcNCysEbCO3LAY3ukw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVOeYCU_6ukDi_3g=H=K5HXoN+UjcNCysEbCO3LAY3ukw@mail.gmail.com>

On Thu, Jan 22, 2026 at 10:27:27AM -0800, Ian Rogers wrote:
> On Thu, Jan 22, 2026 at 9:17 AM Suchit Karunakaran <suchitkarunakaran@gmail.com> wrote:

> > The memcpy in arch__grow_instructions() is copying the wrong number of
> > bytes when growing from a non-allocated table. It should copy
> > arch->nr_instructions * sizeof(struct ins) bytes, not just
> > arch->nr_instructions bytes.

> > This bug causes data corruption as only a partial copy of the
> > instruction table is made, leading to garbage data in most entries and
> > potential crashes

> > Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> > ---
> >  tools/perf/util/disasm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> > index 50b9433f3f8e..6faa9df8e373 100644
> > --- a/tools/perf/util/disasm.c
> > +++ b/tools/perf/util/disasm.c
> > @@ -81,7 +81,7 @@ static int arch__grow_instructions(struct arch *arch)
> >         if (new_instructions == NULL)
> >                 return -1;

> > -       memcpy(new_instructions, arch->instructions, arch->nr_instructions);
> > +       memcpy(new_instructions, arch->instructions, arch->nr_instructions * sizeof(struct ins));

> Reviewed-by: Ian Rogers <irogers@google.com>

> Nice catch! I think we've been trying to make code like this more like:
> memcpy(new_instructions, arch->instructions, arch->nr_instructions *
> sizeof(*new_instructions));
> but the immediately preceding calloc isn't doing this, so your patch
> is consistent. There is also a clean up in this code to switch to
> using reallocarray rather than realloc.

Right, that would be better, but the fix is good as is and we can
cleanup it later.

I added the missing:

Fixes: 2a1ff812c40be982 ("perf annotate: Introduce alternative method of keeping instructions table")

Its an old bug I introduced almost 10 years ago ;-\

- Arnaldo
