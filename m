Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9552CB0;
	Tue,  5 Dec 2023 11:11:02 -0800 (PST)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ce32821a53so1895979b3a.0;
        Tue, 05 Dec 2023 11:11:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701803462; x=1702408262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uODkYjBD6L0Z6eIxrtu/7Xfvr3I8XjBfQSMhqHB6Qbw=;
        b=ipe2IdNbsqbFBPAZEezWOtAtTDCKwS/xhqdqpGJlIfwOo35s/DUureXEgUUk6Mq+Q6
         Bbb0rj0KiiY6KruDLlE2bGzEiaNqW9NafxRTrKAYsVBhgb6H5zZAECV18jKe9cpbfL8l
         pyLSq6L9dbf5Ny6lgo6c7DsAfRbe0gNrIM5PJPs7pVkTIAo3Z9+skGSxFhz2hR+Jwo/7
         1EDLjTf5QUioDXaA5q4pAWsmYOuLkiDUM992CzBcfC0Axr559M86QqEywCuu6YVutg4Q
         fyCrRwD7VLQ43fVILXmQBKO4BbYYJWNKTt/5Hey0xUQw//27iE/Y0PJ3/FWX7bkVSe+9
         rLNg==
X-Gm-Message-State: AOJu0Yws2aaJir4fEp/I//hRgg+NMje1buhwOqoFg2ZCx6taHPQRQdKY
	m2CbsUUqdo7GMSXC0nDc/XJE7s4ddDArDsemLsM=
X-Google-Smtp-Source: AGHT+IFqj9cVd8zrZNQfWXXCe3xl8Op65upOReYUkBSiCVHHvew18D33Nj7SFdsH0mn6xxyPNznBBsC4GddYdRTqbbs=
X-Received: by 2002:a05:6a21:998e:b0:18c:a9d3:4f96 with SMTP id
 ve14-20020a056a21998e00b0018ca9d34f96mr3828901pzb.32.1701803461868; Tue, 05
 Dec 2023 11:11:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204182330.654255-1-irogers@google.com> <bea4ad79-297e-9737-8af1-2286192d26f4@os.amperecomputing.com>
 <CAM9d7ci=Tk845H3x3KMDu-hTdP-u0O6a8D3iAa8EnFLLjOO6OQ@mail.gmail.com>
 <ZW9G8Clxwl6bd0H6@kernel.org> <CAM9d7ciOp_O5N1TDX0HyKavykirByAYrqzcmM-_6ZWjMv-47WQ@mail.gmail.com>
 <ZW9whqUEILWMdcmi@kernel.org>
In-Reply-To: <ZW9whqUEILWMdcmi@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 5 Dec 2023 11:10:50 -0800
Message-ID: <CAM9d7ciqm2NLt5kxjVdOP2y-KV30_CRsSjHpcQgntvNGWukx9g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf metrics: Avoid segv if default metricgroup
 isn't set
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ian Rogers <irogers@google.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 10:48=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Dec 05, 2023 at 09:24:42AM -0800, Namhyung Kim escreveu:
> > Hi Arnaldo,
> >
> > On Tue, Dec 5, 2023 at 7:51=E2=80=AFAM Arnaldo Carvalho de Melo <acme@k=
ernel.org> wrote:
> > >
> > > Em Mon, Dec 04, 2023 at 07:33:18PM -0800, Namhyung Kim escreveu:
> > > > On Mon, Dec 4, 2023 at 2:45=E2=80=AFPM Ilkka Koskinen <ilkka@os.amp=
erecomputing.com> wrote:
> > > > > On Mon, 4 Dec 2023, Ian Rogers wrote:
> > > > > > A metric is default by having "Default" within its groups. The =
default
> > > > > > metricgroup name needn't be set and this can result in segv in
> > > > > > default_metricgroup_cmp and perf_stat__print_shadow_stats_metri=
cgroup
> > > > > > that assume it has a value when there is a Default metric group=
. To
> > > > > > avoid the segv initialize the value to "".
> > >
> > > > > > Fixes: 1c0e47956a8e ("perf metrics: Sort the Default metricgrou=
p")
> > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > >
> > > > > Thanks! I was going to look for the bug but got pulled to other
> > > > > tasks. The patch looks good to me and I tested it successfully on
> > > > > AmpereOne.
> > >
> > > > >    Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputi=
ng.com>
> > >
> > > > Looks like it needs to go through perf-tools for v6.7.
> > > > Ian, do you think this one is enough?
> > >
> > > So I had this on my local perf-tools-next, removed now, I also have s=
ome
> > > other fixes by Ian on the tmp.perf-tools-next, please let me know wha=
t
> > > you guys decide to have in perf-tools for v6.7 so that I can remove i=
t
> > > from there.
> >
> > I think we need this one and the Ampere default-metric-group fix.
> >
> > https://lore.kernel.org/r/20231201021550.1109196-2-ilkka@os.amperecompu=
ting.com/
> >
> > Also perf list JSON fix can go to v6.7.
> >
> > https://lore.kernel.org/r/20231129213428.2227448-2-irogers@google.com/
>
> Ok, removed both, please augment the later description to:
>
> "perf list: Fix JSON segfault by setting the used skip_fuplicate_pmus cal=
lback"
>
> The original description was vague, improving it a bit like that helps
> when just looking at the output of "git log --oneline".

Done and pushed to tmp.perf-tools!

Thanks,
Namhyung
