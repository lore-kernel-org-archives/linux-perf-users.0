Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211116;
	b=RBJGptihh6yLJ4DG/rvkYEYPBkArsd+RErBhIHDRiUXp4Ed4k35INYiTvF/uQNgLAQAr
	 DfIZYxBk/37zSbVCoYRw8km/uxUjgTNLPpqczZwE83GzUEbvnLTNIsH0II27zl9mb47Ch
	 yjzN9BLzIRdA3YY8W0fzMnStttVhgXPeQujHfOrytwYhM7lQzbg7HIk6jj+EEgcvK67xQ
	 2Jo7kN9t0DHiq2+aVFFovuBtjzbaExdNfTvj4v9ZIA6bcGiLsnFKAoKWf/W4TkWfFscBL
	 oQoa4BBzWrGB7kebJR3w6J46PuZjWmg0Za68KtSez+aZ0dhbOeC/IOWGLVpvjwdP2pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211116;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/ZRwqCDLdZQ8QCM8R16NcamQ4q02zizRwtZL0rTHdAQ=;
	b=hMB2cjkJZ8FDDuHbxjqgOJdq97AGMbYa8A2Jj0JAl2rgkTQZq68o59wMwwnKREjmBKkV
	 hjmsSVSiX7L/047kTgEvuT5WflWK9wG1IuBfNtwLN6d2UqhITcXPpL4Wsn6aUVo6HFCeV
	 QFh2igpq/3DpHBAluy47QDPAvOhwv3DgML1JF8AeWWleWH252zNY/FY3WOOM5iEiWUEP3
	 77IV4hU180Z1ef4VZ0EMzOS0EtgiXg1aoudf6JA2IVymzW2yP6A6KbV5jFoTz7Jox1WDa
	 uo4rqXjF0Ep1PnBA6bN1x3HRmftemtcdKa/AVZsCxbV5oz02JovNDJiK0Xw69TCyQBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iY4CPDrL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8A9606A685;
	Fri, 20 Nov 2026 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iY4CPDrL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985651F000CF;
	Fri, 20 Nov 2026 21:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795211115;
	bh=/ZRwqCDLdZQ8QCM8R16NcamQ4q02zizRwtZL0rTHdAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iY4CPDrL5PEo1XiP3HTPGikDnff5U9d9v2kGgHWr1qNF//2wyjdUuuNQqazGNIoO1
	 mr6+G/t18WAasGNwBlb67wQQ6raYQHEZOhS85+3n5MmeFzgqNrTtqHRwqSGTZc/GU2
	 i6Hp2Sn6ei5MAB16G2El3w7T1gIpUKWsmRBjRv2h+MJQElG3z8h9xLpw7x1ayCRclF
	 Jsd7bGZDCXYPIWTxIVmTGkOAXh06Q2yIZ/IU/q+Sx4x3ikDW2nWmlIS4LbCpmZ+eFM
	 Xpoo0iHLpfxuwDqu/mMft5eGMYW/EtCjDqcMeiIipgxFB4vC/WQOBqjmXTyLB7FXAA
	 wCQ2gwu0nJTXw==
Date: Fri, 20 Nov 2026 13:45:13 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: TAKANO Mitsuhiro <takano32@gmail.com>
Cc: Ian Rogers <irogers@google.com>,
	Hang Zhengyang <hang.zhengyang1010@gmail.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf stat: Count kernel events in a group led by a
 tool event
Message-ID: <awC_aZXD5FBGu4mO@google.com>
References: <20261111-tool-pmu-leader-v2-1-3faa0fb98c51@gmail.com>
 <20261111110616.2249764-1-takano32@gmail.com>
 <av6t6M0fUYdtXDEu@google.com>
 <179508291800.2785063.13205692423397372334@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179508291800.2785063.13205692423397372334@gmail.com>

On Thu, Nov 19, 2026 at 10:08:38AM +0000, TAKANO Mitsuhiro wrote:
> Hi Namhyung,
> 
> > I think it's better to make the first non-tool event as a leader
> 
> I agree, and I think that is where this ends up.  What stops me from
> doing it in this patch is the group read: with a kernel event as the
> leader, evsel__group_read_nr_members() still counts a tool event member,
> while the kernel knows nothing about it (a tool event is not opened
> through perf_event_open, it reads /proc/stat) and returns one entry
> fewer.  evsel__process_group_data() then rejects the read with -EINVAL
> and the kernel events of that group come out as <not counted> as well.
> The smallest version of that is a few lines, but it changes what every
> group with a tool event member prints, so it wants its own test and its
> own commit rather than riding along with the EBADF fix.
> 
> > but I'm afraid it'd make evlist management complex
> 
> v3 leaves the group structure alone: no new evlist entry, nr_members
> unchanged, and evsel->leader stays whoever it already was.  What changes
> is how the members are opened:
> 
>   - get_group_fd(): with group_fd = -1 instead of the tool event's
>     /proc/stat fd, or -2 when the leader failed to open, the same -2 the
>     skipped-leader case already returns for a broken group;
>   - create_perf_stat_counter(): a kernel event member is opened disabled,
>     as a leader is, so that it starts with the workload, and
>     PERF_FORMAT_GROUP is not requested for the members - read_format is
>     per fd, and GROUP is what would send each member's read down the
>     group path that only a leader can take.  PERF_FORMAT_ID goes with it:
>     without a group read nothing demuxes ids.
> 
> The cost is real and the changelog states it: in -e '{user_time,a,b}',
> a and b no longer share an on/off window.
> 
> Two things this does not change, both of which happen without the patch:
> a tool event member still counts through a -D / --control window, and a
> tool event leader under enable_on_exec is still not started by anything -
> that is what "perf stat: Start tool events when enable_on_exec is used"
> is for.
> 
> Either way the leader move is a separate series; I can post it once the
> direction is settled.

I think grouping with tool events would cause more headaches.  Probably
the simplest fix is to prohibit grouping.

Thanks,
Namhyung

