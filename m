Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF8B17F4E0;
	Thu, 30 May 2024 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073320; cv=none; b=Rus7Bsop/+rNaP40GfyTbEX8gkvzysANlcc/h+Y6bgWM+TQw2rpgCsYviGUuGKhMNfnEPgWDIeEgikPDQ5r7PmlqQiJGgU+ElSVDsFCpxHHm+Um06cFWjE62GBqXlKW22TN3EgDWpZc6ObhtIhm7P333mSA5sbjHAhYbtzCCToI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073320; c=relaxed/simple;
	bh=0rQl/cKLRRzbfB91lX5MRST7yhxeLasHy+xqZ8/GUBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAIFhGOIHfkq7f/evysA1u7AUuE/lMVD4zA6BoR51oyGcgrLeYQXtUpcubppDeLnzjs/luKthxuCaJ4p21ZgUO27Cw/Fj7DQkcp3+JkvKkRu9NtQfKL/Lz0ggo7V2gMjM4KWvx+UyPPieOSBQMea6dSeoCMZw4Yk1CQhzfS62zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E643B339;
	Thu, 30 May 2024 05:49:01 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D93613F792;
	Thu, 30 May 2024 05:48:35 -0700 (PDT)
Message-ID: <aee9254e-81c1-464a-8a28-f971615baffc@arm.com>
Date: Thu, 30 May 2024 13:48:38 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core
 PMUs
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Leo Yan <leo.yan@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240525152927.665498-1-irogers@google.com>
 <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
 <CAHk-=wi5Ri=yR2jBVk-4HzTzpoAWOgstr1LEvg_-OXtJvXXJOA@mail.gmail.com>
 <20240527105842.GB33806@debian-dev>
 <CAP-5=fXfidyF_e=yMNi26ScgY-VbJPfxN8M7OiK9ELa3qTfXPQ@mail.gmail.com>
 <ZlY0F_lmB37g10OK@x1>
 <CAP-5=fWM8LxrcR4Nf+e2jRtJ-jC0Sa-HYPf56pU5GW8ySdX1CQ@mail.gmail.com>
 <d79b18d7-6930-41fd-8157-eaa55b52df86@arm.com> <Zld3dlJHjFMFG02v@x1>
 <CAP-5=fXKnQzfwDSr3zVeo6ChJe3+xwpBfyAi0ExmPEdhcde4ww@mail.gmail.com>
 <CAM9d7chV8YOCj8=SGs0f60UGtf+N2+X=U+Brg246bFoPXBXS+g@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAM9d7chV8YOCj8=SGs0f60UGtf+N2+X=U+Brg246bFoPXBXS+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/05/2024 06:35, Namhyung Kim wrote:
> On Wed, May 29, 2024 at 12:25 PM Ian Rogers <irogers@google.com> wrote:
>> We can fix the arm_dsu bug by renaming cycles there. If that's too
>> hard to land, clearing up ambiguity by adding a PMU name has always
>> been the way to do this. My preference for v6.10 is revert the revert,
>> then add either a rename of the arm_dsu event and/or the change here.
>>
>> We can make perf record tolerant and ignore opening events on PMUs
>> that don't support sampling, but I think it is too big a thing to do
>> for v6.10.
> 
> How about adding a flag to parse_event_option_args so that we
> can check if it's for sampling events.  And then we might skip
> uncore PMUs easily (assuming arm_dsu PMU is uncore).

It's uncore yes.

Couldn't we theoretically have a core PMU that still doesn't support
sampling though? And then we'd end up in the same situation. Attempting
to open the event is the only sure way of knowing, rather than trying to
guess with some heuristic in userspace?

Maybe a bit too hypothetical but still worth considering.

> 
> It might not be a perfect solution but it could be a simple one.
> Ideally I think it'd be nice if the kernel exports more information
> about the PMUs like sampling and exclude capabilities.
> > Thanks,
> Namhyung

That seems like a much better suggestion. Especially with the ever
expanding retry/fallback mechanism that can never really take into
account every combination of event attributes that can fail.

James
