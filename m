Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233B37A4BC;
	Wed,  1 Jul 2026 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927813; cv=none; b=moXs2PQQs/xViD/ZRLpD8ZZrNqzrivqPhy1gD4ijCpYf8gCUQdIBiI8wua5g3MrYBQSuwYdvu05NKLe3LR9x2BdUd/JeMdN/a+19ogJcEdvVzU6sf9HsSfqiZ3gHibzVSVQvKUnQ4rmGsY8SQqr3N2m7K6piaAoEr1uip3C0gg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927813; c=relaxed/simple;
	bh=e7/cwJGsAWHtuni2mDkCE6rRvkoaqv3ih2drk3fV/1I=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KS+2gr2hvIqzjkpwK9LDvRldKBzEtplF9iIIhcJYxVNeW8HP24tSryr+lgc2j1UHWs5ciqOEFO8ES+Cki/SFx43/I8SBO349ifn3nMVHwMnBhawKs81JAxK0Cu4gTFihCT0ncsCQFBEcKfzWwc4e3Q97f1cE+Kz8BtMA9XN3I7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AODrSBEH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AODrSBEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EE61F000E9;
	Wed,  1 Jul 2026 17:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782927812;
	bh=+qc3Lu62TjP4Hz5w4ajStbgG6sx6nhZhkPmQaWYCWEU=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=AODrSBEHTMIqYGKPIQK4/DNxijexdDQO51cKUE/L+IoNBT1zD6QEszZ0HrHeREG/o
	 kkLUuV8bnw0NQAEO5IcwWOMFV4O0P7h3JCgjLKKvbZXuNn0ikGjo9qruW30GhCmUKL
	 oPQx86xCRaJPHtycpLCed8BhBBMcnJG1eY5T/IZQdAZgOVhEGvCdXv58gHrlunR4ER
	 ftKqlFyXVwD8C5CvNsJalAGaM6qYPFvqJHBMW/HblS9pmjkie1jreUO3/QbwJZG/90
	 h+OJTD86rA5W+SC2z4orRPU5ySojrutn336HvqXw7TLJH2BCLdHyuntUYPgTHjrjKk
	 6hyFpnPgFgJRg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>, 
 Athira Rajeev <atrajeev@linux.ibm.com>, 
 Thomas Falcon <thomas.falcon@intel.com>, Qinxin Xia <xiaqinxin@huawei.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ian Rogers <irogers@google.com>
In-Reply-To: <20260612012413.3253516-1-irogers@google.com>
References: <20260612012413.3253516-1-irogers@google.com>
Subject: Re: [PATCH v1] perf pmu: Recognize default_core as a core PMU in
 more places
Message-Id: <178292781179.3559466.12057728944538544548.b4-ty@kernel.org>
Date: Wed, 01 Jul 2026 10:43:31 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 11 Jun 2026 18:24:13 -0700, Ian Rogers wrote:
> The python metrics code used in places like ilist.py passes a
> pmu-filter of "default_core" on non-hybrid x86/ARM/.. systems. As a
> PMU like "cpu" isn't a literal name match then no PMU matches
> "default_core" and the events fail to parse for the metric. Fix the
> name matching and PMU lookup for "default_core" and check that it
> fixes ilist.py.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


