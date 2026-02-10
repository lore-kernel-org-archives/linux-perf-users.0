Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA2257851
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Feb 2026 05:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770701963; cv=pass; b=RuhKUc0bR6u+/gzJiWrNGHPnYmjj82EQT2opvootFrfCD+5ldtp4JaZ0hrgioZnGoC5xEMFJr8PNcOVBrk9zjpdcGpKhx4tpLDGDHeA6owU2gUbtR4WovRXUkJko4Q5c1vlbsWqVmQwACNpTs1QLeqLgaYz/aYWDSpbcWZ/Wfd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770701963; c=relaxed/simple;
	bh=OgTKhQgSD3PyNtrlWFDywPIhmzw7AzWOAu5tE5fJ1wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6EQ3XumiIkddSvD+LVLQBrAJwF346PUwFht9TYBJ87Z58lx1/mZkiBbDIrmgnI3NIVtnIenwsin9AvVt41mEUI7FvNxOlAg4qppLg9qf4JiS+jN68ItDKgLqqXNs6h7t/RAtPEgboPoc7ErBx+2HsHk/38D2MCDV6/kyOVcRP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zf7O7chU; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zf7O7chU"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aad8123335so35925ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 21:39:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770701962; cv=none;
        d=google.com; s=arc-20240605;
        b=FY6NGZXCtyGg2ZhpY1FT52ktTLbifu2iowfup4eokDLRdlu4KkMEaOE3l8GYbxK9xS
         +0yJtrVCbuYAFiBkK92JJbcz1VbedoHPAUfXzblrQNohOAx/a3mTAIuWtGW6cNLneMFU
         UsOkjjr2d8iIbT8CjWuuBAWpFAlMaSxZKydKCSecrFvIJTIkD/Q0UiXd2xA0F2LVV1a7
         y5WuDDw06a+LSdtncJk9NdyJMRq/DruZsEanQwdRxlcxEOuCOpgx2Gh1yJUGYh9cgYrl
         1HJHOIJWiUxPpbQB2RE0RNZpUIb2buqx8juPzAVcON+WoEYw+T4ugi+V7eKQd/FWHQP7
         vUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5RHHtOTmlUvwj3Tr7J1rW8KuUoWA8Sx0xYuhOSgDhPw=;
        fh=ypyVJdIx8hHyvr3Z9ijn2Td1aaigxlzW/tYlGZVp/vo=;
        b=LG7z8g1N9p0O9qTu43MBfXSsfPjQ6aFP+xFRHl7V2wky1DZcnAwo828eb4Ez5W43QP
         P9qjnlUOMAoDOv7OG/HgScv0UWwysSYS4ZtSVbUhXqhIgxfGdKX6yy4dNoboyM7O/Elk
         qkbdTo5s33d6d1kLpX2B7EPEYRZe37IlshSxVpyFw1wDz+sJ1ibS17mp4YahoyeWQBq8
         k4QBvS9/WlX0w3oYt8YEnVsJU1OyUuiZlRFeaURT+3tEgvzeLookwnXRbsEDgrir4Izc
         Hn99ik25ohRI1o5tLnzMwKmWfxND5JQrrQDjYMFsuvArp8tmiU+Dsa151cWMdb1v0TiH
         LBnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770701962; x=1771306762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RHHtOTmlUvwj3Tr7J1rW8KuUoWA8Sx0xYuhOSgDhPw=;
        b=Zf7O7chUQkitRO0Q1nclVNdvZoZOkolp3LgANkddYC2/TbdPtmgN0yEgHKQoRH1Wib
         4t3/Mw8u2RVVL/gD4gtXTZrklBvp7IwM/ZqlFanhGCTOrKkvF8lDWEEApDUqn3DuAn7e
         ZZRsG/CwnNafXiHK0Py92v3or0ozH4DmP+UnEtx9mZ08vlLpZe1VYPXQ/ZiG1WJ6Z/hq
         WEPkMOGHNMQ/CeSblHb7feqhK4K436N4HJMuCcWEVRoMb2aCp0H/izxhp4eu7iunTVm+
         z9Kavvze5VZmMt6RfjI5eymyWE0uhvpJDFL5yzfuk0jAqkm6ITe2HQpgGxoC/RyP0LQW
         SgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770701962; x=1771306762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5RHHtOTmlUvwj3Tr7J1rW8KuUoWA8Sx0xYuhOSgDhPw=;
        b=G8FfPGPvNeglRYnHRH6y9qTCQYGGdHg+GUKmRhrju/+g2WI6rTbCxSKWNYjxZbKqW0
         xjtm9FxDVnZp+xgRuXQX2flUnDiI9jDQdr6oNLciqyiKvN5O9q9g+RyqgBaF3nRKzwZ8
         cDFvsKwld5mKrTp8USeywlhUspcbmypxZaEgxro3d6OFuXI0rdCwbh+6MUEP0paIlk1Z
         y6eaFGnxgTk2phGcdm6cL7sNRnFpJCk9lwuRFoFTAVESCiRcPLdHeLmff4zPkuckM5Ao
         +mAo1bg0HS+hxzv/8iXpSwNvUiW8iwI5aw0Wo/2GZKvq4diNd6QBIRPW59LBPaCTXFg5
         FyYQ==
X-Gm-Message-State: AOJu0YzwVvuMHTYrfU1qooIHBbLEH/cKDeaxFE6NWmreF9beryn6JZFA
	L6bIMpxORiZEM50wlIgem96FXCu7Xt+JMz/tv+ssvDYV4WE5aGAB4ghEDx3g7pac49lSNpLCReh
	xVHjZcQSWJ8E/RsocGj+0MpltSU6zwQdX622y4Gow
X-Gm-Gg: AZuq6aJfiNzxInnzLWh9FYyq33+wD96cH9Zlck3PizxbsV+JPf6ied5zwwKywcV32c0
	A2lEb9LtI5DH8IZoQ7szp8EV3calCrO+qlpYN8ZWNVxIzk+WxCX/2sq0rOaQWXrBFgX0oqIWqvo
	erNH8Yyn4i2S/9dsGmGE5yxq0wdbECpQt8RgtJUXqRzPq4Ma4Plm1JeMlSdoj1365XBIjJvRzSU
	mfbNES66eKNErs+8JIHvBZNfUFwpme2CC2hKSHDBuLV4tJq8w2ixKWmHDd9oJKY8OhMXKd6Y1L9
	/xAFZvDHOP9x3ao5ck4=
X-Received: by 2002:a17:902:f545:b0:29d:7b9e:6df8 with SMTP id
 d9443c01a7336-2ab0e56d414mr2185125ad.2.1770701961135; Mon, 09 Feb 2026
 21:39:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208122227.3524-1-9erthalion6@gmail.com> <20260208122227.3524-5-9erthalion6@gmail.com>
In-Reply-To: <20260208122227.3524-5-9erthalion6@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Feb 2026 21:39:09 -0800
X-Gm-Features: AZwV_QjoLhrxooPeszhA_5rcvLJSXudWcVYOjF8r9-gtSVbBK34DzlUV9iiScoA
Message-ID: <CAP-5=fXzUOhVku6=R1d=kq6JAo-ow18VQ+qt819_VHL4drkBsw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] perf tests: Test annotate with data type
 profiling and C
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 8, 2026 at 4:23=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gmail.co=
m> wrote:
>
> Exercise the annotate command with data type profiling feature with C. Fo=
r that
> extend the existing data type profiling shell test to profile the datasym
> workload, then annotate the result expecting to see some data structures =
from
> the C code.
>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
>  tools/perf/tests/shell/data_type_profiling.sh | 31 ++++++++++++++-----
>  1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/t=
ests/shell/data_type_profiling.sh
> index cdc9adb7d70..a230f5d4c42 100755
> --- a/tools/perf/tests/shell/data_type_profiling.sh
> +++ b/tools/perf/tests/shell/data_type_profiling.sh
> @@ -6,12 +6,14 @@ set -e
>
>  # The logic below follows the same line as the annotate test, but looks =
for a
>  # data type profiling manifestation
> -testtype=3D"# data-type: struct Buf"
> +
> +# Values in testtypes and testprogs should match
> +testtypes=3D("# data-type: struct Buf" "# data-type: struct _buf")

So in the datasym workload the struct _buf is a typedef and the value
declared to be of the type of the typedef:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/workloads/datasym.c?h=3Dperf-tools-next#n14
```
typedef struct _buf {
char data1;
char reserved[55];
char data2;
} buf __attribute__((aligned(64)));

/* volatile to try to avoid the compiler seeing reserved as unused. */
static volatile buf workload_datasym_buf1 =3D {
/* to have this in the data section */
.reserved[0] =3D 1,
};
```
This test is failing for me as I see "data-type: buf" rather than
"data-type: struct _buf" (ie the typedef rather than the struct):
```
    0.00 :   201290:        movzbl  0xbb5869(%rip), %eax  # 0xdb6b00
<workload_datasym_buf1>               # data-type: buf +0 (data1)
    0.00 :   201297:        addl    $0x1, %eax
   47.66 :   20129a:        movb    %al, 0xbb5860(%rip)  # 0xdb6b00
<workload_datasym_buf1>                # data-type: buf +0 (data1)
    0.00 :   2012a0:        movzbl  0xbb5859(%rip), %eax  # 0xdb6b00
<workload_datasym_buf1>               # data-type: buf +0 (data1)
    0.00 :   2012a7:        cmpb    $0x7b, %al
    0.00 :   2012a9:        jne     0x2012bb <datasym+0x9c>
    0.00 :   2012ab:        movzbl  0xbb584e(%rip), %eax  # 0xdb6b00
<workload_datasym_buf1>               # data-type: buf +0 (data1)
    0.00 :   2012b2:        addl    $0x1, %eax
    0.25 :   2012b5:        movb    %al, 0xbb5845(%rip)  # 0xdb6b00
<workload_datasym_buf1>                # data-type: buf +0 (data1)
    0.00 :   2012bb:        movzbl  0xbb583e(%rip), %eax  # 0xdb6b00
<workload_datasym_buf1>               # data-type: buf +0 (data1)
    0.00 :   2012c2:        movzbl  0xbb586f(%rip), %edx  # 0xdb6b38
<workload_datasym_buf1+0x38>                  # data-type: buf +0x38
(data2)
    0.00 :   2012c9:        addl    %edx, %eax
   52.10 :   2012cb:        movb    %al, 0xbb5867(%rip)  # 0xdb6b38
<workload_datasym_buf1+0x38>                   # data-type: buf +0x38
(data2)
    0.00 :   2012d1:        movl    0xbc7861(%rip), %eax  # 0xdc8b38
<done>             # data-type: sig_atomic_t +0
```
It seems the typedef is a more accurate type name, so I think the test
is wrong here.

Thanks,
Ian

> +testprogs=3D("perf test -w code_with_type" "perf test -w datasym")
>
>  err=3D0
>  perfdata=3D$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  perfout=3D$(mktemp /tmp/__perf_test.perf.out.XXXXX)
> -testprog=3D"perf test -w code_with_type"
>
>  cleanup() {
>    rm -rf "${perfdata}" "${perfout}"
> @@ -29,12 +31,23 @@ trap trap_cleanup EXIT TERM INT
>
>  test_basic_annotate() {
>    mode=3D$1
> -  echo "${mode} perf annotate test"
> +  runtime=3D$2
> +
> +  echo "${mode} ${runtime} perf annotate test"
> +
> +  case "x${runtime}" in
> +    "xRust")
> +    index=3D0 ;;
> +
> +    "xC")
> +    index=3D1 ;;
> +  esac
> +
>    if [ "x${mode}" =3D=3D "xBasic" ]
>    then
> -    perf mem record -o "${perfdata}" ${testprog} 2> /dev/null
> +    perf mem record -o "${perfdata}" ${testprogs[$index]} 2> /dev/null
>    else
> -    perf mem record -o - ${testprog} 2> /dev/null > "${perfdata}"
> +    perf mem record -o - ${testprogs[$index]} 2> /dev/null > "${perfdata=
}"
>    fi
>    if [ "x$?" !=3D "x0" ]
>    then
> @@ -52,7 +65,7 @@ test_basic_annotate() {
>    fi
>
>    # check if it has the target data type
> -  if ! grep -q "${testtype}" "${perfout}"
> +  if ! grep -q "${testtypes[$index]}" "${perfout}"
>    then
>      echo "${mode} annotate [Failed: missing target data type]"
>      cat "${perfout}"
> @@ -62,8 +75,10 @@ test_basic_annotate() {
>    echo "${mode} annotate test [Success]"
>  }
>
> -test_basic_annotate Basic
> -test_basic_annotate Pipe
> +test_basic_annotate Basic Rust
> +test_basic_annotate Pipe Rust
> +test_basic_annotate Basic C
> +test_basic_annotate Pipe C
>
>  cleanup
>  exit $err
> --
> 2.52.0
>
