Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A789B126C0B;
	Mon, 23 Sep 2024 23:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727133865; cv=none; b=qEG+ji5WZD8HzgjM7LlaQ62rgM+9eD4DDSbBFZuNinX4/0mYa+Rz3z7dBCZR3dxylyfAVNebOLb/2T0CYIVDt39cQyzkGhzsGxi9zhqshTBd9Uq8dJmyA0MRNEcU9ra/alTFfZcQae5ku6cLmAgDGSYJZD6mYaCKE6uys/EhFbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727133865; c=relaxed/simple;
	bh=xqoBbplvjPRcsVlMbF7LhtzVncwZc2z3Zp6SRaDXdA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYNToP4kTkzwcCVzmSDqPb1YBm2QSB/kV4zp0K3qNfImoxuZmlN9ocOqUUAnbx7HujsQhpq+HscavIlTKXtzgN9SOIdbf2Vlvvxgmcw4WVWZ9S6MyJlt6Pp/w2vkY+SrBvgTeFotpob/rXLwYyGdBL7vkuBIPQqT25fy/csKr1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qoMlwrAx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qoMlwrAx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0237C4CEC4;
	Mon, 23 Sep 2024 23:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727133865;
	bh=xqoBbplvjPRcsVlMbF7LhtzVncwZc2z3Zp6SRaDXdA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qoMlwrAx177GfLAlzPBCQJmP9TN5JIKdQasLiXeXQi4pdkiEwve4t5KhKBxvmaMBE
	 WLP08GNLnCDm33KvRg9dMwa/ExYYbILQiGasGA2ff2sxRKxK58OaKLZK9hBISld5kr
	 q5nRk/O8N+ME1/Mq6Gyd5mDqw95Z/qBB06idysuCQZ37W9MTonOCVpkRTfvTkypcSz
	 nkcSEShFv8SMYAbZ4gBtlKU+/kX30Ww+UYOePrcWgWE5NRlAYPQkUsMuViwgtf3FO9
	 WTJqMD3qAT+MzHq/TjG1ZtNlnV5EMCBqFsYxEGHqNJt5orQXfY15fJAd29FogqiAHO
	 OSokHPT++a5mQ==
Date: Mon, 23 Sep 2024 16:24:23 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf vdso: Missed put on 32-bit dsos
Message-ID: <ZvH4p3-kdnZfij_4@google.com>
References: <20240912182757.762369-1-irogers@google.com>
 <ZuM9zc71XXXZ3eRZ@x1>
 <CAP-5=fUCVa3VoByKUFDp8Q+M2ZOTdy7ccL7Ter8E8dSE368KAA@mail.gmail.com>
 <CAP-5=fX9FO70B2Z4jp50owX-Lr3sAuECje+0s13tc9C9s1v+jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX9FO70B2Z4jp50owX-Lr3sAuECje+0s13tc9C9s1v+jw@mail.gmail.com>

On Mon, Sep 23, 2024 at 12:01:23PM -0700, Ian Rogers wrote:
> On Thu, Sep 12, 2024 at 12:31 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Thu, Sep 12, 2024 at 12:15 PM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Thu, Sep 12, 2024 at 11:27:57AM -0700, Ian Rogers wrote:
> > > > If the dso type doesn't match then NULL is returned but the dso should
> > > > be put first.
> > >
> > > I guess we can add:
> > >
> > > Fixes: f649ed80f3cabbf1 ("perf dsos: Tidy reference counting and locking")
> > >
> > > ?
> >
> > Yep, that's the one that added the reference count increment.
> 
> Noticed this isn't in the tree yet, do I need to resend for the fixes tag?

Arnaldo, can you please pick this up to perf-tools?

Thanks,
Namhyung

