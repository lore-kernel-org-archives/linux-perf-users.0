Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16D18A6A9
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 16:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745597053; cv=none; b=WhpBaGXYRf0TXtrs0Jbpibl1VHgJ8jKoseyhnh6xaTk1krhEGopObCDqsgHznP2zto1Dsv0OzdtLIZPccqebCo8LUPUAVR2hO2Qsao1NK/K2LBxFQcmimCG0GAvmK6I525e7BuRq4htwaPEAVXBqzkBMTQhm/OBjORyNUKy5G3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745597053; c=relaxed/simple;
	bh=hIMMmVhGXg5SLkbfuKp5Gsu/Gb5HryaY2msIq+5wmtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsIw1iwGmfe5E//vjeueHwOrUIjEd+4IKQEayvoz+DCGPHUnvUx7a1Us6pETTy85tKbugfIK7mD4j/SIVbydimErEn3YFdOpKsy0uKRRvziXU+ObatfF32MzLXsOIUV79woh7Zk6HdjFkThvxt/iBXVQXM/RMYJoFIDDE55WuYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BaeccDHv; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BaeccDHv"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d5bc35ed3aso221375ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 09:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745597050; x=1746201850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJis+idf2PJBqpKbbBrBtHLOAbkaCHGsxT69CiZn9Is=;
        b=BaeccDHvFZ8Fe4mXabfopRLVxKQ9Bgk2ieRcoSxypHk+BElWiltpbIkxOqBViopXcB
         M3El2+5l9KENDd9iUMWAOycwXLpYU5moILe/DaMe0tq7OrgU2pNq9gZxKw5JbqymF6sp
         XdEmHQI+CIz8QQnHKLkrXWrgJtsS+MZ8OmFViYpKE+FP5yTo21WzJ2VKKPDQzW+grxWM
         l7Rj/6d+rEBXel6XAmPjCrE1k5P+dk2kMAa1omkyZ6o66mE6xIWXRi0aiKWnhGTNueu8
         y8rJ/orTHCMZ39D7gDY7XElenBJbdFFrv5aeRugQhcMCY04WzxNV6vaj+92Y93wXib3j
         S+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745597050; x=1746201850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJis+idf2PJBqpKbbBrBtHLOAbkaCHGsxT69CiZn9Is=;
        b=pGdIYnqDu6sAAxX/lt/efPfK3ZcDoMITqrJeeWL8d7cl7Fx5JRPoPzF0d9D9PJb2qs
         XRwP65Vf96Gtcvp5tsgKFi9cHYdXh/GEi3oXYt8O5APZmFYitZRWbRkalwmaSMUfqvHu
         RfBJTNTZ7PkAaqwrXq/8BMnB+0R6uBHMurnsDThvi4Bx3RMjpXU6NeL84nhZzgn93WkF
         YaPnIp8sPuEzQAf3Vp37hPGfs2bgZidn7W8MBE2LaXbsiY6KSFZzGkU9Z9IAEQTXkXl9
         66qV0G3mPz1/U+mN51k5FGomVBnz+olcmE4u20XCxO0yxqEiP8ffL8fIZAtpMMJwLbJg
         kIxw==
X-Forwarded-Encrypted: i=1; AJvYcCWHsdTPJDp87D5dpj7jGf6D7xU8CwKBZZOiuDHemWCfj3wLWhC+DFcbE0gnVoBpsKzDBZ0kUAQtoX+RZZqSKNbg@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlcqumm9dOAZkEMwVdUS7aWDOON6r2Synb+YofoiiXKW+THTQB
	6fbIJaIVc8e+ddOhEbbU72S2+isbIcaMnvCGFd5402Ya0D4447X1aeRNPRBA638lzKrMcH1bMXt
	l5gdGmWmuoqV6/EpMYSNkjMQKX2Q4Yy4R6Ix1
X-Gm-Gg: ASbGncst51YhaUumw8mmLSM8weHj0Gx5heTrekXl60KKTLKUx8j4UVyXplhGqfvNEE+
	l+3zInRsNQgHFnFzSysCm1q8YStMl1M5sVjiPxbu5tkRh4gqx7QSZOMnvZ6TrfmaSKANR6BqDYI
	46Qc/KlLwePKt2BlMfZnqSKIAI90I4Y1u6nQ==
X-Google-Smtp-Source: AGHT+IGpCL7uANXf1i5RK8BHDw8uOpYkVRUVZ6VE9xD2BW+PwsdhIiH3mHt7HLpAYGr0fJzJ2676rhN1n1V9oJnNFU4=
X-Received: by 2002:a05:6e02:1a45:b0:3d9:25aa:a140 with SMTP id
 e9e14a558f8ab-3d93a7c6a49mr3192085ab.15.1745597050438; Fri, 25 Apr 2025
 09:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424061943.1321025-1-irogers@google.com> <20250424061943.1321025-6-irogers@google.com>
 <CAP-5=fXHay1Qn7c3JUe4nH-cTw8zPhPv6-XWMZdPKpwwT=9n2w@mail.gmail.com> <aAugBbpOHQyu7YK2@x1>
In-Reply-To: <aAugBbpOHQyu7YK2@x1>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Apr 2025 09:03:59 -0700
X-Gm-Features: ATxdqUHJClydx5PmGHm-hPQCiW_3yHysNRLOzFT7WStr0Wj1CfLke6VtmJmxtzk
Message-ID: <CAP-5=fWwW9G7EpR6Bn02dm9PVsqvzyDBcAzzVF1Sc2djAcqaYw@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] perf record: Make --buildid-mmap the default
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, James Clark <james.clark@linaro.org>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Michael Petlan <mpetlan@redhat.com>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Leo Yan <leo.yan@arm.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	=?UTF-8?Q?Martin_Li=C5=A1ka?= <m.liska@foxlink.cz>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 7:45=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Apr 24, 2025 at 12:20:44AM -0700, Ian Rogers wrote:
> > On Wed, Apr 23, 2025 at 11:19=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> > > @@ -1795,7 +1796,8 @@ record__finish_output(struct record *rec)
> > >                         data->dir.files[i].size =3D lseek(data->dir.f=
iles[i].fd, 0, SEEK_CUR);
> > >         }
> > >
> > > -       if (!rec->no_buildid) {
> > > +       /* Buildid scanning disabled or build ID in kernel and synthe=
sized map events. */
> > > +       if (!rec->no_buildid && !rec->buildid_mmap) {
>
> > So I think this is wrong. It matches current behaviors, but it is
> > wrong. If we don't process the kernel's mmap events the DSOs won't be
> > loaded and the build ID cache won't contain the DSOs. There is also
> > the bug that the sample processing to find maps to find DSOs, doesn't
> > handle call chains. Given the broken nature of the build ID cache I'm
> > not sure it makes any sense for perf record to be by default
> > populating it. I think it probably makes sense to consider the default
> > population a legacy feature and make -N the default along with
> > --buildid-mmap.
>
> The first four patches are good fixes/cleanups, so I'm picking them, ok?

Thanks, happy for the clean ups to land. I'm keen to push the needle
on making build IDs the norm in the codebase so if we don't take the
switching on build ID mmap by default change, let me know what I can
do to make it so it can land.

Thanks,
Ian
