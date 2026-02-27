Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84ACA42E007
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Feb 2026 17:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772213470; cv=pass; b=etIVJuzmhbd+SYzFzo9VgNIZ2ENccAdfxuwtTCpI7dpntfVQtYhMnHnPgvitBBcE6fDQZXRTOtpFHcnac3F3o8YCgKoYpvBq1CijVG+q6lMyUKWw+WLSxF/OpbpvEmCVB9RLJe15K27dg8YxORDVT4eckpH3TUa+z9eBsYzmj5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772213470; c=relaxed/simple;
	bh=oGvbYERDzpf+ud1yN5pymK09PqOVXfjAhmXrla93aTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfLZD21w44lAKckDDwrCAdLM4GGF7x/WiZMzpjrzIN5KvFHBVpA/kxAWkarXcXnU+GvJdjJjaaLUmIlCnPkenTn40yLIc0ZwPsaNPjUKZD7PYPcBBpmt3WhHEotrJsEG0Xz52L0TIJVQ8fN3jaNBc3dl6sKMVud0lqgcDJMEXJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wcYF5tBE; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wcYF5tBE"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a964077671so385ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Feb 2026 09:31:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772213469; cv=none;
        d=google.com; s=arc-20240605;
        b=Vgf6V71S1Lw3AEY4pdmdN6qBA/WnCptGQiGboxFeKkjwOqpbIOIua5kkgZr6J38BuH
         x6kkYLNbtSsLE5BBcCMfnoX7QaknHAOro2NxKoVcK3BUuOXw/dwm66UKrHLGlL6EiEad
         1vrNylUvgWEHPa1wsH9ARL0ywqI/5lyp63Wac/cB0lqZCyahMjIPrHPeIv5iTzz9QlKH
         3EPlFVvTGWTvksm/k5GlKt1O267jr4faV+CzFF/rypm5SH6nnffegRgLrKIAKFnSaqDZ
         KAwDjovcQyzJoaikeWYIAkiCQqCOWErInda5w2efmWuJK+TFdIkdTW0mJ/+LDLl0AN4/
         VzXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5tHFTaeSsWRCh6JuXEcpq/ukmfs/lMgU64J/6um6Dlc=;
        fh=bQ1wcTKDAGeqXss2B+UzytDIce0qXFMMtX799veZkBc=;
        b=BvGvAbPynTBsZ2ey3TdtumkrGifASNq9D/NC0WoIXPv4t+d7QDZ5zBmarP1qV+bL1t
         PMSrvDE5gMLKzdVPOQKID3SsHkX5qfm6GDUhxk72l42VbS0K4iDIWCCuCV9seqD905/C
         tCybRHNX4K9QdINhVLD4xb8LeTCscloH5KUNUGVIMT0OVHQlSz70Z03127N9XO98xqd0
         cj7o2N0pJshZGhQYnN/UqetB/bafpdpIJNBK8kNOQrv8cKe+dY6v2WV14k6nScvv82jq
         4a0tgPkawqD7uAOSlv0MfKlst8uatbE6LST4ZrYGPiOpymVJ+JBcOmWI6bd5KXB1Skd3
         uIVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772213469; x=1772818269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tHFTaeSsWRCh6JuXEcpq/ukmfs/lMgU64J/6um6Dlc=;
        b=wcYF5tBEO2bm0jRjgRyYEzrlH65squomGOirGrn87JdQzJoHy6NQOYUIF2XZmVnMfA
         24U6VLsZ7e2+HWuBEHob9hdbyGn+gXJcboxxElplSS4VkyKT6tlum6GQDtHeOSqpsCrX
         bHslEhdde9hj7QlgbQPo962roaqux90TJ3rg0WsnwnrNSX3N/Qp4myR8qRptc3q/iJN1
         An64kEXq/7fvtltpc/5itIo4KKIWCoCHmjP2V+TAsqbBZEe0R9DCRaO9F20yiU3Pqd60
         IiQdDm2o23CVmQZy1OUd6I2d6Gi56NLUGltRBsJOETwTY9fyXXyZLNVnQcBIpoMMWHyw
         Ba5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772213469; x=1772818269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5tHFTaeSsWRCh6JuXEcpq/ukmfs/lMgU64J/6um6Dlc=;
        b=QsH1XRcKXXI+mgYKl/rtdMaCywwHMtF89eMMRaxT/q3vLi2ayOgivL1jD7j3jtpoeF
         iz8TlAAauiRd0ufj3Dhxn6D/2CVCfbA4VrkiTpgPysiI4wATP834E1BNYmDhPS+T/R5c
         vmi78gnpO95HGpDZ4uG5AJgpUWoCGMSa3RNVwHCza+ThLy+96F1xfqcDZOYYylmEoqQi
         ei0w+iUDsfx32N3Ds+95uegwIOqiTv+lI7eqJE2iFoSJ4TCIubCXSgK5KQJnPljCBnNv
         uJ4S2r4WMVj+1qkzZOmdI4AEJ4N81olVXwj+RYtPEzlvKKgBkY+rkz0qkJjgNo0odXkd
         wKkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/kWEORdlH7cvUw8+aQB12AGEmQsZu+Y9h6zhJe61VOYgx6nuLpRx5wqJbYZln/gpCNiGHNQM7Rz9BJ96+gDCs@vger.kernel.org
X-Gm-Message-State: AOJu0YzZSzF2V9TnK81WWclYhCYPtzsHf05aPgKvN2O/TWdxveKgZyK+
	X4NtzPWEgWC2RkcefPNxE8WwLaT+R0NMOd4XODwFCBHYkHLdIIB2+YC/uwwgjISeOkqDTKKZWiH
	/FS69QtMJDCoiywgMKhaROkXctyjo6epOOUJH53F+
X-Gm-Gg: ATEYQzzkT8oUnlnxEah7PH8oxcKLDwaWhvq2osAvKBLWoUZEkUwv3tnj6mOZ2MBhW4A
	9KvNkTidXB9Q1IkAsr4SPooEt9l9ezCQ2J+EhBvB/iOJ8u+bVqtxUwgknop+N27WYAXlrMp/IaR
	kOhlt9jWCWLZW3N2d0PmmsJj4eCm9ayK61HT3b5nwSs02ySBNSWiRgQExTeEenSnGtUlWa9VkE9
	hki74nEP+HzM0qg39sYRNB39OSMVNBznX/4JlOji8uH+lv9PFyEvbtGDvmJNrY0PDWlp/u0jB9W
	fYdcsirB
X-Received: by 2002:a17:902:ebc6:b0:2a0:7fac:c031 with SMTP id
 d9443c01a7336-2adf7782c07mr6002605ad.14.1772213468208; Fri, 27 Feb 2026
 09:31:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206-perf_fix_kvm_stat_error-v1-1-ad40115876be@arm.com>
 <aZ-oYb-FDLVT5MGq@google.com> <CAP-5=fVCdQZ584s_24wQc_+03xL2Npj2qDbqGSjE=Ms1-y8raQ@mail.gmail.com>
 <20260226095255.GF4184494@e132581.arm.com> <CAP-5=fUAK=vzeZWDXuun+wptSeBwUMhZuVqdh4zwLoXoV32VPA@mail.gmail.com>
 <aaFIgR29wGYvHnVp@google.com>
In-Reply-To: <aaFIgR29wGYvHnVp@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 27 Feb 2026 09:30:56 -0800
X-Gm-Features: AaiRm52fkMNibtcFZspq25GKe0DGSaSGrK3KmHwv551WsbO8r9P3VSv8eF7LXXA
Message-ID: <CAP-5=fWGpmk6w+SUv5PnhEXxyYe87ostV4sNZa0tZVPWhh+GjA@mail.gmail.com>
Subject: Re: [PATCH] perf kvm stat: Fix build error
To: Namhyung Kim <namhyung@kernel.org>
Cc: Leo Yan <leo.yan@arm.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 11:32=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, Feb 26, 2026 at 08:44:51AM -0800, Ian Rogers wrote:
> > On Thu, Feb 26, 2026 at 1:52=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote=
:
> > >
> > > On Wed, Feb 25, 2026 at 10:36:26PM -0800, Ian Rogers wrote:
> > >
> > > [...]
> > >
> > > > Hmm.. it looks like something has gone screwy with the include path=
s.
> > > > The header you've gotten is:
> > > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools=
-next.git/tree/arch/x86/include/uapi/asm/svm.h#n137
> > > > rather than:
> > > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools=
-next.git/tree/tools/arch/x86/include/uapi/asm/svm.h#n137
> > > > where the value differs between -1ull and -1.
> > > >
> > > > In Leo's change he has the include path as:
> > > >   #include "../../arch/x86/include/uapi/asm/svm.h"
> > > >
> > > > but I think that is off by one and should be:
> > > >   #include "../../../arch/x86/include/uapi/asm/svm.h"
> > >
> > > Sorry I did not check the header path carefully.  A bit thoughts:
> > >
> > > The perf build will not include headers in relative paths as we
> > > expected.
> > >
> > > It tries to find headers with appending search paths.  As Ian said,
> > > I saw .kvm-stat-x86.o.cmd that includes kernel headers:
> > >
> > >   /home/niayan01/Work/linux/tools/include/../../arch/x86/include/uapi=
/asm/svm.h \
> > >   /home/niayan01/Work/linux/tools/include/../../arch/x86/include/uapi=
/asm/vmx.h \
> > >   /home/niayan01/Work/linux/tools/include/../../arch/x86/include/uapi=
/asm/kvm.h \
> > >
> > > I'd suggest a fix in Makefile as below.  The idea is to give priority=
 to
> > > the lower level folders under perf, so that headers in the deeper per=
f
> > > directories are searched first.  This avoids searching any kernel hea=
ders.
>
> It fixes the problem, thanks!
>
> Tested-by: Namhyung Kim <namhyung@kernel.org>

So it is still the wrong fix. The relative include paths is the real
issue, just add the missing "../". I'm not a fan of changing the
include order as it has the potential to break things due to the
subtle way that includes are picked up, tools/include isn't hermetic,
etc. While it may fix one build failure we are likely creating build
failures for others - well me, with bazel, for sure.

Thanks,
Ian


> More comments below.
>
> >
> > I'm not opposed to the change but I still think we should make the
> > relative include be to the correct files. Some other thoughts below.
> >
> > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > index a8dc72cfe48e..47359f672b6a 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -388,8 +388,10 @@ ifeq ($(DEBUG),0)
> > >    endif
> > >  endif
> > >
> > > -INC_FLAGS +=3D -I$(src-perf)/util/include
> >
> > Not clear to me why we need a util/include on top of everything else.
> > It seems somewhat random what is in util/include rather than just in
> > util.
>
> It seems it tries to override some kernel headers but I'm curious we can
> move the files to the tools/include and get rid of the directory.
>
> >
> > >  INC_FLAGS +=3D -I$(src-perf)/arch/$(SRCARCH)/include
> >
> > Hopefully with the removal of the arch directory (and fixing of
> > cross-platform profiling) in slow chunks by changes like:
> > https://lore.kernel.org/lkml/20260224142938.26088-1-irogers@google.com/
> > we can get rid of this one.
> >
> > > +INC_FLAGS +=3D -I$(src-perf)/util/include
> > > +INC_FLAGS +=3D -I$(src-perf)/util
>
> I also hope to remove $(src-perf)/util too and use path relative to
> $(src-perf) always for perf-specific headers.  But this is a separate
> topic.
>
>
> > > +INC_FLAGS +=3D -I$(src-perf)
> >
> > This:
> >
> > >  INC_FLAGS +=3D -I$(srctree)/tools/include/
> > >  INC_FLAGS +=3D -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi
> > >  INC_FLAGS +=3D -I$(srctree)/tools/include/uapi
> >
> > to here means that we prefer linux headers over uapi headers, which I
> > think is the opposite of what a user-land process would expect. I
> > think we should move these headers into two libraries, build them with
> > an `install_headers` rule, and make the include path pick up the
> > headers from where they are installed. As the linux and uapi headers
> > are licensed differently, this would clarify the dependencies and
> > licensing implications.
>
> Sounds good.
>
> Thanks,
> Namhyung
>
> >
> > There's another can of worms regarding whether libperf is something
> > useful, outside of declarations in event.h.
> >
> > Thanks,
> > Ian
> >
> > > @@ -403,9 +405,6 @@ INC_FLAGS +=3D -I$(obj-perf)/util
> > >  INC_FLAGS +=3D -I$(obj-perf)
> > >  endif
> > >
> > > -INC_FLAGS +=3D -I$(src-perf)/util
> > > -INC_FLAGS +=3D -I$(src-perf)
> > > -
> > >  CORE_CFLAGS +=3D -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_G=
NU_
> > >
> > > As a result, I can get the search paths in .kvm-stat-x86.o.cmd:
> > >
> > >   /home/niayan01/Work/linux/tools/perf/util/../../arch/x86/include/ua=
pi/asm/svm.h \
> > >   /home/niayan01/Work/linux/tools/perf/util/../../arch/x86/include/ua=
pi/asm/vmx.h \
> > >   /home/niayan01/Work/linux/tools/perf/util/../../arch/x86/include/ua=
pi/asm/kvm.h \
> > >
> > > Please let me know if this makes sense.
> > >
> > > Thanks,
> > > Leo
