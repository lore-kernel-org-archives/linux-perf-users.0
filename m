Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C01142E83
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Feb 2025 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738695740; cv=none; b=NXHiN3Q/mkL0ZhAhIk9YOG4unFr4x0WQkqcZkrawEpEWLb1tWvqhdNkIVDEobmJujWV/zW7OtFdMIdQNIhE0WCsvcdcJ0tVVh0G7GJncIwjiIjQVdUy9YqGBszn3BKOSSgQ1ElQms9NXfh1vIIrGAR2wSpgPmaZFR+bPbYGvYtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738695740; c=relaxed/simple;
	bh=pih8dX1QkofNv/xwIBaSWsmVMzDcnJG9l/i1Ocrd0qE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rlMhGq6eYrRGI1Il7u+db0ydB5twuBrAt+NpGqMHFzGSfXtZacT84ba6FRIRQQDFQ4XTGW/YOOQpNSRyYxcLrflHHUnrmBWm6dUSVDqDRvyIDXuDAonBdcmMt2nfkPOlFqMdWwOn7IoJgo5oxHTDOX6S5/3bt5VFmhGnaxjNydI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wTeCCjxi; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wTeCCjxi"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d04b70fe79so59325ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Feb 2025 11:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738695738; x=1739300538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pih8dX1QkofNv/xwIBaSWsmVMzDcnJG9l/i1Ocrd0qE=;
        b=wTeCCjxitXd2zKWQ6Hi40u/YT1nfRVtLvmVvLxqEytpsnT31ADTThBnU/H4DDaCl1x
         QQrMVpEVr/oXzQOYjNFZCXou1f+M8/5yZCcEJi66KnLO7nWRjE1PFZxPcxNS94l9eKC2
         Vm+gPjKRjmZSK0v+kQDjbXcYdlOgiZ5ZzR0gj+ylVDZN2XYQjXqDci1LC4NXK7THM47V
         0eYbnDRnc/LPvA/eJPcODqo77PjRc3n8EnVLo6uI9ORUbHDLCs6/DmEfV/wcrmgQukEz
         oqAidwfd3SzRdcPsW/gLNR0kaXaJKmrVc9wWLTeQOctNGMBKYY6S8FtMkI4LGVrOQ/nG
         8Ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738695738; x=1739300538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pih8dX1QkofNv/xwIBaSWsmVMzDcnJG9l/i1Ocrd0qE=;
        b=JU1DuIMnxEcubP011/iJYKH20C3CqpBzax5l0W6xCPPrhAkZ6q48MnWhhFj7qT4JU9
         Mg4iwVXbSzk8+kZZJfEbD6mFUrCspUO0t4Rp2rgpT3lZmbZmZ5r9AfnoVKAG2+2Z43D1
         Y4MLCx2SyNp7fK7EE25BKx1G3u0dDBItildbmbUlqFxJJ45AXuaRlhrry04u6KE8KLGQ
         cFeF+swsC4rPVrg5pxr1sQuTfCmEAVi3VdJ0gvp0m3fRiopwlXqKNmw61KQd1TbwN6Ay
         p6QphfC5iGU2il1aFxTNE/XFs03Ra7xGHZeFaDmbYqkbiY/tXSpdQx0Hppc/oCY9xCl6
         aCrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvr0CPslD48JbA+tDeO1cTDEQ7Sc447A8gGyRKS9eEFoaltlKh4sgGgQMoH2h6cFV88MvZB4DCNiJZ6d45YNPU@vger.kernel.org
X-Gm-Message-State: AOJu0YypI162BU6RPEsVblGlm8ZG97WxD29XPtqRQ2GqeFO0CrSfMA0b
	4QEiFtbVxifrDyZ0DM9GGbNGBxAoajvf9I0sBO93neBjO3yOoyJL9u975HwiZsvnJ3xq5hgkHyn
	LmsobVRXtXOQ2XGDQ4EozAOgygsmgI1D6xm72rOi1JTOveSea/rMJgMM=
X-Gm-Gg: ASbGnct9oAQMfNaWP555rZ9mn6WKGP/CgQfK+jkj633fDbfPAUCE7YQvUMlXkA7JYtO
	BBFBHovHuGouit2jKTuMF+j5C3Ds0wzgMeN5aJQ9YNo9oVOvh3EuW8T2SD5Kiz8O5vfOMtNbn3+
	N5/DCUjt/hvWse5yORsGD8yYY=
X-Google-Smtp-Source: AGHT+IEmHznl7Ik9Amt2S7g3PVA1k3F+CkuI8zD5o1s+dAxpBVFkkmFeRjysvFVzVsPvmCTyCe22Q+d9Jdu7Cu59sAw=
X-Received: by 2002:a05:6e02:1348:b0:3d0:bd4:e46e with SMTP id
 e9e14a558f8ab-3d03fc63026mr4230185ab.22.1738695737640; Tue, 04 Feb 2025
 11:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203230150.106823-1-irogers@google.com> <22469f1ace8127423152c6085f390c80a9faee3c.camel@intel.com>
In-Reply-To: <22469f1ace8127423152c6085f390c80a9faee3c.camel@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Feb 2025 11:02:06 -0800
X-Gm-Features: AWEUYZliUmqeTijL8sAr7rN4aziPfFRWAaOeCitnUkTS0idWPst1Nk1hVcwKDrY
Message-ID: <CAP-5=fW+4AmPj5gfxkPo1Anyqd+NwrRs1HOUwWEdwjBhONA3_Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] Intel vendor events and TMA 5.01 metrics
To: "Falcon, Thomas" <thomas.falcon@intel.com>, "Biggers, Caleb" <caleb.biggers@intel.com>, 
	"Taylor, Perry" <perry.taylor@intel.com>
Cc: "Baker, Edward" <edward.baker@intel.com>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"mpetlan@redhat.com" <mpetlan@redhat.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, 
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "Alt, Samantha" <samantha.alt@intel.com>, 
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "Wang, Weilin" <weilin.wang@intel.com>, 
	"acme@kernel.org" <acme@kernel.org>, "afaerber@suse.de" <afaerber@suse.de>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 10:44=E2=80=AFAM Falcon, Thomas <thomas.falcon@intel=
.com> wrote:
[snip]
> Hi, still seeing some errors in the all metrics test on Alderlake, Kan
> says that TSC is not a core pmu event:

Thanks Thomas,

the tsc event is on the msr PMU and needs special handing in the
conversion of the metrics. We've switched to a new source for the
metrics hence encountering what should be teething problem. I'll add a
fix in v4.

Ian
