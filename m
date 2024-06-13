Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA1414534B
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Jun 2024 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718288470; cv=none; b=D0+dMFhE6JNQj5rfb41SRkvq1EF36BT/eSxJBo+WdOJe/SpoK6bykqkRBYRi+tci8cqj+WTQJ+NcVC3pH1dfSMPHNQOVgkK9AKDUxTgkkXTJBt77ZMiW43wUkq1T3MGzgGaA0+Wc0ddrS9BSXSFxd+xR+1KbSI0EMw+USWune7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718288470; c=relaxed/simple;
	bh=Jspl1d1GywPZYVkqhWuY0XahqaS7bgpPMjto1/76bmg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NRhYH22aD3GFlwMIJQ/pS4IMaWow1F5/WFJ2RP3McJzfzxHjBcl2LfoTEX+gUv5g4anHMwT4IQxQ0/ZmnVTTxW4rmPlDQCT3LCdEnpJ0cT4C1V3UWA7repOrD/CY2LolQDNPfVtQuNDSJTcg7+QXUyIZvrk/vJozwOy8JdolwzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XIn99jdn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XIn99jdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718288468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2sY382ef63A+jByq9yvQvkpTk+pyrgjgAZMiFQ865ao=;
	b=XIn99jdnjOXPTGEeZ6TGT1aFuJKD5VkYsa+3LdyQ6utSBaB2EW/PiPJqAxhAPgi/JX+/cg
	zZ+VOqVxbeoaXItaZXf3qLN3XuE1tnE8kArWEnjvNWPNTnw2SNh8NsOdXpCQG+xOh6QbMw
	mDle13QmRkWAID9bzKQalVIvgFEyf8E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-2TdF8GG8NNSpcYuyKdImug-1; Thu,
 13 Jun 2024 10:21:04 -0400
X-MC-Unique: 2TdF8GG8NNSpcYuyKdImug-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D06BC19560BA;
	Thu, 13 Jun 2024 14:21:03 +0000 (UTC)
Received: from Diego (unknown [10.39.208.8])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0B4D1956050;
	Thu, 13 Jun 2024 14:21:01 +0000 (UTC)
Date: Thu, 13 Jun 2024 16:20:58 +0200 (CEST)
From: Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To: Namhyung Kim <namhyung@kernel.org>
cc: vmolnaro@redhat.com, linux-perf-users@vger.kernel.org, acme@kernel.org, 
    acme@redhat.com
Subject: Re: [PATCH] perf test stat_bpf_counter.sh: Remove comparison of
 separate runs
In-Reply-To: <Zl-x8uob6NT3HlfT@google.com>
Message-ID: <alpine.LRH.2.20.2406131407370.4040@Diego>
References: <20240604153111.105548-1-vmolnaro@redhat.com> <Zl-x8uob6NT3HlfT@google.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, 4 Jun 2024, Namhyung Kim wrote:
> On Tue, Jun 04, 2024 at 05:31:11PM +0200, vmolnaro@redhat.com wrote:
> > From: Veronika Molnarova <vmolnaro@redhat.com>
> > 
> > The test has been failing for some time when two separate runs of
> > perf benchmarks are recorded and the counts of the samples are compared,
> > while once the recording was done with option --bpf-counters and once
> > without it. It is expected that the count of the samples should within
> > a certain range, firstly the difference should have been within 10%,
> > which was then later raised to 20%. However, the test case keeps failing
> > on certain architectures as recording the same benchmark can provide
> > completely different counts samples based on the current load of the
> > system.
> > 
> > Sampling two separate runs on intel-eaglestream-spr-13 of "perf stat
> > --no-big-num -e cycles -- perf bench sched messaging -g 1 -l 100 -t":
> > 
> >  Performance counter stats for 'perf bench sched messaging -g 1 -l 100 -t':
> > 
> >          396782898      cycles
> > 
> >        0.010051983 seconds time elapsed
> > 
> >        0.008664000 seconds user
> >        0.097058000 seconds sys
> > 
> >  Performance counter stats for 'perf bench sched messaging -g 1 -l 100 -t':
> > 
> >         1431133032      cycles
> > 
> >        0.021803714 seconds time elapsed
> > 
> >        0.023377000 seconds user
> >        0.349918000 seconds sys
> > 
> > , which is ranging from 400mil to 1400mil samples.
> > 
> > From the testing point of view, it does not make sense to compare two
> > separate runs against each other when the conditions may change
> > significantly. Remove the comparison of two separate runs and check only
> > whether the stating works as expected for the --bpf-counters option. Compare
> > the samples count only when the samples are recorded simultaneously
> > ensuring the same conditions.
> 
> Hmm.. but having a test which checks if the output is sane can be
> useful.  If it's a problem of dynamic changes in cpu cycles, maybe
> we can use 'instructions' event instead (probably with :u) to get
> more stable values?

Hello.

As far as I understand it, nowadays, the test checks two things:

  test_bpf_counters()
    record $workload twice (with and without --bpf-counters)
	check that there are numeric results
	compare the results

  test_bpf_modifier()
    record $workload once with and without modifier (which should be what
	--bpf-counters switch does to the events, right?)
	check that there are numeric results
	compare the results
	
The problem here is not only the "dynamic changes in cpu-cycles", it
is rather in the testcase design itself. A testcase that compares two
metrics should get rid of all possible variable effects that influence it.

The second function actually compares the values correctly, since they
are measured against the same identical workload.

So, in my opinion, a better test design would be:

  (1) check that record without --bpf-counters works as a reference run
  (2) check that record with --bpf-counters works too
      (if not, we may compare to (1) to find out if whole `record` is broken
	  or just the --bpf-counters option)
  (3) possibly run `perf evlist` to check that --bpf-counters has added the
      '/b' modifier
  (4) check with versus without "b", such as current test_bpf_modifier()
      function does

I like what Veronika suggests, it is basically the above, except of (3).

...

In case we want preserve two separate runs in test_bpf_counters() _and_
also check the numbers, then we should:
  - use some more predictable workload:
    - in an ideal case a statically linked simple binary
	- in less-than-ideal case `perf test -w something`
  - use instructions instead of cycles
However, I don't like that idea very much, because of the design principles
mentioned above.

Regards,
Michael

> 
> Thanks,
> Namhyung
> 
> > 
> > Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> > ---
> >  tools/perf/tests/shell/stat_bpf_counters.sh | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/tools/perf/tests/shell/stat_bpf_counters.sh b/tools/perf/tests/shell/stat_bpf_counters.sh
> > index 61f8149d854e..873b576836c6 100755
> > --- a/tools/perf/tests/shell/stat_bpf_counters.sh
> > +++ b/tools/perf/tests/shell/stat_bpf_counters.sh
> > @@ -6,19 +6,19 @@ set -e
> >  
> >  workload="perf bench sched messaging -g 1 -l 100 -t"
> >  
> > -# check whether $2 is within +/- 20% of $1
> > +# check whether $2 is within +/- 10% of $1
> >  compare_number()
> >  {
> >  	first_num=$1
> >  	second_num=$2
> >  
> > -	# upper bound is first_num * 120%
> > -	upper=$(expr $first_num + $first_num / 5 )
> > -	# lower bound is first_num * 80%
> > -	lower=$(expr $first_num - $first_num / 5 )
> > +	# upper bound is first_num * 110%
> > +	upper=$(expr $first_num + $first_num / 10 )
> > +	# lower bound is first_num * 90%
> > +	lower=$(expr $first_num - $first_num / 10 )
> >  
> >  	if [ $second_num -gt $upper ] || [ $second_num -lt $lower ]; then
> > -		echo "The difference between $first_num and $second_num are greater than 20%."
> > +		echo "The difference between $first_num and $second_num are greater than 10%."
> >  		exit 1
> >  	fi
> >  }
> > @@ -44,7 +44,6 @@ test_bpf_counters()
> >  	base_cycles=$(perf stat --no-big-num -e cycles -- $workload 2>&1 | awk '/cycles/ {print $1}')
> >  	bpf_cycles=$(perf stat --no-big-num --bpf-counters -e cycles -- $workload  2>&1 | awk '/cycles/ {print $1}')
> >  	check_counts $base_cycles $bpf_cycles
> > -	compare_number $base_cycles $bpf_cycles
> >  	echo "[Success]"
> >  }
> >  
> > -- 
> > 2.43.0
> > 
> 
> 

