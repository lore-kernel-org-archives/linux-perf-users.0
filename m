Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0291A9B5B;
	Fri,  8 Nov 2024 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731088236; cv=none; b=ebtRV2AwUQMrVWMQKxEcH07D9cM1wn+S7PH7+KQAB9c2qBiuTKx/ZabysU0DnWGUlMeIHVx9kwCgaDluBOAs833E+7RafVA4qymy1e16wssVw1ZVmdujf5bVG3gY8Zvv/xBL2YmIhFDfuRLP/Ypuycy2LZpItqy16gotm4YUY44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731088236; c=relaxed/simple;
	bh=Vjh4peRHGRK8Ck0N8i5Kou/oF7DnM7DZ7YfjWXGEYTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+ioJftolue/x7geaFItgeb2dZpAj/VufHE0VrMtJXKiH5Q658+F1XU0sTh6WkoQMgJlJBMvsAB+5wuG2Vq6+uppKaon0PPMc9pRNqvTl6kvivdSsJEFzlWSvSNWTsCeiifPBWmqBdOAT0AQjOUA2eNAtCayDAjDnzy02S7rH+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orygR1Rp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orygR1Rp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACD6C4CECD;
	Fri,  8 Nov 2024 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731088235;
	bh=Vjh4peRHGRK8Ck0N8i5Kou/oF7DnM7DZ7YfjWXGEYTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=orygR1Rpm6sanpGa3EOIpoL3FwKpR/VGUMSNPqU7PCTRH2T1zuNBL5yKF5ZTifDoc
	 q/zxybZ0el0KyZjvAekWXCIu8AJwyljuvkvydXdqXpMQQsYEqW/npCO3KxwKQVlsiQ
	 mmY8gqWG6ef+OVdiJmyw7BcJJLfstlGfxY77msn1wUgZZo8sljFHiY6HAjUda0t4c7
	 qsiPQ8w5BPgNNn5RJaWjFlodjPEhpJG/yvJEcp3gvZs94yBT5PorPTYCuNVqr+gK5u
	 4be5K1q9sz3aWuLGaLjBwMu3iWqU6xh7AsYbOernmR4ZYYjpaQhB0rcqgm8iMnaYOw
	 UTHU+0+qrd16Q==
Date: Fri, 8 Nov 2024 09:50:34 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>
Subject: Re: [PATCH v2 3/4] perf test: Don't suppress the libtraceevent
 tests, skip them
Message-ID: <Zy5PaqrVxeIlkqBR@google.com>
References: <20241105142616.761042-1-acme@kernel.org>
 <20241105142616.761042-4-acme@kernel.org>
 <CAP-5=fViyn9Khja2jPa3gDZy0onsqVt20Y3H7e584SdiWXQvQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fViyn9Khja2jPa3gDZy0onsqVt20Y3H7e584SdiWXQvQw@mail.gmail.com>

On Tue, Nov 05, 2024 at 07:50:25AM -0800, Ian Rogers wrote:
> On Tue, Nov 5, 2024 at 6:26 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > As suggested by Namhyung for the "import perf" python binding test, skip
> > the tests that require perf being linked with libtraceevent, telling the
> > reason:
> >
> >   $ make -C tools/perf NO_LIBTRACEEVENT=1
> >   # perf check feature libtraceevent
> >          libtraceevent: [ OFF ]  # HAVE_LIBTRACEEVENT
> >   # ldd ~/bin/perf | grep traceevent
> >   #
> >   # perf test
> >     1: vmlinux symtab matches kallsyms                 : Ok
> >     2: Detect openat syscall event                     : Skip (not linked with libtraceevent)
> >     3: Detect openat syscall event on all cpus         : Skip (not linked with libtraceevent)
> >     4: mmap interface tests                            :
> >     4.1: Read samples using the mmap interface         : Skip (not linked with libtraceevent)
> >     4.2: User space counter reading of instructions    : Skip (not linked with libtraceevent)
> >     4.3: User space counter reading of cycles          : Skip (not linked with libtraceevent)
> > <SNIP>
> >    14: Parse sched tracepoints fields                  : Skip (not linked with libtraceevent)
> >    15: syscalls:sys_enter_openat event fields          : Skip (not linked with libtraceevent)
> > <SNIP>
> >    32: Track with sched_switch                         : Skip (not linked with libtraceevent)
> > <SNIP>
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > Cc: Howard Chu <howardchu95@gmail.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Leo Yan <leo.yan@linux.dev>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Thomas Richter <tmricht@linux.ibm.com>
> > Cc: Veronika Molnarova <vmolnaro@redhat.com>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> This will conflict with:
> https://lore.kernel.org/lkml/20241102165400.75785-7-irogers@google.com/

Let me process that first.

Thanks,
Namhyung

