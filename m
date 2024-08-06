Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC221D2797;
	Tue,  6 Aug 2024 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951487; cv=none; b=aftMTiwwJMb1YOw0S5qtWHj/VvrHMoY189XQ9VYRPn7vhRdM45jg72UtKdzSfU48vO9lFGW93poX0lNbhyu6uqwteSovE8I8h2UAljb12P8tmVuVfxumkha5TeQftGWbBx6BtXvZvmOl11Ud78euaTp675lpCNo3hBGkBZqhlXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951487; c=relaxed/simple;
	bh=IUsHVXl6vrsJ/SUxWscVy8OdmVYWDM4EQy6CniwnHGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4ap1C37yHjvsmk0TLsEGMonJbFjYnE1MjXX4wMJZP4yrOY+kued2RAcFkIID09jHb8hVIkczJC5R1iY8jvMEMeVOBWUmQBShxjSshCeppb0XvBq0eAOHDoUlmma9UvG8tJ5KRhmC1V9FFy0/xnoCOsNwBd2aqTQc6WBBYGcg8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geHgLlko; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geHgLlko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E662C32786;
	Tue,  6 Aug 2024 13:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722951486;
	bh=IUsHVXl6vrsJ/SUxWscVy8OdmVYWDM4EQy6CniwnHGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=geHgLlkoLGrO2ZUWFg05OEtEDyB4uNMJ4wMqysDLl151UJhQmIuAm068k2FGIE5yd
	 +weB892ZbWIUlisCrCuFezAXqBlQom2L16mZGKinKxkwuwTOSGlNhp1GETWvQWEwN0
	 qnLxRPDns8KAegY6ZhrFVX7h8A+ARbeXnDEu/MRw9NEZ/2nMsOheiKGAepPKsZmsFL
	 lv0HsEh4ixkYoc6CcU5CUgipRCwr1m1mv5jPPiK5Ptk7nZIlUggp+vE4A7c//aSvyL
	 YNB9drvTD9kpg1PGa7INUZxiseEnwQqkAgMxX3rysZ3K6A/kwOhsd6uCUvEyWUICcW
	 qraS2ibJdCoBg==
Date: Tue, 6 Aug 2024 10:38:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Eric Lin <eric.lin@sifive.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Ci-Jyun Wu <dminus@andestech.com>,
	Locus Wei-Han Chen <locus84@andestech.com>,
	Atish Patra <atishp@rivosinc.com>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Xu Yang <xu.yang_2@nxp.com>, Sandipan Das <sandipan.das@amd.com>,
	Guilherme Amadio <amadio@gentoo.org>,
	Changbin Du <changbin.du@huawei.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, vincent.chen@sifive.com,
	greentime.hu@sifive.com
Subject: Re: [PATCH v1 4/5] perf pmu-events: Remove duplicated riscv firmware
 event
Message-ID: <ZrInOywRKzRmjtKF@x1>
References: <20240805194424.597244-1-irogers@google.com>
 <20240805194424.597244-4-irogers@google.com>
 <CAPqJEFpiy307B4OBHK4WJGjgbVm_woUrdZ+Vy_LSdQ=ECqZX-Q@mail.gmail.com>
 <CAP-5=fWDmdAkJSoncedZTaSgFwG+p3--jywDj9krnXSfkhh6dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWDmdAkJSoncedZTaSgFwG+p3--jywDj9krnXSfkhh6dQ@mail.gmail.com>

On Mon, Aug 05, 2024 at 09:05:26PM -0700, Ian Rogers wrote:
> On Mon, Aug 5, 2024 at 8:54 PM Eric Lin <eric.lin@sifive.com> wrote:
> >
> > Hi Ian,
> >
> > I've sent a patch to fix it and the patch already merged. Thanks.
> > https://lore.kernel.org/all/20240719115018.27356-1-eric.lin@sifive.com/
> 
> Hi Eric/Arnaldo,
> 
> Right, I already commented this should have gone through the
> perf-tools-next tree:
> https://lore.kernel.org/all/CAP-5=fV3NXkKsCP1WH0_qLRNpL+WuP8S3h1=cHaUMH5MFkVHQg@mail.gmail.com/
> Arnaldo, please take Eric's patch in preference to this one.

So I removed your version from perf-tools-next, eventually we'll get
this merged upstream, I'm just checking this isn't going to get in our
way of testing what we have in perf-tools-next...


- Arnaldo
