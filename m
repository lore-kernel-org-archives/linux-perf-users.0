Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B30333A9DA
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305026; cv=pass; b=teJObi6gXA2sx1NyJAqL4oRIsKE0IoakPG1gYUDmfr7e0qOYoyhY46FRlMUZUh0x2MFQafRcYyyzIMzuGFFRndbllIU7bsb0exKfaxdF91txWkjx0Siek+1X/XGngoF6G9ZU7DO615Ay+yQATfTk1eyhla0EhtnHACXYBzZRGK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305026; c=relaxed/simple;
	bh=WVPXR2XhYU5Dk2dbvQ32Cb7EYnMeMSpemGtNQYT/3f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mD07js7vof1kJOMEzJcK+PK1L/Q+uc0CxwNGbId/j44mHvSQYq4dC/zw2lSgw7nXUXo2eSYrznVSyW1t3NUNM40GU6HTaBUnHkROG7k9zuu+Q0MJUBruY/dHvbgGEfEpcdXtjEJWaFOlHgbkccbeg37DdQ3dYrjKC7f2lKUa/eE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pujCHDWJ; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pujCHDWJ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so1345ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:23:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779305024; cv=none;
        d=google.com; s=arc-20240605;
        b=cI2LI/XLfFWf3iupR6QwecnN0k98xaxDSrndz6Byxsq9uKGb9VpEVJXnq9d7SG1tXW
         QeNn4mXwT8A8gzSw45aXN+BrGJluRUwg+OefmND+sbLEk7wl7XJWoO1t/T6BK+gqrWHa
         ya4h3w6lAmSbZXmxmcSc8rZPx1Ysz7pF2VLALsLu3xk1pO6Sw4MLGrYPZgMzKmEpsoV0
         e3eYN2DW1hrDDgqjV8gwaUAZkc8a1JTOo4onsvFx6YXVQZKfkLWxlFkWUKpd2suBUBaH
         vM97SHZ40ZKD5FDt/n7ahl24VyVtet8a2NqACDUu6MHNeJ70HRUdDh38k8GB177RHnEC
         XuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BKLfV339eikq5ubMtXIpaDsywCdZtBd+AMlZ1Y01tpU=;
        fh=MTu5O5Dfe3pi3EiTxz54aj+gzHgE3x8OTgmUTLGX8k4=;
        b=MOm82wVOOwOHYnEOWaLV4bhpmReOz8GbiglAF+Mni1myV8uQirhBTRqSKRQQ9XETMk
         QmhldqANz7GMYZoajdbnRII12vBWVTFlvr40vrLBPu4tCupLTXr3b4H4YFINwSrvD2Bl
         FxZqdp/zPWOYNatwXnV/FQwbLOE+wFgp7+8M2UMoBS6nUSsywjl3ltK7ielLNRP0p6t0
         5L+oAGGa0yq/gxX+A4yfl8auOZI2c9osOhgRq7g9OdZIhbujai3dmO59PWljGTeawGsZ
         +XnioDk45jPsldYud7O+3NNQ9d03dsRwr3K6kwZLihN2pHkcqHy2Si1FAVP3mewKmbXi
         hHSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779305024; x=1779909824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKLfV339eikq5ubMtXIpaDsywCdZtBd+AMlZ1Y01tpU=;
        b=pujCHDWJ/t6HBUbtg0h3C5ijhJRZqu245DPMBa6b8WsmrhQLCpvd1tImg95WKTckb5
         6gzbqDwYFR/dTrJjqZ6iLCrF2PElKdGSiE0564yfkQ/qJ8Zbb23QOcPqT+ozcZxhzW6y
         262bjnDTpikqqLGb0UgIv28smo9qEuw6mM9Fn7dc+C8GWmR2gcaHg9hSb59jqVZVL9AM
         XDJ77WMvGlDww6OLSYNeh2EmxcCMYVkSyWEzhUBGiWP5KQJ+lGMVarJ8iUfz1U1TE+IW
         vpU/5bdJutBSYNEjeG/eEmfGwOGrlCIiaJ2YI68H7mUJY61+uzdJVYLBs5AijLC7C5X4
         wsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779305024; x=1779909824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BKLfV339eikq5ubMtXIpaDsywCdZtBd+AMlZ1Y01tpU=;
        b=Rm0M+On4o9VdnuenxNcDjVBOVUCcMlK2CM6hhszz5Fdkf7N4saziprBA2S8upVtM9C
         fV/BU9f2XVl9a5q314kEPUstypT7poJVDl56IiQrMIna518wIQn6VimzSaw6amnaZ6nM
         SSnzD4So7WABH+oORBzSXuP6E7YnfIqCoEmMEaLXuA9F8wVopNIJPUgCiobqD2K9DxlV
         tvGhoT8D/utN+3WaGKL/goKq3/DtnEwRuLjYGc1UkJvYS+pSWO+wcAy7urFRkLxobDuW
         OVNnM4VmvQnAQCRRZmGXmeSJaeEq7xLdGByoGXh/PJV2Qzf6yiakhypfq+c1voJ7bOM5
         /Y5w==
X-Forwarded-Encrypted: i=1; AFNElJ/st8C3fyM2zaq8w1Gj3Bzo1ACZNMVnFXwnXDD6I0uMRcC/WkV7wJ2lfB1JUHqQvEfidLyyk2QwEjkz//ET98yZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyvTqOvsL8rI8DOv9X65TWvTayyivXSCqYuH2152oKr4NUu02fU
	OAlzjKMNU9Kh1C24eFSr+dbaTLR+UHceteuME3koRNkNW6sdBLZQaYldjpH0yRTHshvWpHkI4oq
	NiLShjT5JFwEGdXdDewZaR9E3P+7W+NCOYLCBIKIT
X-Gm-Gg: Acq92OHqC91hgk+XfN5mHzuqyHeKlyUzNd3n38f1FtpQTYpgU5LDfOHGkl1acJOmwzy
	i2ui0GLny8bZteOZbut25NV1wIyoAxcL9kgm5KGTLY9rgxYxgnzo0rum9Hy0aT9seWfcS2lh1Zi
	9Kmp4DideZvb4ZzXYfG6AXXa0RuprwxJGh14FT7Fb9hs6Iy33F0NXqF/1Vg21AZYzysXIO32yb1
	HMqTr9vehyyRkMy64L0rFxI8kDCHfJkI6WsSXWY1aCcF4TEW2zjg04S6NM1UhyE5k10wvc0An8C
	0kJJhYbGGWt9rR6mywDyIlWXTunBfGu68jwwdIioK1K6m/7Z
X-Received: by 2002:a17:902:e743:b0:2bd:508b:f3ab with SMTP id
 d9443c01a7336-2be9f6aea4emr479765ad.15.1779305023979; Wed, 20 May 2026
 12:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
 <ag4IT7YfVyFjggK6@x1>
In-Reply-To: <ag4IT7YfVyFjggK6@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 May 2026 12:23:32 -0700
X-Gm-Features: AVHnY4KY6Hdf0VMkKMnARQm70XRFnWbC7Pmer9Xs8MbTLKOMGc5ofwEAxaEdmd8
Message-ID: <CAP-5=fUcs4A3xNoOVkvgFev_OMxtGkz53BuZMtwSEoUwSiy=Ag@mail.gmail.com>
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

On Wed, May 20, 2026 at 12:15=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Wed, May 20, 2026 at 12:05:06PM -0700, Ian Rogers wrote:
> > Nearly all perf code ends up passing an evsel with the perf_sample,
> > which is problematic if you want to rewrite the evsel (such as with
> > off-CPU processing) because all uses of the evsel need to be fixed
> > up. Since the perf_sample now carries its own resolved evsel pointer,
> > passing evsel separately is redundant and error-prone (allowing
> > parameter divergence bugs).
> >
> > This series cleans up the redundant evsel parameter across all perf
> > tool subcommands and APIs, ensuring that tools uniformly retrieve
> > event attributes directly from the sample itself. This simplifies
> > function signatures and improves API consistency.
> >
> > Additionally, this series incorporates subsequent memory safety
> > improvements, robust bounds checking, and memory leak corrections
> > prompted by address sanitizers and Sashiko code reviews.
> >
> > The original combined RFC patch:
> > https://lore.kernel.org/lkml/20260126071822.447368-1-irogers@google.com=
/
> > was split up per reviewer requests.
> >
> > v14:
> >  - Incorporate Acked-by tags from Namhyung Kim.
> >  - Re-polish and expand commit descriptions to provide thorough explana=
tions
> >    of the changes and their rationale.
>
> Thanks, tentatively applying it to perf-tools-next, for v7.2.
>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks Arnaldo! There will be Sashiko reviews to come and the boundary
checking is likely to conflict with the boundary checking you are
adding in:
https://lore.kernel.org/linux-perf-users/20260510033424.255812-1-acme@kerne=
l.org/
When feedback arrives, I prefer sending additional fixes rather than
issuing a v15. I don't mind if you want to drop the boundary checks I
added, they were only included in the series to satisfy Sashiko and
because I worried we'd forget about them.

Thanks,
Ian
