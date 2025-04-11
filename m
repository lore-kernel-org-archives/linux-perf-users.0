Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141EE231A2A
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Apr 2025 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744392911; cv=none; b=c8lw6Zijq9esYX80VDC+jN4A3nfzIMORfvUrYfzDx1gJS/ruxRKexOJBLS0AvUzlKhJo1hPVxeF3ovGvkebGYxrMdwbbp6DOE5slKZFpfDf/iYW4ipo4ecY6Uo4bRPNC5Nh1ApJVW1apMnwbABMb4NhSNoGzHnQnqy2heTvISlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744392911; c=relaxed/simple;
	bh=+eht9iaQ6o1fN2gEoUHVMqICYWehtz7ZUwi+FbnEXgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GL5RbJ5ontaCld7ez51CqkI8eY7ZcLGIu1gEvMuxvhavSSJHQai38+cwank578WdA8l73qXPEb2RSoGxGJsV9LtRntEPAx+89uoBmTcJjCCOs4sU/MqERHXR8CB8t7er1VhPFwpaYW0lCkC2lYL1XNdKxZUECMTZrIEvvEq3kP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MjLSlTVZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MjLSlTVZ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240aad70f2so17575ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Apr 2025 10:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744392909; x=1744997709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eht9iaQ6o1fN2gEoUHVMqICYWehtz7ZUwi+FbnEXgE=;
        b=MjLSlTVZjYfLqKTf33/JtYchF8CUgF0UwEGkkv0JgwG/ap3v/DCXMCABtsxenEZRcX
         yNs20K5X1/pMnI/dMIhE9ZHz0gw3+8r2044zJmWF/rA+c3XSDNGiegIR8Z3MsV/CjET8
         F8io6HWMeqq52Z4T3HrXJP2NwZxKTIQjs6eVipzOgkHCZWcTbqZyEOLP8SAsGTtJBcV2
         OIV+aA6abwPo4+FUk8BWP5DA6nBZ/dnspeuKAVQf7P7mAMoSHE0+ae/OFJ7dgwdEnIwR
         GsIpzp1uMHozhtiWq3mKAJQ8DLasDh4Qe6rhw5SCABehigHy465d4r2tUwg8LJkDWHyZ
         vRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744392909; x=1744997709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eht9iaQ6o1fN2gEoUHVMqICYWehtz7ZUwi+FbnEXgE=;
        b=CRRAsSScELhtk1V4pLL8mkGMHeT/EBBIlwAbeOfJ5FqKji7rvctFzZ8Ra8ukF+tOz5
         K4vDGIMtdF2cdFy61kbjbO5GOEq9JLslTNka/pgXtWZ3eGwqmlh/nP1OpiAGqlQ0Zw35
         pZnNreYXoPiafp44mFWYOtBp84PN99QtGQ/hM8Mb8lvA/Loyd1fPpy+I7laUzuqjYi8X
         o33fnqLmhpMvlkEvUv2e52N6A8Io4D4l+QYVTh5evZTrTwqx+qpNqRK6uT8FwYUTrqHJ
         1m1P0pSKYgq1DPCL8LcyPLT1iLDj82vhbTFNYTqSW/c5gRXLdjYkw5buFQJLGPyW4KsF
         j2fw==
X-Forwarded-Encrypted: i=1; AJvYcCUb5AyzrgCWKPP8TW6cz1WJcWFSSlJGuxkmldCIYCTgOndjq2K+ZKFNzE9NwVFZeuzZQqBplcDO+hWbxFlOdpWE@vger.kernel.org
X-Gm-Message-State: AOJu0YxR5WWzL6Bu3XIH7qmxrtUUht4eCnxyXABgnO4eUhANycanGj7S
	xXNaABlsVsp4uCofLOluO+n5rUnGI+O4w0SSVauxCDMzhiZjsJ6hpTvgemkm1ZFkStztTwI4eSA
	8ymUpgSHtCZbcnJAYmEphBqh2lqeAPC0YzBDE
X-Gm-Gg: ASbGnctiBKrBOwHviLCJFe5FYhYi9ZIUkvsjZug0N+PRg/2PfTGyBB5lk2x0Lc91UDo
	xuBQ0vmrpyS2sWZgxmgN3Kwd0Kl8eVYsDNF9cpAnfNHnupJFb3yGzT/vIARnJsIe1hwnXd/aa4R
	c0kDMxc+Fqu5IcUYz6SX7gG6I=
X-Google-Smtp-Source: AGHT+IFsqGb2NI4C998L4eRk5pxG9ZDV+EPyXU0sBnQYjqjaZsqLTIZPs5b8kewYg6GP32+Vd/vVcfo+p6pguFqbuOY=
X-Received: by 2002:a17:902:c40e:b0:216:21cb:2e06 with SMTP id
 d9443c01a7336-22bea920b31mr3043845ad.19.1744392908956; Fri, 11 Apr 2025
 10:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408171530.140858-1-mark.barnett@arm.com> <Z_ZcRiHTGljxEEdN@gmail.com>
 <2fa741d8-13c7-49c0-a6c5-540a7c2cf3a7@arm.com>
In-Reply-To: <2fa741d8-13c7-49c0-a6c5-540a7c2cf3a7@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 11 Apr 2025 10:34:56 -0700
X-Gm-Features: ATxdqUEZa_1pWKSod4wY40ZarBa-DN6S4qpDe5Ur1LE7Pb1ofS8DC8N_Fn09SwQ
Message-ID: <CAP-5=fUukVQMRHUQ9Mpx38H-7VNLt4mDj-jaYgn8Tf4zjecD-A@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] A mechanism for efficient support for per-function metrics
To: Mark Barnett <mark.barnett@arm.com>
Cc: Ingo Molnar <mingo@kernel.org>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, ben.gainey@arm.com, 
	deepak.surti@arm.com, ak@linux.intel.com, will@kernel.org, 
	james.clark@arm.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 4:08=E2=80=AFAM Mark Barnett <mark.barnett@arm.com>=
 wrote:
> Tool Integration
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> We've been using a python script to process the data into a report. We
> can look at implementing this directly in perf report, if that is
> required. However, I'm nervous about making the new feature the default
> behaviour for the tool.
>
> This feature has been integrated into our tools [1] for the last 12
> months, and has received a lot of testing on Arm Neoverse hardware.
> Other platforms have received less rigorous testing. In my opinion, more
> work would be needed to validate the PMU hardware & software
> characteristics of other architectures before this can be made the defaul=
t.

Hi Mark,

Wrt testing, in v6.14 we've fixed up the python scripting with perf a
bit more and there is an example that parses an event and then dumps
samples here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/python/tracepoint.py?h=3Dperf-tools-next
There is also the perf script integration for things like flame graphs:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/scripts/python/flamegraph.py?h=3Dperf-tools-next#n96

I don't think work should be gated on cleaning up perf report, top,
etc. which still needs clean up for things like hybrid events. As the
histograms should use the sample's period then I believe things should
just work in much the same way as leader sampling can work. It'd be
worth checking.

Thanks,
Ian
