Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E8A2DD5E2
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977338; cv=pass; b=aBhZ1BebvnfF8Q8hjpzZ142iEdKwvi0SOide1pU6TljGJQC4ePRzhtPjMSve0WDT0kWHt7IJmsLklwzRvShmaGH+71eZYRFPk/Jz21xU4XXr9CXcLk/3ojw87WoVy7KbkuxILlpCeiGMoifHkIbihg4OSQ8x/dKL0OE1QheuvJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977338; c=relaxed/simple;
	bh=Rr6XXuC8ePsFIckKm9m3vfBBbbjvzQaeoehPjWxjwAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2OXm5t/1dK1Vheih8c1H1C5fveoiMjrqm/UmOjCngMWyASRV6RkXVwyvhKg3GhsQy5BQiZeRKiMx0eNWChyhBzsCu3Omv24RYxn9K3oYB7fr5skHp/shXH1l6COve43FeiDirEWYOgkrsQTV5b+ZkVh4RwiUUDJnP7ZEgoO9Y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UoCCvCIS; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UoCCvCIS"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1270fc2bdf2so13176c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 10:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774977336; cv=none;
        d=google.com; s=arc-20240605;
        b=IIk2DO3o9HieFBReoSc08WmlX7AWFU006Ot0pIlYCYya+xY5xiySKNR21qwei7k90l
         xP5a2rMdvBvDibY0rnL0jK5ckb42dHJxfF05EpGhRA+OlBDlAJg4QxC0eHscnXeNHsyj
         Iwau/4V2uVEPQM9fNmoMnCgokVybLiURJGpnYSlEyzEcAig2BBMMCyDo2HGxpJ3S4AL8
         cF2OTECdhXnvRVcPW5o3krBl6ejdvnego41N+xmk1WuWDsgAmnajCDq6cTOMAX8o/AJn
         wGCJMI2+DiO2oHQOpDyRI0QytJbTdjvqL+EJhyydl/BAljxUhjvRzRG4BQtVXUYU6WGz
         vmeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+ELH3ctGO6Z2jFUxE+lapqUcGDlcCHMTqC7cRtveKUQ=;
        fh=2ggxsn/vSxUTYbAKELz7XTlq/8ot9I2eDr3ykERc3ec=;
        b=Odv9Iod9TF/rxCWF7jWOgqT3L/amiwQbuDY3CCDk/iAn+ny6iuAxT58UCZZjADIqSV
         /gEQDQ34/fluBzXUWUUMPz71bZkMKRmK/X1RyBHx1O+XiPgueE/yViRdS8FuF9qYUG0l
         xXwjed9wU1D7sRYB5IyYsVDahNzFXFV6rVXVXIeAeViEkssD7Ec4QUFxqRZ/RBLqnz0f
         IecSEG8/jkckgrXU3ElOg+yAzF11t3AqIe2LGczoijowRV90nfTwlXNYMdJV8IQNer+i
         T9mWhdcZ0gfUeazLi7OtJUxtT1OW8h5AtK/tVCF9NpI4ki4lnshl5lTw49O1vrt8OicS
         psag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774977336; x=1775582136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ELH3ctGO6Z2jFUxE+lapqUcGDlcCHMTqC7cRtveKUQ=;
        b=UoCCvCISImqM5+7iWideC7FimjJKYqv8jqEZ59/WwQX4gjQjAghQTTd4Ad+/Ht2HL8
         BRcNnUkXxGJIZtlgLY6gZcfV81GokHvF7vdzqJLt/rQRKPIFBHtGA7sRSLDA7g/hSs+9
         mlefjDEVq+MG6v1ex9d3TkTQb6n0sIoCHR+AzNg15zQYfBCTAcePXAikABFkzJ/eTCPI
         hR3Nh/7kfuXs76nNNIZyDRGnL7/r8iKxnnGzD4r4fXRh46haBnq0n7G4AhuNLrbBkb52
         /XqhjC13o92jcTcyfe/4FCZi4uCvUkeigqkC4U574+j9VBe0ln/vEF6s8EIOOCBWtoVM
         A61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774977336; x=1775582136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+ELH3ctGO6Z2jFUxE+lapqUcGDlcCHMTqC7cRtveKUQ=;
        b=hvTdNMtyWco5PkENftp1m5l3WcBEfHS3QRoeoHe8RCKQBML/cxnV1qqIg9PNoviIG0
         m4xIGT40dt2vSoCvaF8LFXy8qIawIoWi0A+oKaYC51ol7ItkPLYuw+3LpsOngKuw9zEv
         jY6SjiZRy2Ckw2sXS8gOwrvaMn4AU1XktFYMq7xcUWgkoqq2YZpkLeiLl29hMTB6zcl9
         i2GeqdS2ELhlIXoUaz5yA5LsqpXv8AMy/eV74Lsio4WgMCQspJ4Yljrm3W46H8cEojbP
         9k914WCUw1CMgAdFNAODwz2FPl4KV4+zln40uya8hxsCqsvbDBKuhR9uIWSUKUSz/pyg
         xjAw==
X-Gm-Message-State: AOJu0Yy1U1Cywgk4g5nt2Cpua3NgyY1ZNYBLUIlyXiZsDm74tY+OVbZ8
	qTpsqNtfExWRoE4BD0/uqxAPAQilvkmcwPtpXO7fDt/yW4xaXpEeJ/mieM/n2lsL249LX1CrdDn
	O89KRTjjy1WedW+R6E72YMe/FJdO3PW97DS9od7zN
X-Gm-Gg: ATEYQzwHzz5JipQVYtZxmPJa6T8bzUV5FNu4ZAZIjZQom9hbCRRNPScr4WXlWKGqk4O
	yUnv//S9dNng54PVoTfd+rnQ/uCAGljL3GEOTTOjO7QcgVi6hiK07EFWgcyqqSHy3v7Q1V9othh
	rfmbtPJdXC6Wgqz3QQqsXXKDLxFH6AP0XgJzOheyc0Tjh3TOxIUzPSD2m9usR7A0GTz+quzIwww
	NixE31Uof7ZQivPj8snGnzwvP0AsZGUEHJ4T+b7A+bbLsg8nofqLcdgzam4RAvDQioVP3/7QvWI
	hWWxiRAKXxdBt+D4dnv4L40WhJYVKvOG9zCOVw==
X-Received: by 2002:a05:7022:ea2f:b0:124:76e1:5dc7 with SMTP id
 a92af1059eb24-12be6071dc2mr35653c88.5.1774977335204; Tue, 31 Mar 2026
 10:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331101020.1270363-1-mpetlan@redhat.com>
In-Reply-To: <20260331101020.1270363-1-mpetlan@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 31 Mar 2026 10:15:23 -0700
X-Gm-Features: AQROBzADTVVfgJ2BvK6kjquxB3Q8_PYe2J6AG7vxZZ69UBYoKy7XHLQIz4gqMHg
Message-ID: <CAP-5=fX51zhteqMNsHb=oiB1L7QcXuZm71-_-RB_+TrfvS8_RQ@mail.gmail.com>
Subject: Re: [PATCH] perf trace: Fix potential u64 underflow in duration calculation
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 3:10=E2=80=AFAM Michael Petlan <mpetlan@redhat.com>=
 wrote:
>
> Although it happens very rarely, in case of out-of-order events (i.e.
> due to CPU migration when a syscall is executed), the calculation of
> event duration might underflow and thus a bogus value is printed:
>
>     2.804 ( 0.001 ms): :49553/49553 rt_sigaction(sig: QUIT, act: 0x7fff40=
3ed6e0, oact: 0x7fff403ed780, sigsetsize: 8) =3D 0
>     2.807 ( 0.001 ms): :49553/49553 rt_sigaction(sig: CHLD, act: 0x7fff40=
3ed6e0, oact: 0x7fff403ed780, sigsetsize: 8) =3D 0
>     2.815 (18446744073709.438 ms): :49553/49553 execve(filename: 0xbb173a=
30, argv: 0x55aabb171930, envp: 0x55aabb171120) =3D 0
>     2.815 ( 0.534 ms): pwd/49553  ... [continued]: execve())             =
                              =3D 0
>
> Check for possible underflow first and in case of a bogus value, do
> not print it.
>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Sashiko notes [1] that maybe this should be >=3D so that 0ns system
calls still have a duration. I'm not sure how sensible that is.

Thanks,
Ian

[1] https://sashiko.dev/#/patchset/20260331101020.1270363-1-mpetlan%40redha=
t.com


> ---
>  tools/perf/builtin-trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index f487fbaa0ad6..c9de6bb9b0ea 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2956,7 +2956,7 @@ static int trace__sys_exit(struct trace *trace, str=
uct evsel *evsel,
>                 ++trace->stats.vfs_getname;
>         }
>
> -       if (ttrace->entry_time) {
> +       if (ttrace->entry_time && sample->time > ttrace->entry_time) {
>                 duration =3D sample->time - ttrace->entry_time;
>                 if (trace__filter_duration(trace, duration))
>                         goto out;
> --
> 2.47.3
>
