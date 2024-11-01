Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D57815B54A
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Nov 2024 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456153; cv=none; b=KBhzTsJ0iLsEmCD5IjtTf7kB9BPptvvV2ZlE/kNOsVfgL8qitAgiQIPmEY4tC4vSTh19+7rJlfVBxD/haR1gQQMCGrX9yGNnQvsS4itZpqUbV7Y0Z96bg14P7oAzWB2ZV6DwXxKaFYvQ9/UumKwwfwxNQGyYRTX92km2jZlV87Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456153; c=relaxed/simple;
	bh=O7f1AW5ah0B37iD4hjZUhsU7DcU0KAoO8CEYUxZk49M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k1D8GSelnm2P4h3KNG4MHWAvXLyJBlj68jitURIpzGvbKxhz+qDzIZhfhpkf+212zJE1schiANVM6aLqJ/NSZbxy+rn6c/B8M8fIl9G3RoDd4cnD0IpomeVdrfZM18onEbHnXgUajSOC1qEzfK9xa0ga7o4KQ6WmI69lVMWiSrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyRtoW7p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyRtoW7p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730456149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=doEJnum2fwcohhAHmQJNEqkbYbxFpkY1i2g1A8ZJggY=;
	b=YyRtoW7przbszzzO9Ej+u1TbUX6Q/yZZnPOYrPO8vmO9fLxTjdsI6j3EL49SicwCcvQPLA
	p3m/7zWocyx3YXoDnKdu2G3h5oXje4bus4gIdKb91M8lPTXhj2CCnl3LHn5yV9QdLa5E6K
	/Pljxxlhaxo/ukXwxB5ro4b9wuqt0Go=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-kGDgJ4fvNMeOCr1TU8-B7A-1; Fri,
 01 Nov 2024 06:15:46 -0400
X-MC-Unique: kGDgJ4fvNMeOCr1TU8-B7A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCECA19560BE;
	Fri,  1 Nov 2024 10:15:45 +0000 (UTC)
Received: from Carbon (unknown [10.39.208.11])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DB841956086;
	Fri,  1 Nov 2024 10:15:42 +0000 (UTC)
Date: Fri, 1 Nov 2024 11:15:39 +0100 (CET)
From: Michael Petlan <mpetlan@redhat.com>
To: linux-perf-users@vger.kernel.org
cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, 
    Namhyung Kim <namhyung@kernel.org>, Arnaldo de Melo <acme@redhat.com>, 
    vmolnaro@redhat.com
Subject: Re: perf test fail :: "perf stat --bpf-counters --for-each-cgroup
 test"
In-Reply-To: <alpine.LRH.2.20.2407191303000.11376@Diego>
Message-ID: <536d5b91-f9ed-99b3-6c17-3d93bf451ffd@redhat.com>
References: <alpine.LRH.2.20.2407191137440.11376@Diego> <CA+JHD90TkDVHPw4jqxMX2guqsg-8xrqD2iiEfZ_akixvVYZKZg@mail.gmail.com> <alpine.LRH.2.20.2407191303000.11376@Diego>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463776256-540947818-1730456144=:9263"
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463776256-540947818-1730456144=:9263
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT


On Fri, 19 Jul 2024, Michael Petlan wrote:
> On Fri, 19 Jul 2024, Arnaldo Carvalho de Melo wrote:
> > On Fri, Jul 19, 2024, 6:50 AM Michael Petlan <mpetlan@redhat.com> wrote:
> >       Hello Namhyung,
> > 
> >       we were investigating some test failures of the testcase mentioned
> >       in $subj. We have narrowed it down to:
> > 
> >           # perf stat -C 0,1 --for-each-cgroup system.slice,user.slice -e cycles -- taskset -c 1 perf test -w thloop
> > 
> >           Performance counter stats for 'CPU(s) 0,1':
> >                <not counted>      cycles                           system.slice
> >                3,020,401,084      cycles                           user.slice                       
> > 
> >                1.009787097 seconds time elapsed
> > 
> >       As seen, the system.slice is not counted properly in our case. It
> >       happens even without bpf-counters being involved.
> > 
> >       There were rumours that it might be caused due to too small system
> >       load, but it apparently happens even when the load was replaced by
> >       "thloop" workload from perf-test's workload library. However, even
> >       so, if the load was insufficient, we'd see a value – 0 instead of
> >       "not counted". The "<not counted>" result is printed if the counter
> >       wasn't properly enabled and running.
> > 
> >       Have you encountered this problem? What could cause it?
> > 
> > 
> > What does running with -vvv says? Some inconclusive error coming from the kernel? 
> 
Hello!

We have been investigating this issue a bit more again and we have come
to conclusion that everything is probably OK, except of the testcase
which in short relies on the fact that taskset can force any system.slice
workload to happen on a particular CPU, which in my opinion does not
apply, being rather random and that's why the test sometimes fails.

To summarize the problem a bit:

1) The $subj testcase sometimes fails.

2) It consists of two parts, one performs counting system-wide and the
second limits the counting to CPUs 0 and 1. The second one sometimes
fails, while the first (systemwide) passes always.

3) The reason why the test fails is because system.slice may get
<not counted> result.

4) There is another problem with this testcase on single-cpu boxes, since
there is no "cpu 1", so we decided to try having "-C 0" and "taskset -c 0"
on such boxes. The problems with getting "<not counted>" disappeared!

---------------------------

So... The systemwide tracing test works:

# perf stat --for-each-cgroup system.slice,user.slice -e cycles -a -- sleep 3
 Performance counter stats for 'system wide':

     8,884,593      cycles            system.slice
     5,645,624      cycles            user.slice

   3.004137451 seconds time elapsed

When we pin the workload AND tracing to particular CPU, it might fail:

# perf stat -C 0 --for-each-cgroup system.slice,user.slice -e cycles -- taskset -c 0 true

 Performance counter stats for 'CPU(s) 0':

     <not counted>  cycles            system.slice
     2,722,263      cycles            user.slice

   0.004184686 seconds time elapsed

Namhyung said that there might be not enough load, which finally appears
to be the problem. But not in the manner that replacing `true` by something
more "heavy" would help, but in the fact that system.slice didn't run on
CPU 0 at all during the `perf stat` counting.

Taskset can pin the process to some CPU, but even without it (or when we
pin it to CPU 3 for example), _some_ user.slice content is always run on
cpu 0, so we get values.

However, there is no guarantee that system.slice will run there. We would
probably need to load more the content that systemd decides to put under
"system.slice" and hope that it will get a chance to run on CPU 0 or 1 or
whatever we use in the testcase.

Of course, the more CPUs the machine has, the higher chance to get the
<not counted> result for system.slice is. That's why -a works and also
that's why it works on a single-CPU machine.

............

Thus, I think that we should simply remove the taskset part of the testcase
and leave only the systemwide part.

Thoughts?

Michael
---1463776256-540947818-1730456144=:9263--

