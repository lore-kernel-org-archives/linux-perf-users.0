Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E3015A868
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Mar 2025 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740982506; cv=none; b=ceTNHcRjmU8JNgY/WtEGnLQNmBOFX8mxfiVe10q8NytYzHrOmQhW+Hk90P3ha8YuJ9auI3HB+tQELaDrpd28ex1cHbkUv1Jx8/5g/UuU+AsPEu6DlZf2pfKSmDPMlH6RCD3Fr61tK6WVy22kfNq5D1FgErdgvxjaStwhWmaSygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740982506; c=relaxed/simple;
	bh=eUOyFcbQEGuYF+Yt7AOkIMbh6Z7EJojOob3ch5gt9qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CATRx3n5xgGud38u33m5Rzqm9zQiUySRXXzkpkbODyWVG3iz1e7FjDsXXTT/o9OKTBgamAriFd+SMf9hxc3TpYgx3YjiIam53IBFb+Yit0b1xYEvA+GM3euGY+h5d9He+FnV1dnyc3WAmOWr+yv8en8PBHzyT6bHFYoWt7kesL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dJxC9oj3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJxC9oj3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740982503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4SnmPwBakC6LAdBC5cTDHRCeKgWEeCb+G99FZdC+Pt0=;
	b=dJxC9oj3j+/4kmMrM15gMCOvmWoNbfmnJvgyqTKx0mV6n5zhrc1+wAkO8dSsK4v3ayCUex
	OFH+Pfbn2WHMCsqND1C6A6o/hpB2YWkrOjr6F99jOLvtG54TdTWIwmiE5AIGflrs5umvNq
	U7weedyT4guOe2tIhXzWfW16uXAi5y8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-GElY3Q3yMuaw36ig8OiClg-1; Mon, 03 Mar 2025 01:14:51 -0500
X-MC-Unique: GElY3Q3yMuaw36ig8OiClg-1
X-Mimecast-MFC-AGG-ID: GElY3Q3yMuaw36ig8OiClg_1740982490
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2feb4648d4dso11579047a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 02 Mar 2025 22:14:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740982490; x=1741587290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SnmPwBakC6LAdBC5cTDHRCeKgWEeCb+G99FZdC+Pt0=;
        b=bkhNuNq+OTKcm+GtTElYGsQXqW8YdV6q79oo9P8j0iv1Iuqg36wyBeP5Ccj6IDMpbG
         pjZpn4NRM52DK3X/JSldAIua1T0hcoxzzGaKDujDH+QJwcsaz/NdqG6X7tUZLb+OoWpP
         iz+06RsJaefTnb034z9VnL1ILstMPH8jsqEMEbtdsho3zwRxMp3NIYdjackqPaXSgV02
         IXWnotYIiMDon9zlo/AZjeqkcFIf7sVN48ak+uETGw0hYgQuBfePhtQrpZBOwflQtKOj
         cq0fo+CjarnEBiohwh1M8wLJYIEqKI45zMhDes+5DE1/jlWxIlSRMkJP4HNL/uYM6a34
         k0Uw==
X-Forwarded-Encrypted: i=1; AJvYcCW6zg22Dhb8oIe8VUoQxAO7FCOpk1LSU50S5xe2O3/BzPjycGyTo5KIPzrf/FjcPktUYP69vdWgdNRjLs5wo7Dz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Ynqx8fkZjyuZy3K/JR4NS+bPbU6ZFbkTsQQQuxHO3206HFEO
	juSSkZXT62x7cJht6Tbl/VVhnf6jI+CkPIhu3NFJhHwe8pAkh27GTgGqwnKksiupeEejle2fz5O
	0Qnu7ij7FTApFC0gAfhUTOjG295LvnAT4OAtB5pL+xbKeU4eYwafWxQgQoaz0lvkXyd1YbDHldI
	9lAuvDT3/pxWZ2R2c/AE9JerArxGU7AMmeAIvD/vhFRA==
X-Gm-Gg: ASbGncv2HiEk62hxupl7InkOBOzSmPCi6pmLRd8lr08Gb/pvUTGocb2CvKoUnHyn5GF
	1EuooCKFmRNTPUYGIQe0VC9r5Qnpk7UzlikEieO5L1fP66tyjGjT7CB/9oHuiCk/f1Lu4yjCp6Q
	==
X-Received: by 2002:a17:90b:288e:b0:2fc:c262:ef4b with SMTP id 98e67ed59e1d1-2febab787f0mr21340715a91.18.1740982490507;
        Sun, 02 Mar 2025 22:14:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjk1JCQFHhG8fhYGN/gYEG/cY8mOn69tB7aBaDYqkt6sVkQ3cLsTnVuc+Wwef8Xi1zJ8G2l1PbZMHD8WWBXuo=
X-Received: by 2002:a17:90b:288e:b0:2fc:c262:ef4b with SMTP id
 98e67ed59e1d1-2febab787f0mr21340697a91.18.1740982490229; Sun, 02 Mar 2025
 22:14:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122231233.79509-1-vmolnaro@redhat.com> <1eeb7a39-8c75-4bc3-8be6-d3d1fc0e1a61@redhat.com>
 <8f62887e-f3c5-4b43-8c77-897564dc971e@redhat.com> <Z4vv0_-GP5bbNPAj@google.com>
 <CAATMXfkOjMoaOP0LTD58+R0LikpEXi+Sa7g86=6y8EWX5WBZVA@mail.gmail.com>
 <CAATMXfmtSghSj1J91SVimNTLWdi-=--xpyhFn6RwY2b12y+UmQ@mail.gmail.com> <Z70DgrMlgS_nqYHM@google.com>
In-Reply-To: <Z70DgrMlgS_nqYHM@google.com>
From: Qiao Zhao <qzhao@redhat.com>
Date: Mon, 3 Mar 2025 14:14:37 +0800
X-Gm-Features: AQ5f1JqLX8M1ouxXQSLbAmpNs9dm4AqIdFweaDHivREfy5rLL08lOoA0Q1oE_B8
Message-ID: <CAATMXf=UwUMe4m_EFKHan-VM86N=+KoZ8+tqgkuTeD-Cyd4hNA@mail.gmail.com>
Subject: Re: [PATCH] perf test stat_all_pmu.sh: Correctly check 'perf stat' result
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, acme@kernel.org, 
	acme@redhat.com, mpetlan@redhat.com, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Some more tests with Veronika's patch:

Pick one failed event and use '-vv' to show more debug info like this:
>>>>>>>>>>>
# ./perf stat -vv -e 'unc_iio_req_from_pcie_pass_cmpl.wr' true
Using CPUID GenuineIntel-6-CF-2
Attempt to add: uncore_iio_0/unc_iio_req_from_pcie_pass_cmpl.wr/
..after resolving event:
uncore_iio_0/event=3D0x90,ch_mask=3D0xff,fc_mask=3D0x7,umask=3D0x70ff010/
Attempt to add: uncore_iio_2/unc_iio_req_from_pcie_pass_cmpl.wr/
..after resolving event:
uncore_iio_2/event=3D0x90,ch_mask=3D0xff,fc_mask=3D0x7,umask=3D0x70ff010/
Attempt to add: uncore_iio_6/unc_iio_req_from_pcie_pass_cmpl.wr/
..after resolving event:
uncore_iio_6/event=3D0x90,ch_mask=3D0xff,fc_mask=3D0x7,umask=3D0x70ff010/
Attempt to add: uncore_iio_8/unc_iio_req_from_pcie_pass_cmpl.wr/
..after resolving event:
uncore_iio_8/event=3D0x90,ch_mask=3D0xff,fc_mask=3D0x7,umask=3D0x70ff010/
Attempt to add: uncore_iio_1/unc_iio_req_from_pcie_pass_cmpl.wr/
..after resolving event:
uncore_iio_1/event=3D0x90,ch_mask=3D0xff,fc_mask=3D0x7,umask=3D0x70ff010/
Attempt to add: uncore_iio_3/unc_iio_req_from_pcie_pass_cmpl.wr/
..after resolving event:
uncore_iio_3/event=3D0x90,ch_mask=3D0xff,fc_mask=3D0x7,umask=3D0x70ff010/
Attempt to add: uncore_iio_7/unc_iio_req_from_pcie_pass_cmpl.wr/
..after resolving event:
uncore_iio_7/event=3D0x90,ch_mask=3D0xff,fc_mask=3D0x7,umask=3D0x70ff010/
event syntax error: 'unc_iio_req_from_pcie_pass_cmpl.wr'
                     \___ Bad event name

Unable to find event on a PMU of 'unc_iio_req_from_pcie_pass_cmpl.wr'

event syntax error: 'unc_iio_req_from_pcie_pass_cmpl.wr'
                     \___ value too big for format (umask), maximum is 255

event syntax error: 'unc_iio_req_from_pcie_pass_cmpl.wr'
                     \___ value too big for format (umask), maximum is 255

event syntax error: 'unc_iio_req_from_pcie_pass_cmpl.wr'
                     \___ value too big for format (umask), maximum is 255

event syntax error: 'unc_iio_req_from_pcie_pass_cmpl.wr'
                     \___ value too big for format (umask), maximum is 255

event syntax error: 'unc_iio_req_from_pcie_pass_cmpl.wr'
                     \___ value too big for format (umask), maximum is 255

event syntax error: 'unc_iio_req_from_pcie_pass_cmpl.wr'
                     \___ value too big for format (umask), maximum is 255

event syntax error: 'unc_iio_req_from_pcie_pass_cmpl.wr'
                     \___ value too big for format (umask), maximum is 255
Run 'perf list' for a list of valid events

 Usage: perf stat [<options>] [<command>]

    -e, --event <event>   event selector. use 'perf list' to list
available events
>>>>>>>>>>
And the event umask shows "umask=3D0x70ff010", this value is higher than
maximum value "255".

After talking with Michael, this "Bad event name" issue should be
fixed by Ian Rogers's patch
https://lore.kernel.org/lkml/20250211213031.114209-20-irogers@google.com/#r
  perf vendor events: Update Sapphirerapids events/metrics

Will try to test Veronika's patch again after Roger's patch merges.

- Qiao




- Qiao

On Tue, Feb 25, 2025 at 7:41=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Mon, Feb 24, 2025 at 05:34:15PM +0800, Qiao Zhao wrote:
> > On Mon, Feb 24, 2025 at 2:59=E2=80=AFPM Qiao Zhao <qzhao@redhat.com> wr=
ote:
> > >
> > > On Sun, Jan 19, 2025 at 2:15=E2=80=AFAM Namhyung Kim <namhyung@kernel=
.org> wrote:
> > > >
> > > > Hello,
> > > >
> > > > On Thu, Jan 16, 2025 at 01:31:21PM +0100, Veronika Molnarova wrote:
> > > > >
> > > > >
> > > > > On 12/10/24 16:20, Veronika Molnarova wrote:
> > > > > >
> > > > > >
> > > > > > On 11/23/24 00:12, vmolnaro@redhat.com wrote:
> > > > > >> From: Veronika Molnarova <vmolnaro@redhat.com>
> > > > > >>
> > > > > >> Test case "stat_all_pmu.sh" is not correctly checking 'perf st=
at' output
> > > > > >> due to a poor design. Firstly, having the 'set -e' option with=
 a trap
> > > > > >> catching the sigexit causes the shell to exit immediately if '=
perf stat' ends
> > > > > >> with any non-zero value, which is then caught by the trap repo=
rting an
> > > > > >> unexpected signal. This causes events that should be parsed by=
 the if-else
> > > > > >> statement to be caught by the trap handler and are reported as=
 errors:
> > > > > >>
> > > > > >>     $ perf test -vv "perf all pmu"
> > > > > >>     Testing i915/actual-frequency/
> > > > > >>     Unexpected signal in main
> > > > > >>     Error:
> > > > > >>     Access to performance monitoring and observability operati=
ons is limited.
> > > > > >>
> > > > > >> Secondly, the if-else branches are not exclusive as the checki=
ng if the
> > > > > >> event is present in the output log covers also the "<not suppo=
rted>"
> > > > > >> events, which should be accepted, and also the "Bad name event=
s", which
> > > > > >> should be rejected.
> > > > > >>
> > > > > >> Remove the "set -e" option from the test case, correctly parse=
 the
> > > > > >> "perf stat" output log and check its return value. Add the mis=
sing
> > > > > >> outputs for the 'perf stat' result and also add logs messages =
to
> > > > > >> report the branch that parsed the event for more info.
> > > > > >
> > > > > > Hi Ian,
> > > > > >
> > > > > > is there anything that I am missing? If so would be great to kn=
ow the idea
> > > > > > of your patch. This issue is getting quite old so would be grea=
t to get a proper
> > > > > > fix together.
> > > > > >
> > > > > > Thanks,
> > > > > > Veronika
> > > > >
> > > > > Hello,
> > > > >
> > > > > just wanted to ping the patch. Would be great to sort it out and =
close the issue.
> > > >
> > > > Ian, are you ok with this?
> > > >
> > >
> > > Just ping again for this patch, can this fix be acked?
> > >
> > > And I already tested this patch and it works well on the ppc64le syst=
em.
> > >
> > > Tested-by: Qiao Zhao <qzhao@redhat.com>
> >
> > Revert the Tested-by, and when more tests on Intel EMR system, and show=
 other
> > "Bad event name" and " value too big for format (umask)" errors.
> > This patch needs more tests and rewrites.
>
> Thanks for the test, though!
> Namhyung
>
>

