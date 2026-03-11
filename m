Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06B42C11DB
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211305; cv=pass; b=pSfyEMV781uKjiJxJTwmaTPPkxk++0QBy4SQUYGNYt5Hj5fkwbh6RQgu7z8ZGurUtx+gXbmAEdAOajVB07GpFV2cBm+O8SK4GXZGECP6GX13tqxJO/OdOJcLCWqqSsS1/A+SaMYtpyw5cEdJVvFGX0Pm7j+TOE5pbPKfYcU7w0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211305; c=relaxed/simple;
	bh=NxHEyo0g1dDmpgDKXaskoTeA1UaIzXlRIPMYW2qBes4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZafRH+z5qRrMjhJMdSbgKMS1dzSyyrLnxzNiPji+1+efeouynofRW11MtLE8hNFYqkylBfD55S/ByMQH2xdkOvKLb5jE1PMKJkypo/sFRWtvo91cIJxk6Wt+mq0iooLXddpTpa1W3J7L3rRBKRowsjpRvrBDpPHFQzWwcsd1bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YHfvHB76; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=l0LkUf+T; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YHfvHB76";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="l0LkUf+T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773211302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=msvWJ/5YcGd5ow0LGgYwCiHcPpDwBYbOw/dQui5lXnw=;
	b=YHfvHB76Z4HL4+WZGPgCFRnjvMNZ9xCeh/PnIK5izyTimmAAkWhH9tgHnQTdXPduP2XXl6
	fZP6v+fPX9/T7MaO8Tq/ozzNxszL82vupmsYgvOrOQo7H1Se20ogpBCM1ifAyAWD3+AmBB
	pYJwlREtTep9g8i05nC56RGggXJpTWc=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-XQ0xyQ1eOaiR0LHCymGCZQ-1; Wed, 11 Mar 2026 02:41:41 -0400
X-MC-Unique: XQ0xyQ1eOaiR0LHCymGCZQ-1
X-Mimecast-MFC-AGG-ID: XQ0xyQ1eOaiR0LHCymGCZQ_1773211301
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-67bcaf9a123so5442529eaf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 23:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773211301; cv=none;
        d=google.com; s=arc-20240605;
        b=YPfGfc2rxWCHl/FUau3mZAuOb7AWCkqHbHmLBrtOwxJQOnkJ156wjvQsIuC+wqyoo0
         fXzMWE0qDPfJqGnugolNjwyCjOxt1YrcjDlMGXYknKMI26uCfvxRXXwcUpy/Mxgtrx4W
         VYCdaIwtXOFGcynwly04nhJH7j5a8VvkssyrNmLOZyBhTIgK+76PnprqrWpyi/+72f4E
         n3hZO8Vee4c4ukdx4k+NWSh6cMz+1YJk5s7Vdyi43t1hGHhZ8grOs0UKeN0Hz2XyPc5i
         QyWhIn3XHJzlQafiUa8hp79czOfd7ftZEvIY1Msp9ue6C9hagX/ekxsInSjrUo5UCT/M
         PKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=msvWJ/5YcGd5ow0LGgYwCiHcPpDwBYbOw/dQui5lXnw=;
        fh=u0gC0U7UgB0iwgTs82CuYqIzrbffwnfmdO7Rpi4H7Uw=;
        b=kk1OtVOkRqXX5Xnu1W1qJ/WhtmFEY93UxZPM3lVXjSfKYrpRYnBaJ+23YppPhbFhPH
         oquttDjhrj3TigxaED061OJILpP2D6Df2e9h2yk6431ayg0xFo3/p5V6JKEzsuIybFs5
         fiaaRaXdDE5LgdBE/xVMCoYiOdXXF5+1sZbrij/ZoqCFjhNgJCdNH2X8OzM1SrmxaWcG
         lgb8aJ+hUeaE/tbRpP5bAU8v9AnfkmlFZllHPvWIIHkLuCOIDwX2Xm3uTAgKkYnfQd3K
         W5rTOq7uuORVD8gYTFCFmHogpaCmPIlfycA62daNEErqH9rBnHjLkv2isaKnLruMc88i
         erFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773211301; x=1773816101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msvWJ/5YcGd5ow0LGgYwCiHcPpDwBYbOw/dQui5lXnw=;
        b=l0LkUf+TyHU3dsHOoxKSoVH4j2I1ovjMTrcItb/NU3jFIazUwPShv7+6RqDhNMdTtt
         gbD++mq3RGZ6WzPS5mHhEdNCAVqANHp1BrsVwfzJCyBx3cW2iA6aLCOCdgLgtPlw7WND
         Td5AlZ9o9o6c9R4+RJBGSFXAseQ93osH0+tV9CGCBeC/d97xrzqaAi9JDIr6SEhyIW7Z
         2aXMvjVmg7NY0EYEyB2bNEJHtxd3H5zppyKUchPYKL0K/qSpxJiskmJH7zn961iuf82M
         ouQC3dZIrHOjHptFmlziZ6HgYQbG7gj+8D46wbcYiMC9QYmSXJ+uim7wHRCc1Y5iN9VH
         93JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773211301; x=1773816101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=msvWJ/5YcGd5ow0LGgYwCiHcPpDwBYbOw/dQui5lXnw=;
        b=jI723MYvUrwaT4GWn8VWB1VSr52a6Op8KJTwloZ82hCF5s3wIRU65a6XKXdFOsGPSc
         gPJYPgYuvXToRlc3sn85oRaSNp0JKQ5kGqQ513aaV3pD8cqo8nrUfoP8d/GBkFz2t58C
         KWI8qemdr/mhoCOimIY17OqOoHcBu+QOhhQPeZWUPMmFc1L4FWkQqBW3faRagFJwq5kr
         OeXVDfmeVLRDfN/ypvi9GiRzjQF+2yR5aLk2CdY552h46qTKmHsya81zoAMqJJCE4U2k
         NXp8qqtwMfdkepy4/2hiMzNCvfSDvieMQoTvXPYenGDS4IzxQnc8TuZ4ScyA8Y43I94i
         1kmQ==
X-Gm-Message-State: AOJu0Yw0XFEho/NLekA95z04RkPIqlqnhacU2aqk0lYXdV2d8IRKKwOu
	00BkzUJ+2rgjO7trhIOOnxHcZELziRKYCwvmplR+ooJll69OzulZnKh+CE9X7m+k75pDEPCueq3
	OucKeiPFzR33EKDmdIHyKAhJaVxKzLSLjAjUN2zrLJRpSu3HlhpsCCMLZTWskLqK2d7fGaMxn9/
	SwChdkZi8TeU/HTQPzSoWSfLO9z6wrHQEf++p5/s4MDJD2Qw==
X-Gm-Gg: ATEYQzyYI7c8AJNW3poMH0PIMkEj1G4Nlc9EwWZl0J1ggk1e33EM1L9kowXwhHP+MQ8
	8wE1X+gJyL9Fpk1H5gVl7X08qo1oO15QOGpUeXw4nnczKA12BEjeXw5IFcOC+hY5KFISHLxwGPg
	tb1muVSr5XsRE840FLoJ5GO0hb+0j3NkrctodnaFLQff9P21Q3009dp306QPPrj89ir1zqK1BuH
	JbreHg=
X-Received: by 2002:a05:6820:1995:b0:67b:c4cf:9cc3 with SMTP id 006d021491bc7-67bc8873bc8mr1569532eaf.11.1773211300716;
        Tue, 10 Mar 2026 23:41:40 -0700 (PDT)
X-Received: by 2002:a05:6820:1995:b0:67b:c4cf:9cc3 with SMTP id
 006d021491bc7-67bc8873bc8mr1569516eaf.11.1773211300265; Tue, 10 Mar 2026
 23:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302055557.3708296-1-qzhao@redhat.com> <CAATMXfmK73HSM=DZMBHGcoqu=79ftqhYNNtcpUGF-76Ydp9KMA@mail.gmail.com>
In-Reply-To: <CAATMXfmK73HSM=DZMBHGcoqu=79ftqhYNNtcpUGF-76Ydp9KMA@mail.gmail.com>
From: Qiao Zhao <qzhao@redhat.com>
Date: Wed, 11 Mar 2026 14:41:29 +0800
X-Gm-Features: AaiRm50_2yL04rJOdnCEX5sL26XTgGHQQs8iKJz7lKtKEsFifJE-7iOP5e-F0F4
Message-ID: <CAATMXfnDxRdLJRo9LEiM6iGXooQGUFWrj+2=rd8=KL7GUK9Rbw@mail.gmail.com>
Subject: Re: [PATCH v3] perf tests: mmap-basic: fix user rdpmc detection logic
To: james.clark@linaro.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, leo.yan@linux.dev, namhyung@kernel.org, 
	acme@kernel.org, mpetlan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James, Ian,

Just a gentle ping on this patch.
Could you take a look when convenient?

Thanks,
Qiao

On Thu, Mar 5, 2026 at 11:08=E2=80=AFAM Qiao Zhao <qzhao@redhat.com> wrote:
>
> Hi James, Ian,
>
> Do you mind reviewing this v3 change?  Thanks a lot!
>
> - Qiao
>
> On Mon, Mar 2, 2026 at 1:56=E2=80=AFPM Qiao Zhao <qzhao@redhat.com> wrote=
:
> >
> > The mmap-basic test incorrectly determined rdpmc availability in
> > several environments, leading to unexpected failures on arm64 and
> > other architectures.
> >
> > Previously the rdpmc capability decision lived in test_stat_user_read()=
,
> > which caused inconsistent behaviour when:
> >  - perf_user_access sysctl state is unknown
> >  - architectures expose cap_user_rdpmc differently
> >  - arm64 platforms where rdpmc semantics differ from x86
> >
> > As suggested during review, move the rdpmc capability decision into
> > set_user_read() so that the user_read state and expected behavior
> > are decided in a single place.
> >
> > Changes in v3:
> >  - Moves perf_user_access handling into set_user_read()
> >  - Simplify test_stat_user_read() expectation logic
> >  - Use unified rdpmc_supported calculation
> >  - Handle USER_READ_UNKNOWN consistently
> >
> > v2:
> > https://lore.kernel.org/linux-perf-users/20260203141608.14128-1-qzhao@r=
edhat.com/
> >
> > Note:
> > A potential cleanup around perf_event.h mentioned during review is
> > intentionally deferred and will be handled in a follow-up change
> > to keep this fix minimal and focused.
> >
> > Tested on:
> >  - ARM64 (armv8_pmuv3): all mmap-basic user-space counter tests pass
> >  - X86(include hybrid): all mmap-basic tests pass
> >  - IBM Power9: all mmap-basic tests pass
> >
> > Signed-off-by: Qiao Zhao <qzhao@redhat.com>
> > ---
> >  tools/perf/tests/mmap-basic.c | 55 +++++++++++++++++++++++++----------
> >  1 file changed, 39 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basi=
c.c
> > index 3313c236104e..3633e7c87dc1 100644
> > --- a/tools/perf/tests/mmap-basic.c
> > +++ b/tools/perf/tests/mmap-basic.c
> > @@ -185,38 +185,57 @@ static enum user_read_state set_user_read(struct =
perf_pmu *pmu, enum user_read_s
> >  {
> >         char buf[2] =3D {0, '\n'};
> >         ssize_t len;
> > -       int events_fd, rdpmc_fd;
> > +       int events_fd, fd;
> >         enum user_read_state old_user_read =3D USER_READ_UNKNOWN;
> >
> >         if (enabled =3D=3D USER_READ_UNKNOWN)
> >                 return USER_READ_UNKNOWN;
> >
> > +       // Try the PMU rdpmc sysfs interface or similar
> >         events_fd =3D perf_pmu__event_source_devices_fd();
> > -       if (events_fd < 0)
> > -               return USER_READ_UNKNOWN;
> > -
> > -       rdpmc_fd =3D perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc=
", O_RDWR);
> > -       if (rdpmc_fd < 0) {
> > +       if (events_fd >=3D 0) {
> > +               fd =3D perf_pmu__pathname_fd(events_fd, pmu->name, "rdp=
mc", O_RDWR);
> > +               if (fd >=3D 0) {
> > +                       len =3D read(fd, buf, sizeof(buf));
> > +                       if (len =3D=3D sizeof(buf))
> > +                               old_user_read =3D (buf[0] =3D=3D '1') ?
> > +                                       USER_READ_ENABLED :
> > +                                       USER_READ_DISABLED;
> > +
> > +                       if (enabled !=3D old_user_read) {
> > +                               buf[0] =3D (enabled =3D=3D USER_READ_EN=
ABLED) ? '1' : '0';
> > +                               len =3D write(fd, buf, sizeof(buf));
> > +                               if (len !=3D sizeof(buf))
> > +                                       pr_debug("%s write failed\n", _=
_func__);
> > +                       }
> > +                       close(fd);
> > +                       close(events_fd);
> > +                       return old_user_read;
> > +               }
> >                 close(events_fd);
> > -               return USER_READ_UNKNOWN;
> >         }
> >
> > -       len =3D read(rdpmc_fd, buf, sizeof(buf));
> > -       if (len !=3D sizeof(buf))
> > -               pr_debug("%s read failed\n", __func__);
> > +       // Fallback: perf_user_access interface (arm64, riscv, or simil=
ar)
> > +       fd =3D open("/proc/sys/kernel/perf_user_access", O_RDWR);
> > +       if (fd < 0)
> > +               return USER_READ_UNKNOWN;
> >
> >         // Note, on Intel hybrid disabling on 1 PMU will implicitly dis=
able on
> >         // all the core PMUs.
> > -       old_user_read =3D (buf[0] =3D=3D '1') ? USER_READ_ENABLED : USE=
R_READ_DISABLED;
> > +       len =3D read(fd, buf, sizeof(buf));
> > +       if (len =3D=3D sizeof(buf))
> > +               old_user_read =3D (buf[0] =3D=3D '1') ?
> > +                       USER_READ_ENABLED :
> > +                       USER_READ_DISABLED;
> >
> >         if (enabled !=3D old_user_read) {
> >                 buf[0] =3D (enabled =3D=3D USER_READ_ENABLED) ? '1' : '=
0';
> > -               len =3D write(rdpmc_fd, buf, sizeof(buf));
> > +               len =3D write(fd, buf, sizeof(buf));
> >                 if (len !=3D sizeof(buf))
> >                         pr_debug("%s write failed\n", __func__);
> >         }
> > -       close(rdpmc_fd);
> > -       close(events_fd);
> > +
> > +       close(fd);
> >         return old_user_read;
> >  }
> >
> > @@ -295,12 +314,16 @@ static int test_stat_user_read(u64 event, enum us=
er_read_state enabled)
> >                         goto cleanup;
> >                 }
> >
> > +#if defined(__aarch64__) || defined(__riscv)
> > +               rdpmc_supported =3D pc->cap_user_rdpmc;
> > +#else
> >                 if (saved_user_read_state =3D=3D USER_READ_UNKNOWN)
> > -                       rdpmc_supported =3D pc->cap_user_rdpmc && pc->i=
ndex;
> > +                       rdpmc_supported =3D pc->cap_user_rdpmc;
> >                 else
> >                         rdpmc_supported =3D (enabled =3D=3D USER_READ_E=
NABLED);
> > +#endif
> >
> > -               if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->ind=
ex)) {
> > +               if (rdpmc_supported && !pc->cap_user_rdpmc) {
> >                         pr_err("User space counter reading for PMU %s [=
Failed unexpected supported counter access %d %d]\n",
> >                                 pmu->name, pc->cap_user_rdpmc, pc->inde=
x);
> >                         ret =3D TEST_FAIL;
> > --
> > 2.49.0
> >

