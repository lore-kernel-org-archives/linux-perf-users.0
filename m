Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD722F11
	for <linux-perf-users@vger.kernel.org>; Tue, 21 May 2024 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311602; cv=none; b=SkIdy2alNH/yxmerELUSMAMTXzZ1iSBxmEElfkfGW10VH07U2jfBZ6utlXEJFHkCspa7q/Wn+tkKF2kNMPdhyw+ciwdCL4K7H6kcEowj6ckS6GqEXcOsIw0e6J9taCqLPQsveiZlizpe59YDSAp11GjXTlH76/OlfHlC4D3db94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311602; c=relaxed/simple;
	bh=8dd+3CyB9ZfUsu9ED1coxbk8SB2YtRQF+xW5vW/Nv/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rveN+ouD+N1esUCh3ppCMp2czZ5YZyjDv59e0OtZCiajm97V0JgjaBp4c3AHFkphb7Qakul2638HdHVVup30wxiMvy6Qt3KihaCbfqhmIfvvPV5DD9XsV/pnGpzQe5X75fSm1CYNWy0BjvVWydOXKT9uXCasAxCQUouDC7kQVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hpEgDhib; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hpEgDhib"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1eed90a926fso9585ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 May 2024 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716311600; x=1716916400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xvy3vZOZ+DrbSfTr1Y7exdXqXahpXO1bzaeP7lN+Ufk=;
        b=hpEgDhibUlLJxFY55sGD/DxKWW5nybslYJUsHbVtn6N3fRZpXMYhOrpyU/+xXnxp07
         FlEdWGg936tel9MPXpUizcMCcCtp+9IvLMf/K5ZdvoryBHUVVwLnC1qNS2zWxVwpISiB
         P9/HkI2MCLMC4ckECMPhaOzLA7XfoRxav2iX1rbH0piDpOYPbPWfuA1NAx4oaZUDDdmw
         ydJ4Nnul3N4ecj3mIS5DVHBMUM7SFxbi1zL5YqbmWmtHkV+Kmje2idD3QmjVVCjduIUy
         qIcD5oXk1oRFwVOekab9pNSQZ/MX+EAt99dNJ3tg59SHWE9NqgKn7/H1kEEqoafoFM5W
         QGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716311600; x=1716916400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xvy3vZOZ+DrbSfTr1Y7exdXqXahpXO1bzaeP7lN+Ufk=;
        b=wFHViOFsiZxxE9oqLW38R5TmqN/UezHPNJdHily/Hp2krOVIxhTdMimK+SXgZI9Lym
         Qy3jKVermOPm69kCDwwdq8C7p20hSXCImK5xDjMRf7QMOFumeARE7yeVIhaRRMxUffcc
         BlLLSsQGRTD7qh5nf66teCBoZ8AT62Z8JI3sgQW5d865NrppNFQ4qEwN7jACmsm++HC8
         CAYzau5sAlWnLf+CGDpW69xm9y9AI7DKmclf6NZZQUervouoEuYr8NDSUM/9p1zPIshy
         SllKdO1MqrOiEn+/hXVSxKSQJlTS8K0LiklV9iSUWMwSyvBBnm9Qp+lLH3FJ4Au3yuKc
         DYPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG/yQKyoLzjg1WchLGT5U2uvsu06xiZ+PfUcyrOyERPDSYC99z25lua2/gJki4J9bwIYE4oJx7i/UhKW8UIVOQjIPGrT5As9zukkrAz+4STg==
X-Gm-Message-State: AOJu0YyBBdZrkadY6k9XMMfQZEnOQJbf9qwEceivo0tjZqRdeUu8mjpF
	/+2ErTlj+Vq7CzBjaaMfOOyylrfur1eRx5qvU6AanSO72NEGuTEvS0y8/3O/dfe6WNqIBa21BYi
	fKwRx2fyshPvubo1zjPUyEhiqR26lxktC9R8F
X-Google-Smtp-Source: AGHT+IH7MCJIERIUNSu5RuWQS0e+JMaobcia4kPXAmSM9jwR4UnOl+yPIfG2Fs55+kkzwmCz/U8IMakT9c6t53PCvhk=
X-Received: by 2002:a17:902:c106:b0:1e8:88b2:17cd with SMTP id
 d9443c01a7336-1f2ecb14a62mr6705655ad.12.1716311599190; Tue, 21 May 2024
 10:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520203643.182920-1-irogers@google.com> <e3e483ff-d160-4bf2-a1e7-ae541c59f63d@oracle.com>
In-Reply-To: <e3e483ff-d160-4bf2-a1e7-ae541c59f63d@oracle.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 21 May 2024 10:13:07 -0700
Message-ID: <CAP-5=fXtahvLa5hFqdQpPyeHYsUNe=MkJBn8Yf5npNUvGJOU0w@mail.gmail.com>
Subject: Re: [PATCH v1] perf jevents: Autogenerate empty-pmu-events.c
To: John Garry <john.g.garry@oracle.com>
Cc: Weilin Wang <weilin.wang@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 4:45=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 20/05/2024 16:36, Ian Rogers wrote:
> >       }
> > +                ret =3D pmu_events_table__find_event_pmu(table, table_=
pmu, name, fn, data);
> > +                if (ret !=3D -1000)
> > +                        return ret;
> > +        }
> >           return -1000;
>
> what's -1000 meaning? It would be nice to use some standard error codes.

This is a pre-existing thing. 0 means continue and anything else
generally aborts a search, -1000 is used when searching multiple
tables to indicate not found in 1 table but potentially not all.

Commit 3d5045492ab2 ("perf pmu-events: Add
pmu_events_table__find_event()") added this [1], you were on the cc
list ;-) I think moving to a named constant would make this more
intention revealing so I'll add this to a v2 set.

Thanks,
Ian

[1] https://lore.kernel.org/r/20230824041330.266337-9-irogers@google.com

> Thanks,
> John
>
>
