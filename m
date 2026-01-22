Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C46C378831
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769106472; cv=pass; b=MfLejbkSfwgREvJxhLAw5s6msYG90JzcNCUbG/pNqoSh0TjMlbMJ296DvUDbjD1OhJ3Bg9gJeK/y86RGPaarOEDkZUxaELOgV1+rYP215FKl2tK1goHxuToNijk9BPWstB+vo0UfPVs8MP3r+nq68Q1f+CLxU6EEmZs9yHaQjRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769106472; c=relaxed/simple;
	bh=JyLxtvnE64ixGrgwDLQoLKsU4qPZEkI3GHp54dqCSuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LP8FH/G6J9q16SHpx3y7o/emyspQaL0h4eOjalI2AQu5nctPQl7TPYpEgAeu5KcUqvhG2Uk8FBfS68dN+GnPibxhysdBjcmGffSNofECjp1CchviI5OYkg4jIyjLoln6PS5FMFUXjTrHLH0QxqxAZbbPVHxH5Fo7y4Q3PAaXvcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4utpq25r; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4utpq25r"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a1462573caso4525ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 10:27:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769106461; cv=none;
        d=google.com; s=arc-20240605;
        b=TLr1D3V14Eo4UpOPRFn500TYaV3t9aBo+cBz7j5B26cBBZtmuRwMAnyc2fuI4nMzdM
         ljr67y3wY2QkpwwHr5rVhuuvUjppEV5Gl2M5DCtmn+bpMIoctqZ8ZLRBBFfDe9jJXwU9
         bRqSy0ZkLUyCCqAebwAmSWl0w4TSyjyK1OgMKLP5RInTorWsQStG3/RjPbZn5Oh0cgU8
         sk9Xcyu9C9sNgixXaEp4jt3YwhZ5yOxsWveeWjG2kSa2v7Dne74F5BteNhg1DQ0pRUDx
         JkzUUGyWop0iGoAGBG3PPOD/Bc+pIHes+4vv+KVaoDTRdMZ40xQMz3Vpd32eizTL4gh3
         xqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=niO0TVx6ckVY9GU9pRuiDUDuM5tSmcMrUe8PmuupJdU=;
        fh=y5I7MF/10QxLVVX7tL9QEpd2d5iufxiVYSWlU+wQE/k=;
        b=bIjO4pP5O6DyoqzZBOMQuLF4jNs1jBbbKOj3L4tR1u+3gOlvrRLNYhm9osysgb7MiD
         25RZj/e0gIrm/OiC44Y4iGHlWqa/tik7x297x+RrONOM9BAeWCik0rsQiUwNvc8Hz6Kk
         NyqZRToOLMWA1WuqAiWKAt8y0SO3G8Txqj5pe19SruS2QRIyJlA8/afEVjQgFV03keR9
         lwicnXI1SPDsb6wVEdg10Pz3jLex+mQ99xabpDPxdQJvCkzpdN0PUULgw5nBQVjCR58U
         1vv14Cs2xn3w+8Xbd7bZwO2T8RdMQo+IuJIhQmd+S5KfpnkdP8sHj1nF4Qtn+UYjZvSw
         dVHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769106461; x=1769711261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niO0TVx6ckVY9GU9pRuiDUDuM5tSmcMrUe8PmuupJdU=;
        b=4utpq25ri3urWhvunmKV499fbt95NNotnuEf6Ou5IFkygyB7N6eCqPls0fFuCDnIDh
         uZflL3v0G8xLddGCqixmmdjiY+Gd/mJ8HijyDlnO6jy0ONOzOLxiSC9u25wq8La7n70f
         yPgDtEL5pWc+4x9ZDy7fhMlRGAtKfPK8flFPt3/5NI3O5LC+lLR37qixVq6lLdhyPrFC
         DVPZFip54rrfj42WYCGEgd5brkHFch805iXKoG245LJJeBhi7MbRFiq0434IG130LSle
         kUHMXZCpXWfZIzJ7RVvHAr7tfMKutORAbwic2savxUxhS1giy68riJ4nZQ4jIgflW7xk
         hgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769106461; x=1769711261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=niO0TVx6ckVY9GU9pRuiDUDuM5tSmcMrUe8PmuupJdU=;
        b=slXmuTDRHL4VIESxcsAPUTT35yPlwsEsXt28ODptUjzTNdn2BUPy3p6b2oRc+o+7aX
         renD937kXwdQyPBgv5qL7OzLurStPVer582tm1zxX7NVrKGtj518Ho6/piCrmhduWdbj
         UVQUs1wpq4Xfaw6raWmYsQfG75DytGXcrJT8g2S97zjJZ4wE8hAccg7w0ufOXgYFsNcO
         j7xxlYMjvj1zQzW1rDMxRV3M84g9RyxsL9YwmqaO9/GXJ/qbYtZ5O1BkGn4r2F6ZgNrH
         CGBfJY/WzlU2ZNyHEbQZ0PBZhBr0Us9c5naFzSgN7SkMekKicOmTSpdwBb7xydzMo+IR
         hb+A==
X-Forwarded-Encrypted: i=1; AJvYcCXBV8eApzjJ2h09nKLakrHJy/G4Rvbx5ZhkQfjxI7yhT0jzp4Zcz4ZjTjR/UboPQPn0cfTUs/0tEisJWaeGiDA2@vger.kernel.org
X-Gm-Message-State: AOJu0YyYEqIpqiZdj0vn9uquDF6IrxOyIqNKEPImQbL+DhKVrixf/xwu
	pq/qbAbhBBGEbX3s2NbnScQXCvMaqk8jupmocXYXEU8JJ2+IGzSWElwlvtdCaeQ4LqbpC2gmy3c
	D7urNPo5NZbrLEfB32Glb9bcws+iT7V/2t5cFIPnJ
X-Gm-Gg: AZuq6aK+/O0OG3NgfSZ2Lly1Og+a70fXrLY3QLzqkxdB6bsW5akBSayPd1vShyw59iT
	puORe7xK30o3IP9K5HMUcQhZKwCse1fSEvJk/cbH6iAyO/AojsBkTiZyp/YpoivQC46aqHgz780
	DRzAStTqDW0S/fnhYHh27jbcwjxFc/0hIMRnFKwBTZseWhVtIfEaL8VksKeuLFVcs4krBaiBLYg
	8lUFBmQ8UwfGEWxiYGkPMKFiWqGdDZU4zMPFvgGyJjMeZ5Tn5rzDbyYyoqmC/URpyyQqAnV3KOL
	JBjztUMb0dmfIzQCM4HXRzQfkVus9bsWg2w=
X-Received: by 2002:a17:902:c411:b0:292:b6a0:80df with SMTP id
 d9443c01a7336-2a8024e3411mr149045ad.10.1769106460724; Thu, 22 Jan 2026
 10:27:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122171704.142218-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20260122171704.142218-1-suchitkarunakaran@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Jan 2026 10:27:27 -0800
X-Gm-Features: AZwV_QjIDZ-6UjHBLWyHrzew7bdcW6ZYbIhWgHmqHco45mhhzkP8UcFuypwLMTI
Message-ID: <CAP-5=fVOeYCU_6ukDi_3g=H=K5HXoN+UjcNCysEbCO3LAY3ukw@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Fix memcpy size in arch__grow_instructions
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: acme@kernel.org, mingo@redhat.com, namhyung@kernel.org, 
	peterz@infradead.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	mark.rutland@arm.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 9:17=E2=80=AFAM Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> The memcpy in arch__grow_instructions() is copying the wrong number of
> bytes when growing from a non-allocated table. It should copy
> arch->nr_instructions * sizeof(struct ins) bytes, not just
> arch->nr_instructions bytes.
>
> This bug causes data corruption as only a partial copy of the
> instruction table is made, leading to garbage data in most entries and
> potential crashes
>
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
> ---
>  tools/perf/util/disasm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 50b9433f3f8e..6faa9df8e373 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -81,7 +81,7 @@ static int arch__grow_instructions(struct arch *arch)
>         if (new_instructions =3D=3D NULL)
>                 return -1;
>
> -       memcpy(new_instructions, arch->instructions, arch->nr_instruction=
s);
> +       memcpy(new_instructions, arch->instructions, arch->nr_instruction=
s * sizeof(struct ins));

Reviewed-by: Ian Rogers <irogers@google.com>

Nice catch! I think we've been trying to make code like this more like:
memcpy(new_instructions, arch->instructions, arch->nr_instructions *
sizeof(*new_instructions));
but the immediately preceding calloc isn't doing this, so your patch
is consistent. There is also a clean up in this code to switch to
using reallocarray rather than realloc.

Thanks,
Ian

>         goto out_update_instructions;
>  }
>
> --
> 2.52.0
>
