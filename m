Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9104F68AF;
	Thu,  1 Oct 2026 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846341; cv=none; b=gKyBmOKnm+ujtoKC1bfQU1gwNW9NpGOwuRDjrW9eqBmj44i81Ob8lKA/AqF3sdza+TKL1nhjEkW22HRFy2YbuxF958kAyuIDgdZKxDDWcVgQ7hIlRvXWkLBLJk7WnbjOjZSoCID7KGrEdBWQe0pgGJeTI3Pmmd7C5flGpmeN2ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846341; c=relaxed/simple;
	bh=rsOrDKySarF4lzOKp/zVbyCJsr4KVv/PFpaOf5FOgGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxKut9m6y3R2sn+uxys5WPdigZL+2zc4NZ9ItDGCC1pqN4dcL/J77+R32VuOSDgr8B3NPUN77sbcm83jr+/SNjRsfqcdOzJfy9sCAclGLYy9vP+E7q6swSDb28Q/K+TlE977XO1JUZT1wLcBcsRFbbO0UtgwYDRYlH8uv+gamEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJ17CkwC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJ17CkwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373C31F000FF;
	Thu,  1 Oct 2026 09:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790846338;
	bh=NEMYsYoh0zLM6MX2d4GEHmeupSY9q/dyDwBaUl3IMQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NJ17CkwCfvcUS4+GMqGj8CZnWct+4t8/OxYH/aE9I6E0rUQT2Fe9s/CLuNqZAOMIx
	 eXSb7/4UcFQOHN/77X0oN+oY90tpc8y5CIoqLjVb3hgN29EIPRR6r2me9xMY0rBrAS
	 5IvMTNxhCIC9AZYtPCFdchVrV6tgEWHER+puN5AQ4TNibSfxvp9CyQ4eqgjQPW/ffU
	 oWF0eWNMGw6ZE403D4SgFFXEKkf1xrjo7ztkoYhv2rMR8qjSOmj+4JlU2gWobdCnhE
	 xX8l5JedVFMQVcnqea5MjpbGWVafS2rhNvqS5199/UA5M3QfGs7YbD5Sa6b/wi/J45
	 OyaO0cGfvR3hg==
Date: Thu, 1 Oct 2026 11:18:54 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v6 5/5] perf test: Add false_sharing workload exhibiting
 cross-CPU false sharing
Message-ID: <ar4lfjssCX9H2CCL@x2>
References: <20260930213716.2633750-1-acme@kernel.org>
 <20260930213716.2633750-6-acme@kernel.org>
 <ar4LjQ8ryDjWDQ9y@z2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar4LjQ8ryDjWDQ9y@z2>

On Thu, Oct 01, 2026 at 12:28:13AM -0700, Namhyung Kim wrote:
> On Wed, Sep 30, 2026 at 11:37:16PM +0200, Arnaldo Carvalho de Melo wrote:
> > Add a 'perf test -w false_sharing' workload that hammers one shared
> > struct from several CPUs, shaped as a TCP connection: a read-mostly
> > identity (five-tuple) shares a cacheline with per-packet rx counters
> > (the false-sharing line), a second line has packet-path private tx and
> > congestion control counters, and a third the connection config.

> > The packet path runs in the main thread and up to four lookup threads
> > sum the five-tuple and pull the config, reading one volatile shared
> > instance directly so the accesses are PC-relative and resolvable by the
> > data type profiler.
> 
> It'd be great if you can share an output of data type profiling with
> cacheline info.  Probably like below?
> 
>   $ perf mem record -- perf test -w false_sharing
>  
>   $ perf report -s type,typecln -H --group --stdio

Sure, I should've added it there as I usually do :-\

Here it is, will add to the cset message as well:

root@x2:~# perf mem record -- perf test -r5 -w false_sharing
[ perf record: Woken up 19 times to write data ]
[ perf record: Captured and wrote 5.612 MB perf.data (72454 samples) ]
root@x2:~#
root@x2:~# perf report -s type,typecln -H --group --stdio
# Total Lost Samples: 0
#
# Samples: 72K of events 'cpu/mem-loads,ldlat=30/P, cpu/mem-stores/P'
# Event count (approx.): 1261814616
#
#            Overhead  Data Type / Data Type Cacheline
# ...................  ...............................
#
    88.99%  35.88%     struct net_conn
       56.43%  17.50%     struct net_conn: cache-line 0
       32.55%   0.00%     struct net_conn: cache-line 2
        0.01%  18.38%     struct net_conn: cache-line 1
    10.08%  63.03%     (unknown)
       10.08%  63.03%     (unknown): cache-line 0
     0.82%   0.13%     int
        0.82%   0.13%     int: cache-line 0
     0.01%   0.02%     struct folio
        0.01%   0.02%     struct folio: cache-line 0
     0.01%   0.03%     Elf64_Addr
        0.01%   0.03%     Elf64_Addr: cache-line 0
     0.01%   0.03%     struct sched_entity
        0.01%   0.03%     struct sched_entity: cache-line 1
        0.00%   0.00%     struct sched_entity: cache-line 4
        0.00%   0.00%     struct sched_entity: cache-line 2
        0.00%   0.00%     struct sched_entity: cache-line 3
        0.00%   0.00%     struct sched_entity: cache-line 0
     0.01%   0.00%     struct task_group
        0.01%   0.00%     struct task_group: cache-line 4
        0.00%   0.00%     struct task_group: cache-line 5
     0.00%   0.00%     struct css_rstat_cpu
        0.00%   0.00%     struct css_rstat_cpu: cache-line 0
root@x2:~#
root@x2:~# perf report -s type,typecln,typeoff -H --group --stdio
# Total Lost Samples: 0
#
# Samples: 72K of events 'cpu/mem-loads,ldlat=30/P, cpu/mem-stores/P'
# Event count (approx.): 1261814616
#
#               Overhead  Data Type / Data Type Cacheline / Data Type Offset
# ......................  ..................................................
#
    88.99%  35.88%        struct net_conn
       56.43%  17.50%        struct net_conn: cache-line 0
           9.81%   0.00%        struct net_conn +0xa (dport)
           9.54%   0.00%        struct net_conn +0x8 (sport)
           9.53%   0.00%        struct net_conn +0xc (state)
           9.48%   0.00%        struct net_conn +0xd (protocol)
           9.27%   0.00%        struct net_conn +0x4 (daddr)
           8.79%   0.00%        struct net_conn +0 (saddr)
           0.00%  12.08%        struct net_conn +0x10 (bytes_rx)
           0.00%   1.71%        struct net_conn +0x18 (packets_rx)
           0.00%   2.80%        struct net_conn +0x20 (rx_queue)
           0.00%   0.91%        struct net_conn +0x3c (last_ack)
       32.55%   0.00%        struct net_conn: cache-line 2
           5.70%   0.00%        struct net_conn +0x83 (rcv_wscale)
           5.46%   0.00%        struct net_conn +0x84 (keepalive_int)
           5.43%   0.00%        struct net_conn +0x82 (snd_wscale)
           5.39%   0.00%        struct net_conn +0x80 (mss)
           5.34%   0.00%        struct net_conn +0x88 (mark)
           5.23%   0.00%        struct net_conn +0x8c (priority)
        0.01%  18.38%        struct net_conn: cache-line 1
           0.01%   0.05%        struct net_conn +0x5c (retrans)
           0.00%   4.83%        struct net_conn +0x40 (bytes_tx)
           0.00%  10.63%        struct net_conn +0x48 (packets_tx)
           0.00%   1.54%        struct net_conn +0x58 (rtt_us)
           0.00%   1.07%        struct net_conn +0x50 (cwnd)
           0.00%   0.25%        struct net_conn +0x54 (ssthresh)
    10.08%  63.03%        (unknown)
       10.08%  63.03%        (unknown): cache-line 0
          10.08%  63.03%        (unknown)
     0.82%   0.13%        int      
        0.82%   0.13%        int: cache-line 0
           0.82%   0.13%        int +0 (no field)
     0.01%   0.02%        struct folio
        0.01%   0.02%        struct folio: cache-line 0
           0.01%   0.00%        struct folio +0 (flags.f)
           0.00%   0.01%        struct folio +0x34 (_refcount.counter)
           0.00%   0.00%        struct folio +0x18 (mapping)
:
