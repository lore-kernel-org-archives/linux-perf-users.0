Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002420;
	b=M9I+fA7XHa24+0nt4Pw8yWxZKpcursn2MeDLwJ+sWKtbDDVBqelh1/KGnqVdU39uu15g
	 7D5TFmhKu5i58dOxXyJXjyvPzY1Ek9TOUPk4YuzXzPik/MemCpj0odp20yYMeiWkUFlvR
	 Vg9Qadz54/y1hHJt8iN0GQ9EgX6pSbYzM8zHchzp083DAo9r3Vs0GATNdXJgGmdIgTlaG
	 Z8E41c9Cabi+q+XGXkghtz5rNHUDfDYtOSYRm7tnhcOkycn9KFyheWyPvTnee2ItUl6xI
	 uv5zUz+lkR5O9jhAL/vzO7VhWwTqq8jpIcqlFkY3qdGCbYGGjU2t6dPt9GncD5piTAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002420;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=IuoFEhM7y/Ir8t0bUQrpUbUmOEEMOOlzKhyofsZQDpE=;
	b=Z49xavmYk56a6SZ70yqqiMKDlCF2virNA8Df99IPcW80LmxxlS8rwpZrRRMrRfPN+RhU
	 WgDe/JjYSzGMKedYJXRwE4aYkS8EcTVw7b0jKAdnKNOWLRS+MCh3BDWxs15Yj0GNfLu5j
	 4bxsjBjtfGar6kEsAHeYVWb2rxR+Ok2oFadKY9kvudclr3PAquW6bnl9wDRqjmSeFdW9R
	 fphH5caqdf7a7RhHIRezkURTcXZOcyelE0Og190fC1T9JV7/ppDWCkI/4WAPX5uOx9JAN
	 nX3DHHMsb94PSNFxyb9E6c70/eGL3rrySoqslxBI6p7dMPulsIsRThlfIxRtSydhsEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+daBBRl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C091606A32C;
	Fri,  6 Nov 2026 22:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e+daBBRl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1301F008A1;
	Fri,  6 Nov 2026 22:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794002420;
	bh=IuoFEhM7y/Ir8t0bUQrpUbUmOEEMOOlzKhyofsZQDpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e+daBBRlyPrcngQ5c1LWVrzzqQA4zVWhtrQj9nYfSBbmRIn+xllUHdLE1Pu9A+IGX
	 ydQ2VOqDElmza8O95KjteFywEWDnjQaeEKda3OyXxDP3PmFdNwGfVCJBQ1LWX2vGVM
	 LxCnGkIkYtIislrjzuF43hwmsOLXl+4mHL2J10dw8+DmujbETie0x3NLCA3cMr4G0L
	 kbpzRFRkS8Z9FT4G9kEgfGu/sSNVLc9dydZmFd90l2QrIin/OsGQhfFyuewBniZDpZ
	 8l+RMjujd3Oq5pg5u5Dk/oTKp/yPryiy34r2cnVeqoKJ9EB2QT96bDZ/RcpUQq13H6
	 6V+dFT2TgR15g==
Date: Fri, 6 Nov 2026 19:00:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Chun-Tse Shao <ctshao@google.com>, Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf stat: Fix aggregation of cgroup events
Message-ID: <au5N8EWajWX2kEOR@phoenix2>
References: <20261002054832.64980-1-namhyung@kernel.org>
 <CAJpZYjXK2qhkCn_ixge_1vEKjXzn_4tzPT=i9NqYg6HbYdWG6Q@mail.gmail.com>
 <as_GbmeRJ3MtwaVD@google.com>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <as_GbmeRJ3MtwaVD@google.com>

On Wed, Oct 14, 2026 at 11:14:06AM -0700, Namhyung Kim wrote:
> On Fri, Oct 02, 2026 at 10:13:29AM -0700, Chun-Tse Shao wrote:
> > On Thu, Oct 1, 2026 at 10:48 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > I got a report that perf stat with BPF and cgroup is broken with
> > > aggregation like per-socket or node.  On my machine, running the
> > > following command shows the problem.
> > >
> > >   $ sudo perf stat -a --bpf-counters --per-socket -e cycles \
> > >     --for-each-cgroup /user.slice,/system.slice  sleep 1
> > >
> > >    Performance counter stats for 'system wide':
> > >
> > >   S0       12      <not counted>      cpu_atom/cycles/                 user.slice
> > >   S0       16      <not counted>      cpu_core/cycles/                 user.slice
> > >   S0       12      <not counted>      cpu_atom/cycles/                 system.slice
> > >   S0       16      <not counted>      cpu_core/cycles/                 system.slice
> > >
> > >          1.002798147 seconds time elapsed
> > >
> > > That's because there's a logic to make the whole event failed if result
> > > from any CPU looks bad when aggregation is enabled.  Normally it
> > > considers bad when an event has no enabled and running time.  But it's
> > > possible for a cgroup event to have no chance to run on some CPU during
> > > the window and then it will have 0 enabled and running time.  Let's not
> > > treat them as errors.
> > >
> > > After the fix, the same command produces:
> > >
> > >    Performance counter stats for 'system wide':
> > >
> > >   S0       12          5,094,112      cpu_atom/cycles/                 user.slice
> > >   S0       16         28,075,944      cpu_core/cycles/                 user.slice
> > >   S0       12          1,516,568      cpu_atom/cycles/                 system.slice
> > >   S0       16          5,569,575      cpu_core/cycles/                 system.slice
> > >
> > >          1.003231856 seconds time elapsed
> > >
> > > Reported-by: Chun-Tse Shao <ctshao@google.com>
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Tested-by: Chun-Tse Shao <ctshao@google.com>
> 
> Thanks for the test!
> 
> Arnaldo, can you please take this?
> 

applied, 

- Arnaldo

> Thanks,
> Namhyung
