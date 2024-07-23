Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6819314A4FF
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 09:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727418; cv=none; b=Vq6ZvGe05cHsRJqBS8NfiTl2mm4lz7BKpRQT3QKEEtWU3yS5bq6ae/ASu3FXhCe+09xAMfjagRhkyIx9j8ES+ppXriCm3BCdG4sm2xBlKuv2D8YO2Egnd80uK24IyB1jXh02Xak/4iAk3bTD55F8eCurFw2B8I20oroxD+t4zzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727418; c=relaxed/simple;
	bh=CYHMWuvUrjnjTEoDZcFER9mdAunDHA3CfsYytFrG75s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=frw4zza52xWMpViLZDHARMhY5FYeSnbZAsF7fkCl4pV0HmBUyXryDt1AJhfY+jpSB5Gq9HnDnzKM3sVa3rj+Ecte6lJY6DzhF8/ZJ0vN6cAW2BMwzJ+05kMcuQZ4/f/e8uEwVvG89MZaqX9AY/3c89OC7tOg6Eo/q3SpPOR+OW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTKBU8R9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTKBU8R9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721727415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D4sZ7wUuL2xus0RB9yRdz849dpe58TVdYuIJ0fQ3jW4=;
	b=MTKBU8R9NCGzbvHZTax+DkuncvILTAfSb85E31uQAhJNZvMfVkvJO1+M/dbSvPpqaHE1M7
	R78mv/I77TUah0PByC0apgnwoyA4aAsLblz5EKvLFOCf6QRCoZ0mBp+otR6k2xxqYkenyd
	BWIsDMiI1R0pUyMFl2ztdvt7Mb9sUaI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-Vid7WdEhMjSoTfbD-nTlPw-1; Tue,
 23 Jul 2024 05:36:46 -0400
X-MC-Unique: Vid7WdEhMjSoTfbD-nTlPw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 176101955D47;
	Tue, 23 Jul 2024 09:36:45 +0000 (UTC)
Received: from Diego (unknown [10.39.208.41])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 536B11955D45;
	Tue, 23 Jul 2024 09:36:41 +0000 (UTC)
Date: Tue, 23 Jul 2024 11:36:38 +0200 (CEST)
From: Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To: Namhyung Kim <namhyung@kernel.org>
cc: acme@redhat.com, vmolnaro@redhat.com, linux-perf-users@vger.kernel.org
Subject: Re: perf test fail :: "perf stat --bpf-counters --for-each-cgroup
 test"
In-Reply-To: <CAM9d7cjxnz_MEqSN6EsfrMejhQwGro9yjHoWrnDrugnNWuGipA@mail.gmail.com>
Message-ID: <alpine.LRH.2.20.2407231136060.11376@Diego>
References: <alpine.LRH.2.20.2407191137440.11376@Diego> <CAM9d7cjxnz_MEqSN6EsfrMejhQwGro9yjHoWrnDrugnNWuGipA@mail.gmail.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463784192-1159411632-1721727404=:11376"
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463784192-1159411632-1721727404=:11376
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 19 Jul 2024, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Jul 19, 2024 at 2:50 AM Michael Petlan <mpetlan@redhat.com> wrote:
> >
> > Hello Namhyung,
> >
> > we were investigating some test failures of the testcase mentioned
> > in $subj. We have narrowed it down to:
> >
> >     # perf stat -C 0,1 --for-each-cgroup system.slice,user.slice -e cycles -- taskset -c 1 perf test -w thloop
> >
> >     Performance counter stats for 'CPU(s) 0,1':
> >          <not counted>      cycles                           system.slice
> >          3,020,401,084      cycles                           user.slice
> >
> >          1.009787097 seconds time elapsed
> >
> > As seen, the system.slice is not counted properly in our case. It
> > happens even without bpf-counters being involved.
> >
> > There were rumours that it might be caused due to too small system
> > load, but it apparently happens even when the load was replaced by
> > "thloop" workload from perf-test's workload library. However, even
> > so, if the load was insufficient, we'd see a value – 0 instead of
> > "not counted". The "<not counted>" result is printed if the counter
> > wasn't properly enabled and running.
> >
> > Have you encountered this problem? What could cause it?
> 
> Sometimes, it depends on the system activity.
> I assumed there would be some system operation running
> on the given CPUs at any time.  If not, it can fail..

Thanks for response. However, in such case, I'd expect "0" value instead
of "<not counted>". As far as I understand, "<not supported>" occurs when
an event cannot be even opened, "<not counted>" appears when the event
can be opened, but for example there aren't enough free hardware counters,
so it does not run any counting actually. But for cases when there is not
enough load, we get simply low numerical values, or 0, don't we...

Michael
> 
> Thanks,
> Namhyung
> 
> 
---1463784192-1159411632-1721727404=:11376--

