Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154BE194A60
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Apr 2025 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743704742; cv=none; b=fvdVkjGFxWFnEf29CdYPmFd7wriPtyVaACnv6PnXv23UNx5TOHiE2MKWO967JpiU2Sc8G1m3tw9/zmkc7zqkmSihxiysMWmjxgCYQ9Ri7lOUpO8tsw7oHt9cjdTPFOJoQHnnf1bRCwCrbc6c9mvK07A1r9ozehuvDy+1N1cvP8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743704742; c=relaxed/simple;
	bh=6O4SjyPBUVS6GuOVKA8Ep2YS6NwRaURMpWxhlg3eyCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXhdeJZKiiK1AKWKWb4o/syis/lLpaLT9BTSeLmWQs/XVnagOuEQQELqQxjnZOX155FIMs3ClpltJa/jubFqHyUsUSxrQjbjfhcHmENegzCl7TXtjxYj9tdReip04og7zoWjhSsqVoHe3GV7zNqMX/ucUmnbAZDdbJNUVIj5UTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zcZz4XJT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zcZz4XJT"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2240aad70f2so31295ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Apr 2025 11:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743704740; x=1744309540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFjLyXKfUf9Lln2oY8q3RAfmrslmhbLfzALE5R6QN0s=;
        b=zcZz4XJTTC1KIrFhMkRwZLUL6l8lCr1pUTeEhKYrNcjNUfH+mmBQ9idfmtA5/ytUf/
         jg2DzQ2d9NbrdJJe/5D342aIMic8eT8uZ23dIYljNF0MlSSfQzJb/n9oc5IWGnVtwP3T
         g+HlfU5GEA4Oa89KSAldQnDZ9NVNTvIlfxS8UUQgJD6zrd/Ns7Ioq9iFNHJZDmSmVkl4
         1q8rTflY9M86ZodfkvVA42kMXrPggSPXW4jA6PJmqxnhkQ5Da3mdTFVlt3n0XP6TBrOi
         DB6ye4rStXmFRQ69wqwksz5PJKUMrVjhr1LMAtJtBOdt9vZN+3JjW6iKO1lTkWeOWCiw
         7DIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743704740; x=1744309540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFjLyXKfUf9Lln2oY8q3RAfmrslmhbLfzALE5R6QN0s=;
        b=Gcu2CMHk0+Md0VjQw0lX9o2WVj1sujs9TU1504I0TJvuvZ5pKvTgB1PrL0Rx0HXvLB
         1zovYgzBLz25Utgyc+3yS2sy3CeigTbxe6AQOdH8Evn2I9ZwoAbRD4SGfPU4+nIIcQD2
         VFl4OSHfyEinM6amFWDUQI/iT4BM9P3L7zYHJQ3WF9+27RXntreJ/BQjydZuh8jAcFsY
         UkgVK7UfoGePOWyPNiHoFjYSHfu1muDw8xpSnl2mZDGX7+L0knCi5KWhQ31xZrl8SE1g
         i2zVNYncg3Vo6tr3U/9bS0kP2RhvVsnEWsTtMaA/R6+o54U4UknUxueXtnb9R9PNl753
         UHIg==
X-Forwarded-Encrypted: i=1; AJvYcCXT0TkzFQipYMv3m55RmrxMWIjvSavTb8lzb0r5b3fkgcGOqzBi8D0biqvc1tQRVQCq5i3w68YcX5J8kR5qpVVs@vger.kernel.org
X-Gm-Message-State: AOJu0YxgeIAvWmehMW9dwr3m8/yPx0S0zz1K9v6kt90GLr4Rhnolexh6
	SvTPY1fb/dCJkJXcZRnjE8+eAEmY16ZdVxpuIeZXEl4ziyzQua30mYIfUDwmxchHg6BwfdZNtJy
	21CmsfPvTZmFWUMJqkOcV+gaC4SgyZo6YsOom
X-Gm-Gg: ASbGncu+2JyJwNj47rO4rlGzvegjJKc66pfCQx8GBNJPNpz4U+dQo/O01fpF5WxAL08
	RI98EJB68qXuBMsX1WJXWBx68S4sOfZip3P/SvtkFRoQi2q377rpXxRSr5HQo5/iS2oH/3kNhHq
	FKv488Aza9EK/IBPXSp/ZK408VIJ50+Ab6eay61YuOwdU2fLC7wlwq
X-Google-Smtp-Source: AGHT+IE/rO/BPgcEsjghdwMpDQqishD2ZxpXy+zlkKgWovm8/eP1MfW4nKW3b/8CtQ7LLtWZng5pgkIp3VJy69BjzUY=
X-Received: by 2002:a17:903:13d0:b0:21d:dca4:21ac with SMTP id
 d9443c01a7336-22a89eaec48mr294455ad.6.1743704739983; Thu, 03 Apr 2025
 11:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com> <20250401182347.3422199-3-irogers@google.com>
 <Z-6WY4a6RV1bEbNU@thinkpad> <Z-6aoJ3ohVHPsF0A@thinkpad> <CAP-5=fU6E1_8Vzki1dVyb8hDEYOXaSNSrJJkR6AOU8xqvknT8w@mail.gmail.com>
 <Z-6n-3ObiNNLQzFw@thinkpad> <CAP-5=fUg_QmWBRUM4tc7zF-rCP9D5+=AqP_FPPYiFEybhcvbhA@mail.gmail.com>
 <CAP-5=fUkoiZXL3J7A_pjP07fY+vv3Gs0BHXMXxpo1NOngXKtrA@mail.gmail.com> <Z-7RDmHVWqJWS1aV@thinkpad>
In-Reply-To: <Z-7RDmHVWqJWS1aV@thinkpad>
From: Ian Rogers <irogers@google.com>
Date: Thu, 3 Apr 2025 11:25:28 -0700
X-Gm-Features: AQ5f1JoJ2BJGOGUf6FZpYmFCqgQtT7EopMuM-ldesSWRx0Iz3RBrY10aYZHLI2U
Message-ID: <CAP-5=fXSnSBs8+O5AzzdoQR-fk6jwzBC3nEkvHF8PxFnZTUOtA@mail.gmail.com>
Subject: Re: [PATCH v1 02/48] tools headers: Silence -Wshorten-64-to-32 warnings
To: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nathan Chancellor <nathan@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Kyle Meyer <kyle.meyer@hpe.com>, Ben Gainey <ben.gainey@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Eder Zulian <ezulian@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
	He Zhe <zhe.he@windriver.com>, Dirk Gouders <dirk@gouders.net>, 
	Brian Geffon <bgeffon@google.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Howard Chu <howardchu95@gmail.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Jann Horn <jannh@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Jihong <yangjihong@bytedance.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Hao Ge <gehao@kylinos.cn>, Tengda Wu <wutengda@huaweicloud.com>, 
	Gabriele Monaco <gmonaco@redhat.com>, Chun-Tse Shao <ctshao@google.com>, 
	Casey Chen <cachen@purestorage.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Weilin Wang <weilin.wang@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Andrew Kreimer <algonell@gmail.com>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Zixian Cai <fzczx123@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yujie Liu <yujie.liu@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 11:18=E2=80=AFAM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Thu, Apr 03, 2025 at 11:12:30AM -0700, Ian Rogers wrote:
> > On Thu, Apr 3, 2025 at 8:45=E2=80=AFAM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > On Thu, Apr 3, 2025 at 8:23=E2=80=AFAM Yury Norov <yury.norov@gmail.c=
om> wrote:
> > > >
> > > > On Thu, Apr 03, 2025 at 07:52:45AM -0700, Ian Rogers wrote:
> > > > > On Thu, Apr 3, 2025 at 7:26=E2=80=AFAM Yury Norov <yury.norov@gma=
il.com> wrote:
> > > > > >
> > > > > > On Thu, Apr 03, 2025 at 10:08:39AM -0400, Yury Norov wrote:
> > > > > > > On Tue, Apr 01, 2025 at 11:23:00AM -0700, Ian Rogers wrote:
> > > > > > > > The clang warning -Wshorten-64-to-32 can be useful to catch
> > > > > > > > inadvertent truncation. In some instances this truncation c=
an lead to
> > > > > > > > changing the sign of a result, for example, truncation to r=
eturn an
> > > > > > > > int to fit a sort routine. Silence the warning by making th=
e implicit
> > > > > > > > truncation explicit.
> > > > > > > >
> > > > > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > >
> > > > > > I'm the first person in the To list, but only a couple patches =
in the
> > > > > > series are related to my area. If you want to move it with me, =
can you
> > > > > > send bitmaps, bitfields etc. separately?
> > > > >
> > > > > Hi Yury,
> > > > >
> > > > > If you think it is worthwhile. I did the series to see how preval=
ent a
> > > > > bug was in perf's code - inspired by Leo Yan fixing an instance o=
f it.
> > > > > I would prefer not to be on the hook for all the kernel warnings =
:-)
> > > > > Perhaps casts to avoid changing bitmap_weight's type. Unfortunate=
ly to
> > > > > get to where the perf issues were I needed to clean up header fil=
es.
> > > > > In the bitmap cases the change is just to make implicit casts exp=
licit
> > > > > and I don't know how much value you see in that.
> > > >
> > > > Your changes  are technically correct (except for non-synced kernel=
 and
> > > > tools), make the code cleaner, at least to me, and address pretty v=
alid
> > > > compiler's concerns. To me, it's worth to apply.
> > >
> > > Ok cool. I'll make a separate patch series for them. Sorry for giving
> > > you such a long patch series with limited signal to noise.
> >
> > Posted here:
> > https://lore.kernel.org/lkml/20250403165702.396388-1-irogers@google.com=
/
>
> Yep, I see. Let's wait for a while for any feedback? If all OK, I'll
> move it with my branch.

Great, thanks! I only did the kernel version and not the tools version
as the tools versions are already quite out-of-sync. It makes sense to
get the kernel versions good and then pull them into tools.

Thanks,
Ian
