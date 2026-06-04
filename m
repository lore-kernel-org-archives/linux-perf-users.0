Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D5A48A2DF
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Jun 2026 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582655; cv=none; b=N9fWnVakpoHxp+2abwq1RDOege4LdtlRBPiO43HxGB+Mi3fNYhyFNW1enLpm8kKxTDPoYA9IyrkYeyN0/4GAWBbLKwwaJtklCJ2J3hJuYei+TZDrkj4c+4TCmyUFBV6R41p9DqjbqP6UAg4BSkJPopURDHpVm5G3EQvbF4N+6CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582655; c=relaxed/simple;
	bh=kGpjSRzOKA82bb8+D7ji0OxyT6TAkSLhOd0wm3VAgL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7CdPM9njpKnANfuxcgk/JyS4mLQmWsh0t7jSmqYJ0vNTWXtchm2kb0tT8lngLoO6ItyBWWOUGQohN7Do+5p0tq+2BLoPW43DdKldjJf7B0pc9AtLFtCpTxXr7yYlISHfZU09p9QdJ48LDTPP7lHGXDa4SUlzFlqKAkaMq//q28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCULlyQj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCULlyQj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924BC1F00893;
	Thu,  4 Jun 2026 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780582654;
	bh=a23fVnlClqzkGnu4H8lLPL7TNuMOc0N3Wpy71vcyZKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kCULlyQjFdpPWXG4ewMFzM0hHvfv3BE1jLMR+bCTDg8JrJS+unPBUzsVKE6FSqOLF
	 HZW2H2Oxf9EvlUYAZkYnt7EVCN5/8MkRifh6WM0E1Rh3+k00kkZ5mLjO9O2B8rrz+m
	 Xcs/a+EtIo2uHAgpwj+VowrzeTXQx0/qRkePtmVjkI7+pQmH+MKtg+H0/e9mBdkEQS
	 YdjSrfyPrGRUGjIqGGMy3Sa/klvQOxGe74olONPff4xIk/6njjgbdbhn6SrNCM+oaO
	 /fc3AeVL+stfr/0m2PdoLuR1OJf2edRFSZvEPuYXLh5yBQE0YtYhpmbrEvJSI5YfrH
	 1tf577RlKgbVQ==
Date: Thu, 4 Jun 2026 11:17:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Athira Rajeev <atrajeev@linux.ibm.com>,
	Anubhav Shelat <ashelat@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	jolsa@kernel.org, adrian.hunter@intel.com, mpetlan@redhat.com,
	tmricht@linux.ibm.com, maddy@linux.ibm.com,
	linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	hbathini@linux.vnet.ibm.com, Tejas.Manhas1@ibm.com,
	Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: Re: [PATCH] tools/perf/sched: Update process names of processes in
 zombie state for both -s and -S options
Message-ID: <aiGI--j2nJ_kas60@x1>
References: <20260426093930.47809-1-atrajeev@linux.ibm.com>
 <ae76k1BvfgcYI18K@google.com>
 <230801A2-5F9C-42A6-9390-B44786309E30@linux.ibm.com>
 <ag8UFqPmRu8v4g_9@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag8UFqPmRu8v4g_9@x1>

On Thu, May 21, 2026 at 11:17:58AM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, May 21, 2026 at 02:02:53PM +0530, Athira Rajeev wrote:
> > > On 27 Apr 2026, at 11:26 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> > > On Sun, Apr 26, 2026 at 03:09:30PM +0530, Athira Rajeev wrote:
> > >> In redhat perftool testsuite, observed fail for this test:
> > >>    -- [ FAIL ] -- perf_sched :: test_timehist :: --with-summary (output regexp parsing)
> > >> 
> > >> This led to analysis of "perf sched timehist" summary options.
> > >> 
> > >>  # perf sched record -a -o ./perf.data -- sleep 0.1
> > >>   This will record using perf sched record
> > >> 
> > >> perf sched timeliest has two options "-s" and "-S"
> > >>  # perf sched -i ./perf.data timehist -S
> > >> -S : Captures summary also at the end
> > >> 
> > >>  # perf sched -i ./perf.data timehist -s
> > >> -s : Captures only summary
> > >> 
> > >> The test saves -s result which has only summary and compares with
> > >> summary which comes at the end from -S . Since there is a difference
> > >> in these two, test fails.
> > >> 
> > >> Checking the behaviour change in -S and -s results, difference is:
> > >> 
> > >>                  rcu_sched[16]       2          4        0.013      0.001       0.003       0.006   33.23       0
> > >>               migration/11[73]       2          1        0.006      0.006       0.006       0.006    0.00       0
> > >>                migration/3[33]       2          1        0.006      0.006       0.006       0.006    0.00       0
> > >> -               :216753[216753]      -1          1        0.041      0.041       0.041       0.041    0.00       0
> > >> +                 sleep[216753]      -1          1        0.041      0.041       0.041       0.041    0.00       0
> > >>                migration/8[58]       2          1        0.005      0.005       0.005       0.005    0.00       0
> > >>            NetworkManager[811]       1          2        0.089      0.028       0.044       0.060   36.06       0
> > >>               migration/13[83]       2          1        0.005      0.005       0.005       0.005    0.00       0
> > >> 
> > >> Here 216753 is pid for sleep which is a zombie process. This is
> > >> happening in latest kernel due to an update in "-S" result.
> > >> In -S, the process name appears in the results "sleep[216753]",
> > >> where as in the -s, only pid is present in the summary result
> > >> ":216753[216753]".
> > >> 
> > >> After commit 39f473f6d0b2 ("perf sched timehist: decode process names
> > >> of processes in zombie state")
> > >> for -S option, if process name is using pid, it uses different way to
> > >> set it. So that we get the process name and not just Pid.
> > >> 
> > >> This change went in only for timehist_print_sample() function.
> > >> Add this improvement in generic place so that even -s option (which
> > >> captures summary) also will have meaningful information.
> > >> 
> > >> Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> > > 
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > 
> > > Thanks,
> > > Namhyung
> > Hi,
> > 
> > Can we please have this pulled in, if the patch looks fine ?
> 
> Can you please check applying it on top of current perf-tools-next?

So, this seems to be also addressed by:

commit 39f473f6d0b24cf375893f2110b1cc9d8a079a42
Author: Anubhav Shelat <ashelat@redhat.com>
Date:   Wed Jul 16 16:39:15 2025 -0400

    perf sched timehist: decode process names of processes in zombie state

    Previously when running perf trace timehist --state, when recording
    processes in the zombie state the process name would not be decoded
    properly and appears with just the PID:

    1140057.412177 [0006]  Mutter Input Th[3139/3104]          0.956      0.019      0.041      S
    1140057.412222 [0012]  :1248612[1248612]                   0.000      0.000      0.332      Z
    1140057.412275 [0004]  <idle>                              0.052      0.052      0.953      I
    1140057.412284 [0008]  <idle>                              0.070      0.070      0.932      I
    1140057.412333 [0004]  KMS thread[3126/3104]               0.953      0.112      0.058      S

    Now some extra processing has been added to decode the process name:

    1140057.412177 [0006]  Mutter Input Th[3139/3104]          0.956      0.019      0.041      S
    1140057.412222 [0012]  sleep[1248612]                      0.000      0.000      0.332      Z
    1140057.412275 [0004]  <idle>                              0.052      0.052      0.953      I
    1140057.412284 [0008]  <idle>                              0.070      0.070      0.932      I
    1140057.412333 [0004]  KMS thread[3126/3104]               0.953      0.112      0.058      S

    Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
    Link: https://lore.kernel.org/r/20250716203914.45772-2-ashelat@redhat.com
    Signed-off-by: Namhyung Kim <namhyung@kernel.org>


No? It is not applying to perf-tools-next, a quick look found the patch
above.

- Arnaldo
