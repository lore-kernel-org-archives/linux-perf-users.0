Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372D129B214
	for <linux-perf-users@vger.kernel.org>; Fri, 22 Aug 2025 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885761; cv=none; b=mBKtUEBZ6slhYbOe4lLyNclEO9Af8Jchk+U+PnvG/kCygugnFNuQMiJMWMVQC5NT9UdaJsRRf0ZyJVuIqBRcM0pWLqvxzD29pSWpYeCYcYUw/Qef8rbGsaKf92vKmaLxH06+m/2RV9sdJGUBkWLx4QZrS6crZp4eL/n5h1KOJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885761; c=relaxed/simple;
	bh=Tb1rxvji81DhNvos9+34Dpiz+Ba65Rcpm8zkhIppG0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWpwj6L8wxaTvj8UThVENc5DyFkmjp1p4CXdLUrZueeyYTK9RCR4Cwnac6MAxclWU9lmJ3g+gFtNcqUN0jMGq+mIP8ISkWJSv8qJ+BlDA3y54t5Je108f7ApnoLzORMn7uuscTqSTWgMrPymgijUd/ZcgMprHKilB/wfNMY2JEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2IsVA4u; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2IsVA4u"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-246257e49c8so22435ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Aug 2025 11:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755885759; x=1756490559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWb7ujFJINgkd2DMZmp5XVtgDqGOY0d1N6wa3FF1s2Y=;
        b=q2IsVA4uk7cAFQyRT8/zD5kkaWNv1H7tnRqdHK6frrKyZpDmpAX3ASRhPpVgPnp+F7
         UxXg8ZWXnVnn93ZNqpRPrJfXC+q1dGh/Ekh/1QGBzsn5pQLAfkEpIzCKvVdAl8VNb5Ek
         +A8Bihb4cixZdjz4p7sbaOoBjn1USipl8C9PUqlcrtmhplKf14KijV5ELIBSXXl6kqv6
         CcV3QgD6m0eiA69MGn8nDfZiNTGbI2dj32Wm7RrjWPTis3E8qX6H5bvOvUaots9dPHQt
         ISzlYhrK4njCGjFMeG756/SfhcUukKI3g9VMOi//0uyWEpGa70lC405sMlwFIMb40geP
         hw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755885759; x=1756490559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWb7ujFJINgkd2DMZmp5XVtgDqGOY0d1N6wa3FF1s2Y=;
        b=mwl43ErTyN3wSf3LzXsjdCiR1RpzGi0h8FvxgMVYnFmjNjxHxaagVu5l5SZ4XOvoaB
         aU0AuWJRR2s2lg8qpw0kpVfzubl/mISuioMBlCWrlgTt+oLw8/bRcwkXWCqq5acxesu4
         Q0EKYs0zE37iwT0MOzGnM4taLNKAngnaG9wvqSleBAWpin7VtpqS1rl4nqvqhaoe21+X
         vH+fAwf5Db+b9PM5fUBwLjUsqQxt7cunuaqzaI+4qi51NJLHjq24+8Ym7Ep065uI6KVT
         XqtmtVcBSpJkX9G/hhy4kbXK2ryX6b5KIbScmgj8VikIJdyzxLSRm1BWTZdLwY4izGb4
         ryGw==
X-Forwarded-Encrypted: i=1; AJvYcCXPbgRjeTUGVckkXnQ31VdRh6/cSdLHDZIVh9SMchGq/McRdNWemqownQg29RWHRMcJGCwhGeEI2mpYh1NLEnl1@vger.kernel.org
X-Gm-Message-State: AOJu0YyDTRJD7+wTjtslWa8ul39+nBExjj91APOuE2ELjHKCzK7ulhUU
	QsSesIXf8wTvyfQvWoOourgZtcj83fgR34z+keciL8uX5Hg+kKebDVOC+Nxw3E8gZcrlmdUKeLe
	XHBSq3VczWO1Ra5ryPBr26o187c6ki03rqebY5Gce
X-Gm-Gg: ASbGnct2ikKRYgss+b3BJ9UsOgfQ3RkokP/7lmhClDwPMMPGfJ1xvL1NUCAr98CmANm
	2BV1iqiLGygy7ZvcijLxx4P5FlhCQ5NPcVjB7XjldoOK5go8PeMGe2NzrskSbWOqWVQwy4KNO+W
	rr4ZgXYvN6q0dcgXg5EapgHSFKeB+sY3zFJCpMsnLkfdE9YhMLPkW4Obo2QJzKzO+n6dNVdvoid
	934SLKUNjrRHgc=
X-Google-Smtp-Source: AGHT+IFA2af6rcs83KxLB8fpKojCpWMKu9Z76RWMk+J7SWpv7uZ/ZhBHV2AkeRZ3bikP+3HIPQPdbu4m0lj7cvNT4m0=
X-Received: by 2002:a17:903:2f82:b0:240:520b:3cbc with SMTP id
 d9443c01a7336-2466fa251e2mr168825ad.14.1755885759046; Fri, 22 Aug 2025
 11:02:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822122540.4104658-1-tmricht@linux.ibm.com>
In-Reply-To: <20250822122540.4104658-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 22 Aug 2025 11:02:27 -0700
X-Gm-Features: Ac12FXyykAui8r7AO-hPS1XawpXPdLCTa7zC7cWNH1M5PInPONEDUvbV_1htBbE
Message-ID: <CAP-5=fW43ZAguuB-FB2F6CFTCgd1Fy1Xd+WAt4WSA-fMRTwG5A@mail.gmail.com>
Subject: Re: [Ping][PATCH] perf test: Checking BPF metadata collection fails
 on version string
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	blakejones@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 5:26=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> commit edf2cadf01e8f ("perf test: add test for BPF metadata collection")
>
> fails consistently on the version string check. The perf version
> string on some of the constant integration test machines contains
> characters with special meaning in grep's extended regular expression
> matching algorithm. The output of perf version is:
>
>  # perf version
>  perf version 6.17.0-20250814.rc1.git20.24ea63ea3877.63.fc42.s390x+git
>  #
>
> and the '+' character has special meaning in egrep command.
> Also the use of egrep is deprecated.
>
> Change the perf version string check to fixed character matching
> and get rid of egrep's warning being deprecated. Use grep -F instead.
>
> Output before:
>  # perf test -F 102
>  Checking BPF metadata collection
>  egrep: warning: egrep is obsolescent; using grep -E
>  Basic BPF metadata test [Failed invalid output]
>  102: BPF metadata collection test             : FAILED!
>  #
>
> Output after:
>  # perf test -F 102
>  Checking BPF metadata collection
>  Basic BPF metadata test [Success]
>  102: BPF metadata collection test             : Ok
>  #
>
> Fixes: edf2cadf01e8f ("perf test: add test for BPF metadata collection")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Cc: Blake Jones <blakejones@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/test_bpf_metadata.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/shell/test_bpf_metadata.sh b/tools/perf/tes=
ts/shell/test_bpf_metadata.sh
> index 69e3c2055134..be67d56e0f09 100755
> --- a/tools/perf/tests/shell/test_bpf_metadata.sh
> +++ b/tools/perf/tests/shell/test_bpf_metadata.sh
> @@ -61,7 +61,7 @@ test_bpf_metadata() {
>                 /perf_version/ {
>                         if (entry) print $NF;
>                 }
> -       ' | egrep "$VERS" > /dev/null
> +       ' | grep -qF "$VERS"
>         then
>                 echo "Basic BPF metadata test [Failed invalid output]"
>                 err=3D1
> --
> 2.50.1
>
>
