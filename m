Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0729235AC18
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 20:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779309663; cv=pass; b=rhfnIKSfM+9FsnO8hbxXzush5YnUEg7XjfEXAbRq5RkaiAMbZTcG6XcyZMRoczPcmhxzyUeAXMGN/cole7ygOYCLGfWfJRmCvfRBQybm6jTPcLIPw3lR/QUKwKeXR2mUINRiqPciabwqBp08HDCujKcN1nPLfLC+Aquz+bir0lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779309663; c=relaxed/simple;
	bh=VfqFPKv8oNIefzAl9etv3ciigy76PFEIGCYTuJzoiTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uo+YySrfqvj7mnLdTQiacN+KQLJQ+5dflX3VJjJVsj1+/xaS1Rv2jAjIifFpaq7JrWu4R29sWSmcStUBEo+uBYBUbD9O3ean9seCaJVnVaFYTB2mTJCHvLBl90WMXik45jQjSs1khNPWMkhk43b/SBjAOOizKrRP/O/P05Kxchs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VzMIegip; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VzMIegip"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1336742714fso51c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 13:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779309661; cv=none;
        d=google.com; s=arc-20240605;
        b=JXG5j45w1ouJdIlt3bbQZd99UjQvRUef5MPhYU+QhqMFdK3Y5lw97HM2lzQKl++M/Z
         7Zp8ZOJQM3E24NOra5ZYlQgw1RhCZGaLE0wMNUqx1HmbRQvlMZ8aq3mTMNodeTOilVOb
         2gNLRgEDpH/zo0Tpb7dqqnsCS6oMAMvFZcyhPvPyfnvR7HwvYkNzQSbe3r7PhwLTL6d+
         Sgk/TkEbRbWg3DCpt/B7XE9o512r55defMgdVlwi+7gRFphbMibVEuTwTeU+fl2NaIM1
         f349guCtrb63TJnVhkUM8y8FL91U+ojkoJoNaFLC5Jb9WNTImTIv5UQiS3e7U9aF9LkS
         x5VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ro+0NamiAZE8SuVNzqLyZcex46reFlxuWy4gCcsT5Cw=;
        fh=Ynzo5Luwaiab7z6hYEt2PKE8jNVUI6ZWs3RPqnUtn3s=;
        b=PIO8v6AojHzLH7bMAgy9bRbSDdEZ32WhPCg+7e+cUjnaLKNmwjo5tdqFOV3DqQc+/5
         39XKSV6QQZCJjQvscZ8z2IR66VHD/EiWRU612Ost/7Tbo77S4Pdu3A68vWhWfCJN2ycq
         mkRZs2phpcK4JeYAL6CioQmbT/+91iVOx5l1s879Ehcf193fG+RxslBsXuORXA6U1XkM
         ohr1d6FBw2L7r0jxZrL4wRO/SjTyKHpu8pGdHznCAVOZpFga7LmAB6nKAy2zwb6A0bE6
         j2k0prTCrHIu9dY/pA5c3ACG+EhDMSHT4jQJ3s4jB85/s581umbE54v1pVOxquFVeQqf
         ss5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779309661; x=1779914461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ro+0NamiAZE8SuVNzqLyZcex46reFlxuWy4gCcsT5Cw=;
        b=VzMIegipjCaUa8WpEtuJX8wuQQr6YBTi25nB3SZRV949VVO2s8MwMRSMqRiL7E7j2/
         OGhRCDW0XjJmloaL+4A3EOzm3B+7mbc7tFAHcXQxjZ6NO6H74R7y2d9GSMJEckoM+oAN
         YJdK07puM8QQAhNjy/YLihQWKqNNHfL5n0bWdCtYBPaiUV6UgEKnLdK53n8oKvzKsW0U
         1NH6JyNNN6qMYJVCSsGHWsbNVOhm5JtsOxQhVMhu9RIvg/OINX8CkoTM0F+/vx3Jhjp1
         nQOO0b5pA8HUWFBDtXVaV3GGZbTmRb0riaOGZlTQFItfbHzXIT8zOP2MqlD85ef2MR/7
         Go3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779309661; x=1779914461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ro+0NamiAZE8SuVNzqLyZcex46reFlxuWy4gCcsT5Cw=;
        b=lgoloIa+A3Ol3jkytX8d5VvKsbD7a8GyZTeWTup863PcTomoRDSIjuv+18wRnsXlb+
         QVSP2Ex7rqgS+KQxZBJOdNBsccBVD13y70qs6QKHBwAQethd2AAnXYmdjzPOYAv2Xzqn
         glh/Yvq3mezGuSEVICJE+Ft1zgTmSkrJE6RveyH2R9kCoLsPX5yrPmwsEJlhpPWovcez
         2R791bd7FrP5MgppUCkw7f/CyvIdv8325Vh9MbOZmFXTIXiJiEbZfdgH8xWCQ+xaZkzC
         6iND82FDeoiGf/KvaOsqQZUa3iKuYny2znPgvMcXp7eBvJM4czSzfluEMpBw62Zr5O+U
         MFpg==
X-Forwarded-Encrypted: i=1; AFNElJ+rLPQEcLsy7HRz5ViQXCjPZm9rOCZbg+PAsCdG9jy5JpQPcP6lxJRH3c9HqMEJUNOimF3jx/bCwRXUCvTq2nJt@vger.kernel.org
X-Gm-Message-State: AOJu0YxFFdaw+CQAj/o3j3bY0aCp0LKxDLOiija0d2hRhJk20zs9Y7CO
	CefYhxr/HxIl2nAI1EK5huIe+wnOKsSusSaQcsayYtm4k7Pe3m6dwGCBbaN7Ckf6FqhBAbmVGfg
	+7g63xNYMi3/IEgFfmESZ75MsEl489uWh+fpIl/o4
X-Gm-Gg: Acq92OG0nxOVsAVTKMMP3FbR0D9mEX+FeJ1LkgWJJVTGI4qCiHJgCJa2q1AnLILKz4t
	89+s0joYXBqjRIORjnuaxUZdeu9BRSLukgT7u8porO7scBoYCeRzqsw9ODai21CG+sVggrhK33X
	W9GCE3sdVsig93ZfspOTVzDoiayEj7JiqXMQNfrYlxEFFbke49T+nFQCa2o9C3QzeG5nheZBTuo
	JHk9my3dFPAvbJKRJBHsV15JAygOuJ/7KCb23MBp1TCe9hrqaysbAjbZGzStwytF4BtkqVDYoio
	q7FvexmKoGNaIhniaDrU57Nbjd1np7CqBIrdJuUqy7Nd64bL
X-Received: by 2002:a05:7022:f96:b0:12a:7e9c:3974 with SMTP id
 a92af1059eb24-1363371b38emr5249c88.5.1779309660385; Wed, 20 May 2026 13:41:00
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
 <ag4IT7YfVyFjggK6@x1> <ag4PpWl-wV7SDpd5@x1>
In-Reply-To: <ag4PpWl-wV7SDpd5@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 May 2026 13:40:48 -0700
X-Gm-Features: AVHnY4J-2zMY3KRZNxBifQbUYA5ndWAoJfMjDHR9ZH36X4E2BubDRMMHfVMtBNU
Message-ID: <CAP-5=fU3HG9Mh3g+9JUCgkcE-DhmW66JSBnU5K=33kpcwhN0Ug@mail.gmail.com>
Subject: Re: [PATCH v14 00/32] perf tools: Add evsel to perf_sample
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 12:46=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, May 20, 2026 at 04:15:30PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, May 20, 2026 at 12:05:06PM -0700, Ian Rogers wrote:
> > > Nearly all perf code ends up passing an evsel with the perf_sample,
> > > which is problematic if you want to rewrite the evsel (such as with
> > > off-CPU processing) because all uses of the evsel need to be fixed
> > > up. Since the perf_sample now carries its own resolved evsel pointer,
> > > passing evsel separately is redundant and error-prone (allowing
> > > parameter divergence bugs).
> > >
> > > This series cleans up the redundant evsel parameter across all perf
> > > tool subcommands and APIs, ensuring that tools uniformly retrieve
> > > event attributes directly from the sample itself. This simplifies
> > > function signatures and improves API consistency.
> > >
> > > Additionally, this series incorporates subsequent memory safety
> > > improvements, robust bounds checking, and memory leak corrections
> > > prompted by address sanitizers and Sashiko code reviews.
> > >
> > > The original combined RFC patch:
> > > https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.c=
om/
> > > was split up per reviewer requests.
> > >
> > > v14:
> > >  - Incorporate Acked-by tags from Namhyung Kim.
> > >  - Re-polish and expand commit descriptions to provide thorough expla=
nations
> > >    of the changes and their rationale.
> >
> > Thanks, tentatively applying it to perf-tools-next, for v7.2.
>
> Had to apply a minor fixup for a conflict with anoter patch series from
> you, the LBR one.

Sorry for that and thanks for dealing with the conflict! Any chance
you could push to tmp.perf-tools-next? I have some other series that
will conflict and it would be nice to rebase those changes there.

Thanks,
Ian

> - Arnaldo
