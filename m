Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14773F7A94
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926644; cv=none; b=BVfvz8mFuMeglQDZuzUcV//3URBxZYb6DF0EPoA5VekFqWUVeRyQ87HqJdLWeG+sDXJLnqBqlG2K7d7uwfgUCt06GommxpI0+VaSVyxhl5HseS89L4CeG/PJ1LiE1LqPqElKRce4TqTK8YMnrjnVfsBxcrY77H1wlLnyyl/f+eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926644; c=relaxed/simple;
	bh=kxROKPG/rbAzWU6TPUVSx+oJmuNV3M41eJL/lbIb5q4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KPOgyVXpnb87Te9uSP37TfBaC0QVpvfmOxo13vhBBVJUhpilGXRQDIPDl51AJGsi3+A0Le9wQDDBfrMGWI9sBXjYgmKpuYLvz4nFNq3ssZy1YdqWsjq+MbEcJyaxlstTxPzTWbbjDYodEz/mFTnVls/oDa2POJkhg7YS0Fn+5Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R1PQIUQm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1PQIUQm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785926641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M3NMRwj+bv04AD/DEC2xE+Q9d9tOIG4BeOEkx053FvA=;
	b=R1PQIUQmIjVI0j+k9a1OkQSY52cgKN+utdrP+JIEFoti5C8NhYnrNBHPEknn+HjaRY6XU3
	fSaYR5dLAwgtDBdvYMKuOtAHtoblGiXZ0976CwuWlWrn/OaI2GktDlfkcVzcsbVaIuSt0Z
	QZLFAfYejXfPPcrQtbPjWd09yM4MBSQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-pf7ymubxMKiRiIeVUt4ldA-1; Wed,
 05 Aug 2026 06:43:56 -0400
X-MC-Unique: pf7ymubxMKiRiIeVUt4ldA-1
X-Mimecast-MFC-AGG-ID: pf7ymubxMKiRiIeVUt4ldA_1785926635
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19CEB1800642;
	Wed,  5 Aug 2026 10:43:55 +0000 (UTC)
Received: from Carbon (unknown [10.44.24.16])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E710718005A7;
	Wed,  5 Aug 2026 10:43:52 +0000 (UTC)
Date: Wed, 5 Aug 2026 12:43:49 +0200 (CEST)
From: Michael Petlan <mpetlan@redhat.com>
To: james.clark@linaro.org
cc: irogers@google.com, linux-perf-users@vger.kernel.org, leo.yan@linux.dev, 
    namhyung@kernel.org, acme@kernel.org
Subject: Re: [PATCH v3] perf tests: mmap-basic: fix user rdpmc detection
 logic
In-Reply-To: <CAATMXfnDxRdLJRo9LEiM6iGXooQGUFWrj+2=rd8=KL7GUK9Rbw@mail.gmail.com>
Message-ID: <4181fd3b-1e22-4884-c349-63c5abfb814d@redhat.com>
References: <20260302055557.3708296-1-qzhao@redhat.com> <CAATMXfmK73HSM=DZMBHGcoqu=79ftqhYNNtcpUGF-76Ydp9KMA@mail.gmail.com> <CAATMXfnDxRdLJRo9LEiM6iGXooQGUFWrj+2=rd8=KL7GUK9Rbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="659969-1385548246-1785926634=:4835"
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--659969-1385548246-1785926634=:4835
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi James and Ian,

what do you think about the v3? Can we get it merged? Thanks.

Regards,
Michael

On Wed, 11 Mar 2026, Qiao Zhao wrote:
> Hi James, Ian,
> 
> Just a gentle ping on this patch.
> Could you take a look when convenient?
> 
> Thanks,
> Qiao
> 
> On Thu, Mar 5, 2026 at 11:08 AM Qiao Zhao <qzhao@redhat.com> wrote:
> >
> > Hi James, Ian,
> >
> > Do you mind reviewing this v3 change?  Thanks a lot!
> >
> > - Qiao
> >
> > On Mon, Mar 2, 2026 at 1:56 PM Qiao Zhao <qzhao@redhat.com> wrote:
> > >
> > > The mmap-basic test incorrectly determined rdpmc availability in
> > > several environments, leading to unexpected failures on arm64 and
> > > other architectures.
> > >
> > > Previously the rdpmc capability decision lived in test_stat_user_read(),
> > > which caused inconsistent behaviour when:
> > >  - perf_user_access sysctl state is unknown
> > >  - architectures expose cap_user_rdpmc differently
> > >  - arm64 platforms where rdpmc semantics differ from x86
> > >
> > > As suggested during review, move the rdpmc capability decision into
> > > set_user_read() so that the user_read state and expected behavior
> > > are decided in a single place.
> > >
> > > Changes in v3:
> > >  - Moves perf_user_access handling into set_user_read()
> > >  - Simplify test_stat_user_read() expectation logic
> > >  - Use unified rdpmc_supported calculation
> > >  - Handle USER_READ_UNKNOWN consistently
> > >
> > > v2:
> > > https://lore.kernel.org/linux-perf-users/20260203141608.14128-1-qzhao@redhat.com/
> > >
> > > Note:
> > > A potential cleanup around perf_event.h mentioned during review is
> > > intentionally deferred and will be handled in a follow-up change
> > > to keep this fix minimal and focused.
> > >
> > > Tested on:
> > >  - ARM64 (armv8_pmuv3): all mmap-basic user-space counter tests pass
> > >  - X86(include hybrid): all mmap-basic tests pass
> > >  - IBM Power9: all mmap-basic tests pass
> > >
> > > Signed-off-by: Qiao Zhao <qzhao@redhat.com>
> > > ---
> > >  tools/perf/tests/mmap-basic.c | 55 +++++++++++++++++++++++++----------
> > >  1 file changed, 39 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
> > > index 3313c236104e..3633e7c87dc1 100644
> > > --- a/tools/perf/tests/mmap-basic.c
> > > +++ b/tools/perf/tests/mmap-basic.c
> > > @@ -185,38 +185,57 @@ static enum user_read_state set_user_read(struct perf_pmu *pmu, enum user_read_s
> > >  {
> > >         char buf[2] = {0, '\n'};
> > >         ssize_t len;
> > > -       int events_fd, rdpmc_fd;
> > > +       int events_fd, fd;
> > >         enum user_read_state old_user_read = USER_READ_UNKNOWN;
> > >
> > >         if (enabled == USER_READ_UNKNOWN)
> > >                 return USER_READ_UNKNOWN;
> > >
> > > +       // Try the PMU rdpmc sysfs interface or similar
> > >         events_fd = perf_pmu__event_source_devices_fd();
> > > -       if (events_fd < 0)
> > > -               return USER_READ_UNKNOWN;
> > > -
> > > -       rdpmc_fd = perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc", O_RDWR);
> > > -       if (rdpmc_fd < 0) {
> > > +       if (events_fd >= 0) {
> > > +               fd = perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc", O_RDWR);
> > > +               if (fd >= 0) {
> > > +                       len = read(fd, buf, sizeof(buf));
> > > +                       if (len == sizeof(buf))
> > > +                               old_user_read = (buf[0] == '1') ?
> > > +                                       USER_READ_ENABLED :
> > > +                                       USER_READ_DISABLED;
> > > +
> > > +                       if (enabled != old_user_read) {
> > > +                               buf[0] = (enabled == USER_READ_ENABLED) ? '1' : '0';
> > > +                               len = write(fd, buf, sizeof(buf));
> > > +                               if (len != sizeof(buf))
> > > +                                       pr_debug("%s write failed\n", __func__);
> > > +                       }
> > > +                       close(fd);
> > > +                       close(events_fd);
> > > +                       return old_user_read;
> > > +               }
> > >                 close(events_fd);
> > > -               return USER_READ_UNKNOWN;
> > >         }
> > >
> > > -       len = read(rdpmc_fd, buf, sizeof(buf));
> > > -       if (len != sizeof(buf))
> > > -               pr_debug("%s read failed\n", __func__);
> > > +       // Fallback: perf_user_access interface (arm64, riscv, or similar)
> > > +       fd = open("/proc/sys/kernel/perf_user_access", O_RDWR);
> > > +       if (fd < 0)
> > > +               return USER_READ_UNKNOWN;
> > >
> > >         // Note, on Intel hybrid disabling on 1 PMU will implicitly disable on
> > >         // all the core PMUs.
> > > -       old_user_read = (buf[0] == '1') ? USER_READ_ENABLED : USER_READ_DISABLED;
> > > +       len = read(fd, buf, sizeof(buf));
> > > +       if (len == sizeof(buf))
> > > +               old_user_read = (buf[0] == '1') ?
> > > +                       USER_READ_ENABLED :
> > > +                       USER_READ_DISABLED;
> > >
> > >         if (enabled != old_user_read) {
> > >                 buf[0] = (enabled == USER_READ_ENABLED) ? '1' : '0';
> > > -               len = write(rdpmc_fd, buf, sizeof(buf));
> > > +               len = write(fd, buf, sizeof(buf));
> > >                 if (len != sizeof(buf))
> > >                         pr_debug("%s write failed\n", __func__);
> > >         }
> > > -       close(rdpmc_fd);
> > > -       close(events_fd);
> > > +
> > > +       close(fd);
> > >         return old_user_read;
> > >  }
> > >
> > > @@ -295,12 +314,16 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
> > >                         goto cleanup;
> > >                 }
> > >
> > > +#if defined(__aarch64__) || defined(__riscv)
> > > +               rdpmc_supported = pc->cap_user_rdpmc;
> > > +#else
> > >                 if (saved_user_read_state == USER_READ_UNKNOWN)
> > > -                       rdpmc_supported = pc->cap_user_rdpmc && pc->index;
> > > +                       rdpmc_supported = pc->cap_user_rdpmc;
> > >                 else
> > >                         rdpmc_supported = (enabled == USER_READ_ENABLED);
> > > +#endif
> > >
> > > -               if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->index)) {
> > > +               if (rdpmc_supported && !pc->cap_user_rdpmc) {
> > >                         pr_err("User space counter reading for PMU %s [Failed unexpected supported counter access %d %d]\n",
> > >                                 pmu->name, pc->cap_user_rdpmc, pc->index);
> > >                         ret = TEST_FAIL;
> > > --
> > > 2.49.0
> > >
> 
> 
--659969-1385548246-1785926634=:4835--

