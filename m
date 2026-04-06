Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601DA38C430;
	Mon,  6 Apr 2026 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775497851; cv=none; b=fhZw3BZBzE3k3zpJtz/gtX2pvp4AuTE1cPosu9M7bEVmlxdGVl+SiRovjs0OBim1Qci38YDvlgFsZBwd/c0sc5IVnzyiwE441to42AAT43pJCLFZFzIj+xa7wkD79BXkPvGRoy6jV3eWi16NNRuEdo3bdUkPyDxvD++4BM8HvYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775497851; c=relaxed/simple;
	bh=+1mE0Eq3AQuzYEsI5cETGE8OHGoXe+b5c8rj9sJdG5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPVk/+X8AgUoNavsmeb1klM0DXglNvf38LKKXR3CMwo+3MckgLmbGMjjn3u4rFxEi7USSyX3FDoP4YczpJ+fhgpNjlggug5BVQRjssX7gXoa0Y6cdn1o9lMPXGWZjbCO46+ooHyNN4In9PB50TPc/GU5Yhb7aXX+ufiZo+NIgzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZ8AlQND; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZ8AlQND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968AFC4CEF7;
	Mon,  6 Apr 2026 17:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775497851;
	bh=+1mE0Eq3AQuzYEsI5cETGE8OHGoXe+b5c8rj9sJdG5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RZ8AlQND8jagxKfu8EAosWML1/nTo9znOGCVkJRNxWfBNPsr5yaEShA/FY5+9pmKK
	 e611BvT1+U7j2HUnWJ+ithHbkH4rTF3XJpPHmIafeuc8FoiiezPXo65qwEjGtJz9wA
	 OI8SuyzblWAZVo0SXaNcmo43vSCLk73Vna1/sA5/SwJYKDoOtd9gS97dBKkyJN5dp0
	 LsOEPo+f0H4tt0OC5rhb504n0NNwLJOxeJS4obzqEAxHAElHaFTQfCbzPFj3zCcZlV
	 pHeWx1oehZGRbNGYLYrR/TkPJeYkaXBG1KWeuFnVnOjCYnLnRolCheBmhZQs9S//qd
	 X3wykqI6D9oYw==
Date: Mon, 6 Apr 2026 10:50:48 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
	ak@linux.intel.com, alex@ghiti.fr,
	alexander.shishkin@linux.intel.com, anup@brainfault.org,
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com,
	blakejones@google.com, ctshao@google.com,
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com,
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com,
	james.clark@linaro.org, jolsa@kernel.org,
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn,
	palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org,
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn,
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com,
	zhouquan@iscas.ac.cn
Subject: Re: [PATCH v6 00/25] perf tool: Add evsel to perf_sample
Message-ID: <adPyeCq3rQrTurju@google.com>
References: <20260403204017.2919994-1-irogers@google.com>
 <20260404034325.3172592-1-irogers@google.com>
 <adNOd_yaPL3nlXUr@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adNOd_yaPL3nlXUr@google.com>

On Sun, Apr 05, 2026 at 11:11:03PM -0700, Namhyung Kim wrote:
> On Fri, Apr 03, 2026 at 08:43:00PM -0700, Ian Rogers wrote:
> > Nearly all perf code ends up passing an evsel with the perf_sample,
> > which is problematic if you want to rewrite the evsel such as with
> > off-CPU processing - all uses of the evsel need fixing up. Previously
> > I'd mailed this patch as an RFC with everything combined:
> > https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com/
> > and there was a request to break it up.
> > 
> > I've started the series by adding documentation to struct
> > perf_sample. Next I fixed missing perf_sample__init/exit largely from
> > the recent perf inject callchain rewriting work. The 3rd patch adds
> > the evsel to struct perf_sample and ensures it is correctly
> > initialized. The next 22 patches avoid passing the evsel along with
> > sample for different parts of the perf tool, along with some minor
> > tweaks like constification and not determining the evsel if it is
> > present in the sample.
> 
> I'll test and process the first 3 patches first as I found an issue in
> patch 6 and I guess applying patch 4 would break partial imports later.

Applied the first 3 patches to perf-tools-next, thanks!

Best regards,
Namhyung

