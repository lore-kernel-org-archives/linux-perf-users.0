Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09783DA7E6
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Apr 2026 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744594; cv=pass; b=Tjh6QSjqcDTYLCZavPaKkgaiznWgXZqI9sEkLYLZ6rHcH6vflko5d8M8S1uE4ljC9V4tJnL+cEF/OLtggVif0ZokAT4hLLkvreP52Ixr1+wPjnIYcLgLwaw6strE1ezkRL0KqAaQy94ka04duT7LvSvKXsrf7J7866C2Aj4/ClM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744594; c=relaxed/simple;
	bh=sL+DbYXenYNmTUC/7Bv4zzz+q+E0oZ63r6JaIiUCHkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sDethsmmCvfBkEKr28gZZUbG5OrdxBXup7Sxiy9N/qovnpnEcW9uVFBi83a5k1aZKj0acGwfE16KZwXtmK59ogECIYT7jRavvOQxF+KomGA6c28Dby5f5IRNnMJGHaidQ7AhQXgN+Diiee5Wd/Jak2ZjVdkU2U9Xdw41e5LSTy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdnkxGJZ; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdnkxGJZ"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8a05c18d3e2so9234836d6.1
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Apr 2026 07:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775744590; cv=none;
        d=google.com; s=arc-20240605;
        b=e2SMGxv6u/uVRsX9yNfSl/F3s8gCj+PmuiycT35XqC9q7qdad1mUdT8UYQpeTAiVPe
         SASQ75mX6l0gl7i1BLjVa5Z23mkti/3GOe0ZbIvF301Aq9ZnFpyRkmb05EpK+ZPPZePy
         HPr54axghuK9gKJH5B08X4n/g4nNp0cVXFB7iWnJ2hA3MeDJBWVmL0o/6lYkFmVM9MYY
         zYkx22sD8Me4iKy+R2Oinou2myzptd9bbRtPvyIAjHhAx5qE6kR6NXC8zdUHE5HaeDpg
         Nw6CsbToby3r5Dn7Y1djFiRBMGZv9fwaBFhNp56KICAu/CRw+aeX12NgGpOOLLpB8DS5
         wHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ok9Bkvi/fMEfbhekzp5HJ85Ko8mmlKRoz8DsAPKgMiE=;
        fh=KJ/1SdmJMNWF2zeDV9geaJbVpNVeoxtFTaHYKsLacjs=;
        b=BZ5BTyxog9MDQkX/ch41buYMgS9ctdAoHbwzdgLDQ1eXID+1/nI8KgWleQlnRqvWRF
         TIGJsCrG/+af7u1r5H4YtgWbiJ9COmOSb3pm5FnKFvg9RmWd3RPs4jR0WTvow5HlXWDU
         8zr42qhdi5sgWtTridsT/PPhFgpNWKBhQ2LlHERsmLt4VbBfTE5F4s71FODxX72CYZva
         Ir7AN1rmdy3KiCev3+VDl7AwveRt6YOOs9PfXFnX3YyMeJZD3FyHz0lCPuhktl/PiD5Q
         LF9Ur29Y29UPMv7JD9C0xWhM4yCcjLI9HlXsgZHvYUMMJrUZnO10Iw51/2NHkslU/FNt
         eG1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775744590; x=1776349390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok9Bkvi/fMEfbhekzp5HJ85Ko8mmlKRoz8DsAPKgMiE=;
        b=qdnkxGJZZCiRNEBsHBSeD+AYXO/zsKdwjP93YoE7exuF2Lh0+7rJ0lRW35lEcC2UPb
         r89CfTa0/037eoMWbAFc5PVhID72REAyYMZG2JR53ExcS4vgglnC1rw8+/MbHHPNbWEh
         uGADsirmtrfx/HUXQFlq8mYPOlIHbIi4SAu1v6s3iuwnJBQqvHIRNjaKTbxa89tkdBEP
         nUGMPHunpsn4ikMKfS7Ul+Et3jQfmt3ycA41PSe9K0jJF6vVnFV8n627p2xwwtCqRX/C
         P54FeZr1Ce4T2IHwNkYS2gDiidKMZy8okGHf5zMy+Lg92bwQTdruPiKuexGnlumyjBMC
         A/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775744590; x=1776349390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ok9Bkvi/fMEfbhekzp5HJ85Ko8mmlKRoz8DsAPKgMiE=;
        b=mBQo0bgtIvFEq5hIBnQgWE4X77aVFf3YZ5o+1tDSpydtPvGMj02HCwq7Pml+9YcKiH
         cv/22nZZZ2h7Ierq226uzfB6X/lS3d5/lXVuYpxKyLZS9C4eM93XQ0Sj4q8E1Jw/edSg
         gxgEY+3+igFJmvjqVtuudSN0zXrPgOCON7dst4lDd7fky1a17JUgkQH4U9FywdYLoXRj
         u6LIX+eW8dNN8rBSRYxzE7CExfUC68L+/5lR9ZayzZLiWsBI/h41eu1O2whnssi1lBzX
         k57t2nyAas3imgZwkeePDC6vzgPkN0I/tRZCU+Vj6ZxvNsPUyjJLZIpa3mC2bpwqd6zy
         SXrA==
X-Forwarded-Encrypted: i=1; AJvYcCU8IihMSV9ennrkbvOLaVcTX/pXwTmLe8Y9aoXxHtjhLqZy4eMflz30mDLoz0yUX3m2U63GiKh5geR+2T+3AEX4@vger.kernel.org
X-Gm-Message-State: AOJu0YwxrC+A+/fOgzCVJKq+F3l5uMQVPID7ypi5cvbkwVJFx5isfMpX
	X7Om2TTu48ofQ50FApzlX2gMzCD/Kbyt2zImuWKKCttSvYEvu7s9Ttc1SBX+bII20OUqX2/6UKz
	IuAzJ+JZGXYpdyyouJ90xN0ndHv1LpSE=
X-Gm-Gg: AeBDieueGa/gauWUrE2LH1zbI20U2HwggFIvl8I8kwEYWQseIijk9kj9w9Ll4Yz+J+V
	jzJs+2Oz90JTXe8P6cgp5rPNmkSTGVWI7nlBiFLuq8fRDdGZtWtkgInez/0icEtR/TLduWXtPgH
	n8ETnb0pyMLGvJKer2M7RO4Ywv5koLhjYr+wLnPBm+BDcBtx84iC18mPp4ZF5N/8WCDuQyGnsmF
	TqX4Se8tSQ8JHwIOS7LB9wTj+IyF2DrEYiZ5+BTuAIlYGCQbmmBbAH+exoxgM8dgX3lcMMuMDRo
	QOe8dA==
X-Received: by 2002:a05:6214:2484:b0:899:fa7f:7144 with SMTP id
 6a1803df08f44-8ac7469ee67mr54240186d6.26.1775744590254; Thu, 09 Apr 2026
 07:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409081154.318898-1-tmricht@linux.ibm.com>
In-Reply-To: <20260409081154.318898-1-tmricht@linux.ibm.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 9 Apr 2026 07:22:59 -0700
X-Gm-Features: AQROBzD80gPK1y_3vDmxCmOBv6wyWKqbtFJ0-pk5BqD2bPZ7-uCZArSH8SDgDDI
Message-ID: <CAH0uvoimMqbULq6gKaVt7Uv4n6Om2Xjpf7yUi7dmVJwtcj_SQg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Make perf trace enum augmentation tests exclusive
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Thu, Apr 9, 2026 at 1:12=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.co=
m> wrote:
>
> Running both tests cases 'perf trace enum augmentation tests'
> and 'perf trace BTF general tests' together causes the first test case
> to fail:
>  # for i in $(seq 5); do \
>         ./perf test 'perf trace enum augmentation tests' \
>         'perf trace BTF general tests'; \
>    done
>  125: perf trace enum augmentation tests  : Ok
>  126: perf trace BTF general tests        : FAILED!
>  125: perf trace enum augmentation tests  : Ok
>  126: perf trace BTF general tests        : FAILED!
>  125: perf trace enum augmentation tests  : Ok
>  126: perf trace BTF general tests        : FAILED!
>  125: perf trace enum augmentation tests  : Ok
>  126: perf trace BTF general tests        : FAILED!
>  125: perf trace enum augmentation tests  : Ok
>  126: perf trace BTF general tests        : FAILED!
>  #
>
> Test case perf trace enum augmentation tests' fails because  the second
> test case 'perf trace BTF general tests' runs concurrently as can
> be observed using a ps -ef | grep perf output list on a different
> window. Both do a perf trace command concurrently.
> Make test case 'perf trace enum augmentation tests' exclusive.
>
>  # for i in $(seq 5); do \
>         ./perf test 'perf trace enum augmentation tests' \
>         'perf trace BTF general tests'; \
>    done
>  125: perf trace BTF general tests        : Ok
>  155: perf trace enum augmentation tests  : Ok
>  125: perf trace BTF general tests        : Ok
>  155: perf trace enum augmentation tests  : Ok
>  125: perf trace BTF general tests        : Ok
>  155: perf trace enum augmentation tests  : Ok
>  125: perf trace BTF general tests        : Ok
>  155: perf trace enum augmentation tests  : Ok
>  125: perf trace BTF general tests        : Ok
>  155: perf trace enum augmentation tests  : Ok
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Howard Chu <howardchu95@gmail.com>

Acked-by: Howard Chu <howardchu95@gmail.com>

Thanks,
Howard

> ---
>  tools/perf/tests/shell/trace_btf_enum.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/trace_btf_enum.sh b/tools/perf/tests/=
shell/trace_btf_enum.sh
> index 03e9f680a4a6..437510d46f58 100755
> --- a/tools/perf/tests/shell/trace_btf_enum.sh
> +++ b/tools/perf/tests/shell/trace_btf_enum.sh
> @@ -1,5 +1,5 @@
>  #!/bin/bash
> -# perf trace enum augmentation tests
> +# perf trace enum augmentation tests (exclusive)
>  # SPDX-License-Identifier: GPL-2.0
>
>  err=3D0
> --
> 2.53.0
>
