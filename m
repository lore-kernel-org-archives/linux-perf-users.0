Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053DBDF59
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Apr 2025 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743737226; cv=none; b=imdSA+Fv3epfHkIfmSpo/rJWJOWTZn7IPANFu63KW960pg+/PeQju1n84jC5x3ya3gBEQViwGjHr1h3Udqpvnmwy1HJOL69a70hbOmy8sqB27k706RkH/gkYMyXSMy2funW1w3tMd1xLlHtEj2OUl4J5TFwS6jN02+SHD4PVg/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743737226; c=relaxed/simple;
	bh=0N4PLvPPXqq5As7/vex4mwOKOOj90h90YY8balvvxks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9UK4/sZQ7BmBpW+Q4UDbXZNcktm7zY+liakMWMgLhThAnlnmv3fDXebYJ4PMDYMDv6LNKFGhdvBPitpDwCOGTiEpvQrhIBTFhtMIMqbzmpaJvvYb2l11f20FTvz5Rg/psuKTcfgU3qESxSAlmyYI9RgQ7PqtKnGUfCb/qqy4jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMCSNf9U; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMCSNf9U"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e6cea43bb31so1261772276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Apr 2025 20:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743737224; x=1744342024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqFB6oux9OyKXMdob0oD6bucO8UVkTxN/DF+rAzGCyM=;
        b=QMCSNf9U2kLdp6dj61wmLe5tgkd46JvFAYYOyi0omNaSYL1Xm6LGbch5izW9LbOX5/
         nVrJj5fD7swkjLyCh973obG8hnSGgBQw9Q5KYL8YNAm8C99EIflryLEAAXVvlO4IrNCA
         nBESwpGXZStSQwlPyCeiiv52pF7LGl2NwhQ5SOn848kHwqrjMAHllTT7Xx7DZybbwmhS
         YtaIt03V3BHudYuhe7/PmUVaGxx742ILHNIYF4TZ5JSXTCIOgAHfEV2TQa5Wp5Y9e2XO
         EwbflfJAxyGA7bAQ1OV6wPdlEWtrie+GnVZEvs8I6/IN57N7Jg9vm1fLvGCmWf5rKcFC
         BnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743737224; x=1744342024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqFB6oux9OyKXMdob0oD6bucO8UVkTxN/DF+rAzGCyM=;
        b=WUH3UEm7OklcX9gKwmTYk8EVaC8M15lxGunSmyqMHg+L1ueJ+is4cvqqRbv0BHXGs4
         KBhDq0It0jIniLs9MmNIX9zUjU1xXM7JlvGMMz4ae2sOGQmTHZmmBX7vTSYYVvbvYirn
         SOQAAG0hEuHgb+HHz0EYPiIVODt8b1eMn4iGHGUVRgMJWvdYNGgM/xGuKmJcQY/KCl5/
         diKSJLMZf4r9w9LXTIFlwBhpkNMycDkDqs7aNi4mnjtGwztzACLcX3Wk7z81N1f7gnoI
         XJAJUOeIDxiL9N5M9/7ZA5++fsASfHmFZhR62gwGD1dPJFOkqtp62d7Ncm8uad1rkUtD
         kgoA==
X-Forwarded-Encrypted: i=1; AJvYcCUcriXT12ikGV457cqr61LSzYMy8OtHhTlJnbwd6Vj3CfBXuSUmMzlEwz7M3ifNhThMK5ct4DSGBM2rs4OSsM5s@vger.kernel.org
X-Gm-Message-State: AOJu0YwHVY2cpkfmeHCgj5PvkHW4I3AbBr/da19fWSF0LIMNMRDM9o+O
	pxaKSpnwtyL4ogn0Wi1hkCzH5a4Ndl2fFZlHHIuHbIqgXubcEateUUxbbyG7djy2p7pr7P3Kphc
	hTk88TDSu0en9b738zXqwe7aABFI=
X-Gm-Gg: ASbGnctX/7a8GsqSp/WNiY6lybWWYn1GSPqOEm+JD7gRUDaWXffxq6z3YCFOvJSJASC
	c5c3f7VOmECFhqXz+Z+1BJbuZgHggNwav2uMK8gyEViTCC3LwMBNkitFHcxHUzM/m5CNMokZlnT
	WEncKrAeJGP1ASmFFzaCa54vt0
X-Google-Smtp-Source: AGHT+IH8oJgl1yJWCwqTfMCz7ZgVnaEPqMNE1AfLmgSVF2IltKCdv1zBMZaYXBQJ1N+WrePYG64etHcQwTDfJSEOxAU=
X-Received: by 2002:a05:6902:1b0c:b0:e69:371d:677a with SMTP id
 3f1490d57ef6-e6e1c26e4bfmr3288618276.1.1743737223783; Thu, 03 Apr 2025
 20:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403160411.159238-2-ashelat@redhat.com>
In-Reply-To: <20250403160411.159238-2-ashelat@redhat.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 3 Apr 2025 20:26:52 -0700
X-Gm-Features: ATxdqUHW28bVDKEI2sX0MzZtIKdz0Me0Z6YNYByyHyNbWRFL9clqYGGWi5UFiTU
Message-ID: <CAH0uvoh8h2NAw3wbBwXAKyAHWS=QehM=pkBD8GOc+f7CcmedyA@mail.gmail.com>
Subject: Re: [PATCH] perf trace: always print return value for syscalls with
 set errpid
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	irogers@google.com, linux-perf-users@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Resend due to rejection by mailing list]

Hello Anubhav,

Thanks for doing this :)

On Thu, Apr 3, 2025 at 9:06=E2=80=AFAM Anubhav Shelat <ashelat@redhat.com> =
wrote:
>
> Currently some syscalls that have errpid set to true do not print a
> return value in perf trace. The syscalls that were consistently
> observed were set_robust_list and rseq. This is because perf cannot find
> their child process. This change ensures that the return value is always
> printed.
>
> Before:
>      0.256 ( 0.001 ms): set_robust_list(head: 0x7f09c77dba20, len: 24)   =
                     =3D
>      0.259 ( 0.001 ms): rseq(rseq: 0x7f09c77dc0e0, rseq_len: 32, sig: 139=
2848979)             =3D
> After:
>      0.270 ( 0.002 ms): set_robust_list(head: 0x7f0bb14a6a20, len: 24)   =
                     =3D 0
>      0.273 ( 0.002 ms): rseq(rseq: 0x7f0bb14a70e0, rseq_len: 32, sig: 139=
2848979)             =3D 0
>
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>

Reviewed-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard
