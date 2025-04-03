Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA272512F5
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Apr 2025 15:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693619; cv=none; b=pVSV+4hjTBgG9sDwfSUbvCLS7DsljnGQeWakhbKsSZcEkR7wtcxce+WFgRwFOJIDBzrFxiLJuEB10FR0lFqfjWod/MTURcw1HkjujQSEVabDiRGcbT3E+Aonn6EVtLq35LaxHGApz2mb7af0GBQuoYjW5QVKPDCktf54ltIc5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693619; c=relaxed/simple;
	bh=fs/LgmkI6TCB22kZDq7aZ4mKYQ7Ys72g3BpfWw7P6I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WerimmpU029h+vZja006cKnTsAQeZsPToCgLfKN0Ss4pIv1Gtpoi781+jZlL+R827RZTA9H4drQmvYNIlcniVGUKcOEJXK8PSrHNJydaLeY2JOhDIfs/SWGPQm9RjxpBp6jV/RyvQpHsTorTUvb7VkdPCVp97Ulohn9ImT7HI9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JbkZe1g+; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JbkZe1g+"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2263428c8baso441365ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Apr 2025 08:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743693616; x=1744298416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dee6zgCJQcuroOxMyva+g4mLE8nxhGO4+8IU7ckIVZI=;
        b=JbkZe1g+MmU3xE4BYLYDZ9x2PuBZjgTugW4vZnK+5Lk5ykBsjK+RtlLGOtOKFTH+v+
         5ChoTXeICUl6gH2R8rF66dJYcOUVkXmcXcUODmPxFTP2A40Os89dWw8MSVDpjiLWIoYB
         yWosDwWWS5JpbmyufQhlQBLVEE+KCuuWujBL9RZu3+YkVQn5qd6iHD7g2adeBU/ZsRHG
         nR6+lGMICtPJJlcReOhYEy+arw0Bn0J6rPSdlxOyNJ2cpeDuwF5YxxUxXXmCcWV2nOp5
         M+QFrQ680KPmfI7ZOR85IinrPK3El/DJG9CbjxDsPJheE7dg68MMBvD1KmP1u2lpn/aA
         G4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743693616; x=1744298416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dee6zgCJQcuroOxMyva+g4mLE8nxhGO4+8IU7ckIVZI=;
        b=XbLAhnrjWFkxPcqhs45e7nVxpNJa2fIhppvaRHxR3yD4dJn7rCKOzyYaQSDK50Cuij
         Kkc5nCPm5ZjUYMAZifaOQp3qj56YvzRjT5sIH9iDulG+l+DHGYYIoHdeS7L6KtE5BYUo
         BTAOlISdLFNqZs2OYra0Mpc2b26Rz8cow22W0LmWJW/6d8/flHdwUaK6EeKPW1nHx8Bl
         V02XK/j43RvClFCiDTkkrsLVBVKffJNCMeO1p7SsqY45zzXg6OmpudrLUT0NORD+ZO//
         ozvxco+0UI9CRTpNG67PzpMcO/0LicO2okS5sbw6xGi5kNGNNZwm8ZMEls5JjoW0Y4q5
         eVCw==
X-Forwarded-Encrypted: i=1; AJvYcCUMJWs6k44BzyY3XECg+z2KffnuPGz12GQpdb5HwzlM1HRUYwOVHFvc8zKeYkHp2+RVxPkC1+OoFdR8+Po9rG1i@vger.kernel.org
X-Gm-Message-State: AOJu0YwPXTyT9KYRgzOrmXShLZHf8SR3vuR8AS4Ux1aLG0QwmhOA/YMa
	s1gL5YmL86CyIfrR5Y4OFI17m0zggy6dFC2oi2EEs707CS8ynjIyqImaX0wpJ/xkHD3oxQ3Xf20
	6g6pe9RrFpD8N2DFZ5YRl3mASpJIcijuQfIE2
X-Gm-Gg: ASbGncvk0wc7Sar++rWwNDDKxY5FRPJJteo8sOdv7XR+OqvpYygfxEp4RhPA6LvNWgL
	ycCfDdkhQTncd9RTq2GPD2/cHq+oeUxDSPEIDJEFttQStQFdzZDbFXnvcUoJ39beN8PEDAVYDaZ
	2eq5e0mNTEO61mFunJCiy0QO9vcet0+L1Gfz/mdNmkmPqoKVn3EZhlk9XfSr+0fiI=
X-Google-Smtp-Source: AGHT+IFEhwZ8kmTMtl/iwHV8qNI1OFYaobGFX/7zawRv5kR1ju7Udkq7RVzg5YOU8bkAPof7E676COqsdShhA0KwDRw=
X-Received: by 2002:a17:902:da91:b0:21f:3f5c:d24c with SMTP id
 d9443c01a7336-2297744d788mr3514085ad.0.1743693614890; Thu, 03 Apr 2025
 08:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401182347.3422199-1-irogers@google.com> <20250401182347.3422199-10-irogers@google.com>
 <20250402143541.GM115840@e132581.arm.com> <CAP-5=fVqax8cxdZ4HLBP4AMxL6jADfYNrORC97T6F23mjf3N1w@mail.gmail.com>
 <20250402163807.GP115840@e132581.arm.com> <CAP-5=fVJkJ39_qx2T9ZHn-fdxjECP_2G+cyfRRAjLvZZt5vz2A@mail.gmail.com>
 <Z-4URXOzsVHTY7zz@google.com>
In-Reply-To: <Z-4URXOzsVHTY7zz@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 3 Apr 2025 08:20:02 -0700
X-Gm-Features: AQ5f1Jqr-b-6hp9r8O06IKgPseV1przGnqwS6fDbopTyglFfk7CJmDeO0vgiHzM
Message-ID: <CAP-5=fXwAA0PNYAOLNLdHY8g+AyEB0UxmzgX5w-gGj_DZqUxtg@mail.gmail.com>
Subject: Re: [PATCH v1 09/48] perf tests: Silence -Wshorten-64-to-32 warnings
To: Namhyung Kim <namhyung@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
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

On Wed, Apr 2, 2025 at 9:53=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Wed, Apr 02, 2025 at 09:53:57AM -0700, Ian Rogers wrote:
> > On Wed, Apr 2, 2025 at 9:38=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Wed, Apr 02, 2025 at 08:42:58AM -0700, Ian Rogers wrote:
> > >
> > > [...]
> > >
> > > > On Wed, Apr 2, 2025 at 7:35=E2=80=AFAM Leo Yan <leo.yan@arm.com> wr=
ote:
> > > > >
> > > > > On Tue, Apr 01, 2025 at 11:23:07AM -0700, Ian Rogers wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > @@ -478,13 +478,14 @@ static int __cmd_test(struct test_suite *=
*suites, int argc, const char *argv[],
> > > > > >       int err =3D 0;
> > > > > >
> > > > > >       for (struct test_suite **t =3D suites; *t; t++) {
> > > > > > -             int i, len =3D strlen(test_description(*t, -1));
> > > > > > +             int i;
> > > > > > +             int len =3D (int)strlen(test_description(*t, -1))=
;
> > > > >
> > > > > Thanks for huge polish.
> > > > >
> > > > > Just a concern from me.  Throughout this patch, the methodology i=
s not
> > > > > consistent.  Some changes update variable types which is fine for=
 me.
> > > > >
> > > > > But the case above it simply cast size_t to int.  Should we updat=
e the
> > > > > variable type as 'size_t' at here?
> > > >
> > > > Thanks Leo, I played around with it, but don't mind if someone want=
s
> > > > to do it a different way. I was trying to make the changes minimal.
> > > > The problem typically with size_t is we then use the value, for
> > > > example, as a printf size modifier and need to introduce lots of ca=
sts
> > > > back to being an int.
> > >
> > > This conclusion is not quite right, see:
> > > https://stackoverflow.com/questions/2524611/how-can-one-print-a-size-=
t-variable-portably-using-the-printf-family
> > >
> > > > When this isn't too great I've done it, but in
> > > > this case I think keeping the int, the lack of casts but a cast her=
e
> > > > to capture that we expect test descriptions to fit in the size of a=
n
> > > > int is the least worst option.
> > >
> > > I would say in another way.  After we enabled a compiler warning
> > > option, this will give us a chance to improve code by dismissing
> > > the warnings (and avoid potential bugs).
> > >
> > > If we use casts just to silence warnings, we also lose the opportunit=
y
> > > to improve code quality.  The changes in this series that fix type
> > > mismatches are good, but I think the use of casts is not particularly
> > > helpful - we're simply switching from implicit compiler casts to
> > > explicit ones.
> >
> > Right, but I think changing function parameters, return types would
> > turn into an epic refactor and the patch series is already unwieldy.
>
> Yep, it's important to reduce the number and the size of patches from
> the reviewer's pespective. :)
>
>
> > With the casts we can see the behavior is deliberate but that's not to
> > say it couldn't be better. With the warnings gone it allows
> > -Wshorten-64-to-32 to find the truly errant 64 to 32 bit implicit
>
> Do we want to enable this warning?  Is it only available on clang?

It is clang only. libbpf fails with the warning enabled, so enabling
it would break all the BPF stuff which isn't good. That said we could
step toward enabling it, which is what the series does.

> > casts. Anyway, I don't have time to do such a larger refactor so
> > somebody else is going to need to pick that up. I did refactor the
> > cases where I thought it mattered more, but as you say that does lead
> > to a feeling of inconsistency in the series.
>
> I'm curious there are any actual errorenous cases other than the return
> type of comparisons from Leo.

There were other cases of Leo's issue here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/ui/hist.c?h=3Dperf-tools-next#n290
```
ret =3D b->callchain->max_depth - a->callchain->max_depth;
```
you can see that file has field_cmp to handle 64 bit comparisons
returning an int, presumably as this problem had been seen before, and
possibly here once the left_count and right_count are made size_ts to
match the hashmap size operation.
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/metricgroup.c?h=3Dperf-tools-next#n1162

xyarray was a source of differences as the max values are size_t,
which is more than they need to be.
The libperf mmap code was truncating the mask field which didn't look good.
The pipe benchmark, and similar, were truncating the read amount,
which should never be an issue as we shouldn't shove 4GB down a pipe,
but it just isn't good.
There are lots of cases like:
```
                case ARM_SPE_COUNTER:
                       if (idx =3D=3D SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT)
-                               decoder->record.latency =3D payload;
+                               decoder->record.latency =3D (u32)payload;
```
and
```
@@ -4830,7 +4836,7 @@ static struct syscall_entry
*syscall__sort_stats(struct hashmap *syscall_stats)

               entry[i].stats =3D ss;
               entry[i].msecs =3D (u64)st->n * (avg_stats(st) / NSEC_PER_MS=
EC);
-               entry[i].syscall =3D pos->key;
+               entry[i].syscall =3D (int)pos->key;
```
where I think the cast is informative that the top half of the payload
is being discarded, or the key deliberately truncated. In general I
think having the casts makes the behavior of the code more explicit
and less surprising, which is a good thing.

Thanks,
Ian

> Thnaks,
> Namhyung
>
