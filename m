Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EVpxeUBh"
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4265510C1
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 10:59:33 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50ba8177c9fso6507e87.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 10:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701111571; x=1701716371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/wNL+0r9M3vEkbA09HZd27UVLvLuDyJ6shtN1Fiw18=;
        b=EVpxeUBhEtaaEZLJ2EaBAzJW/AI/02XaVVTWkJZhJQQAj5jji6Jj8B7AtDIxJjlyOw
         eGqrplgxchQsvnIxz3inYTDFeMLX/A9SohlR/+N+Jx8A4dXCA18LMCcWtFWODfTzmm3V
         RZuVEQEhbDShg45MrpyV8+rOPlf7BO1i5aURp/cbwPUt0Ursb+bokAcS9TIkx3w/VWNz
         NXNTFCn01EFadNN+hHuTuTizuN15k/znCEk46opJGDTvMA3NiH7pv+nJeDtHSNkfJ3K2
         IsIjiULNRH9x45uotkZ64IdC15Z+QiOwE1EsPtNOE27HEP7qV3jP5ie3xV8jyxhFLIXZ
         BFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111571; x=1701716371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/wNL+0r9M3vEkbA09HZd27UVLvLuDyJ6shtN1Fiw18=;
        b=AePRj1s1s9vJy23ywpvO0zQ2qycXZl9CvbtgKn+Dc2Fy34iop+m64TbK5BRPoQmEpo
         jKVVTN/1VGNTf8aSzxie4TYaA76uoSfQsmqrtK4CM/eN8aQK98sDaV1sfEOZYW6f0njW
         zvEGtauNT4xNASiD1P+rubC57TFOdbpGHcYrx49gfs/9CX8IyTlIc1y3EjjR1QTxHlUE
         S8Yo5cO2PPvXVfJHLM26gWMqOlajT93PMJ6jX/Gkf6CO7mL/2tvRwhefOVs+R+llU1Wl
         1UmgrbIj7ZW7ORZWk+IvoAuMQ0yRKUDtGkRX1Gyix4EJncgJ7ZmNpbHfBFchxUdJOLtf
         7ZFA==
X-Gm-Message-State: AOJu0YznnlhLylMhA1C1B3U8pr2gY1M6mRxJVbSt/k58P6Sb0vXRbv7r
	bQxI5BsjNJ6xbgnf636W7zOjssX+GP1eGgf3MPbLEA==
X-Google-Smtp-Source: AGHT+IFIAPAtevzEtWkxa9wwhZFABJpCknrBAnmFb4+PZShkXnzqu4GkAv8l8u+FsLttnXvygTx7rM76t/73JCe0nps=
X-Received: by 2002:a05:6512:6ce:b0:4fe:ffbc:ac98 with SMTP id
 u14-20020a05651206ce00b004feffbcac98mr564192lff.4.1701111571318; Mon, 27 Nov
 2023 10:59:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-2-irogers@google.com>
 <CAM9d7cgbPGzgc=QG8dStvq1iX8snGyeKTJDrg2XBjX0pCX9Qtg@mail.gmail.com>
 <CAP-5=fXgy95LsYLbbWN85prBs43jvGehOcwYFK-ZK2cOqCyPJA@mail.gmail.com> <CAM9d7ch9pXWZdFKf5zrQZg+nrf_0YpVro5vvkkO+LPfoLTynPQ@mail.gmail.com>
In-Reply-To: <CAM9d7ch9pXWZdFKf5zrQZg+nrf_0YpVro5vvkkO+LPfoLTynPQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 27 Nov 2023 10:59:19 -0800
Message-ID: <CAP-5=fWpNUPfZ6Qs45kw1BkDB0erOu0whzaV0VsYtkLuJhGpAg@mail.gmail.com>
Subject: Re: [PATCH v4 01/53] perf comm: Use regular mutex
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 5, 2023 at 7:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Sun, Nov 5, 2023 at 1:35=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Sun, Nov 5, 2023 at 9:32=E2=80=AFAM Namhyung Kim <namhyung@kernel.or=
g> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Thu, Nov 2, 2023 at 10:58=E2=80=AFAM Ian Rogers <irogers@google.co=
m> wrote:
> > > >
> > > > The rwsem is only after used for writing so switch to a mutex that =
has
> > > > better error checking.
> > >
> > > Hmm.. ok.  It doesn't make sense to use rwsem without readers.
> > >
> > > >
> > > > Fixes: 7a8f349e9d14 ("perf rwsem: Add debug mode that uses a mutex"=
)
> > >
> > > But I'm not sure this is a fix.  Other than that,
> >
> > Thanks Namhyung, it fixes the case that you enable RWS_ERRORCHECK in
> > rwsem.h as the rwsem static initialization is wrong for a mutex.
>
> Sounds like we need a separate fix.  Maybe you need to
> add a static initializer macro depending on the config.

Agreed, but the only use would be here and switching this case to a
mutex gives extra error checking such as the mutex being taken
recursively. Given that, I prefer the existing change and the static
initializer for rwsem can be a follow up when needed.

Thanks,
Ian

> Thanks,
> Namhyung
