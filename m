Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431F62EA726
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750254959; cv=none; b=AElnBWgxnZpRATZBec5Y/6OU9umAHsmR4YIlxZdlzt26wHSL/DM38vqB9PbcO6ECGK2QLDvwKz2iyyEBOHHiGXowNcEd4BnuoZ+VAw6UZr/LtL7QxvoNPcuCTTzT5gDKRw9yC5vNlrCcRvrZAz83bNenRX+x/Lu2XEXPI64Fyz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750254959; c=relaxed/simple;
	bh=/UbLUGwr+V9bSfHvJ/R5Gfcr65OLwM/ONB1gYCKrChI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFum4vf0uMPCKsuxoPkFZ8cSA9MOAIFkRJ2kvPkoSnDec7qv/Zt0ZT+y+rmqxPUKg84m2sI+qNL3EKbAwyjoIPuA+AD8sfbqvec7R4sNMabg/hJbJDc3T5J+Pxopu1i67ri0knsgCcpFQYz3T1WbBAiUhMYv+aa6l7/FOHvLk1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZXxAWCHH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXxAWCHH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750254953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eE6f52ARwuvo1uphG+cXjVvlndHWwTGLNaQZBOOfOng=;
	b=ZXxAWCHHJzlc7AfiyeDflR5UOCf+4q2Kha3cdapIHI9FQCypEmKGMFgDrNS0bv+iWKLguw
	k/JzdEO4yp0csin8Ck0d6792cQcUkyHsxhf7w1yQj8RPmAmNBvCB3KK2XByBfziY/s2T/J
	CoFsz8UfnJXwq81CzzJgj0W18H73gGA=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-8Fcgo6zENOqgP-cUL6OBwQ-1; Wed, 18 Jun 2025 09:55:51 -0400
X-MC-Unique: 8Fcgo6zENOqgP-cUL6OBwQ-1
X-Mimecast-MFC-AGG-ID: 8Fcgo6zENOqgP-cUL6OBwQ_1750254950
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-553acdcd5a1so4022344e87.2
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 06:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750254950; x=1750859750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eE6f52ARwuvo1uphG+cXjVvlndHWwTGLNaQZBOOfOng=;
        b=e8UQ2RC/gDQ3YigcrgxHpKFvuc8edP/GzJwhgf8xR0X8l/b9fQNGO7x2jxzuW/C7nY
         79MewlVmt+hTNq21j/fZZXuhoqy+MA1nybjc510hpjdHn+fHAE9WDq/vw2wirK83d4KJ
         tkneNTMAs+0afU3iNq9Y9JvGouRi/42NmgmCVo08rYOBI0KN84ynC/0z50q7cNU2xzNP
         +CwGqhmbyOJv9qDtTEefP8FhOrumgjo85gzNX0AVVFD//wR/gEUA8YFmMXN7wo3bVD+H
         uWUOs//ubZ0WMEFj6iz8FOP6meX7ZjKUQO5ltzUF9PtmuBGsZR+FiicDqos/8nZRYMS+
         J6/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDiqEktm4xtp0NwKFq9l5lIya+rd1QUU798tEcOP9tlvtMFcR83rxwd2O7rrXsAbcQnOhU7DHU808SfbtDk94W@vger.kernel.org
X-Gm-Message-State: AOJu0YxZiL3kOdM6e9XD1moJnQkM7XLF2EaQGLqsVPg1lSmT+g2d3Fg8
	rEK9jWPMtER6KnBXpdBzv39lnremz42fK77iaqvI3ZPyp9/vRboMFDWiWKPikbW6WDo4OEv513w
	29vF2PAULTcRPysxlvwQdxxZ7zV30ErEuR3fbrgWGG0fw06XKBCFPiN3fOmkwNaON4eR9n7RQhq
	KApA2Vo1UT4LQiP8YIh7/Ecs8TDwkLugk3fRoDXRHpB0nYLQ==
X-Gm-Gg: ASbGncv5n9qjHCl7fzJisYUwt4h9J7FyOCDcJX5q9r3Nu9wwB8D9qmtdMSq55Nrgrb/
	O/pSXm9FvvSr8JW7GoZMuQKj5UmcvbSZUDSZkFsOnsFU6oARkakEALkgxXhvAlhmR8gq7d3am5c
	BGz7c=
X-Received: by 2002:a05:6512:3b29:b0:550:dee7:54b5 with SMTP id 2adb3069b0e04-553b6f20523mr4610575e87.41.1750254950158;
        Wed, 18 Jun 2025 06:55:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwzm2mn8XA5iEvWNbtbXS7rnDtOehkPZV8MdZYOZdHpxDeKCrBWdGcpKi7Cyn9ChGxaaNT1Hc9aEt28OqdDJ4=
X-Received: by 2002:a05:6512:3b29:b0:550:dee7:54b5 with SMTP id
 2adb3069b0e04-553b6f20523mr4610563e87.41.1750254949709; Wed, 18 Jun 2025
 06:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617150847.4029177-2-ashelat@redhat.com> <CAP-5=fUh6-gbbcX4znPHdocwjaGqHJRUqKcK-S93jMbNpZ8hSA@mail.gmail.com>
In-Reply-To: <CAP-5=fUh6-gbbcX4znPHdocwjaGqHJRUqKcK-S93jMbNpZ8hSA@mail.gmail.com>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Wed, 18 Jun 2025 09:55:38 -0400
X-Gm-Features: AX0GCFumsf2CBYj2jK_6f5L9dco_2fHx2Ap5lJDTzoAMWRnW-9RUCap0S6V1SM4
Message-ID: <CA+G8DhLv=1b98VnkzB1GADmc6+ymJV4gSG4nGuuVnov1Z68J0g@mail.gmail.com>
Subject: Re: [PATCH] perf header: exempt x86_64 from core id test
To: Ian Rogers <irogers@google.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yeah that makes more sense. I can send a patch to delete the test.

Anubhav

On Tue, Jun 17, 2025 at 12:46=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Tue, Jun 17, 2025 at 8:11=E2=80=AFAM Anubhav Shelat <ashelat@redhat.co=
m> wrote:
> >
> > On a VM running on an x86_64 architecture, it is possible for the socke=
t
> > id to be greater than the processor number. So exclude x86_64 arch from
> > the core id test.
> >
> > Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> > ---
> >  tools/perf/util/header.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index e3cdc3b7b4ab..c1b4651d0c6a 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -2618,9 +2618,12 @@ static int process_cpu_topology(struct feat_fd *=
ff, void *data __maybe_unused)
> >          * The socket_id number might be higher than the numbers of cpu=
s.
> >          * This depends on the configuration.
> >          * AArch64 is the same.
> > +        * It is also possible for a VM running x86_64 to have a larger
> > +        * socket_id number than the number of cpus.
> >          */
> >         if (ph->env.arch && (!strncmp(ph->env.arch, "s390", 4)
> > -                         || !strncmp(ph->env.arch, "aarch64", 7)))
> > +                         || !strncmp(ph->env.arch, "aarch64", 7)
> > +                         || !strncmp(ph->env.arch, "x86_64", 6)))
> >                 do_core_id_test =3D false;
>
> Why do we have a boolean called do_core_id_test that is checking a
> value assigned to the socket_id? :-)
> I think at this point the test:
> ```
>                 if (do_core_id_test && nr !=3D (u32)-1 && nr > (u32)cpu_n=
r) {
>                        pr_debug("socket_id number is too big."
>                                 "You may need to upgrade the perf tool.\n=
");
>                        goto free_cpu;
>                }
> ```
> has no purpose and we can just delete it.
>
> Thanks,
> Ian
>
> >
> >         for (i =3D 0; i < (u32)cpu_nr; i++) {
> > --
> > 2.49.0
> >
>

