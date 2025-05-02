Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9948023C500;
	Fri,  2 May 2025 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746187607; cv=none; b=Xn/n9uW5wQgLlCBPvcA+sG8E8Q9vuhU5gQn1m7iGmxZWiSBmMpj0q5TdemuCXR37+RR02UpfTvNxzEMvbwvHKZYBTGzgDwnuEm3AeSgCrw5sbAo+p4ZQCehrxIEQ4xCJNf+LRVGtjcq79XDQN4g2sfAgnAxYI0AWPSSM1CL4WnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746187607; c=relaxed/simple;
	bh=VIiENbdDB2JwUhcI2xcDSEB/mg732gTkvnNfrNikiAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feaxZsuFSMcfrdE0tXFQ3T5V16PRyfYiJkgu6Pm6a8P8wbZG8jVdaFUtgjxWaBo0iNBYnWrdjwSGbPsdyZgUIj5T07iFdr7VpDc/uCULxGj0RM5BnnNfC9k7CS0QBje+D716nGTPZ3jRDOtTLKua1NINGoAdqxpqvWMkFH9M2Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvN/dIDp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvN/dIDp"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-440685d6afcso15430775e9.0;
        Fri, 02 May 2025 05:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746187604; x=1746792404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3V73705bvr6jBRGxONET/Lnah1PbBZsX8gJ3s70qtfs=;
        b=GvN/dIDp+HAOv5C+L1ptLYYlUWwW9l+wdWh6ObC3Ceks8hpg/E+R4tD71/FKqhJuO9
         jhCRxBz4VItA5WwfppNdgh0uWOqb5LTJtHzdM1WBZ1t2WCWgQPZSsDVOvkP1dzBLe1Yq
         EtnSEr3jy/esjZLmz67q9cIGjSWqko5S31gbNl84NNAI/X6E92O8mck6sqV+R5HCHHJ4
         Jt0PXaYOG/7vq8ZTrT7AS+r9Ux5Zsuxj799Rd/Q/BLHJVqHxIzyxjQtZ3iust0lKc5uv
         E6VFaBzKmB2ykaZN8FNMcJRFxUVWq6nONPZ6z49veBvulxy9weuE8VKPgXdQbcYQmVIw
         YvaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746187604; x=1746792404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3V73705bvr6jBRGxONET/Lnah1PbBZsX8gJ3s70qtfs=;
        b=LEh7qsHflNOWGwfJrZdL+DQ19WT8QuO2fYUMKtHBtKx0Z0YtQwjgiEbxFeGpz0yTYb
         5zxv8hYCFR+/PnQzrmm6DoGIVwZhjxtTdJATaLSH2yRCi2+rRZVgZd1RbHzJl/mA+pQH
         S9ePhyr3gM+tHLYUUMBfvWtSvpFNs9ak5aG42CUb5nWV7/6mbBAIhBPX0Q3d8Z3fkUgS
         Px3BZ2+E2iR85qSXkATygsHKRWAFa5iK0CDFWaaCwJClz+SMcGsVMLs4JkKl830YM8dw
         a3KawJDnlv4Wc6pYm8gUp4OhlE+xoT/j9/ozM+Tph2pSxYb5eaoRAZ2AwHTJx3IiMzVc
         Es6A==
X-Forwarded-Encrypted: i=1; AJvYcCVDJcf5U6/SxFi58uO9eAw1kcYMlnNw6+Z558AIKLWiAsNmNO+jYPFMHFp0nTtvsMq9c63CgW1qvjjHikA=@vger.kernel.org, AJvYcCX+ZK6N5ehVqMsvA7StrJKLpPwtkuSHaeyiPCm5g2F+m45CdobKAy81W/EuSj40DoERP54HM/hMVmFRg9gHPxkFgw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvo/Yk2CYHvAUJcBmg9uY9dGVl2twLzhNbgJ//ca0uQPYkerTQ
	/vBWUW9QyKdbZ6vqwu/5QR7DcdYUTeg4iuEs4g+MSdYrDHXMYkDN
X-Gm-Gg: ASbGncu/YQqRK6uxlbC5+bZFH624P2RidhPpwOdBhffM0a/pCk6Cv+6bJY9eJmE9efC
	h4UNOvssWCq4wujz2Qxqzy/dv5AFPg5mkZhHW6ac/RjY5dOthwzL3fSRMKrblR2ayCcX8FJy9Sy
	nyKNPcUzl1KlnEGPcbqJ/6qUDkNl+pxbq1SpRJJHMfF54pawT7J+J0ea6qHzV7TVJNeCTLVAmXN
	QHKuQWmEeVJ8weY0n8pt/rPPKOzPRdLh+GuFumuMaYFOgtiarqEozqhFke9jycUrNlLNmX2NRbL
	KrIhb7qqP9IHs5Y36STqqS6m72uWoaNm/u0BQITsqiAmYM9lStJiaSbRcEGnnFt8F/8XUAR/Yaf
	XEFE=
X-Google-Smtp-Source: AGHT+IFh2JoJgMUXNCEsxIU7sFr9ZKrk9uzl/gj68SDvvgkmdXJHvwZfMJbNBkXkaIN5STEA3H1Rgg==
X-Received: by 2002:a05:600c:1c26:b0:440:68db:a013 with SMTP id 5b1f17b1804b1-441bbf2cb29mr17733935e9.25.1746187603660;
        Fri, 02 May 2025 05:06:43 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc469sm43027435e9.6.2025.05.02.05.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 05:06:43 -0700 (PDT)
Date: Fri, 2 May 2025 13:06:35 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
 <kan.liang@linux.intel.com>, Yury Norov <yury.norov@gmail.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Thomas Gleixner <tglx@linutronix.de>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, John Garry
 <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, James Clark
 <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan
 <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, Jonathan
 Cameron <jonathan.cameron@huawei.com>, Nathan Chancellor
 <nathan@kernel.org>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Kyle Meyer <kyle.meyer@hpe.com>, Ben Gainey
 <ben.gainey@arm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol
 Jain <kjain@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, Eder
 Zulian <ezulian@redhat.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, He Zhe <zhe.he@windriver.com>, Brian
 Geffon <bgeffon@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, Howard
 Chu <howardchu95@gmail.com>, Charlie Jenkins <charlie@rivosinc.com>, Colin
 Ian King <colin.i.king@gmail.com>, Dominique Martinet
 <asmadeus@codewreck.org>, Jann Horn <jannh@google.com>, Masahiro Yamada
 <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Yang Jihong
 <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, Andi Kleen
 <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, Ilkka
 Koskinen <ilkka@os.amperecomputing.com>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, Hao
 Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, Gabriele
 Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, Casey Chen
 <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Li
 Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>,
 Levi Yun <yeoreum.yun@arm.com>, Weilin Wang <weilin.wang@intel.com>, Thomas
 Falcon <thomas.falcon@intel.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Andrew Kreimer <algonell@gmail.com>, Krzysztof =?UTF-8?B?xYFvcGF0b3dza2k=?=
 <krzysztof.m.lopatowski@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Jean-Philippe Romain
 <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang
 <xu.yang_2@nxp.com>, Steve Clevenger <scclevenger@os.amperecomputing.com>,
 Zixian Cai <fzczx123@gmail.com>, Stephen Brennan
 <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 04/47] perf bench: Silence -Wshorten-64-to-32
 warnings
Message-ID: <20250502130635.0eabb190@pumpkin>
In-Reply-To: <gha57xgs8b.fsf@gouders.net>
References: <20250430175036.184610-1-irogers@google.com>
	<20250430175036.184610-5-irogers@google.com>
	<gho6wdh00l.fsf@gouders.net>
	<CAP-5=fUdpa40MDNu0aDBO7o8H3YMe-cYsg-YfqUUZUY4M4XLeA@mail.gmail.com>
	<ghecx9guoj.fsf@gouders.net>
	<CAP-5=fXJpD_f6dUqroVpqe-OX5kyOPc1zpbyOZoQtqvQWBGr=Q@mail.gmail.com>
	<gha57xgs8b.fsf@gouders.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 01 May 2025 01:11:16 +0200
Dirk Gouders <dirk@gouders.net> wrote:

> Ian Rogers <irogers@google.com> writes:
>=20
> > On Wed, Apr 30, 2025 at 3:19=E2=80=AFPM Dirk Gouders <dirk@gouders.net>=
 wrote: =20
> >>
> >> Ian Rogers <irogers@google.com> writes:
> >> =20
> >> > On Wed, Apr 30, 2025 at 1:23=E2=80=AFPM Dirk Gouders <dirk@gouders.n=
et> wrote: =20
> >> >>
> >> >> Hi Ian,
> >> >>
> >> >> considering so many eyes looking at this, I am probably wrong.
> >> >>
> >> >> So, this is only a "gauge reply" to see if it's worth I really read
> >> >> through all the commits ;-)
> >> >>
> >> >> Ian Rogers <irogers@google.com> writes:
> >> >>
> >> >> [SNIP]
> >> >> =20
> >> >> > diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sch=
ed-pipe.c
> >> >> > index 70139036d68f..b847213fd616 100644
> >> >> > --- a/tools/perf/bench/sched-pipe.c
> >> >> > +++ b/tools/perf/bench/sched-pipe.c
> >> >> > @@ -102,7 +102,8 @@ static const char * const bench_sched_pipe_us=
age[] =3D {
> >> >> >  static int enter_cgroup(int nr)
> >> >> >  {
> >> >> >       char buf[32];
> >> >> > -     int fd, len, ret;
> >> >> > +     int fd;
> >> >> > +     ssize_t ret, len;
> >> >> >       int saved_errno;
> >> >> >       struct cgroup *cgrp;
> >> >> >       pid_t pid;
> >> >> > @@ -118,7 +119,7 @@ static int enter_cgroup(int nr)
> >> >> >       cgrp =3D cgrps[nr];
> >> >> >
> >> >> >       if (threaded)
> >> >> > -             pid =3D syscall(__NR_gettid);
> >> >> > +             pid =3D (pid_t)syscall(__NR_gettid);
> >> >> >       else
> >> >> >               pid =3D getpid();
> >> >> >
> >> >> > @@ -172,23 +173,25 @@ static void exit_cgroup(int nr)
> >> >> >
> >> >> >  static inline int read_pipe(struct thread_data *td)
> >> >> >  {
> >> >> > -     int ret, m;
> >> >> > +     ssize_t ret;
> >> >> > +     int m;
> >> >> >  retry:
> >> >> >       if (nonblocking) {
> >> >> >               ret =3D epoll_wait(td->epoll_fd, &td->epoll_ev, 1, =
-1); =20
> >> >>
> >> >> The epoll_wait(), I know of, returns an int and not ssize_t.
> >> >>
> >> >> That shouldn't show up, because it doesn't cause real problems... =
=20
> >> >
> >> > So the function is read_pipe so it should probably return a ssize_t.=
 I
> >> > stopped short of that but made ret a ssize_t to silence the truncati=
on
> >> > warning on the read call. Assigning smaller to bigger is of course n=
ot
> >> > an issue for epoll_wait. =20
> >>
> >> Oh yes, I missed that ret is also used for the result of read().
> >>
> >> Some lines down there is also a combination of
> >>
> >> ret =3D enter_cgroup() (which is int)
> >>
> >> and
> >>
> >> ret =3D write()
> >>
> >>
> >> Just confusing but yes, because ret is also used for read() and write()
> >> in those cases it should be ssize_t.
> >>
> >> I'm sorry for the noise. =20
> >
> > No worries, I'm appreciative of the eyes. I suspect we'll only pick up
> > the first patches in this series to fix what is a bug on ARM. I think
> > I'm responsible for too much noise here ;-) =20
>=20
> A final thought (in case this patch will also be picked):
>=20
> Why not, in case of read_pipe() and worker_thread() just cast
> read() and write() to int?  Both get counts of sizeof(int) and
> it would clearly show: we know the result fits into an int.

This is an obvious case of the entire insanity of these changes.

	David

>=20
> In case of read_pipe() that would mean to just change one line in
> contrast to:
>=20
> @@ -172,23 +173,25 @@ static void exit_cgroup(int nr)
> =20
>  static inline int read_pipe(struct thread_data *td)
>  {
> -	int ret, m;
> +	ssize_t ret;
> +	int m;
>  retry:
>  	if (nonblocking) {
>  		ret =3D epoll_wait(td->epoll_fd, &td->epoll_ev, 1, -1);
>  		if (ret < 0)
> -			return ret;
> +			return (int)ret;
>  	}
>  	ret =3D read(td->pipe_read, &m, sizeof(int));
>  	if (nonblocking && ret < 0 && errno =3D=3D EWOULDBLOCK)
>  		goto retry;
> -	return ret;
> +	return (int)ret;
>=20
>=20
> Best regards,
>=20
> Dirk
>=20

