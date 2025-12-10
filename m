Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C08527B4E8
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765391717; cv=pass; b=OHYsldPOtNeYGWm3Nk30sd0n4+ug9vNIk/GrjunCOefXdh7dRiChCPkdgtP5Q0Q4V9i8pfyDf7kOSEDTHsRDdNsX/9uk5HNiXkkKOhD7g7Xpxc1L7h2QLcBTXEDDPZDufh2iXTcD8yLr6crSqdZBTaB7kJL6nMMpZWHtecDGXpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765391717; c=relaxed/simple;
	bh=7iUZibeL2UHNIR4N1JDwRiO59K1+1GWyhNYWdVfQPPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b58n1zIxaYjqRc0CAe7g//KEOqQxRTOVspm193d4rV0u7fdMu5pL4FBR3FJBDAOjkMnV/QVrQK1a4KRmC5XVf8sAxVT427IShW/6fZsxGOMNaT9DF6pUO7mdR0O/+iWFQd20xm6Z5iZ14RLAVPm9HQEv+MUZQvICVds2W90H/ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vZS16Qhx; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vZS16Qhx"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29e7ec26e3dso15525ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2025 10:35:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765391715; cv=none;
        d=google.com; s=arc-20240605;
        b=eZcpCGVRWK6QpPDVicNQn8wBvihI5l2rNgkdHoze0uFKdujUrZdqYzgfufbUK39J1V
         UMG2v2zzxMln6sqwm3Oto1IWut9WSK5b4UU+DFienzi5O8MiV4nzotScmjJZ1yhCJGJQ
         ieOo/FCApR9KXTLTewqYi8jU3jYi0GFC58arKzcVX5jTXIwmtGo2Hffc9c3+svKsP7hf
         9588ZEnzdWlj3c5ZPYPAQ7HXi005en1Uc7rUYGFrTkFsM/lep1iLOZBxHePmfqO1bk8h
         xbuiHyD8x64B8lh4BTIEol6cscnka+XoiPtYwW3hKLNE9zeyHzYQXmeiQ/ieNHjoC1GV
         UBjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BZMRIR2Q3ZuqewvXWF5v1G95vOLQu6CiC7DhBrH8+jg=;
        fh=6DA4G11NGR51Ftmcj0jwsyj+/lm3lkUxXGCj2Hol/Ss=;
        b=DKa6rah56zT72R06vYLnsq1DVgXBQtp3xLuI2YiYEWB+a+1IWsn/12/oV/NECsK12Z
         JgHaBj35Z/N7hHQKqmY4L0o3+Xs61Vv5ArD+Zy0n8irEW87tfNMHWDQAVYj9bm0rc7yg
         3Ufa5/J7CtKbhq+4e88QX7pOjHTCijueSxo4sIPuHlapO16osHAD7FiJ7mVQj/ZwrLUs
         MJaVZOKTmEW2GH3nDEn7c70WVF4PVHpoH030SXxO1dpW7yRVqfwLyLqcPPwmrkBdJk3D
         OZiiCqoqq2FGykZBbDsWLMn5VjeUQiy/I7/HtWMf76wZRt3VKvbTzclPUkbHi49LPmva
         8lRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765391715; x=1765996515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZMRIR2Q3ZuqewvXWF5v1G95vOLQu6CiC7DhBrH8+jg=;
        b=vZS16QhxgBSv1dxUPLO4n60wA4jEGpDJrcxCWPjES9oNxZQVVwXBFHadQYkat1D/Zw
         QmVk4VCmwu+eRUn+gs96X4yl5azYF8W19ElbPFpvH+WMCiaDHfkNl1+gOq1iNPcrasOx
         3AC1TiLxI6Mz6A+IkXEpKAhoF7zOiOylM7DhfOxw/aN5QwS3l+5cY53bAs2btNZ1we1u
         3Ve2YrjyZvFd09UffnwZWdUw0v9N8sXlaI5YFDek+5XpDJp3qWG6L2OcjJ3gP6OM34H7
         qK+3HGaLQBq/Wy3PpqJOvn4BDzQclmDkJSA7WcedDhxmlgN9G/R6xBoeG2wqaszNj0z0
         KI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765391715; x=1765996515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BZMRIR2Q3ZuqewvXWF5v1G95vOLQu6CiC7DhBrH8+jg=;
        b=fY2Ho6q/V6vISytGVVjl7OO9jLbiUaLxzakuXJcTxQDTEgO4DuC+JsbCgIuu3SSlsY
         v8wV82OVZ3nnb0y1tKAC/YjE8KDgB4afe/XPEKjNbNaOFHFQ8+K0+VGwNipl40vOCI+n
         W535WVzqUnxqkmlVOO7gIRAbCu27zK4KJTk/741EdWsKS1WYPiYoqVPWfoWn+nbQSlor
         LD1xlyWsRQB+9uZvQViygwQt58PgtSMftPAfHFM0gpa04PPmE5G6ouPSvbX6sSSywUux
         dGw++b9HNF+M44NYMZLhyILsMZ0JGERLpjhwzxKwCfUEmlM7UNp0CD6hw07DNkE+StSL
         iMfw==
X-Forwarded-Encrypted: i=1; AJvYcCUvKeYWiXuzXXhUTJGhAeDkF3uTHYi8TyaexnoP9Y4mJD7G0hbqORUJIw0ysPkoTK3TRkvLxdiVYzBLwfN8szLb@vger.kernel.org
X-Gm-Message-State: AOJu0YxYlUmKhoITAZyp6+Mk+27wm9JRWf/2NZkjxsKtaSBTJIxswTsc
	tPVXEhF+RajeNZ1uktbShqFuQDnka8RnmP2d31S6l08RcnVp6EGowLiIR9xCfBz6e2XVVYA/iQ3
	tmH5bvbrgg5qg2n8xpb5c+QXfjGEazMbcZ2BSxjQf
X-Gm-Gg: AY/fxX5yLegnQFCvlctQ1jisYvfqht0hwke27md3JqMDu0u3wG1SYi6J43E6VH6uClG
	WQTKCiKDyJ7j54NDoNpNvrX9TZJiNwMYDAEBaxxQQKJ4WfPdnYl1NWE8GMoFSDWxsmUKx59JaoG
	jqRh8CiLiK2ycLfnZsRJ4ZBorCQ7Z/SPu+JddbSUuURF+DCFP+ilAq+yfSbCndD3U4N4kI9H0tV
	Vh5q/Eql/eO2IPTmzlbF3b3dHm5diAfrydqWKJ1iwrwmTfnGAFtYR0ZUTfvkDkFCU5Lcii8l0KM
	cCLE8rLZL771UEU3h7UomgvaXQ==
X-Google-Smtp-Source: AGHT+IHkNtWv5/wfc7clfE6FKDxA6B6rrCfOLX5MNaL0d4/+iHfwM93T6frSydRfoQD0vFxm5erOpRpxXqxo4Y94ORY=
X-Received: by 2002:a17:903:3c70:b0:292:b6a0:80df with SMTP id
 d9443c01a7336-29eea1fa30bmr107165ad.10.1765391713128; Wed, 10 Dec 2025
 10:35:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210071752.4160369-1-tmricht@linux.ibm.com>
In-Reply-To: <20251210071752.4160369-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 10 Dec 2025 10:35:01 -0800
X-Gm-Features: AQt7F2p7zkl5_tleQz8BxMy-eEc6AfcdZWPmBPnZXC7zroc51uSFIkefyEI9spM
Message-ID: <CAP-5=fXZw9NA7bK6bH+hxPYG0nHGPYKqtYt3pg7iNmsQPWHRig@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Fix test case perf evlist tests for s390x
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 11:18=E2=80=AFPM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Perf test case 78: perf evlist tests fails on s390. The failure
> is causes by grouping events cycles and instructions because
> sampling does only support event cycles.
> Change the group to software events to fix this.
>
> Output before:
>   # ./perf test 78
>   78: perf evlist tests              : FAILED!
>   #
>
> Output after:
>   # ./perf test 78
>   78: perf evlist tests              : Ok
>   #
>
> Fixes: db452961de939 ("perf tests evlist: Add basic evlist test")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

Tested-by: Ian Rogers <irogers@google.com>

Thanks!

Ian

> ---
>  tools/perf/tests/shell/evlist.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/evlist.sh b/tools/perf/tests/shell/ev=
list.sh
> index 140f099e75c1..5632be391710 100755
> --- a/tools/perf/tests/shell/evlist.sh
> +++ b/tools/perf/tests/shell/evlist.sh
> @@ -38,13 +38,14 @@ test_evlist_simple() {
>
>  test_evlist_group() {
>         echo "Group evlist test"
> -       if ! perf record -e "{cycles,instructions}" -o "${perfdata}" true=
 2> /dev/null
> +       if ! perf record -e "{cpu-clock,task-clock}" -o "${perfdata}" \
> +               -- perf test -w noploop 2> /dev/null
>         then
>                 echo "Group evlist [Skipped event group recording failed]=
"
>                 return
>         fi
>
> -       if ! perf evlist -i "${perfdata}" -g | grep -q "{.*cycles.*,.*ins=
tructions.*}"
> +       if ! perf evlist -i "${perfdata}" -g | grep -q "{.*cpu-clock.*,.*=
task-clock.*}"
>         then
>                 echo "Group evlist [Failed to list event group]"
>                 err=3D1
> --
> 2.52.0
>
