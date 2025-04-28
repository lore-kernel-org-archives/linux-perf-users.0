Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEBD1DF269
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Apr 2025 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745826141; cv=none; b=iM6sOHlP3McfaDgwtobyq9BwgArfziO7mydxPtyAWcGrFNCJ7mpF6mpAPVINFhbp/tXfNTJtdr4NPPVgUoIII+mKhG3xgDnQdg+o9UxlqHdiS8nIdcQkRWHHyKPW6tAiMKtAYZUl0Lj7uM5e1+J3gtkEVsucwyKOGi1ay3042G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745826141; c=relaxed/simple;
	bh=RO4fe7hF3YRJO+Sakz3qlIuEQu+QpUlcCFkVjyWJZoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CllnTFuSgN6BFMDygtYLeTSdgIoNrDxKUklN5PkboqeBtgW0wTwJ/Ly/x3SdwTDwlaUyyvs8xRUfFmtWsomGiUkUR6ecRIAA0vN3xGfBiqMWxb7PzUvBa/diYfF/M/lnd7dNpQjIrfkJNpcgwVEDf3I3aYkcCStIeK+xauWQkoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OAnfLBX3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAnfLBX3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745826138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dpj7I8mgxfJqgam51CzzudZUWclMLZg1KKSrTJW4zYg=;
	b=OAnfLBX3iCilB4XyghfhkTXuXkUjdExCxba2AaQNLKD5zIq7wOvPOV6ZSaxmMawgeW/2jj
	lmTbNE6JpVLlPDGrkpYQgQZ9gnF8Kd7hSUrjifMrA6dDzGsPgTp0MskjNf6mERKV0kYs/A
	SC+YdPiXZxSUlR396GO99hagZASqb54=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-ogAkanY0Pomca6GPyAXV9A-1; Mon, 28 Apr 2025 03:42:16 -0400
X-MC-Unique: ogAkanY0Pomca6GPyAXV9A-1
X-Mimecast-MFC-AGG-ID: ogAkanY0Pomca6GPyAXV9A_1745826135
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-acb66d17be4so327099466b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Apr 2025 00:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745826135; x=1746430935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpj7I8mgxfJqgam51CzzudZUWclMLZg1KKSrTJW4zYg=;
        b=pFPTDUNCQD/Wjen7NkviHQG5JOziPVYuCcMTWvPLFL1d7NasP4MSMWyzANSIF3EZys
         FeJFf3y9T/5uhMnzNktdJQkOa8nMMal9NM3DAsARHxWNQZfAh3sTXr6eGyr5EkVYAnBW
         b2x28XFkjgONtTkyPKbCja0dvykmpFNciUV9l5aztYH++rqWROJWflIzRWRSjPhUJzVE
         LUKjHn68+XEiUVVSQy8t+OjdJNizLZJNmn260AToavrzAmAXUTSe0Ey6PwlL+Gajy+kH
         rIz/Yhc1B1a4AXuEWdizXS2NiFVe57/ldvEkA+u+J0FNuNmhF3uyjUyf+brA2r5oe3Xo
         xGrw==
X-Forwarded-Encrypted: i=1; AJvYcCUHGl93IG2qfPwFste9eF6F1u4mNM/vCJ9MQqEgHlGgSaobm2xAObbTMzz+OytKigTuICJojSmzDQcRV4Mh44D9@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7aohTns4sB53hqxAyXRaoDTD0YnrkXnxQ4Kd5jcpK3M+kjTd
	eQjCqVx93H9p9K+TxNvZKHykw9XtVcw+k8ff2rkgOJGI27c2K36mnKMse2qjA8UvrxvwbAbHgqY
	kdKvqCagGT09sS2VHiUPh4LwlBBtcXA5x76l1mypOp2muE7VMXvqrSwrM0AHJGWF67eQ=
X-Gm-Gg: ASbGncsfYgYpPEoi48j7mSjokffPq+Zc7itIWR1qmkgcw5yddIfAYUckWBpfxJUiunP
	/mQANK5WIfznYlWM2XpjfOt8hlKXjXU6v+IxnpIFeRCLmnqF9NDuXAZiI/IrdaxSyi0nMqIADTz
	pvI28PxICxek6sNI3XXUOhlflYSB2p4/L2OxZ657oEBqyR9iQuKVyV3Xr7peA+JanvevZusQkWc
	1QPvuhZy/q9BsVjZbRQ0srKi42aH59bUBxyU9Vfbmd7XPm/gcldQndTMWKeJxO2J9QTIL792wbo
	B07GLaLSAy+EhatSsQ==
X-Received: by 2002:a17:907:1c27:b0:ac4:3cd:2cb2 with SMTP id a640c23a62f3a-ace7104e5d8mr1000675166b.1.1745826135426;
        Mon, 28 Apr 2025 00:42:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXzAr0+bjExObNijhwwYl1i6kI6R1HoChQXPYHAU+nUMCp81+2mz+T7WI44sNlBU3yht/5vw==
X-Received: by 2002:a17:907:1c27:b0:ac4:3cd:2cb2 with SMTP id a640c23a62f3a-ace7104e5d8mr1000672266b.1.1745826134717;
        Mon, 28 Apr 2025 00:42:14 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.219.109])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e4e70bbsm587228966b.63.2025.04.28.00.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 00:42:14 -0700 (PDT)
Date: Mon, 28 Apr 2025 09:42:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Ingo Molnar <mingo@kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, mst@redhat.com
Subject: Re: [mainline]Warning while building tools/perf
Message-ID: <CAGxU2F4X2TYM+fD-TnLjTPd+AcwSccREBnO1+geSFs-KVM4kRg@mail.gmail.com>
References: <9c40ab1a-3d08-4af8-a430-0ba245842959@linux.ibm.com>
 <43507075-ec04-44c8-a95f-49e074d933d8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43507075-ec04-44c8-a95f-49e074d933d8@linux.ibm.com>

On Fri, 25 Apr 2025 at 18:07, Venkat Rao Bagalkote <venkat88@linux.ibm.com> wrote:
>
>
> My bad, missed to mention the warning in the previous mail.
>
> On 25/04/25 9:32 pm, Venkat Rao Bagalkote wrote:
> > Hello,
> >
> >
> > I am seeing a new build warning while building tools/perf on the
> > mainline kernel, with base:
> >
> > commit 02ddfb981de88a2c15621115dd7be2431252c568 (HEAD -> master,
> > origin/master, origin/HEAD)
> > Merge: 30e268185e59 b0b7ee3b574a
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Thu Apr 24 13:01:31 2025 -0700
> >
> >     Merge tag 'scsi-fixes' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> >
> >     Pull SCSI fixes from James Bottomley:
> >      "The single core change is an obvious bug fix (and falls within
> > the LF
> >       guidelines for patches from sanctioned entities). The other driver
> >       changes are a bit larger but likewise pretty obvious"
> >
> >     * tag 'scsi-fixes' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi:
> >       scsi: mpi3mr: Add level check to control event logging
> >       scsi: ufs: core: Add NULL check in
> > ufshcd_mcq_compl_pending_transfer()
> >       scsi: core: Clear flags for scsi_cmnd that did not complete
> >       scsi: ufs: Introduce quirk to extend PA_HIBERN8TIME for UFS devices
> >       scsi: ufs: qcom: Add quirks for Samsung UFS devices
> >       scsi: target: iscsi: Fix timeout on deleted connection
> >       scsi: mpi3mr: Reset the pending interrupt flag
> >       scsi: mpi3mr: Fix pending I/O counter
> >       scsi: ufs: mcq: Add NULL check in ufshcd_mcq_abort()
> >
>
> Warning:
>
> diff -u tools/perf/trace/beauty/include/uapi/linux/vhost.h
> include/uapi/linux/vhost.h
>
> >
> > Git Bisect is pointing to below commit as first bad commit.
> >
> >
> > a940e0a685575424d33324ec7f0089045249de0a is the first bad commit
> > commit a940e0a685575424d33324ec7f0089045249de0a

That commit just updated the documentation, no code change.

I guess in tools/perf they copied vhost.h and there is some check to 
control if they are in sync.

CCing Arnaldo who has updated the copy several times.

Thanks,
Stefano

> > Author: Stefano Garzarella <sgarzare@redhat.com>
> > Date:   Mon Mar 3 09:52:37 2025 +0100
> >
> >     vhost: fix VHOST_*_OWNER documentation
> >
> >     VHOST_OWNER_SET and VHOST_OWNER_RESET are used in the documentation
> >     instead of VHOST_SET_OWNER and VHOST_RESET_OWNER respectively.
> >
> >     To avoid confusion, let's use the right names in the documentation.
> >     No change to the API, only the documentation is involved.
> >
> >     Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >     Message-Id: <20250303085237.19990-1-sgarzare@redhat.com>
> >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> >  include/uapi/linux/vhost.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >
> > Upon reverting the above commit, warning is not seen.
> >
> >
> > Bisect log:
> >
> >
> > git bisect start
> > # status: waiting for both good and bad commits
> > # good: [9c32cda43eb78f78c73aee4aa344b777714e259b] Linux 6.15-rc3
> > git bisect good 9c32cda43eb78f78c73aee4aa344b777714e259b
> > # status: waiting for bad commit, 1 good commit known
> > # bad: [02ddfb981de88a2c15621115dd7be2431252c568] Merge tag
> > 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> > git bisect bad 02ddfb981de88a2c15621115dd7be2431252c568
> > # good: [cc0dec3f659d19805fcaf8822204137c9f27a912] Merge branch
> > 'net-stmmac-fix-timestamp-snapshots-on-dwmac1000'
> > git bisect good cc0dec3f659d19805fcaf8822204137c9f27a912
> > # bad: [0251ddbffbeb213f0f74ef94b2cacce580eb8d76] Merge tag
> > 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
> > git bisect bad 0251ddbffbeb213f0f74ef94b2cacce580eb8d76
> > # good: [bc3372351d0c8b2726b7d4229b878342e3e6b0e8] Merge tag
> > 'for-6.15-rc3-tag' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> > git bisect good bc3372351d0c8b2726b7d4229b878342e3e6b0e8
> > # bad: [fbd3039a64b01b769040677c4fc68badeca8e3b2] virtio_console: fix
> > missing byte order handling for cols and rows
> > git bisect bad fbd3039a64b01b769040677c4fc68badeca8e3b2
> > # bad: [a940e0a685575424d33324ec7f0089045249de0a] vhost: fix
> > VHOST_*_OWNER documentation
> > git bisect bad a940e0a685575424d33324ec7f0089045249de0a
> > # good: [16c22c56d4282584742022a37d4f79a46ca6094a] virtio_pci: Use
> > self group type for cap commands
> > git bisect good 16c22c56d4282584742022a37d4f79a46ca6094a
> > # first bad commit: [a940e0a685575424d33324ec7f0089045249de0a] vhost:
> > fix VHOST_*_OWNER documentation
> >
> >
> > If you happen to fix this, please add below tag.
> >
> >
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> >
> >
> > Regards,
> >
> > Venkat.
> >
>

