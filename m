Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528735;
	b=P3xwAt4UyujagX9hKhxN/dqdt+myS4BTkCnoWtDUzic94HAALPxNwZu4fBEJEyBxWR+o
	 SexMwi39NVO/kEN41WlWtRouLS8HGBJPG/j6DluCCi2RiAwsguP2ImztZxAc/wiuGyRVu
	 vLHfdbhq1pq73JgHJbjhBn79JGyCmscPbuc1si5xkzhKoQgJsQPK1B3fDJZVcsZUcznRG
	 VJBIlwY6pTWyhzGGgyMkl1sJBhAw81z797L7yF3+9qGXjPltzQ+S4y+EgD7vD9+Ovzf+6
	 Hmr6h1TOYhkKpB2MrbhNXipgp5NP18WTx7GBnsTGtFaVWrumfnzyJG5DsCDNsEZfx1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528735;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:CC:Subject:User-Agent:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Jj9W1Fne0Eiht74C80diOWke64Mz4zGkFNYLVP0fVM4=;
	b=lG7ku5Iq8Oh3zGoL9oWK5V6d+NwR3R6e3JDY6CS3jGvQlSRUyktn9fPhUAhNmiitQxkT
	 BunHyrAYiHMW98FFBJUzh8KZAGm9cQfWuVBdttG84AQTnlGc9svvquo3rmbqAXrEzqWNq
	 6FLBRY2bSbmNwWM52wpxA2aP6BBBgD+NsQmc/Q2DERV1HWh2bGsDvc444uqRNqDd49wa6
	 kG1YW/Mg6Ot0KiDGHEmxPwM18oH+cC3Y7oAfA5trSIfBM+tBvS8RBQ5MJoo2dzvwUId3M
	 57KuychShleFjNQE3uxAZC01SgOWsD3fCch3MFqokOmAr6iqF/JWyPI++FbFdAVMJmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jTBO8R2R;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F279D606A31A
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 20:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F279D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jTBO8R2R
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-99071945aa7so33440241.3
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792528734; x=1793133534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Jj9W1Fne0Eiht74C80diOWke64Mz4zGkFNYLVP0fVM4=;
        b=jTBO8R2RDGFldB5sTmqyvIMD7lIP4ciDhUAXegojI3fPn4+naP/jvyuk1AUOiUxOpc
         U6RsmckMC+p1qW1pSrLeSvNhQb5tUomZopc2/16tD5QSu0rlwuTS/gGEA0KPb59hywPA
         EizmoNKwQ1tDYD6zwtYymLyeijMj+EOkGmiGR/UFeX0a9k3HAK9wOJXNzoMlBrZUUQ6V
         TqePOZxYKOoLdz7OO5bkhibxzmXsNzBSX6j8tGg/HEl2BZv+UHGS51KNmrzRK8jEugEP
         xS1omLgaia3/NIswYLQBJelu6dBbW2j/4sQKZec8HlZgcVqvqLiK4Ry60X3YDFzSxwsx
         nTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792528734; x=1793133534;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jj9W1Fne0Eiht74C80diOWke64Mz4zGkFNYLVP0fVM4=;
        b=c+ZkrSGeS6rhwIQvBxdeN9rLORKWywtIiPKTvH2LBVwUmnjFDzlnVrjP3vlsT55Xz2
         V4rAUJk84FPsk6Oqb/OsYA6+aLJJT9auDRVxtNJxwkYtw58nn73Jkuoa+Eujb3rb91h2
         TUYhVzWC38r11yH9qOHbCbyqefuVz4B+0plFa28VyijsVe+RYD7AMxxN5SLy1Un2AcmI
         W8E69TytTOTY8mpu7zYUQqmNBdWmRS+9rcocueA4VcsJkuJJOO38ZEI4e44j+Ihyd4Xx
         8nclQ9cXkXezWq8liCWtQjaw7nJLfY7ZpQy5p4TmoBGCcS/hn1FVQvUWf9JOSEU7Y2E9
         H3GQ==
X-Forwarded-Encrypted: i=1; AKwUvBwZeeXdmslpQ+exnJv+OCJs1kGlFBN2dTxvNTZ6paOi2iCYBDxtH8+HgjgR9SOJ1VtprxTe3b66hTldxpFDNJPU@vger.kernel.org
X-Gm-Message-State: AFq9FYIZ+2ocji324aYSkewbPYFlQSSmvxpDwQK2P+WQUPTB4QNV/BZg
	MgtLG1JKFgCzzLxMIXRD0gIl5UIQru9RX3CQ1KmXxrHEpHVKCbEqrGbt
X-Gm-Gg: AYBFou1HhMEL+3d9vvYSMz5HoY3KB/XDMTVAh8fxDyfz5n4zxUphexLyy5CRB5Lk/vI
	/U5Xhk52lGWaRbhIskjQCMY8tNObMEyGxZmSd1kJTX9FwDzZTbvZ/jTdkOe66yPjuTgnju8QReS
	SWR+JRDesWFP4CG1EeLV2s1CVgRbAoKUlEjBHMCMFqu7wylI1gh4WHI6CUgXiq0SrkLEBjXMp2l
	tigImjsmBE8vrxKpK6jruxqioBUlt0BKRVKBlZOqfXFcjCbREGNPa+BMyfGxxqbZEqeGl6xzvC9
	3eA3Tz9ikwJy7V5ikEp5afD3zCIu9o0FkUqZL3EOtw/TiMoUg0a/AH9ThtEtiDv9JjrE+bKF2UV
	20lPwZkaphgc7cRzNLCvyl/64Ir8mSijc/sDzYKtg27FX4y2MCpYK6hG+3BMII6EjCSeiMom+Gw
	KOiPag2Wrf3+CeofgchGbBS1T6lf8f/TauuTJP7gr88ajgPuuq9kS7q+bB4EjA+tI8ipDYwVbOU
	toAR8LruNXxQ7Q7h2Mk02Yg/g==
X-Received: by 2002:a05:6102:2b85:b0:7c0:c6e3:3b88 with SMTP id ada2fe7eead31-7cc926fba03mr132043137.28.1792528733875;
        Tue, 20 Oct 2026 13:38:53 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2804:2bf0:60e7:ae00:617a:6625:1f37:5d9f])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc92428d7asm405406137.10.2026.10.20.13.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 13:38:53 -0700 (PDT)
Date: Tue, 20 Oct 2026 17:38:48 -0300
From: Arnaldo Melo <arnaldo.melo@gmail.com>
To: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
CC: James Clark <james.clark@linaro.org>, Besar Wicaksono <bwicaksono@nvidia.com>,
 namhyung@kernel.org, linux-tegra@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, vsethi@nvidia.com, rwiley@nvidia.com,
 skelley@nvidia.com, mochs@nvidia.com, rajjoshi@nvidia.com,
 treding@nvidia.com, jonathanh@nvidia.com, john.garry@linux.dev,
 will@kernel.org, mike.leach@arm.com, leo.yan@linux.dev, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, ctshao@google.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/6=5D_perf_jevents=3A_Add_NVIDI?=
 =?US-ASCII?Q?A_Tegra410_uncore_PMU_events_and_metrics?=
User-Agent: Thunderbird for Android
In-Reply-To: <CAP-5=fXUMVJwtAp+8dA8V=hBD9q4x6J4YiUufwXAOXcAJoAKTg@mail.gmail.com>
References: <20261019164241.403644-1-bwicaksono@nvidia.com> <21f58af0-fa3f-41c5-ab03-216c60fbe2f1@linaro.org> <ate93zQFkfAecIv2@x2> <CAP-5=fXUMVJwtAp+8dA8V=hBD9q4x6J4YiUufwXAOXcAJoAKTg@mail.gmail.com>
Message-ID: <F2F3FF02-67B6-4EBF-BD4B-364C7CD28535@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On October 20, 2026 5:32:48 PM GMT-03:00, Ian Rogers <irogers@google=2Ecom=
> wrote:
>On Tue, Oct 20, 2026 at 12:15=E2=80=AFPM Arnaldo Carvalho de Melo
><acme@kernel=2Eorg> wrote:
>>
>> On Mon, Oct 19, 2026 at 06:23:16PM +0100, James Clark wrote:
>> > On 19/10/2026 17:42, Besar Wicaksono wrote:
>> > > Add event aliases and derived metrics for the NVIDIA Tegra410 uncor=
e
>> > > PMUs=2E
>>
>> > Reviewed-by: James Clark <james=2Eclark@linaro=2Eorg>
>>
>> Thanks, applied to perf-tools-next, for v7=2E4=2E
>
>Hi Arnaldo,
>
>can we not take these in v7=2E4 as there is unaddressed feedback:
>https://lore=2Ekernel=2Eorg/linux-perf-users/CAP-5=3DfWucvdYefDOL3Vn=3DO=
=3DYUPEXE+tngDDfPLv-T5i3WkCJVA@mail=2Egmail=2Ecom

Sure, will remove until the discussion comes to a conclusion=2E=20

- Arnaldo=20

>
>The specific problem is that the NVidia PMUs have adopted a convention
>not supported by the perf tool of 'pmu_name_<socket>_rc_<num>'=2E rc
>stands for root complex=2E What ends up happening is that aggregation is
>broken as the json is claiming that pmu_name is the PMU's name while
>the suffix perf_pmus code thinks pmu_name_<socket>_rc is the pmu name=2E
>They've wrangled support via the json by claiming these are sys
>events=2E
>
>We can either:
>1) support a new suffix convention of <num>_rc_<num>
>2) push back and ask the driver writers to name their PMU correctly as
>defined in the ABI:
>https://web=2Egit=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=
=2Egit/tree/Documentation/ABI/testing/sysfs-bus-event_source-devices
>
>If we do (1) then it would be nice if the support for that could be
>contained in this patch series=2E In any case these events don't belong
>in sys=2E
>
>Thanks,
>Ian
>
>> - Arnaldo

- Arnaldo 
