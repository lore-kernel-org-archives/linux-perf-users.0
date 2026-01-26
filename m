Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C134C124
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449387; cv=pass; b=Lxh8diJG4Ojcpp1BcTxeYEVmHbMBSJj+8Ed1z1+dCOY9oyyWMZ8Jce+I5EzzGdFpm/nv8gou7O4MkVNXWRzinzpLiCrlGr6alfjJWvSHXUIh6tX3pcUo252Ufg0vleJsT4lrQdZNFMUMqURUXO1bnOJw2sYXyBUji6PPStkV2lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449387; c=relaxed/simple;
	bh=g7YzmZlLzxLm1WxnED0D7dK8pgHNCsq9mTJ/fFxN1c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THCOIsJRWthjN9ZQJndV3xnrKfyOzvAn3Ibfy8MSMpBkx9SsEK8ReCaUVAOjb2mYXu46ZoNGus44eeapM/IVf9YLg/5tjskXCxkXUJ0PzXiXftVooQRsoMgSFog1ZHlA/pFqZuglAJ5jgVEXDx4F/ny/Sdp5206nFuZyOxKY0qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B51EwUA6; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B51EwUA6"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a76b39587aso1015ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 09:43:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769449386; cv=none;
        d=google.com; s=arc-20240605;
        b=Uxv1+dymH09tSMJHwaW3GrZpm5txCpY7MdgdZJnu1+oB6pIYny4EOhxCjJsjJBBh95
         j035Ao2ylweJHKNy2V3dW/tsQkOLB8q9oxYR6bQtQEqsCsrUW5RQXZoPglnQ7drHfBkW
         m9xgY0c6m7T+NOsIhZ3lzeS31Q3PA2GivWib5p0pp4ISC7k9EjXwyhL0vomO5fUIzMdA
         q8hc2DfGTX0zCQcxuu3lUxRcVlVJrrsuA9dbQVNt58Tvjk2MEzqSrOnp7xodJ7XzZsq8
         I+80Bz7vWhdAsQ+jVVzXhwHXVrE+0pyn+aVSWba/z5ZtbPf7dHjq941CZmvpceBONKr0
         qPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=buGfk5/1aHFZlIIMOertm0h+v4ooWBsjxJ1vRzpNYwo=;
        fh=AR+1hCof63Qp772+Q2VZBBunv5OquAll4Dfl8Q0ICyI=;
        b=WOveX+4KyxdE5R6vwviRF0BjMKxOHB+NxOBAIapgZO857ktdM84bnCr2PhAcmLuueG
         ghQgO5YcO+vXoxIxzFO8WLPzfrxke8aBHF4DfiP6KhS10EYT2mba+rW1XG4I1HJh2I24
         brDnw4kI0z4LTILh6XH7vWesiQp743CrxGoZReh4/HxTqH5lknNcuMVspPISPmjYUEjn
         KgPWlm64TVND8K+xqB0dn/R/pRhV9+HqrOwAXIsh/IdofY1NuzzthuxIMjSEXbxsoICt
         N5RQ5amY0l1TmbpkQzpc3jkIJP3pgd7gmZymGqlc6tsA550OPr8BbROyygScOzQcungk
         I/bA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769449386; x=1770054186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buGfk5/1aHFZlIIMOertm0h+v4ooWBsjxJ1vRzpNYwo=;
        b=B51EwUA6Vmu4RIEZ7hQonAMTKUfBc07lmiAOUa91ij8q4It9iuOQwLmu+bY+xRfWB9
         DOnBLcrL163/DTPPzAQMHRVCVBxdOaaTQGLohr6qnmFT8JXEnZ9TlWbcslhUpzKYRvqy
         88DviBcjigF614jR1jpuIV+OoUn/g9aBQfJjeXZCZ8o5DrGl6UC4T6VXw4nnJd/ly+iU
         rTT+mU5vAvg+uH/aDtGnNg41DIl6+/nFHsC0Zaqwl4QyX/0uDhtQLPsdnG0O4A8kbuMm
         o59g13JGaeUhy2hP8wAEmZaoCacMk8MaxPRH/Y6xGo41EDcsnAmf/oEIPww7N501kMeK
         ZWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769449386; x=1770054186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=buGfk5/1aHFZlIIMOertm0h+v4ooWBsjxJ1vRzpNYwo=;
        b=JN0AWoWZL0d9pBoy/g5rKM5IVa4ZgTjZTBb/q4t1gXQVhCgsV01pZMQubbdNjzbHwF
         Poecsjw9M5l4CVXGtJgAOuFZn8fRnYtWH5M3I+VmT8cmLYsEerZeU6rUj/mbTRGkXcme
         Z9A64iTWf/ZRXFhPc0LHt0G5eJtdbC7mUIzoNx8GaaHDR+vVF69g1a6hGqIJJUzc10CZ
         +cTYUhj5dfgOWrdxG8PdG6CVT0I7K8iH6yNcptq5OaCFbCh8LakuOFAk6r4RB3DWO8MN
         5T/1E6HY1iWzwxy3szb5N50lYnmb4Ua0WJpt7m4UWK/aQajk4NjoY6tY0+FuHiyrWYmN
         cSMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFzHIbW+ykuVVeSiNuTu6+zVTTAKlCvWjNqI0oy2mB9yj6jgB8nKeLDrZAqZC3rQJMCZrTVOSM0cw+EDrLWU4l@vger.kernel.org
X-Gm-Message-State: AOJu0YzBQk+ADUsxJpD3agpklCjG8CD1+Xdh+NhK/l1v/xryydqmP9Xb
	9t2e78AHYuJCVdApF5Uw8yYDKMmyx+AEsAwJYROsNTi5HNPDiZG+TCCWPGqs25CoCxskf+ff2z8
	BI+8eSZm4G0SZlW1wN0BWE0nHh5ln0P9k2bCGZA+d
X-Gm-Gg: AZuq6aKIzcHOOlzUSQEGkfPW6BXiWdVDn/xLgAs0Ik1gbYhoK3lnIgAZfqF7wb6rpTq
	5gMw7cAZgeWfnM/heYHx9fwvYEeDalnNi8SkF4FOk9GpdKf9ed0IBGroSD/DCOhY8QtsBTfR2IL
	Lx7Jpk5Hc+d0ZsEVLW6L37CK7qrHSuv1ZA86DGOJHkNDqi5OlA3TrxlxjFQ1riycNFIbL1VqjEN
	96Etrn+skq/s8qWhWVzWAHGJP+6VvwJrjQts4o9sl9rQ83wLYkTeonqlucqdxIrADTI3MFohnrt
	VDXJlv+8Fqifje9X4hIqfY3tVg==
X-Received: by 2002:a17:903:249:b0:2a7:87c2:fcde with SMTP id
 d9443c01a7336-2a844e940f6mr1999015ad.15.1769449385360; Mon, 26 Jan 2026
 09:43:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126101823.2090077-1-tmricht@linux.ibm.com>
In-Reply-To: <20260126101823.2090077-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 26 Jan 2026 09:42:54 -0800
X-Gm-Features: AZwV_QhnBtYvUOa0-W3O55v68ICGZGXde2Tro63ayWgS4vBkaOy5iMUVh04ueaw
Message-ID: <CAP-5=fXPGXJMDPQc4XxrEWW_HgJTbrbL6g1xfTBn14jDiW0Yxw@mail.gmail.com>
Subject: Re: [PATCH linux-next] perf test: Fix test perf evlist for z/VM s390x
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 2:18=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Perf test case 'perf evlist tests' fails on z/VM machines on s390.
>
> The failure is causes by event cycles. This event is not available
> on virtualized machines like z/VM on s390.
> Change to software event cpu-clock to fix this.
>
>     Output before:
>       # ./perf test 78
>       79: perf evlist tests              : FAILED!
>       #
>
>     Output after:
>       # ./perf test 78
>       79: perf evlist tests              : Ok
>       #
>
> Fixes: b04d2b919912 ("perf test: Fix test case perf evlist tests for s390=
x")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Tested-by: Jan Polensky <japo@linux.ibm.com>
> Reviewed-by: Jan Polensky <japo@linux.ibm.com>
> Cc: Ian Rogers <irogers@google.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/tests/shell/evlist.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/shell/evlist.sh b/tools/perf/tests/shell/ev=
list.sh
> index 5632be391710..8a22f4171c07 100755
> --- a/tools/perf/tests/shell/evlist.sh
> +++ b/tools/perf/tests/shell/evlist.sh
> @@ -21,13 +21,13 @@ trap trap_cleanup EXIT TERM INT
>
>  test_evlist_simple() {
>         echo "Simple evlist test"
> -       if ! perf record -e cycles -o "${perfdata}" true 2> /dev/null
> +       if ! perf record -e cpu-clock -o "${perfdata}" true 2> /dev/null
>         then
>                 echo "Simple evlist [Failed record]"
>                 err=3D1
>                 return
>         fi
> -       if ! perf evlist -i "${perfdata}" | grep -q "cycles"
> +       if ! perf evlist -i "${perfdata}" | grep -q "cpu-clock"
>         then
>                 echo "Simple evlist [Failed to list event]"
>                 err=3D1
> --
> 2.52.0
>
