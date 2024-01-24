Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3147D5398
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jan 2024 01:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058094; cv=none; b=o6BeRdMcmrqBUcWDzvvd4oqrB2IVnFQ2UFqlza8oIIESQaIOw2lBkq/ODbZohE0VubK7DkOgBWntLpiNKUPIm2+0dRvabAsgkq6rMDB48W75JkmHyCMR4+QP64NuNxJNxTJsEyE5aVEKoO9xt17eSSY8k8GItd8wRM9VDPOK614=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058094; c=relaxed/simple;
	bh=T/b+m9AyJemflQXshEC8U3/yAZhlAxWNJzC6mlUIrvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fO8k79GhWM1vy19Q2Gin+SIFNBkVgPFof7ezjvIvf/ZzHtsp7EwRifo/jhgz6NEdwQglEBtaagnC5cawmG2rRXzjCbDcIyBa8hqmyfinTPN+LnnzvvMkho9pL3ZOQH/l+weVebJtr9Dh5NTcXK/ssB+NonGfHdBDHkd7BqJ0bPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ce10b5ee01so3463779a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jan 2024 17:01:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706058092; x=1706662892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BH5DxrfA/dNc0QDkH5pltJtgMJqf+sOFB68d/beKYIE=;
        b=IyO7XXdpvscSi05AasjYZL7Ka7Ah8UlQr7ijrvL+xCoCLzmEm45R/iomaQt1ZNN9DU
         rpmTKZpq9Sq1Q2wRwTzm0IC2IoXuiQtTgUUnnwRiEADJZrZEtIpVYnAthlEV+ZnZKQbI
         wYHDX9lkjTt1DZupUcSi2/ROPmITMo2eSzI6zLGaDc95rzyTtZCBr/Gp5s1kPEJydQBH
         Jm7WbvsPjV7mfVRJAvopKKbi9QJaRfDBAcj7HNIh7y4PKQLTZbRyGZ3M/tj5JpNiNUq8
         MUHG2j7Zn3af8AXljCkpxGzBbT6JXQVocSI5d4fg2ZuKQu2os49asV5/oNcE16rrl7IL
         Hrcw==
X-Gm-Message-State: AOJu0YxKbUiGtpG0JhbhFwI85Fp+A1h0Dh9EhUfPC9ihhjQIhvBdf2ei
	kAheuqdi+6YuLoRLZtIfOwNsTdei72dJi/eX4D18tiFSLWL8l5PGjX/spgSqSBQvAzkyVDKUO7w
	EgqJLiLH+nQnWTMWxpnlPFPHqBVU=
X-Google-Smtp-Source: AGHT+IH9ZiY/wzm9h+eWKI6m2rVzPuPys202JY5rd97M7yCHvIhLVhXuuGyxpR+AvysZ6Y+WrKPmv4i+6gznnJjjbS0=
X-Received: by 2002:a05:6a20:d38a:b0:19b:5b08:1f4b with SMTP id
 iq10-20020a056a20d38a00b0019b5b081f4bmr90983pzb.15.1706058091020; Tue, 23 Jan
 2024 17:01:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122080406.28678-1-yangyicong@huawei.com>
In-Reply-To: <20240122080406.28678-1-yangyicong@huawei.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 23 Jan 2024 17:01:20 -0800
Message-ID: <CAM9d7cjnQONuhh0B91p-rbu7g2of9q=OFH9Fipsit3GQCo8zBw@mail.gmail.com>
Subject: Re: [PATCH] perf build: Make minimal shellcheck version to v0.6.0
To: Yicong Yang <yangyicong@huawei.com>
Cc: acme@kernel.org, peterz@infradead.org, irogers@google.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	linux-perf-users@vger.kernel.org, yangyicong@hisilicon.com, 
	hejunhao3@huawei.com, linuxarm@huawei.com, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding Athira to CC.

Thanks,
Namhyung

On Mon, Jan 22, 2024 at 12:08=E2=80=AFAM Yicong Yang <yangyicong@huawei.com=
> wrote:
>
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> perf build failed due to the shellcheck on my machine (v0.4.6 on Ubuntu
> 18.04.1 LTS) doesn't support -a/--check-sourced and -S/--severity option.
> These two options are introduced in shellcheck v0.4.7 and v0.6.0
> respectively. So restrict the minimal version of shellcheck to v0.6.0.
>
> Fixes: b809fc656e76 ("perf build: Shellcheck support for OUTPUT directory=
")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  tools/perf/Makefile.perf | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 27e7c478880f..f8774a9b1377 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -236,6 +236,16 @@ else
>    SHELLCHECK :=3D $(shell which shellcheck 2> /dev/null)
>  endif
>
> +# shellcheck is using in tools/perf/tests/Build with option -a/--check-s=
ourced (
> +# introduced in v0.4.7) and -S/--severity (introduced in v0.6.0). So mak=
e the
> +# minimal shellcheck version as v0.6.0.
> +ifneq ($(SHELLCHECK),)
> +  ifeq ($(shell expr $(shell $(SHELLCHECK) --version | grep version: | \
> +        sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \< =
060), 1)
> +    SHELLCHECK :=3D
> +  endif
> +endif
> +
>  export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
>  export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK
>
> --
> 2.24.0
>
