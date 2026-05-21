Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5953BED66;
	Thu, 21 May 2026 13:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368609; cv=none; b=Sx0dbvuo+EaxFJNzYYQF2H8cNeyE/zg0kc8YuPBj7NvG6xRy3WP1rNC9v5SLgVKgiAlRI7Wjbt4t+v0LKXDeqvxMTlqCT8FHcdNR0lt8WDblKYBi+TFc9C6TEUS7KX/lTKxZdacDE32fsN7jfksmF6mng4hroXPzCLV/votjifQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368609; c=relaxed/simple;
	bh=LQJGKjpaUpkFsitH7BlBeCDFh+DO/nMNCRCX5lOHcl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skoU52vacrrWvaArk5hwfHU/UWA+q6hMExEiePIxXQFZffktKpssVY4QO9u+3QWdb4AVw6Dx5bR5H/tCojmiWsGjJ6t7EoEJ/tvEjHAsHgTNSPJi3SIoKBNUm7oNRpnGgZNeLXyHcf23ojavv/5Tyu2CxolIG9HULNrimup9Xo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4wDesyF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4wDesyF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EA51F00A3C;
	Thu, 21 May 2026 13:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368608;
	bh=/lytDsxCjcesE5K/6KnlhJAWrzcFLtKMBrhhaD5NM54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L4wDesyF+hqN+U2lprF58+HV4uFVrIOfqIzRn/0ylrW10Ri6FIYT/gnCX5HnfX1Jw
	 eRqNh1FaNA0PqPQ7NE5hd3RfInSFC9PxYW6aExiolPd8FcoeKY1RoCIxkAWofljAUm
	 D2ymj6+i54TTLruHJzNNJ1Unhv5kkOYCqoa8He8Yqdx8pmQnRi+U3j0AcqJRzPRzQr
	 Urk0pDabne1JE6vy/m1S2YlE/MBslMe3HWbCG8YL9807hZio306s9YzK124gqPm4+E
	 p6L/Kb5PEhKCzTJop0XMBOQt2+kyD7IgruN5DCUjsN3Cbh5li+uOwWbAvsTgUeWSie
	 kY7G7rkPRjeYQ==
Date: Thu, 21 May 2026 10:03:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
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
Subject: Re: [PATCH v14 00/32] perf tools: Add evsel to perf_sample
Message-ID: <ag8Cnbn10ubut6XX@x1>
References: <ag4ecqF1PZg_u4Op@x1>
 <ag4e1BNQlZWVWISE@x1>
 <ag4f1iYyHdkpToXu@x1>
 <CAP-5=fWtx=B56xy+dDK33E8VTZ+4gBE=nLNf6ZdVZyQoAFLE6g@mail.gmail.com>
 <ag4j-dzzaa2xMr4y@x1>
 <ag4kauWBogiPBhRh@x1>
 <CAP-5=fW5DbyqPJwxO87YQ4DC4bRnhXxCe93Fkdbr3RMjT8-AQw@mail.gmail.com>
 <ag4l42A5UJOR3tQz@x1>
 <ag4szmCZdWwqHR_R@x1>
 <CAP-5=fWoN5UR4xvO9MAE3c0kNR-6sURsHtdzAN3kkHUHQrqUcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWoN5UR4xvO9MAE3c0kNR-6sURsHtdzAN3kkHUHQrqUcQ@mail.gmail.com>

On Wed, May 20, 2026 at 03:32:18PM -0700, Ian Rogers wrote:
> On Wed, May 20, 2026 at 2:51 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> >
> > Everything is at
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next
> >
> > I also rebased my perf.data validation (that has some extra fixes, because... Sashiko):
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git perf-data-validation
> >
> > I think I addressed some of your review comments, if bored, take a look,
> > I'll submit as soon as I get what is in tmp.perf-tools-next moved to
> > perf-tools-next which I plan/hope to do later today, after the container
> > build tests finish.
> 
> I'll look at the perf-data-validation branch. Would it be okay to post
> the patches to LKML so that we can get the Sashiko review on them?

I did it, and having passed thru sashiko locally dozens of times it
ended up being rather clean :-)

I'm addressing some of the valid concerns raised now and will send a v2.

- Arnaldo
