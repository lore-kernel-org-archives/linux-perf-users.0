Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A9B2C17A1;
	Mon,  2 Feb 2026 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770062396; cv=none; b=qF4Y1L8T5TrmAvsFqRqOsVy4J6TcfrXTNXc1faXvdjQuVaIPtl4RcvaVrHGWJiBrMw9jfGSJw+F/LgfJgdr1xpsE35NPh0WTcC+mhgmK/hRIb0HRW8H3+mnOhR1krW1iZ41GYvDNHNOGx55IOSd7G9zbQS4JywXjUmFvqvv66fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770062396; c=relaxed/simple;
	bh=eEU6X/6L7H/3zpIVEJEiFvuFbR2Tsb/isJ7/+9fxYsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nbfn/GJ4Q5Amhm+W+4RA3011BEOO2yFa4v3U2Mp8QwSmGMXHLj2aWD2kXHjfHukeTPbzMD3hzYCJ4DS//jB896a9DbJYSIClSbkQCBsoLcLQE4oVEi1CK5ZGV2hHMOX+m2OL879hm77V1f8NQynnTkH98vSOp+NFyPWcuizZjIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fzWlhWu2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fzWlhWu2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ijkgu82x5tCkNyZgQnmbEBJphoNEGQgRBkZ7m2AwrGY=; b=fzWlhWu2KNOvni03qgbg5X6xt+
	e64YaRpHvUj5sM2HHZiHgNcfRce/ra3GMnADtB23Kpjc4zG8+Lc94UMoiueScO7YzNheOabtIOibK
	LFDgeTrNBpeDtQltabGi3K3Tc+JM5Ng6vWU2iYY4gaBCb4W484JEpWhLJu2lE36IpjaaSvFZENLNB
	hUaEPevouUmJZYvvcDGswZzVy46aONuN1tWgRDeo5kOHS0sxjonxHKSnuClDrpXeE869FjMiGGw2+
	rSM+NGAUgX6Xd0eZabHVvxDmWEHfjI20xtquzq3gPbEu+unbJbpIvgt06tkSgdEVrv+GlVTVgrnWu
	/Hi064UQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn05H-0000000Gzcd-2exJ;
	Mon, 02 Feb 2026 19:59:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2A2853008E2; Mon, 02 Feb 2026 20:59:43 +0100 (CET)
Date: Mon, 2 Feb 2026 20:59:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Tao Chen <chen.dylane@linux.dev>, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
	eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
Message-ID: <20260202195943.GI1282955@noisy.programming.kicks-ass.net>
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-3-chen.dylane@linux.dev>
 <20260128091033.GG3372621@noisy.programming.kicks-ass.net>
 <CAEf4BzYpcgC0Pi0f_ScUavJ_Tw74PKULsbPdexKsWmb8RmxLKg@mail.gmail.com>
 <20260130113150.GB166857@noisy.programming.kicks-ass.net>
 <CAEf4BzZNOqxhkjuePzeG=ivqBSHXnWzPLPPHJdoC91c+u-WjAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZNOqxhkjuePzeG=ivqBSHXnWzPLPPHJdoC91c+u-WjAg@mail.gmail.com>

On Fri, Jan 30, 2026 at 12:04:45PM -0800, Andrii Nakryiko wrote:

> > Also, there appears to be no buildid caching what so ever, surely that
> > would help some.
> 
> Jiri Olsa proposed caching build id per file or per inode some time
> back, there was vehement opposition to it. And doing some locked
> global resizable hash that might need to be used from NMI sounds
> horrible, tbh. So we have what we have today.

See kernel/module/tree_lookup.c and include/linux/rbtree_latch.h :-)
