Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FE830F52D
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 17:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761326485; cv=none; b=a1HB6rMP8o+PXHsJklTZlMdRnreXBf02l4vWArtYnTW1Ymeqj/8SXa/pX7FWDLMkOFJlr8DMKEpQDTbBUa7Ml2gcJ6JmJQWtcxXUF3I7OkiiHzXcdNxDGuUbiB6YPcIp1XQMx1ANEMLpX1AFaFRf8cXxtxc3+B11YhXS+F3N4y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761326485; c=relaxed/simple;
	bh=wDo0H1pOd7pyMs1PSc7DacG7oWEgK7FXoIq1tvZOPeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwAvDO1B5vxlFyjgOZJkR/R17X0Y2F20b1emstjH4l6beZynzBxZq0hyfHjM1U+d23yGqHeZQ6mXn81tACIBnSB+KsoXbmNZ6EH5H4EWXRlmqkbIssWc+25xRkYKhOjYPLsQKVnoFZzxremesYW+UZ0+LfPgl+C/cd8z/oOLCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCwtOnj3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCwtOnj3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761326482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nIYBTWAmoHrBgeo59+/76sWXW0Tfht4GLSBzlyT5i/A=;
	b=fCwtOnj3sfj1/a+xP+1ptSG4SB6mfhsH/elohwCl4ilNgGTTcISdQrkT95kdd6J7FhhSjT
	sxjIMQeH/SU03BV8jWisQiW1524AZYWJ/FlU2mcLLUSB11/EAv1QKDXg95XW817iyOMEUH
	FoXqL7j+bPPymBJVLMvfKkAqIaAfF0U=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-um5Q5TlTPM2BhXamCjRI1w-1; Fri, 24 Oct 2025 13:21:20 -0400
X-MC-Unique: um5Q5TlTPM2BhXamCjRI1w-1
X-Mimecast-MFC-AGG-ID: um5Q5TlTPM2BhXamCjRI1w_1761326479
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-378dd2050b9so11699471fa.2
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 10:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761326479; x=1761931279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIYBTWAmoHrBgeo59+/76sWXW0Tfht4GLSBzlyT5i/A=;
        b=eDeEa97VroDqvjZO1H4H3ooB1/k6UiYmtIT0PoUt97HnvnHJfm2badlbGV2BrG8E9l
         xkjmgMTwQxlbFS29B2W9MT0IQngQBWlJHDNpZP9K+uyNVS6Ph+wwSpURPHnAk8Y2/t67
         8XROM2xljU0UJKP0eonXWFtNMWTI0ma1TMbjU5RAq0N2MiucezLpPYJZAM028ipp/RGU
         cs28QAZA3zI6Ir1glRQlmlodwWzOUltkJ/oOJ1HZES5dZxH/yDSdb2RLZDI6NEifLKv2
         hIS0VwkPFxA8cpgZQwLk55HSmT8P6NbOeecNggnHwWHoFlgPTmRMQT7TlHD4CczFEWJF
         sVFw==
X-Forwarded-Encrypted: i=1; AJvYcCVcroKVPkta//TDDNM6KkLX+Uz09f8wdjkeIff7QdC3erT73oIIFJJW/2Stqu5WprKVeNn4f/SkGkb3R42ONnji@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf6PVW5arKJnV0guKRkb9tM3eIy2ZbLeIXGKqVEBItQDCvqITX
	Glh+1VJhTUqJntSHUBohiRvB2EXoUFGFrwl6jFgYSkJiZIjChoCksVTHDy+KEtx46dMtJklLr6e
	Yvbpa34UMHsb1po+pQAS0SfZ4mtiHEMewr3Rgl1gx650S/9U0cKtaOz6uktxGhUzY7kA0FR3A2G
	EDxbIDGwOcwh89VWqF3jtsYq6BphJAGhdmwNHbnRQ5Dqk57w==
X-Gm-Gg: ASbGncuC2iyA0P/0AE3YpJuj7xtgw4P41V4fj9TY22Goa074rYGIwua+t57ca5/lsZk
	GESRZXgrA7M7kJcjHvUZIJJvMcuP1rkkPsB8r+Hs6nEovEwtVnTT5uiDRIurdSTmFmNF/mOvjuB
	Txc7rSNew81UFAJ+GG2usaEQwpigVJH33SZvSkmlPAH7/x2pPxtYXaiRc=
X-Received: by 2002:a2e:bcd1:0:b0:36a:a8bb:9b9a with SMTP id 38308e7fff4ca-378e4162236mr11502871fa.0.1761326478690;
        Fri, 24 Oct 2025 10:21:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGXISwzvZ/DsySRseKkQcC0UE8bAautLr+I9rS/dWAuyPBHZaY977hT5OrBFa3h0oGKRJbQp6GxgcPB5eSzJI=
X-Received: by 2002:a2e:bcd1:0:b0:36a:a8bb:9b9a with SMTP id
 38308e7fff4ca-378e4162236mr11502711fa.0.1761326478184; Fri, 24 Oct 2025
 10:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023132406.78359-2-ashelat@redhat.com> <5b02372a-f0be-4d3a-a875-c5ea65f2bafe@linux.ibm.com>
In-Reply-To: <5b02372a-f0be-4d3a-a875-c5ea65f2bafe@linux.ibm.com>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Fri, 24 Oct 2025 18:21:06 +0100
X-Gm-Features: AS18NWBHegFU3J-b1B1Qcb9u9LpbOnqpm3OGMMaRqBdyFWtd4MeIHGlfmQwsn30
Message-ID: <CA+G8Dh+DaVp1XVHm=Hh1aLP=5YOmChTRu4=nSUAwTKJO-a4LDw@mail.gmail.com>
Subject: Re: [PATCH] Revert "perf test: Allow tolerance for leader sampling test"
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	irogers@google.com, linux-perf-users@vger.kernel.org, peterz@infradead.org, 
	mingo@redhat.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The issue on arm is similar. Failing about half the time, with 1
failing case. So maybe the same issue on arm.

Anubhav

On Fri, Oct 24, 2025 at 9:40=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On 10/23/25 15:24, Anubhav Shelat wrote:
> > This reverts commit 1c5721ca89a1c8ae71082d3a102b39fd1ec0a205.
> >
> > The throttling bug has been fixed in 9734e25fbf5a perf: Fix the throttl=
e
> > logic for a group. So this commit can be reverted.
> >
> > Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> > ---
> >  tools/perf/tests/shell/record.sh | 33 ++++++--------------------------
> >  1 file changed, 6 insertions(+), 27 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/=
record.sh
> > index 0f5841c479e7..13e0d6ef66c9 100755
> > --- a/tools/perf/tests/shell/record.sh
> > +++ b/tools/perf/tests/shell/record.sh
> > @@ -267,43 +267,22 @@ test_leader_sampling() {
> >      err=3D1
> >      return
> >    fi
> > -  perf script -i "${perfdata}" | grep brstack > $script_output
> > -  # Check if the two instruction counts are equal in each record.
> > -  # However, the throttling code doesn't consider event grouping. Duri=
ng throttling, only the
> > -  # leader is stopped, causing the slave's counts significantly higher=
. To temporarily solve this,
> > -  # let's set the tolerance rate to 80%.
> > -  # TODO: Revert the code for tolerance once the throttling mechanism =
is fixed.
> >    index=3D0
> > -  valid_counts=3D0
> > -  invalid_counts=3D0
> > -  tolerance_rate=3D0.8
> > +  perf script -i "${perfdata}" | grep brstack > "${script_output}"
> >    while IFS=3D read -r line
> >    do
> > +    # Check if the two instruction counts are equal in each record
> >      cycles=3D$(echo $line | awk '{for(i=3D1;i<=3DNF;i++) if($i=3D=3D"c=
ycles:") print $(i-1)}')
> >      if [ $(($index%2)) -ne 0 ] && [ ${cycles}x !=3D ${prev_cycles}x ]
> >      then
> > -      invalid_counts=3D$(($invalid_counts+1))
> > -    else
> > -      valid_counts=3D$(($valid_counts+1))
> > +      echo "Leader sampling [Failed inconsistent cycles count]"
> > +      err=3D1
> > +      return
> >      fi
> >      index=3D$(($index+1))
> >      prev_cycles=3D$cycles
> >    done < "${script_output}"
> > -  total_counts=3D$(bc <<< "$invalid_counts+$valid_counts")
> > -  if (( $(bc <<< "$total_counts <=3D 0") ))
> > -  then
> > -    echo "Leader sampling [No sample generated]"
> > -    err=3D1
> > -    return
> > -  fi
> > -  isok=3D$(bc <<< "scale=3D2; if (($invalid_counts/$total_counts) < (1=
-$tolerance_rate)) { 0 } else { 1 };")
> > -  if [ $isok -eq 1 ]
> > -  then
> > -     echo "Leader sampling [Failed inconsistent cycles count]"
> > -     err=3D1
> > -  else
> > -    echo "Basic leader sampling test [Success]"
> > -  fi
> > +  echo "Basic leader sampling test [Success]"
> >  }
> >
> >  test_topdown_leader_sampling() {
>
> I disagree here. Reverting this patch cause the test case to fail very of=
ten on s390.
> The test fails about every 2nd run, because the is one run-away value out=
 of many.
> Here is an example:
>
> # ./perf record -e "{cycles,cycles}:Su" -- perf test -w brstack
> [ perf record: Woken up 2 times to write data ]
> [ perf record: Captured and wrote 0.015 MB perf.data (74 samples) ]
> [root@b83lp65 perf]# perf script | grep brstack
>             perf  136408 340637.903395:    1377000 cycles:           1171=
606 brstack_foo+0x1e (/root/linux/tools/perf/perf)
>             perf  136408 340637.903396:    1377000 cycles:           1171=
664 brstack_bench+0x24 (/root/linux/tools/perf/perf)
>             perf  136408 340637.903396:    1377000 cycles:           1171=
6d4 brstack_bench+0x94 (/root/linux/tools/perf/perf)
>             perf  136408 340637.903397:    1377000 cycles:           1171=
6d4 brstack_bench+0x94 (/root/linux/tools/perf/perf)
>             perf  136408 340637.903398:    1377000 cycles:           1171=
6e8 brstack_bench+0xa8 (/root/linux/tools/perf/perf)
>             perf  136408 340637.903398:    1377000 cycles:           1171=
606 brstack_foo+0x1e (/root/linux/tools/perf/perf)
>             perf  136408 340637.903399:    1377000 cycles:           1171=
5cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>             perf  136408 340637.910844:    1377000 cycles:           1171=
6e4 brstack_bench+0xa4 (/root/linux/tools/perf/perf)
>             perf  136408 340637.910844:   39843371 cycles:           1171=
6e4 brstack_bench+0xa4 (/root/linux/tools/perf/perf)
>             perf  136408 340637.910845:    1377000 cycles:           1171=
632 brstack_foo+0x4a (/root/linux/tools/perf/perf)
>             perf  136408 340637.910846:    1377000 cycles:           1171=
692 brstack_bench+0x52 (/root/linux/tools/perf/perf)
>             perf  136408 340637.910847:    1377000 cycles:           1171=
6ee brstack_bench+0xae (/root/linux/tools/perf/perf)
>             perf  136408 340637.910847:    1377000 cycles:           1171=
5cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>             perf  136408 340637.910848:    1377000 cycles:           1171=
598 brstack_bar+0x0 (/root/linux/tools/perf/perf)
>             perf  136408 340637.910848:    1377000 cycles:           1171=
5e8 brstack_foo+0x0 (/root/linux/tools/perf/perf)
>             perf  136408 340637.910849:    1377000 cycles:           1171=
7ae brstack+0x86 (/root/linux/tools/perf/perf)
>             perf  136408 340637.910850:    1377000 cycles:           1171=
5cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>             perf  136408 340637.910850:    1377000 cycles:           1171=
6ee brstack_bench+0xae (/root/linux/tools/perf/perf)
>             perf  136408 340637.910851:    1377000 cycles:           1171=
6ee brstack_bench+0xae (/root/linux/tools/perf/perf)
>             perf  136408 340637.910851:    1377000 cycles:           1171=
59e brstack_bar+0x6 (/root/linux/tools/perf/perf)
>             perf  136408 340637.910852:    1377000 cycles:           1171=
598 brstack_bar+0x0 (/root/linux/tools/perf/perf)
>             perf  136408 340637.910853:    1377000 cycles:           1171=
79e brstack+0x76 (/root/linux/tools/perf/perf)
>             perf  136408 340637.910853:    1377000 cycles:           1171=
606 brstack_foo+0x1e (/root/linux/tools/perf/perf)
>             perf  136408 340637.910854:    1377000 cycles:           1171=
6d4 brstack_bench+0x94 (/root/linux/tools/perf/perf)
>             perf  136408 340637.910855:    1377000 cycles:           1171=
612 brstack_foo+0x2a (/root/linux/tools/perf/perf)
>             perf  136408 340637.910855:    1377000 cycles:           1171=
5cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>             perf  136408 340637.910856:    1377000 cycles:           1171=
598 brstack_bar+0x0 (/root/linux/tools/perf/perf)
>             perf  136408 340637.910856:    1377000 cycles:           1171=
5cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>             perf  136408 340637.910857:    1377000 cycles:           1171=
632 brstack_foo+0x4a (/root/linux/tools/perf/perf)
> .... many more lines with identical cycles value.
>
> I have contacted our hardware/firmware team, but have not gotten a respon=
se back.
> I still think this has to do with s390 LPAR running under hyperviser cont=
rol and I do not know what
> happens when the hipervisor kicks in.
>
> I agree with James Clark that this should be handled transperently by the=
 hipervisor, that means
> stopping the LPAR should stop the CPU measurement unit, before giving con=
trol to a different lpar.
>
> But what happens when the hipervisor just kicks in and returns to the sam=
e LPAR again? Or does
> some admin work on behalf of this LPAR. As long as I can not answer this =
question, I would like
> to keep some ratio to handle run-away values.
>
> As said before, this happens in roughly 50% of the runs...
>
> Here is a run where the test succeeds without a run-away value:
>
> # ./perf record -e "{cycles,cycles}:Su" -- perf test -w brstack
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.015 MB perf.data (70 samples) ]
> # perf script | grep brstack
>             perf  136455 341212.430466:    1377000 cycles:           1171=
59e brstack_bar+0x6 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430467:    1377000 cycles:           1171=
5cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430468:    1377000 cycles:           1171=
612 brstack_foo+0x2a (/root/linux/tools/perf/perf)
>             perf  136455 341212.430468:    1377000 cycles:           1171=
656 brstack_bench+0x16 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430469:    1377000 cycles:           1171=
6ee brstack_bench+0xae (/root/linux/tools/perf/perf)
>             perf  136455 341212.430469:    1377000 cycles:           1171=
5cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430470:    1377000 cycles:           1171=
5e8 brstack_foo+0x0 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430471:    1377000 cycles:           1171=
6c6 brstack_bench+0x86 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430471:    1377000 cycles:           1171=
622 brstack_foo+0x3a (/root/linux/tools/perf/perf)
>             perf  136455 341212.430472:    1377000 cycles:           1171=
5cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430472:    1377000 cycles:           1171=
692 brstack_bench+0x52 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430473:    1377000 cycles:           1171=
70c brstack_bench+0xcc (/root/linux/tools/perf/perf)
>             perf  136455 341212.430474:    1377000 cycles:           1171=
6e4 brstack_bench+0xa4 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430474:    1377000 cycles:           1171=
69a brstack_bench+0x5a (/root/linux/tools/perf/perf)
>             perf  136455 341212.430475:    1377000 cycles:           1171=
5cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430475:    1377000 cycles:           1171=
5cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430476:    1377000 cycles:           1171=
6e4 brstack_bench+0xa4 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430476:    1377000 cycles:           1171=
5cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430477:    1377000 cycles:           1171=
5e8 brstack_foo+0x0 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430478:    1377000 cycles:           1171=
70c brstack_bench+0xcc (/root/linux/tools/perf/perf)
>             perf  136455 341212.430478:    1377000 cycles:           1171=
70c brstack_bench+0xcc (/root/linux/tools/perf/perf)
>             perf  136455 341212.430479:    1377000 cycles:           1171=
6ee brstack_bench+0xae (/root/linux/tools/perf/perf)
>             perf  136455 341212.430479:    1377000 cycles:           1171=
598 brstack_bar+0x0 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430480:    1377000 cycles:           1171=
5cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430481:    1377000 cycles:           1171=
5fc brstack_foo+0x14 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430481:    1377000 cycles:           1171=
5cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430482:    1377000 cycles:           1171=
6ee brstack_bench+0xae (/root/linux/tools/perf/perf)
>             perf  136455 341212.430482:    1377000 cycles:           1171=
664 brstack_bench+0x24 (/root/linux/tools/perf/perf)
>             perf  136455 341212.430483:    1377000 cycles:           1171=
70c brstack_bench+0xcc (/root/linux/tools/perf/perf)
>             perf  136455 341212.430484:    1377000 cycles:           1171=
70c brstack_bench+0xcc (/root/linux/tools/perf/perf)
>             perf  136455 341212.430484:    1377000 cycles:           1171=
5cc brstack_bar+0x34 (/root/linux/tools/perf/perf)
> #
>
> So please let this code in otherwise we need an s390 specific check for s=
uccess.
>
> Thanks a lot
> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> IBM Deutschland Research & Development GmbH
>
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
>
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
>

