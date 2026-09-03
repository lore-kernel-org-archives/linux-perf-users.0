Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27D036C0CD
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459438; cv=pass; b=FD/5gNbT7Ev69r0vMSW/89ACVtg8NoorrjwgY73cxl0SdGbrqu4bCgjNRMq1Wn2jkinxCdW/5vVZESX3XjEFDWZgDanMT/KRxQaW8bCH0FwDb8wRD6sgxUCGFyIhtj0ygjEso1SxD3FOpuMXZXjkDHON6bUK5x7G4wRuBdYFIWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459438; c=relaxed/simple;
	bh=uvE5b/EiDpNgiR0Kg/L+ZSuEvfLCiq/r/YNySx3RI8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PaMjeCU6EMuGkqamyEM34lwkf9UkYCQk1NWosSxtZ00Ey7aPFK2gC+pe+RE5gKwGG4lO7CXjHHv8VWKPZpnAFbXlY5Oi1hT7BfZb1iyzQTNXxoY9wo+CSAI2Om4gM0D+psMcTXXi8zeQndWcinU5o9COR+HG7iAObnz9Tqe4gLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=glfB8ogb; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="glfB8ogb"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52e843c64b8so340771cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Sep 2026 11:17:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788459435; cv=none;
        d=google.com; s=arc-20260327;
        b=IMJd6BOfiI+IIxsx12iHszZdY0I9Mc9gJBNONLvTr7Ao7N19S9PwVikUOGZpM1ujfJ
         huQZ33FqThfnALEJ9IKlO1UzpvuEF1Cxq1QuVbUh+Tgd/A3CPaR1tQMG/cvc+YfG/shO
         89HlLMgNq7szlmFOylCd9QxzcfDQAKcU6zs7IwhFqZhp6DJFVW/yq5zrWj3sOr3m3a9w
         P4ypC0ne2fog2pKXPOung614EbkKFQi5qKyXUVfSKbZH45OWg3RF/Sw4GJ3JtPoxaVjK
         GWNOD9E43QvVFfV+4Z0GSwJyCFIllEPWBD8cQiWyN5EmDD2ou6ubVday1oKokxYqMb61
         s05g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TYPdkHe//ABCrrcrY9PNffZ5lOpN9WmoX92PzRYdpRw=;
        fh=iMWCxSmn53aoPstoFoiumESac1H9tXlfb1q1dJF1fUc=;
        b=V5nAcKmn6+FrWRunTqQ4B/t2NbsZ251ZAfrRHRwujaAS0l9bd+O8Nbp5G0XIcL8vf3
         yOw7Ug9f95eeRZeJCxMq1kbClkg5DnUPV06Bcrs1BSxXGrytMd0oxfsaBjdQBH/m51VR
         PXy7QuNPCrirHIfwYgF1JahOdAsjy1nwvfRR3VkzrneSel5IsZngNyk3QI1tf/oeKn+3
         laPAYJwiNwuXxqODkDfhzp8gSY6NbTyylH+806Xmt4Ywfzzqkbi16+6aYOCGo3Cdxnl8
         IsSTpa4k4SOey63ubkJXM0A5DblDL9NlG4wdtK9kU9KJkr5biqwTPWMAjYJYjaykPYnL
         aybg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788459435; x=1789064235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TYPdkHe//ABCrrcrY9PNffZ5lOpN9WmoX92PzRYdpRw=;
        b=glfB8ogbiW1UrHVbhgTdWbl9g9W8SsJkTDLlIYtNd+PHpONFgsxqjg3QM9pLw5fQ1E
         cnAh5pjiwnHczQYIqu17zcG17LEGdwvdc79aoYHYzP9pqjCwO97co8JpY5Ri29WQycSr
         +sKnnXjHT10V/cF0xC3ROJwlN7gwC4XVFnVGtoa5j0NBFUKURTazcMWX0Y8CLs+wRurO
         5FJ2kC0bfaHRK29KcH89652PWKUqDB4nYAwrRtm7oHota79QAe7lD+TYv32muzDpzLoU
         TAhBXQqShVtyjQr7AUVdi2g+1Thd2OjmTmEHmr4awBOiQMJhvY/6ixfIWoquRZU28jRC
         LTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788459435; x=1789064235;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TYPdkHe//ABCrrcrY9PNffZ5lOpN9WmoX92PzRYdpRw=;
        b=g/tK2lBxoSagdLfbAIpsehcSZZOhRXD/sltVeLHhPK0+jBrOPZRva/WSchxCW8Rov9
         k7ZNzaRGG4IeXTMWBkeM+yYaQrHwdMWlV7KAASciWsuOYhMiaQXE08d1EpGsQZFMbB1b
         YTFDnpvambV5y3CmQfGU2bDg+D2XRueDxesQlOSaJ0vRnRvjxFa54pnLgHXcQDBIkoRX
         lsY1hPRAIWzuy3HzJxGpVSMnBZUSoze5t+RFdHtU2DRgAPgLpF+WLR/NBEjxR6qXxhs6
         92LsH/fnF0QMW+M6amaWF5/w4DUJW5mnC+DEP8F37Hgpe56qAkHpjfymmuGv8NqAqHEV
         JaPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJzg/xIgRZC1R1J0q+22cQDUGhN9wx7Yg2XJOc/fnxFxOU6cCwsFe33ZPZU6mFU+3usFsurfjNbW/WDAUuINi2@vger.kernel.org
X-Gm-Message-State: AFuF++mBUF8bMTLbH5evtGOFqw2HY/LXnRucxJVUtHTz/bX9WdR4eZTb
	TcfxdylkX18sten+FiFQdPSZeKcy+IJJ6xxudIKBKUKp7UECdoSo/VkIBLuDvXJQaBJo7eO040k
	nRA/z+N5IstVsUoY7odnA3LHypR/kvnTi9qBi/Xji
X-Gm-Gg: AYBFou3Ym4eWGERYvUYY+yzjA/ltrcW5jSWWQRqdwZunnCI4CACOx7G9mFoo9KMiHBw
	oyBjeqFdMmlUYfAToNx4rUXEpDtZzBk+KJPxalVLaQ9cFZQKz0G4UZF8mrdALFGtKRQ8dHSJ41m
	qc9BGEoO6wBdUcGAXv79uc69vLeX0rNrmjogQviSnanAh5Sy4ixONFUMnEvZZNhHw+oIFwQIlaE
	jQZoCcq0JHMDHsGo2X8WQPSwmFA6NdvCq5xCsoIhRVIb6bysK3xrfEI8sLVFSaXrbc/DrpOw6fm
	Y1NGL+XSSGVytFuNqgOZcTr/atZUxKk6yOmGo5bFwIxPZZ3h5mxG/4o/MGb75n9LoBqzt9FEbGM
	=
X-Received: by 2002:ac8:5992:0:b0:52f:4a75:f840 with SMTP id
 d75a77b69052e-53055567dccmr83931cf.9.1788459433648; Thu, 03 Sep 2026 11:17:13
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903073554.1300334-1-tmricht@linux.ibm.com>
In-Reply-To: <20260903073554.1300334-1-tmricht@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 3 Sep 2026 11:17:01 -0700
X-Gm-Features: AcwNN1Wj7onVlAWq82ttAz6rRWHfVF4Ef3_xa9bxcnd8LJ60UxXFqlzVG2puzko
Message-ID: <CAP-5=fUtW=EfB5SOt8iCSsyt4pg_2NhoWvTr=Qf5vEKU5CwZRA@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: perf stat tests fails on s390
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, iii@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com, Aaron Tomlin <atomlin@atomlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 12:36=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> The test case 'perf stat tests' fails on s390 z/VM machines. The
> root cause is the unsupported CPU measurement facility on z/VM.
> Therefore the events cycles and instructions do not exist and
> are unsupported. This cause the subtest
>   Hide zero events stat test
> to fail.
>
> Output before:
>  # perf test 116
>  116: perf stat tests  : FAILED!
>
>  =3D=3D=3D Test Summary =3D=3D=3D
>  Passed main tests : 0
>  Passed subtests   : 0
>  Skipped tests     : 0
>  Failed tests      : 1
>  List of failed tests:
>   116: perf stat tests
>  #
>
> Output after:
>  # ./perf test 116
>  116: perf stat tests  : Ok
>
>  =3D=3D=3D Test Summary =3D=3D=3D
>  Passed main tests : 1
>  Passed subtests   : 0
>  Skipped tests     : 0
>  Failed tests      : 0
>  #
>
> Fixes: 64724095a33f ("perf stat: Add --hide-zero-events option to suppres=
s zero-count events")
> Cc: Aaron Tomlin <atomlin@atomlin.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/stat.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat=
.sh
> index 298ce454b45a..1f5d4cc05807 100755
> --- a/tools/perf/tests/shell/stat.sh
> +++ b/tools/perf/tests/shell/stat.sh
> @@ -583,6 +583,11 @@ test_hide_zero_events_stat() {
>    # Check that --metric-only works with --hide-zero-events
>    if ! perf stat --hide-zero-events --metric-only -e instructions,cycles=
 true > "${stat_output}" 2>&1
>    then
> +    if grep -sq 'No supported events found' "${stat_output}"
> +    then
> +      echo "Hide zero events stat test [Skipped - events not supported]"
> +      return
> +    fi
>      echo "Hide zero events stat test [Failed - metric-only command faile=
d]"
>      err=3D1
>      return
> --
> 2.55.0
>
