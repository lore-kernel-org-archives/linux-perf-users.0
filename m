Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C61B86D2
	for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721387116; cv=none; b=GWXJrEPhMXnV04RM+mUUsuhTXQIMM2vzTmro2WPPrX+l3JLJETwHsKVD+jWXT6/iayapybCk/MGY9cHPDh5MAZT/r8xIBFyWwNvxBko41qU2Be+VCZLZGOS3GaEWLYeIerRC6nZt8qW5sQHWX3lbI4Mr6E0c/7nRIL/v/5Eq4xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721387116; c=relaxed/simple;
	bh=wkfFohn4deEjb8Iy5ovU1RSbs/JoiplJv6KChrzbsM0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iyU9PnfEbAYaGejDGNTV37nW2tqH++AHDyTAkSCmYUvGb80zgKynextMVTnZz2e7ijNoKxlcZlnd9a2eVbmf6LHHFuVjaBUawvuphZ0r72WOnyWuDrOEvEsQtaxHItgcMnAhn8KK0r6/F9WsWugxMU72ldwjmsB1giTm4OQ4aTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UCWx3Fc6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UCWx3Fc6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721387113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1knaMNnm4FbRUHdv7x8gQ7HXIFexClM5P6ITONvaC94=;
	b=UCWx3Fc6+Nfet3idYs/Fh8L8hqXF/NSIay2NvLh1cupf7tzCiycPYAFq7yN3FbXpByxTaB
	eWJJq1yHTabAKg7lQkpcYebFx15XREkjCRs9jrJppqKqw85NZVJ2z7psDrG9Q9Dv5lLrIN
	mHpRtSvV6WYHVWOshZDsjpqII0evmPY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-m-VwlFWcOhiFA01A03WRQw-1; Fri,
 19 Jul 2024 07:05:11 -0400
X-MC-Unique: m-VwlFWcOhiFA01A03WRQw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1CF519560B1;
	Fri, 19 Jul 2024 11:05:09 +0000 (UTC)
Received: from Diego (unknown [10.39.208.33])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03C011955E80;
	Fri, 19 Jul 2024 11:05:06 +0000 (UTC)
Date: Fri, 19 Jul 2024 13:05:02 +0200 (CEST)
From: Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo de Melo <acme@redhat.com>, 
    vmolnaro@redhat.com, linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: perf test fail :: "perf stat --bpf-counters --for-each-cgroup
 test"
In-Reply-To: <CA+JHD90TkDVHPw4jqxMX2guqsg-8xrqD2iiEfZ_akixvVYZKZg@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.2407191303000.11376@Diego>
References: <alpine.LRH.2.20.2407191137440.11376@Diego> <CA+JHD90TkDVHPw4jqxMX2guqsg-8xrqD2iiEfZ_akixvVYZKZg@mail.gmail.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463784192-1564810635-1721387109=:11376"
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463784192-1564810635-1721387109=:11376
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 19 Jul 2024, Arnaldo Carvalho de Melo wrote:
> On Fri, Jul 19, 2024, 6:50 AM Michael Petlan <mpetlan@redhat.com> wrote:
>       Hello Namhyung,
> 
>       we were investigating some test failures of the testcase mentioned
>       in $subj. We have narrowed it down to:
> 
>           # perf stat -C 0,1 --for-each-cgroup system.slice,user.slice -e cycles -- taskset -c 1 perf test -w thloop
> 
>           Performance counter stats for 'CPU(s) 0,1':
>                <not counted>      cycles                           system.slice
>                3,020,401,084      cycles                           user.slice                       
> 
>                1.009787097 seconds time elapsed
> 
>       As seen, the system.slice is not counted properly in our case. It
>       happens even without bpf-counters being involved.
> 
>       There were rumours that it might be caused due to too small system
>       load, but it apparently happens even when the load was replaced by
>       "thloop" workload from perf-test's workload library. However, even
>       so, if the load was insufficient, we'd see a value – 0 instead of
>       "not counted". The "<not counted>" result is printed if the counter
>       wasn't properly enabled and running.
> 
>       Have you encountered this problem? What could cause it?
> 
> 
> What does running with -vvv says? Some inconclusive error coming from the kernel? 

Nothing obvious:

# perf stat -vvv -C 0,1 --for-each-cgroup system.slice,user.slice -e cpu-clock taskset -c 0 perf test -w thloop
Using CPUID GenuineIntel-6-6A-6
Control descriptor is not initialized
Opening: cpu-clock 
------------------------------------------------------------
perf_event_attr:   
  type                             1 (PERF_TYPE_SOFTWARE)
  size                             136
  config                           0 (PERF_COUNT_SW_CPU_CLOCK)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 3  cpu 0  group_fd -1  flags 0xc = 5
Opening: cpu-clock 
------------------------------------------------------------
perf_event_attr:   
  type                             1 (PERF_TYPE_SOFTWARE)
  size                             136
  config                           0 (PERF_COUNT_SW_CPU_CLOCK)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 4  cpu 0  group_fd -1  flags 0xc = 6
Opening: cpu-clock
------------------------------------------------------------
perf_event_attr:
  type                             1 (PERF_TYPE_SOFTWARE)
  size                             136
  config                           0 (PERF_COUNT_SW_CPU_CLOCK)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 3  cpu 1  group_fd -1  flags 0xc = 7
Opening: cpu-clock
------------------------------------------------------------
perf_event_attr:   
  type                             1 (PERF_TYPE_SOFTWARE)
  size                             136
  config                           0 (PERF_COUNT_SW_CPU_CLOCK)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  exclude_guest                    1
------------------------------------------------------------
sys_perf_event_open: pid 4  cpu 1  group_fd -1  flags 0xc = 9
cpu-clock: 0: 0 0 0
cpu-clock: 0: 1004758163 1004761145 1004761145
cpu-clock: 1: 0 0 0
cpu-clock: 1: 60896 62271 62271
cpu-clock: 0 0 0   
cpu-clock: 1004819059 1004823416 1004823416

 Performance counter stats for 'CPU(s) 0,1':

     <not counted> msec cpu-clock                        system.slice
          1,004.82 msec cpu-clock                        user.slice       #    0.999 CPUs utilized

       1.005824026 seconds time elapsed

Some events weren't counted. Try disabling the NMI watchdog:
        echo 0 > /proc/sys/kernel/nmi_watchdog
        perf stat ...
        echo 1 > /proc/sys/kernel/nmi_watchdog

....

The nmi_watchdog message is irrelevant, it does not work no matter what is set there.

> Maybe retsnoop can narrow it down? 

Will try. Thanks.
> 
> https://github.com/anakryiko/retsnoop
> 
> - Arnaldo 

Michael
> 
> 
> 
>       Thanks.
>       Michael
> 
> 
> 
---1463784192-1564810635-1721387109=:11376--

