Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CCE2798F8;
	Tue, 11 Nov 2025 19:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762889648; cv=none; b=H7j0nOtiX/C1ZXkpGjMzdL8mAU0xEqDKARl5QMmqARR761CnnJemQv8Ar+IRU52jbsDxCf5/w2WBqg84Dt4TM9JnCiDP928BZVTvECmf/MOWXByqbKNfPHnDLiHhzP/Ak+HhRSajyru5V3YhIYUvC4A4YKDXI2oVtPvEaQ4BVp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762889648; c=relaxed/simple;
	bh=v7NoUGhdTTQsuzKrcG/+r6lzjJyNg1UzIw6aiVzxVaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MS1hD10Z+S6xLYIp0YEjrJ1Z00dHK3n0b9XsyP9mkrpMWXds4p/If3gQOWZQoqEZ1ax0SyhmK8RPmsCOg4qf/vxmQ8JPwe0XdUWEBj6v1GXNjcbgluXSaRmhhBdZZ26igHWwyQ5GwKqpK9QGJ7V8pizTN9qkMtQ/dhA5tN7YVNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abYIC78V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abYIC78V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2633C4CEF5;
	Tue, 11 Nov 2025 19:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762889647;
	bh=v7NoUGhdTTQsuzKrcG/+r6lzjJyNg1UzIw6aiVzxVaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abYIC78Vki7dMvCS/0slHBey55YuUwvgFqzBHmsduRQvvbcBYefzO6GQCbXCFE5At
	 rjklwkwPoJzul1Jyy7JyDVHD6zy4CciyyAS6rXxEa7De4bPOu5qLJmOKyRsYtKKT5e
	 E6GYpWe74to2dWi38S6PS5t5ahhTk8c0GFTgQlpIU+bBpxy/OOt/JHbdd8fL9hANqr
	 NOSdJ0/w9fQnzGDMud8Jr78a6zV3qA+/+SR1bi/vYf6DnOTvmOij5u432CA+LFeVBH
	 bgs0q69X8b4yhFSuJNCEQvMb/mbX5ALafghuOYwBsEQ4MJiwoAEtcK/ZXqLmMJ5mJZ
	 AndYnurX2eZoA==
Date: Tue, 11 Nov 2025 11:34:04 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: "Chen, Zide" <zide.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	thomas.falcon@intel.com, dapeng1.mi@linux.intel.com,
	xudong.hao@intel.com
Subject: Re: [PATCH] perf tools: Refactor precise_ip fallback logic
Message-ID: <aROPrA02BU1uafrD@google.com>
References: <aP1ucJiJYBavTHV7@google.com>
 <e10d671a-eb89-4e06-a1eb-e2f12ee41d70@intel.com>
 <aQl3qfyTdAb68l1l@google.com>
 <652bf158-ba9e-4a97-b4c3-3a7f7e39fe85@intel.com>
 <aQzugcpRvOcPEEro@google.com>
 <5f84fe4f-90ef-42d6-8a3a-c1f515a7832a@intel.com>
 <aQ5n4ML9lxY4VAxi@google.com>
 <eb41cde1-9611-4998-a82f-5d6efb80b0d1@intel.com>
 <aRLq0isFxDJlsHlL@google.com>
 <42bafd4d-ff6e-4529-95f7-9c4c963fc49c@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42bafd4d-ff6e-4529-95f7-9c4c963fc49c@intel.com>

On Tue, Nov 11, 2025 at 11:11:45AM -0800, Chen, Zide wrote:
> 
> 
> On 11/10/2025 11:50 PM, Namhyung Kim wrote:
> > On Fri, Nov 07, 2025 at 02:31:23PM -0800, Chen, Zide wrote:
> >>
> >>
> >> On 11/7/2025 1:42 PM, Namhyung Kim wrote:
> >>> On Thu, Nov 06, 2025 at 05:23:09PM -0800, Chen, Zide wrote:
> >>>>
> >>>>
> >>>> On 11/6/2025 10:52 AM, Namhyung Kim wrote:

> >>> Can you run these commands and show the output here?
> >>>
> >>>   $ perf record -e task-clock:S  true
> >>>   $ perf evlist -v
> >>
> >> On 6.18.0-rc4:
> >>
> >> $ perf record -e task-clock:S  true
> >> [ perf record: Woken up 2 times to write data ]
> >> [ perf record: Captured and wrote 0.006 MB perf.data ]
> >>
> >> $ perf evlist -v
> >> task-clock:Su: type: 1 (PERF_TYPE_SOFTWARE), size: 136, config: 0x1
> >> (PERF_COUNT_SW_TASK_CLOCK), { sample_period, sample_freq }: 4000,
> >> sample_type: IP|TID|TIME|READ|ID|PERIOD, read_format: ID|LOST, disabled:
> >> 1, inherit: 1, exclude_kernel: 1, exclude_hv: 1, mmap: 1, comm: 1, freq:
> >> 1, enable_on_exec: 1, task: 1, sample_id_all: 1, mmap2: 1, comm_exec: 1,
> >> ksymbol: 1, bpf_event: 1, build_id: 1
> > 
> > Thanks for sharing this.  Yep, it has the inherit bit.
> > 
> > I think there's a bug in the missing feature test.  Indeed, it should
> > also have PERF_SAMPLE_TID for the test according to the kernel comment.
> > 
> > 	/*
> > 	 * We do not support PERF_SAMPLE_READ on inherited events unless
> > 	 * PERF_SAMPLE_TID is also selected, which allows inherited events to
> > 	 * collect per-thread samples.
> > 	 * See perf_output_read().
> > 	 */
> > 	if (has_inherit_and_sample_read(attr) && !(attr->sample_type & PERF_SAMPLE_TID))
> > 		return ERR_PTR(-EINVAL);
> 
> It seems that the purpose of the inherit_sample_read fallback is to
> remove the inherit attribute when both PERF_SAMPLE_READ and inherit are
> present, but PERF_SAMPLE_TID is not. The new change may not be able to
> accomplish this?

No, the purpose of the missing feature check is to detect whether the
current kernel supports this feature or not.  The correct check should
pass both READ and TID together.

Thanks,
Namhyung

