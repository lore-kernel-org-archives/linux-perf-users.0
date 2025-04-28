Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984AB1FFC45
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Apr 2025 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745837158; cv=none; b=VgdGRXL9DQCXAM5UJ9Doi3Cr+XbUvVUvfSHu/w0lvCQ516r+PCmMbTUnJ5xJfz0Co7DZuLsEmrhaIql/so2fAl5ru7edSQle2fFQ7KBw8QWT5OPAZY6His/kKFylxCN3OfpszBdCEmQDHylGUO2TwLf4JXhOSILTtKElvxzEk18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745837158; c=relaxed/simple;
	bh=BfVpXOtVnMCA2Chp0FBzrJVBMyu2X/fGknG6KW71f5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6DK3xjOg2heT2Nl7KzIP/G8+mb6Ru48TBeKNKXdmURuqZpGngcMDidrYxu9C3HT8lwtsBrfacWmS6l3u458t7eRwz5XIBrp9RCp/1giZtS2d66A1XASR1SWldFpj+Hs73Of8ImuaUImHiNNj4rLkQ4o1admi1o0GAgxjmCWhmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JAtqmGmO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAtqmGmO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745837155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMYe0308IK+Yd7YE4lCtC/FPVv4+EuXG93+Si0fR0Go=;
	b=JAtqmGmOYE0UtDpXQrUntlmE7htvrkn2ojdBmxHqHPIRM3Q7OSCbD0BBUeHmjVAmLL9TEm
	7piSdDzXBb1bTpKuCK6tbsAiKALAnKAesnyXqf/e78JU0J9m9g4cTH/tMIhY2vI8gotm1+
	DYlrH/I9NY3XQzycK/9/BkGhhCZ5GwI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-DHjqeBHKNSqkVIGlK4iH1w-1; Mon, 28 Apr 2025 06:45:54 -0400
X-MC-Unique: DHjqeBHKNSqkVIGlK4iH1w-1
X-Mimecast-MFC-AGG-ID: DHjqeBHKNSqkVIGlK4iH1w_1745837153
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-acb5a03afdcso378052266b.3
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Apr 2025 03:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745837153; x=1746441953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMYe0308IK+Yd7YE4lCtC/FPVv4+EuXG93+Si0fR0Go=;
        b=cEZg6vwmGxQMSkqqBiFU5PXKycjinaTnvojNtzbMs4+Eu9XPKziMSZp7Cs9eeWKxJJ
         k+JEJC+cRMzT6SR3LzFHJnumCHU1l2BjHF2FrNx+pfsFEncbH0yJ1Z1XfxnD6e0lLnhX
         gwyOBwRiBHYhF+w0DIeYkZ5zMAbio3lm+cP6ANW0DuDpSyjsf6A0wLI3VMPrgKHp9I5b
         nzHquXFJ/X9MdBOYkm1c9hKCUBxtsbtCHsWVhpugVa+gZGBjxkZ3ejdIqhIlXPx7zyLx
         rigM/kyL93I0a5gSHRVifdBtSG7071KbumLAEiMelik9mJ6bC/02C6ziNuh0j49wTHtn
         Z2pg==
X-Forwarded-Encrypted: i=1; AJvYcCXGTooA1I0PuNkCgb+uRvATatxk1ffvy6IzikgWiN5NuhIHngI3HweeeT04N1HtfI7Cw+R7iey6kV9G5+2vm+fn@vger.kernel.org
X-Gm-Message-State: AOJu0YwHqhG09xb7R6pqlb400w6Hx83tMbj+7ALMlnNtYkZRqP1GNzqT
	g1a6ScnyUw3zMoOQHt0ldQ5YLCRdGB5nxhsNnjYk2PdPfP51ONBGPsWX4dcgzhyBL1t+04gyuKi
	6xjH7gVguZ/ZXqiUHcCFS46zgXTyzCcs6fh58RgLAvQ5i2wG7iMQHWuoso7ZJv4fL1DSmTTMZju
	uppTtS8iEi0OO68Q8M5hvMzOZ7wIMEVF7Cci88hRIc8A==
X-Gm-Gg: ASbGncspFuL2AalkVY4REqdy6ur4BimB9tYcxcvelXt5TE4JlWF6YDcGW+xnkPQyiCj
	YfsGKZf0dQOzamlMkL8RAuq7ZXnKgjuuAdEfRCK+8KLyE4+NHWtrIPAyKK/MZoBfVTffI539EMf
	d8Xqk2j/CSqluvo4pDxrq+084=
X-Received: by 2002:a17:906:8f8a:b0:aca:cda9:3170 with SMTP id a640c23a62f3a-ace7136c8f9mr986991566b.46.1745837152849;
        Mon, 28 Apr 2025 03:45:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6CEEM3fpiFA011WKHygpJfI3qalmbUpfmLQ7ejG9VQsEf2vkIAuhZX4wTtg8RGsfQV/bqCOwSsENmQ/n/X8U=
X-Received: by 2002:a17:906:8f8a:b0:aca:cda9:3170 with SMTP id
 a640c23a62f3a-ace7136c8f9mr986989266b.46.1745837152471; Mon, 28 Apr 2025
 03:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP4=nvTab7BnT4uu0iCuFJpZ-_MdY-MYU+Q25QnpygEZKmsQ8A@mail.gmail.com>
 <20250428101234.GB551819@e132581.arm.com>
In-Reply-To: <20250428101234.GB551819@e132581.arm.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 28 Apr 2025 12:45:41 +0200
X-Gm-Features: ATxdqUE6obWzOYhFcES93UpT9dGSANioAhesV3WAj6nlEAJMjJZ5qYwh3vl3kp0
Message-ID: <CAP4=nvQ_7oS5ZAsKmOd_ORg0tyHS=B+i2m63K=TLg22rTEiRGQ@mail.gmail.com>
Subject: Re: [BUG] perf segfaults when combining --overwrite and intel_pt event
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Wander Costa <wcosta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 28. 4. 2025 v 12:22 odes=C3=ADlatel Leo Yan <leo.yan@arm.com> napsal:
>
> Hi Tomas,
>

Hi Leo,

> I would like to suggest a fix blow.  For overwrite mode, we need a
> fixup to remap the user page with write permission.
>
> Could you confirm if works at you side?
>

Thank you for looking at this. The initial segfault on writing to
read-only page is fixed, however, perf now segfaults in a different
place:

(gdb) r
Starting program: /home/tglozar/dev/linux/tools/perf/perf record
--overwrite -a -e intel_pt/cyc,noretcomp/k sleep 5
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".
[Detaching after fork from child process 424037]
[New Thread 0x7ffff2df46c0 (LWP 424038)]
[ perf record: Woken up 1 times to write data ]
Thread 1 "perf" received signal SIGSEGV, Segmentation fault.
intel_pt_info_fill (itr=3D0x7a1e40, session=3D0x794ef0,
auxtrace_info=3D0x7cdfd0, priv_size=3D144) at arch/x86/util/intel-pt.c:361
361             pc =3D session->evlist->mmap[0].core.base;
(gdb) bt
#0  intel_pt_info_fill (itr=3D0x7a1e40, session=3D0x794ef0,
auxtrace_info=3D0x7cdfd0, priv_size=3D144) at arch/x86/util/intel-pt.c:361
#1  0x000000000061ce76 in auxtrace_record__info_fill (itr=3D0x7a1e40,
session=3D0x794ef0, auxtrace_info=3D0x7cdfd0, priv_size=3D144)
   at util/auxtrace.c:580
#2  0x000000000061ec48 in perf_event__synthesize_auxtrace_info
(itr=3D0x7a1e40, tool=3D0x765de0 <record>, session=3D0x794ef0,
   process=3D0x41a747 <process_synthesized_event>) at util/auxtrace.c:1320
#3  0x000000000041e869 in record__synthesize (rec=3D0x765de0 <record>,
tail=3Dtrue) at builtin-record.c:2062
#4  0x0000000000420d04 in __cmd_record (rec=3D0x765de0 <record>, argc=3D2,
argv=3D0x7fffffffe0e0) at builtin-record.c:2841
#5  0x0000000000424025 in cmd_record (argc=3D2, argv=3D0x7fffffffe0e0) at
builtin-record.c:4285
#6  0x0000000000461143 in run_builtin (p=3D0x76a260 <commands+288>,
argc=3D7, argv=3D0x7fffffffe0e0) at perf.c:351
#7  0x00000000004613b2 in handle_internal_command (argc=3D7,
argv=3D0x7fffffffe0e0) at perf.c:404
#8  0x0000000000461501 in run_argv (argcp=3D0x7fffffffdecc,
argv=3D0x7fffffffdec0) at perf.c:448
#9  0x00000000004617e7 in main (argc=3D7, argv=3D0x7fffffffe0e0) at perf.c:=
556
(gdb) p session->evlist->mmap
$2 =3D (struct mmap *) 0x0

This appears to be a different bug.

Tomas

