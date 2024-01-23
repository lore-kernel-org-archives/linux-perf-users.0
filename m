Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49539811E4
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jan 2024 17:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031781; cv=none; b=r/JbeSTn9NSjNLgZva3fJnVihDqz/dwV8DoV0oGis4QPQd9Wo0cj5QknjmXdfbPGIPY6289qRkC4sX6sgjywKmwf5sMGToZ7tkhLbiX7/0mA2xbQ/zu0cYaFVUBqoabE3WcNhvdoydz3iY4Hk6Buoz34qCbMMvep6nbvJc/Q/kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031781; c=relaxed/simple;
	bh=n3jKIAZHq3vd21IsvzrvUoALWXXBX28mPv7aETmBltQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVVbI+7NL7YXeNfWZVE/7F8STNtaNVFb0lFoO46KjtKhQOtzebvFjqbXf+TUVTuoZD/nF5KT/uo0XKaTbMCS/zWa3y2R5kkrQxj4R2PH9/8WM4iyweVsWUy2+CY0W56Q93ZTYvQaWDntEBp2cvy2wN6AcXrNY6IphYldHnKy6i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g+00Oxld; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+00Oxld"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d72043fa06so385ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jan 2024 09:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706031779; x=1706636579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lsOV8IeC537w+9Ec2CkST/B5Vp6PgwtVbjoxdE5XqY=;
        b=g+00OxldrvhzCkDaVfoxzsjN8rLHhK31Xx2OsxOH/X0cKxRNOYGaEZLstGwvKkc5Lt
         hX6ti6vlSufChqA5jbvT71YOYT6gmhCCYQJMlCAHw4I/9MJbpI47GmrKXbMF2XnrBzrR
         OUUxc4JIAQiaNzkxDBj5mh91/hTpNjvmuGydoqkgitI7ZPcOgXqs8sahYlkHLfKQIyjl
         Gw3TLP4MAQHvxw8dHMJeSDbybyvUZUhkc+Cz/weGX4DJdkkK/O9sFDM+SU66tPnZmjcR
         gfKBM3iMvJrTjWQIz4NRyyLX7LYgkm6Lng1ZNhBxTzgV6TztXBsxfLnkYDN5hxWMJIV4
         70VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031779; x=1706636579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lsOV8IeC537w+9Ec2CkST/B5Vp6PgwtVbjoxdE5XqY=;
        b=jyH2PgrbTlcs+GWEGyfLnNzmcDwdvcw3uQYtaMn8NqDh1vBmCnS6dbVoXDZ90rQ0+5
         6UsOmFjHdKQ79Fq5Uxf8SxfDBw/5+Te2RsJGMpFx6DBLkApr99n/GkflyY8SFFh7fANi
         dnyik+R/qTvftV5JtCTDsQRTerz2uU88PF+GAva8LXwUx+C9jgNhrDbVMlANNOxoYLQL
         t0cBgWJq2TCgnVi9PjdR3TRA9pyL5wOf32UN25rZHvOQyTcmCSdJMbInnZplkE/i61o0
         iGC6L8mf3jcCRYHIOcqhYqgiGxnlfWFSURsxFPx0DpXgX4gPg/c4Als1ieR2Ip+WUn2Q
         NG5w==
X-Gm-Message-State: AOJu0YymVe1szJ27pMFu296aakpP4ryby2YV6RcJyfRmP+L9C9TynhLj
	02umNp/6YlGnsGOwm5Ek4PPbNbrhbhMfOOpy0jkqbKUHI0ua2xBeLaStH6pT67LODlAmpY4bHo1
	JJjz2BcSF7plaSGYVfgsxq49Cf6zLWWs4y8ru
X-Google-Smtp-Source: AGHT+IF1UbkrcinQVrOa9/H7VTo5/9FAKWEP3LSPlRx0C1zaxx4BKyW1DsJvy16rHG9mGfBfPDYgrH4qkhdMwpfTXU4=
X-Received: by 2002:a17:903:124f:b0:1d7:5e3:2c9a with SMTP id
 u15-20020a170903124f00b001d705e32c9amr30274plh.22.1706031779264; Tue, 23 Jan
 2024 09:42:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122095955.2647989-1-tmricht@linux.ibm.com>
In-Reply-To: <20240122095955.2647989-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Jan 2024 09:42:48 -0800
Message-ID: <CAP-5=fVmJry0gGNV+n4tp6LPgK6=w2EDf7dRA+nBQx3mMJRc-w@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Fix test case perf script tests on s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	acme@kernel.org, namhyung@kernel.org, svens@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 2:00=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> In linux next repo, test case 'perf script tests' fails on s390.
> The root case is a command line invocation of perf record with
> call-graph information. On s390 only dwarf formatted call-graphs
> are supported and only on software events.
>
> Change the command line parameters fors s390.
>
> Output before:
>  # perf test 89
>  89: perf script tests              : FAILED!
>  #
>
> Output after:
>  # perf test 89
>  89: perf script tests              : Ok
>  #
>
> Fixes: 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>

Thanks Thomas!
Reviewed-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/tests/shell/script.sh | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/script.sh b/tools/perf/tests/shell/sc=
ript.sh
> index 5ae7bd0031a8..2973adab445d 100755
> --- a/tools/perf/tests/shell/script.sh
> +++ b/tools/perf/tests/shell/script.sh
> @@ -54,7 +54,14 @@ def sample_table(*args):
>  def call_path_table(*args):
>      print(f'call_path_table({args}')
>  _end_of_file_
> -       perf record -g -o "${perfdatafile}" true
> +       case $(uname -m)
> +       in s390x)
> +               cmd_flags=3D"--call-graph dwarf -e cpu-clock";;
> +       *)
> +               cmd_flags=3D"-g";;
> +       esac
> +
> +       perf record $cmd_flags -o "${perfdatafile}" true
>         perf script -i "${perfdatafile}" -s "${db_test}"
>         echo "DB test [Success]"
>  }
> --
> 2.43.0
>
>
