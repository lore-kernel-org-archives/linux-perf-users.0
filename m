Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C718CCB;
	Mon, 11 Dec 2023 15:13:19 -0800 (PST)
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5c1a75a4b6cso2602026a12.2;
        Mon, 11 Dec 2023 15:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702336399; x=1702941199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cqid22gVYH094dKsNq0+eWukD9v01nP4LAhWHajwYxo=;
        b=o2bRTkKwfrzWT6OkJeKYtq9OprxDeD5/YUxCkdMB3WPo5/vo9th6xElrdwdYaGgK+5
         WN0zf/BkQL70h9sig2ySnyutSCtltRSxcff6pf2hAU7xgfp8x5MMwcmkJMx7Z1VYle+X
         S1V6Ij5ynIbt5qdfF+9tJaB83gzFq8Wi/FeKqI+6LDwl8hhsFqbh20NbPMR55FxiCZBe
         q1WCbEtWwK8i8MqQmP22OHfMrO7QcKILFPDscRd7MzW9GhU1fGVZ22CrWFMHR/LxoMSd
         VA7rSN2gkeIuBImGxpkK2avGJOea1lyELHZRiWCQTB3GqebZlL20RhrFaAUfWGWcdIHA
         eOZA==
X-Gm-Message-State: AOJu0YwtmfmmKDzAK5/1JBeoIy1f7onm2P0egAqviLNjR1UTkNZcL9xp
	2rcUqxS+c5A5a923DoiUJMPoWdmVdtxsIlNdXjJCUkUwZps=
X-Google-Smtp-Source: AGHT+IFs5STX4S2N0jTA70Ngwh3RK7N00wUSIIOBD/HENzpB5AKMNG20w7x0dKREB9ZbHLlL0xHkT6kxXiptoR/Kei0=
X-Received: by 2002:a17:90a:24b:b0:28a:7a82:53b6 with SMTP id
 t11-20020a17090a024b00b0028a7a8253b6mr1507629pje.28.1702336398933; Mon, 11
 Dec 2023 15:13:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207125716.1947860-1-tmricht@linux.ibm.com>
 <CAM9d7cgJUgVGpQJ=KgH+3RzAJ8Ce50Acr=gSZh_ZLuiTa3-sEg@mail.gmail.com>
 <de0dd86a-4c49-49ed-a90b-4890c82a7b2d@linux.ibm.com> <7451a263-82e8-4daa-a7f6-009d5560445e@linux.ibm.com>
In-Reply-To: <7451a263-82e8-4daa-a7f6-009d5560445e@linux.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 11 Dec 2023 15:13:07 -0800
Message-ID: <CAM9d7cheZG+4PYf2xT0kykHW2LRt_d2GHG-mLWqvLBD3fJWFOQ@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix fails of perf stat --bpf-counters
 --for-each-cgroup on s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 3:30=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.co=
m> wrote:
>
> On 12/8/23 12:07, Thomas Richter wrote:
> > On 12/8/23 00:26, Namhyung Kim wrote:
> >
> >> Thanks for the patch.  But I think it should support
> >> machines without systemd (or maybe with old versions).
> >>
> >> Also probably you want to reset the behavior after
> >> the test.  I think we can just run some built-in test
> >> workload like `perf test -w thloop`.
> >>
> >> Thanks,
> >> Namhyung
> >
> > Thanks for our feedback.
> > Well regarding the use of systemd daemon-reexec the manual says
> > this command restarts the systemd triggered processes.
> > There is nothing to reset. All ports stay active while the command
> > is processed.
> >
> > I tried your 'perf test -w thloop`, but that did not trigger
> > anything on system.slice.
> >
> > I do not understand enough about cgroups and system.slice, but I am
> > under the impression, that the system.slice just increment counters
> > when executed by processes under systemd control. Maybe I am wrong.

Ah, you're right.  It needs to run the task somewhere in the system.slice.
Then it'd be hard to get a proper cgroup name generally. Hmm..

My concern was it'd bind system daemons on the CPU 0 and 1 after the
test.  Probably you could run it at the end of the test again without tasks=
et.

> >
> > The only other workload which always incremented system.slice counters
> > was 'ssh localhost ls -l', which involves local login and a running ssh=
d.

But it won't work if the system doesn't have sshd.

Thanks,
Namhyung
