Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EBA2E6CCD
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777659450; cv=pass; b=d0rFbUSsY6UnG4WIWzFEtFJIFsOY/qpyAH6m9rN2P7y0FfCIyZtGglzizsH9pjWytWp4s0DNJlI9idxRbz4NZBjvyDzDgkgR2szCw1e+jQfUDOHMrySGv2xEvQy77YUUnvJQyfrvamOpl+i/6VFywIIJst00xxQULWN7VLvIUko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777659450; c=relaxed/simple;
	bh=C+PBV21bLAplVEioAWIjwlXp1Y0dL/zvcpNJ4/ZsggM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aLW++G4NlY7r+W0HXY5C+hN5VpETfbUNBIXT9EFUyi68OBRXtsSQ1qzESKnW0q9PdMa9qWL9ySIxfYpYSRiG8e20uEmAp9db2vo6JgEAv6cTLqpbYmXlxtF0b09g6owqzqjlfM7KdmAOXq17GOncfvP+ti1A/gibRgsqk/6E1KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HupK1jf5; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HupK1jf5"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12db2e415a7so1425217c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 May 2026 11:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777659448; cv=none;
        d=google.com; s=arc-20240605;
        b=d518x1EuX8BbBfTjPgY9knx9NmREkKWBjU9p0RtpZgVG3vrJrY/TD0hWrwFyLyoRib
         Q1TXm/Go9EUvoPCLOVQAl3x/h3cilM+17GhBjrZvNj7yDG7WmrAOXksYpTrlPni/BKYY
         fuzxQcjMmEJnowf4h2fPGwEfdUPdQTlBRlQ/60/PCt2XZ4zZu//jmMnxh5K53aEXv3mQ
         ueEQfNVfBRGiAnsn7a+ZvBijCK9pKeFlnjXuAbpbx3S0nwXMQRWdpegpkEsowGa/KPA0
         0wIejmKYiVIWeaR/ZKOWBhh+LC2iADV92+XQYwpx3/nvNJTDtaTmY8NBKQNeg6koeh67
         bYZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KlH0OH/EGOi2Y6/dCX5pDyw5JayBQgRJ4/eWfphup8A=;
        fh=1tujcoydZ3VS411XWVAH9MsLVxawPZ9dg6UiEZG0AG0=;
        b=FA6rr19yTeBYECuskoEZDZKz0Cm4hvsPMNH6/U59mVsaAWAj9T9txb9HJDnln2vjZD
         e7TBbQarI6fQXDA1D5eBcmrpLpLYDqGJak4F8sBIb3UmZ2cvfxm2v8LMru4DEmwVxC7v
         Excml0TJ9NTcqk4Kp7Qs5C6QvMhiuY80wcB6K39Jjjf4o0Q6CBw9hJtQXlKBD0YCItPn
         53DcpEXGqcd63lDbI77gIOjqC6akcgys8gXz9ktbS7QVTjrLj0W431HbBbYhLpKYVIkw
         lz33XiaxK/GfgW2NmAJd12QOy1iCArnejmheDk8deWDLxTFxnBLW9/yi9PKI96Rxw/vw
         lX0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777659448; x=1778264248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlH0OH/EGOi2Y6/dCX5pDyw5JayBQgRJ4/eWfphup8A=;
        b=HupK1jf53VlPhTk7YxeUg+0XT7Y4Lw1izhzRoaP+cNBMAo4fpZSeND5OXP9COCKlsX
         NQctlkQI/LFPpqcJGeWsRUciw7kDZQbffpyGbcc907HbNUxuffocBUIkuI8crOxsM671
         rsxqvOXUfrcCxhU2P/OGtcH0SW6GWwmVz19HzJlgGOb3baQyHFPlmiyBRON5uDUtvzlW
         RT7/y6DxNJrl9GnTVPWz1Yl4DzMpEbu3tD/9ncFNfdh38X9Qj9MoGSi+U2uaASQ1k47X
         WWqWwQXI0jZJ5s6g2ImPCsSJ3dEh4t9lpMgFszrE+S8Tzmm9HnGg5zk2AeFOAVGAD48Y
         k0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777659448; x=1778264248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KlH0OH/EGOi2Y6/dCX5pDyw5JayBQgRJ4/eWfphup8A=;
        b=kSR2pyXXUZizkGf3FpOwu4jYilM0dQEUo742l8nTiZ568L+/udWJq5pezt8cZmOXyR
         uQrrkqKa864mAoNweIAuQyalQcVLTCnLt9REk8xn1YrXu6qf1Yv3f3TB1T0RPQxPGY1S
         bRymG8/+Iy+Q6roYYtAImmBZsqgfew6XIM5muvpwK22kpfs5ys/XMg3e5/Wwnabeq3mT
         5U0N4m1RF45M1jGSb6wYluuubgmNK7Z4yHtMXOWo203UeC7qBkp2S1UByeZ0W9hKwKKU
         wTD36o6RMGw68N3dEJ8FNYBPHGDQfE8Jor4151ak/VPghNg35xlGB5OQQEnLg+ERl1BM
         /nyA==
X-Forwarded-Encrypted: i=1; AFNElJ+mZ8E0ZSFGHlcU0uOnxWPJXTLfyVYKpAUdzDGrWBlO42VN/xMfkYfKPseQWtvuzCVfLZpXTe81dFUhQHaJhasG@vger.kernel.org
X-Gm-Message-State: AOJu0YxoJN5QVAi+Rkmt6HJMeCl4zPitYcE462APTng2pzonbvKWN72Q
	74B2BoB3YXWbXS6RA4gNOoRWfNrJFY/TR8c26JsbSNzDrIcE3YH0auEPzOhWrgENRQBxW09IWPv
	gwiW9+mj1YoJtymxNiyMeCdLjNYXaY3lZmYQIDuapcPDvGr5jCsrDEBP5nWo=
X-Gm-Gg: AeBDiev+UsgFBfrXeavn5NV/NyapQV2KA8+KXoocMMr/9kbyLb3AccE11EgT4U+TteP
	naFQS7E+e3JAcVWnQFO/Nz53qns6F6PFYaFJvoob1XLAGZBw90T2gIaoezDrFIXFPcEnDAzfXw/
	U/dbLPqmFoJa1oY13AeOCLgoXcATP30J9g4lBH2tb1X4l8n6vWSorX08l3B85BCmP35WPzqiDuC
	K0ZG8VT2A7YAnSYBKMiqJFK+sOGycDnE04HpOPYtVMBFUU055i9Yze+VhQL1F4E+1i1J7CS/gM5
	26ewiFb9mSPxT+RsHqhnsK+iBQQ=
X-Received: by 2002:a05:7022:1603:b0:12d:de3f:f3e7 with SMTP id
 a92af1059eb24-12dfd88044dmr136292c88.39.1777659447801; Fri, 01 May 2026
 11:17:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416204828.1303734-1-ctshao@google.com> <CAP-5=fUa9btU_FqtTUH02+CRmVgkudbQ+SA-J=pmNhf0zgq8Rw@mail.gmail.com>
In-Reply-To: <CAP-5=fUa9btU_FqtTUH02+CRmVgkudbQ+SA-J=pmNhf0zgq8Rw@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 1 May 2026 11:17:16 -0700
X-Gm-Features: AVHnY4JgEWEcPwBi7DwU6aHaZnoBm0R0TN7YQRB8wlbL7Tsru72VPjV3RoPYg2g
Message-ID: <CAJpZYjUXkfCNwKdXR_z3PTz8UFwG2DJK+1Bq0X93sMtcU+tZEQ@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Merge CPU maps when merging uncore aliases
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, thomas.falcon@intel.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Instead, I submitted another fix to tweak `Merge CPU maps when merging
uncore aliases`. Please take a look
lore.kernel.org/20260501181129.938256-1-ctshao@google.com

Thanks,
CT


On Thu, Apr 16, 2026 at 2:05=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Thu, Apr 16, 2026 at 1:48=E2=80=AFPM Chun-Tse Shao <ctshao@google.com>=
 wrote:
> >
> > Sockets with event zero counts are hidden in `perf stat --per-socket`
> > because alias merging aggregates counts but not CPU maps. This causes
> > the display logic to incorrectly skip sockets not present in the leader
> > instance's map.
> >
> > For example, with AMD_UMC:
> >   $ cat /sys/bus/event_source/devices/amd_umc*/cpumask
> >   0
> >   ...
> >   128
> >   ...
> >
> >   $ perf stat -e amd_umc/config=3D0xff/ --per-socket -a -- sleep 1
> >
> >    Performance counter stats for 'system wide':
> >
> >   S0       12                  0      amd_umc/config=3D0xff/
> >
> >          1.000777829 seconds time elapsed
> >
> > Merge CPU maps in `evsel__merge_aggr_counters` to ensure the aggregated
> > event correctly reflects all underlying PMU instances.
> >
> > After fix:
> >   $ perf stat -e amd_umc/config=3D0xff/ --per-socket -a -- sleep 1
> >
> >    Performance counter stats for 'system wide':
> >
> >   S0       12                  0      amd_umc/config=3D0xff/
> >   S1       12                  0      amd_umc/config=3D0xff/
> >
> >          1.000666681 seconds time elapsed
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  tools/perf/util/stat.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index 14d169e22e8f..d696d217f98d 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -535,6 +535,12 @@ static int evsel__merge_aggr_counters(struct evsel=
 *evsel, struct evsel *alias)
> >                 aggr_counts_a->run +=3D aggr_counts_b->run;
> >         }
> >
> > +       /*
> > +        * Merge the CPU maps so that the display logic (e.g. should_sk=
ip_zero_counter)
> > +        * knows this merged event covers all CPUs from both aliases.
> > +        */
> > +       perf_cpu_map__merge(&evsel->core.cpus, alias->core.cpus);
> > +
>
> Once we have counts, mutating the cpumaps seems wrong; it could impact
> other things such as the evlist copies of unioned together cpumaps.
> I'm confused by the bug, we should have two aggregate ids one for each
> socket. In should_skip_zero_counter it should only skip the zero count
> if the counter is not applicable for the counter currently trying to
> be printed. Does the display code fail to iterate through all the
> counters?
>
> Thanks,
> Ian
>
> >         return 0;
> >  }
> >
> > --
> > 2.54.0.rc1.555.g9c883467ad-goog
> >
