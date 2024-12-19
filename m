Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5957082B;
	Thu, 19 Dec 2024 05:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734586166; cv=none; b=fDQB3LfnmWBvFIiOamzEKgm1+MJ2DnGeuTPyVFLTD+e4m92rljgFtTqPRh/EtWTPbFOdJzQ3wf0ixK64cLo9gmwnh1X1XSnWMJDL0kZYymoBwSoc7evMGuf9ftebBVcuU80o/2whG1OgZGv84XpUwo5g2OVz2iXzyWsTj9Lve0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734586166; c=relaxed/simple;
	bh=Byt/LqFSDMp2dnBSJKL6RN4retcQZK1jGabKgh2I8f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBby2pZJx+a8XVi1G/EDsrl6Kro/esVszr+FRfCI4LGhwNMct4KIkUzpLgeGTKlfiIx6dj7+MZ6CdnBd+UX/a4vRaEtYltRCRstIgqQP2GvgylFC34+la725YQCtJFgXo/sWzS8bLgq/0i2MxdkC5vdSGPG71vM2MlK6MkUCBdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/+UW3IE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/+UW3IE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFDDC4CECE;
	Thu, 19 Dec 2024 05:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734586165;
	bh=Byt/LqFSDMp2dnBSJKL6RN4retcQZK1jGabKgh2I8f0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/+UW3IEZTQ/YNa1ckliSZItOoUyLjukg6yq93v7gFxlLV/zJLeJcFf8ybXPlIZ3A
	 WgXUjIFiqoU8jM+MjXMheUNyi/jzpLeQWbFzufrCRsPNeyUJEJpI+6S8T/6xjeORhc
	 +wMDbFq0lYP8bva36rZ6EbnML7ESIbxU0BbPye3IRRP2m2THAu9SnhVWE4rm++M8yT
	 N3bTdM1Ai/49A6jzVlrZtlpaClU1I6qGEwMRN4+9MXqWJ63fEsH9pNfdm5lkA/EIqe
	 xNVNRy9aT42WiJYRjRpPhO8CqW+yf09kT6lqZAkRA+gZIqaYSwRQYnJL6z0xw3wM3c
	 AxGrI7dtryvSg==
Date: Wed, 18 Dec 2024 21:29:23 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Yanteng Si <siyanteng@loongson.cn>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] perf synthetic-events: Ensure features are aligned
Message-ID: <Z2OvM2YkFd1zoDot@google.com>
References: <20241216232459.427642-1-irogers@google.com>
 <20241216232459.427642-4-irogers@google.com>
 <Z2NyAxRzKaIw2qaB@google.com>
 <CAP-5=fX9+jbZo4qd4JDY=tHNJM_hD+pn2B_0ytf0_6A78XeMaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX9+jbZo4qd4JDY=tHNJM_hD+pn2B_0ytf0_6A78XeMaQ@mail.gmail.com>

On Wed, Dec 18, 2024 at 05:29:01PM -0800, Ian Rogers wrote:
> On Wed, Dec 18, 2024 at 5:08 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, Dec 16, 2024 at 03:24:57PM -0800, Ian Rogers wrote:
> > > Features like hostname have arbitrary size and break the assumed
> > > 8-byte alignment of perf events. Pad all feature events until 8-byte
> > > alignment is restored.
> >
> > But it seems write_hostname() and others use do_write_string() which
> > handles the padding already.
> 
> Well it does something :-) (I agree my description isn't 100%)
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/header.c?h=perf-tools-next#n188
> ```
> static int do_write_string(struct feat_fd *ff, const char *str)
> {
> u32 len, olen;
> int ret;
> 
> olen = strlen(str) + 1;
> len = PERF_ALIGN(olen, NAME_ALIGN);
> 
> /* write len, incl. \0 */
> ret = do_write(ff, &len, sizeof(len));
> if (ret < 0)
> return ret;
> 
> return write_padded(ff, str, olen, len);
> }
> ```
> but NAME_ALIGN is 64:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/header.h?h=perf-tools-next#n187
> whereas the data file is expecting things aligned to sizeof(u64) which
> is 8-bytes. We're potentially writing out 7 u64s worth of 0s for no
> alignment gain. It should be safe, given I don't see other use of this
> alignment value, to switch the string alignment to being sizeof(u64)
> but following this change we could also just get rid of the padding
> knowing it will be fixed in the caller.

Probably, but it seems simpler just to change NAME_ALIGN to 8. :)

Thanks,
Namhyung

