Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF9437E;
	Tue, 13 Aug 2024 18:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723572662; cv=none; b=AKksLoZpGGsuRIUEVbt4xA96pLX9asieQKdlITXjEcIvPskyccum3acWOQjG7c9MJCZMGyr4j9zf8MDGI09KI5NTFfL8MlJjTtQf3z9BM7Rb6o84GEh2/t1bBfEYXyOqmJpk2gw8Moy576W4eqLRDTC1M1EfyMzb2wvui/oZyI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723572662; c=relaxed/simple;
	bh=NESDk1hBrlDDjEoFAGg7Zo88DWS8q93HbtxAe268zkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8YwCIOzGmCzhqu8TBH3BYJLEYTMAtZhgVlqYwvoL9Z98ppJJQzvTFoP2yr2ENliDENHO14yXpRHJsG6QbibBpBdhMI2RcAq9GN7b/ZzFX6OLf76gmYeP3ug/L5qAC9CTHL+6ImQ/HpvZya7CRzjCRP7DnFKO2w348T7c8YeAqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBIB4WY8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBIB4WY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F9DC32782;
	Tue, 13 Aug 2024 18:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723572661;
	bh=NESDk1hBrlDDjEoFAGg7Zo88DWS8q93HbtxAe268zkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OBIB4WY8l9mm9MD14+GmXXtCw4+38Zb/jNtFHaT8yUptAzaMZrtvU8gNxOnwnkQQJ
	 cSP3SreptKwUyQvr+Z2IT6aC7OXQlYPRZSan2PrVL2Fo3kEKnhq1SoNEWjfKEoVnN5
	 X8qUtoQg1n3PURyQb4oOET0n5HekkGC7kjyAXgMImxsVRLqqXdDhTFT9NRrXlSR3+z
	 R2jc2cHctqkNUo9/LmY+SbktaP8Sif+xAdvSbSYrg7vddQyy+JyHN0x7YGKtYY+JQI
	 PV+L6CHw0Bqwab2rdqaSrC6O1jHBdwDIbhkHVW6hxiWvvzs3Ey0YBIJDcm9wrC0nQK
	 EyxDu8IQ1GyWg==
Date: Tue, 13 Aug 2024 15:10:56 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf disasm: Fix memory leak for locked operations
Message-ID: <ZruhsN4i6xtc59nJ@x1>
References: <20240813040613.882075-1-irogers@google.com>
 <ZrtzTTHim_vGX1ma@x1>
 <CAP-5=fUA8T9B2RvXg-Hpj_fHXmwB18ah6Krm3qm5ULH-M04Lqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUA8T9B2RvXg-Hpj_fHXmwB18ah6Krm3qm5ULH-M04Lqw@mail.gmail.com>

On Tue, Aug 13, 2024 at 09:04:57AM -0700, Ian Rogers wrote:
> On Tue, Aug 13, 2024 at 7:53 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, Aug 12, 2024 at 09:06:12PM -0700, Ian Rogers wrote:
> > > lock__parse calls disasm_line__parse passing
> > > &ops->locked.ins.name. Ensure ops->locked.ins.name is freed in
> > > lock__delete.
> > >
> > > Found with lock/leak sanitizer.
> 
> Ooops, I meant address/leak sanitizer.
> 
> > Applied both patches to perf-tools-next.
> 
> Thanks, could you fix the commit message.

Sure,

- Arnaldo
