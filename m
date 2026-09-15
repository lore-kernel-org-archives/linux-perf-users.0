Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92DF4DB567
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 20:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789505015; cv=pass; b=QmNG2jQ1arxYhdkvaG6lKU9/b4dklukh0EUBg2ARxtv9yNOEP1pD3l2uqqMYHAcPZeyoRSpg88rDdNLVz0UApXUM+nFYT7uqM0VGeUI7uyX/i3k+2xpNiofpsHaOmdH+miV/tOhHz37VygVU7XbV5PD2fInqzMLKJZSmMGD753M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789505015; c=relaxed/simple;
	bh=5LBKxwU79FGsx7tIU937PL+51gEJAsWIuLxSQRCF9dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJHI7XHHOvPKbfoEQ9k/jYMyJr2ALrvtPHo1FnPWubD351FlFUcAK2aP0ruhezUdb9EUi6/FjsWfwWcXG/7LKdiD58pyt2Xyl5jnFrvirwoABIr7ECji/TjFYflqCo4ObtN1GyzpMwxYUuBDuGwp8E3vuDg9sbBK+oFdXPenB0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iOKKMqGN; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iOKKMqGN"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d5fc2cd8so12461cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 13:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789505010; cv=none;
        d=google.com; s=arc-20260327;
        b=CBehwzbyvtzmnv+iOiKtXXuUCxc3NnsnBRVp/7aqpISt43/mQzYsMR6o4wj056Tovd
         c9xIbJHzASMcCCpHkcIHNSJD9acE1WIy9PPx8jk3O1cDyscT8LG11/Osf6O2Y4/R27+s
         qNP4oAKaqr4TVdZhBDrqhJErUlKujDoQ7NBl5tcuVhRHOWGnm33HkmgaRbhmrbw8f0iQ
         m37J9SSV+n+jTCFHf/f9Foyh/GBPyUfmAwe9QBg/NGt26EFDI4yHQ+MjrzSn1Tx+8E8k
         GDB4z/RgYQfIbk+HWi36kppIMEwDmdelIKJ+vzGlstLgExssH3Y7qSaDl38LcVx+ho/E
         sT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gxcMcTW254D7Js1d9QcVB1rz5hl6w8herQA35v6+0+s=;
        fh=lYkvAKJ0m4rKOQ0D5RGcQ4tqUOn7MWDSZGJBAT+ubBY=;
        b=p6L9/s0Ko/7SZ0IqUzrxMvUgbZaMOEd6tb83d/5JK57v06f7Yu0NBdbpJPb72nbtVQ
         cU0zYbgDJxy8IqpdvFZwQFGNhFvXlv/BKmZRNsJ9l9lg3WpdzSH9j7rAVOTBiiH2Tl+X
         r6NSIAh+AFNSbwL/MhsqoJuTPlnP2xJnLR4ImpfVzaRg1/Wk3YzquNByG6yfGNYXUkBN
         u3cfNAGojiV3kjGBDvTeY9Y1NjxQpdEaDcbw90P9lH8SxeYsyPYIsSNP46DGpD45O2fP
         HiaPza/Adn1QPFNYIHGstiTE8et5DHfJAI+vdr0bp+BFyErnEOwGUbSq4KAuVt371W3m
         R8nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789505010; x=1790109810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gxcMcTW254D7Js1d9QcVB1rz5hl6w8herQA35v6+0+s=;
        b=iOKKMqGNleS1j62hJpNntTODpmoY7xxzX9d4NggjnAqdsk+Jrwv4HJ3dqmNlbkIO2T
         SvSCGeKqFwCUmTOnra8HTiIKSkxCAMXKI2XZdRUPnbAciJzA4b2KLxSW4iNMASCh3mvV
         9OKfoBFNUqxhC/zyzOfSqI6x+h37nad3jI0GxXGxxGaDuWSV+yEg5/uMs9emPVBYOYx2
         uimBoyu75hSCo5/taE+OM3ACKRlLnam24h62AxN21VStrY1sjisFB0Pn7yV4FXW25ZgK
         LuEWH44bi3dfgRiYrEvYa64T7jAJ2HM/v5nPA1F+O6uFKB4ZfJ63ufWcQiddnz0Omw6y
         vfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789505010; x=1790109810;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gxcMcTW254D7Js1d9QcVB1rz5hl6w8herQA35v6+0+s=;
        b=eZlO6VpeBtp1ZwOn3hQrhM2XmpbdQubjQIjtWH5MxkHfYjBtCUe+jjk0jf7VI/Z0+c
         5bKSsOBZouV0NsB3PliWzVoKgcToOgY4C49Vfoq/N6vP9H2roefHqn7Da8VJ+x70E+rX
         8Hfe11xPvC438+8+rpJ0EleRG7G5NHtC9zuM22U/twue/wFyOoXOg4sFGDfyLDEtRJPu
         GaJOzZFG/KheYrfykXoXnWt6PAQy+l0P0r6yom2grWs54+sqY0jjrBqC/1nz1YinsLpe
         ctlmoAe1djGKou2Ug/3HrP06V8Dv2u1zG9yWrUFOTppc98GYDC5/1R8Ys9MNr/ZGKcn0
         T4Ig==
X-Forwarded-Encrypted: i=1; AKwUvByTihiciBV4K0HS7xVZkF09PdwzePbSWiEZlD4rwoU1yYO4DQx2z5YTLTzCm4pE3zw6hxBbwKE96TkRMwyw8mb5@vger.kernel.org
X-Gm-Message-State: AFuF++m3y85wFJlIWn26MfWm3/zJMJbwAEirqRFU4vwiEPFx9b98rB3t
	PqQj/ae8BSikkcGuyz17W0oyCeDvx7d3dAqPrfYiIz6IUAgbo9rU8EDbdI66jscgKP8saV5JIJc
	8vGcxZ8J1fn+QaMYkTuuG8iI94fcuio5A4PFUiFmK
X-Gm-Gg: AYBFou3HK4QwJ+WffI70KZWpnlC5zN0LUSVoQtE+8B3x9yYCZ2Vz/iMWVCztnqc5gMT
	Jj92eEQs687xSPSTjJHp4por0K2exlXakXtp254RXluG0J4RJqiNVeoRqP/LSv03TJYp5x14iuf
	DV+JOGC0THaUJQmLV/3/rIqfxjJkWwm46i51dp/v1maxMbQPWXKcKOtv+Z2ybdVgURAja3ZlxSR
	BNyC6c2D2qA8lZUPw/udp6waMGRbCO0/qkpuUNr+9zTw6bNbi91F1qxk7TuQriTuF6IfayW15I5
	0C1t5BtMoaOQ+HGm4JGaH1PmXYULm29TrijMfthBv70FRTkZyx094kXCDYaoC46pYHFHwJn8ief
	KLGtNCLXE/w==
X-Received: by 2002:ac8:5f8d:0:b0:531:a85:69c1 with SMTP id
 d75a77b69052e-5327e6ab465mr306701cf.5.1789505008852; Tue, 15 Sep 2026
 13:43:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726094120.331668-3-thorsten.blum@linux.dev> <6c6e55c5-8275-4cb5-9f86-8770cc7ad19b@linux.intel.com>
In-Reply-To: <6c6e55c5-8275-4cb5-9f86-8770cc7ad19b@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 13:43:16 -0700
X-Gm-Features: AcwNN1XBCbtuwqf-84xx1OeLRosIWZDCrze4C3s6DVvpZPcA6lieFVhLq8K4qJA
Message-ID: <CAP-5=fUdeyTy=H2kJiJ5St3EMz-ooi-F-9iE8z5S_iXRDY+k7w@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] perf/x86/intel/uncore: Use sysfs_emit() in uncore_event_show()
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 10:07=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel=
.com> wrote:
>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> On 7/26/2026 5:41 PM, Thorsten Blum wrote:
> > Replace sprintf() with sysfs_emit() in uncore_event_show(). sysfs_emit(=
)
> > is preferred for formatting sysfs output because it provides safer
> > bounds checking.
> >
> > Add a terminating newline as suggested by checkpatch.
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> > Changes in v2:
> > - Add a terminating newline as suggested by checkpatch
> > - Link to v1: https://lore.kernel.org/r/20260206194254.36105-2-thorsten=
.blum@linux.dev/
> > ---
> >  arch/x86/events/intel/uncore.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/unc=
ore.c
> > index 7857959c6e82..1ef4b4a5f545 100644
> > --- a/arch/x86/events/intel/uncore.c
> > +++ b/arch/x86/events/intel/uncore.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  #include <linux/module.h>
> > +#include <linux/sysfs.h>
> >
> >  #include <asm/cpu_device_id.h>
> >  #include <asm/intel-family.h>
> > @@ -153,7 +154,7 @@ ssize_t uncore_event_show(struct device *dev,
> >  {
> >       struct uncore_event_desc *event =3D
> >               container_of(attr, struct uncore_event_desc, attr);
> > -     return sprintf(buf, "%s", event->config);
> > +     return sysfs_emit(buf, "%s\n", event->config);
> >  }
> >
> >  struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pm=
u, int cpu)
> >
