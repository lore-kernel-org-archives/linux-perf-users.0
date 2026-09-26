Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A751DFFB
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 22:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790462797; cv=pass; b=TDOwCVhImOpe7F8Uvmpe/9zevNjA0KO3gnozaDgwwu/jqi8rzdiwRKBDFlvKG66q84qfTVLWKpAVBupHlwh7bNeBjEubyFHc7skqvYJljdNwgBO+W6zHvUGrbTxvZPg1wVRGkdCyH3gCR0awuMqaZB88icd19QFXbQbl44Hz+3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790462797; c=relaxed/simple;
	bh=EGsHpMqvsJdko56+qOe+JPf8zXAERHfCpLuYy9xQ4Fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5/trX83173/M/liMro38KcRuQWJBxL7GXT3o4lOQQNbrDGsudJmmOAl9sK167R3WKCiLfYiGKyJBmJDlkn06j5CKem4zh5zGm1iFaSecOsAk99IkNspX4Yrs/wEnRHMVCttF4rGsP9ocTGHpDeeWjN5SsMNb8HKwUovNOlDc1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EezoyIBf; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EezoyIBf"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5333401e359so28361cf.1
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 15:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790462794; cv=none;
        d=google.com; s=arc-20260327;
        b=quoL6fDN2YPXSW3Pc+to9jmn8dhFiOa0T/Wr29IpCkwnA+nsv62hK6TEaoUoNFys21
         uoDCpjFmwykgJXlmxQ920v/p6zrMwyelsdy9sZFpOu+UaAnctUr2f3BlGypNJSL30VdR
         CnaWg9IjyzXjBlCewBDnQxWFmuWxDESqa3Cs+V55mbw40FdL92ZqEuN2QkogR5efjTXF
         6d3oyI/HaR0YOGq9qBRyUb7ED4cEBcHYmwNMLx9btbAmQP18wCiRuw7hQ0cZ59Von8vy
         ZpyCeIjc2XNlCOENIECCTEEAQiI6rJZNExMYpRL4kYXRw51iJIWD8cHyev0PzXVifCy9
         nJ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PCuo0S1OV4LTqlcYTiFFagxuS84m6WpikLQczzGr1KA=;
        fh=8ls125a2vxRrs6JcTVEhd605bmYEzTwqFhhpXhSUp5k=;
        b=MyGAKzNaACESz2ARE1kaivhV08kdPfq6qn2Ylcs8QAFg+O261rnW0rNVdTFsDAU0gg
         EImGBHQPYfebvaT7YPz1UKE8YE49J74xKXhuE8U5rjZklWpk/4o+ucHrMhnhO/H8jggg
         XmMrCoyyuNVSV4vehDxFCdvOFW3jY7nhe2x1feIIaP+T9RTD50+njwGWl3t+Rp7t+M4y
         DKOEqDGtkPdqF3m4uRAn75V7S/OXWA6YLJUg1THahTbuQcd0j5csc+Dw0nBfEiEetAfS
         +cHQk0MWatyJtoW/MLSAix+siKxbFUj0dBC/skNmxbeDUJQUKcCo2kL4fLtVKHhONrSR
         010A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790462794; x=1791067594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PCuo0S1OV4LTqlcYTiFFagxuS84m6WpikLQczzGr1KA=;
        b=EezoyIBfA4xIfoskj7bYG+kD6m4fv3Lvcd8SN5uFcFcVW+mSmw3Gv8VaytuW5aZBlH
         XwrnZXL+9cu30X55tlKQtu7ORptUSnOhRDwqSd8C9FHfhXFSg8dJlc9xo3vsmkwDExNo
         NmD+Q/elTKOT67ntKK9lwIneh9IOWBm/EuH7d3kpU++fdxSeBpw4fbwaB7rskzV+2TMT
         J9/sY3lvR5kuNlA9WHoJOXqVJm1dMGgLKqpU8sccP38e5j1OnCNf4Jf6U2JxFRWXR2uI
         JnGgHGbPIVj/McHo/ku7dZehJXy3EnmTEqfUzvbaoydoVb4S2MOhxGAYmDn1z5uCs5Qu
         2ueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790462794; x=1791067594;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PCuo0S1OV4LTqlcYTiFFagxuS84m6WpikLQczzGr1KA=;
        b=WHvLqtqz0FOM/nboEgAILTycAphQjIsZ64vNJPBbi3/xsONVVqJEMPh+0pxis0NxfP
         egke+/Bt9fqqBl3orQXICCWlDsaFP8bzlw6/mLjSXAuIKGoMuO48/diDK0vSvzftUL7e
         V5Mjz8B3TQ5GNWkwuiBCRSzNVpqeRJ5zS4CT1Kbq3jjhT7+wDJSroGiqVZ+dGoMQVK9M
         7w6SxfdQp7XImhADouQ0OgDzgHNUVPapl8WedHgYq1EhhB9GEzfS63+gdkQUW0wCovIf
         eg7tGLpxkdQ89ANvcupyZT70BIlIXwjiEjgQwvzK7XjMkiINhSey0NSv4x0lAsgrf2Ih
         m4NA==
X-Forwarded-Encrypted: i=1; AKwUvBw7AJc3BktQepUM+d1sBiszHg0HGI9hJ004HXq7SatmgIj0LojNHZGTdCkxnPO+PkdAvSC4Efu2f+YowipRRKnM@vger.kernel.org
X-Gm-Message-State: AFuF++l/QVMirj4H5kCVI3AYjmDw4eEy75vwulW1FHJUwZRiKBsS+Z3A
	1z/2yNoOy6AJG5iJguaSZBsHf/N78ywk6CSKpcvCJvYyS3Rpdcj1jf65eEhdXydupEHgsvTJxjM
	GVwB8tpLC5AzbLH+Tw8EBR19NjVTZxxQwES921B57
X-Gm-Gg: AYBFou26huYEhd5hHyL9+RZP7dTF+G9W19vMj4xAieXYDrZzEaFhqzY/mNgKKN2q9aF
	NV+g0ny6sIB4gvk8nACMb+6aA3RppyNcRQC9le1UJvnbJOZzcAoQyaQDaiN3H24+gDcn4P6d/0D
	UFxiKP/PWJNViv7bz1oPgNGEq655Z9Vtwg25YvMCpdPjy3PKACmyr0nqAZceSLJZJB18hPpOFx4
	v4bT8c9fdgkHHUGMtqCIFY0r7ak3zgfkOlEp+rm+DjPEfFh+AAL96BURXYkEq1ZRDU6xFRhaZRs
	zS5RACBMT15hNf90ccIZFJtyFRsoFjbnWAIpz1NLBZC5+MGJD9Hv8JBuDRY1sFrafA==
X-Received: by 2002:a05:622a:2613:b0:532:84d3:abb with SMTP id
 d75a77b69052e-533226c3db1mr13278171cf.7.1790462793627; Sat, 26 Sep 2026
 15:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923181213.3032038-1-irogers@google.com> <20260926062029.800743-1-irogers@google.com>
 <argt6raEAmM4e9PI@x2>
In-Reply-To: <argt6raEAmM4e9PI@x2>
From: Ian Rogers <irogers@google.com>
Date: Sat, 26 Sep 2026 15:46:22 -0700
X-Gm-Features: AclHuK-0IxZAf1dYZJF9GMyttOC5x9pBIt1GNidk8M2Zep5e7G-BGHdFJ36Ha2g
Message-ID: <CAP-5=fXvENrH1PrQvQmA22h_XRTB_f_ez_sFU9him6dU4uH0Ew@mail.gmail.com>
Subject: Re: [PATCH v4 00/49] perf: Complete transition to standalone Python scripts
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: alice.mei.rogers@gmail.com, james.clark@linaro.org, leo.yan@linux.dev, 
	namhyung@kernel.org, adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2026 at 1:41=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, Sep 25, 2026 at 11:19:27PM -0700, Ian Rogers wrote:
> > The perf script command has historically supported running Python and P=
erl
> > scripts by embedding libpython and libperl. That approach has several
> > drawbacks:
> >  - high overhead from constructing Python dictionaries for every event
> >    (whether used by the script or not),
> >  - complex build dependencies on specific Python/Perl libraries,
> >  - threading and interpreter lifecycle complications from embedding the
> >    interpreter inside perf,
> >  - no unified model for standalone scripts such as ilist.py, treport.py=
,
> >    tracepoint.py, and twatch.py.
>
> So I applied it and tested on the containers, make -C tools/perf
> build-test and 'perf test', that has some flakiness running the new
> tests for these python scripts in parallel, nothing that prevents it
> from being merged now tho:
>
> =3D=3D=3D Test Summary =3D=3D=3D
> Passed main tests : 146
> Passed subtests   : 156
> Skipped tests     : 28
> Failed tests      : 13
> List of failed tests:
>    72: Test dwarf unwind
>    88: daemon operations
>   101: perf kvm tests
>   111: perf record tests
>   112: perf record sample filtering (by BPF) tests
>   117: perf sched tests
>   137: check-perf-trace python test
>   138: compaction-times python test
>   141: failed-syscalls-by-pid python test
>   142: failed-syscalls python test
>   144: futex-contention python test
>   157: sctop python test
>   159: stat-cpi python test
> root@x2:~# perf test 72
>  72: Test dwarf unwind                                                   =
                                      : Ok
>
> =3D=3D=3D Test Summary =3D=3D=3D
> Passed main tests : 1
> Passed subtests   : 0
> Skipped tests     : 0
> Failed tests      : 0
> root@x2:~# perf test 88
>  88: daemon operations                                                   =
                                      : Ok
>
> =3D=3D=3D Test Summary =3D=3D=3D
> Passed main tests : 1
> Passed subtests   : 0
> Skipped tests     : 0
> Failed tests      : 0
> root@x2:~# perf test 101
> 101: perf kvm tests                                                      =
                                      : Ok
>
> =3D=3D=3D Test Summary =3D=3D=3D
> Passed main tests : 1
> Passed subtests   : 0
> Skipped tests     : 0
> Failed tests      : 0
> root@x2:~# perf test 112 ; perf test 117 ; perf test 137 ; perf test 141 =
; perf test 142 ; perf test 144 ; perf test 157; perf test 159
> 112: perf record sample filtering (by BPF) tests                         =
                                      : Ok
>
> =3D=3D=3D Test Summary =3D=3D=3D
> Passed main tests : 1
> Passed subtests   : 0
> Skipped tests     : 0
> Failed tests      : 0
> 117: perf sched tests                                                    =
                                      : Ok
>
> =3D=3D=3D Test Summary =3D=3D=3D
> Passed main tests : 1
> Passed subtests   : 0
> Skipped tests     : 0
> Failed tests      : 0
> 137: check-perf-trace python test                                        =
                                      : Ok
>
> =3D=3D=3D Test Summary =3D=3D=3D
> Passed main tests : 1
> Passed subtests   : 0
> Skipped tests     : 0
> Failed tests      : 0
> 141: failed-syscalls-by-pid python test                                  =
                                      : Ok
>
> =3D=3D=3D Test Summary =3D=3D=3D
> Passed main tests : 1
> Passed subtests   : 0
> Skipped tests     : 0
> Failed tests      : 0
> 142: failed-syscalls python test                                         =
                                      : Ok
>
> =3D=3D=3D Test Summary =3D=3D=3D
> Passed main tests : 1
> Passed subtests   : 0
> Skipped tests     : 0
> Failed tests      : 0
> 144: futex-contention python test                                        =
                                      : Ok
>
> =3D=3D=3D Test Summary =3D=3D=3D
> Passed main tests : 1
> Passed subtests   : 0
> Skipped tests     : 0
> Failed tests      : 0
> 157: sctop python test                                                   =
                                      : Ok
>
> =3D=3D=3D Test Summary =3D=3D=3D
> Passed main tests : 1
> Passed subtests   : 0
> Skipped tests     : 0
> Failed tests      : 0
> 159: stat-cpi python test                                                =
                                      : Ok
>
> =3D=3D=3D Test Summary =3D=3D=3D
> Passed main tests : 1
> Passed subtests   : 0
> Skipped tests     : 0
> Failed tests      : 0
> root@x2:~# uname -a
> Linux x2 7.2.5-200.fc44.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Sep 11 15:11:05=
 UTC 2026 x86_64 GNU/Linux
> root@x2:~# cat /etc/os-release
> NAME=3D"Fedora Linux"
> VERSION=3D"44 (Workstation Edition)"
> RELEASE_TYPE=3Dstable
> ID=3Dfedora
> VERSION_ID=3D44
> VERSION_CODENAME=3D""
> PRETTY_NAME=3D"Fedora Linux 44 (Workstation Edition)"
> ANSI_COLOR=3D"0;38;2;60;110;180"
> LOGO=3Dfedora-logo-icon
> CPE_NAME=3D"cpe:/o:fedoraproject:fedora:44"
> DEFAULT_HOSTNAME=3D"fedora"
> HOME_URL=3D"https://fedoraproject.org/"
> DOCUMENTATION_URL=3D"https://docs.fedoraproject.org/en-US/fedora/f44/"
> SUPPORT_URL=3D"https://ask.fedoraproject.org/"
> BUG_REPORT_URL=3D"https://bugzilla.redhat.com/"
> REDHAT_BUGZILLA_PRODUCT=3D"Fedora"
> REDHAT_BUGZILLA_PRODUCT_VERSION=3D44
> REDHAT_SUPPORT_PRODUCT=3D"Fedora"
> REDHAT_SUPPORT_PRODUCT_VERSION=3D44
> SUPPORT_END=3D2027-05-19
> VARIANT=3D"Workstation Edition"
> VARIANT_ID=3Dworkstation
> root@x2:~#

That's great! I'll dig into the flakes.

Thanks!
Ian
