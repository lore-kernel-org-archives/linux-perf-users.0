Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAD4397E9A
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 22:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956207; cv=pass; b=AKUAdoyiW9FMAfHvjWM3hUnFrZ0GN+mf7CQlNiFtJktBMv1CX5cxggFYRrsIy+kXfU0XiK31jw0SA6WvsThYOSTGq8crhJ+JddklQeabKEAFUJtQ/Uu6pHOmaN5gNDQEaUNK/p4nuUwXoElxkmMBDh4bwGkubsk50eVz49CPKIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956207; c=relaxed/simple;
	bh=GnezBpdD+ckp8obmbhW5EYyO47hkUHBLAMCqTa7Fa8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ii4jhIOvynf0byQilENm7rQ9A46T8Nwjm7xm1AcaLqj1RXuPswVxoJaHS2S++xLttwHdzePOfMiyjWyZL6aSm4++fXVxoTgyajzvbdSimVz4mSdBqjHVB2RhpLbYYBTzPqeap3w8nljBCn77Ds+3Vshalrk+A75vnLIVxiq0Axk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WIAelhcP; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WIAelhcP"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bf2d865383so371425ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 15:03:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780956205; cv=none;
        d=google.com; s=arc-20240605;
        b=IZzECvg5YuCcahb36wxQwYfzJ2woRPJXs47Br7FV6kR/sTbkrWTKmWeWApA9t0aKGP
         jip7oPkZTJXRnDjJ0RjY1EMDlyG0G641QvWCwRk684JKKlLZxlwD6t2hsHo9/GKdyIiI
         uL+luGIkWUt5ofm7RIdUJKJbd7F0RM6f3Ft1jfQMvAuoL5uCwJ0neQZzLCXBAbfAxw+c
         zAGQfTiPJc0yTFsGLuWebul89R2lhuCKO2n5mIYPxqqm9DUAcOn72WGedZZGU7TrXIFO
         gu9UEQb4nrAABYRW/HX4Z86TKm1qqWQRxppd1l5mEE3S+OCcBTBOZXWIKgXHV1WpBwOT
         q6iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Td9/E5f9V6aXQ0cuox27S5GUKVxy5gX2ycYw8xHBNKc=;
        fh=G7XOLUKnJ1Hbr8vPrulil5J4iIjREeoNvdWi556/gvw=;
        b=eD2SZ3rwDUp0RlwSg2l0IEw1ZsvRy/5aX48dP18GtohnzuaTsKIxJLqe5La46lxWBl
         e+Ofc1NSvPXL6zboXjZx3h7GtOXQhGcyWgfyHgJyCEK8QmsClW/TMepyxomZPrgKQ41v
         FnlTJTN5cWOgn3H+AJosy56So/MNBC/QKiH2QbqLWBrNcb2tWSWiGD+ZlKGlNttlQ9Gb
         /yY+A/LZNcN/CrFfd6KdajhAmpUvfJbQt0amLW/YrQpK+016LFJfnOdTKUJHB07ndQRH
         XJRZw3DPVfG9vRlESIfz7G3oQ8kJDluJ5JBcrwSj0yARjbuboqoJwqANdv9UePOHsci9
         wjyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780956205; x=1781561005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Td9/E5f9V6aXQ0cuox27S5GUKVxy5gX2ycYw8xHBNKc=;
        b=WIAelhcPgK3GBkaKzvZ3Ebpkc14SrrmgWt/mhJSVOdYGQWE+mSLJr3yzFJvQ45y/8r
         LiU4j2HRjQWaJpG0jsg3/YkcUF0m7ffV9s2YOikZ/Odo4FlZ2d3+wIozgOAtgKC8lB+o
         aVCUSzsDHN5K5Af+whOr35uxI3jQKLVMDv/wpfwM6+VkmjtuPDBnoJSJnmM9uy8eF4B5
         wOezoUBvUzLtHCnEyHtbqxR9gZWp4QcnLEu9yQ9OtmzZW4oTXaKJTeZjMA2KJxJ40RY8
         1/nJDuEUxZD9DO4Y7PlkTfpfSxtd3SYa5CR4ZJYvnCMWspFBwapcysjbVrtPIqfFrCjc
         fCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780956205; x=1781561005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Td9/E5f9V6aXQ0cuox27S5GUKVxy5gX2ycYw8xHBNKc=;
        b=p5gPuQZMGYS1geh5fPQ2nWAVqVvVDfyDEKmdxuVj+9PgY8OYAQVxuooWkMPxne8V0s
         YO7/XJf8zckjQvL3NbjHDNf4ocWhJhS5hKRrxC7etcpJrZRXJW1PVlAv4hO2a9qg3zkC
         V3pxnm3Vi1BJgNK20uW5DDBpYEipUWjicqLyXbII5Dyy+cpYZcZzt5fAcNCPGQRG/s53
         l/Wu7pplIAwGLN9lD0yC8XzpauLUZ8MF/djaHH8WwMNQY302rqMgLBJZwH25A8f0EcQf
         U8tLytVQROYRIaOAgN3LyZ6hlQjKwPIWju41wzZPARwcXKtYqvixdSNWdBo9vnGuA+pb
         vVmw==
X-Forwarded-Encrypted: i=1; AFNElJ/LcQcq5sOkAfxb2G/HnOy+CMaI0zwwq+mrX8q7CkhB3gW9FBjhYYy9ixi7PZ0MUcl8RCDOfWxZV/cD6qK8V+30@vger.kernel.org
X-Gm-Message-State: AOJu0YwQA6xcRhbo3cNLCy5rsPRKjw4x0kCG5IJ6i+6lMh9pwvfsmRH1
	wCnq61UM53UHL+3GZEkpxmRJL9MbnSp0G/Mb7s6mO85d76B/wsH41Z0D1gEXVVc8UXnsMrETyPn
	koko9vU4447fRSUO1U6bVwwNq03xrYobf2a0XQ/ms
X-Gm-Gg: Acq92OElkJLooyyxAAh7ocxJIdMi9C8ZDwoJ0DNKGjDO5lBCtoQkEuKONSvmJv9A+ZW
	jrS9fXVOC6/bleH6hQNXuugD/KtTl7JtOgyKjaQiPlO+Wy/RIap+1Xe86ZF9q6ZUADY+cvuMo4V
	hyI8udWaHdrraOdwGVMMHE7qzqMXmYQMgYzJZWJb+MAEXX/D4eBEU86TGACEq+BQMVXObS/Oj+x
	tuVg57pu7rPS/ybh6TE9p0+8G9djpFN+uoi/kei6um7dAvQ/TTFtYvKqEOLqcZ8CECd0s+nL/ih
	NmMEbd7nh8IWWYqT3Tg0Is+1pgMf9x0rFvVPjH/WVK/cvtX9
X-Received: by 2002:a17:902:d583:b0:2b9:a39a:e5db with SMTP id
 d9443c01a7336-2c1eb742bf1mr6324125ad.7.1780956204854; Mon, 08 Jun 2026
 15:03:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608201753.1979464-11-acme@kernel.org> <20260608205059.7ECD01F00898@smtp.kernel.org>
In-Reply-To: <20260608205059.7ECD01F00898@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jun 2026 15:03:13 -0700
X-Gm-Features: AVVi8CfD2DVec-bEtIZMfcyfb1m__IqqI3l50f4Ca8Zyxp3CE1PRAkHyt_q-Td0
Message-ID: <CAP-5=fW80NxOXjDRUJsn9Z35CahcXxwUs8sug=eTBxA_n3--Rw@mail.gmail.com>
Subject: Re: [PATCH 10/11] perf tools: Use scnprintf() in build_id__snprintf()
 and hwmon read_events()
To: sashiko-reviews@lists.linux.dev
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 1:51=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The early termination condition `offs < bf_size` is rendered inef=
fective by the switch to `scnprintf`.
> --
>
> commit 0dbaa7b9065f01d9d8a6117248bffa97b3021ddf
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> perf tools: Use scnprintf() in build_id__snprintf() and hwmon read_events=
()
>
> This commit replaces snprintf() with scnprintf() in build_id__snprintf()
> and hwmon_pmu__describe_items() to prevent accumulated lengths from excee=
ding
> the allocated buffer size and underflowing the remaining size.
>
> > diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> > index 8c0a9ae932aa5..a3b92108f9626 100644
> > --- a/tools/perf/util/build-id.c
> > +++ b/tools/perf/util/build-id.c
> > @@ -94,7 +94,7 @@ int build_id__snprintf(const struct build_id *build_i=
d, char *bf, size_t bf_size
> >       }
> >
> >       for (size_t i =3D 0; i < build_id->size && offs < bf_size; ++i)
> > -             offs +=3D snprintf(bf + offs, bf_size - offs, "%02x", bui=
ld_id->data[i]);
> > +             offs +=3D scnprintf(bf + offs, bf_size - offs, "%02x", bu=
ild_id->data[i]);
>
> [Severity: Low]
> Does this change neutralize the early termination condition in the loop?
>
> Since scnprintf() returns the number of characters written excluding the =
null
> terminator, `offs` will reach at most `bf_size - 1` and never equals `bf_=
size`.
>
> Once the buffer is full (`bf_size - offs =3D=3D 1`), scnprintf() will onl=
y write a
> null terminator, returning 0. Because `offs` stops increasing, the condit=
ion
> `offs < bf_size` remains true. This causes the loop to continue writing n=
othing
> for the remaining `build_id->size` iterations instead of exiting early.

Looks like a "-1" is needed to address this.

Thanks,
Ian

> >
> >       return offs;
> >  }
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608201753.19=
79464-1-acme@kernel.org?part=3D10
>
