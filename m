Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370AE38F23A;
	Thu, 22 Jan 2026 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097616; cv=none; b=LagPWTPJms50erU5bkdBkf7pBJWPflfOwbAX65ikT6HPrz/Wi0mLGXqM9D59UOAUC+eD9+kodGUCZW/XnDVbSunqJaOFFii5mY6p4KBlFfYUk4/n+slREzJE/KwJ+QDPo1rn+ZZfXx7Oq6tVIuODX3TVWsRrWOLBR9YIPKj+dms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097616; c=relaxed/simple;
	bh=Wr175+S63GrRuGGn0knVl8xDqsyuOQKHG2rHm/P7Tgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJ8T5+2Y6umk5/shN/xjE33lWTxjpRu1s0HmShSb+4WqF21/CzJO/pjklau29akcozeg9/rI60xrTuvYEHuGNqia8IVGHOLzFZTTu/dhkVcbhdNODRFPRKC08gMgFgSUL7vjzkN1m1Aix+JfHbK/qWT0HntM9OIYYdCvEtWN69E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afGF9vhc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afGF9vhc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56955C116C6;
	Thu, 22 Jan 2026 16:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769097614;
	bh=Wr175+S63GrRuGGn0knVl8xDqsyuOQKHG2rHm/P7Tgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=afGF9vhcqL6YN3r23+p0Y+Loyp2ciRqAYPAWCHsTu1a0W+k6nd70XvkDqkQD/2XGJ
	 1eyayqXANnxecyVsTDzazwP0zo01/iU2lox2ZmZMtuHOIGfEW852EdRbVj9BlN3d5X
	 5OWF1dQv7ExVLglL4ZegvvWDsxm0K9AZCUv+EYRhRs5LxGQ0YLqUgQ/aseK6EeBnOk
	 BdQj4RHuW9clTAh4A5wG3DV6ngj5R8a7NS4tmOlTF2G0/ZOn3hEPqc6wRQ1PeTeat8
	 fKIIUyafb4fgFdy9pM2i4xmNBZSQe8Y2mCBozdiolTUKsjemG0le18LP/wgFgelQ/V
	 l8N1/uO2qIJwQ==
Date: Thu, 22 Jan 2026 13:00:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ian Rogers <irogers@google.com>, "Chen, Yu C" <yu.c.chen@intel.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>, ravi.bangoria@amd.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, rostedt@goodmis.org, vincent.guittot@linaro.org,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	gautham.shenoy@amd.com, kprateek.nayak@amd.com,
	juri.lelli@redhat.com, yangjihong@bytedance.com, void@manifault.com,
	tj@kernel.org, sshegde@linux.ibm.com, ctshao@google.com,
	quic_zhonhan@quicinc.com, thomas.falcon@intel.com,
	blakejones@google.com, ashelat@redhat.com, leo.yan@arm.com,
	dvyukov@google.com, ak@linux.intel.com, yujie.liu@intel.com,
	graham.woodward@arm.com, ben.gainey@arm.com, vineethr@linux.ibm.com,
	tim.c.chen@linux.intel.com, linux@treblig.org,
	santosh.shukla@amd.com, sandipan.das@amd.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mingo@redhat.com, namhyung@kernel.org, james.clark@arm.com
Subject: Re: [PATCH v5 00/10] perf sched: Introduce stats tool
Message-ID: <aXJJirXQ9jsnewn9@x1>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <6a434657-5b5b-41ec-a79a-c648c2829602@intel.com>
 <20260121163342.GI166857@noisy.programming.kicks-ass.net>
 <CAP-5=fX=QuRw8M4Xco=A8WbBfDSPmyjtQ-JdnBEM-VRdX65_1g@mail.gmail.com>
 <20260121195155.GP166857@noisy.programming.kicks-ass.net>
 <aXEyJCSqlPPUS9YG@x1>
 <20260121201034.GC171111@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121201034.GC171111@noisy.programming.kicks-ass.net>

On Wed, Jan 21, 2026 at 09:10:34PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 21, 2026 at 05:08:04PM -0300, Arnaldo Carvalho de Melo wrote:
> > Until then, since you and Ian acked this one, I'm going over it and
> > tentatively merging it,
 
> Thanks!

It is on

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next

Has the two minor fixes to overcome that 'sv' maybe used uninitialized
on the error path + 32-bit build, I will move to perf-tools-next after
it gets built on all the test containers, later today.

- Arnaldo
