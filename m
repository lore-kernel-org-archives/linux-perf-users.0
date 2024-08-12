Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E9F183CD4;
	Mon, 12 Aug 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480521; cv=none; b=LTCgqEH/zEKqj29lnHgqKJfmuOdHeY9BUwDFW1sf+IWgi7SJdOOzvAwewrdd3tGekceKOpFYBnPA8tCyw3eBpdybmIoXP/UPC0gH6i+B7sG4h3Y89pZlvI21BTcg6lj20ge71+8px+3af+KljAnoavXWSvK0A3VTnYTZdWTW6ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480521; c=relaxed/simple;
	bh=NyaFbORqzBAgAvTSW78fZAxNKl09IffJ6EdbJBvboGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mj9j0sUpVnu6LfMvTuZiEIyouAZ0HtOW84its2J0A/Y8/RUjzthJG9jHG+0Hjl54roxcJnZZIRZ07gGEouZqZDKAWCoxM9xgqnbpph+Sd4B4/+EfugS7wu+uXQLkK9jrkIBi5EdWQD7CdmBcfW0Ld/dAjKn3c/U7RCkMVtBK9Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgguJnHC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgguJnHC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79C3C4AF09;
	Mon, 12 Aug 2024 16:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723480521;
	bh=NyaFbORqzBAgAvTSW78fZAxNKl09IffJ6EdbJBvboGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgguJnHCBzfOgFebel30g7EN9MC98XxSFL0XgMv/QMWoW2hXKpfZZxmORLPytvxLj
	 BjP6/mqKSult1mWTckknrbBAZe8xf9LLlwb7i++cKtApIrF2GL1PImO1dkD4FagvdG
	 b602whZfKBVlIFiWoslnpgiZUhsWEX8PxBmyPCYVWE0c1Ti1KHc6hOF2A50cUEogU9
	 zKq7JnyU28psmj8//rBG0+qEkEjVOtaAQ+Wysxnojnb0jVhL6Ggs/OwJE0AHWN7NON
	 iZc4TMrTGudWxsmnK1WVXFKReCpUExY+wGTIvIyD6yDSSsAd6mXDeZ5bdQryFXNh7/
	 4Uczcz3skP1jQ==
Date: Mon, 12 Aug 2024 13:35:18 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, weilin.wang@intel.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v18 0/8] TPEBS counting mode support
Message-ID: <Zro5xt05JaqJvQZe@x1>
References: <20240720062102.444578-1-weilin.wang@intel.com>
 <CAM9d7cgoTyf3Zjt=+2yZi5Pat4UrxKxN=rkLHmyUWZqwZk8_Kw@mail.gmail.com>
 <CAP-5=fWr2Qna9ikzUCFavo3OTUDSP3ztr=i6E=R962CXCdHckg@mail.gmail.com>
 <ZrEpJxtm5zlp5rbo@x1>
 <CAP-5=fVTaHdiF8G2Dn=vnguvoapa_+ZKsQ7Wy3z51K9nDZQUtg@mail.gmail.com>
 <ZrIl8NCHkIVHQVt2@x1>
 <CAP-5=fUVcBw4GBT8tcOWS1MV1C6zbfbovon1pCqk7gmfMN=J_Q@mail.gmail.com>
 <CAP-5=fXtDeddhfB8UQcjSAoWPSMo=ve1Xfr2-2K7L1LsMOQenQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXtDeddhfB8UQcjSAoWPSMo=ve1Xfr2-2K7L1LsMOQenQ@mail.gmail.com>

On Mon, Aug 12, 2024 at 08:38:06AM -0700, Ian Rogers wrote:
> On Tue, Aug 6, 2024 at 7:35 AM Ian Rogers <irogers@google.com> wrote:
> > On Tue, Aug 6, 2024 at 6:32 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > For now I'm removing the whole series from perf-tools-next.
> >
> > Ugh.
> 
> Hi, what's the plan here? The topdown (aka TMA) metrics on recent
> Intel CPUs (client and server) are dependent on timed PEBS. I think we
> should land this series and move forward from there.

I'm taking this as an Acked-by, merged the 3rd and 4th patches to keep
bisectability and constified the process_sample_event() perf_tool
pointer, test building with containers now.

Will push to tmp.perf-tools-next while that runs.

- Arnaldo
