Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F58033F38C
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 03:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769137936; cv=pass; b=Z9hUD6j23/j9RoO3pltqtq3A70v8o1fg9VARtplHBTwHzovS1uDYMsQsy3DtRl8hhBk7AkRm4zvexOqu/dat+ldKORDJwEK+LIlMZlJ6hloMh2Ky/PxvGaEp9lwQwgIFO0N5fOcTfDXexW/gClnV+KunS45UgPK7vqlrSgFGD4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769137936; c=relaxed/simple;
	bh=Ntqz9xAOmLjIN+fEN9mJF902eqxMMuFRfOeaD9nUsak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGZgyjgNEF5bZb+mKTfFdvroE2NPCCg4CTXXYDk7mzR76twMUSHH8w+gSga+1Hg6JDe7iY4i940ysE9T3YYmsh4Homz8w1/NiCvEj2/xEDO5E25IdlEO1PMUgzrb3ngyX/r4MhNk3h/FKZN5zacOK1Tk58hGpR+cGTAGJrCMiHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y4sU14+9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ehbkxPqW; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y4sU14+9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ehbkxPqW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769137916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ykeExz3XUavdLy+TxiQTMUDx5ZF1wmyVw5357NGEROI=;
	b=Y4sU14+99mlsdWe+X351NUq+FWe10uBsoOVxKkgy4EVNV3GsHxDeV3OBGh70eB5Uv2ZkM3
	d5hiYyTu/0juUUw2CPBmBlZkKTIcdONsvhQE6bPugkb7hVIQQJrqf7amuXgCBvfm3nT6cD
	ZgdL45M6pRjjw7IEaio5nnfjMMNatrM=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-k3FBhE_cN_-o6v9pMckNsw-1; Thu, 22 Jan 2026 22:11:55 -0500
X-MC-Unique: k3FBhE_cN_-o6v9pMckNsw-1
X-Mimecast-MFC-AGG-ID: k3FBhE_cN_-o6v9pMckNsw_1769137914
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-662c0f7c3c0so5247095eaf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 19:11:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769137914; cv=none;
        d=google.com; s=arc-20240605;
        b=budcHUsKvuoXJ8vqyE6vjBt28au2FTemD5kZEQW2Tgc0vX+HJQWJQ+WqcpO+y5CVna
         kRzDwF4dPoEHr/SCQzEwjYsDWKvhB2r8YBMaAKwVfT7tnYVxbxjQKSCTJ0cLEqknzLI0
         BspBRPA8sZFXTBswTPRNDsIjXd6JHDdAaVR1TTLRb02oxU082LTOjdLYYfhfPG1ra35l
         L6zDyKjQ9sNBQwnvCOgX/l5jErgh2jVAJEmzS+6EduB89XXPI714hoJHmVRd4JitBZz5
         n/Z2ZwyX0StGvPus/wdjj/sPkmmN5917iL8oukHT8P3m/jpiMveHDVU+klCldf5CMr74
         uLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ykeExz3XUavdLy+TxiQTMUDx5ZF1wmyVw5357NGEROI=;
        fh=9BfFuG2F5qK7LLoDxnNmEgXCGMDhITKXlYkLV/iqj1I=;
        b=Affw/sd0W0c7y69ia82PdgFBb2wxhOrnDlRHrm5fdd3wKZkqMW3Ii3hp7Zk86KSsKF
         mEhIt61XvYc7G6e2yfxiu5+I7+qX45ShQkXxEQ0sdtSSY4CpUyIsQ7cTeF99qZL/aObI
         PL5q3/f/O3GrrmSATFDtzrF/uhHFFYyqbaxGIfFvZMLonra8heKUc7vNJr2ve9peGTj5
         ZF51Hw9kHZP4+O+Fr2BWZlMWTLrysjUgg+H0PKDdJeJxV96z8crwF6Jj/F86EaFLTY80
         mkYBl1Lm/OGVGahK/PRt6gc+bKEEXsphAVcYRhTUIZDs1J4phDmSCrqEMMyHLaAyXHcX
         aYVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769137914; x=1769742714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykeExz3XUavdLy+TxiQTMUDx5ZF1wmyVw5357NGEROI=;
        b=ehbkxPqWFZwsrKQbodAe+gWnO1gY2b932A18+aKlgsrM6fd8T5BwTlVAWVEf2Fa2l9
         NIN1TrL8QJZCVBmwD/r3ICg4MaTNtZ3VBdoYuzJONqDmH8efs1wEII4K/BTQ277aiLqh
         nxWOL9zjJqOL4tazw05lMzcXXl/MKO77HLoPFMmjuSiaaeUFPt2OgOQq2jxTzHe9y7bq
         THS1Ot3ToyfyxeIEFxNnsrtVkdaQa9d2+lqCJk4g+dC9f+9hqKGu0s/x9weVIWkvvrGv
         VV8XlhBdOaVA/uKhk4reqFBdjnahr1T1sChxZKZ1BC9AKKka8SqRZ3qZTvpnGX/j3F3o
         Hjqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769137914; x=1769742714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ykeExz3XUavdLy+TxiQTMUDx5ZF1wmyVw5357NGEROI=;
        b=n105vaMSjMIPASm6AkUv6MuvEPOnOBIiWqthqaaKOarNRn13vgQpnJwjv3R1V9v8cS
         2yloAoJXFu4B1wT2cFgSPDpvwlhpayr2yDsaA5gP0SfFQoFNGY+sLyoaNX+SM/XdZjFn
         hD4XrDZYbAxkZeGfIOCJnzibcErtmQVXOBOyoX5HWtZ8HoGMatql1sLDFpAJRuOhcZY5
         IeFV1sEbc0gQUCjb5LUIfYfqf4I47YnWM5LsJX7LGDnz92ac+hD78Cyl3HoisKIumMcQ
         SU1o6w1T76mbfc5QXj3AxpAo+d5yaXAeXTzo9h/BNgXW/r7dSaAd09WFjdULe1EEXCS/
         yuHQ==
X-Forwarded-Encrypted: i=1; AJvYcCULnqW/7KnJzxEQ2Fc1RHONn26YI7ZklZMAQrttLxFnuPW4MJsHVveT0pVo9MVwwj/2Vj4At8i0x4VCZxG/YKyO@vger.kernel.org
X-Gm-Message-State: AOJu0YzyIamme8T5qZktmU4OWlI3oJN6NzfAkTLCySyiYjvMFMuW1O4z
	DP5iZYueabdkifvRZn/GuM9PVZLRq7l+2Fau6XrNbOKJDUZTmuB89cd/uurScCREos0FWF6xSV/
	Jjh/rcGa748Lm5tXGiX+WApF8UDWPdVU5LXQASJlbJNCqEu7xwNyj0/Ap6AyvyMIFDLH/p7RiNh
	OJg7+xHfOXIE9G/czEJDJuVU1LFONTcL7L+I4fcgjb74AlHg==
X-Gm-Gg: AZuq6aKqW0dIkive1TMEK8CLQyk6iRX2zPSouLXuMgXXkBLyyFgA/UTq6US3z+/oKa6
	16nDglHVa0OqLhLgPs1u+8ZIQe2yXeZlCJy1GsfJ0MfZpYW9OVPdIfuECVQwPT9ZxHrrQ9LUP9w
	TmOd0aDk4Cb03y8Huh2K/L29OtBTPc7SiiDX/ASW/Op8sNtzebbWNrpbQrQkzdEnl5+5g=
X-Received: by 2002:a05:6820:221d:b0:65b:f0da:31c0 with SMTP id 006d021491bc7-662cab5ede3mr939458eaf.55.1769137914187;
        Thu, 22 Jan 2026 19:11:54 -0800 (PST)
X-Received: by 2002:a05:6820:221d:b0:65b:f0da:31c0 with SMTP id
 006d021491bc7-662cab5ede3mr939451eaf.55.1769137913840; Thu, 22 Jan 2026
 19:11:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120090522.1193981-1-qzhao@redhat.com>
In-Reply-To: <20260120090522.1193981-1-qzhao@redhat.com>
From: Qiao Zhao <qzhao@redhat.com>
Date: Fri, 23 Jan 2026 11:11:42 +0800
X-Gm-Features: AZwV_Qi6tSSt0-HVFRrRDIpj-GfvmoGgIyTFLValKcfrC3YZD6xUSRRpr9Ior0E
Message-ID: <CAATMXfkYH8w7sLpDSHTf1JRGdQiK5Ey8pX6u=5t+Nsi091SXgA@mail.gmail.com>
Subject: Re: [PATCH] perf tests: mmap: skip user counter tests when runtime
 PMU access is unavailable
To: namhyung@kernel.org, irogers@google.com
Cc: mpetlan@redhat.com, acme@kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kim, Ian,

Do you mind reviewing this change?

On Tue, Jan 20, 2026 at 5:05=E2=80=AFPM Qiao Zhao <qzhao@redhat.com> wrote:
>
> On some platforms (e.g. ARM systems with restricted PMU access), user spa=
ce
> PMU counters may be reported as supported but blocked at runtime. Failing
> the mmap interface tests in this case is incorrect.
>
> [Test Log]
> 124.2: User space counter reading of instructions                    : FA=
ILED!
> --- start ---
> User space counter reading 0
> User space counter reading for PMU armv8_pmuv3_0
> User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected unsup=
ported counter access 1]
> ---- end ----
> 124.3: User space counter reading of cycles                          : FA=
ILED!
> --- start ---
> User space counter reading 1
> User space counter reading for PMU armv8_pmuv3_0
> User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected unsup=
ported counter access 1]
> ---- end ----
> [/Test Log]
>
> Skip the user counter mmap tests when runtime PMU access is not available=
,
> while preserving failure for genuinely inconsistent states.
>
> Signed-off-by: Qiao Zhao <qzhao@redhat.com>
> ---
>  tools/perf/tests/mmap-basic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.=
c
> index 3313c236104e..4881a641749b 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -308,9 +308,9 @@ static int test_stat_user_read(u64 event, enum user_r=
ead_state enabled)
>                 }
>
>                 if (!rdpmc_supported && pc->cap_user_rdpmc) {
> -                       pr_err("User space counter reading for PMU %s [Fa=
iled unexpected unsupported counter access %d]\n",
> +                       pr_debug("User space counter reading for PMU %s i=
s not supported (cap_user_rdpmc=3D%d), skipping!\n",
>                                 pmu->name, pc->cap_user_rdpmc);
> -                       ret =3D TEST_FAIL;
> +                       ret =3D TEST_SKIP;
>                         goto cleanup;
>                 }
>
> --
> 2.49.0
>

