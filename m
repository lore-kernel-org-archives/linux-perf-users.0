Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D753370F0
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 03:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777001240; cv=pass; b=YA4Whl5syH3LikgYfC9Pt/BAR/BS4Hk3Rs8c5Am1A8E1enBKgMEMxvDcFD8ufQpmKFfPfOKlwOOmFgTPqYRPb9VyHDtLVp8fQOmjeb77XPGREyfCPDPR7pCCZ5YKMD75OZeCispLtR64POYzqKlU+ss6JDkGmFebZXRmNsp4JEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777001240; c=relaxed/simple;
	bh=JY0AqOhyqcXdZ5HpuP5ETFWQFJ1T9SXrF1EFm6rzc2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZ6D8J/Va+21ve8frAO6kR/zx8Qf6We0sJCryXo5p36LK/a2jaMEWzDqR/TJylsumw+Il/JjCqEsYVsqL+qrnLQcXry9voneE9nZXfKaCtCiGXXsGBeAX5eiKXblY58HGR1RUJOz/iw73k4DAOhA4ihJxorhtfqmjVtyqg2bK64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PyK+VQAo; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyK+VQAo"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8a3970f1a0eso82604556d6.2
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 20:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777001238; cv=none;
        d=google.com; s=arc-20240605;
        b=eBoJoMO66M8VreR11yAjV7a0L8wseO+3RCHc9LvWSonoTS3iR7BIi40hJkh5uGnBaW
         PGAFw2LMNMaP1yjjkffGSdsrNYcACaNK48rorxyGZ/yVib9Bk4eLyyFJqMAW0II/DnXX
         StFbFdIeBjCg1T4au556nSiAJkJIp2ovrrlHzHkQ7IRp7OSMHMIvi1Nm9IJVebbmn8lg
         WW2WihArIdnrxRGfPxA24ERire49N/ucrVo+Q/SaUumtAUi1IqUQEdMMBHGhdH88maHO
         CLxhJDL2mFo5it+oDWYUCncfWVycxtvKe8U0KBorq1PP1xFAUbenMpB/hwCMcHwL/HeC
         0puw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7RUPTeQTQGi0BjE0UmfwkRC6wWtA9Ja3PP3yApVpgPI=;
        fh=eQaS6D4o08nzO1ru3THBTTOlsDW2FOvOriTJGaam+mg=;
        b=I2TZFvFrn1OGvVypqLSeyfUeVd/+0QIQJZ52QFjPiJn741olZ17xM1QqWeISDt11TX
         HGQPrqbkz+N1+pTnQvgjULGyf0ohSe+Q/U3eWy+n/GOtFkpxv3GAk7+9WEPMPs2pnM07
         zlQoxDEg4O1aF/V7DfLtqD5G1sC6vwC17D9pGaNfcsGK5vYXcmaYVtKHVceHiNs+EI1T
         8P8vGJ9jmLvpHLdkgTDUob/5OzfM3NeiwG87QQ5Q1FbPnj2Rz1sy4heWhwc4cMcACziN
         KZrdNrZs3X90ipSwamA+im6bwQoaQVdvTeHXitCIb6y4erfNFxXW84qTR4rgnj85sRAh
         s45Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777001238; x=1777606038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7RUPTeQTQGi0BjE0UmfwkRC6wWtA9Ja3PP3yApVpgPI=;
        b=PyK+VQAojhWwD2ks3NwQqYiAL6B953UQDEY8ntmIauS1p+OGlPTKxrt29Syiw9k4WW
         YYnHIicUhVA+kftBPSGEtDlGAcqdzPS7mOBvinHxHOx1l+qDcarxBz2ppy77dLxF1J25
         zJPr949eImG6euRjuxh5zgGPorTTLUDMiTa1kOYINhRDACEAPZMC9OS6mtzrxqDp9pnb
         6WypD/m7iDA3BvN2QAVgttGyhCRcJMHAKsxth+H/LoZDGzoGyxYMPxj/p0+rfyN/9eY2
         QKi0nFcogGjv3xW40JpxK4komOZt7Mw8MfAZikDhvjI8L9WwD/8IhhObaD9VLrHhmVZ6
         eDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777001238; x=1777606038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7RUPTeQTQGi0BjE0UmfwkRC6wWtA9Ja3PP3yApVpgPI=;
        b=LyBQFvwvCztBFs3T7xpsP74CdyxUuAU73xk6DWG2q78AeBkkYMp/RKJ+I7ErsOc5wl
         x2Nmj24fBSk9lJuCxOV1aBf3unYHxdOaLj5NyRvctdUuf4YquWy1ZqqAMSEQ5cmSQhJl
         674dUnVw0eYiIccnFYnnobLhQRkspNRIFiBtajsu4wkQ40bYgBxWIyXSYnPRuhL+KiTe
         aAZ+Lp43ejs7Nd+sTqxSD+JLxlyh74q1oFXbTSxZwHjfYenoBPLxc/VZDulQ1xKKzbGG
         PRDeKSvFTydHMsRapOJXVMIEZvG921rKBRyR51RNeyOSs3c8AeLArIT1VWRQPa4qS/fc
         LqAA==
X-Forwarded-Encrypted: i=1; AFNElJ+NmIdPykDa/40+MHfTL0T1V9HsG0aXEKcUI0jIsH3bnIbkdvpngjqQfz9OD0En3OkrMkOI4gq4oiy31Y+ZYgVe@vger.kernel.org
X-Gm-Message-State: AOJu0YxCyBaciPy3Ty0ssbmk5KY3AFdj7plkn+JxefZsSUOFVMjt3JmX
	Oy7AdM46aYyUwgTRUp46NEdiFM9SZja2Ya1rIiTmJyk/WJx7HFydfLBRa90grzIFDP64n9zqbtC
	ESmWfVMkL5Uhjo6kKXBu7yV19PIneTDA=
X-Gm-Gg: AeBDietd7JwdSXtoE22ZNtt/FTy+3d3iN7PLKnuDLztTth13Qd29xUYsdjE6wNK5eF9
	mZCeWmRCx32q3D5f/Flc2HG77+iQf5xNyPSE+wirdnmlQuEjdKecQF5Y4B8j24/ihP2h6fUqBrW
	k/tRwKZou2zT8R4tybTh3tlFILW26t3/Ri9xm/8DL5f+gREhEElnF7BSM+e6Da8/9s2PsY2Jj3V
	I9WxnQRU2LUGrQ3bfxG8gHA0gShLvDJtfnKI2lHWhfoWj52hkUrAKxTEncJEa9nWThCVoOaITti
	ahab1VcUuEMhMMUvSWpjGqkRXO+KNwdqZMybXoUA8uI=
X-Received: by 2002:a05:6214:d67:b0:8ac:a6bd:503b with SMTP id
 6a1803df08f44-8b028037183mr472986456d6.15.1777001238015; Thu, 23 Apr 2026
 20:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423004211.7037-1-akinobu.mita@gmail.com> <20260423043402.92389-1-sj@kernel.org>
In-Reply-To: <20260423043402.92389-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Fri, 24 Apr 2026 12:27:07 +0900
X-Gm-Features: AQROBzBx5d3KUTNito_bNnI17aarN3ECdM6A_J0f8yYwS-I7ROvlPbglOPzJMxU
Message-ID: <CAC5umyiikHr4doYKW5Gy4uv6M0_HbBZUSd9kM+L+kCrKYKEuXw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/4] mm/damon: introduce perf event based access check
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello SeongJae,

2026=E5=B9=B44=E6=9C=8823=E6=97=A5(=E6=9C=A8) 13:34 SeongJae Park <sj@kerne=
l.org>:
>
> Hello Akinobu,
>
> On Thu, 23 Apr 2026 09:42:06 +0900 Akinobu Mita <akinobu.mita@gmail.com> =
wrote:
>
> > DAMON currently only provides PTE accessed-bit based access check, this
> > patch series adds a new perf event based access check.
> >
> > Since perf event-based access checks do not require modifying the PTE
> > accessed-bit for pages representing each damon region, it reduces the
> > overhead of monitoring at a fixed granularity of the page size.
>
> As I also commented to the previous version, the high level idea makes se=
nse to
> me.  I think this can be useful.
>
> Also as I commented to the previous version, I understand the page level
> monitoring overhead reduction is the main purpose of this patch, and it m=
akes
> sense to me.  Nonetheless, I like this mainly because the perf event coul=
d
> provide more detailed information including from which CPU/thread the acc=
ess is
> made, and whether the access is for read/write, to my understanding.  Ple=
ase
> let me know if my understanding is wrong.

That's correct.
Once the integration into your new monitoring infrastructure is
complete, those things will become possible.

> >
> > Here is a method and its results for comparing access checks using
> > existing access bits and new perf events.
> [...]
> > Using accessed bit, prepare_access_checks takes 7 seconds and
> > check_accesses takes 5 seconds.
> [...]
> > Using perf event, prepare_access_checks takes 0.01 seconds and
> > check_accesses takes 2.6 seconds.
>
> Thank you so much for sharing these great test results with the detailed =
setup
> description!
>
> > ```
> > $ sudo $HOME/damo/damo stop
> > $ sudo $HOME/damo/damo start --ops vaddr \
> >       --perf_event 5000 0 0x4 0x1cd 0x1f 0 \
> >       --monitoring_intervals 5s 60s 300s \
> >       --monitoring_nr_regions_range 1000000000 1000000000 \
> >       --target_pid $(cat /tmp/memcached.pid)
> [...]
> > Note: damo's --perf_event option
> >
> > Using these features also requires modifications to damo, but these
> > are not included in this patch series and are currently under
> > development in the following branch:
> >
> > * https://github.com/mita/damo/tree/damo-perf-for-v3.2.2
>
> Thank you for sharing this, too!
>
> >
> > The option newly added to damo for perf event-based access check has th=
e
> > following format:
> >
> > `--perf_event <sample freq> <sample phys addr> <type> <config> <config1=
> <config2>`
>
> I think we may need to discuss more for final interface.  But I think tha=
t
> could be done later, after the kerenl ABI is fixed.

My current patch introduces a set of kernel ABIs (.../perf_events/<P>/*),
and if I want to control another field in the perf_event_attr,
I would have to add a new ABI. This would be a significant
maintenance cost.

Instead, I would like to provide a single bin file where the
perf_event_attr I want to set is written as binary.

> >
> > - `sample freq`: A higher frequency improves access accuracy, but also
> >   increases overhead.
> > - `sample phys addr`: specify 0 for vaddr and 1 for paddr.
> > - The remaining type, config, config1, and config2 settings can be foun=
d
> >   as follows:
>
> The values look bit human-unfriendly.  I wonder if we could use more
> human-friendly values, e.g., 'cpu' for type,
> 'mem_trans_retired.load_latency_gt_1024' for config, etc.  Not necessaril=
y we
> need to fix this right now.  Let's keep discussing.

I'd like to do it that way. These processes can be handled better
from user space than from within the kernel, so I'd like to achieve
this from damo with the help of the perf tool and library.

> >
> > Run `perf mem record -vv` to obtain the log, and then find the part in
> > the log where `perf_event_open` was executed successfully.
> > ```
> > $ sudo perf mem record -vv echo > /tmp/perf-mem-record.log 2>&1
> > $ cat /tmp/perf-mem-record.log
> > ...
> > perf_event_attr:
> >   type                             4 (cpu)
> >   size                             144
> >   config                           0x1cd (mem_trans_retired.load_latenc=
y_gt_1024)
> [...]
> > ...
> > ```
> >
> > The values for `type` and `config` are taken from this output.
> > Use the values of `config1` and `config2` if they are included in the l=
og;
> > otherwise, set them to 0.
>
> The above information will also be very useful for early testers of this =
patch
> series including myself.  Thank you for sharing.
>
> >
> > Any feedback or advice on the patch set would be greatly appreciated.
>
> Again, I like the high level concept of this patch series.  I definitely =
want
> this to be merged.  Nonetheless, not exactly as it is right now.  I think=
 we
> should spend enough time for the user interface design.  I hope the final
> interface is long-term maintainable and easy to extend.
>
> >
> > * RFC v3
> > - drop "reintroduce damon_operations->cleanup()" as no longer needed
> > - drop "allow user to set min size of region" (will be sent separately)
> > - add tgid to struct damon_access_report and use it instead of tid
> > - set perf_event_attr.precise_ip to 2
> > - prepare for the transition to report-based monitoring
> > - switch to use access_reported in struct damon_region
> > - switch to use sample/primitives/perf_events sysfs directory
>
> Thank you for doing this revisioning.
>
> For the user interface and also internal interface, I suggested to consid=
er
> reusing those for page fault events based per-CPUs/threads/reads/writes
> monitoring DAMON extension patch series in our previous discussion.  I th=
ink
> this version is following the right direction much more than the previous
> version.
>
> But, nowadays I'm thinking about a new user interface for the
> per-CPUs/threads/reads/writes monitoring that can easily also extended fo=
r perf
> event based monitoring and for not only access monitoring but general and
> multiple data attributes monitoring.
>
> It is still under the development and I'm planning to share a very early =
RFC
> version of that by LSFMMBPF.  I will try to add my idea about how this pe=
rf
> event based monitoring could also implemented by reusing the interface on=
 the
> early RFC version.
>
> Could we wait until the early RFC version is published, review my idea ab=
out
> how this perf event based monitoring could reuse it, and continue discuss=
ions
> about the next steps of this patch series?

That sounds good. I'd definitely like to check it out.

> [1] https://lore.kernel.org/20251208062943.68824-1-sj@kernel.org/
>
>
> Thanks,
> SJ
>
> [...]
