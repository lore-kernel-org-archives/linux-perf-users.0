Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E5E195F10;
	Thu,  6 Jun 2024 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717681887; cv=none; b=GuG6zmAjCaG4Ns2uiFdiVyxzEl0XfRhwiirrHI6ndkPlzgzjkOOO+5krkGBK/6tfHGcZKC94r2oC7Qqm6Q7v6/biLAxJd2pvD+aesbZWWmpMQokPqitB61+Gw05r3SNYv5ZTW5m6dGejIk3xS7blYYw/lqaCO0wK6QrIPnpmuWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717681887; c=relaxed/simple;
	bh=gNK3dp5fn/H795o5UEgHg6VeYr3fgd5BNg14ucmQgQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzLP1GK8weH6+g28rhi9FrCJ5iAlZ3VmqchO6ZDliwTvxIBw4o8SoP41eR0oEOexot4SLvO3SSIqsfn/n8HBK/ucHFLIB4y4rsx9OwjOEMCFtpTsN19ZHGt6g8sw7HuDY2p/OAfIZ67w8pq+6y5+S9e3QpUimZ/FShRPY5H+yEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1AU+LTI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1AU+LTI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FCFC2BD10;
	Thu,  6 Jun 2024 13:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717681886;
	bh=gNK3dp5fn/H795o5UEgHg6VeYr3fgd5BNg14ucmQgQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d1AU+LTIBH/0dAG7ND7cckGhpsoCV34pPi3eW6gnxERxWaCKYcGH6rWkgPDgUeHgA
	 pkRxHLfKUin8/eVQWLWcsMixNuhT3RaZ7L8I395lHN+AcWQSH2hZKIcEqAHnbo9K3T
	 kqpNgN4lKlCv/VEwxTcckkOEYZCMq6TLWccgFAiQUA16bLW00g24j9rWoCA3Tc2hlm
	 gFeQGEV9CxHRvKDSNTU8o/RNXtaBgAUyuKWbWyI6KjpXz4UX7KCwASwqsBHpPYrcrO
	 MY7PwGJJAn8FvyUjm+lc+cUes6XoAfeTJY68tK84R75EytaflgrtZGJ9mUz0cZiWsO
	 QhzeR3uYiwX5g==
Date: Thu, 6 Jun 2024 10:51:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Leo Yan <leo.yan@linux.dev>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core
 PMUs
Message-ID: <ZmG-28go-qqOVsyM@x1>
References: <Zld3dlJHjFMFG02v@x1>
 <CAP-5=fXKnQzfwDSr3zVeo6ChJe3+xwpBfyAi0ExmPEdhcde4ww@mail.gmail.com>
 <CAM9d7chV8YOCj8=SGs0f60UGtf+N2+X=U+Brg246bFoPXBXS+g@mail.gmail.com>
 <aee9254e-81c1-464a-8a28-f971615baffc@arm.com>
 <CAP-5=fVynt-8cH6Jc5VyfBLBOqkF+v_7kknHdUPZBM1r3WwhTQ@mail.gmail.com>
 <ZlkC_Tm6kKIL3Phc@google.com>
 <CAM9d7ciTbHngfimDNsXS_adR7xg4ZHvSHzVhAzuQ6o-nQ2nsMQ@mail.gmail.com>
 <CAP-5=fUq6jLCtjPNb0gngtR0cXopG+-mJ-+CnEOAXeG7VShh8A@mail.gmail.com>
 <CAM9d7cjPe68PMb1hnbypMOQUQOybpisdqH3eTH1B9G-KG5rKXw@mail.gmail.com>
 <f30f676e-a1d7-4d6b-94c1-3bdbd1448887@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f30f676e-a1d7-4d6b-94c1-3bdbd1448887@arm.com>

On Thu, Jun 06, 2024 at 10:42:33AM +0100, James Clark wrote:
> On 06/06/2024 08:09, Namhyung Kim wrote:
> > On Wed, Jun 5, 2024 at 4:02 PM Ian Rogers <irogers@google.com> wrote:
> >> 2) Ignore failures, possibly hiding user errors.

> >> I would prefer for (2) the errors were pr_err rather than pr_debug,
> >> something the user can clean up by getting rid of warned about PMUs.
> >> This will avoid hiding the error, but then on Neoverse cycles will
> >> warn about the arm_dsu PMU's cycles event for exactly Linus' test
> >> case. My understanding is that this is deemed a regression, hence
> >> Arnaldo proposing pr_debug to hide it.

> > Right, if we use pr_err() then users will complain.  If we use
> > pr_debug() then errors will be hidden silently.
 
> I'm not sure if anyone would really complain about warnings for
> attempting to open but not succeeding, as long as the event that they
> really wanted is there. I'm imagining output like this:
 
>   $ perf record -e cycles -- ls
 
>   Warning: skipped arm_dsu/cycles/ event(s), recording on
>     armv8_pmuv3_0/cycles/, armv8_pmuv3_1/cycles/
 
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.008 MB perf.data (30 samples) ]
 
> You only really need to worry when no events can be opened, but
> presumably that was a warning anyway.

Agreed, while we don't find a way, old or new to autoritatively skip the
event, when that pr_warning() gets turned into a pr_debug() so that
people expecting that those skipped events were included get a message
telling why they were not.
 
> And in stat mode I wouldn't expect any warnings.

Right.

- Arnaldo
