Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DEB38DD3;
	Sat, 11 May 2024 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715442765; cv=none; b=RRl5eAuHgyJJ2AHjQtPugD1DQ3VLEq3FthF2f3KZMM9eiBy1wqaYcTcsUm3jJOyZdAnJ2LtYrJ517e44tOM7FYHLmjym9+NHFrkTQaW/AvM7oS6s8Ups/vw3UOk+YO2QxR5YZdo9mv1Hf/25c2HYsIDbwet9I8sLRG3hspXSuv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715442765; c=relaxed/simple;
	bh=I0ll1PT06G3pFgzR9h6/T/HxLGGQr8T4pG8CPzC9UV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUN3evVF09PgMhnbD09fnuQwJV78+urz3w40SDwosc3YpfBCmo38iSkkhr4hnS0cKviKvXbL5r3r7QcU+NZ4k/ZvLrLXS2WrXZZjvR4NQqczFgScT38stI4wYJNICtWU6xB4rc5khWkeeyVGTOMlv60zZ1UVqHg12ZMqSm5c7nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lE8dwaKU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lE8dwaKU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF47C2BBFC;
	Sat, 11 May 2024 15:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715442765;
	bh=I0ll1PT06G3pFgzR9h6/T/HxLGGQr8T4pG8CPzC9UV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lE8dwaKU6Nqbu5AEHC35mmB2RCIzmhM/2rLRy4HPELOyeaXqgD7vhpwRkKRDq6FWc
	 X+sM7SKPzcgmdEvhusUd9zbr8F69KNk3/Q9wEHIx0R+Te3BvUGSXuYkP5O14GRFbC4
	 QDTbdYCE/zT1QOGsTavq2aLCVHza2hA22F6LFC2G0c7KT7/sZYg/+EMBqWGdLiflGm
	 cSWuHDy2wCeeU/+5oAXzI2Dz6kIaWEIi0evD1xHJHbRGUseJNcpP/UbDvwHdIBoYpt
	 FI6MsmJ5AP300Z2Z0qJliZfLJkzR0dL7PkApXBJhXLDTy3kUoMK3nt5aQSTkYk2Vkf
	 w6EMDPE/+GMaA==
Date: Sat, 11 May 2024 12:52:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Justin He <Justin.He@arm.com>, John Garry <john.g.garry@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <James.Clark@arm.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	nd <nd@arm.com>
Subject: Re: [PATCH 2/2] perf pmu: Fix num_events calculation
Message-ID: <Zj-USRLJIGIvj7iE@x1>
References: <20240510024729.1075732-1-justin.he@arm.com>
 <20240510024729.1075732-3-justin.he@arm.com>
 <CAP-5=fVGD-pK1igABj0wiq6-KVM+Z4i7rnRhM=Vy7bFHW4pLQA@mail.gmail.com>
 <DBBPR08MB4538A157B81F2BBD2DD9E40DF7E72@DBBPR08MB4538.eurprd08.prod.outlook.com>
 <CAP-5=fWgGOWi_YedpQgdK2DnBvtRk-79GEhKMsTehcfOVtxLNA@mail.gmail.com>
 <CAP-5=fULL0KNWA_O0B3r4Q0DA2_FMk=rARhb=z8ySKzFyVwFyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fULL0KNWA_O0B3r4Q0DA2_FMk=rARhb=z8ySKzFyVwFyw@mail.gmail.com>

On Fri, May 10, 2024 at 05:50:29PM -0700, Ian Rogers wrote:
> On Fri, May 10, 2024 at 1:41 PM Ian Rogers <irogers@google.com> wrote:
> > As such the fix here is incomplete. There may be both sys json events
> > (detected by PMU/id name) and CPU json events (detected by CPUID). I'm
> > looking into a fix.
> 
> Patch sent:
> https://lore.kernel.org/lkml/20240511003601.2666907-1-irogers@google.com/

I applied the patch to tmp.perf-tools-next, will go to perf-tools-next
soon, would be good for Justin to test and provide a Tested-by.

- Arnaldo
