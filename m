Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B56E286416;
	Wed, 29 Oct 2025 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755118; cv=none; b=eozBlZQEFGyUzrkfRSX2QLyH7k1KgiVzv0okFNA/nCdCgIYDnaP0Q/pNHHYFLFIOnm7AiG+j7Om9r13WAZVrsOVmjjVGZ/cuzTN13t2pQFz09ZbQctgwdGivZJ9y3j+JQPtsAWA1TwskRKVRWuaHeQJuOxsABFQ0L1KNPjkNr2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755118; c=relaxed/simple;
	bh=7UCXhxFAQkX4hGKF8jO2mccSg5UuWXfviYXMhXekzOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nphhKmL897Wv002rosP7FTaSoKbpy8HgCxUTWOc/BF9hG9+OmrZ3P5tCZzmnuEPOhn3I1mNjTsZhfrJ/Gf+g2lOH77Tl/gxpkwdPpBILk3nCUaG79doNNSlpYz44NyjOJlAbMZk1q9hdVBcjxhVcrtG4TDNaqq7y2Vt+uJFvf7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuBTOGtI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuBTOGtI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E8EC4CEF7;
	Wed, 29 Oct 2025 16:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761755117;
	bh=7UCXhxFAQkX4hGKF8jO2mccSg5UuWXfviYXMhXekzOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OuBTOGtISsiYiDhjq8NuYo71luDf78P8fNwJFdRdywNes8abgxtPqigKf2GlHmibf
	 kKb6NVd9mxjJJm/af7kkdBFvWiOyiFqnCNAuY3F6BZpFC+4YDso4ZKLc0OIrO2u6bW
	 35cVkiWxZukmfKpsd1niAMj3R4u6L6kqekQ7uWYhs2+geapiVNwjn4jgp17mSnHvDS
	 MyLlJngBzQaVLCcGQDDK1tIwxZER5wpPDGa4lzKhRC/GJqGDzMqk+H4wxhTkXzI6Iy
	 Fpe0gjR7vJLLH5BItzhd86TqSClN9jit0iH9Wzff1x+LweRyt0i4IpF14I9cPDxwkg
	 tVJqK7GvPTfDQ==
Date: Wed, 29 Oct 2025 13:25:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Howard Chu <howardchu95@gmail.com>, Song Liu <song@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Levi Yun <yeoreum.yun@arm.com>,
	Zhongqiu Han <quic_zhonhan@quicinc.com>,
	Blake Jones <blakejones@google.com>,
	Anubhav Shelat <ashelat@redhat.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Weilin Wang <weilin.wang@intel.com>
Subject: Re: [RFC PATCH v1 12/15] perf evlist: Add reference count
Message-ID: <aQI_6vZUbjhnl4ZJ@x1>
References: <20251029053413.355154-1-irogers@google.com>
 <20251029053413.355154-13-irogers@google.com>
 <aQI_OJziRPMRqzM9@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQI_OJziRPMRqzM9@x1>

On Wed, Oct 29, 2025 at 01:22:21PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Oct 28, 2025 at 10:34:10PM -0700, Ian Rogers wrote:
> > This a no-op for most of the perf tool. The reference count is set to
> > 1 at allocation, the put will see the 1, decrement it and perform the
> > delete. The purpose for adding the reference count is for the python
> > code. Prior to this change the python code would clone evlists, but
> > this has issues if events are opened, etc. This change adds a
> > reference count for the evlists and a later change will add it to
> > evsels. The combination is needed for the python code to operate
> > correctly (not hit asserts in the evsel clone), but the changes are
> > broken apart for the sake of smaller patches.
 
> Looks ok, noisy for all the s/delete/put/ but that is ok, but then you
> are not using the RC_CHK_ACCESS stuff from the get go, why not?
 
> All the prep patches looks ok, assuming they build in succession.

Also I tried to run the test case before the patches on a 9950x3d, AMD,
with ibs and couldn't, some perf.data format error, then on Intel I had
to hit control+c and got a deprecation warning, both, of course
completely unrelated to your work, so just FYI:

root@five:~# perf mem record -a sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 2.247 MB perf.data (12814 samples) ]
root@five:~# time perf script mem-phys-addr
/home/acme/libexec/perf-core/scripts/python/mem-phys-addr.py:49: DeprecationWarning: 'maxsplit' is passed as positional argument
  m = re.split('-|:', line, 2)
^CWarning:
929 out of order events recorded.
Event: cpu_core/mem_inst_retired.all_loads/P
Memory type                                    count  percentage
----------------------------------------  ----------  ----------
100000000-8bfbfffff : System RAM              149050        87.4
  2ac600000-2ad75cfff : Kernel rodata           1567         0.9
  2ad800000-2adc6a47f : Kernel data              517         0.3
  2ae7e8000-2aedfffff : Kernel bss               282         0.2
  2ab000000-2ac54d27e : Kernel code               21         0.0
0-fff : Reserved                               18990        11.1
100000-30093fff : System RAM                    2566         1.5

real	11m46.282s
user	0m1.317s
sys	0m0.344s
root@five:~# grep -m1 'model name' /proc/cpuinfo
model name	: Intel(R) Core(TM) i7-14700K
root@five:~# cat /etc/redhat-release
Fedora release 42 (Adams)
root@five:~# uname -a
Linux five 6.16.9-200.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Sep 25 18:05:50 UTC 2025 x86_64 GNU/Linux
root@five:~#

- Arnaldo
