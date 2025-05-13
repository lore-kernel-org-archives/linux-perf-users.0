Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513F81E411C;
	Tue, 13 May 2025 21:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747170977; cv=none; b=bIHzhWQnwWJ+q9CVE+fiHaWLInU4jvIWiarXZ22bx0BqZqaF73JhX2wp/kZ4GU+seTWjgyBYL4QYPWLOg/PiDeVkoUxXgCfsBjJte9w4qOKqS+DM4wTiHXltsVk4y51dB4q04MJEleuk2W+wXkqrKzihsDUJnRZpKsXHPMsHE1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747170977; c=relaxed/simple;
	bh=OCH0BK06VVN2yYB9rxyYp8AqflFZbhIBbYHXqwJAYkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELMFxNK+WvI2mAQdIGpJI49exZIFilgcoyU16fkkcRVB8Sx3fScB4P/UXFJD99Paxm0eIHicHerr4n1sfIhNC4j7BFO8BTZLWCDKI2KnzqZN7CuoM/1fXG7hCLPdEbLJsPF2cbcIbvu5jV/ctVmD0V3uy9b06+34aU7mbkZxT40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQExqIcT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQExqIcT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB69C4CEE4;
	Tue, 13 May 2025 21:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747170975;
	bh=OCH0BK06VVN2yYB9rxyYp8AqflFZbhIBbYHXqwJAYkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uQExqIcTyLk20XIz0CwOmttvO7SteTg0twIdi7fYXK/qUZCkLKBBXaD9czS/zuG5L
	 PnSQr7iBf6ivahVWcQeSdlSDCYf3tiMteab+GiaWtGntcIwiW87A3teHjWwHPjNZ1l
	 uwLeln0T9+WGgt3qyUPO5K4QfjaedOsqaqAtiJix/B/4TzuigelFCzcVnv4Z3oo5+j
	 coe9D4OrsgBKGjFNvbactB7O3/lvNxKQ/23p1iiu3Jt5mf8QOi007iqRKIMdug55YB
	 vFxMWU9JsYU3KuUTMndkEME+eJaTkY5yRtcLsTIrxAs7kklnBa25yAb7D3WyDtIsnP
	 Sy5HOGk5hOhMA==
Date: Tue, 13 May 2025 18:16:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Gautam Menghani <gautam@linux.ibm.com>, namhyung@kernel.org,
	peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	maddy@linux.ibm.com
Subject: Re: [PATCH v2 4/4] perf python: Add counting.py as example for
 counting perf events
Message-ID: <aCO2nJG8i3S6vUid@x1>
References: <20250512055748.479786-1-gautam@linux.ibm.com>
 <20250512055748.479786-5-gautam@linux.ibm.com>
 <CAP-5=fWb-=hCYmpg7U5N9C94EucQGTOS7YwR2-fo4ptOexzxyg@mail.gmail.com>
 <aCI0oDBSz86S9fz-@x1>
 <CAP-5=fVYXRzQjRzcDX0aJv5yg3bwDO+PWHfP-Laig0s3cnzcaQ@mail.gmail.com>
 <aCOwnUUVKx798Uza@x1>
 <CAP-5=fXK9Jru+ZqeTSuaTmOTmpF3JDHDswUOcmdOyLSP1Go_Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXK9Jru+ZqeTSuaTmOTmpF3JDHDswUOcmdOyLSP1Go_Gg@mail.gmail.com>

On Tue, May 13, 2025 at 01:59:28PM -0700, Ian Rogers wrote:
> On Tue, May 13, 2025 at 1:50 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> [snip]
> > Right, I like the effort he is making into having perf more usable in
> > python, and I encourage him to think about the issues you raised so that
> > we can come to some good abstractions.
> 
> Thanks Arnaldo, can we be tolerant to API changes in the python from a
> "regression" point-of-view? Like avoiding the notion of indices?

But correct me if I am missing something, aren't indices only introduced
with this new patchset?

- Arnaldo

> Presumably such a fix would also need fixing in all the perf python
> scripts, but the external users I worry about. My sense is the number
> of external users is minimal, for example, toplev I don't believe is a
> user [1].
> 
> Ian
> 
> [1] https://github.com/andikleen/pmu-tools
