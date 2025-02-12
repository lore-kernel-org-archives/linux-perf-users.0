Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839B520370D;
	Wed, 12 Feb 2025 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398206; cv=none; b=cKnqbeihzk+9hGfIW9ExI99UbbFbE7Vgq70irKB16WBnM4ckfz4vxVaZkHsFWZsAlsImGZpfBtAp+TuP+MbgqqJOkcPD7j947ktyG10niw7mWUV8KywO4ow054fhbkZgk6jgL5Cr8bAEG1p236euUP9QUBRkrfhZ8REvnVBLKkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398206; c=relaxed/simple;
	bh=+28k4TdfMZqihQFvAU2iFbLst+0jYM8o20C5cyRR1pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fz7xoDPF2kdpUeTXiP1iDUY5ilW+Pb9xNOTE1Aca3+UETEXA7sSCb1M/MBc/bIN7vLn2UNsrYVDfj+aTgk/3wnOuRqAcbQwVaX/1DE2BV+RjfSGH+vR14m5eYe05sFPf5qdMQq/QT05+vyg98ZdAtxKE/KlAiOmNIGz5RIBxBeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXkDrrLj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXkDrrLj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BD0C4CEDF;
	Wed, 12 Feb 2025 22:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739398206;
	bh=+28k4TdfMZqihQFvAU2iFbLst+0jYM8o20C5cyRR1pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XXkDrrLjxUF3bRerz0hGvj4t02fEtD7p97gMcA0kqz7OMgKmas+SvPEWNAnuGsFt6
	 oKzDw3Ku/lKA6WpnNF81d1h3OXfQkmP8CL2/jfcLc3uc7Xs5bmP+iHeikQ4vLIhFzo
	 9gMTEwt+fWLZS0RyuabeqhC8qiqj8dA5ZGkUdWPnfejHVRoMAbvqlridGv0E4jaPAC
	 oqjtLSibNj+QXlUTxyMMkx7WTUbJVVJ0u7mPDcH7ql6IpOjVPa7cZG6vFDmzPlMAJN
	 lqzE+iw0NZC7LGFyEoMzmYr/vuUNmixpJSpfV+fzoOmnNM8I3RUNPTEH1WZx0SkDza
	 C1xhxEcZdXMZQ==
Date: Wed, 12 Feb 2025 14:10:04 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 0/4] perf trace: Add --summary-mode option
Message-ID: <Z60cPJyLRk5N3UxT@google.com>
References: <20250205205443.1986408-1-namhyung@kernel.org>
 <CAH0uvoinT1ZH3Cifj_skJOjfKrvQ8jdbU_3gFp21eD4PwGOwkQ@mail.gmail.com>
 <Z6ztSE_yo2t28w45@google.com>
 <Z60Lrs0U0gIF5oaW@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z60Lrs0U0gIF5oaW@x1>

On Wed, Feb 12, 2025 at 09:59:26PM +0100, Arnaldo Carvalho de Melo wrote:
> On Wed, Feb 12, 2025 at 10:49:44AM -0800, Namhyung Kim wrote:
> > On Fri, Feb 07, 2025 at 09:25:02PM -0800, Howard Chu wrote:
> > > Hello Namhyung,
> > > 
> > > On Wed, Feb 5, 2025 at 12:54 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hello,
> > > >
> > > > I've realized that perf trace shows system call summary at the end for
> > > > each thread.  But sometimes users want to see the global whole system
> > > > summary or statistics instead.
> > > >
> > > > So I've added --summary-mode option like below:
> > > >
> > > >     $ sudo ./perf trace -as --summary-mode=total sleep 1
> > > >
> > > >      Summary of events:
> > > >
> > > >      total, 21580 events
> > > >
> > > >        syscall            calls  errors  total       min       avg       max       stddev
> > > >                                          (msec)    (msec)    (msec)    (msec)        (%)
> > > >        --------------- --------  ------ -------- --------- --------- ---------     ------
> > > >        epoll_wait          1305      0 14716.712     0.000    11.277   551.529      8.87%
> > > >        futex               1256     89 13331.197     0.000    10.614   733.722     15.49%
> > > >        poll                 669      0  6806.618     0.000    10.174   459.316     11.77%
> > > >        ppoll                220      0  3968.797     0.000    18.040   516.775     25.35%
> > > >        clock_nanosleep        1      0  1000.027  1000.027  1000.027  1000.027      0.00%
> > > >        epoll_pwait           21      0   592.783     0.000    28.228   522.293     88.29%
> > > >        nanosleep             16      0    60.515     0.000     3.782    10.123     33.33%
> > > >        ioctl                510      0     4.284     0.001     0.008     0.182      8.84%
> > > >        recvmsg             1434    775     3.497     0.001     0.002     0.174      6.37%
> > > >        write               1393      0     2.854     0.001     0.002     0.017      1.79%
> > > >        read                1063    100     2.236     0.000     0.002     0.083      5.11%
> > > >        ...
> > > >
> > > > Also it changes internal data structure to hash table to track
> > > > statistics of syscalls.  And removes the rb_resort code.
> > > >
> > > > v3 changes)
> > > > * Add Acked-by from Howard
> > > > * Update commit messages  (Ian)
> > > 
> > > Sorry for the delay.
> > > 
> > > Reviewed-by: Howard Chu <howardchu95@gmail.com>
> > 
> > Thanks for your review!
> > 
> > Arnaldo and Ian, are you ok with this?
> 
> I looked at it quickly, some minor nits, apart from that, for the
> series:
> 
> Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks, I'll update them.
Namhyung

