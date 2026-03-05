Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C55118DB26
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Mar 2026 03:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772680115; cv=pass; b=RaXD+pZBy1dSs5q9xa1C34HUb9+YV1zqarlbBGoJfzLPbeVo3FZLZwkcM8SM1yRo/Ux+uxcwTb9UiP3DtdyIqj4xucwkZThqHmKMvEPmMWogou4w+ooLr+1PlsqD0YoH56DDzimTw7XgA0yFjyKPIW10qg9yNuvjlgx9calWToA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772680115; c=relaxed/simple;
	bh=UT+Be3oySum0x0C0iXf+bIItiviCfr+6unrTcD/t2nY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jb7es34ZKHTUTAQDANkWounkpE6UrkxcScwn8Mp7qSZePNCd4kVsbtRaqMME934TBQ0RxvdpyPHBhsIGNbmkCBj+yzmLy8CndZQAW+LrdvyenkPGBn+DgE2S2H22PB/YZo2SLlXLnepEbh0dB3nkhaKofKbOPRuEIpY80LzKGOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KXgL2DhE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pmnXZuru; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KXgL2DhE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pmnXZuru"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772680113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Z5xudHkdQaeU84FS1WoVn989Dx8iL86gbrUsdTzumk=;
	b=KXgL2DhEB8bglX5QkbWubLhOtvPJIrvSkIiyCoLprQcAjI4ftvHQsnv1iHVsRr7zA5FXLk
	EVTAy3sNtrwUdoyo2Axwvj7j2Sr15GJL8eO1S0Trl41g3bp+g+05/c/6796Ol3AXddAuIg
	5mxi0neMfqGSZBHJx1Dm6C3x+RG2wiI=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-2zk5yTxGNgSxASMkAs9eOw-1; Wed, 04 Mar 2026 22:08:32 -0500
X-MC-Unique: 2zk5yTxGNgSxASMkAs9eOw-1
X-Mimecast-MFC-AGG-ID: 2zk5yTxGNgSxASMkAs9eOw_1772680111
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679dda090fbso134329261eaf.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Mar 2026 19:08:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772680111; cv=none;
        d=google.com; s=arc-20240605;
        b=Hi/DGz5DSN7UNM13yd5ur1inwxFlNHsR7xyV5TA32L4EFrJS1fK0EcUCPr1UMeIVAF
         Yu2FrxpJjzdUelJcQNkxtNcmEk9fHbvACgHpdIDo9Kxm5pLadoEV0BFngkv4qww5lmOJ
         rRZVgjURFIAsYtqb9mX/pGiWmN0xBmjqbQKAlJar4wMgbc9CZaVAuFzm1Oy6hijqq9V6
         /K4Cxgdc8pr7r8+TzXID8GIJRoFGKLxyDNvDDeb2UsCqi4QBDb2avr27v+W3YpoiXQDP
         T3cnlF2+4159Zw3ZcrN2Ku1zkB55ADfcp6e4BNgR3B45+FXbnl5nhwhwcgvIYvT9JTEM
         l+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8Z5xudHkdQaeU84FS1WoVn989Dx8iL86gbrUsdTzumk=;
        fh=u0gC0U7UgB0iwgTs82CuYqIzrbffwnfmdO7Rpi4H7Uw=;
        b=kDUt6B8MDbEVzwKoxlkOQXv4Bpuhl6gDtsePLrV7bjFpaFEG49oLtCvL5gF5Ahb6ax
         tHMBUGhlKjsn0/tzmaSzGMzRSNW24snY3NbH0gaqU33AxblPyCl65g+g8k3Ss/5iPEXk
         L8ivYlNLjInACQZqCCu8zVg9kJ9yncRUxPMawDMDabdbmBEGwD8qEFkB8He9bFe8+6cW
         kdOp4a60MNH8h8M082XOJ2zah4RNNVkf60AZuMeVyqP2luDFeGzsw1vSf5rlT64KCVZv
         pDU8HpGrLOLxOkwcGVzr5hNHvPjJMOI8BaSUo4VpodLfwI0v1UHnCO15R8emjIFBdHQl
         tq5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772680111; x=1773284911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z5xudHkdQaeU84FS1WoVn989Dx8iL86gbrUsdTzumk=;
        b=pmnXZuruJQSuXU/HvvBArnATpa8Mgz7bYErbcQGYZhukgOAzhxDMLcFyTEz/kLI/7r
         60DFGsYguTaCof3ciBmh7V+i6VpJP7KLNIWL4GfgSkFf/AjtAk0ORkuAnAkWjnxbzdP9
         v3045rVkdeXqls/cuPgLPC+Eypn1ZtZJjDBTuzY/qDAvVdEsJyX+LQoG9YiMCpuGiAnH
         1nmBQlpPD5pAmQkrNegooLiBD6CRLgoV/L9SQgbUzntKDb3EzjjfIQFEm24wG355a/HT
         qbK4Upppu051cLwnwZ4gjpi9g38jQkCr6h3We3JM3ZKQwhWkAqINZkQAwHAK/mxxdl3E
         fqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772680111; x=1773284911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Z5xudHkdQaeU84FS1WoVn989Dx8iL86gbrUsdTzumk=;
        b=jR2hFv8llLT6hrsHc1xfA9/1CSnaDaDTzUNWwLEW6kfvlID5S7mIqKKQVBSoUKdbEC
         qagvHE5NQu3poPKtouZXBvcGZqltJQnuAb9r2b3q5sB5tVG2SXI76U5nQZ3DvnF8RsIh
         /5aPjur/vKwUhVjoZrlrRUywhUt2I9N5W61g/UbIcl+FZX7dlihhf2B6DALS18bSUHpZ
         a9hO2vgX2TNfq+ER6maOhQU2v/nNjxUL4i3w0V/IfOv8HCK8pefCZqPXddSOr+8vOgyD
         1SGkrGFm3ENGnKpqa9tSn1Lcd71JvZfNprTTWwXAG7Sq8DHqehsTY2SLoYqfocgOdmGu
         Q71Q==
X-Gm-Message-State: AOJu0Yww6Y5rSobC72qzyz1rAPZCcR+ByrvQjzBeifJKk1kvJ3+Go92v
	huIwiemuSH8wLdzoLqJT2Hdn39y7+7cOBTiw3+/2QSKOJ2J0LYV+ubgSzlFLCTkca9uDqYil1/d
	O6QIXbQoXtFTyrTzdgtvnZfkSKcHSrADvoMAEMSu8NMPsZcSovHVHkMC+EGHZLupDOLTJGAuTxp
	bNU4fqf0KXQHqMTctD8cOX44dfOXT5Auhz+l68E7oKgBnA6A==
X-Gm-Gg: ATEYQzw5MtBm/vwCHmQJ8kmv/LGdn4SOsdt5L9zj8XvXZ/eSyr9LPM5PKzCew47/xh6
	gVH7JoBUs3KzISqyvyvURxsEiVqJZiWNXMwVYMpBwdn8KYMIPe5M/E+teUgt5qMLo3uXqw9ZosJ
	IzzeXA3IgEqVePpsjNzVxjwZ1/7g3Q7FuJVaUeM0jvBMbtY0YPDNlNG3jDHpS5GLi6m2R0pkpF+
	hCBa6A=
X-Received: by 2002:a4a:e912:0:b0:67a:1d88:46da with SMTP id 006d021491bc7-67b1e915d2cmr3014628eaf.66.1772680111186;
        Wed, 04 Mar 2026 19:08:31 -0800 (PST)
X-Received: by 2002:a4a:e912:0:b0:67a:1d88:46da with SMTP id
 006d021491bc7-67b1e915d2cmr3014608eaf.66.1772680110715; Wed, 04 Mar 2026
 19:08:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302055557.3708296-1-qzhao@redhat.com>
In-Reply-To: <20260302055557.3708296-1-qzhao@redhat.com>
From: Qiao Zhao <qzhao@redhat.com>
Date: Thu, 5 Mar 2026 11:08:19 +0800
X-Gm-Features: AaiRm51NdS6GCTQyafEreWk9pIU6ZWhyy-a_-1zNKjuGd-2WQs6rnzvD1yUQUFY
Message-ID: <CAATMXfmK73HSM=DZMBHGcoqu=79ftqhYNNtcpUGF-76Ydp9KMA@mail.gmail.com>
Subject: Re: [PATCH v3] perf tests: mmap-basic: fix user rdpmc detection logic
To: james.clark@linaro.org, irogers@google.com
Cc: linux-perf-users@vger.kernel.org, leo.yan@linux.dev, namhyung@kernel.org, 
	acme@kernel.org, mpetlan@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James, Ian,

Do you mind reviewing this v3 change?  Thanks a lot!

- Qiao

On Mon, Mar 2, 2026 at 1:56=E2=80=AFPM Qiao Zhao <qzhao@redhat.com> wrote:
>
> The mmap-basic test incorrectly determined rdpmc availability in
> several environments, leading to unexpected failures on arm64 and
> other architectures.
>
> Previously the rdpmc capability decision lived in test_stat_user_read(),
> which caused inconsistent behaviour when:
>  - perf_user_access sysctl state is unknown
>  - architectures expose cap_user_rdpmc differently
>  - arm64 platforms where rdpmc semantics differ from x86
>
> As suggested during review, move the rdpmc capability decision into
> set_user_read() so that the user_read state and expected behavior
> are decided in a single place.
>
> Changes in v3:
>  - Moves perf_user_access handling into set_user_read()
>  - Simplify test_stat_user_read() expectation logic
>  - Use unified rdpmc_supported calculation
>  - Handle USER_READ_UNKNOWN consistently
>
> v2:
> https://lore.kernel.org/linux-perf-users/20260203141608.14128-1-qzhao@red=
hat.com/
>
> Note:
> A potential cleanup around perf_event.h mentioned during review is
> intentionally deferred and will be handled in a follow-up change
> to keep this fix minimal and focused.
>
> Tested on:
>  - ARM64 (armv8_pmuv3): all mmap-basic user-space counter tests pass
>  - X86(include hybrid): all mmap-basic tests pass
>  - IBM Power9: all mmap-basic tests pass
>
> Signed-off-by: Qiao Zhao <qzhao@redhat.com>
> ---
>  tools/perf/tests/mmap-basic.c | 55 +++++++++++++++++++++++++----------
>  1 file changed, 39 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.=
c
> index 3313c236104e..3633e7c87dc1 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -185,38 +185,57 @@ static enum user_read_state set_user_read(struct pe=
rf_pmu *pmu, enum user_read_s
>  {
>         char buf[2] =3D {0, '\n'};
>         ssize_t len;
> -       int events_fd, rdpmc_fd;
> +       int events_fd, fd;
>         enum user_read_state old_user_read =3D USER_READ_UNKNOWN;
>
>         if (enabled =3D=3D USER_READ_UNKNOWN)
>                 return USER_READ_UNKNOWN;
>
> +       // Try the PMU rdpmc sysfs interface or similar
>         events_fd =3D perf_pmu__event_source_devices_fd();
> -       if (events_fd < 0)
> -               return USER_READ_UNKNOWN;
> -
> -       rdpmc_fd =3D perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc",=
 O_RDWR);
> -       if (rdpmc_fd < 0) {
> +       if (events_fd >=3D 0) {
> +               fd =3D perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc=
", O_RDWR);
> +               if (fd >=3D 0) {
> +                       len =3D read(fd, buf, sizeof(buf));
> +                       if (len =3D=3D sizeof(buf))
> +                               old_user_read =3D (buf[0] =3D=3D '1') ?
> +                                       USER_READ_ENABLED :
> +                                       USER_READ_DISABLED;
> +
> +                       if (enabled !=3D old_user_read) {
> +                               buf[0] =3D (enabled =3D=3D USER_READ_ENAB=
LED) ? '1' : '0';
> +                               len =3D write(fd, buf, sizeof(buf));
> +                               if (len !=3D sizeof(buf))
> +                                       pr_debug("%s write failed\n", __f=
unc__);
> +                       }
> +                       close(fd);
> +                       close(events_fd);
> +                       return old_user_read;
> +               }
>                 close(events_fd);
> -               return USER_READ_UNKNOWN;
>         }
>
> -       len =3D read(rdpmc_fd, buf, sizeof(buf));
> -       if (len !=3D sizeof(buf))
> -               pr_debug("%s read failed\n", __func__);
> +       // Fallback: perf_user_access interface (arm64, riscv, or similar=
)
> +       fd =3D open("/proc/sys/kernel/perf_user_access", O_RDWR);
> +       if (fd < 0)
> +               return USER_READ_UNKNOWN;
>
>         // Note, on Intel hybrid disabling on 1 PMU will implicitly disab=
le on
>         // all the core PMUs.
> -       old_user_read =3D (buf[0] =3D=3D '1') ? USER_READ_ENABLED : USER_=
READ_DISABLED;
> +       len =3D read(fd, buf, sizeof(buf));
> +       if (len =3D=3D sizeof(buf))
> +               old_user_read =3D (buf[0] =3D=3D '1') ?
> +                       USER_READ_ENABLED :
> +                       USER_READ_DISABLED;
>
>         if (enabled !=3D old_user_read) {
>                 buf[0] =3D (enabled =3D=3D USER_READ_ENABLED) ? '1' : '0'=
;
> -               len =3D write(rdpmc_fd, buf, sizeof(buf));
> +               len =3D write(fd, buf, sizeof(buf));
>                 if (len !=3D sizeof(buf))
>                         pr_debug("%s write failed\n", __func__);
>         }
> -       close(rdpmc_fd);
> -       close(events_fd);
> +
> +       close(fd);
>         return old_user_read;
>  }
>
> @@ -295,12 +314,16 @@ static int test_stat_user_read(u64 event, enum user=
_read_state enabled)
>                         goto cleanup;
>                 }
>
> +#if defined(__aarch64__) || defined(__riscv)
> +               rdpmc_supported =3D pc->cap_user_rdpmc;
> +#else
>                 if (saved_user_read_state =3D=3D USER_READ_UNKNOWN)
> -                       rdpmc_supported =3D pc->cap_user_rdpmc && pc->ind=
ex;
> +                       rdpmc_supported =3D pc->cap_user_rdpmc;
>                 else
>                         rdpmc_supported =3D (enabled =3D=3D USER_READ_ENA=
BLED);
> +#endif
>
> -               if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->index=
)) {
> +               if (rdpmc_supported && !pc->cap_user_rdpmc) {
>                         pr_err("User space counter reading for PMU %s [Fa=
iled unexpected supported counter access %d %d]\n",
>                                 pmu->name, pc->cap_user_rdpmc, pc->index)=
;
>                         ret =3D TEST_FAIL;
> --
> 2.49.0
>

