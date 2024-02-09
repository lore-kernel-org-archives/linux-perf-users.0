Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D068657A8
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Feb 2024 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707462823; cv=none; b=kLohDO8PnjazQs6X0+m7WDUcuTaZa07rBvryBsQwJTh2Z517jgPZFiqteZmwvOOt5ny7vZSx5dgXCDGM3BZc32+mQSsUUVL44ZmVuuNDT2VYWqEXhacR4Vyv/TGnuX3H8vksuEp0tTnY82xWi+FHfjcg8N7PGGaVfJrytp7XcvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707462823; c=relaxed/simple;
	bh=N7IYJkWIQjsV2m3g4T9AVblWnB9WhQgPbKYgNguuh6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKBahjGcPk+CGy+wcxspDtNAs9X4PqylTxGKLsXn6snHyDtqpEgTirowJTIT3MdLBkWeWKKSWpGgP8PBXFelN5G8XJGeIZVvQ5MdYb0egDvN1JXyoLnoCj+Z9ju2Gd3FYH8395eNn3Tt25+3N3FwUfG0N0T4iGktjuArFut02N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso459859a12.2
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Feb 2024 23:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707462821; x=1708067621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbZwuRwQwnHEylxz/xDzNyGpeBZ2Cv+gHCnWW3yvsCU=;
        b=Y82P9TOAffvJ/x3C7+gfj8y+OieW1rKCUvEemTDf/NxZCQmANlqmcpi5/aOa174iks
         s68+LnepqM+hsY2y1Ny+TuA4A0wsnU7gz2brfJeRV0J7bxWMGc7jRHPmUi6k9C+CzPCy
         9V6UD8SAooJn8CwJBVOTIIN6LlaUwybaNh/rPL62i1C3hA0V2vI2LvCaMIT2bHnheDrW
         Nd3iaNl9pX/wxvWUMHPBdB+k4ERG9g6k/ukhdTTcvXX7SSNIyM6cVFISaTROPCmDFHCv
         Hd47/Kxk2sSx+WxMbzzlH3q8BE/u6dhLmG3b9yiIgaWkNBXXFORyoKztvCfJbrR7JK8x
         IoaA==
X-Gm-Message-State: AOJu0YzqVr7/LmIyuQHo+z0x1/gscgOKOwTsC+0A7FfPowBN/BfaRBa9
	JFiDs+6r5BQIFiahPxDzAWsGRUMorx0i+u0kiTCXnDg2haX80wPpcN+g2Tyeb8As/A6HNugcquf
	twEp75RpdyUEtXEJrFgZy1f8AlMnZj/PXTYA=
X-Google-Smtp-Source: AGHT+IHrwUgDChbr+g9X1zRvi0PNYI3QYuPyRl7jsrJVgAfpTkveVBd5OJxjFtI43jV4Bxj7O1hVIJs2vggBcScqRZ0=
X-Received: by 2002:a05:6a20:9593:b0:19c:5b32:9504 with SMTP id
 iu19-20020a056a20959300b0019c5b329504mr1109026pzb.49.1707462820644; Thu, 08
 Feb 2024 23:13:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131113951.17077-1-mpetlan@redhat.com> <CAM9d7chjET+Zy7EYcRNW=9XaC+DKcqqU+EatiGJouRCjjHscKA@mail.gmail.com>
 <alpine.LRH.2.20.2402081741080.11354@Diego>
In-Reply-To: <alpine.LRH.2.20.2402081741080.11354@Diego>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 8 Feb 2024 23:13:29 -0800
Message-ID: <CAM9d7chDp4_+Mk+-CNw2Es9MBtA7f6pbJ3X5cqpDfUjc+QkMQA@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf testsuite: Add common regex patters
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, vmolnaro@redhat.com, acme@redhat.com, 
	acme@kernel.org, mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 8:49=E2=80=AFAM Michael Petlan <mpetlan@redhat.com> =
wrote:
>
> On Thu, 1 Feb 2024, Namhyung Kim wrote:
> > On Wed, Jan 31, 2024 at 3:42=E2=80=AFAM Michael Petlan <mpetlan@redhat.=
com> wrote:
> > >
> > > From: Veronika Molnarova <vmolnaro@redhat.com>
> > >
> > > Unify perf regexes for checking testing output into a single file
> > > to reduce duplicates and prevent errors when editing.
> > >
> > > This will be used in upcomming patches in shell tests.
> > >
> > > Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> > > Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> > > ---
> > >  tools/perf/tests/shell/common/patterns.sh | 256 ++++++++++++++++++++=
++
> > >  1 file changed, 256 insertions(+)
> > >  create mode 100644 tools/perf/tests/shell/common/patterns.sh
> > >
> > > diff --git a/tools/perf/tests/shell/common/patterns.sh b/tools/perf/t=
ests/shell/common/patterns.sh
> > > new file mode 100644
> > > index 000000000000..919a07b8b454
> > > --- /dev/null
> > > +++ b/tools/perf/tests/shell/common/patterns.sh
> >
> > We have tests/shell/lib directory, maybe better to put this there.
> > But maybe we can move it later once we apply the series.
>
> Yes, in case the testsuite gets accepted, I plan to work further
> on the integration with the current shell test set, in order to
> unify the configuration, output, logging, etc. So, I'd prefer to
> merge the directories later.

Sounds good.  I'd like to merge this series to improve the test
coverage.  And then we can work on fixing problems.


> >
> > > @@ -0,0 +1,256 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> [...]
>
> > > +export RE_ADDRESS_NOT_NULL=3D"0x[0-9A-Fa-f]*[1-9A-Fa-f]+[0-9A-Fa-f]*=
"
> > > +# Memory address (not NULL)
> > > +# Examples:
> > > +#    0xffffffff9abe8ae8
> > > +#!   0x0
> > > +#!   0x0000000000000000
> > > +
> > > +export RE_PROCESS_PID=3D"\w+\/\d+"
> >
> > I'm afraid the process name can have spaces like
> > "my proc A/9876".
> >
> > Thanks,
> > Namhyung
> >
> Good catch! Theoretically yes. It is not used yet (perf-trace tests use
> this regexp; we aim to post the rest of the testsuite later). However,
> looking at the perf-trace testcase, it runs also `perf trace -a`, so
> if there are any processes with non-standard name, they would appear
> there. But that's not only space, but also other characters, like '+',
> etc. We will try to fix this to match any valid process name. Thanks.

Ok, I'm looking forward to seeing more test cases.

Thanks,
Namhyung
