Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D02D411694
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543598; cv=pass; b=nErTXhUG0RPIjaZpKpjBT1vAcSEzELmCNYrEJ4/ZPLyLUEdbRT8bejSkHAyKun5Bhv2hg3uvSbzkTXK8ek9vB+sws7qXxtmyAn8eSuQh4unswxHwSSLZDAXDRKg52rUw9SZrzdDxtDfGVh0vKAlqe/C0aVjKe7G9AnqVtS+7IZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543598; c=relaxed/simple;
	bh=FKf5eZY4HDNVwU84ggQwXteKnn3XHSxFKP1Ih731Ixw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gESfu4B/6IkVlP+TbUlJzhomFiLjX4TBU76j9cJR1sd1kP9yBsz4h0GiIQoP4RDp5y6ZEf3wqsE5M9+aqCfC+xY4TYSSPAL9gdULbGzv8zrlsjvi3qrjuDtGGGUpKlhSeL+IIVEZ6UrX+Zzwe04Hza7Y8xhAJrGcWV5qbrT4Cs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SP5Yuvn7; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SP5Yuvn7"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c67ea316caso2175ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 10:13:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781543595; cv=none;
        d=google.com; s=arc-20240605;
        b=e24Jw9ARek7jiJkCgse4HXGnglPZl207jEtOw44BexmbW3L/4eKWPzBUCTMN0I63Bq
         YOqpxdt5ShKsjm90Z6uvxNbktU8hh7GQi2i5UmrueMETiVyJYCcCokXYH0OdADLbcHh+
         taHog/lWkQKYMkXlxkFKE3NMR/IdXkh0BJc0VFCUxW0U00nWOgvNSKIMxlvTnaOKF4K/
         nQaULLXGXnu/rw28i7kN0USninfCFr+DqCs+TF3YqWryQwCDitKEQ+eYP1MA0Mj7k4q0
         4I0owoCF8mI8aStwe1RiIf65ZLx1C/G7Bo9ODQB65Ws13dJTNgHVyfZcsch9m+PwXHNM
         D/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hhZPkZlPFgzmWIRxu4vUU8Zx/0fLJidulAt5k1xzr7I=;
        fh=+CsldEX0eu763Gpettg0sGu57WsGs0ISJ5e7Q4coYaY=;
        b=QKpEANFdhQJ3y4psLJ31SSyz+pHs1ls/KyYMopVAj8QnUr7bxxad6TYQK28Nl+DtQv
         i9qCzz6kN0Dy7Ckqxk9YuovcVaQ72NMnJcul3IhlTnwuBbzd2BKKbXIcIt5NRG0OBEXY
         H0vDbbQzgyLzeomVaAFlFRWswZkdf0cG00eEcLV6vadh0mfJMINeadNvpYRELozeQl8f
         UNSbNAr4DXt+Ft+jdTLBqTcoLEP7xAYbdL+K2tymks/o64rLUic1dmdoVCBtGC9VtOn7
         AtrsF3n30VpfmyBJqcZAf1onqZ64uKgJNL/FwPJSHXyT+xDEOOVwvYvNNsko0Z4GdCnm
         bBfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781543595; x=1782148395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhZPkZlPFgzmWIRxu4vUU8Zx/0fLJidulAt5k1xzr7I=;
        b=SP5Yuvn7A3Zlas/PZo7F7w6AlwjNIyC2Owmm80GpS60T47CZ/zz5AuW/mgequwZ2uz
         AATIy/Uk/yfeU42qxj3ZT8iI9T9VHqigRBOUV43hD0mTboyYi741BtOms4IjO/pPUr6P
         0BPR00l0luppHVExPtilENEPwKCBXpjGnvujKBkXulzvgO+g/cO+7Swv4SHBKrNgNT/w
         rOCJsq0TrSi4yEhWA08uO3Hwhz7DxgoRuZmeI4nWnI0Xn60zfutwnE4cPOpT1L7YSIO+
         PB+bRoKR2kYODf0OZ1CP91HHS8M8PxjCCT+bj4faszN0MnqoTeJHjBipO4vustgDye3y
         jCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781543595; x=1782148395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hhZPkZlPFgzmWIRxu4vUU8Zx/0fLJidulAt5k1xzr7I=;
        b=ZktFVNzi++3AH+mUmJwB3PN4oVBI8oRFlRGZzL3pKXodQNaMShujydh8Aq0Te7+CLb
         WJlVT0tCly30KA/4yp/vOj+X+4hn8r0u6UFUFk1ZLwsjfqoctARIIQjHdHYM3/gu0/+2
         mc/r/IRbhtozQXpgIZQ3btrOZcJhdu1Kzkg3rVScL5yxQ2T2iR2Gzh9aTH9Ww/R8oaDa
         DdxrZpyhDk7/b3Bmbe7vbY3BGfp/rkl0RGsSmfFgRBWRbXLNPil5Pwvy7so6Ohbu37WO
         +h5MiVoxcb8XPEy4K6hbP2olCi2bCdcONaugcpUP06zCCnUpG4jty5W7I2xenGa3EcK7
         Frjw==
X-Forwarded-Encrypted: i=1; AFNElJ8KRxSZUeNsbVaHFtJMx6mF1xd2Y3VzYddFn0w6Mbl8pID+laXQFEyRJ9mNlvnAnG2eUplb4g3HOchrdECiUNZZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyhaR+UneGMD+7WT2JZ/GOMmTZ/jE2P45zeoB7geksedTj7EKtE
	BRTaYXc1O4xrG3SB8gAT8W3tUQ87jSfyu46EfldhhTmaFC7WaflYuWpFmJwHsVI8m9u9aZIFnes
	uNbjmludowiZ/a5p36jD4TixiCGsTcT0CjXK9DVMc
X-Gm-Gg: Acq92OHPJZ8iaSIwK2/ar91iaBBULvNem61LJ9j08B4S0r+scSHxtx6HuS34WxR+uZ3
	Szi8si66r4boOx6LrkyuaGP7y0ff/kb1P9vs+XtEuAiKGueo6Ah0J6D+i7G4fx3Tgrof6kS+lLD
	URpjsGrGoDhvuv+4d+DKgo6nyYHJdPF83Z4Ab8I7DEeZh0n5NU7IUgerMHoiHl8oujpaZd+GmTl
	q5ud3uMGX30NcAJm2EXneOuSS769/LcVELSnGVRnc/e2Au2bVT5cQQGQj29VbAXzGUx6NVLG+hX
	0HPN+07mzG5wxK31kitCcuXmWtgwB5ceETcy
X-Received: by 2002:a17:902:f54b:b0:2c0:defb:557e with SMTP id
 d9443c01a7336-2c69a3330f9mr32195ad.1.1781543594364; Mon, 15 Jun 2026 10:13:14
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612222413.40791-1-acme@kernel.org> <20260612222413.40791-8-acme@kernel.org>
In-Reply-To: <20260612222413.40791-8-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jun 2026 10:13:02 -0700
X-Gm-Features: AVVi8Cf5cebbHUEOseSL1q26c87H4xjhiD5S77gsuR8KB0mrHPRwTYTrSTH8-IY
Message-ID: <CAP-5=fV40BjNXAZsx=+0wAmSTm1L8jOgSHmTecnjQ7TeDS4R8Q@mail.gmail.com>
Subject: Re: [PATCH 07/13] perf hwmon: Fix fd check to accept fd 0 in hwmon_pmu__describe_items()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>, "Claude Opus 4.6" <noreply@anthropic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 3:24=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> hwmon_pmu__describe_items() checks 'if (fd > 0)' after openat(), which
> incorrectly rejects fd 0.  While fd 0 is normally stdin, if stdin has
> been closed (common in daemon/service contexts), the kernel reuses fd 0
> for the next open.  With fd > 0, the sysfs file is not read and the fd
> is leaked.
>
> Change to 'if (fd >=3D 0)' to match the standard openat() error check.
>
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Fixes: 53cc0b351ec99278 ("perf hwmon_pmu: Add a tool PMU exposing events =
from hwmon in sysfs")
> Cc: Ian Rogers <irogers@google.com>
> Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/hwmon_pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/hwmon_pmu.c b/tools/perf/util/hwmon_pmu.c
> index efd3067a2e591050..ed544dca70c380b2 100644
> --- a/tools/perf/util/hwmon_pmu.c
> +++ b/tools/perf/util/hwmon_pmu.c
> @@ -435,7 +435,7 @@ static size_t hwmon_pmu__describe_items(struct hwmon_=
pmu *hwm, char *out_buf, si
>                         hwmon_item_strs[bit],
>                         is_alarm ? "_alarm" : "");
>                 fd =3D openat(dir, buf, O_RDONLY);
> -               if (fd > 0) {
> +               if (fd >=3D 0) {
>                         ssize_t read_len =3D read(fd, buf, sizeof(buf) - =
1);
>
>                         while (read_len > 0 && buf[read_len - 1] =3D=3D '=
\n')
> --
> 2.54.0
>
