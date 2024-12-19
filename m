Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E028854727
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Dec 2024 01:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734571755; cv=none; b=fHpYF1xCAzxBSDAoPtxQnSXgk26kkGhZkCJJwmn8IdlpjCDWmQzcxx9ex30h99p+NiIEHeNi5jWXFSm1aNrVa8Hwdle7aq3Cg86EoFaLkiDtSLrd1y6Grzh45P3sfK7Bl0JB/JoM5TF9+g2a7ppXgauZ+liAwPVZq5Fe7SNj7NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734571755; c=relaxed/simple;
	bh=55P42yXMsnmw1gM61UYBagx+05l8alLXL9NUw3bTuP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRaq+enwg++hv9UndKVLAaD1Y0qLAFrZ81h7131rtfBOF0IHKnVSq6gH+NCabVX1PonzqcvA5kP7Hb9o0h4DsVvaj/oQyqzec+23634OFf1Y/ZCylMGUE2LGGoU3VlUJ43bC/jqp7FdaonUg65gOuUHGeRyj6bIQRZo8NUymkAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bligBLQP; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bligBLQP"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a814c54742so41525ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 17:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734571753; x=1735176553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55P42yXMsnmw1gM61UYBagx+05l8alLXL9NUw3bTuP0=;
        b=bligBLQP4EF/hYVfbX2be7IfKo0l9v0R4a6ZGRmfIvUsCK1zAvPDwvOl7DFGlYQwXt
         Xb9UoeDoeRPuzUb6p44oXehRxObfoBv7Ey/Nzn2oYhOzRe0ys7KGAWtMeDiaLdgTDi9C
         XPDUaBIvM4M/EF5ZSyW1tCWaU6aLlLdnnqhpkFPaSmuFQ5GD+oKTAu/jTqRcWoAlGyWe
         SJ+gs+KxUBuoJ7yBgbYL6UV4fe9SHm2QuiKdZ/cbSUxf9YKqndA0la9Nc3Awjp0YsFyW
         hRWkEAxl+enedkuFx9RUxeaPeBZ1A1w1FPm28MTNqZpQkcMwUbzlSgjxeAypXbbmx8x/
         +MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734571753; x=1735176553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55P42yXMsnmw1gM61UYBagx+05l8alLXL9NUw3bTuP0=;
        b=LiSXv8GKUgshFBEPNG8zpA0WyAQKBlTozi9qGFSUJGzUackduGfH4dZhyHH9KDmx9g
         6YEOWzdMRz7629SkIACbxRwhILV/pbQB1JBkMSUx2lcyTZ0smUtSsCvsWSYbZ8/4F9zl
         xy4TFQSqE7qYcrVNussbZDE/n3v0y3kEFAEVigF+71Eq81/uAJlMlBGNn1JQqIUrxmfi
         6M6sE+1SIGsAob3BDlHbmi7QBS72kmhqdI+7ys3iSm4rKR/ywaPox3gAZhnEJlAATiyU
         K9+tqbn8rnkL3Ljvye5vvtiT+f6rcTIkoo//kofHNP8X6J0bkHoKsCHBsWG8CtST/+lq
         FoOA==
X-Forwarded-Encrypted: i=1; AJvYcCVuh6UJUVE1iYgs04LX7yrJ8pwjM7GhmaL07aqbLpJUkPFFLLe8xv/j04RDTL0HWaoMvwnD3sCmU2Z5ui5HysY6@vger.kernel.org
X-Gm-Message-State: AOJu0YyAOblV1F9NjTxwn12nvJRFgrzx5NVzRDwkfqo4DPNElsh1eUnu
	PhX8+7G11IIGtOmyJrrwrMNJNzHvcYZTzIzWWEyrKHT5wSGaoDUIUfL/Ir5wWD9Ej/5RU/j4Nlq
	nKGURYMgbkrTh2rTvYHAb9rrSc7OwqptDyeqx
X-Gm-Gg: ASbGnctQh4zWA+niwIpzNSqmqxksje3Ra/4Ee1fzh5oaGZfncF84rO6ErlSbKqnRd2c
	wKnRrewMBUW3gKQCVuSczwpQPBWbM5yLzcFsppao=
X-Google-Smtp-Source: AGHT+IHbVDZF8sLfnVYiJWWN52S2zAo6xcpZl52W/38/ExJTsKdtSTLw4CR/FIuC9tFrCDTd2tD67s9ZwW9yS5Gcws8=
X-Received: by 2002:a05:6e02:6cf:b0:3a7:5be0:5a06 with SMTP id
 e9e14a558f8ab-3c0ae35eb12mr649245ab.29.1734571752924; Wed, 18 Dec 2024
 17:29:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216232459.427642-1-irogers@google.com> <20241216232459.427642-4-irogers@google.com>
 <Z2NyAxRzKaIw2qaB@google.com>
In-Reply-To: <Z2NyAxRzKaIw2qaB@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Dec 2024 17:29:01 -0800
Message-ID: <CAP-5=fX9+jbZo4qd4JDY=tHNJM_hD+pn2B_0ytf0_6A78XeMaQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] perf synthetic-events: Ensure features are aligned
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 5:08=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Dec 16, 2024 at 03:24:57PM -0800, Ian Rogers wrote:
> > Features like hostname have arbitrary size and break the assumed
> > 8-byte alignment of perf events. Pad all feature events until 8-byte
> > alignment is restored.
>
> But it seems write_hostname() and others use do_write_string() which
> handles the padding already.

Well it does something :-) (I agree my description isn't 100%)
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/header.c?h=3Dperf-tools-next#n188
```
static int do_write_string(struct feat_fd *ff, const char *str)
{
u32 len, olen;
int ret;

olen =3D strlen(str) + 1;
len =3D PERF_ALIGN(olen, NAME_ALIGN);

/* write len, incl. \0 */
ret =3D do_write(ff, &len, sizeof(len));
if (ret < 0)
return ret;

return write_padded(ff, str, olen, len);
}
```
but NAME_ALIGN is 64:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/header.h?h=3Dperf-tools-next#n187
whereas the data file is expecting things aligned to sizeof(u64) which
is 8-bytes. We're potentially writing out 7 u64s worth of 0s for no
alignment gain. It should be safe, given I don't see other use of this
alignment value, to switch the string alignment to being sizeof(u64)
but following this change we could also just get rid of the padding
knowing it will be fixed in the caller.

Thanks,
Ian
