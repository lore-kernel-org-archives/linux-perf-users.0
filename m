Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FCE1E25EB;
	Tue,  7 Jan 2025 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736279793; cv=none; b=bxVwfF0OamP8CtgNLQxuxhpzHFvfsaDT0d2wQVjoTrw5PcCOZLt6Ic7x0qk56BGgbXYG0rf5lqauVKOKKhK/qwNVYMG8YMOb/iJlGcjRaIZnBXOvypd0ZsjLmlUNEaxTg9eA+KRWa1q2ZqKEbTQbFkHeFszBSI0ELmHNjOpDlcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736279793; c=relaxed/simple;
	bh=5qCKAtSNPo7Tn9P35RFYyu+WsKIktZtGuzdfhG5wKSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMZFL74/qL8m6ycPN6adNUfbk3fd/O2fmU9+gWp8QKg2f1kurG0d2+1mTLuXnAiIgMdEwh37LfunYSo6bZYTHl/W6CIz4Zasqzfk1amb9bHcmoo5QwW6dmxOZ9y7RW2xFL0p2IONLNAivNqKnZQBWzHN440Gvbg0htD1nn53xIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBYE34tt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBYE34tt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B61C4CED6;
	Tue,  7 Jan 2025 19:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736279793;
	bh=5qCKAtSNPo7Tn9P35RFYyu+WsKIktZtGuzdfhG5wKSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FBYE34ttzTFcCB0cnW2CkoNiulzSbZwy1fVoMc2bsOTlbsK+r7+dblJO9PSfC3v0K
	 ELnH7tnLJnsmkPfayDnx/tVmO/RwwTGIfKOeDvZB6wendx/SUf+NrFoMnhlCjK/ciQ
	 PMroXa6uqCN2NDG7ecyLNMuts+7Mb3wqaOXE+t4pP4iJ7syNDngOcNdjMAKOmuvi1R
	 on+Vz37Geomf0V3BQ908IztGPMZPLjZIq9yk5z/EhqZytXPymSqf+gciP4OD3ddKFK
	 Dbb2pv1bIhkamtoYoPEyn7HYiNVB4d3nOJIYsZkkIsBMh+Wd/TsJoDR6oCl8sCMPhT
	 yzHLD2ZZUTFQA==
Date: Tue, 7 Jan 2025 16:56:29 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Edward Baker <edward.baker@intel.com>,
	Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH v1 00/22] Intel vendor events and TMA 5.01 metrics
Message-ID: <Z32G7cNV3hZ2bZHT@x1>
References: <20241209222800.296000-1-irogers@google.com>
 <CAP-5=fWr9R74-NbKbW96otG6KitQYaQng4D40Bv4z9ov9yvNJA@mail.gmail.com>
 <Z1iQhL4WXFL4Wf27@x1>
 <2ae362c8-b8f4-453e-9c92-a25ad989ffe4@linux.intel.com>
 <CAP-5=fUTXzZfRqre0Vai_5pxue_mAvb9oh-Ea9Sgr7U=Lrm_Nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUTXzZfRqre0Vai_5pxue_mAvb9oh-Ea9Sgr7U=Lrm_Nw@mail.gmail.com>

On Mon, Jan 06, 2025 at 09:16:56AM -0800, Ian Rogers wrote:
> On Wed, Dec 11, 2024 at 8:24 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> > On 2024-12-10 2:03 p.m., Arnaldo Carvalho de Melo wrote:
> > >> I should have also said, this series requires:
> > >> https://lore.kernel.org/all/20241113165558.628856-1-irogers@google.com/

Checking that this is in...

> > > Applying that one now to perf-tools-next,

> > > Kan, can I have your Acked-by or Reviewed-by?

> > Sure.

> > Acked-by: Kan Liang <kan.liang@linux.intel.com>
 
> Happy new year and thanks Kan! Arnaldo, Namhyung please let me know if
> there is anything more necessary for this series. I don't believe it
> needs a rebase.

So, the Co-authored-by: tag was used and it is not documented in
Documentation/process/submitting-patches.rst, I think the right tag her
is "Co-developed-by:", and there are some rules about its usage, from
that doc:

---------------------------------- 8< ------------------------------

Co-developed-by: states that the patch was co-created by multiple developers;
it is used to give attribution to co-authors (in addition to the author
attributed by the From: tag) when several people work on a single patch.  Since
Co-developed-by: denotes authorship, every Co-developed-by: must be immediately
followed by a Signed-off-by: of the associated co-author.  Standard sign-off
procedure applies, i.e. the ordering of Signed-off-by: tags should reflect the
chronological history of the patch insofar as possible, regardless of whether
the author is attributed via From: or Co-developed-by:.  Notably, the last
Signed-off-by: must always be that of the developer submitting the patch.

---------------------------------- 8< ------------------------------

I'm taking the liberty to make these changes locally, please Ack these
changes by replying to this message, ok?

- Arnaldo
