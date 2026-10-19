Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792435992;
	b=1mx95UnmtTkT2ERkmWDgOLDYTwu/etIRM1CrRXZ7YP72KrzRkGsw9r1C57WUcW9acx1q
	 vjSl7gxwLHrjAyHQ873++RuZT7ATTkWZ516xrQQslEZyMWWYfnyHAugROkYpViPsTgMEu
	 BIcz7jQ9At0WJOs5EDP7wjp5z2kHyZkXf/PwdjgUOlP8zyIHH+eZ2QVs7jp13REhBLegh
	 0dgqBI79ybWGlm5HrZXgkLEQXUwu5EcFDtO8J1rFfMXrJI5OiTKu6v1rVur22C+LoOLyp
	 tnw1NCrlY/Y3BCRffQUxCqRCF4q7NyUxI05bZRmSKgldcHJQLLXtTNmVJ7DcxvAIxiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792435992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=U0OPXpDCVqLBQpzhnWrzkRzYhRBBjTJwu5vXYqV+PdU=;
	b=YqWQM8O5WCQ8Ww0v4QmXxKCZFF5uUV+e/4QTJQtmz1LmLfuou6BQU9TurbMsl34Tuu5z
	 GnzKP4gbVFTmY1Ve9mnEl4+YrErEG9kuPEn+rPMWifKEhjgpRtfHtrZzgrLLmApPZCuIB
	 7d7E6X7hCpQrkM+qVrHRYyPIsInrWFh5SvN2NUxdBUEw+Jm9Aj9CO5RMov/lQ5xlODACB
	 e+vshBD8RwGf34RGntS1o9mTGmi02CLO3qnJpttAJ1FvTQOzC37pqcddiR6Ptem2OXCt2
	 96OvFO2NCwz3VRhdbk6LXGRgy3A9BN2MEZMkL3uKfRvyMNJndGwB6aPt5m123mXL9Mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DOsT1NNS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B98A606A321
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 18:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B98A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DOsT1NNS
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so860588a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Oct 2026 11:53:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792435992; cv=none;
        d=google.com; s=arc-20260327;
        b=inuiXiEJI6tbntTWHxG7FUa8mKAIU2W/O2WewaD44Ug9KMr1s7c6gBONUR0r0hlgaj
         Sy+2/0776/RMD08LqZOliQoED2Wjj7mB8eCJSJMwwKI/pODDpS/6VymkEZh+MZ3zTNEI
         N0DH1zX16itw1AdJZbckpSXPrKNjDl6R+hxZ1bxHMVyQwCahdvaFokE/8qZnikNkY8P8
         TJneEu20xGSekUbYPjQK8sFd86NWU5KeWSBESoHZqMi7bYWLkUKtRMaYl2FThIH2T62K
         wpDTtkT73nw6iBHHsm7KELrAWUbLJNrCsqfZ2hVVXvzRBzeISVbXf4LgPAwQJIyASCTq
         VKdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U0OPXpDCVqLBQpzhnWrzkRzYhRBBjTJwu5vXYqV+PdU=;
        fh=x14mBKnhS+mW15YbbdehxExnHgUOA1YrS8bk0F3J230=;
        b=iNhcU4TSD+AevD1N+/JBg6gHe3k3ULqh4/NW2ZxJTiu53akj5F17abZ8jNS3UbAo7O
         jZN7lOCqq+YaO20ykOt8OKuJHe9SF+Zeq9Y+k+KwVRB+QQYDKlX/yJEo5WIq0TE4LrCB
         IQ0yB7p0SGUSQOX99wEbHF4WRAnhG6uMsblb45xcYpen2nnzLNVe5VqU6b4PuZG23YTK
         N3hGRqjSVntcLAjDjdAAJpI4XWvXVMQcXsw6awNfQmJWPp1XZZipoc/OTRwh171zVNZ2
         F82AkM+RE2IQxwMLVszq92bAyHp3LVnmFkn8QueZCW2VRap/3P7w9Vq7GpJUM4L3jsoq
         GSzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792435992; x=1793040792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U0OPXpDCVqLBQpzhnWrzkRzYhRBBjTJwu5vXYqV+PdU=;
        b=DOsT1NNSJKlA/uY2lImfOMWlM2PpdpUfyChND1lpSPqVsgMsk1pqU/rY8ral8PHrbW
         lofgdd2YHUQfG3pK/1GbMc6xWMLdGiT+Bt7mK5shbNnRna/Ot8SuE95csawvabM/Czut
         e8Zn79YeiiCo6l3bpwSdnKuX0YSzzvx4Q7m9HpxpqTKUO7H8jRFbBzrAeT1bfqwQKRM5
         HKLVX8lUh91v+Xulae5VuAr9lMgBw1a/jM+II6bU9LeLbqfWStJtvu7tmQKdoJfeJQin
         CIumq+YZKWqjbjgj9DtSYzuThRhcvpe/v84fLWXI034/2pDO2py143GDXS9JFnZxzlya
         VPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792435992; x=1793040792;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U0OPXpDCVqLBQpzhnWrzkRzYhRBBjTJwu5vXYqV+PdU=;
        b=BjDR2hGG+SiTMF5fB9gZgjnk9QMEGdzNzXX1FL2t4YOx4jBcgdyg7ENnNtdi2gYKlg
         zdo0oI9OTv659BP3BQ09PMmd0c0p4JxERgKgcyS0eDBF1n9qnBblNtKVGgK510WEYCxu
         FASwTZb1cYtnyGOYV12xqmfLzNlWX/Z+sfBDdLyCWTmWjJ3u1qwUe939TE/dEbbsVHDk
         yigm/FtnDgctdd7jKOg2koPELO4eyRBJ0eXmYHMI7QPV9lwVbMyOH5wonhIWirghTqfA
         jP6mCvPR3E+IPFST+IOU7nqdo6WX889k7+qEktWUlJywEVXFoTYt2P4otJ4VQc6lTWr0
         DGYA==
X-Forwarded-Encrypted: i=1; AKwUvBybNEFEoVpNnCeBFHYIk3kVJniS5irEBe61zMqVDo6bDLa4o5fb9+iyKEZjuTl7OK0j1uk2mkXyOTYagYyTF8qX@vger.kernel.org
X-Gm-Message-State: AFq9FYIByN1g0N1aRPlvt5Uyzj/GLjyz2IEWVpsihVplIvYN1PU1S1lW
	FrhxHhm05AmgEESM97Mwawzhx9SbemD1R4kWCMmuMSWZOfz05C3COPn1auED52pthKaj3UjIUR+
	Gd9IreILxwIkzYdHHIIk533X0gWo/0iI=
X-Gm-Gg: AYBFou1Z2Q2iSEbhHBUQvZTLkhJc3/TVCkBDDHEuDHvR6pfNLocFiwNazPVbHzMWuUL
	9CUdilZtjBPYrouFBzz5on4pTZYeCtUTyAA9SVZU+DcGYlB/zNpQUY2suQ0ImnnG6yhzygrjSXt
	QgtuS+15WfyEx1ZHve0FgPFARYR/rLuATsq01aFUzzw6ByvMOa/Ve9u9xzj1pgJJBCwEAleupa3
	p22AqwVBhRr8LSPW9RavuSSqLDoO0MlnWM8CauSnE5ZJ8wjl2J5hcRtgWk6IuhopoI1qwTtPLqh
	twzLuGY0Yp7URYVwOXNZQyKWhHpiKTA3OI1riIMNGsRbyz63gCQ8P7od8OUDA4Ukd567jF7HzCX
	mqySP+ovUQVhQvM8oEX3A7wx9Mc79WHgijXBYC5HDkOJ4qjzNFBFi
X-Received: by 2002:a17:90b:4fc5:b0:3a4:a592:4cfa with SMTP id
 98e67ed59e1d1-3acef3d957bmr7542638a91.45.1792435991820; Mon, 19 Oct 2026
 11:53:11 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019080709.477548-1-18983559317@163.com> <atX2FsqHIkOvhrLy@redhat.com>
 <CAEf4BzbX7vmpd2da4eKphX1r8=QXGey_1m32-KP=-8FOkFk15Q@mail.gmail.com> <atZFvTrDIyBtzWbo@redhat.com>
In-Reply-To: <atZFvTrDIyBtzWbo@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 19 Oct 2026 11:52:59 -0700
X-Gm-Features: AclHuK_kIpsNmMuQwgIok0RUwcZKJw_O92TtNFcUdNT_GKShwZ_47p0XZYU5R4M
Message-ID: <CAEf4BzaxGie0JYKRLrEYHA5DdHjEFOERHU8_o3n4mxM+kN1x+w@mail.gmail.com>
Subject: Re: [PATCH v1] uprobe: Assign session ID before publishing consumer
To: Oleg Nesterov <oleg@redhat.com>
Cc: Binbin Deng <18983559317@163.com>, mhiramat@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, james.clark@linaro.org, andrii@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 9:31=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 10/19, Andrii Nakryiko wrote:
> >
> > On Mon, Oct 19, 2026 at 3:51=E2=80=AFAM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > On 10/19, Binbin Deng wrote:
> > > >
> > > > consumer_add() publishes a consumer on uprobe->consumers
> > > > before assigning its session ID.  handler_chain() traverses the con=
sumer
> > > > list under the trace RCU read-side critical section and can therefo=
re
> > > > observe the new consumer while uc->id still contains its initial va=
lue.
> > > >
> > > > The race is reachable when an uprobe at the same inode:offset is al=
ready
> > > > active and a task hits its entry breakpoint while another CPU regis=
ters a
> > > > second session consumer.  handler_chain() may store the stale ID in=
 the
> > > > return_instance consumer array.  By the time the function returns,
> > > > uc->id has been assigned a nonzero value, so return_consumer_find()=
 fails
> > > > to match the saved ID and the session ret_handler is incorrectly sk=
ipped.
> > >
> > > I guess we don't really care, this doesn't differ from the case when
> > > consumer_add() is called right after list_for_each_entry_rcu() in
> > > handler_chain().
> >
> > that uc->id is important for "uprobe session" semantics,
>
> Yes, but
>
> > which seems a
> > bit different situation compared to barely missing consumer_add() in
> > handler_chain(),
>
> I must have missed something... If handler_chain() misses consumer_add()
> then push_consumer(uc->id) won't be called.  This means that then later
> handle_uretprobe_chain() -> return_consumer_find(uc->id) will equally fai=
l?

yes, you are right, and we are in violent agreement :)

>
> > but regardless, the fix looks good, we should apply it
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> Agreed, I have acked it too.
>
> Oleg.
>
