Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792694562;
	b=ICV+64pl+uD3fWZCdkb3DyfusWLEpZX74j97FChsyZW482joFhcqRqNOiXgCWYkByuwv
	 vgmMZdqZm0duOmjgURh801BgPqix/7K01CrNt1SwHi1oHcYoGBSG12SbfIgYOZ11n4wrZ
	 Xyl/Z08Wr4BM5aqmfaKdIEUS/i6Vp7XoizNOHrkuxX/QWpih+dpDghkm9ymJUz85V5smP
	 f6S/RaQOGvu82NCCacGv5yi73owDfnQnSVc6SUOzRf/0IRYbJQVE7pFmUWKTOeQyMDFmi
	 VxIdJSG6CU+eugZbxNPhlVC4f4coPLIbFh0WOq0KWuYeRIqDeYcmFyOqHteUR3nG0RQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IZ/uBrhQVS3DiMAnoAWQ1amBgCkO8xqm7sNIOjhR87M=;
	b=zVon4DhRBL8gp2YEX53FYu5GImtLKUP0a76m0jF3xegCtESFpU20TzwJh6SE2MkIZfgq
	 D+QWwHOv3VPn1RtRif4bvTLiYlDg0X8lMMc8o6rTIk38wT8+xSPXoQcVtOlcLCW4QQAkl
	 gF/0TU7safEcUI7q1KSczPNbgUa2txr1zM5sWmwakTnycqW5KT8TRjQd09tccBLmWgXrV
	 yoUDCgD8R3kScXAOkGwLXBYZ5zSszW5AKkUvlbLQR5b2qEj9oqDukIaJ1lz9YDWP/OZfI
	 /DL3IinIH2qiKkcenE4n3T5ypYGqKwvdGcp8SIN1qhcV94ex6Y0i2n9jew3UaPD8hKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BOuS4q7X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C1E606A31E
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 18:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48C1E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=BOuS4q7X
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so7515ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 11:42:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792694561; cv=none;
        d=google.com; s=arc-20260327;
        b=MUIA9XtgbObV6BKAEAK6U6Q2bN7O3KxuZ/xlkIfyZS8sp4+6OJvRTbAet1X39GsJ9+
         TMPoGtNBn1cG5slCww4h/5Xhxwm4baTkmnOO/PUZowLwFvN++Ynf8kfGoAL0eOpCa2ha
         j7JF0mC7JgFZHbSGutLEegbqFH/TM3loHIi9cpTjSCVpQFvBtiAvyQcFuA3UPWf6kTcp
         lYfaGm1Yq23wxzfIQ65R+sAYRQ129o9IxT9exdr7xOxl2oAsvPftu0MbHPLSaT8Br1Gg
         BxWcX6zTWFNDvvj/30Gd0hTYu9jrfzyCSYLuDjvLzp7cDYvGqR0aHYSWAz/DbYUWgKL2
         OonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IZ/uBrhQVS3DiMAnoAWQ1amBgCkO8xqm7sNIOjhR87M=;
        fh=f8FqnWVHvI2NhVZnQ24M82dQiZhxnQzLMebGNJPRXzk=;
        b=CFmwB17mPlZcc7hjMiL15IhIUg/uY2YLhbkKVd1eIhVfnc0pkxqIwPaMjfSnWUvgqZ
         e8v7YojI1gTmceN0HsUvUKQhHG5kZQryaPvhWsoWjItPM58X2J2TA+qphRN7mrbvXAVR
         8qvZITDNYNZaze0KybZRjHuMza5hz5cA2vvo0dtpW28fwPmq9nOJk88E8wXVQtROtxcd
         1gFrVbNt7pOEPPlgQ8ygatnTFi2XGCnxkAb6Ec3FCkFkmGZMaIR0O1V5+3ibOYCnMfPC
         r5+oO+c6GFez3B+mDAqgw4YZpyi/N0Kt/WkVfZMGjMRbo4Tv9GoLkiCOuhnqjw2OuVBH
         GB9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792694561; x=1793299361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IZ/uBrhQVS3DiMAnoAWQ1amBgCkO8xqm7sNIOjhR87M=;
        b=BOuS4q7XWOM5LGw8MNF0KrwxF3Jt38bvVnV9dG/mO9HB+/HLgal8RwQeOzbBSkqmt8
         TNxoi/vfETwQZdpKw7tHJd/h7OXKu2NRsQelKmdyE7Ejv/sFCDr1pXQfua9ljDXpuajX
         GxlhNTrhVHXvmNMUoWhe6YLx17lm4OzQm9Y9kRQKegEq2P7PVjeLfTmV08bCYpg+wkZD
         IzOs6Ge0Vf8WmsdVBCRP6CeAEVoIplSNL5Pr04D+nK4Tf9D8hDOgNrBvp+QW+yDjWCy5
         3VYi3eLFQlcMrrMHi3z6tyOd5e3fp9AnYg7yj94Eb1ynH2ODewv5HyazRJUksAhNA3pN
         ETQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792694561; x=1793299361;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IZ/uBrhQVS3DiMAnoAWQ1amBgCkO8xqm7sNIOjhR87M=;
        b=Gx2iUSkTz4ZLII4o5/qTByX8w38MD/P3KzcSCWJtpV9s5wqIuamJxvwyHuBhYfCUMR
         mltH3I2l34lg8xJBntbq49vGijErivm8Y2Do+3xju3yPjNDDL0re8kkmBuo1KA4905j+
         wZdPRC5GFol5lgPJAFudi9HNubeiCn48q7ewNa8j0i8ju2LunWcLP8KB5rqw4J4bKJqQ
         +NTV1NpNwJkOycrJdzmfWgAP9kqzBQkoYpyrpDXz6CUW5NwdsG2LCvK+VjL412AP2fif
         vPBhDTmHLeVy7XyAuzwH/YrcGQlTeWenA0BusMH/qoNG8ltBQ5S4ZjUx5sH0nqWaSIbK
         A//g==
X-Forwarded-Encrypted: i=1; AKwUvBwQ41va1kUMVSkssNThq527dgO4sL+qa6+gvVytesl54d+rKtqv9i/Belo7Qkh8kZyqKGTibLvpPBthtpxO7d4G@vger.kernel.org
X-Gm-Message-State: AFq9FYJoK2mgUQ8xj6Ur+Z0tvh9op+Ve4jGfniGzL87SbrM9UuEHQf9C
	IXQFczfvR+d1PmkgET/nqNtAshUShNUmwlC2113PEmmnBY+JZYms6etoNF3iz4SN7aBpIbzA1Pu
	pqidCPtH3hfC4e7THsaYlBTzx6s2zL4XF8aM/PgF8
X-Gm-Gg: AYBFou2Bd14VMXKZe4CDTvm9pzZFyX5T8SNm93dck9mek5Tg9FbxtZ4RVIWlU9+qB1f
	aBrxRFuHYS51WfTiH1doWEdQ9n3B5ZuuWVxo7Iu28KvvZpJ3UMP0QASkJ54wxTX8hsNb6LjeP/a
	XjtleHH9DUiHBhdKUH0605yX31USahKN4lDqMITFP180Lp3dssaadQXk1XZMSNcjWpY+mWNGQtc
	qyxDtqRLqV/bd4wp+YU88rjx142g7R3JliZGJI2s442s/Qz874Y99CU2PQjyrYKKmAmmKHeLpAy
	6Wmok1iLz9IpQI18JfvAl9mXk12JOy2ZqL3nsnAlEF57unBMnJ0MA6DO7GIQ3HcX2Aqyi0ewk/M
	mtVpKTqoSv8PHyaHlmbRl29DDam9UBnPzZZDtOOtCs3sdByYRwLlgd8h5z4ve/Yom3F/UcYfjut
	LkjvW+YVilYcb50ULhthFfDRU/FEpWr/UE5+lLDr0nscI=
X-Received: by 2002:a17:903:98f:b0:2e6:12af:5b04 with SMTP id
 d9443c01a7336-2ea7c74bcb0mr574065ad.0.1792694560033; Thu, 22 Oct 2026
 11:42:40 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com> <20261022015712.1297331-7-alexei.starovoitov@gmail.com>
In-Reply-To: <20261022015712.1297331-7-alexei.starovoitov@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 22 Oct 2026 20:42:03 +0200
X-Gm-Features: AclHuK-4emBvKnbiUXwxsP0RzswCumffVqYk-pDdBlhbp7tQ8eLavk3E__t9lUU
Message-ID: <CAG48ez28oYxMAxJaXnYtT_8xGReS6SLC5vURw4eStWpuPsSSdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/9] uprobes: Don't sleep on mmap_lock with
 dup_mmap_sem held in dup_mmap()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, peterz@infradead.org, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com, mhiramat@kernel.org, 
	jolsa@kernel.org, akpm@linux-foundation.org, liam@infradead.org, 
	ljs@kernel.org, surenb@google.com, david@kernel.org, vbabka@kernel.org, 
	hughd@google.com, kees@kernel.org, tglx@kernel.org, x86@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 3:57=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> @@ -1713,8 +1713,22 @@ __latent_entropy int dup_mmap(struct mm_struct *mm=
, struct mm_struct *oldmm)
>         LIST_HEAD(uf);
>         VMA_ITERATOR(vmi, mm, 0);
>
> -       if (mmap_write_lock_killable(oldmm))
> -               return -EINTR;
> +       /*
> +        * Take mmap_lock of oldmm and dup_mmap_sem of uprobes.
> +        * Don't sleep on one of them while holding the other.
> +        */
> +       for (;;) {
> +               if (mmap_write_lock_killable(oldmm))
> +                       return -EINTR;
> +               if (uprobe_try_start_dup_mmap())
> +                       break;
> +               mmap_write_unlock(oldmm);
> +
> +               uprobe_start_dup_mmap();
> +               if (mmap_write_trylock(oldmm))
> +                       break;
> +               uprobe_end_dup_mmap();
> +       }

I guess in practice that probably works fine, though in theory this
locking pattern could potentially lead to livelock?

Like, if two threads T1/T2 both try to acquire the locks L1 and L2
with this pattern, you could get something like:

Thread 2: lock L1
Thread 2: trylock L2 [fails due to contention by a third thread]
Thread 2: unlock L1

Thread 1: lock L1
Thread 2: lock L2
Thread 1: trylock L2 fails
Thread 2: trylock L1 fails
Thread 1: unlock L1
Thread 2: unlock L2

Thread 1: lock L2
Thread 2: lock L1
Thread 1: trylock L1 fails
Thread 2: trylock L2 fails
Thread 1: unlock L2
Thread 2: unlock L1
... and so on

In practice, it's probably fine as long as SMP cores don't run in
perfect lockstep...
