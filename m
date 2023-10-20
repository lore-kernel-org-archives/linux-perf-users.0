Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E4C1EA90
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Oct 2023 20:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzvtr4Xj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6CEC433C8;
	Fri, 20 Oct 2023 20:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697835049;
	bh=vcCmM+YIN7c3zbhDbrlN4oi4Ii7L05ap0rwyCwo2eA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dzvtr4Xj9ypoLS+Q12yZ5osJJw5wQhZ3fAvNKABzZI+BcIn58Kn3WoEKf3tQt82gy
	 RjLPPab1839fBz5qQoYT8u1URaTMSQlT2WAyU7bgJIFl08cZGEjoQoDNnybx7wFRGv
	 9jDnYy9B/i9UykDg3+8wgt4T+wIODKQrQMJbXep/QhE+SXB83gv87xOV5qEg8jtsbl
	 1Q7XFdI9yhoRMLFBIma2EQystqW7Gr1FSXsjth5HPTzJtlhJcMF+Y5qIM1L4fGUa/3
	 s+N+/TJcfk40rBouMTV1ue2ROGjbHG8si/vf2TJZaqYDsdMGleSn+RAKAfQ8MPy9n6
	 eWe+8cTMte7XQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id A96D24035D; Fri, 20 Oct 2023 17:50:46 -0300 (-03)
Date: Fri, 20 Oct 2023 17:50:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org,
	vmolnaro@redhat.com
Subject: Re: perf sampling count/freq/period strange bahavior
Message-ID: <ZTLoJtlIJi1F2R4F@kernel.org>
References: <alpine.LRH.2.20.2310191027320.11297@Diego>
 <CAM9d7cgxWY3ymyz93h+stWXW7UTdKN6V+T7ZyWZ2wn0j1oi1vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgxWY3ymyz93h+stWXW7UTdKN6V+T7ZyWZ2wn0j1oi1vw@mail.gmail.com>
X-Url: http://acmel.wordpress.com

Em Thu, Oct 19, 2023 at 11:33:19PM -0700, Namhyung Kim escreveu:
> Hello,
> 
> On Thu, Oct 19, 2023 at 1:28 AM Michael Petlan <mpetlan@redhat.com> wrote:
> >
> > Hello all...
> >
> > We have encountered a strange behavior related to sampling. Generally
> > said, the number of samples is usually much lower than it should be.
> >
> > Let's say, for load L, `perf stat -e instructions -- L` shows around
> > 250,000 event hits. If I understand the concept of `-c` option for
> > `perf record`, with `-c 250` it should make the counter overflow and
> > generate a sample for every 250th event hit, so, it should result into
> > ~1000 samples.
> >
> > Instead I am getting something like ~62-150 samples, for example 124.
> > I have checked in dmesg that kernel has not throttled anything. When
> > running `perf report --stdio`, I see in the header that there were 0
> > samples lost (so the buffer was consumed fast enough). Additionally,
> > `perf report --stdio` tries to estimate the actual event count:
> >
> >   Event count (approx.): 31000
> >
> > (Which is because 250 * 124 = 31000, so perf itself considers this
> > formula (n_of_samples * sampling_rate = n_of_events) valid.)
> >
> > But in reality, this is not the case, `perf stat`, as said, never
> > shows that low number of events for the same load.
> >
> > What else is involved in the sampling rates and why the number of
> > samples is so much lower than it should be?
> >
> > Thank you for ideas!
> 
> I don't know but it seems PMU has some internal limit
> on the period and ignores lower values.
> 
> On my Intel machine,
> 
> $ perf stat -e instructions:u true
> 
>  Performance counter stats for 'true':
> 
>            120,024      instructions:u
> 
>        0.002002822 seconds time elapsed
> 
>        0.002040000 seconds user
>        0.000000000 seconds sys
> 
> 
> $ perf record -e instructions:u -c 10000 true
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.002 MB perf.data (12 samples) ]
> 
> $ perf record -e instructions:u -c 5000 true
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.002 MB perf.data (24 samples) ]
> 
> $ perf record -e instructions:u -c 4000 true
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.002 MB perf.data (30 samples) ]
> 
> $ perf record -e instructions:u -c 3000 true
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.002 MB perf.data (40 samples) ]
> 
> $ perf record -e instructions:u -c 2000 true
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.003 MB perf.data (51 samples) ]
> 
> $ perf record -e instructions:u -c 1000 true
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.003 MB perf.data (51 samples) ]
> 
> $ perf record -e instructions:u -c 500 true
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.003 MB perf.data (51 samples) ]

Same thing here, see below.

But if you ask for a small period you'll miss lots of events, right? The
events that take place while you're processing the bigger number of perf
interrupts.

Like lets get an interrupt per instruction: :-)

[root@five ~]# perf record -c 1 -e instructions stress-ng --quiet --cpu 1 -t 2
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.075 MB perf.data (1687 samples) ]
[root@five ~]#

[root@five ~]# perf stat -r5 -e instructions stress-ng --quiet --cpu 1 -t 2

 Performance counter stats for 'stress-ng --quiet --cpu 1 -t 2' (5 runs):

    17,313,307,689      instructions             ( +-  0.17% )

          2.023840 +- 0.000939 seconds time elapsed  ( +-  0.05% )

[root@five ~]# perf record -c 1000000 -e instructions stress-ng --quiet --cpu 1 -t 2
[ perf record: Woken up 3 times to write data ]
[ perf record: Captured and wrote 0.548 MB perf.data (17228 samples) ]
[root@five ~]# perf record -c 1000000 -e instructions stress-ng --quiet --cpu 1 -t 2
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.530 MB perf.data (16627 samples) ]
[root@five ~]# perf record -c 1000000 -e instructions stress-ng --quiet --cpu 1 -t 2
[ perf record: Woken up 3 times to write data ]
[ perf record: Captured and wrote 0.549 MB perf.data (17264 samples) ]
[root@five ~]# perf record -c 2000000 -e instructions stress-ng --quiet --cpu 1 -t 2
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.292 MB perf.data (8839 samples) ]
[root@five ~]# perf record -c 2000000 -e instructions stress-ng --quiet --cpu 1 -t 2
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.284 MB perf.data (8590 samples) ]
[root@five ~]# perf record -c 2000000 -e instructions stress-ng --quiet --cpu 1 -t 2
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.288 MB perf.data (8694 samples) ]
[root@five ~]# perf record -c 4000000 -e instructions stress-ng --quiet --cpu 1 -t 2
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.154 MB perf.data (4313 samples) ]
[root@five ~]# perf record -c 4000000 -e instructions stress-ng --quiet --cpu 1 -t 2
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.154 MB perf.data (4319 samples) ]
[root@five ~]# perf record -c 4000000 -e instructions stress-ng --quiet --cpu 1 -t 2
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.154 MB perf.data (4312 samples) ]
[root@five ~]# perf record -c 1000 -e instructions stress-ng --quiet --cpu 1 -t 2
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.090 MB perf.data (2156 samples) ]
[root@five ~]#

