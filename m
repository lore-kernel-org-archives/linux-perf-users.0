Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA9A30F93B
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Sep 2025 16:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349773; cv=none; b=i+s2IVNu3NPsSZcpnwS/9K2GQYDbLb0T71XiCnVgHYUP1Lcm5fILJ+ZaiZOAC3ESlCG+Zs1z3dx+vH2xEKlYLJhgMFkQOEMw/H/XpsMb50xs7CWtpVR1Mal11OwfR3wcEwomZzRHHsVAicHCNqVBV+ZbjYgyWpq3LeMVkP43K0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349773; c=relaxed/simple;
	bh=SK+V3i1b4JHmPbAgOyQ+O9nq+ydOhVWHaRR5izAFwGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swK1Z1iL4KrhuIBBwRJ6cdN6NuP7N7d/zgUWxOz+dTn5GBQDpRI4F5ZvGT22L0CZPOr04EoxtBfVXUREHPepb7VXUqkoMQZUcSDU09gw2nx8/lQAH7cGbY98o1PF1HjFHgkJC+zqYKRTIuEBaeYZGYRpTF2YjhJiKB87Pl6TkZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vm/IzO8a; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vm/IzO8a"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24cf5bcfb60so322875ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Sep 2025 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757349771; x=1757954571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxpZ3PbJm0tZWt4QSlez9tE8S36lpDl95U5aEIOWH8M=;
        b=Vm/IzO8auHY+GsFS7FGc66jLLFHwTpn3ofRlSocqDrFQSwEir3iuhwqH6EZl3s5b3J
         cnh7YWe3RzzlxDjHiE+SvCU2QHPUeBAckSJYumdAlgdFQjWVA+Efj1gEACUGPwUk+ABA
         cL8IqGpKZqod7tXG+JORvFMtcu0R86HhLgTv4FuvUwA1+ynKjshzwzOsXTShPbPcC6ve
         ZpTtjQjiIyJzavvF0uYAqPmTFf+RFCAkbdsQ5jiVy8qCYIK6sLgNU8q7AlBREtaaV5Jb
         nRMwCkN4O9C9V+oMT7gB5Vsebx3YB/gATlroYZ3fiCFcrAIpnJsiuFqVtq3B4C6UW3lr
         kWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757349771; x=1757954571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxpZ3PbJm0tZWt4QSlez9tE8S36lpDl95U5aEIOWH8M=;
        b=mFFA3YYzq1DWx2UfAeUx20V85XhJKktEobs2lN2s/z6hPXP4g25pbzsAsAxGPrdIzO
         vQITk+NwKEKGxaQSTOtjfZi+avj5u3LIekE4UlFALjSwzT0r0XtRbyNizQgrzMqXWIcS
         JDRd69QQB7PqwiPXdS8sXhAQDengCuUDs1iy+6ITsaHuiHPMFMjEyIZhCwBkJGWflzRx
         Ng2AysnBLFXgoHaadD8SYLVtlyN/Rx65JmkdslWK30Xs7ORXE6VW96L95fpEDR39pWNw
         ywy4p6FNRoOlk0CjLfKnUVyvhBl7aqlw8TASCFPevAoZ4IQd7L5qHdau+aTswxQqG8ut
         eW0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWl7841C5kTYUssBF9RDw0mRxY89Hu9B0XWdHna2Nta+x3kSGFuxU1t1FhoPP13IaE3tCLho1WGcwudZU1mIC0z@vger.kernel.org
X-Gm-Message-State: AOJu0YzHC8ivvRhgbFErjwpIQT0HZ2rVET5CF8eyoXxE4oTpj/I5lwGC
	4acDgROdNtHAAuokdxr7f4Pju90mqAaUKY1goilpkMHIrnfyqONZM7sKQnJKvIK8zIfUKeiLVWo
	ZLItQKPb5gzX75q8eIfLew9CJTm+6p7ht4eSDfBgp
X-Gm-Gg: ASbGnctunCBSLJC6jbsA3yq99+Wg+1daCc9FAsLlgfXebpCWEsgzqqIzZOXHtOZlfry
	z708TULbYJK08mLFBptOiugPxpX6JZF+XdHZ8cPfcQ+gMkTb8d4QvkShwMYN4UoxJDmaL5FyEIz
	W7M1XtExyGrpaFTu3SpYO9s8/emyWZgbRYHZH8cqvkATZP8OWM5obdcPRGE/EtncUjz+hwuXAus
	L8Jh3UJ/XZlKfO5DLWEsuTiAZbk1HNM+dbjMvGpH4M9v6bOlkmwZmM=
X-Google-Smtp-Source: AGHT+IEoSQybo+B9Ek7ofJWgjkMpsbm1SkCuXz2R9pZBuMRExcNhf8XxMuhra3hawRg85LZyRSbST+/NDna5xaK6pP4=
X-Received: by 2002:a17:902:d2c4:b0:240:640a:c564 with SMTP id
 d9443c01a7336-25171acbe36mr6682975ad.3.1757349771128; Mon, 08 Sep 2025
 09:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603181634.1362626-1-ctshao@google.com> <CAP-5=fVjA9630Com3xNWvgDHbwmsswQ8GEbqvnZ5QCtARQJuvQ@mail.gmail.com>
 <CAP-5=fXY68WRiz3PVD19GBPg4t+_-f3pyLCwhdCDZHmQ=Aag3Q@mail.gmail.com>
In-Reply-To: <CAP-5=fXY68WRiz3PVD19GBPg4t+_-f3pyLCwhdCDZHmQ=Aag3Q@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Sep 2025 09:42:38 -0700
X-Gm-Features: Ac12FXz3ARBiOKDmnpPM27gy1mVzPRCmSPUEaTgHBWMDiYTBCCbQqzDPHiDjBcI
Message-ID: <CAP-5=fU=5Be2mUL0Ptw1hLG9NuvS9dT1DN83nA2Q9kTskqmh-w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] perf: Reveal PMU type in fdinfo
To: peterz@infradead.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, Chun-Tse Shao <ctshao@google.com>, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	james.clark@linaro.org, howardchu95@gmail.com, weilin.wang@intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 8:25=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Tue, Jun 24, 2025 at 8:06=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Tue, Jun 3, 2025 at 11:16=E2=80=AFAM Chun-Tse Shao <ctshao@google.co=
m> wrote:
> > >
> > > It gives useful info on knowing which PMUs are reserved by this proce=
ss.
> > > Also add config which would be useful.
> > > Testing cycles:
> > >
> > >   $ ./perf stat -e cycles &
> > >   $ cat /proc/`pidof perf`/fdinfo/3
> > >   pos:    0
> > >   flags:  02000002
> > >   mnt_id: 16
> > >   ino:    3081
> > >   perf_event_attr.type:   0
> > >   perf_event_attr.config: 0
> > >
> > > Testing L1-dcache-load-misses:
> > >
> > >   $ ./perf stat -e L1-dcache-load-misses &
> > >   $ cat /proc/`pidof perf`/fdinfo/3
> > >   pos:    0
> > >   flags:  02000002
> > >   mnt_id: 16
> > >   ino:    1072
> > >   perf_event_attr.type:   3
> > >   perf_event_attr.config: 65536
> > >
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> >
> > Ping.
> >
> > Thanks,
> > Ian
>
> Hi Peter and Ingo,
>
> This small kernel change enables being able to better diagnose which
> processes are using perf events for what. In the series it is used in
> perf to blame EBUSY for PMUs like intel-pt on which processes are
> using that PMU.
> Are there issues that need resolving before the patch can be
> considered for inclusion?
>
> The original patch was sent in October 2024:
> https://lore.kernel.org/lkml/20241031223948.4179222-2-ctshao@google.com/

Ping. We're nearly up to a 1 year anniversary on this 10 line change.

Thanks,
Ian
