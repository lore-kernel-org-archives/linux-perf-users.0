Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB723A3807
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537856; cv=pass; b=ISXyDidNgzjvL6y7L9vbK7md9Y5gtdUXDxHmEIDZIu6eDGs7m4q1dMAVLWUL4SnVWUwzjJqXdCVZbPDmD4K+4Lzz8gzdB3J15hKqSSAnC38itFIBIyPhnlmoqHaP5FIVRMKdv1jOGgPOf8vLqiyISYAbGxV3Xha98bFYdRrKbu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537856; c=relaxed/simple;
	bh=waXHvVEP8Y0m+Zkmb+90NzlfZJHyWWk6ieAY3TDLn00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIO3hfh0DIg2Cw2meqCQrSKepW223nCNzgXI9ygEstTlWqvWYs3TM0Ap95T3NDeimPKO6nu36UJXJE/UGWBYZbGmF7qicze6LHdBHTGznMbokLrrD2rcajmzNQXFbtXKNhZGm33HlkEX90JPlxz1u91VMq07v8S5ZmkLSuIJBwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=We0WIHHq; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="We0WIHHq"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf22c18ad3so185825ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 08:37:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781537854; cv=none;
        d=google.com; s=arc-20240605;
        b=YFornbOrMRWzS84e0Ee/+uF1yCv465bi2wQ1Xiq2ariFreVcF9LSfIUO/kAD9vWBry
         jPbs9XsbPI5LdGeU63p/TbVr97ZReziFy4nbpPCleDmjx9EdlZTc6Fjpgo/rFbQQBejz
         9Sobjwc0upD4qfF55pd52GzmlxJTfuX4V0hxymmi8H/WiWUg76TlM/+jgkpQhhFmzWxh
         HT9bSRpbsZMn3itX4xlPp3W1s4Ewht/3xeEn+iVF43ehysuDLCg3M09zZe3/FZNM0LrD
         NU6GDW146DTjckK8km5OtPChZ8DSAxokz3sIjsuaHY1cckvh0Pa6+92QKSjhnOmRm5Iq
         hZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BwMpR2s0Waqr3fJu94xq4fdF3hUjcT7amK+18nHRrzc=;
        fh=4tsupPWWAtAT+E9Yqhlxm2DXxVabB4ajIAkMfD2SmGw=;
        b=GlNXGUCGaUCA7VK53ISRRvnWCnw8OgDhTQsBWUerTdacF4T0TVNmopHsOAc9PQ+wjT
         rNhz7BBA4rRtyYU/rKs4Cc4MoiZ5rEyIhKdzDhLo0J6k6VQmbooh2WMxmHCWOhI0eX0i
         51vgAvnWgxdwDi5/Q82P9MVuArtwvtfusl8EDGKwaIOBMU3qT/5OOx8/lrYOGK5Zxq95
         tvUYAKIDxfGBbl2+rMft5WR8ZKv78TLhzAM2daP/jZ0BaGV5+LwTOUCXVLOtUfm2w4zb
         GkUP8+IlBpFP1pw8Mp1pp28WLNaG08QWMBO/wKUo75zqDooqA+rNvMRN2Ah4PSmPazuO
         7t7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781537854; x=1782142654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwMpR2s0Waqr3fJu94xq4fdF3hUjcT7amK+18nHRrzc=;
        b=We0WIHHq5za2dUx1q9YxH+STEoTXCB1saGIhIZDSxvgXc+wZN8wboophW+Xcq/vRFm
         sIjyvrDW9ecK223p+Pb5hx2staGrIOgcnh7G42pCacjnx6QYDghfqnxga8ZpGI3z2hR9
         Lla0fSZ5gdqG5txu9WhXzMWv0l3VJ+tnK+YJLBxuyDXh7XpjbiZc/Yjo6bkyGjvML1Cu
         KguZRYO++obiPqR9nR0RVEaRgA/AZyPjzMHchxZis8vvO3SmGkYdxEvLLun9zEtxwxPj
         u0CMsy4//EX8yfp2GkLHCeTyKlhm9W+gjeNGMbeAFOuU1KO6ksQX4pB/Ph6/DFRtOh72
         36Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781537854; x=1782142654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BwMpR2s0Waqr3fJu94xq4fdF3hUjcT7amK+18nHRrzc=;
        b=J+CK9+d/AIDmtPeotq6nYuWDLhw/VtCgYrdXxsLCU3r4MeB/25N4w3ybiybztWVxOO
         knqTAIi4fWB+IyBFzRUtxSA7NyijK26KPm8W1XfV0EWYrI3BNSidmEwQs6m6eZjNoLX/
         7Adq0FcvthAM3x4UvAa4BIVxccHlTCyA1JBiEK7HG86flYPS4liMpb5C1Ocu5nsz9J4e
         uZk3evPcyERFne5P84UiIHv0McZ/xrojKyLoXvqdR7wOI6WZ+K1VYC/08pKPHr/Cb0Ne
         eGdg75fpdTsE7HgTKezaexNFB9veIAj+/vxvUeG83VOGnFVRc4mb0Lu5TRtp6L4V58RK
         9t7A==
X-Forwarded-Encrypted: i=1; AFNElJ/qf6cxWTCEpJrvmgnjuoB9I4r2ne6wZMZDnw8nMcjVNgrN+RMYAHRyYUob6KVJfTBIpbkxZBwYP3dDI+TTcBcP@vger.kernel.org
X-Gm-Message-State: AOJu0YzEqlYWHb0qE804xXb5p7LFCmdwLuDSMepdpG9M7gah7OUcsZ83
	/LDmT+yzc+1Cp+mvt6yLcZW5TflS/bnaE3/5D4GbPARi0USaFLTm9dU99WzQCTbW8GHxLrXsi12
	sElHr0Dg50ujWLBi9pVMpRl1XQQOiLkm/9NgHVk6v
X-Gm-Gg: Acq92OFyd8offN2lIni4DeiHQZ4Bv9HSWK9qJSE2I8/K2TVXoQdLUuBUM2WMPcCyGas
	3lIg90tBPPBbHufq/pRSNY5fC4qlyIplR698Rd63dxnB3AQNDWvqs6XWj6Jvh7DzGt6jSg8O69x
	Zqxk4yrOWsU0YE185hkm11+WNeFhzTAHMTiKDRMYL+wtVswuVG3HO1TCXMAYqKOeZmQK98b7bi7
	IkAC/AeGWSWwXva3B9ijGsG4ltmwZGaVom7TSBND5wlhN4XxAFo0l3s8uW3KFaWY3JrxTqk8kW2
	WMFnNS53YNoQHZRczmNjs2QvKP7evhci+1y3mg==
X-Received: by 2002:a17:903:19cc:b0:2c1:4a67:5f31 with SMTP id
 d9443c01a7336-2c6968305bcmr600355ad.9.1781537853083; Mon, 15 Jun 2026
 08:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609215046.2391903-1-ctshao@google.com> <0b6d58d5-f802-47dc-ae71-31c45184b738@linux.intel.com>
In-Reply-To: <0b6d58d5-f802-47dc-ae71-31c45184b738@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jun 2026 08:37:21 -0700
X-Gm-Features: AVVi8Cc7N-HxLTVS7DlAr9qvARu6rk_YKZRh7Ttf3nd4FIB4jf6MO19ixXcfaOI
Message-ID: <CAP-5=fU1EsSAo-f9zEVX3gWAVhpjbaCjqgA2M_xWo+qLZ_6AZA@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] perf vendor events intel: update
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	afaerber@suse.de, mani@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2026 at 6:32=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
> LGTM. Thanks.
>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

The tigerlake update is just the version number. On the perfmon git
the change was removing zero fields:
https://github.com/intel/perfmon/commit/8353ffb63efcad6b6fac1a8c05d76e2d631=
7ae23
but zero fields are dropped from the perf JSON, resulting in no differences=
.

Thanks,
Ian

> On 6/10/2026 5:50 AM, Chun-Tse Shao wrote:
> > Sync with the latest perfmon events from:
> > https://github.com/intel/perfmon
> > by running the script:
> > https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> > and copying the resulting json and mapfile.csv changes into the perf
> > tree.
> >
> > Chun-Tse Shao (6):
> >   perf vendor events intel: Update arrowlake events from 1.17 to 1.19
> >   perf vendor events intel: Update emeraldrapids events from 1.23 to
> >     1.24
> >   perf vendor events intel: Update graniterapids events from 1.18 to
> >     1.19
> >   perf vendor events intel: Update lunarlake events from 1.22 to 1.25
> >   perf vendor events intel: Update pantherlake events from 1.05 to 1.06
> >   perf vendor events intel: Update tigerlake events from 1.18 to 1.19
> >
> >  .../pmu-events/arch/x86/arrowlake/cache.json  |  30 ++-
> >  .../arch/x86/arrowlake/floating-point.json    |  45 ++++
> >  .../pmu-events/arch/x86/arrowlake/memory.json |  18 ++
> >  .../arch/x86/arrowlake/pipeline.json          | 129 +++++++++-
> >  .../arch/x86/emeraldrapids/cache.json         |   9 +
> >  .../graniterapids/uncore-interconnect.json    |  10 +
> >  .../arch/x86/graniterapids/uncore-memory.json |   2 +-
> >  .../pmu-events/arch/x86/lunarlake/cache.json  |   2 +-
> >  .../arch/x86/lunarlake/pipeline.json          |  27 ++-
> >  .../arch/x86/lunarlake/uncore-memory.json     | 208 ++++++++++++++++-
> >  tools/perf/pmu-events/arch/x86/mapfile.csv    |  12 +-
> >  .../arch/x86/pantherlake/counter.json         |   5 +
> >  .../arch/x86/pantherlake/pipeline.json        |  29 ++-
> >  .../x86/pantherlake/uncore-interconnect.json  |  10 +
> >  .../arch/x86/pantherlake/uncore-memory.json   | 221 +++++++++++++++++-
> >  15 files changed, 728 insertions(+), 29 deletions(-)
> >  create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/uncore-i=
nterconnect.json
> >
