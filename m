Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D37F2765DF;
	Thu, 22 Jan 2026 01:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769045577; cv=none; b=YapFO+JHEPFpzRAbrSP8+YnzhUgP57OHqsxUC0w80cVJSesO+irOckKmRXpqsDJ/Xk8aTMewtb57KbSjhgQ+Ad7AbUjEcZF4W6Lgw4PAZKix4UlUkYXofLTsVx/5fUIecun32mPb/xmhp+eYx6jNN5YNmLPWZ5Sw+K5MBmTjh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769045577; c=relaxed/simple;
	bh=4XFiPAs8jnYhz1j9qg/XDog+5uvcWAWFIKqPse5lFOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtB5Xnk1lVQe3ZaB+mEzz/S7dg0Yo7h9GCkjXbb8/6S4Yc1AAh7w6O6TIL2qisJVI020v2Zz4iJ3PXwtnVqdGa6/7vALQ3h+QwGlqdNEUMm+q2nZIyQ+xXDuleNEt1P/qLh3VFkA7kTwX7nJvF7ptY/fJU4pSCgi0cEmWNGU+wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knU6+T/5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knU6+T/5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80ACBC4CEF1;
	Thu, 22 Jan 2026 01:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769045577;
	bh=4XFiPAs8jnYhz1j9qg/XDog+5uvcWAWFIKqPse5lFOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=knU6+T/5mkRnstY2YflDDZSOSRfzeQwh8MC7RMZinADVihZdinKBl3bEGEeF7LRJo
	 8T3eHHYIrEXvBIswd0GtHfCwc8CR+92ATlQl/V57L3Ab0z65jIQ2SXUasq4cUmBxNQ
	 dLEHVBdMuwEcJsLpQ2/bOBpxe9dYaGM6anmhDzlu/yf1F69xkQ0Wpmb7zZ4aeZ3UQO
	 2norVvxXjca2pYdvoEhKBrsIHXeH5qG1ChdSppf3S9f2Ax3+j6Buc24AeAYU+kgzqn
	 f6vbQBfJ0Mu8bjwdghkK59+DvwKO0cQiZA5mg5fKwzDOYUDNF8mFFftXWDTgBhug93
	 tf31N5xdJUB9g==
Date: Wed, 21 Jan 2026 22:32:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	irogers@google.com, james.clark@arm.com, ravi.bangoria@amd.com,
	yu.c.chen@intel.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	rostedt@goodmis.org, vincent.guittot@linaro.org,
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
	James Clark <james.clark@linaro.org>
Subject: Re: [PATCH v5 07/10] perf sched stats: Add support for live mode
Message-ID: <aXF-RvjGU-mPA_B1@x1>
References: <20260119175833.340369-1-swapnil.sapkal@amd.com>
 <20260119175833.340369-8-swapnil.sapkal@amd.com>
 <aXF1OECUByl0kgCF@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXF1OECUByl0kgCF@x1>

On Wed, Jan 21, 2026 at 09:54:16PM -0300, Arnaldo Carvalho de Melo wrote:
> So continuing to test build up to:
 
> ⬢ [acme@toolbx perf-tools-next]$ git log --oneline -5
> 139b45df27c05531 (HEAD -> perf-tools-next) perf sched stats: Add schedstat v17 support
> e092c5d4541da7f0 perf sched stats: Add schedstat v16 support
> e659d5e11000b7ff perf sched stats: Add record and rawdump support
> 900884770020691c perf header: Support CPU DOMAIN relation info
> a02829a0e6c65b12 tools/lib: Add list_is_first()
> ⬢ [acme@toolbx perf-tools-next]$

Just the first two patches build on 32-bit arches, I'll look at it
tomorrow after some coffee, for now at least the first two are merged,
to make some progress.

- Arnaldo
