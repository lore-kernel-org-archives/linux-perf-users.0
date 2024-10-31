Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46322149C53
	for <linux-perf-users@vger.kernel.org>; Thu, 31 Oct 2024 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730374369; cv=none; b=Quw6h1LuLU7hU1PnHCLWAEXAViq5GRIrwKqgyoka2Ks2t7OeYXaZRiLCS0Dj4Vk/S9o5Tl2B0XPIskI6IvN+Rc6y9nev9xMXgigPdnEfipG7VQys9zjboOCmi5mS+JqgI3ROihEsMJnt9vt82Ml8u9O/3/Is5K+RmrzSj9e9Dhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730374369; c=relaxed/simple;
	bh=0jnLJL+TyYTEXBKTAG9x6W1q/j7nmnKzIT6FDzcMNqg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sU1cuDimX8Z/S/0NIXXBIgaKBphiWaQzzUyfWEzGhihPFMHywNRGx3jWI80etlSzsUgNeK7FIj9OyuaZB85QDhJBPB5T8LMWUhcvhrjtIzCeZVlg5IrPp6L7PTTwlxznkrC9BJ3SCbdSv3c72W68ZSS7Iuz5QbtQZ2ZwqjLxS9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ao+3nftM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ao+3nftM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730374366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jwu/aoLO9YK4nuC4V0476umiEleaBJSsHSf3gNfQUN8=;
	b=Ao+3nftMbf7jrnJmAHDaQSRgBcF+l5aflA5KgEU3Rcwprt+eoRaDL0kWxc7Z0bPKk+9rdX
	NqVEkmKez04Ps+ZmMEZa2wOZkaSthRaku01J1n2ZwMON6SNdyZYrg6fYADYpolhc+kMzGt
	oMx70eY/KQfrnhexHQQ1PX3BlJoc7Sc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-DeuoOVNmO_uuRyixYskZ0g-1; Thu,
 31 Oct 2024 07:32:42 -0400
X-MC-Unique: DeuoOVNmO_uuRyixYskZ0g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80F881955F41;
	Thu, 31 Oct 2024 11:32:41 +0000 (UTC)
Received: from Carbon (unknown [10.39.208.11])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45FDA1956046;
	Thu, 31 Oct 2024 11:32:38 +0000 (UTC)
Date: Thu, 31 Oct 2024 12:32:31 +0100 (CET)
From: Michael Petlan <mpetlan@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>
cc: vmolnaro@redhat.com, linux-perf-users@vger.kernel.org, mpetlan@redhat.com, 
    kan.liang@linux.intel.com, irogers@google.com, acme@redhat.com, 
    ak@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: Re: perf sched timehist --state vs perf script
In-Reply-To: <ZyF_JDYF4wgEmbrW@google.com>
Message-ID: <a8297e65-97fc-507c-1b73-7547374688c@redhat.com>
References: <20241024163630.24882-1-vmolnaro@redhat.com> <ZyF_JDYF4wgEmbrW@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, 29 Oct 2024, Namhyung Kim wrote:
> On Thu, Oct 24, 2024 at 06:36:30PM +0200, vmolnaro@redhat.com wrote:
> > From: Veronika Molnarova <vmolnaro@redhat.com>
> > 
> > Hello!
> > 
> > We encountered an issue with 'perf sched timehist --state' when
> > we expected for a test case that the process of a workload would 
> > eventually end in the dead state(marked by 'X') and be switched
> > out. This can be seen also by using 'perf script':
> > 
> >     # perf sched record -a sleep 1
> >     [ perf record: Woken up 1 times to write data ]
> >     [ perf record: Captured and wrote 0.167 MB perf.data (166 samples) ]
> >     # perf script | grep sleep
> >            sleep  151541 [000] 193461.410617: sched:sched_stat_runtime: comm=sleep pid=151541 runtime=3132275 [ns]
> >            sleep  151541 [000] 193461.410624:       sched:sched_switch: sleep:151541 [120] S ==> swapper/0:0 [120]
> >          swapper       0 [000] 193462.410688:       sched:sched_waking: comm=sleep pid=151541 prio=120 target_cpu=000
> >          swapper       0 [000] 193462.410698:       sched:sched_switch: swapper/0:0 [120] R ==> sleep:151541 [120]
> >          :151541  151541 [000] 193462.411100: sched:sched_stat_runtime: comm=sleep pid=151541 runtime=407210 [ns]
> >          :151541  151541 [000] 193462.411107:       sched:sched_switch: sleep:151541 [120] X ==> swapper/0:0 [120]
> > 
> > But for the 'perf sched timehist --state' the process is shown
> > in the zombie state when it is being switched out:
> > 
> >     # perf sched timehist --state | grep 151541
> >     Samples do not have callchains.
> >       193461.410624 [0000]  sleep[151541]                       0.000      0.054      3.129      S 
> >       193462.411107 [0000]  :151541[151541]                     0.000      0.000      0.408      Z 
> > 
> > Shouldn't both commands report the same result, or is there a reason
> > why 'perf script' uses the dead state while 'perf sched' uses dead?

Hello! Thanks for reacting!
> 
> I remember there was a discussion related to this.
> 
> https://lore.kernel.org/all/20240122070859.1394479-2-zegao@tencent.com/
> 
> And it seems it's fixed both in perf and libtraceevent.  Maybe your
> libtraceevent is somewhat outdated and doesn't have the update.
>
Yes! When we've updated libtraceevent to 1.8.3, both show Z now, which is
probably correct.

Then it comes into my mind whether shouldn't perf-sched and perf-script
both take it from libtraceevent to unify the approaches, rather than
perf-sched using its own implementation and perf-script taking it from
libtraceevent... ?

> > It also seems that the 'perf sched' cannot read the name of the zombie
> > process, but that can be a different issue.
> 
> Hmm.. right.  It should update thread->comm using the sched_switch event.

According to the tests, the name seems that it used to be translated correctly
in past, so it'd be nice if it worked again, althoug it is pretty clear which
process it was, according to the PID. Thus, the test can be adjusted to search
for the combination "PID, status Z", instead of "command, status Z"... I.e. to
accept the current situation...

Thanks,

Michael

> 
> Thanks,
> Namhyung
> 
> 

