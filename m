Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811BB5820E
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Apr 2024 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713885320; cv=none; b=lCm0EPna7gW5U+ua7fRtiu53F7KSndy1vsIhUCtpf7kCZHNJROEN1IUmpwbS7iSNd5Sz5ADTYVGhmVxDYO0VXee7aBS2FfgY8l9cuolrhvtPyPJTU+oJFs90ipx3LzLxk+6vm6WrmD1N92HHXfPuUR5XGhROMorepnMYYXfQLQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713885320; c=relaxed/simple;
	bh=0SenlblrjMqan5Pcbzcsf/FKyDn1lUZo9dEh2XP0Z9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYCp1txQsGIDSR35P7uxfR/eEhCqXnxDBc4C6u3eOc22d58rJ+ysd9hTR4SgQKDAwV1PKLGETwpO/yUGf4wt6ov0yCwVuDzxIXK5fSjSPV1szeA2upC7c1cNUExW+Lv5tVuUktPTtV+yh2zhQZth6qDyAx6Tm8Nzv6gtbxWZG+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4M4Wkov5; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4M4Wkov5"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-434ffc2b520so208021cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Apr 2024 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713885318; x=1714490118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SenlblrjMqan5Pcbzcsf/FKyDn1lUZo9dEh2XP0Z9M=;
        b=4M4Wkov5iosIaAr9HxKN2h/003c0jT7Y+iLULrRPu4nm/4YQAiRaE7aJDSxx4izvyd
         zeD6nnkXPNlSKZsNO7V5YMy5CJLIuD8kpkoX8y6lEtqNBjIIo8bC9F4xjtuIiyrdq3oo
         1ohK8PDgaGetp6FN06v6MkkdwT5ximkM0o8EosKD/UxwkXvfkFWeP4FSna/bctIuRloJ
         u2bIEj09rs7AIrD9YM5wywcqbNjy2gxCVncY5eRS0BvlseTOY/B1kYp4PVMiDYBjTbX3
         L2O+NY8LnCXu0F3IEDESVL1dBa+HlZdNhlQ4uOZwmVYMa/YiFSEoQydLTR4PMAJ8m8qX
         pAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713885318; x=1714490118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SenlblrjMqan5Pcbzcsf/FKyDn1lUZo9dEh2XP0Z9M=;
        b=lY0i558xkpx+PdfAP8oe9B+80pVf+Uep3gJc6Asgm0NSJOS4irLAqLOhG6FFD3EsHM
         rAVqec5xEt9aKw3nn0v0znf5YajRzRplM/XgiQDZ8w1XQXwZKh5nLzQOM3rXGjWWO3p7
         QVnXA+zHbtB2ArjbWKzP2QWchzQZKlDCY5Qm1fpau1U3GtJN+cDP5z//vK9/uOQTle7T
         b20l3/whge5a8Wylf+L+mzMplKALwrBjVgD1XSBAH2cqJGzds1PkRbsQ+9xgHtD4CLFr
         C0iDYPwghrBT0XvJVy2LxMQylsNe7SE4Zb74hhTbPq+M2+0ZhYcnd39P4bgdQUu2eU1p
         GS4w==
X-Forwarded-Encrypted: i=1; AJvYcCWSdAFepc14cMJTC4CSDWH/32KLbTRUrSGCOfcjICX5jxtE7pjzB8ML/7zUZloS0sVahbFu0DjrCNMHf9ib12PXxpwCAaEs8p09wl0mpvJdoQ==
X-Gm-Message-State: AOJu0YxH+CX0M9VwrILaoLRfNPC0roPNlv+ny31b2jUnbwa1osmzBGxe
	j1YD1FyUqa68JPsskBKoNT5z1YQCvqwaaWhc7JIEqYU612f96RAdoEDfI4+OO0o55dWT6+nXRu9
	Is6exsYK/1Ojk+5iJAsRo+/YHZmVSbsg9u5qC
X-Google-Smtp-Source: AGHT+IEmDbvhgmJutRXxF3MJaFpsjAadibBlJZsxjSUIBJXhn/ms41LXrsgezlKX1Aj3ErOqxfZQYsmePxgCn9a7wgw=
X-Received: by 2002:ac8:468d:0:b0:437:b3df:9ab9 with SMTP id
 g13-20020ac8468d000000b00437b3df9ab9mr224998qto.23.1713885318312; Tue, 23 Apr
 2024 08:15:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423031719.1941141-1-irogers@google.com> <c1c460ed-69c3-4fde-aa9b-be1051dae6ec@linux.ibm.com>
In-Reply-To: <c1c460ed-69c3-4fde-aa9b-be1051dae6ec@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 23 Apr 2024 08:15:02 -0700
Message-ID: <CAP-5=fVrQJiFtLeYQqkKACHo_3ez9NEadYLcqy-UKk4i5dHSqQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Assume sysfs event names are always lowercase
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: Kan Liang <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Bjorn Helgaas <bhelgaas@google.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 11:53=E2=80=AFPM Thomas Richter <tmricht@linux.ibm.=
com> wrote:
>
> On 4/23/24 05:17, Ian Rogers wrote:
> > By assuming sysfs events are lower case, the case insensitive event
> > parsing can probe for the existence of a file rather then loading all
> > events in a directory. When the event is a json event like
> > inst_retired.any on Intel, this reduces the number of openat calls on
> > a Tigerlake laptop from 325 down to 255.
> >
>
> Ian, sorry for the late reply.
> On s390 the events in the sysfs tree are all upper case:

Yikes, sigh.. thanks for catching this :-)

> [root@a35lp67 ~]# ls -l /sys/devices/cpum_cf/events/ | head -10
> total 0
> -r--r--r-- 1 root root 4096 Apr 17 14:47 AES_BLOCKED_CYCLES
> -r--r--r-- 1 root root 4096 Apr 17 14:47 AES_BLOCKED_FUNCTIONS
> -r--r--r-- 1 root root 4096 Apr 17 14:47 AES_CYCLES
> -r--r--r-- 1 root root 4096 Apr 17 14:47 AES_FUNCTIONS
> -r--r--r-- 1 root root 4096 Apr 17 14:47 BCD_DFP_EXECUTION_SLOTS
> -r--r--r-- 1 root root 4096 Apr 17 14:47 CPU_CYCLES
> -r--r--r-- 1 root root 4096 Apr 17 14:47 CRSTE_1MB_WRITES
> -r--r--r-- 1 root root 4096 Apr 17 14:47 DCW_OFF_DRAWER
> -r--r--r-- 1 root root 4096 Apr 17 14:47 DCW_OFF_DRAWER_MEMORY
> [root@a35lp67 ~]#
>
> Same is true for all other PMUs (currently 5 and growing).
>
> Is there a branch to pull to try out the effect of your patch on s390?

Sorry not, I think everything would break anyway. I'll extend what
I've done so that event names can be lowercase or in shouty UPPERCASE.

Thanks,
Ian

> Thanks Thomas
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
