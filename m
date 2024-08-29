Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BAB1A0732;
	Thu, 29 Aug 2024 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945495; cv=none; b=a7JLSH7IIyIM/eypRqHMoEsiEauGERFqRIa8iphI2J25/ntPUoV2g66gFJNxbzL4BCOh5abr6fEW7Of+NtGX5qFqHDz+NzbULUOgaP+SqBLghZegQEtZKta7U2y96LNRQE03u+m6lTaruwk4C98Iy8SavqRWILoedxCdonSvfFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945495; c=relaxed/simple;
	bh=ZPbu71g6dfyWDg4bm9S3SHHiwmbci3SUkSp1SD6E/uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ube27OQX4VN7V/fJ8N4VSw9E8kvUXISN0oVYuOSOv0smTSz0EEf7NFjTdxwkWsdlNm9D8gHqymo+PfbjWIvuwXL/0q1s86odRpFdeVkzT5isTOhEjb4GTwAGs6ycA5xv/KX8CIMdqxW6qEwBGZufrwLM/8KWa0QnKsGaZk7ILlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJV7h05Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJV7h05Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB53C4CEC3;
	Thu, 29 Aug 2024 15:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724945494;
	bh=ZPbu71g6dfyWDg4bm9S3SHHiwmbci3SUkSp1SD6E/uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJV7h05QFFQ2FjRmLz6759wZoaRcQiPfN1WwrG7adnANoJydNYw3y5R9f7CWClr/Z
	 r4GeWzQMyRnR7IUMKlwrpELLlbm7FKhGeZZCYuuRhN7XH/Z3Yx17d27YWbQzmz/hlj
	 bxV9CRtHP9halhZ2y9tmSA4J4/ZCq9nahd7BJFPGeXQvcWoUClML6+olkAjzP7zSMl
	 HGVbIhcc82oa6zDRio3OGtj5MUcoH9nYCh2Tkbxuu6T+87h58M8MPEQv2BUvKHctwK
	 /blxw1QwUtzoaRaVOTnvYKKTZ8T55mB/rMxTtENMMAeZAXvxYX1Ff+5y/lycDyfxO0
	 fWIUfbY52c7JA==
Date: Thu, 29 Aug 2024 12:31:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: coresight@lists.linaro.org, gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org, leo.yan@linux.dev, anshuman.khandual@arm.com,
	James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-perf-users@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH v6 00/17] coresight: Use per-sink trace ID maps for Perf
 sessions
Message-ID: <ZtCUUsJNj9Z1CRLK@x1>
References: <20240722101202.26915-1-james.clark@linaro.org>
 <ZqOwGWcYosGe9ru4@x1>
 <6476a228-847b-4804-9229-c11a881663c7@arm.com>
 <ZqOzio8Oco9ZFsDm@x1>
 <8068c8ff-a8ce-4bcd-bb19-2c25b45cf6f3@arm.com>
 <ZqO3gPcCCVh1r5WM@x1>
 <aab886f3-ebbf-4853-b26b-5cf70c801683@arm.com>
 <7b96894c-f5df-473b-be50-ee118ce3cfaf@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b96894c-f5df-473b-be50-ee118ce3cfaf@linaro.org>

On Thu, Aug 29, 2024 at 10:05:02AM +0100, James Clark wrote:
> 
> 
> On 22/08/2024 3:35 pm, Suzuki K Poulose wrote:
> > Hi Arnaldo,
> > 
> > On 26/07/2024 15:49, Arnaldo Carvalho de Melo wrote:
> > > On Fri, Jul 26, 2024 at 03:38:13PM +0100, Suzuki K Poulose wrote:
> > > > On 26/07/2024 15:32, Arnaldo Carvalho de Melo wrote:
> > > > > On Fri, Jul 26, 2024 at 03:26:04PM +0100, Suzuki K Poulose wrote:
> > > > > > On 26/07/2024 15:18, Arnaldo Carvalho de Melo wrote:
> > > > > > > On Mon, Jul 22, 2024 at 11:11:42AM +0100, James Clark wrote:
> > > > > > > > This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
> > > > > > > > as long as there are fewer than that many ETMs
> > > > > > > > connected to each sink.
> > > > > > > 
> > > > > > > Hey, may I take the tools part, i.e. patches 0-7 and
> > > > > > > someone on the ARM
> > > > > > > kernel team pick the driver bits?
> > > 
> > > > > > I plan to pick the kernel driver bits for v6.12
> > > 
> > > > > Perhaps it is better for me to wait for that?
> > > 
> > > > Yes, please.
> > > 
> > > Please let me know when you do so so that I can merge the tooling bits.
> > 
> > I have now merged the driver changes to coresight/next, they will be
> > sent to Greg for v6.12. [0]
> > 
> > You may go ahead and merge the tool bits.

I'm taking this as an Acked-by: Suzuki, ok?

> > Thanks
> > Suzuki
> > 
> > [0] https://lkml.kernel.org/r/172433479466.350842.6920589600831615538.b4-ty@arm.com
> > 
> > 
> > > 
> > > Thanks,
> > > 
> > > - Arnaldo
> > 
> 
> Hi Arnaldo,
> 
> I just checked and the tool patches still apply cleanly if you're able to
> take them.

Sure.

- Arnaldo
