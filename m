Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9615684
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Mar 2025 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741744152; cv=none; b=aZzHHTAE2kqReTKs9/xSLtU6xfPX3Z0LdVgpuGlOE4KFeXEU/AJkOmc8stKgk8dYKVxc4PjStAPLxTVFye+G5iMDoU8qbLfR8GyMToxoIk2TRc+zqsTfkCu0LCF7HiQ7BlZtofEfzv3+sw6U8wdGZ3Jw3zKQIf7ByzquvhJgAFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741744152; c=relaxed/simple;
	bh=z6vEESz7fgeKeMKNXCWcHEVY5/CY2eTREfVGqLFccNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8ouv2hlSaxup0VMoztmHgYFoN56yA9kvo5pepjeOLRwh3ofg3G88LWVwrxODfFvu2XDa9C+7vi2qqEoLIfpNGYUO1JOt5o2aXay8cEp7+v9yZ8FuxFE2Gjcg3B8LmHuXAkanEO5cDvKjdDLlJuuHGG9snrQpykMRQXun5cWHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3WERBy+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3WERBy+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741744149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mS40iqy6bE/t2MX5M833ImvODIoJA/NdWM+482Gsggw=;
	b=H3WERBy+se2eY6oYFHIiJuunC+VCt/l8+P0N9/RHj6q1uRmw/uLlmytnlixIx7fkklOX93
	0WQ5TwrGX83kj/OHI14SBG4XIF7kWSM/s9g6qy+SK2vCMFSf2XuccG25+sGrZywyma2xXw
	0eutm9JJUEhA3WYxmuKJVulwoLJFg2s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-5rM2sgx6PNu3bRjmHp9hwA-1; Tue, 11 Mar 2025 21:49:07 -0400
X-MC-Unique: 5rM2sgx6PNu3bRjmHp9hwA-1
X-Mimecast-MFC-AGG-ID: 5rM2sgx6PNu3bRjmHp9hwA_1741744147
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-300fefb8e25so2819870a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 18:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741744147; x=1742348947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mS40iqy6bE/t2MX5M833ImvODIoJA/NdWM+482Gsggw=;
        b=u2oKvYps+NXrd8mpGpvu8Y3/ImOS8mwIx5Eh/ECauPJXk+21JjojafkK2JpHveK0ZD
         3tBm4tFiTZbBpZyOFza1V7GltHLwq7zWl/WPHQSWnlsbGoOifN3JKO9DOZBqJ07KQ7Om
         mSXQrcyK16Hu8tIVCPgrY3w/E4viFs+pBQrxkP7aPuYVKFib3GcNSQsnEkDSDpZg4QQ2
         fWZJ5+hP0JnMa3t/gETxM/0tv5MpaTfRx0j1ovtZgEg/M6jnnQ9lhrjIUR8JKXtWQ9i0
         gH9asVmm+a12xdvrtCw+8YupnGRoFygY2PS6MIsgIbokVo17gqR/KFMMcOdvacFjAnEz
         jj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1MgrimCxrhUKacyZ+d9AaK83K3g7ralKmvwndIL5iMi/ZnlAI8EqkeAnfaIIHLjzKHR25FjZ+N+PaOW8mgt5L@vger.kernel.org
X-Gm-Message-State: AOJu0YyGQ/U9h0T+I+ykSz6BC3NYjpokudfKK0QfLayHnWnlLaw083K5
	bK7Kx/iKCjysR/3Hg7gjTABJO8V0jO0iKx8LB5CeEFs0SonFBnx/aQ07dIxMACdZamQK7D+PV4y
	8hAevtPd6sx3EafNapzNxTqUPBKwJlLljpLxcbFFLE+x5/kw6Qm8CSn3hVVoDJ8JAEtLTs2TKyt
	V1Lkc3pUx1njWQBohdU9mNGXLMKPpBLs1+l2bCUGTaZQ==
X-Gm-Gg: ASbGncvpDG9h3F7qv4ozarQnfp2/So2rJK+zkPSmNzPkxLfibG3O7QCeuibMyZqx/b5
	R18xw57QHhxWRF19Qj3fBgXY2gpslz4Y/yk8CgNOZXvyCqX05Scmv53TmBfXqCKSnofKO9JrYlg
	==
X-Received: by 2002:a17:90a:a009:b0:301:1d03:93cd with SMTP id 98e67ed59e1d1-3011d039a52mr272686a91.24.1741744146670;
        Tue, 11 Mar 2025 18:49:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA5DMKtdM6NBs30TE0W6cWUn0CsNJQ79iHLKfXGh7a5VcW+do0uAHogscVm/LdHTJJ+Ad94KxOVWY7qCnqGEA=
X-Received: by 2002:a17:90a:a009:b0:301:1d03:93cd with SMTP id
 98e67ed59e1d1-3011d039a52mr272663a91.24.1741744146330; Tue, 11 Mar 2025
 18:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122231233.79509-1-vmolnaro@redhat.com> <1eeb7a39-8c75-4bc3-8be6-d3d1fc0e1a61@redhat.com>
 <8f62887e-f3c5-4b43-8c77-897564dc971e@redhat.com> <Z4vv0_-GP5bbNPAj@google.com>
 <CAATMXfkOjMoaOP0LTD58+R0LikpEXi+Sa7g86=6y8EWX5WBZVA@mail.gmail.com>
 <CAATMXfmtSghSj1J91SVimNTLWdi-=--xpyhFn6RwY2b12y+UmQ@mail.gmail.com>
 <Z70DgrMlgS_nqYHM@google.com> <CAATMXf=UwUMe4m_EFKHan-VM86N=+KoZ8+tqgkuTeD-Cyd4hNA@mail.gmail.com>
In-Reply-To: <CAATMXf=UwUMe4m_EFKHan-VM86N=+KoZ8+tqgkuTeD-Cyd4hNA@mail.gmail.com>
From: Qiao Zhao <qzhao@redhat.com>
Date: Wed, 12 Mar 2025 09:48:53 +0800
X-Gm-Features: AQ5f1JoIAlP-Thft_9mc_LSRGshdECAIxHkDaQgt5bvOtD25g4LkMeNpZsxWZEM
Message-ID: <CAATMXfmmUOzYnHGvf6q83n5pq=UOJs905YYqn0MFM-mZWEoG-Q@mail.gmail.com>
Subject: Re: [PATCH] perf test stat_all_pmu.sh: Correctly check 'perf stat' result
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, acme@kernel.org, 
	acme@redhat.com, mpetlan@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,

Sorry for causing some trouble and confusion.
Veronika's patch fixed the "check 'perf stat' result" issue, and the
test passed.
About the "Bad event name" issue, it is another EMR/SPR uncore issue,
not caused by Veronike's patch.
So if no other is missing, can we merge this issue?

Tested-by: Qiao Zhao <qzhao@redhat.com>

- Qiao

On Mon, Mar 3, 2025 at 2:14=E2=80=AFPM Qiao Zhao <qzhao@redhat.com> wrote:
>
> Some more tests with Veronika's patch:
>
> Pick one failed event and use '-vv' to show more debug info like this:
> >>>>>>>>>>>
> # ./perf stat -vv -e 'unc_iio_req_from_pcie_pass_cmpl.wr' true
> Using CPUID GenuineIntel-6-CF-2
> Attempt to add: uncore_iio_0/unc_iio_req_from_pcie_pass_cmpl.wr/
> ..after resolving event:
> uncore_iio_0/event=3D0x90,ch_mask=3D0xff,fc_mask=3D0x7,umask=3D0x70ff010/
> Attempt to add: uncore_iio_2/unc_iio_req_from_pcie_pass_cmpl.wr/
> ..after resolving event:
> uncore_iio_2/event=3D0x90,ch_mask=3D0xff,fc_mask=3D0x7,umask=3D0x70ff010/
> Attempt to add: uncore_iio_6/unc_iio_req_from_pcie_pass_cmpl.wr/
> ..after resolving event:
> uncore_iio_6/event=3D0x90,ch_mask=3D0xff,fc_mask=3D0x7,umask=3D0x70ff010/
> Attempt to add: uncore_iio_8/unc_iio_req_from_pcie_pass_cmpl.wr/
> ..after resolving event:
> uncore_iio_8/event=3D0x90,ch_mask=3D0xff,fc_mask=3D0x7,umask=3D0x70ff010/
> Attempt to add: uncore_iio_1/unc_iio_req_from_pcie_pass_cmpl.wr/
> ..after resolving event:
> uncore_iio_1/event=3D0x90,ch_mask=3D0xff,fc_mask=3D0x7,umask=3D0x70ff010/
> Attempt to add: uncore_iio_3/unc_iio_req_from_pcie_pass_cmpl.wr/
> ..after resolving event:
> uncore_iio_3/event=3D0x90,ch_mask=3D0xff,fc_mask=3D0x7,umask=3D0x70ff010/
> Attempt to add: uncore_iio_7/unc_iio_req_from_pcie_pass_cmpl.wr/
> ..after resolving event:
> uncore_iio_7/event=3D0x90,ch_mask=3D0xff,fc_mask=3D0x7,umask=3D0x70ff010/
> event syntax error: 'unc_iio_req_from_pcie_pass_cmpl.wr'
>                      \___ Bad event name
>
> Unable to find event on a PMU of 'unc_iio_req_from_pcie_pass_cmpl.wr'
>
> event syntax error: 'unc_iio_req_from_pcie_pass_cmpl.wr'
>                      \___ value too big for format (umask), maximum is 25=
5
>
> event syntax error: 'unc_iio_req_from_pcie_pass_cmpl.wr'
>                      \___ value too big for format (umask), maximum is 25=
5
>
> event syntax error: 'unc_iio_req_from_pcie_pass_cmpl.wr'
>                      \___ value too big for format (umask), maximum is 25=
5
>
> event syntax error: 'unc_iio_req_from_pcie_pass_cmpl.wr'
>                      \___ value too big for format (umask), maximum is 25=
5
>
> event syntax error: 'unc_iio_req_from_pcie_pass_cmpl.wr'
>                      \___ value too big for format (umask), maximum is 25=
5
>
> event syntax error: 'unc_iio_req_from_pcie_pass_cmpl.wr'
>                      \___ value too big for format (umask), maximum is 25=
5
>
> event syntax error: 'unc_iio_req_from_pcie_pass_cmpl.wr'
>                      \___ value too big for format (umask), maximum is 25=
5
> Run 'perf list' for a list of valid events
>
>  Usage: perf stat [<options>] [<command>]
>
>     -e, --event <event>   event selector. use 'perf list' to list
> available events
> >>>>>>>>>>
> And the event umask shows "umask=3D0x70ff010", this value is higher than
> maximum value "255".
>
> After talking with Michael, this "Bad event name" issue should be
> fixed by Ian Rogers's patch
> https://lore.kernel.org/lkml/20250211213031.114209-20-irogers@google.com/=
#r
>   perf vendor events: Update Sapphirerapids events/metrics
>
> Will try to test Veronika's patch again after Roger's patch merges.
>
> - Qiao
>
>
>
>
> - Qiao
>
> On Tue, Feb 25, 2025 at 7:41=E2=80=AFAM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hello,
> >
> > On Mon, Feb 24, 2025 at 05:34:15PM +0800, Qiao Zhao wrote:
> > > On Mon, Feb 24, 2025 at 2:59=E2=80=AFPM Qiao Zhao <qzhao@redhat.com> =
wrote:
> > > >
> > > > On Sun, Jan 19, 2025 at 2:15=E2=80=AFAM Namhyung Kim <namhyung@kern=
el.org> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > On Thu, Jan 16, 2025 at 01:31:21PM +0100, Veronika Molnarova wrot=
e:
> > > > > >
> > > > > >
> > > > > > On 12/10/24 16:20, Veronika Molnarova wrote:
> > > > > > >
> > > > > > >
> > > > > > > On 11/23/24 00:12, vmolnaro@redhat.com wrote:
> > > > > > >> From: Veronika Molnarova <vmolnaro@redhat.com>
> > > > > > >>
> > > > > > >> Test case "stat_all_pmu.sh" is not correctly checking 'perf =
stat' output
> > > > > > >> due to a poor design. Firstly, having the 'set -e' option wi=
th a trap
> > > > > > >> catching the sigexit causes the shell to exit immediately if=
 'perf stat' ends
> > > > > > >> with any non-zero value, which is then caught by the trap re=
porting an
> > > > > > >> unexpected signal. This causes events that should be parsed =
by the if-else
> > > > > > >> statement to be caught by the trap handler and are reported =
as errors:
> > > > > > >>
> > > > > > >>     $ perf test -vv "perf all pmu"
> > > > > > >>     Testing i915/actual-frequency/
> > > > > > >>     Unexpected signal in main
> > > > > > >>     Error:
> > > > > > >>     Access to performance monitoring and observability opera=
tions is limited.
> > > > > > >>
> > > > > > >> Secondly, the if-else branches are not exclusive as the chec=
king if the
> > > > > > >> event is present in the output log covers also the "<not sup=
ported>"
> > > > > > >> events, which should be accepted, and also the "Bad name eve=
nts", which
> > > > > > >> should be rejected.
> > > > > > >>
> > > > > > >> Remove the "set -e" option from the test case, correctly par=
se the
> > > > > > >> "perf stat" output log and check its return value. Add the m=
issing
> > > > > > >> outputs for the 'perf stat' result and also add logs message=
s to
> > > > > > >> report the branch that parsed the event for more info.
> > > > > > >
> > > > > > > Hi Ian,
> > > > > > >
> > > > > > > is there anything that I am missing? If so would be great to =
know the idea
> > > > > > > of your patch. This issue is getting quite old so would be gr=
eat to get a proper
> > > > > > > fix together.
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Veronika
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > just wanted to ping the patch. Would be great to sort it out an=
d close the issue.
> > > > >
> > > > > Ian, are you ok with this?
> > > > >
> > > >
> > > > Just ping again for this patch, can this fix be acked?
> > > >
> > > > And I already tested this patch and it works well on the ppc64le sy=
stem.
> > > >
> > > > Tested-by: Qiao Zhao <qzhao@redhat.com>
> > >
> > > Revert the Tested-by, and when more tests on Intel EMR system, and sh=
ow other
> > > "Bad event name" and " value too big for format (umask)" errors.
> > > This patch needs more tests and rewrites.
> >
> > Thanks for the test, though!
> > Namhyung
> >
> >

