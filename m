Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977E326D73
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099437; cv=pass; b=IKMyKmUi8kIGxRgGOodrVVloKB//QDroMhhUx/yE6zOLPt6hJKl9BR9hzJG2KA+OwiRQM+8c9W58IQ0jYenlWqNDOOQBDf7PkmvNankMx4RRmzH85FoaKvGZ4eXx1c162XT8dzPSLrPst2urc9CyVGQhHuZsADTvobV1A8zbU8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099437; c=relaxed/simple;
	bh=eUYh5fZ2H/lrvWYY8ZArALVyB0TUBG8Z/B/6j5qezZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZ5JbU5Ok3RBOUBMv3ZJyP45TaBjHY+s8Y3eoGY36nCly4R1Xc380/hKTSvQbwGuoDHWBQ1zqg2JXzY6AD2dcjT1eoDks/LpGkpZzuH9i0VF0dLz7SIZcF5GXgkvo4oGpoYfXlh3RuslHakzmzLfTzxK/9IT4UILCSKCJFf5Cpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=auU3US4Q; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="auU3US4Q"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso128985ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 09:57:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776099435; cv=none;
        d=google.com; s=arc-20240605;
        b=PcsrEdBbK+3He5o/Rk3+CGDzc2m0wLOYAM50OM78EygRFupkQUhGALmjYeKhHJl7uf
         wXt6YyIv3mE+K08P5PUt6kInQcUCxEmStfQCyfuYVnwc0Yoi/JZLW7qfMmKGZXEBp/Fm
         FjqNxeBgog7sEgI5YZ1dUwBGFuvGh+Frvd3Ws1GY8u41O7WBfGVCzMQKAbSlqa4lIhkT
         KoqcaXEqlLLyONOEwK2eFKSLugGStb/z1mMLkkjB5VqIwwKgMJaqnb6rwapXZdNJ1Gty
         8B+fWjVk04gqONCbv6Q1P3VaO51ibwHIJ/xgSVuqk76MPvZPsuUOCtqItF1aRhOiaD2Y
         L5IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JNh/xfzQ80pt9xupHq6FNyqy/TiMnj92GOSqlZIM7lk=;
        fh=VGWGnACjPzWFc48FUJX9YrxBRc4aose9+OGPBO3MEhQ=;
        b=Q5l3y1KDP3NqQaLTK4VSNTJEK95sRy1TpeH5fOoQJkm8EjvpWkqKYbK48kdHvSf//y
         x7Qra+HsyIV9kEs8nMwPnBDv2xtuazR/9RtI5eeghNQrdaNHKLLsewLuWV51lYpHYlM/
         /nGcPWAXLIkzm2eUvOK5nBr2TIBD6kRe1NHcKP+fwZ4xWJEIrN/hyPH1yD3eymlnuIOY
         oWiVxZLIcmRWcV4ANUQfPMadl3d8JUwDRhtYff7jvBjWT5A4ljAxDMZawa8Ie3qr2WPu
         wpGVGvLg8x5Jc67O0UV/lyj6oU7de295pCf/2re5WhSxFOjcQt2NjYEkm3QwRTUNN0Wd
         Fu5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776099435; x=1776704235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNh/xfzQ80pt9xupHq6FNyqy/TiMnj92GOSqlZIM7lk=;
        b=auU3US4Qsir+k4xnDqyR2Y2WYziGB6GYdluyFYXOnYtjXQtsdHRC18CIP7a6jNrXjK
         23MTCfKhT42J9TbqSdSsuf+sPCy+uq6P7+ujjISjFtuNoh31gXaqIb5xhJIRh+EeET0r
         BSEPeE6vKuhWekGjSj5n6eyBjy7UXS+S56IMAvWumU9o2xkBU8WfG/k9dnwhZ7uYGYqm
         yHE8xr1HFpiiMthrfZRQpV5ore4XtMtVzlpOBwG0BmpoVD5OxVBxMzd2q7X7AxUtPCdu
         4yDVkujbP0KNV52UDPQC2D9GuctZj3LlroyGv5I7WG2+cx1mngLHfGKeB39YtCz9ny4i
         lNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776099435; x=1776704235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JNh/xfzQ80pt9xupHq6FNyqy/TiMnj92GOSqlZIM7lk=;
        b=ZVJ16nAF6koYYH07y1qgDclPmvNXryZnxL7Vec2fjCKDaa2+VW6mSkv9PHyLv5PwLf
         jUcbwMiRbeh6tBz4Qnk/YYNsUBv/jF1nnNbIgpZR7XoUvSOXVInqE2WxhDMo8ysErzRO
         vwDtCMDwvAxltOldPFVeXVgSwKRp51Y7iVLobhke7a0becSXQt0klS4qmLL0Pd6daYyJ
         TQOWis4HFBssxJYw2poRbqb6jGGFINC/De0rOv1+c9WRjHoP3v6bfPuW0YTtPs9xtiGI
         Y2llJx6f1wJ05h1WefpaQ+ToUXuMGeIJ2X/mpG5YaF+PIRn7X7MgK76cZPulGBOhxY1j
         AK2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+/9OvtOhshKb2OP+Qcmwl7NLwtFzLaLKlgVsMgWdDadWVKqIHKVFl2+fBhxkfVN8J/bsDwQNPQKnx1tZD8+sFi@vger.kernel.org
X-Gm-Message-State: AOJu0YxnzXVMLApO2KOeG5nN7eP8bOAGcS48Kxu+p4JdQ1DbVhLzxMPh
	hkMvEKUDl9X6XbMY4sqpEcGp54i7tVVFUYslXpd3uIytGFn9M7N2XmhWJ2LETWfh1X34gSIcvCg
	JGC89wawNMc07YRA30Iva/20+c5PDNLbEbdWTKs/K
X-Gm-Gg: AeBDieuI+H6Ywv48Nc9gRh+db0JuLLhh034To5Uvd70Ii6mOKQuzFkTQUGEX3TDloPO
	5Yn96MKVD3cSs0y971vOn0ZRIYtVxnj0GqX8e+GA5Thgh5ZQLAMU5Ea9Sa2NQkGX4o82rmQzOEx
	+v3eXYvgFdPAan3CLGqUxGv7RJCiynqzKczTNDh2lT2PPUJ1iSarMgU2yBYzEL5yTOImAPc56X5
	q80B541FbxQPBMgXdtUWBxuUBREYQ3StUEzgb5ZPes1FEKg7+G0GnJIFIA9DHvtLEgfh/8fGzYS
	b5U00+tmBxYqrIY6kWCtBWPcFoeaYK+OPOBZ0KwlUukB2TUB
X-Received: by 2002:a17:903:3c4e:b0:2b2:4663:abe0 with SMTP id
 d9443c01a7336-2b2c8c7575bmr11795055ad.7.1776099434792; Mon, 13 Apr 2026
 09:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
 <adv8Ka16pvgVkm8R@google.com> <CAP-5=fVc-Ac09cnXYPUVcNwzHOqFod0v=-YjjDf_oVHvM7cHDw@mail.gmail.com>
 <ad0cfz-gUKea5bI8@google.com>
In-Reply-To: <ad0cfz-gUKea5bI8@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 Apr 2026 09:57:02 -0700
X-Gm-Features: AQROBzDcjIbd6vcU20bgz2tcxZdP3TRqw5gtMprZEuqb37Pt7-4MkLe0t4ewu8s
Message-ID: <CAP-5=fVs9vhofGdgE6MjAY6QND=VvfEmj1j8jz5ytC5ehAwYog@mail.gmail.com>
Subject: Re: [PATCH v10 00/29] perf tool: Add evsel to perf_sample
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 9:40=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Sun, Apr 12, 2026 at 05:52:57PM -0700, Ian Rogers wrote:
> > On Sun, Apr 12, 2026 at 1:10=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Hi Ian,
> > >
> > > On Sat, Apr 11, 2026 at 07:08:03PM -0700, Ian Rogers wrote:
> > > > Nearly all perf code ends up passing an evsel with the perf_sample,
> > > > which is problematic if you want to rewrite the evsel such as with
> > > > off-CPU processing - all uses of the evsel need fixing up. Previous=
ly
> > > > I'd mailed this patch as an RFC with everything combined:
> > > > https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google=
.com/
> > > > and there was a request to break it up.
> > > >
> > > > v10: Changes to some of the bounds checks as prompted by Sashiko.
> > > >
> > > > v9: Clean up some error path nits caught by Sashiko and simple boun=
d
> > > >     checks Sashiko recommended.
> > > > https://lore.kernel.org/linux-perf-users/20260411191710.524998-1-ir=
ogers@google.com/
> > > >
> > > > v8: Fix address sanitizer issues with kwork and move patches, along
> > > >     with bound check additions, to end of series.
> > > > https://lore.kernel.org/linux-perf-users/20260411065718.372240-1-ir=
ogers@google.com/
> > > >
> > > > v7: Separate out kwork work->name to a strdup into its own patch, n=
ow patch 4.
> > > > https://lore.kernel.org/linux-perf-users/20260408072601.210837-1-ir=
ogers@google.com/
> > > >
> > > > v6: Address more Sashiko feedback.
> > > > https://lore.kernel.org/lkml/20260404034325.3172592-1-irogers@googl=
e.com/
> > > >
> > > > v5: Address feedback from Sashiko and Namhyung.
> > > > https://lore.kernel.org/lkml/20260403204017.2919994-1-irogers@googl=
e.com/
> > > >
> > > > v4: Fix more sashiko issues: bounds checks, memory safety, making
> > > >     refactors better, inconsistent evsels, mmap2 buildid injection
> > > >     choice of evsel, mismatched function arguments.
> > > > https://sashiko.dev/#/patchset/20260320080835.724836-1-irogers%40go=
ogle.com
> > > > https://lore.kernel.org/lkml/20260320192627.368357-1-irogers@google=
.com/
> > > >
> > > > v3: Fix various sashiko review comments particularly about unintend=
ed
> > > >     behavior changes.
> > > > https://lore.kernel.org/lkml/20260320080835.724836-1-irogers@google=
.com/
> > > >
> > > > v2: Add review feedback on the first 2 patches from Namhyung, fix a
> > > >     missed evsel assignment running event2evsel in builtin-inject.
> > > > https://lore.kernel.org/lkml/20260319232334.287517-1-irogers@google=
.com/
> > > >
> > > > v1: https://lore.kernel.org/lkml/20260209174032.4142096-1-irogers@g=
oogle.com/
> > > >
> > > > Ian Rogers (29):
> > > >   perf sample: Fix documentation typo
> > > >   perf tool: Remove evsel from tool APIs that pass the sample
> > > >   perf kvm: Don't pass evsel with sample
> > > >   perf evsel: Refactor evsel tracepoint sample accessors perf_sampl=
e
> > > >   perf trace: Don't pass evsel with sample
> > > >   perf callchain: Don't pass evsel and sample
> > > >   perf lock: Only pass sample to handlers
> > > >   perf lock: Constify trace_lock_handler variables
> > > >   perf hist: Remove evsel parameter from inc samples functions
> > > >   perf db-export: Remove evsel from struct export_sample
> > > >   perf hist: Remove evsel from struct hist_entry_iter
> > > >   perf report: Directly use sample->evsel to avoid computing from
> > > >     sample->id
> > > >   perf annotate: Don't pass evsel to add_sample
> > > >   perf inject: Don't pass evsel with sample
> > > >   perf kmem: Don't pass evsel with sample
> > > >   perf kwork: Don't pass evsel with sample
> > > >   perf sched: Don't pass evsel with sample
> > > >   perf timechart: Don't pass evsel with sample
> > > >   perf trace: Don't pass evsel with sample
> > > >   perf evlist: Try to avoid computing evsel from sample
> > > >   perf script: Don't pass evsel with sample
> > > >   perf s390-sample-raw: Don't pass evsel or its PMU with sample
> > > >   perf evsel: Don't pass evsel with sample
> > > >   perf kmem: Add bounds checks to tracepoint read values
> > > >   perf sched: Bounds check CPU in sched switch events
> > > >   perf timechart: Bounds check CPU
> > > >   perf evsel: Add bounds checking to trace point raw data accessors
> > > >   perf kwork: Fix address sanitizer issues
> > > >   perf kwork: Fix memory management of kwork_work
> > >
> > > I've picked the first 23 patches to tmp.perf-tools-next as the rest
> > > still has some issues.  Also I've touched some commits to either remo=
ve
> > > some parts or split them into separate commits.
> > >
> > > Please take a look.
> >
> > Hi Namhyung,
> >
> > thanks for doing this but I've done a similar clean up. To totally
> > separate the evsel refactoring from the rest of the changes, to fix
> > the address sanitizer issues with kwork, etc. I'll incorporate your
> > changes and then resend the series.
>
> Thanks, I'd like to merge what's in the tmp.perf-tools-next unless
> there's a serious mistake.  You can rebase the rest changes on top.

I'd drop what's in tmp.perf-tools-next. Otherwise we're putting fixes
on top of fixes. Looking at v12 the sashiko issues are all minor and
the progression of the patches is more granular and natural.

Thanks,
Ian

> Thanks,
> Namhyung
>
